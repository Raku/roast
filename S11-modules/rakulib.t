use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 1;

# Implement RAKULIB as primary module path environment variable
is_run 'BEGIN { BEGIN { q{S11modules-RAKULIB-Test.rakumod}.IO.spurt(q{package { say q{all your base} }}); %*ENV<RAKULIB>=qq{}; };\
        use S11modules-RAKULIB-Test }',
{
    out    => "",
    status => * != 0,
}, 'RAKULIB works (see RT 130883)';
unlink "S11modules-RAKULIB-Test.rakumod";
