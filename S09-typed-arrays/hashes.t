use v6;
use Test;

plan 18;

# L<S09/Typed arrays>

# while S09 doesn't explicit state it for Hashes, we can assume that
# the same that it says for Arrays hold true.

{
    my Int %h;
    ok %h.of === Int, 'my Int %h declares a Hash of Int';
    lives_ok { %h = (a => 3, b => 7) }, 'can assign Ints to an Hash of Int';
    lives_ok { %h<foo> = 8           }, 'can assign Int to hash slot';
    lives_ok { %h{'c', 'd' } = (3, 4) }, 'can assign to slice of typed hash';
    is +%h, 5, '... and we have the right number of items';

    my Int %g;
    lives_ok { %g = %h }, 'can assign one typed hash to another';
    lives_ok { %h.pairs }, 'can call methods on typed hashes';
    is %h.pairs.sort.join, %g.pairs.sort.join, 
                        '... and the hashes are the same afterwards';

    lives_ok { my Int %s = :a(3) }, 'can initialize typed hash';
    my Str %s = :a<b>;
    dies_ok { %h = %s }, "Can't assign Str hash to Int hash";
    dies_ok { %h = :a<b> }, "Can't assign literal Str hash to Int hash";
    dies_ok { %h<a> = 'foo' }, "Can't assign to hash item";
    dies_ok { %h{'a', 'b'} = <c d> }, "prevent mismatched hash slice";
    dies_ok { %h<z><t> = 3 }, 'Typ constraint prevents autovivification';
}

{
    lives_ok { my %s of Int = :a(3) }, 'can initialize typed hash (of Int)';
    #?rakudo todo "of trait on vars"
    dies_ok { my %s of Int = :a("3") }, 'initialization of typed hash type checked (of Int)';
    my %s of Str;
    lives_ok { %s<a> = 'b' }, "Can assign to typed hash element (of Int)";
    #?rakudo todo "of trait on vars"
    dies_ok { %s<a> = 1 }, "Can't assign wrongly typed value to typed hash element (of Int)";
}

# vim: ft=perl6
