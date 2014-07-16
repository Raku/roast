# http://perl6advent.wordpress.com/2011/12/23/day-23-idiomatic-perl-6/
use v6;
use Test;
use lib 't/spec/packages';
use Test::Util;
plan 55;

# Pick a random array element

our @array = 10, *+10 ... 250;
our $array-indices = [ 0 .. 24 ];
our $z;

sub picker-seems-random(&picker ) {
    my $sample = (1 .. 15).map({ &picker() }).Bag;
    +$sample.keys > 2 && $sample (<=) @array; 
}

ok picker-seems-random( { $z = @array[ rand*@array ]; } ), '$z = @array[ rand*@array ];';
ok picker-seems-random( { $z = @array.pick } ), '$z = @array.pick;';

# Loop over the keys (indexes) of an array

is_deeply [gather for 0 .. @array.end -> $i { take $i }], $array-indices, 'for 0 .. @array.end -> $i {...}';
is_deeply [gather for @array.keys -> $i { take $i }], $array-indices, 'for @array.keys -> $i {...}';
 
# Whole number division

for [3, 1], [5,1], [6, 2], [42,14] {
    my ($x, $y) = @$_;
    is_deeply Int( $x / 3 ), $y, 'Int( $x / 3 )';
    is_deeply $x div 3, $y, '$x div 3';
}

# Print the count of the elements of an array.

is_deeply 0+@array, 25, '0+@array';
is_deeply +@array, 25, '+@array';
is_deeply @array.elems, 25, '@array.elems';

# Do something every 5th time

is_deeply [gather for 0 .. 42 -> $x { if !($x % 5) {take $x}  }], [0, 5, 10, 15, 20, 25, 30, 35, 40], 'if !($x % 5) {...}'; 
is_deeply [gather for 0 .. 42 -> $x { if $x %% 5 {take $x}  }], [0, 5, 10, 15, 20, 25, 30, 35, 40], 'if $x %% 5 {...}'; 

# Do something $n times, counting up to $n-1

