use v6;
use Test;

plan 6;

# L<S02/"Names"/"You should not assume that these will have the same value as their compile-time cousins.">

ok $?PERLVER, '$?PERLVER is present';
ok $*PERLVER, '$*PERLVER is present';

ok $?OS, '$?OS is present';
ok $*OS, '$*OS is present';

ok $?OSVER, '$?OSVER is present';
ok $*OSVER, '$*OSVER is present';
