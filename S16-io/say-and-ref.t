use v6;
use Test;
BEGIN { @*INC.push: 't/spec/packages' }
use Test::Util;

plan 2;


is_run q{my $a = [1, 2, 3]; say   $a},
    {
        out     => "1 2 3\n",
        err     => '',
        status  => 0,
    }, 'Can say array ref';

is_run q{my $a = [1, 2, 3]; print  $a},
    {
        out     => "1 2 3",
        err     => '',
        status  => 0,
    }, 'Can print array ref';

# vim: ft=perl6
