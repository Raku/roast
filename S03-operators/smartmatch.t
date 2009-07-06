use v6;

use Test;

plan 102;

=begin pod

This tests the smartmatch operator, defined in L<S03/"Smart matching">

=end pod

sub eval_elsewhere($code){ eval($code) }

#L<S03/"Smart matching"/Any Callable:($) item sub truth>
{
    sub is_even($x) { $x % 2 == 0 }
    sub is_odd ($x) { $x % 2 == 1 }
    ok 4 ~~ &is_even,    'scalar sub truth (unary)';
    ok 4 !~~ &is_odd,    'scalar sub truth (unary, negated smart-match)';
    ok !(3 ~~ &is_even), 'scalar sub truth (unary)';
    ok !(3 !~~ &is_odd), 'scalar sub truth (unary, negated smart-match)';
}

#L<S03/"Smart matching"/Any Callable:() simple closure truth>
{
    sub uhuh { 1 }
    sub nuhuh { undef }

    ok((undef ~~ &uhuh), "scalar sub truth");
    ok(!(undef ~~ &nuhuh), "negated scalar sub false");

};

#L<S03/Smart matching/Any undef undefined not .defined>
{ 
    ok(!("foo" ~~ undef), "foo is not ~~ undef");
    ok "foo" !~~ undef,   'foo !~~ undef';
    ok((undef ~~ undef), "undef is");
};

#L<S03/Smart matching/Any .foo method truth>
{
    class Smartmatch::Tester {
        method a { 4 };
        method b($x) { 5 * $x };
        method c { 0 };
    }
    my $t = Smartmatch::Tester.new();
    ok ($t ~~ .a),    '$obj ~~ .method calls the method (+)';
    ok !($t ~~ .c),   '$obj ~~ .method calls the method (-)';
    ok ($t ~~ .b(3)), '$obj ~~ .method(arg) calls the method (true)';
    ok ($t ~~ .b: 3), '$obj ~~ .method: arg calls the method (true)';
    ok !($t ~~ .b(0)), '$obj ~~ .method(arg) calls the method (false)';
    ok !($t ~~ .b: 0), '$obj ~~ .method: arg calls the method (false)';

    # now change the same in when blocks, which also smart-match
    my ($a, $b, $c) = 0 xx 3;
    given $t {
        when .a { $a = 1 };
    }
    given $t {
        when .b(3) { $b = 1 };
    }
    given $t {
        when .b(0) { $c = 1 };
    }
    ok $a, '.method in when clause';
    ok $b, '.method(args) in when clause';
    ok !$c, '..method(args) should not trigger when-block when false';
}


#L<S03/Smart matching/"hash keys same set">
my %hash1 = ( "foo", "Bar", "blah", "ding");
my %hash2 = ( "foo", "zzz", "blah", "frbz");
my %hash3 = ( "oink", "da", "blah", "zork");
my %hash4 = ( "bink", "yum", "gorch", "zorba");
my %hash5 = ( "foo", 1, "bar", 1, "gorch", undef, "baz", undef );
{
    #?pugs todo
    ok eval_elsewhere('(%hash1 ~~ %hash2)'), "hash keys identical";
    ok eval_elsewhere('!(%hash1 ~~ %hash4)'), "hash keys differ";
}

#L<S03/Smart matching/hash value slice truth>
{
    #?pugs todo
    ok(%hash1 ~~ any(%hash3), "intersecting keys");
    ok(%hash1 !~~ any(%hash4), "no intersecting keys");
};

#L<S03/Smart matching/hash value slice truth>
{ 
    my @true = (<foo bar>);
    my @sort_of = (<foo gorch>);
    my @false = (<gorch baz>);
    #?pugs todo 2
    ok((%hash5 ~~ @true), "value slice true");
    ok((%hash5 ~~ @sort_of), "value slice partly true");
    ok(!(%hash5 ~~ @false), "value slice false");
};

#L<S03/Smart matching/hash value slice truth>
{ 
    #?pugs todo
    ok((%hash1 ~~ any(<foo bar>)), "any key exists (but where is it?)");
    ok(!(%hash1 ~~ any(<gorch ding>)), "no listed key exists");
};

