use v6;

use Test;

plan 64;

=begin pod

Testing operator overloading subroutines

=end pod

# L<S06/"Operator overloading">

# This set of tests is very basic for now.
# TODO: all variants of overloading syntax (see spec "So any of these")

{
    sub prefix:<X> ($thing) { return "ROUGHLY$thing"; };

    is(X "fish", "ROUGHLYfish",
       'prefix operator overloading for new operator');
}



{
    sub prefix:<±> ($thing) { return "AROUND$thing"; };
    is ± "fish", "AROUNDfish", 'prefix operator overloading for new operator (unicode, latin-1 range)';
    sub prefix:<(+-)> ($thing) { return "ABOUT$thing"; };
    #?pugs todo 'bug'
    is eval(q[ (+-) "fish" ]), "ABOUTfish", 'prefix operator overloading for new operator (nasty)';
}

{
    sub prefix:<∔> ($thing) { return "AROUND$thing"; };
    is ∔ "fish", "AROUNDfish", 'prefix operator overloading for new operator (unicode, U+2214 DOT PLUS)';
}

#?rakudo skip 'prefix:[] form not implemented'
{
    sub prefix:['Z'] ($thing) { return "ROUGHLY$thing"; };

    is(Z "fish", "ROUGHLYfish",
       'prefix operator overloading for new operator Z');
}

#?rakudo skip 'prefix:[] form not implemented'
{
    sub prefix:["∓"] ($thing) { return "AROUND$thing"; };
    is ∓ "fish", "AROUNDfish", 'prefix operator overloading for new operator (unicode, U+2213 MINUS-OR-PLUS SIGN)';
}

#?rakudo skip 'prefix:[] form not implemented'
{
    sub prefix:["\x[2213]"] ($thing) { return "AROUND$thing"; };
    is ∓ "fish", "AROUNDfish", 'prefix operator overloading for new operator (unicode, \x[2213] MINUS-OR-PLUS SIGN)';
}

#?rakudo skip 'prefix:[] form not implemented'
{
    sub prefix:["\c[MINUS-OR-PLUS SIGN]"] ($thing) { return "AROUND$thing"; };
    is ∓ "fish", "AROUNDfish", 'prefix operator overloading for new operator (unicode, \c[MINUS-OR-PLUS SIGN])';
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
    #?pugs todo 'bug'
    is eval(q[ "romeo & juliet" (C) "Shakespeare" ]), "romeo & juliet CopyRight Shakespeare",
	'infix operator overloading for new operator (nasty)';
}

{
    sub infix:«_<_ »($one, $two) { return 42 }
    is 3 _<_ 5, 42, "frenchquoted infix sub";
}

# unfreak perl6.vim:  >>

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

#?rakudo skip 'macros'
{
    my $var = 0;
    #?pugs 2 todo 'feature'
    ok(eval('macro circumfix:["<!--","-->"] ($text) is parsed / .*? / { "" }; <!-- $var = 1; -->; $var == 0;'), 'circumfix macro {"",""}');
    ok(eval('macro circumfix:«<!-- -->» ($text) is parsed / .*? / { "" }; <!-- $var = 1; -->; $var == 0;'), 'circumfix macro «»');
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
#?rakudo skip "Lexical 'infix:plus' not found"
{
  my &infix:<plus>;
  BEGIN {
    &infix:<plus> := { $^a + $^b };
  }

  is 3 plus 5, 8, 'overloading an operator using "my &infix:<...>" worked';
}

# Overloading by setting the appropriate code variable using symbolic
# dereferentiation
#?rakudo skip '&::'
{
  my &infix:<times>;
  BEGIN {
    &::["infix:<times>"] := { $^a * $^b };
  }

  is 3 times 5, 15, 'operator overloading using symbolic dereferentiation';
}

# Accessing an operator using its subroutine name
#?rakudo skip 'scalar binding'
{
  is &infix:<+>(2, 3), 5, "accessing a builtin operator using its subroutine name";

  my &infix:<z> := { $^a + $^b };
  is &infix:<z>(2, 3), 5, "accessing a userdefined operator using its subroutine name";

  is ~(&infix:<»+«>([1,2,3],[4,5,6])), "5 7 9", "accessing a hyperoperator using its subroutine name";
}

# Overriding infix:<;>
#?rakudo skip 'infix:<;>'
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
#?rakudo skip 'prefix:<if>'
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
#?rakudo skip 'prefix:<~> method'
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
    skip "Stringification failed", 1;
  };
  #?pugs todo 'feature'
  is eval('($obj as OtherClass).x'), 23, "our object was coerced correctly";
}

#?rakudo skip 'lexical operators'
{
	my sub infix:<Z> ($a, $b) {
		$a ** $b;
	}
	is (2 Z 1 Z 2), 4, "default Left-associative works.";
}

#?rakudo skip 'lexical operators'
{
	my sub infix:<Z> is assoc('left') ($a, $b) {
		$a ** $b;
	}

	is (2 Z 1 Z 2), 4, "Left-associative works.";
}

#?rakudo skip 'lexical operators'
{
	my sub infix:<Z> is assoc('right') ($a, $b) {
		$a ** $b;
	}

	is (2 Z 1 Z 2), 2, "Right-associative works.";
}

