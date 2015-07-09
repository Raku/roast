use v6;
use Test;

# L<S32::Containers/"Array"/"=item splice">

=begin description

This test tests the C<splice> builtin

=end description

plan 2 * 12;

sub splice-ok(\ret, \ret_exp, \rem, \rem_exp, Str $comment) {
    subtest {
        plan 4;
        is ret.WHAT, ret_exp.WHAT, 'return types match';
        is ret,      ret_exp,      'return results match';
        is rem.WHAT, rem_exp.WHAT, 'remainder types match';
        is rem,      rem_exp,      'remainder results match';
    }, $comment;
}

my     @Any;
my int @int;
my Int @Int;

#for $@Any, Array, $@int, array[int], $@Int, Array[Int] -> @a, $T {
for $@Any, Array, $@Int, Array[Int] -> @a, $T {
#for $@Any, Array -> @a, $T {

    sub submeth-ok(\values,\params,\return,\remain,$comment){
        subtest {
            plan 2;

            # sub
            @a = values;
            splice-ok splice(@a,|params),$T.new(return),@a,$T.new(remain),
              "sub: $comment";

            # method
            @a = values;
            splice-ok @a.splice(|params),$T.new(return),@a,$T.new(remain),
              "$T.perl() method: $comment";
        }, "$T.perl() $comment";
    }

    submeth-ok (1..10),      \(),  (1..10),        (), 'whole';
    submeth-ok (1..12),   \(0,1),     (1,),   (2..12), 'simple 1 elem';
    submeth-ok (1..10),   \(8,2),   (9,10),    (1..8), 'simple 2 elems';
    submeth-ok (1..10),     \(7), (8,9,10),    (1..7), 'simple rest';
    submeth-ok (1..10),   \(7,*), (8,9,10),    (1..7), 'simple rest whatever';
    submeth-ok (1..10),    \(10),       (),   (1..10), 'none rest';
    submeth-ok (1..10),     \(*),       (),   (1..10), 'none whatever rest';
    submeth-ok (1..10),   \(*-3), (8,9,10),    (1..7), 'end rest';
    submeth-ok (1..10), \(*-3,2),    (8,9), (1..7,10), 'end some';

    submeth-ok (1..10), \(10,0,11,12),  (),   (1..12), "push";
    submeth-ok (1..10),  \(*,0,11,12),  (),   (1..12), "push whatever";
    submeth-ok (2..10),    \(0,0,0,1),  (),   (0..10), "unshift";
}

=finish

# to be converted into more descriptive tests
@a = (2..10);
splice_ok splice(@a,0,0,0,1), @a, [], [0..10], "Prepending values works";

# Need to convert these
# skip 5, "Need to convert more tests from Perl5";
@a = (0..11);
splice_ok splice(@a,5,1,5), @a, [5], [0..11], "Replacing an element with itself";

@a = (0..11);
splice_ok splice(@a, +@a, 0, 12, 13), @a, [], [0..13], "Appending an array";

{
    @a = (0..13);
    @res = splice(@a, *-@a, +@a, 1, 2, 3);
    splice_ok @res, @a, [0..13], [1..3], "Replacing the array contents from right end";
}

{
    @a = (1, 2, 3);
    splice_ok splice(@a, 1, *-1, 7, 7), @a, [2], [1,7,7,3], "Replacing a array into the middle";
} 

{
    @a = (1,7,7,3);
    splice_ok splice(@a,*-3,*-2,2), @a, [7], [1,2,7,3], "Replacing negative count of elements";
}

# Test the identity of calls to splice:
sub indirect_slurpy_context( *@got ) { @got };

# splice4 gets "CxtItem _" or "CxtArray _" instead of "CxtSlurpy _"
my @tmp = (1..10);
{
    @a = splice @tmp, 5, 3;
    @a = indirect_slurpy_context( @a );
    @tmp = (1..10);
    @b = indirect_slurpy_context( splice @tmp, 5, 3 );
    is( @b, @a, "Calling splice with immediate and indirect context returns consistent results");
    is( @a, [6,7,8], "Explicit call/assignment gives the expected results");
    is( @b, [6,7,8], "Implicit context gives the expected results"); # this is due to the method-fallback bug
}

{
    @tmp = (1..10);
    @a = item splice @tmp, 5, 3;
    is( @a, [6..8], "Explicit scalar context returns an array reference");
}

## test some error conditions

@a = splice([], 1);
is +@a, 0, '... empty arrays are not fatal anymore';
# But this should generate a warning, but unfortunately we can't test for
# warnings yet.

dies-ok({ 42.splice }, '.splice should not work on scalars');

@a = (1..10);
dies-ok({use fatal; splice(@a,-2)}, "negative offset dies");
dies-ok({use fatal; splice(@a,2,-20)}, "negative size dies");

{
    my @empty;
    nok @empty.splice(0, 3), 'splicing an empty array should return the empty list';
}

# RT #116897
{
    my @empty = ();
    my $i = 0;
    while splice(@empty, 0, 3) { $i++; last }
    is $i, 0, "'while (…splice…)' should neither hang nor even run";
}

# vim: ft=perl6
