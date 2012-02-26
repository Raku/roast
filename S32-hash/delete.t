use v6;

use Test;
plan 11;

# L<S02/Names and Variables/:delete>

sub gen_hash {
    my %h;
    my $i = 0;
    for 'a'..'z' { %h{$_} = ++$i; }
    return %h;
}

{
    my %h1 = gen_hash;

    my $b = %h1<b>;
    is %h1.delete('b'), $b, "Test for delete single key.";
}

#?niecza todo
{
    my %h1 = gen_hash;
    my @cde = %h1<c d e>;
    is %h1.delete(<c d e>), @cde, "test for delete multiple keys.";
}


my %hash = (a => 1, b => 2, c => 3, d => 4);

is +%hash, 4, "basic sanity (2)";
is ~(%hash.delete('a')), "1",
  "deletion of a hash element returned the right value";
is +%hash, 3, "deletion of a hash element";

#?niecza skip 'Excess arguments to CORE Hash.delete, used 2 of 3 positionals'
{
    is ~(%hash.delete("c", "d")), "3 4",
    "deletion of hash elements returned the right values";
    is +%hash, 1, "deletion of hash elements";
}
ok !defined(%hash{"a"}), "deleted hash elements are really deleted";

{
    my $a = 1;
    eval_dies_ok '$a.delete', "Can't :delete a scalar";
}

# RT #68482
#?pugs skip '.gist'
{
    my %rt68482 = 1 => 3;
    is %rt68482.delete(1).WHAT.gist, 3.WHAT.gist, '.delete.WHAT is the element';

    %rt68482 = 1 => 3;
    my $rt68482 = %rt68482.delete(1);
    is $rt68482.WHAT.gist, 3.WHAT.gist, '.WHAT of stored .delete is the element';
}

done;

# vim: ft=perl6
