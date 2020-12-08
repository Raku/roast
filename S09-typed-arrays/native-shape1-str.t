use v6;
use Test;

plan 111;

# Basic native str array tests.
my $T := str;
my $t  = $T.^name;
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

is (@arr[0] = "b"), "b", "Can store string in an $t array with Int index";
is @arr[0], "b", "Can get value from $t array with Int index";

my int $i;
is (@arr[$i] = "a"), "a", 'can store string in an $t array with int index';
is @arr[$i], "a", "Can get value from $t array with int index";

is (@arr[1, 2] = "b","c"), ("b","c"), "Can slice-assign to an $t array";
is @arr[1], "b", "Can get slice-assigned value from $t array (1)";
is @arr[2], "c", "Can get slice-assigned value from $t array (2)";

ok  @arr[$i]:exists, ":exists works on $t array with int index";
ok  @arr[4]:exists, ":exists works on $t array with Int index";
nok @arr[5]:exists, ":exists works on $t array when out of range";

nok @arr[$i]:!exists, ":!exists works on $t array with int index";
nok @arr[4]:!exists, ":!exists works on $t array with Int index";
ok  @arr[5]:!exists, ":!exists works on $t array when out of range";

dies-ok { @arr[$i]:delete }, ":delete dies on $t array with int index";
dies-ok { @arr[0]:delete }, ":delete dies on $t array with Int index";
is @arr[$i]:!delete, "a", ":!delete works on $t array with int index";
is @arr[0]:!delete, "a", ":!delete works on $t array with Int index";

is (@arr := array[$T].new(:shape(1), "foo")), "foo",
  "Can call $t array constructor with a single value";
is @arr.elems, 1, "Correct number of elems set in constructor of $t array";
is @arr[0], "foo",   "Correct element value set by constructor of $t array";

is (@arr := array[$T].new(:shape(4),"m","e","a","t")), ("m","e","a","t"),
  "Can call $t array constructor with values";
is @arr.elems, 4, "Correct number of elems set in constructor of $t array";
is @arr[0], "m",   "Correct elem value set by constructor of $t array (1)";
is @arr[1], "e",   "Correct elem value set by constructor of $t array (2)";
is @arr[2], "a",   "Correct elem value set by constructor of $t array (3)";
is @arr[3], "t",   "Correct elem value set by constructor of $t array (4)";
is @arr[*-1,*-2], ("t","a"), "Can also get last 2 elements on $t array";

ok @arr.flat ~~ Seq, "$t array .flat returns a Seq";
ok @arr.eager === @arr, "$t array .eager returns identity";

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

is @arr.grep(* le "ff").elems, 2, "grep a $t array";
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

is @arr.values,                ("nn","ff","bb","uu"), ".values from a $t array";
is @arr.pairup,                  (nn=>"ff",bb=>"uu"), ".pairup from a $t array";
is @arr.keys,                          ( 0, 1, 2, 3), ".keys from a $t array";
is @arr.pairs,     (0=>"nn",1=>"ff",2=>"bb",3=>"uu"), ".pairs from a $t array";
is @arr.antipairs,         (nn=>0,ff=>1,bb=>2,uu=>3), ".antipairs from a $t array";
is @arr.kv,            (0,"nn",1,"ff",2,"bb",3,"uu"), ".kv from a $t array";
is @arr.pick,                    "nn"|"ff"|"bb"|"uu", ".pick from a $t array";
is @arr.roll,                    "nn"|"ff"|"bb"|"uu", ".roll from a $t array";

@arr[1] = @arr[0];
is-deeply @arr.unique, <nn bb uu>, "$t array.unique";
is-deeply @arr.repeated, ("nn",),    "$t array.repeated";
is-deeply @arr.squish, <nn bb uu>, "$t array.squish";

dies-ok { @arr.pop },         "Trying to pop a shaped $t array dies";
dies-ok { @arr.shift },       "Trying to shift a shaped $t array dies";
dies-ok { @arr.push(42) },    "Trying to push a shaped $t array dies";
dies-ok { @arr.unshift(42) }, "Trying to unshift a shaped $t array dies";
dies-ok { @arr[0] := my $a }, "Cannot bind to a $t array";
dies-ok { @arr[0]:delete },   "Cannot delete from a $t array";
dies-ok { @arr.append(66) },  "Cannot append to a $t array";
dies-ok { @arr.prepend(66) }, "Cannot prepend to a $t array";
dies-ok { @arr.splice },      "Cannot splice to a $t array";

@arr = "a" .. "d";
is @arr.Str,  'a b c d',   ".Str space-separates on $t array";
is @arr.gist, '[a b c d]', ".gist space-separates on $t array";
is @arr.raku, qq/array[$t].new(:shape(4,), ["a", "b", "c", "d"])/,
  ".raku includes type and str values on $t array";

#?rakudo skip 'STORE not working correctly yet)'
is-deeply @arr[^2], <a b>, 'does slice return correctly';
is-deeply @arr[my $ = ^2], "c", 'does slice handle containerized range';

is @arr.join(":"), "a:b:c:d", "does join a $t array";

is (@arr = ()), "   ", "Can clear $t array by assigning empty list";
is @arr.join(":"), ":::", "does emptying a $t array reset";
@arr = "a","b";
is @arr.join(":"), "a:b::", "does re-initializing a $t array work";

# Interaction of native shaped str arrays and untyped arrays.
my @native := array[$T].new(:shape(10),"a".."j");
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

my @untyped2 = "g".."p";
my @native2 := array[$T].new(:shape(10));
@native2 = @untyped2;
is @native2.elems, 10, "List-assign untyped array of Str to $t array (1)";
is @native2[0], "g", "List-assign untyped array of Str to $t array (2)";
is @native2[9], "p", "List-assign untyped array of Str to $t array (3)";

@untyped2[9] = 666;
throws-like { @native2 = @untyped2 }, Exception,
  "List-assigning incompatible untyped array to $t array dies";

my @ssa := array[$T].new(:shape(10),"a".."j");
my @ssb := array[$T].new(:shape(10),"a".."j");
is @ssa ~~ @ssb, True, "Smartmatching same $t arrays works";

is array[$T].new(:shape(5),"d","e","a","b","c").sort, "a b c d e",
  "Can we sort $t array";

is array[$T].new(:shape(2),"b","a").sort, "a b",
  "Can we sort 2-element sorted $t array";

is array[$T].new(:shape(1),"a").sort, "a",
  "Can we sort 1-element sorted $t array";

# vim: expandtab shiftwidth=4
