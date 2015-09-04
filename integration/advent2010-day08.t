# http://perl6advent.wordpress.com/2010/12/08/different-names-of-different-things/

use v6;

use Test;

plan 8;

is do {flip "hello"}, "olleh", 'string reversal';
is do {join ", ", reverse <ab cd ef>}, "ef, cd, ab", 'list reversal';

my %capitals = France => "Paris", UK => "London";
is-deeply [%capitals.invert.sort], ["London" => "UK", "Paris" => "France"], 'hash inversion';

my %original := %capitals;
my %inverse = %original.invert;

is-deeply %inverse, {"Paris" => "France", "London" => "UK"}, 'hash inversion, non-distructive';

my %h;

%h.push('foo' => 1);
is-deeply %h, {foo => 1}, 'hash element push';

%h.push('foo' => 2);
is-deeply %h, {foo => [1, 2]}, 'hash element push';

%h.push('foo' => 3);
is-deeply %h, {foo => [1, 2, 3]}, 'hash element push';

is-deeply flip(<a b c>.list), "c b a", 'flip coercement (list)';