#L<S03/Smart matching/hash slice existence>
{ 
    #?pugs todo
    ok((%hash1 ~~ all(<foo blah>)), "all keys exist");
    ok(!(%hash1 ~~ all(<foo edward>)), "not all keys exist");
};

#Hash    Rule      hash key grep            match if any($_.keys) ~~ /$x/

#L<S03/Smart matching/hash slice existence>
{ 
    #?pugs todo 3
    ok((%hash5 ~~ "foo"), "foo exists");
    ok((%hash5 ~~ "gorch"),
       "gorch exists, true although value is false");
    ok((%hash5 ~~ "wasabi"), "wasabi does not exist");
};

#L<S03/Smart matching/hash slice existence>
{ 
    my $string = "foo";
    ok eval_elsewhere('(%hash5 ~~ .{$string})'), 'hash.{Any} truth';
    $string = "gorch";
    ok eval_elsewhere('!(%hash5 ~~ .{$string})'), 'hash.{Any} untruth';
};

#L<S03/Smart matching/hash value slice truth>
{ 
    ok eval_elsewhere('(%hash5 ~~ .<foo>)'), "hash<string> truth";
    ok eval_elsewhere('!(%hash5 ~~ .<gorch>)'), "hash<string> untruth";
};

#L<S03/Smart matching/arrays are comparable>
{ 
    ok((("blah", "blah") ~~ ("blah", "blah")), "qw/blah blah/ .eq");
    ok(!((1, 2) ~~ (1, 1)), "1 2 !~~ 1 1");
    ok(!((1, 2, 3) ~~ (1, 2)), "1 2 3 !~~ 1 2");
    ok(!((1, 2) ~~ (1, 2, 3)), "1 2 !~~ 1 2 3");
    ok(!(list() ~~ list(1)), "array smartmatch boundary conditions");
    ok(!(list(1) ~~ list()), "array smartmatch boundary conditions");
    ok((list() ~~ list()), "array smartmatch boundary conditions");
    ok((list(1) ~~ list(1)), "array smartmatch boundary conditions");
    ok((1,2,3,4) ~~ (1,*), 'array smartmatch dwims * at end');
    ok((1,2,3,4) ~~ (1,*,*), 'array smartmatch dwims * at end (many *s)');
    ok((1,2,3,4) ~~ (*,4), 'array smartmatch dwims * at start');
    ok((1,2,3,4) ~~ (*,*,4), 'array smartmatch dwims * at start (many *s)');
    ok((1,2,3,4) ~~ (1,*,3,4), 'array smartmatch dwims * 1 elem');
    ok((1,2,3,4) ~~ (1,*,*,3,4), 'array smartmatch dwims * 1 elem (many *s)');
    ok((1,2,3,4) ~~ (1,*,4), 'array smartmatch dwims * many elems');
    ok((1,2,3,4) ~~ (1,*,*,4), 'array smartmatch dwims * many elems (many *s)');
    ok((1,2,3,4) ~~ (*,3,*), 'array smartmatch dwims * at start and end');
    ok((1,2,3,4) ~~ (*,*,3,*,*), 'array smartmatch dwims * at start and end (many *s)');
    ok((1,2,3,4) ~~ (*,1,2,3,4), 'array smartmatch dwims * can match nothing at start');
    ok((1,2,3,4) ~~ (*,*,1,2,3,4), 'array smartmatch dwims * can match nothing at start (many *s)');
    ok((1,2,3,4) ~~ (1,2,*,3,4), 'array smartmatch dwims * can match nothing in middle');
    ok((1,2,3,4) ~~ (1,2,*,*,3,4), 'array smartmatch dwims * can match nothing in middle (many *s)');
    ok((1,2,3,4) ~~ (1,2,3,4,*), 'array smartmatch dwims * can match nothing at end');
    ok((1,2,3,4) ~~ (1,2,3,4,*,*), 'array smartmatch dwims * can match nothing at end (many *s)');
    ok(!((1,2,3,4) ~~ (1,*,3)), '* dwimming does not cause craziness');
    ok(!((1,2,3,4) ~~ (*,5)), '* dwimming does not cause craziness');
    ok(!((1,2,3,4) ~~ (1,3,*)), '* dwimming does not cause craziness');

    # now try it with arrays as well
    my @a = 1, 2, 3;
    my @b = 1, 2, 4;
    my @m = (*, 2, *); # m as "magic" ;-)

    ok (@a ~~  @a), 'Basic smartmatching on arrays (positive)';
    ok (@a !~~ @b), 'Basic smartmatching on arrays (negative)';
    ok (@b !~~ @a), 'Basic smartmatching on arrays (negative)';
    ok (@a ~~  @m), 'Whatever dwimminess in arrays';
    ok (@a ~~ (1, 2, 3)), 'smartmatch Array ~~ List';
    ok ((1, 2, 3) ~~ @a), 'smartmatch List ~~ Array';
    ok ((1, 2, 3) ~~ @m), 'smartmatch List ~~ Array with dwim';

    ok (1 ~~ *,1,*),     'smartmatch with Array RHS co-erces LHS to list';
    ok (1..10 ~~ *,5,*), 'smartmatch with Array RHS co-erces LHS to list';
};

