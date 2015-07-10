use v6;
use Test;

# L<S32::Containers/"Array"/"=item splice">

=begin description

This test tests the C<splice> builtin

=end description

plan (3*45) + (2*1) + 3 + 1 + 1;

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
my num @num;
my Num @Num;

for
    $@Any,      Array, False
  , $@int, array[int], False
  , $@Int, Array[Int], False
#  , $@num, array[num],  True
#  , $@Num, Array[Num],  True
-> @a, $T, $toNum {

    sub submeth-ok(\values,\params,\return,\remain,$comment){
        subtest {
            plan 2;

            if $toNum {
                my @params  = params;
                @params[$_] = @params[$_].Num for 2 .. @params.end;

                my $Treturn := $T.new(return.list.map(*.Num));
                my $Tremain := $T.new(remain.list.map(*.Num));

                # sub
                @a = values.map(*.Num);
                splice-ok splice(@a,|@params), $Treturn, @a, $Tremain,
                  "$T.perl() sub: $comment";

                # method
                @a = values.map(*.Num);
                splice-ok @a.splice(|@params), $Treturn, @a, $Tremain,
                  "$T.perl() method: $comment";
            }

            else {
                my $Treturn := $T.new(return.list);
                my $Tremain := $T.new(remain.list);

                # sub
                @a = values;
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

    @a = ^10;

    # splicing in an infinite list
    for 'splice @a,0,0,1..Inf', '@a.splice: 0,0,1..Inf' -> $code {
        throws-like $code, X::Cannot::Infinite, :action('splice in');
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
for $@int, array[int], $@Int, Array[Int] -> @a, $T {
#for $@Int, Array[Int] -> @a, $T {
    @a = ^10;
    #?rakudo todo "somehow the test causes different typecheck error"
    throws-like 'splice @a,0,0,"foo"', X::TypeCheck::Splice,
      :action<splice>,
      :got(Str),
      :expected($T);
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

# vim: ft=perl6
