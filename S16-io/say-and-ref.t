use v6;
use Test;
BEGIN { @*INC.push: 't/spec/packages' }
use Test::Util;

plan 3;


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

# RT #80186
is_run q{IO.say},
    {
        out => "(IO)\n";
    }, 'Can do IO.say';

# vim: ft=perl6
