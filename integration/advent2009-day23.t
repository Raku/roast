# http://perl6advent.wordpress.com/2009/12/23/day-23-lazy-fruits-from-the-gather-of-eden/

use v6;
use Test;

plan 4;

my @gather-result = gather { take $_ for 5..7 };

my @push-result;
push @push-result, $_ for 5..7;

is @gather-result, @push-result, 'Gather/task and push building the same list';

sub incremental-concat(@list) {
    my $string-accumulator = "";
    gather for @list {
    # RAKUDO: The ~() is a workaround for [perl #62178]
        take ~($string-accumulator ~= $_);
    }
};

is incremental-concat(<a b c>), ["a", "ab", "abc"], 'String accumulator';

class Tree {
    has Tree $.left;
    has Tree $.right;
    has Str $.node;
}

sub transform(Tree $t) {
    $t.node();
}

sub traverse-tree-inorder(Tree $t) {
  traverse-tree-inorder($t.left) if $t.left;
  take transform($t);
  traverse-tree-inorder($t.right) if $t.right;
}

my $tree = Tree.new(
                node => 'a',
                left => Tree.new(
                    node => 'b',
                    left => Tree.new(
                        node => 'c'
                    ),
                    right => Tree.new(
                        node => 'd'
                    )
                ),
                right => Tree.new(
                    node => 'e'
                )
           );
my @all-nodes = gather traverse-tree-inorder($tree);

is @all-nodes, ["c", "b", "d", "a", "e"], 'In order tree traversal with gather/take';

#?rakudo skip "lists aren't properly lazy in Rakudo yet"
#?niecza skip 'hangs'
{
    my @natural-numbers = 0 .. Inf;
    my @even-numbers  = 0, 2 ... *;    # arithmetic seq
    my @odd-numbers   = 1, 3 ... *;
    my @powers-of-two = 1, 2, 4 ... *; # geometric seq

    my @squares-of-odd-numbers = map { $_ * $_ }, @odd-numbers;

    sub enumerate-positive-rationals() { # with duplicates, but still
      take 1;
      for 1..Inf -> $total {
        for 1..^$total Z reverse(1..^$total) -> $numerator, $denominator {
          take $numerator / $denominator;
        }
      }
    }

    sub enumerate-all-rationals() {
      map { $_, -$_ }, enumerate-positive-rationals();
    }

    # TODO - we need a test for enumerate-all-rationals

    sub fibonacci() {
      gather {
        take 0;
        my ($last, $this) = 0, 1;
        loop { # infinitely!
          take $this;
          ($last, $this) = $this, $last + $this;
        }
      }
    }

    is fibonacci[10], 55, 'Lazy implementation of fibonacci with gather/take';
}

sub merge(@a, @b) {
  !@a && !@b ?? () !!
  !@a        ?? @b !!
         !@b ?? @a !!
  (@a[0] < @b[0] ?? @a.shift !! @b.shift, merge(@a, @b))
}

sub hamming-sequence() { # 2**a * 3**b * 5**c, where { all(a,b,c) >= 0 }
  gather {
    take 1;
    take $_ for
        merge( (map { 2 * $_ }, hamming-sequence()),
               merge( (map { 3 * $_ }, hamming-sequence()),
                      (map { 5 * $_ }, hamming-sequence()) ));
  }
}

# TODO - we need some tests for merge and hamming problem above

done;
