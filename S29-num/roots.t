use v6;
use Test;
<<<<<<< .mine
plan 9;
=======
plan 8;
>>>>>>> .r20951

# L<S29/Num/"=item roots">

sub approx($a, $b){
    ($a-$b).abs < 0.001;
}

sub has_approx($n, @list) {
    for @list -> $i {
        if approx($i, $n) {
            return 1;
    }
    return undef;
}

#?rakudo skip 'roots not implemented'
{
    my @l = roots(-1, 2);
    ok(@l.elems == 2, 'roots(-1, 2) returns 2 elements');
    ok(has_approx(1i, @l), 'roots(-1, 2) contains 1i');
    ok(has_approx(-1i, @l), 'roots(-1, 2) contains -1i');
}

#?pugs todo 'feature'
#?rakudo skip 'roots not implemented'
{
    my @l = 16.roots(4);
    ok(@l.elems == 4, 'roots(16, 4) returns 4 elements');
    ok(has_approx(2, @l), 'roots(16, 4) contains 2');
    ok(has_approx(2i, @l), 'roots(16, 4) contains 2i');
    ok(has_approx(-2, @l), 'roots(16, 4) contains -2');
    ok(has_approx(-2i, @l), 'roots(16, 4) contains -2i');
}
