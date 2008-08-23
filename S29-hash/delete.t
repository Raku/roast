use v6;

use Test;
plan 9;

# L<S29/Hash/=item delete>

=begin pod

Test delete method of Spec Functions.

  our List  multi method Hash::delete ( *@keys )
  our Scalar multi method Hash::delete ( $key ) is default

  Deletes the elements specified by C<$key> or C<$keys> from the invocant.
  returns the value(s) that were associated to those keys.

=end pod

sub gen_hash {
    my %h;
    my $i = 0;
    for 'a'..'z' { %h{$_} = ++$i; }
    return %h;
}

{
    my %h1 = gen_hash;

    my $b = %h1<b>;
    is %h1.delete(<b>), $b, "Test for delete single key. (Method call)";
}

#?rakudo skip 'Slices'
{
    my %h1 = gen_hash;
    my @cde = %h1<c d e>;
    is %h1.delete(<c d e>), @cde, "test for delete multiple keys. (method call)";
}


my %hash = (a => 1, b => 2, c => 3, d => 4);

is +%hash, 4, "basic sanity (2)";
is ~%hash.delete("a"), "1",
  "deletion of a hash element returned the right value";
is +%hash, 3, "deletion of a hash element";
#?rakudo skip 'slurpy Hash.delete'
{
    is ~%hash.delete("c", "d"), "3 4",
    "deletion of hash elements returned the right values";
    is +%hash, 1, "deletion of hash elements";
}
ok !defined(%hash{"a"}), "deleted hash elements are really deleted";

{
    my $a = 1;
    try { delete $a; };
    # XXX do we really want to test against a specific error message?
    #?rakudo 1 skip "no rx:P5"
    like($!, rx:P5/Argument is not a Hash or Array element or slice/, "expected message for mis-use of delete");
}

