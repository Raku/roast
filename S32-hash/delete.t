use v6;

use Test;
plan 9;

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
    is %h1<b>:delete, $b, "Test for delete single key.";
}

my %hash = (a => 1, b => 2, c => 3, d => 4);

is +%hash, 4, "basic sanity (2)";
is ~(%hash<a>:delete), "1",
  "deletion of a hash element returned the right value";
is +%hash, 3, "deletion of a hash element";
ok !defined(%hash{"a"}), "deleted hash elements are really deleted";

{
    my $a = 1;
    throws-like '$a:delete', Exception, "Can't :delete a scalar";
}

# RT #68482
{
    my %rt68482 = 1 => 3;
    is (%rt68482<1>:delete).WHAT.gist, 3.WHAT.gist, 'delete.WHAT is the element';

    %rt68482 = 1 => 3;
    my $rt68482 = %rt68482<1>:delete;
    is $rt68482.WHAT.gist, 3.WHAT.gist, '.WHAT of stored delete is the element';
}

{ # coverage; 2016-10-04
    is-deeply Hash<z>:delete, Nil, ':delete on Hash:U returns Nil';
}

# vim: ft=perl6
