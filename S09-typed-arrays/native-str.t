use v6;
use Test;

plan 183;

# Basic native str array tests.
my $T := str;
my $t  = str.^name;
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
nok @arr.is-lazy , "Empty $t array is not lazy";

#?rakudo skip "non-existing str elements return null_s"
is @arr[5], "",   "Accessing non-existing on $t array gives empty string";
is @arr.elems, 0, "Elems do not grow just from an access on $t array";

is (@arr[0] = "a"), "a", "Can store string in an $t array";
is @arr[0], "a",  "Can get value from $t array";
is @arr.elems, 1, "The elems grew as expected on $t array";
ok @arr,          "$t array becomes truthy when it has an element";

is (@arr[1, 2] = "b","c"), ("b","c"), "Can slice-assign to an $t array";
is @arr[1], "b",   "Can get slice-assigned value from $t array (1)";
is @arr[2], "c",   "Can get slice-assigned value from $t array (2)";
is @arr.elems, 3,  "The elems grew as expected on $t array";
is @arr.end, 2,    "The end value matches grown elems on $t array";
is @arr.Int, 3,    "Int-ifies to grown number of elems on $t array";
is +@arr, 3,       "Numifies to grown number of elems on $t array";
nok @arr.is-lazy,  "$t array with values is not lazy";

is (@arr[10] = "z"), "z", "Can assign non-contiguously to $t array";
#?rakudo skip "non-existing str elements return null_s"
is @arr[  9],  "", "Elems before non-contiguous assign are \"\" on $t array";
is @arr[ 10], "z", "Non-contiguous assignment works on $t array";
is @arr[*-1], "z", "Can also get last element on $t array";

is (@arr = ()), (), "Can clear $t array by assigning empty list";
is @arr.elems, 0, "Cleared $t array has no elems";
is @arr.end, -1,  "Cleared $t array has end of -1";
is @arr.Int, 0,   "Cleared $t array Int-ifies to 0";
is +@arr, 0,      "Cleared $t array numifies to 0";
nok @arr,         "Cleared $t array is falsey";

is (@arr = "a".."z"), ("a".."z").List, "Can assign Str range to $t array";
is @arr.elems, 26, "Got correct elems from range assign on $t array";
is @arr[ 0], "a",  "Got correct element from range assign on $t array (1)";
is @arr[25], "z",  "Got correct element from range assign on $t array (2)";

ok  @arr[ 0]:exists, ":exists works on $t array (1)";
ok  @arr[25]:exists, ":exists works on $t array (2)";
nok @arr[26]:exists, ":exists works on $t array (3)";

is (@arr := array[$T].new("a")),"a",
  "Can call $t array constructor with a single value";
is @arr.elems, 1, "Correct number of elems set in constructor of $t array";
is @arr[0], "a",  "Correct element value set by constructor of $t array";

is (@arr := array[$T].new("m","e","a","t")), ("m","e","a","t"),
  "Can call $t array constructor with values";
is @arr.elems, 4, "Correct number of elems set in constructor of $t array";
is @arr[0], "m",  "Correct elem value set by constructor of $t array (1)";
is @arr[1], "e",  "Correct elem value set by constructor of $t array (2)";
is @arr[2], "a",  "Correct elem value set by constructor of $t array (3)";
is @arr[3], "t",  "Correct elem value set by constructor of $t array (4)";
is @arr[*-1,*-2], ("t","a"), "Can also get last 2 elements on $t array";

ok @arr.flat ~~ Seq, "$t array .flat returns a Seq";
ok @arr.eager === @arr, "$t array .eager returns identity";

diag qq:!a:!c/my $t \$s; for @arr { \$s ~= \$_ }; \$s/ if !
  is EVAL( qq:!a:!c/my $t \$s; for @arr { \$s ~= \$_ }; \$s/ ), "meat",
    "Can iterate over $t array";

$_++ for @arr;
is @arr[0], "n", "Mutating for loop on $t array works (1)";
is @arr[1], "f", "Mutating for loop on $t array works (2)";
is @arr[2], "b", "Mutating for loop on $t array works (3)";
is @arr[3], "u", "Mutating for loop on $t array works (4)";

is (@arr.map( { $_ ~= $_ })), ("nn","ff","bb","uu"), "Can map over $t array";
is @arr[0], "nn", "Mutating map on $t array works (1)";
is @arr[1], "ff", "Mutating map on $t array works (2)";
is @arr[2], "bb", "Mutating map on $t array works (3)";
is @arr[3], "uu", "Mutating map on $t array works (4)";

is @arr.grep(* le "ff").elems, 2, "Can grep a $t array";
is-deeply @arr.grep("uu"),      ("uu",),             "$t array.grep(Str)";
is-deeply @arr.grep("uu", :k),  (3,),                "$t array.grep(Str, :k)";
is-deeply @arr.grep("uu", :kv), (3,"uu"),            "$t array.grep(Str, :kv)";
is-deeply @arr.grep("uu", :p),  (Pair.new(3,"uu"),), "$t array.grep(Str, :p)";
is-deeply @arr.grep("uu", :v),  ("uu",),             "$t array.grep(Str, :v)";