#L<S03/Smart matching/numeric equality>
{ 
    #?pugs todo
    ok(((1, 2) ~~ any(2, 3)),
       "there is intersection between (1, 2) and (2, 3)");
    ok(!((1, 2) ~~ any(3, 4)),
       "but none between (1, 2) and (3, 4)");
};

#L<S03/Smart matching/array value slice truth>
{ 
    ok ((undef, 1, undef) ~~ .[1]),
        "element 1 of (undef, 1, undef) is true";
    ok !((undef, undef) ~~ .[0]),
        "element 0 of (undef, undef) is false";
    ok ((0, 1, 2, 3) ~~ .[1, 2, 3]),
        "array slice .[1,2,3] of (0,1,2,3) is true";
    ok !((0, 1, 2, 3) ~~ .[0]),
        "array slice .[0] of (0,1,2,3) is false";
    ok !((0, 1, 2, 3) ~~ .[0,1]),
        "array slice .[0,1] of (0,1,2,3) is false";
};

#L<S03/"Smart matching"/in range>
{ 
    #?pugs todo
    ok((5 ~~ 1 .. 10), "5 is in 1 .. 10");
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

#L<S03/Smart matching/type membership>
{ 
    class Dog {}
    class Cat {}
    class Chihuahua is Dog {} # i'm afraid class Pugs will get in the way ;-)

    ok (Chihuahua ~~ Dog), "chihuahua isa dog";
    ok !(Chihuahua ~~ Cat), "chihuahua is not a cat";
};

#Any     Role      role playing             match if \$_.does(\$x)

#L<S03/Smart matching/numeric equality>
{ 
    ok((1 ~~ 1), "one is one");
    ok(!(2 ~~ 1), "two is not one");
};

#L<S03/Smart matching/string equality>
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

# does this imply MMD for $_, $x?
#Any     Any       run-time dispatch        match if infix:<~~>($_, $x)


#L<S03/Smart matching>
{ 
    # representational checks for !~~, rely on ~~ semantics to be correct
    # assume negated results

    ok(!("foo" !~~ "foo"), "!(foo ne foo)");
    ok(("bar" !~~ "foo"), "bar ne foo)");

    #?pugs 2 skip 'parsefail'
    ok(!(%hash1 !~~ any(%hash3)), "intersecting keys");
    ok((%hash1 !~~ any(%hash4)), "no intersecting keys");
};

=begin begin Explanation

You may be wondering what the heck is with all these try blocks.
Prior to r12503, this test caused a horrible death of Pugs which
magically went away when used inside an eval.  So the try blocks
caught that case.

=end begin Explanation

{
    my $result = 0;
    my $parsed = 0;
    my @x = 1..20;
    try {
        $result = all(@x) ~~ { $_ < 21 };
        $parsed = 1;
    };
    ok $parsed, 'C<all(@x) ~~ { ... }> parses';
    ok ?$result, 'C<all(@x) ~~ { ... } when true for all';

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

ok NaN ~~ NaN, 'NaN ~~ NaN is True';

# need to test in eval() since class defintions happen at compile time,
# ie before the plan is set up.
eval_lives_ok 'class A { method foo { say "" ~~ * } }; A.new.foo',
              'smartmatch in a class lives (RT #62196)';
# vim: ft=perl6