#?rakudo skip 'lexical operators'
{
	my sub infix:<Z> is assoc('chain') ($a, $b) {
		$a eq $b;
	}


	is (1 Z 1 Z 1), Bool::True, "Chain-associative works.";
	is (1 Z 1 Z 2), Bool::False, "Chain-associative works.";
}

#?rakudo skip 'assoc("non")'
{
	sub infix:<our_non_assoc_infix> is assoc('non') ($a, $b) {
		$a ** $b;
	}
	is (2 our_non_assoc_infix 3), (2 ** 3), "Non-associative works for just tow operands.";
	is ((2 our_non_assoc_infix 2) our_non_assoc_infix 3), (2 ** 2) ** 3, "Non-associative works when used with parens.";
	eval_dies_ok '2 our_non_assoc_infix 3 our_non_assoc_infix 4', "Non-associative should not parsed when used chainly.";
}

{
    role A { has $.v }
    multi sub infix:<==>(A $a, A $b) { $a.v == $b.v }
    lives_ok { 3 == 3 or  die() }, 'old == still works on integers (+)';
    lives_ok { 3 == 4 and die() }, 'old == still works on integers (-)';
    ok  (A.new(v => 3) == A.new(v => 3)), 'infix:<==> on A objects works (+)';
    ok !(A.new(v => 2) == A.new(v => 3)), 'infix:<==> on A objects works (-)';
}

#?rakudo skip 'circumfix:<< >>'
{
    sub circumfix:<<` `>>(*@args) { @args.join('-') }
    is `3, 4, "f"`, '3-4-f', 'slurpy circumfix:<<...>> works'

}

{
    multi sub infix:<+=> (Int $a is rw, Int $b) { $a -= $b }
    my $frew = 10;
    $frew += 5;
    #?rakudo todo 'meta ops'
    is $frew, 5, 'infix redefinition of += works';
}

{
    class MMDTestType {
        has $.a is rw;
        method add(MMDTestType $b) { $.a ~ $b.a }
    }

    multi sub infix:<+>(MMDTestType $a, MMDTestType $b) { $a.add($b) };

    my MMDTestType $a .= new(a=>'foo');
    my MMDTestType $b .= new(a=>'bar');

    is $a + $b, 'foobar', 'can overload exiting operators (here: infix:<+>)';
}

# test that multis with other arity don't interfere with existing ones
# used to be RT #65640
{
    multi sub infix:<+>() { 42 };
    ok 5 + 5 == 10, "New multis don't disturb old ones";
}

# taken from S06-operator-overloading/method.t
#?rakudo skip 'unknown errors'
{
    class Bar {
        has $.bar is rw;
    }

    multi sub prefix:<~> (Bar $self)      { return $self.bar }
    multi sub infix:<+>  (Bar $a, Bar $b) { return "$a $b" }

    {
        my $val;
        lives_ok {
            my $foo = Bar.new();
            $foo.bar = 'software';
            $val = "$foo"
        }, '... class methods work for class';
        is($val, 'software', '... basic prefix operator overloading worked');

        lives_ok {
            my $foo = Bar.new();
            $foo.bar = 'software';
            $val = $foo + $foo;
        }, '... class methods work for class';
        is($val, 'software software', '... basic infix operator overloading worked');
    }

# Test that the object is correctly stringified when it is in an array.
# And test that »...« automagically work, too.
    {
        my $obj;
        lives_ok {
        $obj     = Bar.new;
        $obj.bar = "pugs";
        }, "instantiating a class which defines operators worked";

        my @foo = ($obj, $obj, $obj);
        my $res;
        lives_ok { $res = ~@foo }, "stringification didn't die";
        is $res, "pugs pugs pugs", "stringification overloading worked in array stringification";

        lives_ok { $res = ~[@foo »~« "!"] }, "stringification with hyperization didn't die";
        is $res, "pugs! pugs! pugs!", "stringification overloading was hyperized correctly";
    }


}

# RT #65638
{
    is eval('sub infix:<,>($a, $b) { 42 }; 5, 5'), 42, 'infix:<,>($a, $b)';
    is eval('sub infix:<,>(Int $x where 1, Int $y where 1) { 42 }; 1, 1'), 42,
       'very specific infix:<,>';
    #?rakudo todo 'RT 65638'
    is eval('sub infix:<#>($a, $b) { 42 }; 5 # 5'), 42, 'infix:<comment char>($a, $b)';
    #?rakudo skip 'mixed overloaded operators of different arities'
    is eval('sub infix:<+>() { 42 }; 5 + 5'), 10, 'infix:<+>()';
    is eval('sub infix:<+>($a, $b) { 42 }; 5 + 5'), 42, 'infix:<+>($a, $b)';
}

#?rakudo skip 'not yet implemented'
{
    multi sub infix:<foo>($a, $b) {$a + $b};

    my $x foo=6;
    is $x, 6, 'foo= works for custom operators';
}

#?rakudo skip 'not yet implemented'
{
    our multi sub infix:<bar>($a, $b) {$a + $b};

    my $x bar=6;
    is $x, 6, 'bar= works for custom operators';

}

# RT #74104
{
    class RT74104 {}
    multi sub infix:<+>(RT74104 $, RT74104 $) { -1 }
    is 2+2, 4, 'overloading an operator does not hide other candidates';
}

done;

# vim: ft=perl6