is-deeply @arr.first("uu"),      "uu",             "$t array.grep(Str)";
is-deeply @arr.first("uu", :k),  3,                "$t array.grep(Str, :k)";
is-deeply @arr.first("uu", :kv), (3,"uu"),         "$t array.grep(Str, :kv)";
is-deeply @arr.first("uu", :p),  Pair.new(3,"uu"), "$t array.grep(Str, :p)";
is-deeply @arr.first("uu", :v),  "uu",             "$t array.grep(Str, :v)";

is ([~] @arr), "nnffbbuu", "Can use reduce meta-op on a $t array";

is @arr.values,            ("nn","ff","bb","uu"), ".values from a $t array";
is @arr.pairup,              (nn=>"ff",bb=>"uu"), ".pairup from a $t array";
is @arr.keys,                      ( 0, 1, 2, 3), ".keys from a $t array";
is @arr.pairs, (0=>"nn",1=>"ff",2=>"bb",3=>"uu"), ".pairs from a $t array";
is @arr.antipairs,     (nn=>0,ff=>1,bb=>2,uu=>3), ".antipairs from a $t array";
is @arr.kv,        (0,"nn",1,"ff",2,"bb",3,"uu"), ".kv from a $t array";
is @arr.pick,                "nn"|"ff"|"bb"|"uu", ".pick from a $t array";
is @arr.roll,                "nn"|"ff"|"bb"|"uu", ".roll from a $t array";

@arr[1] = @arr[0];
is-deeply @arr.unique, <nn bb uu>, "$t array.unique";
is-deeply @arr.repeated, ("nn",),  "$t array.repeated";
is-deeply @arr.squish, <nn bb uu>, "$t array.squish";

@arr = ();
throws-like { @arr.pop }, X::Cannot::Empty,
  action => 'pop',
  what   => "array[$t]",
  "Trying to pop an empty $t array dies";
throws-like { @arr.shift }, X::Cannot::Empty,
  action => 'shift',
  what   => "array[$t]",
  "Trying to shift an empty $t array dies";

is @arr.push("a"), ("a",), "can push to $t array";
is @arr.elems, 1, "push to $t array works (1)";
is @arr[0], "a",  "push to $t array works (2)";
# https://github.com/Raku/old-issue-tracker/issues/4223
throws-like { @arr.push(42) }, X::TypeCheck,
  got => Int,
  "Cannot push non-str/Str to $t array";
throws-like { @arr[0] := my $a }, Exception,
  "Cannot bind to $t array";
throws-like { @arr[0]:delete   }, Exception,
  "Cannot delete from $t array";

is (@arr.push("b","c")), ("a","b","c"),
  "can push multiple to $t array";
is @arr.elems, 3, "push multiple to $t array works (1)";
is @arr[1], "b",  "push multiple to $t array works (2)";
is @arr[2], "c",  "push multiple to $t array works (3)";
throws-like { @arr.push(42,66) }, Exception,
  "Cannot push non-str/Str to $t array (multiple push)";

is @arr.append("d"), ("a","b","c","d"), "can append to $t array";
is @arr.elems, 4, "append to $t array works (1)";
is @arr[3], "d",  "append to $t array works (2)";
throws-like { @arr.append(42) }, Exception,
  "Cannot append non-str/Str to $t array";

is (@arr.append("e","f")), ("a","b","c","d","e","f"),
  "can append multiple to $t array";
is @arr.elems, 6, "append multiple to $t array works (1)";
is @arr[4], "e",  "append multiple to $t array works (2)";
is @arr[5], "f",  "append multiple to $t array works (3)";
throws-like { @arr.append(42,666) }, Exception,
  "Cannot append non-str/Str to $t array (multiple append)";

is @arr.pop, "f", "pop from $t array works (1)";
is @arr.elems, 5, "pop from $t array works (2)";

is (@arr.unshift("z")), ("z","a","b","c","d","e"),
  "can unshift to $t array";
is @arr.elems, 6, "unshift to $t array works (1)";
is @arr[0], "z",  "unshift to $t array works (2)";
is @arr[1], "a",  "unshift to $t array works (3)";
# https://github.com/Raku/old-issue-tracker/issues/4223
throws-like { @arr.unshift(42) }, Exception,
  "Cannot unshift non-str/Str to $t array";

is (@arr.unshift("x","y")), ("x","y","z","a","b","c","d","e"),
  "can unshift multiple to $t array";
is @arr.elems, 8, "unshift multiple to $t array works (1)";
is @arr[0], "x",  "unshift multiple to $t array works (2)";
is @arr[1], "y",  "unshift multiple to $t array works (3)";
is @arr[2], "z",  "unshift multiple to $t array works (4)";
is @arr[3], "a",  "unshift multiple to $t array works (5)";
throws-like { @arr.unshift(42,666) }, Exception,
  "Cannot unshift non-str/Str to $t array (multiple unshift)";

is (@arr.prepend("w")), ("w","x","y","z","a","b","c","d","e"),
  "can prepend to $t array";
