use v6;
use Test;
plan 9;

sub postfix:<!>($N) {
    [*] 2..$N;
}
is 6!, 720, 'factorial';

my $x = 2;
my $y = 3;
my $z = 4;

is $x + $y * $z, $x + ($y * $z), 'precedence';
is $x * $y + $z, ($x * $y) + $z, 'precedence';
is $x / $y / $z, ($x / $y) / $z, 'associativity';
$x = $y = $z;
is $x, $z, 'associativity';

# !prefix examples
ok 'a' !eq 'b', '!eq';
ok 'a' !~~ /b/, '!~~';
ok 3 !< 2, '!<';
ok 'b' !before 'a', '!before';

