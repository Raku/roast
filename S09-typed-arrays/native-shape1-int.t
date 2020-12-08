use v6;
use Test;

my @int  =  int, int8, int16, int32;
my @uint = uint,uint8,uint16,uint32;
if $*KERNEL.bits == 64 {
    @int.push:   int64;
    @uint.push: uint64;
}

plan (@int + @uint) * 111;

# Basic native int array tests.
for flat @int,@uint -> $T {
    my $t = $T.^name;
    diag "Testing $t array";

    ok array[$T].new(:shape(5)) ~~ Positional,     "$t array is Positional";
    #?rakudo todo 'apparently it is not a typed Positional'
    ok array[$T].new(:shape(5)) ~~ Positional[$T], "$t array is Positional[$t]";
    ok array[$T].new(:shape(5)).of === $T,         "$t array .of is $t";

    my @a := EVAL "my $t @[5]";
    ok @a ~~ Positional,         "$t array is Positional";
    #?rakudo todo 'apparently it is not a typed Positional'
    ok @a ~~ Positional[$T],     "$t array is Positional[$t]";
    ok @a.of === $T,             "$t array .of is $t";
    ok @a.new ~~ Positional,     ".new from $t array is Positional";
    #?rakudo todo 'apparently it is not a typed Positional'
    ok @a.new ~~ Positional[$T], ".new from $t array Positional[$t]";
    ok @a.new.of === $T,         ".new from $t array .of is $t";

    my @arr := array[$T].new(:shape(5));
    is @arr.elems,  5, "New $t array has 5 elems";
    is @arr.end,    4, "New $t array has end of -1";
    is @arr.Int,    5, "New $t array Int-ifies to 5";
    is +@arr,       5, "New $t array numifies to 5";
    nok @arr.is-lazy , "Empty $t array is not lazy";

    dies-ok { @arr[5] }, "Accessing non-existing on $t array dies";
    is @arr.elems, 5, "Elems do not grow just from an access on $t array";

    is (@arr[0] = 42), 42, "Can store integer in an $t array with Int index";
    is @arr[0], 42, "Can get value from $t array with Int index";

    my int $i;
    is (@arr[$i] = 66), 66, 'can store integer in an $t array with int index';
    is @arr[$i], 66, "Can get value from $t array with int index";

    is (@arr[1, 2] = 69, 70), (69,70), "Can slice-assign to an $t array";
    is @arr[1], 69, "Can get slice-assigned value from $t array (1)";
    is @arr[2], 70, "Can get slice-assigned value from $t array (2)";

    ok  @arr[$i]:exists, ":exists works on $t array with int index";
    ok  @arr[4]:exists, ":exists works on $t array with Int index";
    nok @arr[5]:exists, ":exists works on $t array when out of range";

    nok @arr[$i]:!exists, ":!exists works on $t array with int index";
    nok @arr[4]:!exists, ":!exists works on $t array with Int index";
    ok  @arr[5]:!exists, ":!exists works on $t array when out of range";

    dies-ok { @arr[$i]:delete }, ":delete dies on $t array with int index";
    dies-ok { @arr[0]:delete }, ":delete dies on $t array with Int index";
    is @arr[$i]:!delete, 66, ":!delete works on $t array with int index";
    is @arr[0]:!delete, 66, ":!delete works on $t array with Int index";

    is (@arr := array[$T].new(:shape(1), 42)), 42,
      "Can call $t array constructor with a single value";
    is @arr.elems, 1, "Correct number of elems set in constructor of $t array";
    is @arr[0], 42,   "Correct element value set by constructor of $t array";

    is (@arr := array[$T].new(:shape(4),10, 15, 12,16)), (10,15,12,16),
      "Can call $t array constructor with values";
    is @arr.elems, 4, "Correct number of elems set in constructor of $t array";
    is @arr[0], 10,   "Correct elem value set by constructor of $t array (1)";
    is @arr[1], 15,   "Correct elem value set by constructor of $t array (2)";
    is @arr[2], 12,   "Correct elem value set by constructor of $t array (3)";
    is @arr[3], 16,   "Correct elem value set by constructor of $t array (4)";
    is @arr[*-1,*-2], (16,12), "Can also get last 2 elements on $t array";

    ok @arr.flat ~~ Seq, "$t array .flat returns a Seq";
    ok @arr.eager === @arr, "$t array .eager returns identity";

    $_++ for @arr;
    is @arr[0], 11, "Mutating for loop on $t array works (1)";
    is @arr[1], 16, "Mutating for loop on $t array works (2)";
    is @arr[2], 13, "Mutating for loop on $t array works (3)";
    is @arr[3], 17, "Mutating for loop on $t array works (4)";

    is (@arr.map(* *= 2)), (22,32,26,34), "Can map over $t array";
    is @arr[0], 22, "Mutating map on $t array works (1)";
    is @arr[1], 32, "Mutating map on $t array works (2)";
    is @arr[2], 26, "Mutating map on $t array works (3)";
    is @arr[3], 34, "Mutating map on $t array works (4)";

    is @arr.grep(* < 30).elems, 2, "grep a $t array";
    is-deeply @arr.grep(34),      (34,),             "$t array.grep(Int)";
    is-deeply @arr.grep(34, :k),  (3,),              "$t array.grep(Int, :k)";
    is-deeply @arr.grep(34, :kv), (3,34),            "$t array.grep(Int, :kv)";
    is-deeply @arr.grep(34, :p),  (Pair.new(3,34),), "$t array.grep(Int, :p)";
    is-deeply @arr.grep(34, :v),  (34,),             "$t array.grep(Int, :v)";

    is-deeply @arr.first(34),      34,             "$t array.grep(Int)";
    is-deeply @arr.first(34, :k),  3,              "$t array.grep(Int, :k)";
    is-deeply @arr.first(34, :kv), (3,34),         "$t array.grep(Int, :kv)";
    is-deeply @arr.first(34, :p),  Pair.new(3,34), "$t array.grep(Int, :p)";
    is-deeply @arr.first(34, :v),  34,             "$t array.grep(Int, :v)";

    is ([+] @arr), 114, "Can use reduce meta-op on a $t array";

    is @arr.values,                (22,32,26,34), ".values from a $t array";
    is @arr.pairup,              (22=>32,26=>34), ".pairup from a $t array";
    is @arr.keys,                  ( 0, 1, 2, 3), ".keys from a $t array";
    is @arr.pairs,     (0=>22,1=>32,2=>26,3=>34), ".pairs from a $t array";
    is @arr.antipairs, (22=>0,32=>1,26=>2,34=>3), ".antipairs from a $t array";
    is @arr.kv,            (0,22,1,32,2,26,3,34), ".kv from a $t array";
    is @arr.pick,                    22|32|26|34, ".pick from a $t array";
    is @arr.roll,                    22|32|26|34, ".roll from a $t array";

    @arr[1] = @arr[0];
    is-deeply @arr.unique, (22,26,34), "$t array.unique";
    is-deeply @arr.repeated, (22,),    "$t array.repeated";
    is-deeply @arr.squish, (22,26,34), "$t array.squish";

    dies-ok { @arr.pop },         "Trying to pop a shaped $t array dies";
    dies-ok { @arr.shift },       "Trying to shift a shaped $t array dies";
    dies-ok { @arr.push(42) },    "Trying to push a shaped $t array dies";
    dies-ok { @arr.unshift(42) }, "Trying to unshift a shaped $t array dies";
    dies-ok { @arr[0] := my $a }, "Cannot bind to a $t array";
    dies-ok { @arr[0]:delete },   "Cannot delete from a $t array";
    dies-ok { @arr.append(66) },  "Cannot append to a $t array";
    dies-ok { @arr.prepend(66) }, "Cannot prepend to a $t array";
    dies-ok { @arr.splice },      "Cannot splice to a $t array";

    @arr = 1..4;
    is @arr.Str,  '1 2 3 4',   ".Str space-separates on $t array";
    is @arr.gist, '[1 2 3 4]', ".gist space-separates on $t array";
    is @arr.raku, "array[$t].new(:shape(4,), [1, 2, 3, 4])",
      ".raku includes type and int values on $t array";

    #?rakudo skip 'STORE not working correctly yet)'
    is-deeply @arr[^2], (1,2), 'does slice return correctly';
    is-deeply @arr[my $ = ^2], 3, 'does slice handle containerized range';

    is @arr.join(":"), "1:2:3:4", "does join a $t array";

    is (@arr = ()), "0 0 0 0", "Can clear $t array by assigning empty list";
    is @arr.join(":"), "0:0:0:0", "does emptying a $t array reset";
    @arr = 42,66;
    is @arr.join(":"), "42:66:0:0", "does re-initializing a $t array work";

    # Interaction of native shaped int arrays and untyped arrays.
    my @native := array[$T].new(:shape(10),1..10);
    my @untyped = @native;
    is @untyped.elems, 10, "List-assigning $t array to untyped works (1)";
    is @untyped[0], 1, "List-assigning $t array to untyped works (2)";
    is @untyped[9], 10, "List-assigning $t array to untyped works (3)";

    @untyped = flat 0, @native, 11;
    is @untyped.elems, 12, "List-assign $t array surrounded by literals (1)";
    is @untyped[ 0],  0, "List-assign $t array surrounded by literals (2)";
    is @untyped[ 5],  5, "List-assign $t array surrounded by literals (3)";
    is @untyped[10], 10, "List-assign $t array surrounded by literals (4)";
    is @untyped[11], 11, "List-assign $t array surrounded by literals (5)";

    my @untyped2 = 21..30;
    my @native2 := array[$T].new(:shape(10));
    @native2 = @untyped2;
    is @native2.elems, 10, "List-assign untyped array of Int to $t array (1)";
    is @native2[0], 21, "List-assign untyped array of Int to $t array (2)";
    is @native2[9], 30, "List-assign untyped array of Int to $t array (3)";

    @untyped2[9] = 'C-C-C-C-Combo Breaker!';
    throws-like { @native2 = @untyped2 }, Exception,
      "List-assigning incompatible untyped array to $t array dies";

    my @ssa := array[$T].new(:shape(10),1..10);
    my @ssb := array[$T].new(:shape(10),1..10);
    is @ssa ~~ @ssb, True, "Smartmatching same $t arrays works";

    is array[$T].new(:shape(5),4,5,1,2,3).sort, "1 2 3 4 5",
      "Can we sort $t array";

    is array[$T].new(:shape(2),2,1).sort, "1 2",
      "Can we sort 2-element sorted $t array";

    is array[$T].new(:shape(1),1).sort, "1",
      "Can we sort 1-element sorted $t array";
}

# vim: expandtab shiftwidth=4
