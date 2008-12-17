use v6;

use Test;

plan 67;

=begin kwid

This tests the smartmatch operator, defined in L<S03/"Smart matching">

note that ~~ is currently a stub, and is really eq.
the reason it's parsed is so that eval '' won't be around everywhere, not for
emulation.

=end kwid

sub eval_elsewhere($code){ eval($code) }

#L<<S03/"Smart matching"/Any Code:($) item sub truth>>
{
    sub uhuh { 1 }
    sub nuhuh { undef }

    ok((undef ~~ &uhuh), "scalar sub truth");
    ok(!(undef ~~ &nuhuh), "negated scalar sub false");

    sub is_even($x) { $x % 2 == 0 }
    sub is_odd ($x) { $x % 2 == 1 }
    ok 4 ~~ &is_even,    'scalar sub truth (unary)';
    ok 4 !~~ &is_odd,    'scalar sub truth (unary, negated smart-match)';
    ok !(3 ~~ &is_even), 'scalar sub truth (unary)';
    ok !(3 !~~ &is_odd), 'scalar sub truth (unary, negated smart-match)';
};

#?rakudo emit #
my %hash1 is context = ( "foo", "Bar", "blah", "ding");
#?rakudo emit #
my %hash2 is context = ( "foo", "zzz", "blah", "frbz");
#?rakudo emit #
my %hash3 is context = ( "oink", "da", "blah", "zork");
#?rakudo emit #
my %hash4 is context = ( "bink", "yum", "gorch", "zorba");
#?rakudo emit #
my %hash5 is context = ( "foo", 1, "bar", 1, "gorch", undef, "baz", undef );

#L<<S03/Smart matching/"hash keys same set">>
#?rakudo skip 'context variables'
{ 
    ok eval_elsewhere('(%+hash1 ~~ %+hash2)'), "hash keys identical", :todo;
    ok eval_elsewhere('!(%+hash1 ~~ %+hash4)'), "hash keys differ";
};

#L<<S03/Smart matching/hash value slice truth>>
#?rakudo skip 'context variables'
{ 
    flunk('FIXME parsefail');
#    ok(eval(%hash1 ~~ any(%hash3)), "intersecting keys", :todo);
    flunk('FIXME parsefail');
#    ok(!(%hash1 ~~ any(%hash4)), "no intersecting keys");
};

#L<<S03/Smart matching/hash value slice truth>>
#?rakudo skip 'context variables'
{ 
    my @true = (<foo bar>);
    my @sort_of = (<foo gorch>);
    my @false = (<gorch baz>);
    ok((%hash5 ~~ @true), "value slice true", :todo);
    ok((%hash5 ~~ @sort_of), "value slice partly true", :todo);
    ok(!(%hash5 ~~ @false), "value slice false");
};

#L<<S03/Smart matching/hash value slice truth>>
#?rakudo skip 'context variables'
{ 
    ok((%hash1 ~~ any(<foo bar>)), "any key exists (but where is it?)", :todo);
    ok(!(%hash1 ~~ any(<gorch ding>)), "no listed key exists");
};

#L<<S03/Smart matching/hash slice existence>>
#?rakudo skip 'context variables'
{ 
    ok((%hash1 ~~ all(<foo blah>)), "all keys exist", :todo);
    ok(!(%hash1 ~~ all(<foo edward>)), "not all keys exist");
};

#Hash    Rule      hash key grep            match if any($_.keys) ~~ /$x/

#L<<S03/Smart matching/hash slice existence>>
#?rakudo skip 'context variables'
{ 
    ok((%hash5 ~~ "foo"), "foo exists", :todo);
    ok((%hash5 ~~ "gorch"),
       "gorch exists, true although value is false", :todo);
    ok((%hash5 ~~ "wasabi"), "wasabi does not exist", :todo);
};

#L<<S03/Smart matching/hash slice existence>>
#?rakudo skip 'context variables'
{ 
    my $string is context = "foo";
    ok eval_elsewhere('(%+hash5 ~~ .{$+string})'), 'hash.{Any} truth';
    $string = "gorch";
    ok eval_elsewhere('!(%+hash5 ~~ .{$+string})'), 'hash.{Any} untruth';
};

#L<<S03/Smart matching/hash value slice truth>>
#?rakudo skip 'context variables'
{ 
    ok eval_elsewhere('(%+hash5 ~~ .<foo>)'), "hash<string> truth";
    ok eval_elsewhere('!(%+hash5 ~~ .<gorch>)'), "hash<string> untruth";
};

#L<<S03/Smart matching/arrays are comparable>>
{ 
    ok((("blah", "blah") ~~ ("blah", "blah")), "qw/blah blah/ .eq");
    ok(!((1, 2) ~~ (1, 1)), "1 2 !~~ 1 1");
    ok((1,2,3,4) ~~ (1,*), 'array smartmatch dwims * at end');
    ok((1,2,3,4) ~~ (*,4), 'array smartmatch dwims * at start');
    ok((1,2,3,4) ~~ (1,*,3,4), 'array smartmatch dwims * 1 elem');
    ok((1,2,3,4) ~~ (1,*,4), 'array smartmatch dwims * many elems');
    ok((1,2,3,4) ~~ (*,3,*), 'array smartmatch dwims * at start and end');
    ok((1,2,3,4) ~~ (*,1,2,3,4), 'array smartmatch dwims * can match nothing at start');
    ok((1,2,3,4) ~~ (1,2,*,3,4), 'array smartmatch dwims * can match nothing in middle');
    ok((1,2,3,4) ~~ (1,2,3,4,*), 'array smartmatch dwims * can match nothing at end');
    ok(!((1,2,3,4) ~~ (1,*,3)), '* dwimming does not cause craziness');
    ok(!((1,2,3,4) ~~ (*,5)), '* dwimming does not cause craziness');
    ok(!((1,2,3,4) ~~ (1,3,*)), '* dwimming does not cause craziness');
};

