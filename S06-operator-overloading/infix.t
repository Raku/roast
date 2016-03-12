use v6;
use Test;
plan 44;

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
    is EVAL(q[ "romeo & juliet" (C) "Shakespeare" ]), "romeo & juliet CopyRight Shakespeare",
        'infix operator overloading for new operator (nasty)';
}

{
    sub infix:«_<_ »($one, $two) { return 42 }   #OK not used
    is 3 _<_ 5, 42, "frenchquoted infix sub";
}

# unfreak perl6.vim:  >>

# Overloading by setting the appropriate code variable
#?rakudo skip "cannot bind with this LHS RT #124979"
{
  my &infix:<plus>;
  BEGIN {
    &infix:<plus> := { $^a + $^b };
  }

  is 3 plus 5, 8, 'overloading an operator using "my &infix:<...>" worked';
}

# Overloading by setting the appropriate code variable using symbolic
# dereferentiation
#?niecza skip 'Cannot use hash access on an object of type Array'
{
  my &infix:<times>;
  BEGIN {
    &::("infix:<times>") = { $^a * $^b };
  }

  is 3 times 5, 15, 'operator overloading using symbolic dereferentiation';
}

# Accessing an operator using its subroutine name
{
  is &infix:<+>(2, 3), 5, "accessing a builtin operator using its subroutine name";

  my &infix:<z> := { $^a + $^b };
  is &infix:<z>(2, 3), 5, "accessing a userdefined operator using its subroutine name";

  #?rakudo skip 'undeclared name'
  #?niecza skip 'Undeclared routine'
  is ~(&infix:<»+«>([1,2,3],[4,5,6])), "5 7 9", "accessing a hyperoperator using its subroutine name";
}

# Overriding infix:<;>
#?rakudo todo 'infix:<;> RT #124981'
#?niecza todo
{
    my proto infix:<;> ($a, $b) { $a + $b }
    is $(3 ; 2), 5  # XXX correct?
}

# here is one that co-erces a MyClass into a Str and a Num.
#?niecza skip 'import NYI'
{
    class OtherClass {
      has $.x is rw;
    }

    class MyClass {
      method prefix:<~> is export { "hi" }
      method prefix:<+> is export { 42   }
      method infix:<as>($self: OtherClass $to) is export {   #OK not used
        my $obj = $to.new;
        $obj.x = 23;
        return $obj;
      }
    }
    import MyClass;  # should import that sub forms of the exports

  my $obj;
  lives-ok { $obj = MyClass.new }, "instantiation of a prefix:<...> and infix:<as> overloading class worked";
  lives-ok { ~$obj }, "our object can be stringified";
  is ~$obj, "hi", "our object was stringified correctly";
  is EVAL('($obj as OtherClass).x'), 23, "our object was coerced correctly";
}

#?rakudo skip 'infix Z will never work; no lexical Z RT #124983'
{
  my sub infix:<Z> ($a, $b) {
      $a ** $b;
  }
  is (2 Z 1 Z 2), 4, "default Left-associative works.";
}

#?rakudo skip 'no lexical Z RT #124983'
{
  my sub infix:<Z> ($a, $b) is assoc('left') {
      $a ** $b;
  }

  is (2 Z 1 Z 2), 4, "Left-associative works.";
}

#?rakudo skip 'no lexical Z RT #124983'
{
  my sub infix:<Z> ($a, $b) is assoc('right') {
      $a ** $b;
  }

  is (2 Z 1 Z 2), 2, "Right-associative works.";
}

#?rakudo skip 'no lexical Z RT #124983'
{
  my sub infix:<Z> ($a, $b) is assoc('chain') {
      $a eq $b;
  }


  is (1 Z 1 Z 1), Bool::True, "Chain-associative works.";
  is (1 Z 1 Z 2), Bool::False, "Chain-associative works.";
}

