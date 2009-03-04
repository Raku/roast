use v6;

use Test;

plan 1;

{
  my @array = <a b c d>;
  for @array { $_ ~= "c" }
  is ~@array, "ac bc cc dc",
    'mutating $_ in for works';
}

# Hm... what about @array.sort: { $_ = ... }? Disallow? (As that would prevent
# many optimizations...)  (and Perl 5 never allowed that anyway)
