use Test;

my @num = num, num32;
if $*KERNEL.bits == 64 {
    @num.push:  num64;
}

plan @num * 118;

# Basic native num array tests.
for @num -> $T {
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

    is @arr[5],  0e0, "Accessing non-existing on $t array gives 0";
    is @arr.elems, 0, "Elems do not grow just from an access on $t array";

    is_approx (@arr[0] = 4.2e0), 4.2e0, "Can store num in an $t array";
    is_approx @arr[0], 4.2e0, "Can get value from $t array";
    is @arr.elems, 1,  "The elems grew as expected on $t array";
    ok @arr,           "$t array becomes truthy when it has an element";

    @arr[1,2] = 6.9e0, 7.0e0;                     # cannot approx test Parcels
    is_approx @arr[1], 6.9e0, "Can get slice-assigned value from $t array (1)";
    is_approx @arr[2], 7.0e0, "Can get slice-assigned value from $t array (2)";
    is @arr.elems, 3,  "The elems grew as expected on $t array";
    is @arr.end,   2,  "The end value matches grown elems on $t array";
    is @arr.Int,   3,  "Int-ifies to grown number of elems on $t array";
    is +@arr,      3,  "Numifies to grown number of elems on $t array";
    nok @arr.infinite, "$t array with values is not infinite";

    is (@arr[^3] = NaN,-Inf,Inf), (NaN,-Inf,Inf),
      "are special IEEE values supported on $t array";

    is_approx (@arr[10] = 10.0e0), 10.0e0,
      "Can assign non-contiguously to $t array";
    is_approx @arr[  9],    0e0, "Elems non-contiguous assign 0 on $t array";
    is_approx @arr[ 10], 10.0e0, "Non-contiguous assignment works on $t array";
    is_approx @arr[*-1], 10.0e0, "Can also get last element on $t array";

    is (@arr = ()), (), "Can clear $t array by assigning empty list";
    is @arr.elems, 0, "Cleared $t array has no elems";
    is @arr.end,  -1, "Cleared $t array has end of -1";
    is @arr.Int,   0, "Cleared $t array Int-ifies to 0";
    is +@arr,      0, "Cleared $t array numifies to 0";
    nok @arr,         "Cleared $t array is falsey";

    @arr = 1e0..50e0;                             # cannot approx test Parcels
    is @arr.elems, 50, "Got correct elems from range assign on $t array";
    is_approx @arr[0],   1e0, "Correct elem from range assign on $t array (1)";
    is_approx @arr[49], 50e0, "Correct elem from range assign on $t array (2)";

    ok  @arr[ 0]:exists, ":exists works on $t array (1)";
    ok  @arr[49]:exists, ":exists works on $t array (2)";
    nok @arr[50]:exists, ":exists works on $t array (3)";

    @arr := array[$T].new(4.2e0);                 # cannot approx test Parcels
    is @arr.elems,  1, "Correct number of elems set in constructor of $t array";
    is_approx @arr[0], 4.2e0, "Correct elem set by constructor of $t array";

    @arr := array[$T].new(1.0e0, 1.5e0, 1.2e0);   # cannot approx test Parcels
    is @arr.elems,  3, "Correct number of elems set in constructor of $t array";
    is_approx @arr[0], 1.0e0, "Correct elem set by constructor of $t array (1)";
    is_approx @arr[1], 1.5e0, "Correct elem set by constructor of $t array (2)";
    is_approx @arr[2], 1.2e0, "Correct elem set by constructor of $t array (3)";
    @arr[*-1,*-2];                                # cannot approx test Parcels

    ok @arr.flat  === @arr, "$t array .flat returns identity";
    ok @arr.list  === @arr, "$t array .list returns identity";
    ok @arr.eager === @arr, "$t array .eager returns identity";

#?rakudo skip "borkedness with num and iteration"
{
    diag qq:!a:!c/my $t \$s = 0e0; for @arr { \$s += \$_ }; \$s/ if !
      is EVAL( qq:!a:!c/my $t \$s = 0e0; for @arr { \$s += \$_ }; \$s/ ), 3.7e0,
        "Can iterate over $t array";
}

    $_++ for @arr;
    is_approx @arr[0], 2.0e0, "Mutating for loop on $t array works (1)";
    is_approx @arr[1], 2.5e0, "Mutating for loop on $t array works (2)";
    is_approx @arr[2], 2.2e0, "Mutating for loop on $t array works (3)";

    @arr.map(* *= 2);                             # cannot approx test Parcels
    is_approx @arr[0], 4.0e0, "Mutating map on $t array works (1)";
    is_approx @arr[1], 5.0e0, "Mutating map on $t array works (2)";
    is_approx @arr[2], 4.4e0, "Mutating map on $t array works (3)";

    is @arr.grep(* < 4.5e0).elems, 2, "Can grep a $t array";
    is_approx ([+] @arr), 13.4e0, "Can use reduce meta-op on a $t array";

    @arr = ();
    throws_like { @arr.pop }, X::Cannot::Empty,
      action => '.pop',
      what   => "array[$t]",
      "Trying to pop an empty $t array dies";
    throws_like { @arr.shift }, X::Cannot::Empty,
      action => '.shift',
      what   => "array[$t]",
      "Trying to shift an empty $t array dies";
    throws_like { @arr[0] := my $a }, X::AdHoc,
      message => 'Cannot bind to a natively typed array',
      "Cannot push non-int/Int to $t array";
    throws_like { @arr[0]:delete }, X::AdHoc,
      message => 'Cannot delete from a natively typed array',
      "Cannot push non-int/Int to $t array";
    throws_like { @arr = 0e0..Inf }, X::Cannot::Infinite,
      action => 'initialize',
      what   => "array[$t]",
      "Trying to initialize a $t array with a right infinite list";
    throws_like { @arr = -Inf..0e0 }, X::Cannot::Infinite,
      action => 'initialize',
      what   => "array[$t]",
      "Trying to initialize a $t array with a left infinite list";

    @arr.push(4.2e0);                             # cannot approx test Parcels
    is @arr.elems, 1,  "push to $t array works (1)";
    is_approx @arr[0], 4.2e0, "push to $t array works (2)";
    throws_like { @arr.push('it real good') }, X::AdHoc,
      message => 'This type cannot unbox to a native number',
      "Cannot push non-num/Num to $t array";

    @arr.push(10.1e0, 10.5e0);                    # cannot approx test Parcels
    is @arr.elems, 3, "push multiple to $t array works (1)";
    is_approx @arr[1], 10.1e0,  "push multiple to $t array works (2)";
    is_approx @arr[2], 10.5e0,  "push multiple to $t array works (3)";
    throws_like { @arr.push('omg', 'wtf') }, X::AdHoc,
      message => 'This type cannot unbox to a native number',
      "Cannot push non-num/Num to $t array (multiple push)";

    is_approx @arr.pop, 10.5e0, "pop from $t array works (1)";
    is @arr.elems,    2, "pop from $t array works (2)";

    @arr.unshift(-1e0);                           # cannot approx test Parcels
    is @arr.elems,  3, "unshift to $t array works (1)";
    is_approx @arr[0],  -1e0, "unshift to $t array works (2)";
    is_approx @arr[1], 4.2e0, "unshift to $t array works (3)";
    throws_like { @arr.unshift('part of the day not working') }, X::AdHoc,
      message => 'This type cannot unbox to a native number',
      "Cannot unshift non-num/Num to $t array";

    @arr.unshift(-3e0,-2e0);                      # cannot approx test Parcels
    is @arr.elems,  5, "unshift multiple to $t array works (1)";
    is_approx @arr[0],  -3e0, "unshift multiple to $t array works (2)";
    is_approx @arr[1],  -2e0, "unshift multiple to $t array works (3)";
    is_approx @arr[2],  -1e0, "unshift multiple to $t array works (4)";
    is_approx @arr[3], 4.2e0, "unshift multiple to $t array works (5)";
    throws_like { @arr.unshift('wtf', 'bbq') }, X::AdHoc,
      message => 'This type cannot unbox to a native number',
      "Cannot unshift non-num/Num to $t array (multiple unshift)";

    is_approx @arr.shift, -3e0, "shift from $t array works (1)";
    is @arr.elems,    4, "shift from $t array works (2)";

    @arr = 1e0..10e0;                             # cannot approx test Parcels
    my @replaced = @arr.splice(3, 2, 98e0, 99e0, 100e0);
    is @arr.elems, 11, "Number of elems after splice $t array";
    is_approx @arr[2],   3e0, "Splice on $t array did the right thing (1)";
    is_approx @arr[3],  98e0, "Splice on $t array did the right thing (2)";
    is_approx @arr[4],  99e0, "Splice on $t array did the right thing (3)";
    is_approx @arr[5], 100e0, "Splice on $t array did the right thing (4)";
    is_approx @arr[6],   6e0, "Splice on $t array did the right thing (5)";
    is @replaced.elems, 2, "Number of returned spliced values from $t array";
    is_approx @replaced[0],  4e0, "Correct value in splice from $t array (1)";
    is_approx @replaced[1],  5e0, "Correct value in splice from $t array (2)";

    @arr = 1e0..5e0;                              # cannot approx test Parcels
    is @arr.Str,  '1 2 3 4 5', ".Str space-separates on $t array";
    is @arr.gist, '1 2 3 4 5', ".gist space-separates on $t array";
    is @arr.perl, "array[$t].new(1e0, 2e0, 3e0, 4e0, 5e0)",
      ".perl includes type and num values on $t array";

    my &ftest := EVAL qq:!c/sub ftest($t \$a, $t \$b) { \$a + \$b }/;
    @arr = 3.9e0, 0.3e0;
    is_approx ftest(|@arr), 4.2e0, "Flattening $t array in call works";

    # Interaction of native num arrays and untyped arrays.
    my @native := array[$T].new(1e0..10e0);

    my @untyped = @native;
    is @untyped.elems,        10, "List-assign $t array to untyped works (1)";
    is_approx @untyped[0],   1e0, "List-assign $t array to untyped works (2)";
    is_approx @untyped[9],  10e0, "List-assign $t array to untyped works (3)";

    @untyped = 0e0, @native, 11e0;
    is @untyped.elems, 12,        "List-assign $t array surrounded by lits (1)";
    is_approx @untyped[0],   0e0, "List-assign $t array surrounded by lits (2)";
    is_approx @untyped[5],   5e0, "List-assign $t array surrounded by lits (3)";
    is_approx @untyped[10], 10e0, "List-assign $t array surrounded by lits (4)";
    is_approx @untyped[11], 11e0, "List-assign $t array surrounded by lits (5)";

    my @untyped2 = 21e0..30e0;
    my @native2 := array[$T].new;
    @native2 = @untyped2;
    is @native2.elems,        10, "List-assign array of Num to $t array (1)";
    is_approx @native2[0],  21e0, "List-assign array of Num to $t array (2)";
    is_approx @native2[9],  30e0, "List-assign array of Num to $t array (3)";

    @untyped2.push('C-C-C-C-Combo Breaker!');
    throws_like { @native2 = @untyped2 }, X::AdHoc,
      message => 'This type cannot unbox to a native number',
      "List-assigning incompatible untyped array to $t array dies";
}
