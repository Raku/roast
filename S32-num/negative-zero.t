use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;
plan 7;

=begin pod

Tests for correct handling of negative zeros

=end pod

sub is-neg-zero ($v, $desc) {
    # atan2 is sensitive to the sign of the zero; use it as a way to determine
    # which zero we got from val()
    is-approx atan2($v, -1e0), -π, $desc;
}



subtest 'sprintf formats' => {
    plan 6;

    is-deeply sprintf('%f', -0e0), '-0.000000',     'sub, %f, -0e0';
    is-deeply sprintf('%e', -0e0), '-0.000000e+00', 'sub, %e, -0e0';
    is-deeply sprintf('%g', -0e0), '-0',            'sub, %g, -0e0';
    is-deeply '%f'.sprintf( -0e0), '-0.000000',     'method, %f, -0e0';
    is-deeply '%e'.sprintf( -0e0), '-0.000000e+00', 'method, %e, -0e0';
    is-deeply '%g'.sprintf( -0e0), '-0',            'method, %g, -0e0';
}

# RT#128897
{
    is-neg-zero val(<-0e0>), 'val() negative zero, U+002D minus';
    is-neg-zero val(<−0e0>), 'val() negative zero, U+2212 minus';
    is-neg-zero '-0e0'.Num,  'Str.Num gives neg. zero, U+002D minus';
    is-neg-zero '−0e0'.Num,  'Str.Num gives neg. zero, U+2212 minus';
    is-neg-zero   '-0'.Num,  'Str.Num gives neg. zero (non-num str), U+002D';
    is-neg-zero   '−0'.Num,  'Str.Num gives neg. zero (non-num str), U+2212';
}
