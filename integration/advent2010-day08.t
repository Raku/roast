# http://perl6advent.wordpress.com/2010/12/08/different-names-of-different-things/

use v6;

use Test;

plan 7;

is do {flip "hello"}, "olleh";
is do {join ", ", reverse <ab cd ef>}, "ef, cd, ab";

my %capitals = France => "Paris", UK => "London";
is_deeply %capitals.invert, ("Paris" => "France", "London" => "UK").list.item;

my %original := %capitals;
my %inverse;
%inverse.push( %original.invert );

is_deeply %inverse, {"Paris" => "France", "London" => "UK"};

my %h;
%h.push('foo' => 1);    is_deeply %h, {foo => 1};
%h.push('foo' => 2);    is_deeply %h, {foo => [1, 2]};
%h.push('foo' => 3);    is_deeply %h, {foo => [1, 2, 3]};
