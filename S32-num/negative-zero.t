use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;
plan 1;

=begin pod

Tests for correct handling of negative zeros

=end pod

subtest 'sprintf formats' => {
    plan 6;

    is-deeply sprintf('%f', -0e0), '-0.000000',     'sub, %f, -0e0';
    is-deeply sprintf('%e', -0e0), '-0.000000e+00', 'sub, %e, -0e0';
    is-deeply sprintf('%g', -0e0), '-0',            'sub, %g, -0e0';
    is-deeply '%f'.sprintf( -0e0), '-0.000000',     'method, %f, -0e0';
    is-deeply '%e'.sprintf( -0e0), '-0.000000e+00', 'method, %e, -0e0';
    is-deeply '%g'.sprintf( -0e0), '-0',            'method, %g, -0e0';
}
