use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;

plan 1;

is_run 'BEGIN { BEGIN { q{NativeCall.pm6}.IO.spurt(q{package { say q{all your base} }}); %*ENV<PERL6LIB>=qq{}; }; use NativeCall }',
{
    out => "",
}, 'RT 130883 is fixed';

unlink "NativeCall.pm6";