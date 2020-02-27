use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 1;

# Test deprecated environment variable PERL6LIB
# TODO remove this file when PERL6LIB is removed
is_run 'BEGIN { BEGIN { q{S11modulesRakuLibTest.rakumod}.IO.spurt(q{package { say q{all your base} }}); %*ENV<PERL6LIB>=qq{}; }; use S11modulesRakuLibTest }',
{
    out    => "",
    status => * != 0,
}, 'RT 130883 is fixed, PERL6LIB works';

unlink "S11modulesRakuLibTest.rakumod";
