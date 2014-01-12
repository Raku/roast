use v6;
use Test;

plan 33;

# L<S09/Typed arrays>

# while S09 doesn't explicit state it for Hashes, we can assume that
# the same that it says for Arrays hold true.

{
    my Int %h;
    is %h.of,    Int, 'my Int %h declares a Hash of Int';
    is %h.keyof, Any, 'my Int %h declares a Hash with Any keys';
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
    dies_ok { %h<z><t> = 3 }, 'Type constraint prevents autovivification';
    ok %h<a>:!exists,  'Make sure autovivication did not happen';
} #16

{
    lives_ok { my %s of Int = :a(3) }, 'can initialize typed hash (of Int)';
    dies_ok { my %s of Int = :a("3") }, 'initialization of typed hash type checked (of Int)';
    my %s of Str;
    lives_ok { %s<a> = 'b' }, "Can assign to typed hash element (of Str)";
    dies_ok { %s<a> = 1 }, "Can't assign wrongly typed value to typed hash element (of Int)";
} #4

#?pugs   skip "doesn't know about key constraints"
#?niecza skip "doesn't know about key constraints"
{
    my %h{Int};
    is %h.of,    Any, "check the value constraint";
    is %h.keyof, Int, "check the key constraint";
    dies_ok { %h<a>=1 }, "cannot use strings as keys";
    dies_ok { %h<a b c>=(1,2,3) }, "cannot use string slices as keys";
    lives_ok { %h{1} = "a" }, "can use Ints as keys";
    is %h{1}, 'a', "a did the assignment work";
    lives_ok { %h{(2,3,4)} = <b c d> }, "can use Int slices as keys";
    is %h{2}, 'b', "b did the assignment work";
    is %h{3}, 'c', "b did the assignment work";
    is %h{4}, 'd', "b did the assignment work";

    ok %h{2}:exists, ':exists adverb works with key constraint hashes';
    is %h{2}:delete, 'b', ':delete adverb works with key constraint hashes';
    ok %h{2}:!exists, ':delete adverb works with key constraint hashes';
} #13

# vim: ft=perl6
