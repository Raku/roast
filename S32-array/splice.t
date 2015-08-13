use v6;
use Test;

# L<S32::Containers/"Array"/"=item splice">

=begin description

This test tests the C<splice> builtin

=end description

sub splice-ok(\ret, \ret_exp, \rem, \rem_exp, Str $comment) {
    subtest {
        plan 4;
        is ret.WHAT, ret_exp.WHAT, 'return types match';
        is ret,      ret_exp,      'return results match';
        is rem.WHAT, rem_exp.WHAT, 'remainder types match';
        is rem,      rem_exp,      'remainder results match';
    }, $comment;
}

my       @Any;
my   int @int;
my  int8 @int8;
my int16 @int16;
my int32 @int32;
my int64 @int64;
my   Int @Int;
my   num @num;
my num32 @num32;
my num64 @num64;
my   Num @Num;

my @testing =
    $@Any, Array,
    $@int, array[int],
   $@int8, array[int8],
  $@int16, array[int16],
  $@int32, array[int32],
  $@int64, array[int64],
    $@Int, Array[Int],
#    $@num, array[num],  # breaks stuff :-(
#  $@num32, array[num],  # breaks stuff :-(
#  $@num64, array[num],  # breaks stuff :-(
#    $@Num, Array[Num],  # need way to handle named params in capture
;

plan (@testing/2 * 50) + 3 + 1 + 1 + 2 + 1;

for @testing -> @a, $T {
    my $toNum = @a.of ~~ Num;

    sub submeth-ok(\values,\params,\return,\remain,$comment){
        subtest {
            plan 2;

            if $toNum {
                @a = values.map(*.Num);

                my @params  = params;
                @params[$_] = @params[$_].Num for 2 .. @params.end;

                my $Treturn :=
                  return === Nil ?? Nil !! $T.new(return.list.map(*.Num));
                my $Tremain := $T.new(remain.list.map(*.Num));

                # sub
                splice-ok splice(@a,|@params), $Treturn, @a, $Tremain,
                  "$T.perl() sub: $comment";

                # method
                @a = values.map(*.Num);
                splice-ok @a.splice(|@params), $Treturn, @a, $Tremain,
                  "$T.perl() method: $comment";
            }

            else {
                @a = values;

                my $Treturn :=
                  return === Nil ?? Nil !! $T.new(return.list);
                my $Tremain := $T.new(remain.list);

                # sub
                splice-ok splice(@a,|params), $Treturn, @a, $Tremain,
                  "$T.perl() sub: $comment";

                # method
                @a = values;
                splice-ok @a.splice(|params), $Treturn, @a, $Tremain,
                  "$T.perl() method: $comment";
            }
        }, "$T.perl() $comment";
    }

#---------------------+--------+---------+----------+---------------------------
#                init | params |  return |   remain | comment
#---------------------+--------+---------+----------+---------------------------
    submeth-ok (1..10),      (),  (1..10),        (), 'whole';
    submeth-ok (1..12),   (0,1),     (1,),   (2..12), 'simple 1 elem';
    submeth-ok (1..10),   (8,2),   (9,10),    (1..8), 'simple 2 elems';
    submeth-ok (1..10),   <8 2>,   (9,10),    (1..8), 'simple 2 elems, as Str';
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

    submeth-ok (),     (0,1), (),    (), 'remove 1 past end';
    submeth-ok (), (0,1,1,2), (), (1,2), 'remove 1 past end + push';
    submeth-ok (), (0,*,1,2), (), (1,2), 'remove whatever past end + push';

    # test some SINKs
    submeth-ok (1..10),     \(:SINK),  Nil,      (), 'whole SINK';
    submeth-ok (1..12), \(0,1,:SINK),  Nil, (2..12), 'simple 1 elem SINK';
    submeth-ok (1..10),  \(10,:SINK),  Nil, (1..10), 'none rest SINK';

    # make sure we initialize with properly typed values
    @a = $toNum ?? (^10).map(*.Num) !! ^10;

    # splicing in an infinite list
    for 'splice @a,0,0,1..Inf', '@a.splice: 0,0,1..Inf' -> $code {
        throws-like $code, X::Cannot::Lazy, :action('splice in');
    }

    # offset out of range
    for 11, 11, -1, -1, '*-11', -1 -> $offset, $got {
        for "splice @a,$offset,1", "@a.splice: $offset,1" -> $code {
            throws-like $code, X::OutOfRange,
              :what("Offset argument to splice"),
              :$got,
              :range("0..10");
        }
    }

    # size out of range
    for -1, -1, '*-8', -1 -> $size, $got {
        for "splice @a,3,$size", "@a.splice: 3,$size" -> $code {
            throws-like $code, X::OutOfRange,
              :what("Size argument to splice"),
              :$got,
              :range("0..^7");
        }
    }
}

# wrong type
for @testing -> @a, $T {

    # make sure we initialize with properly typed values
    @a = @a.of ~~ Num ?? (^10).map(*.Num) !! ^10;

    if @a.of =:= Mu {   # can't be wrong, so don't test
        pass; pass;
    }

    else {
        for 'splice @a,0,0,"foo"', '@a.splice: 0,0,"foo"' -> $code {
            #?rakudo todo "somehow the test causes different typecheck error"
            throws-like $code, X::TypeCheck::Splice,
              :action<splice>,
              :got(Str),
              :expected($T.^name);
        }
    }
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

# RT #116897
{
    my @empty = ();
    my $i = 0;
    while splice(@empty, 0, 3) { $i++; last }
    is $i, 0, "'while (…splice…)' should neither hang nor even run";
} #1

# RT #125571
{
    my Int @a = 1, 2, 3;
    dies-ok { splice @a, 1, 1, 'not an integer'}, '&splice is type-safe';
    dies-ok { @a.splice(1, 1, 'not an integer')}, '.splice is type-safe';
} #2

# RT #119913
{
    my @l = 1..100;
    @l.splice( 5, *, "borrowed", "blue");
    is @l.join(" "), "1 2 3 4 5 borrowed blue", "Whatever splice"
} #1

# vim: ft=perl6
