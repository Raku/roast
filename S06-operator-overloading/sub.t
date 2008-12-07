use v6;

use Test;

plan 35;

=begin pod

Testing operator overloading subroutines

L<S06/"Operator overloading">

=end pod

# This set of tests is very basic for now.

{
    sub prefix:<X> ($thing) { return "ROUGHLY$thing"; };

    is(X "fish", "ROUGHLYfish",
       'prefix operator overloading for new operator');
}

{
    sub prefix:<±> ($thing) { return "AROUND$thing"; };
    is ± "fish", "AROUNDfish", 'prefix operator overloading for new operator (unicode)';
    sub prefix:<(+-)> ($thing) { return "ABOUT$thing"; };
    is eval(q[ (+-) "fish" ]), "ABOUTfish", 'prefix operator overloading for new operator (nasty)', :todo<bug>;
}

{
    my sub prefix:<->($thing) { return "CROSS$thing"; };
    is(-"fish", "CROSSfish",
	 'prefix operator overloading for existing operator (but only lexically so we don\'t mess up runtime internals (needed at least for PIL2JS, probably for PIL-Run, too)');
}

{
    sub infix:<×> ($a, $b) { $a * $b }
    is(5 × 3, 15, "infix Unicode operator");
}

{
    sub infix:<C> ($text, $owner) { return "$text copyright $owner"; };
    is "romeo & juliet" C "Shakespeare", "romeo & juliet copyright Shakespeare",
	'infix operator overloading for new operator';
}

{
    sub infix:<©> ($text, $owner) { return "$text Copyright $owner"; };
    is "romeo & juliet" © "Shakespeare", "romeo & juliet Copyright Shakespeare",
	'infix operator overloading for new operator (unicode)';
}

{
    sub infix:<(C)> ($text, $owner) { return "$text CopyRight $owner"; };
    is eval(q[ "romeo & juliet" (C) "Shakespeare" ]), "romeo & juliet CopyRight Shakespeare",
	'infix operator overloading for new operator (nasty)', :todo<bug>;
}

{
    sub infix:«_<_»($one, $two) { return 42 }
    is 3 _<_ 5, 42, "frenchquoted infix sub";
}

{
    sub postfix:<W> ($wobble) { return "ANDANDAND$wobble"; };

    is("boop"W, "ANDANDANDboop", 
       'postfix operator overloading for new operator');
}

{
    sub postfix:<&&&&&> ($wobble) { return "ANDANDANDANDAND$wobble"; };
    is("boop"&&&&&, "ANDANDANDANDANDboop",
       "postfix operator overloading for new operator (weird)");
}

{
    my $var = 0;
    ok(eval('macro circumfix:{"<!--","-->"} ($text) is parsed / .*? / { "" }; <!-- $var = 1; -->; $var == 0;'), 'circumfix macro {"",""}', :todo<feature>);
    ok(eval('macro circumfix:«<!-- -->» ($text) is parsed / .*? / { "" }; <!-- $var = 1; -->; $var == 0;'), 'circumfix macro «»', :todo<feature>);
}

# demonstrate sum prefix

{
    my sub prefix:<Σ> (@x) { [+] @x }
    is(Σ [1..10], 55, "sum prefix operator");
}

# check that the correct overloaded method is called
{
    multi postfix:<!> ($x) { [*] 1..$x }
    multi postfix:<!> (Str $x) { return($x.uc ~ "!!!") }

    is(10!, 3628800, "factorial postfix operator");
    is("boobies"!, "BOOBIES!!!", "correct overloaded method called");
}

# Overloading by setting the appropriate code variable
{
  my &infix:<plus>;
  BEGIN {
    &infix:<plus> := { $^a + $^b };
  }

  is 3 plus 5, 8, 'overloading an operator using "my &infix:<...>" worked';
}

