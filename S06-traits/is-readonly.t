use v6;
use Test;

plan 3;

# L<S06/"Parameter traits"/"=item is readonly">
# should be moved with other subroutine tests?

{
    my $a = 3;

    ok (try { VAR($a).defined }), ".VAR on a plain normal initialized variable returns true";
}

# RT #71356
{
    class C {
        has $!attr is readonly = 71356;
        method get-attr() { $!attr }
        method set-attr($val) { $!attr = $val }
    }
    is C.new.get-attr, 71356, 'can read from readonly private attributes';
    #?rakudo todo 'readonly attributes'
    #?pugs todo
    dies_ok { my $c = C.new; $c.set-attr: 99; }, 'cannot assign to readonly private attribute'
}

# vim: ft=perl6
