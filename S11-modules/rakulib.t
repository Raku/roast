use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 1;

# Implement RAKULIB
is_run 'BEGIN { BEGIN { q{S11modulesRakuLibTest.pm6}.IO.spurt(q{package { say q{all your base} }}); %*ENV<RAKULIB>=qq{}; }; use S11modulesRakuLibTest }',
{
    out    => "",
    status => * != 0,
}, 'RAKULIB works';
unlink "S11modulesRakuLibTest.pm6";
