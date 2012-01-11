use v6;
use Test;

# L<S03/List infix precedence/"the sequence operator">

plan 12;

# sequence with a limit function of arity 2

#?niecza 2 skip 'Cannot use value like WhateverCode as a number'
is (8,*/2 ... abs(*-*) < 2).join(', '), '8, 4, 2, 1', 'arity-2 convergence limit';
is (8,*/2 ...^ abs(*-*) < 2).join(', '), '8, 4, 2', 'arity-2 excluded convergence limit';

# rephrase to make Niecza happy
is (8,*/2 ... (*-*).abs < 2).join(', '), '8, 4, 2, 1', 'arity-2 convergence limit';
is (8,*/2 ...^ (*-*).abs < 2).join(', '), '8, 4, 2', 'arity-2 excluded convergence limit';

# sequence with a limit function of arity 3

{
  my $i = -5;
  my @seq = { ++$i; $i**3-9*$i } ... { ($^a-$^b) > ($^b-$^c) };
  is @seq.join(', '), '-28, 0, 10, 8, 0, -8, -10', 'arity-3 curvature limit';
}

{
  my $i = -5;
  my @seq = { ++$i; $i**3-9*$i } ...^ { ($^a-$^b) > ($^b-$^c) };
  is @seq.join(', '), '-28, 0, 10, 8, 0, -8', 'arity-3 excluded curvature limit';
}

# limit functions that limit sequence exactly at arity limit

#?niecza 2 skip 'Cannot use value like WhateverCode as a number'
is (2, 1, 0.5 ... abs(*-*) < 2).join(', '), '2, 1', 'ASAP arity-2 convergence limit';
is (2, 1, 0.5 ...^ abs(*-*) < 2).join(', '), '2', 'ASAP arity-2 excluded convergence limit';

# rephrase to make Niecza happy
is (2, 1, 0.5 ... (*-*).abs < 2).join(', '), '2, 1', 'ASAP arity-2 convergence limit';
is (2, 1, 0.5 ...^ (*-*).abs < 2).join(', '), '2', 'ASAP arity-2 excluded convergence limit';

# limit function that accepts any number of args

is (1 ... { @_ eq "1 2 3" }).join(', '), '1, 2, 3', 'arity-Inf limit';
is (1 ...^ { @_ eq "1 2 3" }).join(', '), '1, 2', 'arity-Inf excluded limit';

done;
