use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 1;

# Test deprecated environment variable RAKUDOLIB
# TODO remove this file when RAKUDOLIB is removed
is_run 'BEGIN { BEGIN { q{S11modules-RAKUDOLIB-Test.rakumod}.IO.spurt(q{package { say q{all your base} }}); %*ENV<RAKULIB>=qq{}; };\
        use S11modules-RAKUDOLIB-Test }',
{
    out    => "",
    status => * != 0,
}, 'RAKUDOLIB works (see RT 130883)';
unlink "S11modules-RAKUDOLIB-Test.rakumod";