#L<<S03/Smart matching/numeric equality>>
{ 
    ok(((1, 2) ~~ any(2, 3)),
       "there is intersection between (1, 2) and (2, 3)", :todo);
    ok(!((1, 2) ~~ any(3, 4)),
       "but none between (1, 2) and (3, 4)");
};

#L<S03/Smart matching/array value slice truth>
#?rakudo skip 'Null PMC access in type()'
{ 
    ok eval('((undef, 1, undef) ~~ .[1])'),
        "element 1 of (undef, 1, undef) is true";
    ok eval('!((undef, undef) ~~ .[0])'),
        "element 0 of (undef, undef) is false";
};

#L<<S03/"Smart matching"/in range>>
{ 
    ok((5 ~~ 1 .. 10), "5 is in 1 .. 10", :todo);
    ok(!(10 ~~ 1 .. 5), "10 is not in 1 .. 5");
    ok(!(1 ~~ 5 .. 10), "1 is not i n 5 .. 10");
    ok(!(5 ~~ 5 ^..^ 10), "5 is not in 5 .. 10, exclusive");
};

#Str     StrRange  in string range          match if $min le $_ le $max

#L<S03/Smart matching/"simple closure truth">
{ 
    ok((1 ~~ { 1 }), "closure truth");
    ok((undef ~~ { 1 }), 'ignores $_');
};

#L<<S03/Smart matching/type membership>>
{ 
    class Dog {}
    class Cat {}
    class Chihuahua is Dog {} # i'm afraid class Pugs will get in the way ;-)

    ok eval('(Chihuahua ~~ Dog)'), "chihuahua isa dog";
    ok eval('!(Chihuahua ~~ Cat)'), "chihuahua is not a cat";
};

#Any     Role      role playing             match if \$_.does(\$x)

#L<<S03/Smart matching/numeric equality>>
{ 
    ok((1 ~~ 1), "one is one");
    ok(!(2 ~~ 1), "two is not one");
};

#L<<S03/Smart matching/string equality>>
{ 
    ok(("foo" ~~ "foo"), "foo eq foo");
    ok(!("bar" ~~ "foo"), "!(bar eq foo)");
};

# no objects, no rules
# ... staring vin diesel and kevin kostner! (blech)
#Any     .method   method truth*            match if $_.method
#Any     Rule      pattern match            match if $_ ~~ /$x/
#Any     subst     substitution match*      match if $_ ~~ subst

# i don't understand this one
#Any     boolean   simple expression truth* match if true given $_

#L<S03/Smart matching/Any undef undefined not .defined>
{ 
    ok(!("foo" ~~ undef), "foo is not ~~ undef");
    ok "foo" !~~ undef,   'foo !~~ undef';
    ok((undef ~~ undef), "undef is");
};

# does this imply MMD for $_, $x?
#Any     Any       run-time dispatch        match if infix:<~~>($_, $x)


#L<S03/Smart matching>
{ 
    # representational checks for !~~, rely on ~~ semantics to be correct
    # assume negated results

    ok(!("foo" !~~ "foo"), "!(foo ne foo)");
    ok(("bar" !~~ "foo"), "bar ne foo)");

    #?pugs 2 skip 'parsefail'
    #?rakudo 2 skip 'context variables'
    ok(!(%hash1 !~~ any(%hash3)), "intersecting keys", :todo);
    ok((%hash1 !~~ any(%hash4)), "no intersecting keys");
};

=begin begin Explanation

You may be wondering what the heck is with all these try blocks.
Prior to r12503, this test caused a horrible death of Pugs which
magically went away when used inside an eval.  So the try blocks
caught that case.

=end begin Explanation

#?rakudo skip 'pointy blocks'
{
    #L<S09/"Junctions">
    my @x = 1..20;
    my $code = -> $x { $x % 2 };
    my @result;
    my $parsed = 0;
    try {
        @result = any(@x) ~~ $code;
        $parsed = 1;
    };
    ok $parsed, 'C<my @result = any(@x) ~~ $code> parses';
    my @expected_result = grep $code, @x;
    ok @result ~~ @expected_result,
        'C<any(@x) ~~ {...}> works like C<grep>', :todo<feature>;
}

{
    my $result = 0;
    my $parsed = 0;
    my @x = 1..20;
    try {
        $result = all(@x) ~~ { $_ < 21 };
        $parsed = 1;
    };
    ok $parsed, 'C<all(@x) ~~ { ... }> parses';
    ok $result, 'C<all(@x) ~~ { ... } when true for all';

    $result = 0;
    try {
        $result = !(all(@x) ~~ { $_ < 20 });
    };
    ok $result,
        'C<all(@x) ~~ {...} when true for one';

    $result = 0;
    try {
        $result = !(all(@x) ~~ { $_ < 12 });
    };
    ok $result,
        'C<all(@x) ~~ {...} when true for most';

    $result = 0;
    try {
        $result = !(all(@x) ~~ { $_ < 1  });
    };
    ok $result,
        'C<all(@x) ~~ {...} when true for one';
};

# vim: ft=perl6
