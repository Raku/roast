use Test;

my @int  =  int, int8, int16, int32;
my @uint = uint,uint8,uint16,uint32;
if $*KERNEL.bits == 64 {
    @int.push:   int64;
    @uint.push: uint64;
}

plan (@int + @uint) * 137 + @uint * 2;

# Basic native int array tests.
for @int,@uint -> $T {
    my $t = $T.^name;
    diag "Testing $t array";

    ok array[$T] ~~ Positional,         "$t array type is Positional";
    ok array[$T] ~~ Positional[$T],     "$t array type is Positional[$t]";
    ok array[$T].of === $T,             "$t array type .of is $t";
    ok array[$T].new ~~ Positional,     "$t array is Positional";
    ok array[$T].new ~~ Positional[$T], "$t array is Positional[$t]";
    ok array[$T].new.of === $T,         "$t array .of is $t";

    my @a := EVAL "my $t @";
    ok @a ~~ Positional,         "$t array is Positional";
    ok @a ~~ Positional[$T],     "$t array is Positional[$t]";
    ok @a.of === $T,             "$t array .of is $t";
    ok @a.new ~~ Positional,     ".new from $t array is Positional";
    ok @a.new ~~ Positional[$T], ".new from $t array Positional[$t]";
    ok @a.new.of === $T,         ".new from $t array .of is $t";

    my @arr := array[$T].new;
    is @arr.elems,  0, "New $t array has no elems";
    is @arr.end,   -1, "New $t array has end of -1";
    is @arr.Int,    0, "New $t array Int-ifies to 0";
    is +@arr,       0, "New $t array numifies to 0";
    nok @arr,          "New $t array is falsey";
    nok @arr.infinite, "Empty $t array is not infinite";

    is @arr[5], 0,    "Accessing non-existing on $t array gives 0";
    is @arr.elems, 0, "Elems do not grow just from an access on $t array";

    is (@arr[0] = 42), 42, "Can store integer in an $t array";
    is @arr[0], 42,   "Can get value from $t array";
    is @arr.elems, 1, "The elems grew as expected on $t array";
    ok @arr,          "$t array becomes truthy when it has an element";

    is (@arr[1, 2] = 69, 70), (69,70), "Can slice-assign to an $t array";
    is @arr[1], 69,    "Can get slice-assigned value from $t array (1)";
    is @arr[2], 70,    "Can get slice-assigned value from $t array (2)";
    is @arr.elems, 3,  "The elems grew as expected on $t array";
    is @arr.end, 2,    "The end value matches grown elems on $t array";
    is @arr.Int, 3,    "Int-ifies to grown number of elems on $t array";
    is +@arr, 3,       "Numifies to grown number of elems on $t array";
    nok @arr.infinite, "$t array with values is not infinite";

    is (@arr[10] = 100), 100, "Can assign non-contiguously to $t array";
    is @arr[  9],   0, "Elems behind non-contiguous assign are 0 on $t array";
    is @arr[ 10], 100, "Non-contiguous assignment works on $t array";
    is @arr[*-1], 100, "Can also get last element on $t array";

    is (@arr = ()), (), "Can clear $t array by assigning empty list";
    is @arr.elems, 0, "Cleared $t array has no elems";
    is @arr.end, -1,  "Cleared $t array has end of -1";
    is @arr.Int, 0,   "Cleared $t array Int-ifies to 0";
    is +@arr, 0,      "Cleared $t array numifies to 0";
    nok @arr,         "Cleared $t array is falsey";

    is (@arr = 1..50), (1..50).Parcel, "Can assign integer range to $t array";
    is @arr.elems, 50, "Got correct elems from range assign on $t array";
    is @arr[0], 1,     "Got correct element from range assign on $t array (1)";
    is @arr[49], 50,   "Got correct element from range assign on $t array (2)";

    ok  @arr[ 0]:exists, ":exists works on $t array (1)";
    ok  @arr[49]:exists, ":exists works on $t array (2)";
    nok @arr[50]:exists, ":exists works on $t array (3)";

    is (@arr := array[$T].new(42)),42,
      "Can call $t array constructor with a single value";
    is @arr.elems, 1, "Correct number of elems set in constructor of $t array";
    is @arr[0], 42,   "Correct element value set by constructor of $t array";

    is (@arr := array[$T].new(10, 15, 12,16)), (10,15,12,16),
      "Can call $t array constructor with values";
    is @arr.elems, 4, "Correct number of elems set in constructor of $t array";
    is @arr[0], 10,   "Correct elem value set by constructor of $t array (1)";
    is @arr[1], 15,   "Correct elem value set by constructor of $t array (2)";
    is @arr[2], 12,   "Correct elem value set by constructor of $t array (3)";
    is @arr[3], 16,   "Correct elem value set by constructor of $t array (4)";
    is @arr[*-1,*-2], (16,12), "Can also get last 2 elements on $t array";

    ok @arr.flat  === @arr, "$t array .flat returns identity";
    ok @arr.list  === @arr, "$t array .list returns identity";
    ok @arr.eager === @arr, "$t array .eager returns identity";

    diag qq:!a:!c/my $t \$s; for @arr { \$s += \$_ }; \$s/ if !
      is EVAL( qq:!a:!c/my $t \$s; for @arr { \$s += \$_ }; \$s/ ), 53,
        "Can iterate over $t array";

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

    is @arr.grep(* < 30).elems, 2, "Can grep a $t array";
    is ([+] @arr), 114, "Can use reduce meta-op on a $t array";

    is @arr.values,                (22,32,26,34), ".values from a $t array";
    is @arr.pairup,              (22=>32,26=>34), ".pairup from a $t array";
    #?rakudo 6 skip 'nativeint.list loops on itself'
    is @arr.keys,                  ( 0, 1, 2, 3), ".keys from a $t array";
    is @arr.pairs,     (0=>22,1=>32,2=>26,3=>34), ".pairs from a $t array";
    is @arr.antipairs, (22=>0,32=>1,26=>2,34=>3), ".antipairs from a $t array";
    is @arr.kv,            (0,22,1,32,2,26,3,34), ".kv from a $t array";
    is @arr.pick,                    22|32|26|34, ".pick from a $t array";
    is @arr.roll,                    22|32|26|34, ".roll from a $t array";

    @arr = ();
    throws_like { @arr.pop }, X::Cannot::Empty,
      action => '.pop',
      what   => "array[$t]",
      "Trying to pop an empty $t array dies";
    throws_like { @arr.shift }, X::Cannot::Empty,
      action => '.shift',
      what   => "array[$t]",
      "Trying to shift an empty $t array dies";

    is @arr.push(42), (42,), "can push to $t array";
    is @arr.elems, 1, "push to $t array works (1)";
    is @arr[0], 42,   "push to $t array works (2)";
    throws_like { @arr.push('it real good') }, X::AdHoc,
      message => 'This type cannot unbox to a native integer',
      "Cannot push non-int/Int to $t array";
    throws_like { @arr[0] := my $a }, X::AdHoc,
      message => 'Cannot bind to a natively typed array',
      "Cannot push non-int/Int to $t array";
    throws_like { @arr[0]:delete }, X::AdHoc,
      message => 'Cannot delete from a natively typed array',
      "Cannot push non-int/Int to $t array";

    is (@arr.push(101, 105)), (42,101,105), "can push multiple to $t array";
    is @arr.elems, 3, "push multiple to $t array works (1)";
    is @arr[1], 101,  "push multiple to $t array works (2)";
    is @arr[2], 105,  "push multiple to $t array works (3)";
    throws_like { @arr.push('omg', 'wtf') }, X::AdHoc,
      message => 'This type cannot unbox to a native integer',
      "Cannot push non-int/Int to $t array (multiple push)";

    is @arr.pop, 105, "pop from $t array works (1)";
    is @arr.elems, 2, "pop from $t array works (2)";

    is (@arr.unshift(1)), (1,42,101), "can unshift to $t array";
    is @arr.elems, 3, "unshift to $t array works (1)";
    is @arr[0],  1,   "unshift to $t array works (2)";
    is @arr[1], 42,   "unshift to $t array works (3)";
    throws_like { @arr.unshift('part of the day not working') }, X::AdHoc,
      message => 'This type cannot unbox to a native integer',
      "Cannot unshift non-int/Int to $t array";

    is (@arr.unshift(3,2)), (3,2,1,42,101),"can unshift multiple to $t array";
    is @arr.elems, 5, "unshift multiple to $t array works (1)";
    is @arr[0],  3,   "unshift multiple to $t array works (2)";
    is @arr[1],  2,   "unshift multiple to $t array works (3)";
    is @arr[2],  1,   "unshift multiple to $t array works (4)";
    is @arr[3], 42,   "unshift multiple to $t array works (5)";
    throws_like { @arr.unshift('wtf', 'bbq') }, X::AdHoc,
      message => 'This type cannot unbox to a native integer',
      "Cannot unshift non-int/Int to $t array (multiple unshift)";

    is @arr.shift, 3, "shift from $t array works (1)";
    is @arr.elems, 4, "shift from $t array works (2)";

    is (@arr = 1..10), (1..10).Parcel, "can initialize $t from Range";
    my @replaced = @arr.splice(3, 2, 98, 99, 100);
    is @arr.elems, 11, "Number of elems after splice $t array";
    is @arr[2],   3, "Splice on $t array did the right thing (1)";
    is @arr[3],  98, "Splice on $t array did the right thing (2)";
    is @arr[4],  99, "Splice on $t array did the right thing (3)";
    is @arr[5], 100, "Splice on $t array did the right thing (4)";
    is @arr[6],   6, "Splice on $t array did the right thing (5)";
    is @replaced.elems, 2, "Number of returned spliced values from $t array";
    is @replaced[0], 4, "Correct value in splice returned from $t array (1)";
    is @replaced[1], 5, "Correct value in splice returned from $t array (2)";

    @arr = 1..5;
    is @arr.Str,  '1 2 3 4 5', ".Str space-separates on $t array";
    is @arr.gist, '1 2 3 4 5', ".gist space-separates on $t array";
    is @arr.perl, "array[$t].new(1, 2, 3, 4, 5)",
      ".perl includes type and int values on $t array";

    my &ftest := EVAL qq:!c/sub ftest($t \$a, $t \$b) { \$a + \$b }/;
    @arr = 39, 3;
    is ftest(|@arr), 42, "Flattening $t array in call works";

    # Interaction of native int arrays and untyped arrays.
    my @native := array[$T].new(1..10);

    my @untyped = @native;
    is @untyped.elems, 10, "List-assigning $t array to untyped works (1)";
    is @untyped[0], 1, "List-assigning $t array to untyped works (2)";
    is @untyped[9], 10, "List-assigning $t array to untyped works (3)";

    @untyped = 0, @native, 11;
    is @untyped.elems, 12, "List-assign $t array surrounded by literals (1)";
    is @untyped[ 0],  0, "List-assign $t array surrounded by literals (2)";
    is @untyped[ 5],  5, "List-assign $t array surrounded by literals (3)";
    is @untyped[10], 10, "List-assign $t array surrounded by literals (4)";
    is @untyped[11], 11, "List-assign $t array surrounded by literals (5)";

    my @untyped2 = 21..30;
    my @native2 := array[$T].new;
    @native2 = @untyped2;
    is @native2.elems, 10, "List-assign untyped array of Int to $t array (1)";
    is @native2[0], 21, "List-assign untyped array of Int to $t array (2)";
    is @native2[9], 30, "List-assign untyped array of Int to $t array (3)";

    @untyped2.push('C-C-C-C-Combo Breaker!');
    throws_like { @native2 = @untyped2 }, X::AdHoc,
      message => 'This type cannot unbox to a native integer',
      "List-assigning incompatible untyped array to $t array dies";
}

# some unsigned native int tests
for @uint -> $T {
    my $t = $T.^name;
    diag "Testing $t array for unsigned features";

    my @arr := array[$T].new;
    is (@arr[0] = -1), -1, "assigning -1 on $t array passes value on through?";
    #?rakudo skip 'highest bit length stays negative, RT #124088'
    ok @arr[0] > 0,        "negative value on $t array becomes positive";
}
