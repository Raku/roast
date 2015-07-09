use v6;
use Test;

# L<S32::Containers/"Array"/"=item splice">

=begin description

This test tests the C<splice> builtin

=end description

plan (2 * 29) + 3 + 1;

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

#---------------------+--------+---------+----------+---------------------------
#                init | params |  return |   remain | comment
#---------------------+--------+---------+----------+---------------------------
    submeth-ok (1..10),      (),  (1..10),        (), 'whole';
    submeth-ok (1..12),   (0,1),     (1,),   (2..12), 'simple 1 elem';
    submeth-ok (1..10),   (8,2),   (9,10),    (1..8), 'simple 2 elems';
    submeth-ok (1..10),     (7), (8,9,10),    (1..7), 'simple rest';
    submeth-ok (1..10),   (7,*), (8,9,10),    (1..7), 'simple rest *';
    submeth-ok (1..10),    (10),       (),   (1..10), 'none rest';
    submeth-ok (1..10),     (*),       (),   (1..10), 'none * rest';
    submeth-ok (1..10),   (*-3), (8,9,10),    (1..7), 'end rest';
    submeth-ok (1..10), (*-3,2),    (8,9), (1..7,10), 'end some';
    submeth-ok (1..10), (*-3,*-1),  (8,9), (1..7,10), 'end some callable';

    submeth-ok  (^10),       (10,0),    (),     (^10), 'push none';
    submeth-ok  (^10),        (*,0),    (),     (^10), 'push none *';
    submeth-ok  (^10),     (*-@a,0),    (),     (^10), 'push none callable';
    submeth-ok  (^10), (10,0,10,11),    (),     (^12), 'push two';
    submeth-ok  (^10),  (*,0,10,11),    (),     (^12), 'push two *';
    submeth-ok  (^10),    (10,0,@a),    (), (^10,^10), 'push self';
    submeth-ok  (^10),     (*,0,@a),    (), (^10,^10), 'push self *';
    submeth-ok (2..9),    (0,0,0,1),    (),     (^10), 'unshift';
    submeth-ok  (^10),        (0,0),    (),     (^10), 'unshift none';
    submeth-ok  (^10),     (0,0,@a),    (), (^10,^10), 'unshift self';
    submeth-ok  (^10),    (0,10,@a), (^10),     (^10), 'replace self';

    submeth-ok (^10), (5,1,42), (5,), (^5,42,6..^10), 'replace 1 with 1';
    submeth-ok (^10), (5,1,^3), (5,), (^5,^3,6..^10), 'replace 1 with range';
    submeth-ok (^10),    (5,1), (5,),    (^5,6..^10), 'replace 1 with none';
    submeth-ok  (^9), (5,1,@a), (5,),  (^5,^9,6..^9), 'replace 1 with self';
    submeth-ok (^10), (5,0,42),   (), (^5,42,5..^10), 'replace none with 1';
    submeth-ok (^10), (5,0,^3),   (), (^5,^3,5..^10), 'replace none with range';
    submeth-ok (^10),    (5,0),   (),          (^10), 'replace none with none';
    submeth-ok  (^9), (5,0,@a),   (),  (^5,^9,5..^9), 'replace none with self';

#    submeth-ok (), (0,1), ($T,), (), 'remove 1 past end'
}

# splice4 gets "CxtItem _" or "CxtArray _" instead of "CxtSlurpy _"
# Test the identity of calls to splice:
{
    sub indirect_slurpy_context( *@got ) { @got };

    my @tmp = (1..10);
    my @a = splice @tmp, 5, 3;
    @a = indirect_slurpy_context( @a );
    @tmp = (1..10);
    my @b = indirect_slurpy_context( splice @tmp, 5, 3 );
    is( @b, @a, "Calling splice with immediate and indirect context returns consistent results");
    is( @a, [6,7,8], "Explicit call/assignment gives the expected results");
    is( @b, [6,7,8], "Implicit context gives the expected results"); # this is due to the method-fallback bug
} #3

{
    my @tmp = (1..10);
    my @a = item splice @tmp, 5, 3;
    is( @a, [6..8], "Explicit scalar context returns an array reference");
} #1

=finish

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
