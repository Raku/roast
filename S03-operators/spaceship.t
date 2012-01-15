use v6;

use Test;

# L<S03/Nonchaining binary precedence/Sort comparisons>

plan 5;

my %ball = map {; $_ => 1 }, 1..12;
is(
    (%ball{12}) <=> (%ball{11}),
    Order::Same,
    'parens with spaceship parse incorrectly',
);

my $result_1 = ([+] %ball{10..12}) <=> ([+] %ball{1..3});

is($result_1, Order::Same, 'When spaceship terms are non-trivial members it parses incorrectly'); 
my $result_2 = ([+] %ball{11,12}) <=> ([+] %ball{1,2});
is($result_2, Order::Same, 'When spaceship terms are non-trivial members it parses incorrectly'); 
#?rakudo skip 'unspecced: does infix:«<=>» numify its arguments?'
{
my $result_3 = ([0] <=> [0,1]);
is($result_3, Order::Increase, 'When spaceship terms are non-trivial members it parses incorrectly'); 
}

%ball{12} = 0.5;
is(%ball{12} <=> %ball{11}, Order::Increase, 'When spaceship terms are non-integral numbers it parses incorrectly');

# vim: ft=perl6
