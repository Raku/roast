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

plan (@testing/2 * 54) + 14;

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
                  return === Nil ?? Nil !! $T.new(|return.list);
                my $Tremain := $T.new(|remain.list);

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
    submeth-ok (1..10), (*-3,2),    (8,9), (flat 1..7,10), 'end some';
    submeth-ok (1..10), (*-3,*-1),  (8,9), (flat 1..7,10), 'end some callable';

    submeth-ok  (^10),       (10,0),    (),     (^10), 'push none';
    submeth-ok  (^10),        (*,0),    (),     (^10), 'push none *';
    submeth-ok  (^10),     (*-@a,0),    (),     (^10), 'push none callable';
    submeth-ok  (^10), (10,0,10,11),    (),     (^12), 'push two';
    submeth-ok  (^10),  (*,0,10,11),    (),     (^12), 'push two *';
    submeth-ok  (^10),    (10,0,@a),    (), (flat ^10,^10), 'push self';
    submeth-ok  (^10),     (*,0,@a),    (), (flat ^10,^10), 'push self *';
    submeth-ok (2..9),    (0,0,0,1),    (),     (^10), 'unshift';
    submeth-ok  (^10),        (0,0),    (),     (^10), 'unshift none';
    submeth-ok  (^10),     (0,0,@a),    (), (flat ^10,^10), 'unshift self';
    submeth-ok  (^10),    (0,10,@a), (^10),     (^10), 'replace self';

    submeth-ok (^10), (5,1,42), (5,), (flat ^5,42,6..^10), 'replace 1 with 1';
    submeth-ok (^10), (5,1,^3), (5,), (flat ^5,^3,6..^10), 'replace 1 with range';
    submeth-ok (^10),    (5,1), (5,),    (flat ^5,6..^10), 'replace 1 with none';
    submeth-ok  (^9), (5,1,@a), (5,),  (flat ^5,^9,6..^9), 'replace 1 with self';
    submeth-ok (^10), (5,0,42),   (), (flat ^5,42,5..^10), 'replace none with 1';
    submeth-ok (^10), (5,0,^3),   (), (flat ^5,^3,5..^10), 'replace none with range';
    submeth-ok (^10),    (5,0),   (),          (^10), 'replace none with none';
    submeth-ok  (^9), (5,0,@a),   (),  (flat ^5,^9,5..^9), 'replace none with self';

    submeth-ok (),     (0,1), (),    (), 'remove 1 past end';
    submeth-ok (), (0,1,1,2), (), (1,2), 'remove 1 past end + push';
    submeth-ok (), (0,*,1,2), (), (1,2), 'remove whatever past end + push';
    submeth-ok (1, 2, 3), (*, *), (), (1, 2, 3), 'two *, no list';
    submeth-ok (1, 2, 3), (*, *, 4, 5, 6), (), (^6+1), 'two * with a given list';

    # Callables
    my sub s-offset { ($^a / 2).Int }; my sub s-size   { $^a - 1 }
    submeth-ok (1, 2, 3, 4), (&s-offset, *),           (3, 4), (1, 2),        '.splice(Callable, Whatever)';
    submeth-ok (1, 2, 3, 4), (&s-offset, *, 42),       (3, 4), (1, 2, 42),    '.splice(Callable, Whatever, List)';
    submeth-ok (1, 2, 3, 4), (2, &s-size, 42),         (3,),   (1, 2, 42, 4), '.splice(Int, Callable, List)';
    submeth-ok (1, 2, 3, 4), (&s-offset, 1, 42),       (3,),   (1, 2, 42, 4), '.splice(Callable, Int, List)';
    submeth-ok (1, 2, 3, 4), (&s-offset, &s-size, 42), (3,),   (1, 2, 42, 4), '.splice(Callable, Callable, List)';

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

# RT #128736
{
    subtest 'splice can extend an array' => {
        my @a;
        @a.splice: 0, 0, 42;
        is-deeply @a, [42     ], 'method on empty array';

        @a.splice: 1, 0, 'y';
        is-deeply @a, [42, 'y'], 'method on array with elements';

        my @b;
        splice @b, 0, 0, 42;
        is-deeply @b, [42     ], 'sub with empty array';

        splice @b, 1, 0, 'y';
        is-deeply @b, [42, 'y'], 'sub with array with elements';
    }
}

# RT #129773
{
    lives-ok { [].splice: *, {42;}       }, 'splice(Whatever, Callable) lives';
    lives-ok { [].splice: *, {42;}, [42] }, 'splice(Whatever, Callable, @a) lives';
}

