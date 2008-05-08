use v6;
use Test;
plan 10;

# L<S29/Num/"=item roots">

#?rakudo skip 'parsefail'
{
    sub has_approx($n, @list) {
        for @list -> my $i {
            if approx($i, $n) {
                return 1;
            }
        }
        return undef;
    }
}

#?pugs todo 'feature'
#?rakudo skip 'parsefail'
{
    my @l = eval('roots(-1, 2)');
    ok(!$!, 'roots($x, $n) compiles');
    ok(@l.elems == 2, 'roots(-1, 2) returns 2 elements');
    ok(has_approx(1i, @l), 'roots(-1, 2) contains 1i');
    ok(has_approx(-1i, @l), 'roots(-1, 2) contains -1i');
}

#?pugs todo 'feature'
#?rakudo skip 'parsefail'
{
    my @l = eval('16.roots(4)');
    ok(!$!, '$x.roots($n) compiles');
    ok(@l.elems == 2, 'roots(16, 4) returns 4 elements');
    ok(has_approx(2, @l), 'roots(16, 4) contains 2');
    ok(has_approx(2i, @l), 'roots(16, 4) contains 2i');
    ok(has_approx(-2, @l), 'roots(16, 4) contains -2');
    ok(has_approx(-2i, @l), 'roots(16, 4) contains -2i');
}
 
