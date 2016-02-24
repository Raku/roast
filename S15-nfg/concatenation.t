use v6;
use Test;

plan 8;

my $a = "\x0044";
my $b = "\x0307";
my $c = "\x0323";

{
    my $ab = $a ~ $b;
    my $ac = $a ~ $c;
    my $abc = $a ~ $b ~ $c;
    my $acb = $a ~ $c ~ $b;
    
    is $ab.chars, 1, 'Base + combiner is 1 grapheme (1)';
    is $ac.chars, 1, 'Base + combiner is 1 grapheme (2)';
    is $abc.chars, 1, 'Base + 2 combiners is 1 grapheme (1)';
    is $acb.chars, 1, 'Base + 2 combiners is 1 grapheme (2)';
    is $abc, $acb, 'Order of combiners concatenated does not affect equality';
}

# 3 bases joined with marks is 2 composed/synthetic followed by base
is ($a, $a, $a).join($b).chars, 3, 'join respects NFG (1)';
is ($a, $a, $a).join($c).chars, 3, 'join respects NFG (2)';
is ($a, $a, $a).join($b ~ $c).chars, 3, 'join respects NFG (3)';
