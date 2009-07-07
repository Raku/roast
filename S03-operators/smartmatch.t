use v6;

use Test;

plan 138;

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
#L<S03/Smart matching/Any .foo(...) method truth>
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

#L<S03/Smart matching/Any .(...) sub call truth>
{
    my $t = sub { Bool::True };
    my $f = sub { Bool::False };
    my $mul = sub ($x) { $x * 2 };
    my $div = sub ($x) { $x - 2 };

    ok ($t ~~ .()),     '~~ .() sub call truth (+)';
    ok !($f ~~ .()),    '~~ .() sub call truth (-)';
    ok ($mul ~~ .(2)),  '~~ .($args) sub call truth (+,1)';
    ok !($mul ~~ .(0)), '~~ .($args) sub call truth (-,1)';
    ok !($div ~~ .(2)), '~~ .($args) sub call truth (+,2)';
    ok ($div ~~ .(0)),  '~~ .($args) sub call truth (-,2)';
}

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

#L<S03/Smart matching/hash value slice truth>

{
    my %h = (a => 0, b => 0, c => 1, d => 2);
    sub notautoquoted_a { 'a' };
    sub notautoquoted_c { 'c' };

    ok  (%h ~~ .{'c'}),     '%hash ~~ .{true"}';
    ok !(%h ~~ .{'b'}),     '%hash ~~ .{false"}';
    ok  (%h ~~ .{<c d>}),   '%hash ~~ .{<true values>}';
    ok !(%h ~~ .{<c d a>}), '%hash ~~ .{<not all true>}';
    ok !(%h ~~ .{notautoquoted_a}), '~~. {notautoquoted_a}';
    ok  (%h ~~ .{notautoquoted_c}), '~~. {notautoquoted_c}';
    ok  (%h ~~ .<c>),     '%hash ~~ .<true"}';
    ok !(%h ~~ .<b>),     '%hash ~~ .<false"}';
    ok  (%h ~~ .<c d>),   '%hash ~~ .<true values>';
    ok !(%h ~~ .<c d a>), '%hash ~~ .<not all true>';
    ok !(%h ~~ .<c d f>), '%hash ~~ .<not all exist>';
}

#L<S03/Smart matching/Any Bool simple truth>
{
    ok  (0 ~~ True),         '$something ~~ True (1)';
    ok  (0 ~~ Bool::True),   '$something ~~ Bool::True (1)';
    ok  ('a' ~~ True),       '$something ~~ True (2)';
    ok  ('a' ~~ Bool::True), '$something ~~ Bool::True (2)';
    ok !(0 ~~ False),        '$something ~~ False (1)';
    ok !(0 ~~ Bool::False),  '$something ~~ Bool::False (1)';
    ok !('a' ~~ False),      '$something ~~ False (2)';
    ok !('a' ~~ Bool::False),'$something ~~ Bool::False (2)';
}

#L<S03/Smart matching/Any Num numeric equality>
{
    ok  ('05' ~~ 5),            '$something ~~ number numifies';
    ok  ('1.2' ~~ 1.2),         '$thing ~~ number does numeric comparison';
    # yes, this warns, but it should still be true
    ok  (undef ~~ 0),           'undef ~~ 0';
    ok !(undef ~~ 2.3),         'undef ~~ $other_number';
}

#L<S03/Smart matching/Any Str string equality>
{
    ok(!("foo" !~~ "foo"),  "!(foo ne foo)");
    ok(("bar" !~~ "foo"),   "bar ne foo)");
    ok  (4 ~~ '4'),         'string equality';
    ok !(4 !~~ '4'),        'negated string equality';
    ok  (undef ~~ ''),      'undef ~~ ""';
}

#L<S03/Smart matching/Hash Pair test hash mapping>
{
    my %a = (a => 1, b => 'foo', c => undef);
    ok  (%a ~~ b => 'foo'),         '%hash ~~ Pair (Str, +)';
    ok !(%a ~~ b => 'ugh'),         '%hash ~~ Pair (Str, -)';
    ok  (%a ~~ a => 1.0),           '%hash ~~ Pair (Num, +)';
    ok  (%a ~~ :b<foo>),            '%hash ~~ Colonpair';
    ok  (%a ~~ c => undef),         '%hash ~~ Pair (undef)';
    ok  (%a ~~ d => undef),         '%hash ~~ Pair (undef, nonexistent)';
    ok !(%a ~~ a => 'foo'),         '%hash ~~ Pair (key and val not paired)';
}

