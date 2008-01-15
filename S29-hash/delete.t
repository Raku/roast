use v6-alpha;

use Test;
plan 7;

# L<S29/"Hash"/=item delete>
my %hash = (a => 1, b => 2, c => 3, d => 4);
is +%hash, 4, "basic sanity (2)";
is ~%hash.delete("a"), "1",
  "deletion of a hash element returned the right value";
is +%hash, 3, "deletion of a hash element";
is ~%hash.delete("c", "d"), "3 4",
  "deletion of hash elements returned the right values";
is +%hash, 1, "deletion of hash elements";
ok !defined(%hash{"a"}), "deleted hash elements are really deleted";

{
    my $a = 1;
    try { delete $a; };
    like($!, rx:P5/Argument is not a Hash or Array element or slice/, "expected message for mis-use of delete");
}