is @arr.elems, 9, "prepend to $t array works (1)";
is @arr[0], "w",  "prepend to $t array works (2)";
is @arr[1], "x",  "prepend to $t array works (3)";
throws-like { @arr.prepend(42) }, Exception,
  "Cannot prepend non-str/Str to $t array";

is (@arr.prepend("u","v")), ("u","v","w","x","y","z","a","b","c","d","e"),
  "can prepend multiple to $t array";
is @arr.elems, 11, "unshift multiple to $t array works (1)";
is @arr[0], "u", "prepend multiple to $t array works (2)";
is @arr[1], "v", "prepend multiple to $t array works (3)";
is @arr[2], "w", "prepend multiple to $t array works (4)";
is @arr[3], "x", "prepend multiple to $t array works (5)";
throws-like { @arr.prepend(42,666) }, Exception,
  "Cannot prepend non-str/Str to $t array (multiple unshift)";

is @arr.shift, "u", "shift from $t array works (1)";
is @arr.elems,  10, "shift from $t array works (2)";

is (@arr = "a".."j"), ("a".."j").List, "can initialize $t from Range";
my @replaced = @arr.splice(3, 2, "x","y","z");
is @arr.elems, 11, "Number of elems after splice $t array";
is @arr[2], "c", "Splice on $t array did the right thing (1)";
is @arr[3], "x", "Splice on $t array did the right thing (2)";
is @arr[4], "y", "Splice on $t array did the right thing (3)";
is @arr[5], "z", "Splice on $t array did the right thing (4)";
is @arr[6], "f", "Splice on $t array did the right thing (5)";
is @replaced.elems, 2, "Number of returned spliced values from $t array";
is @replaced[0], "d", "Correct value in splice returned from $t array (1)";
is @replaced[1], "e", "Correct value in splice returned from $t array (2)";

@arr = "a".."e";
is @arr.Str,  'a b c d e', ".Str space-separates on $t array";
is @arr.gist, '[a b c d e]', ".gist space-separates on $t array";
is @arr.raku, qq/array[$t].new("a", "b", "c", "d", "e")/,
  ".raku includes type and int values on $t array";

is-deeply @arr[^2], array[$T].new("a","b"), 'does slice return same type';
is-deeply @arr[my $ = ^2], "c", 'does slice handle containerized range';

my &ftest := EVAL qq:!c/sub ftest($t \$a, $t \$b) { \$a ~ \$b }/;
@arr = "a","h";
is ftest(|@arr), "ah", "Flattening $t array in call works";

@arr = "a".."e";
is @arr.join(":"), "a:b:c:d:e", "does join a $t array";

@arr = ();
@arr[4] = "z";
is @arr.join(":"), "::::z", "does emptying a $t array really empty";

my @holes := array[$T].new;
@holes[4] = "z";
is @holes.join(":"), "::::z", "does join handle holes in a $t array";

my @ssa := array[$T].new("a".."e");
my @ssb := array[$T].new("a".."e");
is @ssa ~~ @ssb, True, "Smartmatching same $t arrays works";

@ssb.push("z");
is @ssa ~~ @ssb, False, "Smartmatching different $t arrays works";

my @unsorted := array[$T].new("d","e","a","b","c");
is @unsorted.sort, "a b c d e", "Can we sort $t array";

@unsorted = "a","b";
is @unsorted.sort, "a b", "Can we sort 2-element sorted $t array";

@unsorted = "b","a";
is @unsorted.sort, "a b", "Can we sort 2-element unsorted $t array";

@unsorted = "a";
is @unsorted.sort, "a", "Can we sort 1-element $t array";

@unsorted = ();
is @unsorted.sort, "", "Can we sort 0-element $t array";

# Interaction of native int arrays and untyped arrays.
{
    my @native := array[$T].new("a".."j");
    my @untyped = @native;
    is @untyped.elems, 10, "List-assigning $t array to untyped works (1)";
    is @untyped[0], "a", "List-assigning $t array to untyped works (2)";
    is @untyped[9], "j", "List-assigning $t array to untyped works (3)";

    @untyped = flat "x", @native, "z";
    is @untyped.elems, 12, "List-assign $t array surrounded by literals (1)";
    is @untyped[ 0], "x", "List-assign $t array surrounded by literals (2)";
    is @untyped[ 5], "e", "List-assign $t array surrounded by literals (3)";
    is @untyped[10], "j", "List-assign $t array surrounded by literals (4)";
    is @untyped[11], "z", "List-assign $t array surrounded by literals (5)";
}

{
    my @untyped = "k".."t";
    my @native := array[$T].new;
    @native = @untyped;
    is @native.elems, 10, "List-assign untyped array of Str to $t array (1)";
    is @native[0], "k",   "List-assign untyped array of Str to $t array (2)";
    is @native[9], "t",   "List-assign untyped array of Str to $t array (3)";

    @untyped.push(42);
    throws-like { @native = @untyped }, Exception,
      "List-assigning incompatible untyped array to $t array dies";
}

# R#2912
{
    my @a;
    @a[1] = "b";
    my str @b = @a;
    is-deeply @b, (my str @ = "","b"), 'did we survive the hole';
}

# vim: expandtab shiftwidth=4
