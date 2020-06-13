use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 3;


is_run q{my $a = [1, 2, 3]; say   $a},
    {
        out     => "[1 2 3]\n",
        err     => '',
        status  => 0,
    }, 'Can say array ref';

is_run q{my $a = [1, 2, 3]; print  $a},
    {
        out     => "1 2 3",
        err     => '',
        status  => 0,
    }, 'Can print array ref';

# https://github.com/Raku/old-issue-tracker/issues/2284
is_run q{IO.say},
    {
        out => "(IO)\n";
    }, 'Can do IO.say';

# vim: expandtab shiftwidth=4
