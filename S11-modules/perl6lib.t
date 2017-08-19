use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;

plan 1;

is_run 'BEGIN { BEGIN { q{S11modulesPerl6LibTest.pm6}.IO.spurt(q{package { say q{all your base} }}); %*ENV<PERL6LIB>=qq{}; }; use S11modulesPerl6LibTest }',
{
    out    => "",
    status => * != 0,
}, 'RT 130883 is fixed';

unlink "S11modulesPerl6LibTest.pm6";