subtest 'Array.splice' => { # coverage; 2016-10-01
    constant @tests = # Args | Return | Result
        [ \(                 ), [1,2,3], []            ],
        [ \( *               ), [ ],     [1,2,3]       ],
        [ \( *,   *          ), [ ],     [1,2,3]       ],
        [ \( *,   *,  [4,5,6]), [ ],     [1,2,3,4,5,6] ],
        [ \( *,   2          ), [ ],     [1,2,3]       ],
        [ \( *,   2,  [4,5,6]), [ ],     [1,2,3,4,5,6] ],
        [ \( *,  {2}         ), [ ],     [1,2,3]       ],
        [ \( *,  {2}, [4,5,6]), [ ],     [1,2,3,4,5,6] ],
        [ \( *,   *,   4,5,6 ), [ ],     [1,2,3,4,5,6] ],
        [ \( *,   2,   4,5,6 ), [ ],     [1,2,3,4,5,6] ],
        [ \( *,  {2},  4,5,6 ), [ ],     [1,2,3,4,5,6] ],
        [ \({2}              ), [3],     [1,2]         ],
        [ \({2},  *          ), [3],     [1,2]         ],
        [ \({2},  *,  [4,5,6]), [3],     [1,2,4,5,6]   ],
        [ \({2},  1          ), [3],     [1,2]         ],
        [ \({2},  1,  [4,5,6]), [3],     [1,2,4,5,6]   ],
        [ \({2}, {1}         ), [3],     [1,2]         ],
        [ \({2}, {1}, [4,5,6]), [3],     [1,2,4,5,6]   ],
        [ \({2},  *,   4,5,6 ), [3],     [1,2,4,5,6]   ],
        [ \({2},  1,   4,5,6 ), [3],     [1,2,4,5,6]   ],
        [ \({2}, {1},  4,5,6 ), [3],     [1,2,4,5,6]   ],
        [ \( 2               ), [3],     [1,2]         ],
        [ \( 2,   *          ), [3],     [1,2]         ],
        [ \( 2,   *,  [4,5,6]), [3],     [1,2,4,5,6]   ],
        [ \( 2,   1          ), [3],     [1,2]         ],
        [ \( 2,   1,  [4,5,6]), [3],     [1,2,4,5,6]   ],
        [ \( 2,  {1}         ), [3],     [1,2]         ],
        [ \( 2,  {1}, [4,5,6]), [3],     [1,2,4,5,6]   ],
        [ \( 2,   *,   4,5,6 ), [3],     [1,2,4,5,6]   ],
        [ \( 2,   1,   4,5,6 ), [3],     [1,2,4,5,6]   ],
        [ \( 2,  {1},  4,5,6 ), [3],     [1,2,4,5,6]   ],
    ;

    plan 2*@tests;
    for @tests -> $t {
        my @a = 1, 2, 3;
        is-deeply @a.splice(|$t[0]), $t[1], "return correct for $t[0].gist()";
        is-deeply @a,                $t[2], "result correct for $t[0].gist()";
    }
}

subtest 'Array.splice callable args' => {
    constant @tests =
        [ ['hello world'.comb], 11, 5 ],
        [ ['deadbeaf'.comb], 8, 2 ],
        [ ['I H Perl 6'.comb], 10, 6 ],
        ;

    plan 4 * @tests;
    for @tests -> $t {
        my @a = |$t[0];
        @a.splice: { is-deeply $^a, $t[1], 'arg is correct for start'; $t[2] },
                   { is $^a, $t[1]-$t[2], 'arg is correct for offset'; 1 };

        my @b = |$t[0];
        splice(@b, { is-deeply $^a, $t[1], 'arg is correct for start'; $t[2] },
                   { is $^a, $t[1]-$t[2], 'arg is correct for offset'; 1 });
    }
}

subtest 'Array.splice can splice beyond end of Array' => {
    plan 8;
    my @a1 = <a b c d>;
    is-deeply @a1.splice(1, 10), [<b c d>], 'return value (non-lazy)';
    is-deeply @a1,               [<a>],     'result (non-lazy)';

    my @a2 = <a>, |lazy <b c d>;
    is-deeply @a2.splice(1, 10), [<b c d>], 'return value (lazy)';
    is-deeply @a2,               [<a>],     'result (lazy)';

    my @a3;
    is-deeply @a3.splice(0, 10), [],        'return value (uninitialized)';
    is-deeply @a3,               [],        'result (uninitialized)';

    my @a4 = ();
    is-deeply @a3.splice(0, 10), [],        'return value (empty)';
    is-deeply @a3,               [],        'result (empty)';
}

# vim: ft=perl6
