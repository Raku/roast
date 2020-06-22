use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/6108
# TODO Replace PERL6LIB with RAKULIB when supported
is_run 'BEGIN { BEGIN { q{S11modulesRakuLibTest.pm6}.IO.spurt(q{package { say q{all your base} }}); %*ENV<PERL6LIB>=qq{}; }; use S11modulesRakuLibTest }',
{
    out    => "",
    status => * != 0,
}, 'RT 130883 is fixed';

unlink "S11modulesRakuLibTest.pm6";

# vim: expandtab shiftwidth=4
