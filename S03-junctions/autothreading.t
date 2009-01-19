use v6;
use Test;

plan 6;

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


