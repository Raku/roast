use v6;
use Test;

plan 32;

{
    # Solves the equatioin A + B = A * C for integers
    # by autothreading over all interesting values

    my $n = 0;
    sub is_it($a, $b, $c) {
        $n++;
        if ($a != $b && $b != $c && $a != $c &&
        $a * 10 + $c == $a + $b ) {
        return "$a + $b = $a$c";
        } else {
        return ();
        }
    }

    # note that since the junction is not evaluated in boolean context,
    # it's not collapsed, and the auto-threading may not abort prematurely
    # when a result is found.
    my $answer = is_it(any(1..2), any(7..9), any(0..6));
    is($n, 42, "called lots of times :-)");

    ok( $answer eq "1 + 9 = 10", "found right answer");
}

{
    # Checks auto-threading works on method calls too, and that we get the
    # right result.
    class Foo {
        has $.count = 0;
        method test($x) { $!count++; return $x }
    }

    my ($x, $r, $ok);
    $x = Foo.new;
    $r = $x.test(1|2);
    is($x.count, 2, 'method called right number of times');
    $ok = $r.perl.subst(/\D/, '', :g) eq '12' | '21';
    ok(?$ok,        'right values passed to method');

    $x = Foo.new;
    $r = $x.test(1 & 2 | 3);
    is($x.count, 3, 'method called right number of times');
    $ok = $r.perl.subst(/\D/, '', :g) eq '123' | '213' | '312' | '321'; # e.g. & values together
    ok(?$ok,        'junction structure maintained');
}

{
    # Check auto-threding works right on multi-subs.
    my $calls_a = 0;
    my $calls_b = 0;
    my $calls_c = 0;
    my ($r, $ok);
    multi mstest(Int $x) { $calls_a++; return $x }
    multi mstest(Str $x, Str $y) { $calls_b++ }
    multi mstest(Str $x) { $calls_c++ }
    $r = mstest(1&2 | 3);
    is($calls_a, 3, 'correct multi-sub called right number of times');
    is($calls_b, 0, 'incorrect multi-sub not called');
    is($calls_c, 0, 'incorrect multi-sub not called');
    $ok = $r.perl.subst(/\D/, '', :g) eq '123' | '213' | '312' | '321'; # e.g. & values together
    ok(?$ok,        'junction structure maintained');

    $calls_a = 0;
    $calls_b = 0;
    $calls_c = 0;
    mstest("a" | "b", "c" & "d");
    is($calls_b, 4, 'correct multi-sub called right number of times');
    is($calls_a, 0, 'incorrect multi-sub not called');
    is($calls_c, 0, 'incorrect multi-sub not called');
    
    $calls_a = 0;
    $calls_b = 0;
    $calls_c = 0;
    mstest('a' | 1 & 'b');
    is($calls_a, 1, 'correct multi-sub called right number of times (junction of many types)');
    is($calls_c, 2, 'correct multi-sub called right number of times (junction of many types)');
    is($calls_b, 0, 'incorrect multi-sub not called');

    # Extra sanity, in case some multi-dispatch caching issues existed.
    $calls_a = 0;
    $calls_b = 0;
    $calls_c = 0;
    mstest('a' | 1 & 'b');
    is($calls_a, 1, 'correct multi-sub called again right number of times (junction of many types)');
    is($calls_c, 2, 'correct multi-sub called again right number of times (junction of many types)');
    is($calls_b, 0, 'incorrect multi-sub again not called');
    
    $calls_a = 0;
    $calls_b = 0;
    $calls_c = 0;
    mstest('a');
    is($calls_a, 0, 'non-junctional dispatch still works');
    is($calls_b, 0, 'non-junctional dispatch still works');
    is($calls_c, 1, 'non-junctional dispatch still works');
}

{
    # Check auto-threading with multi-methods. Basically a re-hash of the
    # above, but in a class.
    class MMTest {
        has $.calls_a = 0;
        has $.calls_b = 0;
        has $.calls_c = 0;
        multi method mmtest(Int $x) { $!calls_a++; return $x }
        multi method mmtest(Str $x, Str $y) { $!calls_b++ }
        multi method mmtest(Str $x) { $!calls_c++ }
    }
    my ($obj, $r, $ok);
    $obj = MMTest.new();
    $r = $obj.mmtest(1&2 | 3);
    is($obj.calls_a, 3, 'correct multi-method called right number of times');
    is($obj.calls_b, 0, 'incorrect multi-method not called');
    is($obj.calls_c, 0, 'incorrect multi-method not called');
    $ok = $r.perl.subst(/\D/, '', :g) eq '123' | '213' | '312' | '321'; # e.g. & values together
    ok(?$ok,            'junction structure maintained');

    $obj = MMTest.new();
    $obj.mmtest("a" | "b", "c" & "d");
    is($obj.calls_b, 4, 'correct multi-method called right number of times');
    is($obj.calls_a, 0, 'incorrect multi-method not called');
    is($obj.calls_c, 0, 'incorrect multi-method not called');
    
    $obj = MMTest.new();
    $obj.mmtest('a' | 1 & 'b');
    is($obj.calls_a, 1, 'correct multi-method called right number of times (junction of many types)');
    is($obj.calls_c, 2, 'correct multi-method called right number of times (junction of many types)');
    is($obj.calls_b, 0, 'incorrect multi-method not called');
}