#L<S03/Smart matching/Any Pair test object attribute>
#?rakudo skip 'Any ~~ Pair'
{
    class SmartmatchTest::AttrPair {
        has $.a = 4;
        has $.b = 'foo';
        has $.c = undef;
    }
    my $o = SmartmatchTest::AttrPair.new();
    ok  ($o ~~ :a(4)),      '$obj ~~ Pair (Int, +)';
    ok !($o ~~ :a(2)),      '$obj ~~ Pair (Int, -)';
    ok  ($o ~~ :b(0)),      '$obj ~~ Pair (Int, +) (with coercion, warns)';
    ok  ($o ~~ :b<foo>),    '$obj ~~ Pair (Str, +)';
    ok !($o ~~ :b<ugh>),    '$obj ~~ Pair (Str, -)';
    ok  ($o ~~ :c(undef)),  '$obj ~~ Pair (undef, +)';
    ok !($o ~~ :b(undef)),  '$obj ~~ Pair (undef, -)';
    # unspecced, but decreed by TimToady: non-existing method
    # or attribute dies:
    # http://irclog.perlgeek.de/perl6/2009-07-06#i_1293199
    dies_ok {$o ~~ :e(undef)},  '$obj ~~ Pair, nonexistent, dies';
    dies_ok {$o ~~ :e(5)},      '$obj ~~ Pair, nonexistent, dies';
}

# TODO: 
# Set   Set
# Hash  Set
# Any   Set

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

# TODO:
# Set   Array
# Any   Array

#L<S03/Smart matching/Hash Hash hash keys same set>
my %hash1 = ( "foo" => "Bar", "blah" => "ding");
my %hash2 = ( "foo" => "zzz", "blah" => "frbz");
my %hash3 = ( "oink" => "da", "blah" => "zork");
my %hash4 = ( "bink" => "yum", "gorch" => "zorba");
my %hash5 = ( "foo" => 1, "bar" => 1, "gorch" => undef, "baz" => undef );

{
    ok  (%hash1 ~~ %hash2), 'Hash ~~ Hash (same keys, +)';
    ok !(%hash1 ~~ %hash3), 'Hash ~~ Hash (same keys, -)';
    #?pugs todo
    ok eval_elsewhere('(%hash1 ~~ %hash2)'), "hash keys identical";
    ok eval_elsewhere('!(%hash1 ~~ %hash4)'), "hash keys differ";
}
=begin needsdiscussion
#L<S03/Smart matching/hash value slice truth>
{
    #?pugs todo
    ok(%hash1 ~~ any(%hash3), "intersecting keys");
    ok(%hash1 !~~ any(%hash4), "no intersecting keys");
};
=end needsdiscussion

# TODO:
# Set   Hash
# Array Hash

#L<S03/"Smart matching"/Regex Hash hash key grep>
{
    my %h = (moep => 'foo', bar => 'baz');
    ok  (/oep/ ~~ %h),      'Regex ~~ Hash (+,1)';
    ok  (/bar/ ~~ %h),      'Regex ~~ Hash (+,2)';
    ok !(/ugh/ ~~ %h),      'Regex ~~ Hash (-,1)';
    ok !(/foo/ ~~ %h),      'Regex ~~ Hash (-,value)';
}

#L<S03/"Smart matching"/Scalar Hash hash entry existence>
{
    my %h = (moep => 'foo', bar => undef);
    ok  ('moep' ~~ %h),     'Scalar ~~ Hash (+, True)';
    ok  ('bar' ~~ %h),      'Scalar ~~ Hash (+, False)';
    ok !('foo' ~~ %h),      'Scalar ~~ Hash (-)';
}

# TODO:
# Any   Hash

# Regex tests are in spec/S05-*

#L<S03/"Smart matching"/in range>
{ 
    # more range tests in t/spec/S03-operators/range.t
    #?pugs todo
    ok((5 ~~ 1 .. 10), "5 is in 1 .. 10");
    ok(!(10 ~~ 1 .. 5), "10 is not in 1 .. 5");
    ok(!(1 ~~ 5 .. 10), "1 is not i n 5 .. 10");
    ok(!(5 ~~ 5 ^..^ 10), "5 is not in 5 .. 10, exclusive");
};

#L<S03/Smart matching/type membership>
{ 
    class Dog {}
    class Cat {}
    class Chihuahua is Dog {} # i'm afraid class Pugs will get in the way ;-)
    role SomeRole { };
    class Something does SomeRole { };

    ok (Chihuahua ~~ Dog), "chihuahua isa dog";
    ok (Something ~~ SomeRole), 'something does dog';
    ok !(Chihuahua ~~ Cat), "chihuahua is not a cat";
};

# TODO:
# Signature Signature
# Callable  Signature
# Capture   Signature
# Any       Signature
#                    
# Signature Capture  


#L<S03/Smart matching/Any Any scalars are identical>
#?rakudo skip 'Any ~~ Any'
{
    class Smartmatch::ObjTest;
    my $a = Smartmatch::ObjTest.new;
    my $b = Smartmatch::ObjTest.new;
    ok  ($a ~~  $a),    'Any ~~  Any (+)';
    ok !($a !~~ $a),    'Any !~~ Any (-)';
    ok !($a ~~  $b),    'Any ~~  Any (-)';
    ok  ($a !~~ $b),    'Any !~~ Any (+)';
}

# reviewed by moritz on 2009-07-07 up to here.



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
eval_lives_ok 'class A { method foo { diag "" ~~ * } }; A.new.foo',
              'smartmatch in a class lives (RT #62196)';

# vim: ft=perl6