{
  sub infix:<our_non_assoc_infix> ($a, $b) is assoc('non') {
      $a ** $b;
  }
  is (2 our_non_assoc_infix 3), (2 ** 3), "Non-associative works for just tow operands.";
  is ((2 our_non_assoc_infix 2) our_non_assoc_infix 3), (2 ** 2) ** 3, "Non-associative works when used with parens.";
  throws-like '2 our_non_assoc_infix 3 our_non_assoc_infix 4',
      X::Syntax::NonAssociative,
      "Non-associative should not parsed when used chainly.";
}

#?niecza skip "roles NYI"
{
    role A { has $.v }
    multi sub infix:<==>(A $a, A $b) { $a.v == $b.v }
    lives-ok { 3 == 3 or  die() }, 'old == still works on integers (+)';
    lives-ok { 3 == 4 and die() }, 'old == still works on integers (-)';
    ok  (A.new(v => 3) == A.new(v => 3)), 'infix:<==> on A objects works (+)';
    ok !(A.new(v => 2) == A.new(v => 3)), 'infix:<==> on A objects works (-)';
}

{
    multi sub infix:<+=> (Int $a is rw, Int $b) { $a -= $b }
    my $frew = 10;
    $frew += 5;
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
#?niecza skip 'No matching candidates to dispatch for &infix:<+>'
{
    multi sub infix:<+>() { 42 };
    ok 5 + 5 == 10, "New multis don't disturb old ones";
}

# RT #65638
{
    is EVAL('sub infix:<,>($a, $b) { 42 }; 5, 5'), 42, 'infix:<,>($a, $b)';
    is EVAL('sub infix:<,>(Int $x where 1, Int $y where 1) { 42 }; 1, 1'), 42,
       'very specific infix:<,>';
    #?rakudo todo 'RT #65638'
    #?niecza todo
    is EVAL('sub infix:<#>($a, $b) { 42 }; 5 # 5'), 42, 'infix:<comment char>($a, $b)';
    is EVAL('multi sub infix:<+>() { 42 }; 5 + 5'), 10, 'infix:<+>()';
    is EVAL('sub infix:<+>($a, $b) { 42 }; 5 + 5'), 42, 'infix:<+>($a, $b)';
}

{
    multi sub infix:<foo>($a, $b) {$a + $b};

    # autoviv tries to call &[foo]() with no arguments, so we define first
    # alternative is below, with a candidate with an empty parameter list
    my $x = 0;
    $x foo=6;
    is $x, 6, 'foo= works for custom operators';
}

{
    multi sub infix:<foo>($a, $b) {$a + $b};
    multi sub infix:<foo>() { 0 };

    # alternative with a candidate with an empty parameter list
    my $x foo=6;
    is $x, 6, 'foo= works for custom operators';
}

{
    our sub infix:<bar>($a, $b) {$a + $b};

    # similar to above, but without the empty param candidate
    my $x = 0;
    $x bar=6;
    is $x, 6, 'bar= works for custom operators';

}

# RT #74104
#?niecza skip 'No matching candidates to dispatch for &infix:<+>'
{
    class RT74104 {}
    multi sub infix:<+>(RT74104 $, RT74104 $) { -1 }
    is 2+2, 4, 'overloading an operator does not hide other candidates';
}

# RT #111418
# RT #112870
{
    sub infix:<*+>($a, $b) { $a * $b + $b }
    is 2 *+ 5, 15, 'longest operator wins (RT #111418)';
    sub infix:<~eq>(Str $a, Str $b) { uc($a) eq uc($b) }
    ok 'a' ~eq 'A', 'longest operator wins (RT #112870)';
}

# RT #109800
{
    my &infix:<c> = { $^a + $^b };
    is 1 c 2, 3, 'assignment to code variable works.';
}

is infix:['+'](2,3), 5, 'can call existing infix via compile-time string lookup';
is infix:['Z~'](<a b>, <c d>), 'ac bd', 'can call autogen infix via compile-time string lookup';
