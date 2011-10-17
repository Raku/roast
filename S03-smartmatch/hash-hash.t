use v6;
use Test;
plan 4;

sub eval_elsewhere($code){ eval($code) }

#L<S03/Smart matching/Hash Hash hash keys same set>
my %hash1 = ( "foo" => "Bar", "blah" => "ding");
my %hash2 = ( "foo" => "zzz", "blah" => "frbz");
my %hash3 = ( "oink" => "da", "blah" => "zork");
my %hash4 = ( "bink" => "yum", "gorch" => "zorba");
my %hash5 = ( "foo" => 1, "bar" => 1, "gorch" => Mu, "baz" => Mu );

{
    #?rakudo todo 'nom regression'
    #?niecza todo
    ok  (%hash1 ~~ %hash2), 'Hash ~~ Hash (same keys, +)';
    ok !(%hash1 ~~ %hash3), 'Hash ~~ Hash (same keys, -)';
    #?pugs todo
    #?rakudo todo 'nom regression'
    #?niecza todo
    ok eval_elsewhere('(%hash1 ~~ %hash2)'), "hash keys identical";
    #?niecza skip 'System.IndexOutOfRangeException: Array index is out of range.'
    ok eval_elsewhere('!(%hash1 ~~ %hash4)'), "hash keys differ";
}

done;

# vim: ft=perl6