# Overloading by setting the appropriate code variable using symbolic
# dereferentiation
{
  my &infix:<times>;
  BEGIN {
    &::("infix:<times>") := { $^a * $^b };
  }

  is 3 times 5, 15, 'operator overloading using symbolic dereferentiation';
}

# Accessing an operator using its subroutine name
{
  is &infix:<+>(2, 3), 5, "accessing a builtin operator using its subroutine name";

  my &infix:<z> := { $^a + $^b };
  is &infix:<z>(2, 3), 5, "accessing a userdefined operator using its subroutine name";

  is ~(&infix:<»+«>([1,2,3],[4,5,6])), "5 7 9", "accessing a hyperoperator using its subroutine name";
}

# Overriding infix:<;>
{
    my proto infix:<;> ($a, $b) { $a + $b }
    is (3 ; 2), 5  # XXX correct?
}

# [NOTE]
# pmichaud ruled that prefix:<;> and postfix:<;> shouldn't be defined by
# the synopses:
#   http://colabti.de/irclogger/irclogger_log/perl6?date=2006-07-29,Sat&sel=189#l299
# so we won't test them here.

# Overriding prefix:<if>
# L<S04/"Statement parsing" /"since prefix:<if> would hide statement_modifier:<if>">
{
    my proto prefix:<if> ($a) { $a*2 }
    is (if+5), 10;
}

# [NOTE]
# pmichaud ruled that infix<if> is incorrect:
#   http://colabti.de/irclogger/irclogger_log/perl6?date=2006-07-29,Sat&sel=183#l292
# so we won't test it here either.

# great.  Now, what about those silent auto-conversion operators a la:
# multi sub prefix:<+> (Str $x) returns Num { ... }
# ?

# I mean, + is all well and good for number classes.  But what about
# defining other conversions that may happen?

# here is one that co-erces a MyClass into a Str and a Num.
# L<A12/"Overloading" /Coercions to other classes can also be defined:/>
{
    class OtherClass {
      has $.x is rw;
    }

    class MyClass {
      method prefix:<~> is export { "hi" }
      method prefix:<+> is export { 42   }
      method infix:<as>($self, OtherClass $to) is export {
        my $obj = $to.new;
        $obj.x = 23;
        return $obj;
      }
    }

  my $obj;
  lives_ok { $obj = MyClass.new }, "instantiation of a prefix:<...> and infix:<as> overloading class worked";
  my $try = lives_ok { ~$obj }, "our object was stringified correctly";
  if ($try) {
   is ~$obj, "hi", "our object was stringified correctly", :todo<feature>;
  } else {
    skip 1, "Stringification failed";
  };
  is eval('($obj as OtherClass).x'), 23, "our object was coerced correctly", :todo<feature>;
}

{
	my sub infix:<Z> ($a, $b) {
		$a ** $b;
	}
	is (2 Z 1 Z 2), 4, "default Left-associative works.";
}

{
	my sub infix:<Z> is assoc('left') ($a, $b) {
		$a ** $b;
	}

	is (2 Z 1 Z 2), 4, "Left-associative works.";
}

{
	my sub infix:<Z> is assoc('right') ($a, $b) {
		$a ** $b;
	}

	is (2 Z 1 Z 2), 2, "Right-associative works.";
}

{
	my sub infix:<Z> is assoc('chain') ($a, $b) {
		$a eq $b;
	}


	is (1 Z 1 Z 1), Bool::True, "Chain-associative works.";
	is (1 Z 1 Z 2), Bool::False, "Chain-associative works.";
}

{
	sub infix:<our_non_assoc_infix> is assoc('non') ($a, $b) {
		$a ** $b;
	}
	is (2 our_non_assoc_infix 3), (2 ** 3), "Non-associative works for just tow operands.";
	is ((2 our_non_assoc_infix 2) our_non_assoc_infix 3), (2 ** 2) ** 3, "Non-associative works when used with parens.";
	eval_dies_ok '2 our_non_assoc_infix 3 our_non_assoc_infix 4', "Non-associative should not parsed when used chainly.";
}