my $n = 10;
is_deeply [gather for 0 ..^ $n -> $x {take $x}], [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 'for 0 ..^ $n {...}';
is_deeply [gather for ^$n -> $x {take $x}], [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 'for ^$n {...}';

# Split on whitespace

for 'I must go down to the seas again' {
    my @words;

    @words = .split(/\s+/);
    is_deeply @words, [<I must go down to the seas again>], '@words = .split(/\s+/);';

    @words = .words;
    is_deeply @words, [<I must go down to the seas again>], '@words = .words';
}

# Split a string into individual characters.

{
    my $word = 'Camelia';
    my @chars;

    @chars = $word.split('');
    is_deeply @chars, [<C a m e l i a>], q<@chars = $word.split('');>;

    @chars = $word.comb;
    is_deeply @chars, [<C a m e l i a>], '@chars = $word.comb;';
}

# Infinite loop

my $m;

while 1 { last if ++$m >= 10 };
is $m, 10, 'while 1 {...}';

loop { last if ++$m >= 20 };
is $m, 20, 'loop {...}';

# Return the unique elements from a list, in original order

my @a = 10, 20, 'dog', 30, 'cat', 'dog', 20, '40';
is_deeply [do {my %s;  grep { !%s{$_}++ }, @a}], [10, 20, 'dog', 30, 'cat', '40'], 'my %s;  return grep { !%s{$_}++ }, @a';
is_deeply [@a.uniq], [10, 20, 'dog', 30, 'cat', '40'], '@a.uniq';

# Some idioms remain the same

my @alpha = 'A' .. 'Z';
is @alpha.join, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', q<my @alpha = 'A' .. 'Z'>;

@a = qw{ able baker charlie };
is @a.join(','), 'able,baker,charlie', '@a = qw{ able baker charlie };';

my %meta = ( foo => 'bar', baz => 'quz' );
is %meta<baz>, 'quz', q{%meta = ( foo => 'bar', baz => 'quz' );};

@a = 1, 2, 3;
my @squares = map { $_ * $_ }, @a;
is_deeply [@squares], [1, 4, 9], 'my @squares = map { $_ * $_ }, @a;';

@a = 10, 20, 'dog', 30, 'cat', 'dog', 20, '40';
my @starts_with_number = grep { /^\d/ }, @a;
is_deeply [@starts_with_number], [10, 20, 30, 20, '40'], '@starts_with_number = grep { /^\d/ }, @a;';

# Magic diamond

my $readme-lines = Test::Util::run( 'my $n; for $*ARGFILES.lines {$n++}; print $n', :args(['README.md']) );

ok $readme-lines >= 10, 'for $*ARGFILES.lines {...}'
   or diag "output: $readme-lines";

my $readme-lines2 = Test::Util::run( 'my $n; for lines() {$n++}; print $n', :args(['README.md']) );

ok $readme-lines2 >= 10, 'for lines() {...}'
   or diag "output: $readme-lines2";

is $readme-lines, $readme-lines2, 'lines() defaults to $*ARGFILES';

# Hash initialization to constant

@a = <red yellow blue>;

{
    my %h = map { $_ => 1 }, @a;
    is_deeply (item %h), {red => 1, yellow => 1, blue => 1}, 'my %h = map { $_ => 1 }, @a'
}

{
    my %h = @a X=> 1;
    is_deeply (item %h), {red => 1, yellow => 1, blue => 1}, 'my %h = @a X=> 1'
}

# Hash initialization for enumeration

{
    my $c;   my %h = map { $_ => ++$c }, @a;
    is_deeply (item %h), {red => 1, yellow => 2, blue => 3}, 'my $c;   my %h = map { $_ => ++$c }, @a';
}

{
    my %h = @a Z=> 1..*;
    is_deeply (item %h), {red => 1, yellow => 2, blue => 3}, 'my $c;   my %h = map { $_ => ++$c }, @a';
}

{
    my %h = @a.pairs».invert;
    is_deeply (item %h), {red => 0, yellow => 1, blue => 2}, 'my %h = @a.pairs».invert;';
}

# Swap two variables

{
    my $x = 35;
    my $y = 7;

    ( $x, $y ) = $y, $x;
    is_deeply [$x, $y], [7, 35], '( $x, $y ) =   $y, $x;';

    ( $x, $y ) .= reverse;
    is_deeply [$x, $y], [35, 7], '( $x, $y ) .= reverse;';
}

# Rotate array left by 1 element

{
    my @a = 10, 20, 30, 40;

    @a.push: @a.shift;
    is_deeply [@a], [20, 30, 40, 10], '@a.push: @a.shift;';

    @a .= rotate;
    is_deeply [@a], [30, 40, 10, 20], '@a .= rotate';
}

# Create an object

class Dog {
    has $.bark = 'arrf!';
}

{
    my $pet = Dog.new;
    is $pet.bark, 'arrf!', 'my $pet = Dog.new;';
}

{
    my Dog $pet .= new;
    is $pet.bark, 'arrf!', 'my Dog $pet .= new;';
}

my @y = 3, 5, 7, 9;
my @z;

@z = map { $_ > 5 ?? ($_) xx 3 !! Nil }, @y;
is_deeply [@z], [Nil, Nil, 7,7,7, 9,9,9], '@z = map { $_ > 5 ?? ($_) xx 3 !! Nil }, @y';

@z = @y.map: { $_ xx 3 if $_ > 5 };
is_deeply @z, [7,7,7, 9,9,9], '@y.map: { $_ xx 3 if $_ > 5 };';

@z = ($_ xx 3 if $_ > 5 for @y);

#?rakudo.jvm todo "RT #122306"
#?rakudo.moar todo "RT #122306"
is_deeply @z, [7,7,7, 9,9,9], '@z = ($_ xx 3 if $_ > 5 for @y);';

# Random integer between 3 and 7 inclusive

$z = 3 + Int(5.rand);
ok 3 <= $z <= 7, '$z = 3 + Int(5.rand)'
    or diag "z: $z";

$z = (3..7).pick;
ok 3 <= $z <= 7, '(3..7).pick'
    or diag "z: $z";

# Count by 3 in an infinite loop

my @s = gather for 3, * + 3 ... * -> $n { last if $n > 21; take $n };
is_deeply [@s], [3, 6, 9, 12, 15, 18, 21], 'for 3, * + 3 ... * -> $n {...}';

@s = gather for 3, 6, 9 ... * -> $n { last if $n > 21; take $n };
is_deeply [@s], [3, 6, 9, 12, 15, 18, 21], 'for 3, 6, 9 ... * -> $n {...}';

# Loop over a range, excluding the start and end points

my $start = 3;
my $limit = 8;

is_deeply [for ($start+1) .. ($limit-1) -> $i {$i}], [4, 5, 6, 7], 'for ($start+1) .. ($limit-1) -> $i {...}';
is_deeply [for $start ^..^ $limit -> $i {$i}], [4, 5, 6, 7], 'for $start ^..^ $limit -> $i {...}';
