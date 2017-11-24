use v6;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;

plan 177;

# L<S03/Nonchaining binary precedence/Range object constructor>

# 3..2 must *not* produce "3 2".  Use reverse to get a reversed range. -lwall
is ~(3..6), "3 4 5 6", "(..) works on numbers (1)";
is ~(3..3), "3",       "(..) works on numbers (2)";
is ~(3..2), "",        "(..) works on auto-rev numbers (3)";
is ~(8..11), "8 9 10 11",   "(..) works on carried numbers (3)";

is ~("a".."c"), "a b c", "(..) works on chars (1)";
is ~("a".."a"), "a",     "(..) works on chars (2)";
is ~("b".."a"), "",      "(..) works on chars (3)";
is ~("a".."z"), "a b c d e f g h i j k l m n o p q r s t u v w x y z", "(..) works on char range ending in z";
is ~("A".."Z"), "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z", "(..) works on char range ending in Z";
is ~("Y".."AB"), "",     "(..) works on carried chars (3)";

is ~('Y'..'d'), 'Y Z [ \ ] ^ _ ` a b c d',  '(..) works on uppercase letter .. lowercase letter (1)';
is ~('z'..'Y'), '',    '(..) works on auto-rev uppercase letter .. lowercase letter (2)';
is ~('Y'..'_'), 'Y Z [ \ ] ^ _', '(..) works on letter .. non-letter (1)';
is ~('_'..'Y'), '',    '(..) works on auto-rev letter .. non-letter (2)';
is ~(' '..' '), ' ',    'all-whitespace range works';

is ~(3..9-3), "3 4 5 6", "(..) has correct precedence (1)";
is ~(5..9-5), "",        "(..) has correct precedence (2)";
is ~(2+1..6), "3 4 5 6", "(..) has correct precedence (3)";
is ~(2+5..6), "",        "(..) has correct precedence (4)";

# Test the three exclusive range operators:
# L<S03/Range and RangeIter semantics/range operator has variants>
is [1^..9], [2..9],  "bottom-exclusive range (^..) works (1)";
is [2^..2], [],      "bottom-exclusive range (^..) works (2)";
is [3^..2], [],      "bottom-exclusive auto-rev range (^..) works (3)";
is [1 ..^9], [1..8], "top-exclusive range (..^) works (1)";
is [2 ..^2], [],     "top-exclusive range (..^) works (2)";
is [3 ..^2], [],     "top-exclusive auto-rev range (..^) works (3)";
is [1^..^9], [2..8], "double-exclusive range (^..^) works (1)";
is [9^..^1], [],     "double-exclusive auto-rev range (^..^) works (2)";
is [1^..^2], [],     "double-exclusive range (^..^) can produce null range (1)";

# tests of (x ^..^ x) here and below ensure that our implementation
# of double-exclusive range does not blindly remove an element
# from the head and tail of a list
is [1^..^1], [], "double-exclusive range (x ^..^ x) where x is an int";

is ["a"^.."z"], ["b".."z"], "bottom-exclusive string range (^..) works";
is ["z"^.."a"], [], "bottom-exclusive string auto-rev range (^..) works";
is ["a"..^"z"], ["a".."y"], "top-exclusive string range (..^) works";
is ["z"..^"a"], [], "top-exclusive string auto-rev range (..^) works";
is ["a"^..^"z"], ["b".."y"], "double-exclusive string range (^..^) works";
is ["z"^..^"a"], [], "double-exclusive string auto-rev range (^..^) works";
is ['a'^..^'b'], [], "double-exclusive string range (^..^) can produce null range";
is ['b'^..^'a'], [], "double-exclusive string auto-rev range (^..^) can produce null range";
is ['a' ^..^ 'a'], [], "double-exclusive range (x ^..^ x) where x is a char";
is ('a'..'z').list.join(' '), 'a b c d e f g h i j k l m n o p q r s t u v w x y z', '"a".."z"';

# RT #130554
is ['!'^..'&'], ['"'..'&'], "bottom-exclusive non-alphanumeric string range (^..) works";
is ['!'..^'&'], ['!'..'%'], "top-exclusive non-alphanumeric string range (..^) works";
is ['!'^..^'&'], ['"'..'%'], "double-exclusive non-alphanumeric string range (^..^) works";
is ['%'^..^'&'], [], "double-exclusive non-alphanumeric string range (^..^) can produce null range";

is 1.5 ~~ 1^..^2, Bool::True, "lazy evaluation of the range operator";

# Test the unary ^ operator
is ~(^5), "0 1 2 3 4", "unary ^num produces the range 0..^num";
is [^1],   [0],        "unary ^ on the boundary ^1 works";
is [^0],   [],         "unary ^0 produces null range";
is [^-1],  [],         "unary ^-1 produces null range";
is [^0.1], [0],        "unary ^0.1 produces the range 0..^x where 0 < x < 1";
is ~(^"5"), "0 1 2 3 4", 'unary ^"num" produces the range 0..^num';

{
    my @a = 3, 5, 3;
    is (^@a).perl, (0..^3).perl,    'unary ^@a produces 0..^+@a';
}

# test iterating on infinite ranges
is (1..*).[^5].join('|'), '1|2|3|4|5', '1..*';
is ('a'..*).[^5].join('|'), 'a|b|c|d|e', '"a"..*';

# test that the zip operator works with ranges
is (1..5 Z <a b c>).flat.join('|'), '1|a|2|b|3|c', 'Ranges and infix:<Z>';
is (1..2 Z <a b c>).flat.join('|'), '1|a|2|b',     'Ranges and infix:<Z>';
is (<c b a> Z 1..5).flat.join('|'), 'c|1|b|2|a|3', 'Ranges and infix:<Z>';

# two ranges
is (1..6 Z 'a' .. 'c').flat.join, '1a2b3c',   'Ranges and infix:<Z>';

{
    # Test with floats
    # 2006-12-05:
    # 16:16 <TimToady> ~(1.9 ^..^ 4.9) should produce 2.9, 3.9
    # 16:17 <pmichaud> and ~(1.9 ^..^ 4.5) would produce the same?
    # 16:17 <TimToady> yes
    is ~(1.1 .. 4) , "1.1 2.1 3.1", "range with float .min";
    is ~(1.9 .. 4) , "1.9 2.9 3.9", "range with float .min";
    is ~(1.1 ^.. 4), "2.1 3.1"    , "bottom exclusive range of float";
    is ~(1.9 ^.. 4), "2.9 3.9"    , "bottom exclusive range of float";

    is ~(1 .. 4.1) , "1 2 3 4", "range with float .max";
    is ~(1 .. 4.9) , "1 2 3 4", "range with float .max";
    is ~(1 ..^ 4.1), "1 2 3 4", "top exclusive range of float";
    is ~(1 ..^ 4.9), "1 2 3 4", "top exclusive range of float";

    is ~(1.1 .. 4.1), "1.1 2.1 3.1 4.1", "range with float .min/.max";
    is ~(1.9 .. 4.1), "1.9 2.9 3.9"    , "range with float .min/.max";
    is ~(1.1 .. 4.9), "1.1 2.1 3.1 4.1", "range with float .min/.max";
    is ~(1.9 .. 4.9), "1.9 2.9 3.9 4.9", "range with float .min/.max";

    is ~(1.1 ^..^ 4.1), "2.1 3.1"    , "both exclusive float range";
    is ~(1.9 ^..^ 4.1), "2.9 3.9"    , "both exclusive float range";
    is ~(1.1 ^..^ 4.9), "2.1 3.1 4.1", "both exclusive float range";
    is ~(1.9 ^..^ 4.9), "2.9 3.9"    , "both exclusive float range";
    is [1.1 ^..^ 1.1], [], "double-exclusive range (x ^..^ x) where x is a float";
}

# Test that the operands are forced to scalar context
# Range.new coerces its arguments to numeric context if needed
# RT #58018
# RT #76950
{
    my @three = (1, 1, 1);
    my @one = 1;

    is ~(@one .. 3)     , "1 2 3", "lower inclusive limit is in scalar context";
    is ~(@one ^.. 3)    , "2 3"  , "lower exclusive limit is in scalar context";
    is ~(3 ^.. @one)    , ""     , "lower exclusive limit is in scalar context";
    is ~(1 .. @three)   , "1 2 3", "upper inclusive limit is in scalar context";
    is ~(4 .. @three)   , ""     , "upper inclusive limit is in scalar context";
    is ~(1 ..^ @three)  , "1 2"  , "upper exclusive limit is in scalar context";
    is ~(4 ..^ @three)  , ""     , "upper exclusive limit is in scalar context";
    is ~(@one .. @three), "1 2 3", "both limits is in scalar context";
    is ~(@one ^.. @three), "2 3" , "lower exclusive limit scalar context";
    is ~(@one ..^ @three), "1 2" , "upper exclusive limit scalar context";
    is ~(@one ^..^ @three), "2"  , "both exclusive limit scalar context";
}

# test that .map and .grep work on ranges
{
    is (0..3).map({$_ * 2}).join('|'),      '0|2|4|6', '.map works on ranges';
    is (0..3).grep({$_ == 1|3}).join('|'),  '1|3',     '.grep works on ranges';
    is (1..3).first({ $_ % 2 == 0}),        2,         '.first works on ranges';
    is (1..3).reduce({ $^a + $^b}),         6,         '.reduce works on ranges';
}

# test that range operands are handled in string context if strings
{
    my $range;
    my $start = "100.B";
    my $end = "102.B";
    lives-ok { $range = $start..$end },
             'can make range from numeric string vars';
    is $range.min, $start, 'range starts at start';
    is $range.min.WHAT.gist, Str.gist, 'range start is a string';
    is $range.max,   $end, 'range ends at end';
    is $range.max.WHAT.gist, Str.gist, 'range end is a string';
    lives-ok { "$range" }, 'can stringify range';
    is ~$range, "100.B 101.B 102.B", 'range is correct';
}
 
# RT #67882
{
    my $range;
    lives-ok { '1 3' ~~ /(\d+) \s (\d+)/; $range = $0..$1 },
             'can make range from match vars';
    is $range.min, 1, 'range starts at one';
    is $range.max, 3, 'range ends at three';
    lives-ok { "$range" }, 'can stringify range';
    is ~$range, "1 2 3", 'range is correct';
}
# and another set, just for the lulz
# RT #67882
{
    ok '1 3' ~~ /(\d) . (\d)/, 'regex sanity';
    isa-ok $0..$1, Range, '$0..$1 constructs a Range';
    is ($0..$1).join('|'), '1|2|3', 'range from $0..$1';
}

{
    my $range;
    lives-ok { '1 3' ~~ /(\d+) \s (\d+)/; $range = +$0..+$1 },
             'can make range from match vars with numeric context forced';
    is $range.min, 1, 'range starts at one';
    is $range.max,   3, 'range ends at three';
    lives-ok { "$range" }, 'can stringify range';
    is ~$range, "1 2 3", 'range is correct';
}

{
    my $range;
    lives-ok { '1 3' ~~ /(\d+) \s (\d+)/; $range = ~$0..~$1 },
             'can make range from match vars with string context forced';
    is $range.min, 1, 'range starts at one';
    is $range.min.WHAT.gist, Str.gist, 'range start is a string';
    is $range.max,   3, 'range ends at three';
    is $range.max.WHAT.gist, Str.gist, 'range end is a string';
    lives-ok { "$range" }, 'can stringify range';
    is ~$range, "1 2 3", 'range is correct';
}

# L<S03/Nonchaining binary precedence/it is illegal to use a Range as
# implicitly numeric>

{
    ok !defined(try { 0 .. ^10 }), '0 .. ^10 is illegal';
}

# Lists are allowed on the rhs if the lhs is numeric (Real):
is ~(2 .. [<a b c d e>]), "2 3 4 5", '2 .. @list is legal';

# RT #68788
{
    $_ = Any; # unsetting $_ to reproduce bug literally
    lives-ok {(1..$_)}, '(1..$_) lives';
    isa-ok (1..$_), Range, '(..) works on Int .. Any';
}

{
    my $range = 1 .. '10';
    is +$range, 10, "1 .. '10' has ten elements in it";
    is +$range.grep(Numeric), 10, "and they are all numbers";
}

{
    my @array = 1 .. 10;
    my $range = 1 .. @array;
    is +$range, 10, "1 .. @array has ten elements in it";
    is +$range.grep(Numeric), 10, "and they are all numbers";
}

# RT #82620
{
    lives-ok {("a".."b").map({.trans(""=>"")}).perl},
        "range doesn't leak Parrot types";
}

{
    my $big = 2 ** 130;
    my $count = 0;
    ++$count for $big .. $big + 2;
    is $count, 3, 'can iterate over big Int range';
}

# RT #110350
{
    for 1e0 .. 1e0 {
        isa-ok $_, Num, 'Range of nums produces a Num';
    }
}

# RT #77572
throws-like '1..2..3', X::Syntax::NonAssociative, '.. is not associative';

{
    ## once this block died at compile time
    ## with q[P6opaque: no such attribute '$!phasers']
    ## cmp. https://github.com/rakudo/rakudo/commit/c5e7a7783d
    isa-ok { *.perl for ^2 }, Block,
        'range optimizer is protected from cases with no block';
}

# RT #127279
my @opvariants = «.. ^.. ..^ ^..^ ' R..' ' R^..' ' R..^' ' R^..^'»;
for @opvariants {
    throws-like "\{ use fatal; |4$_ 5 }", X::Worry::Precedence::Range, "$_ warns on common flattening mistake";
    throws-like "\{ use fatal; |4$_ 5 }", X::Worry::Precedence::Range, "$_ warns on common stringification mistake";
    eval-lives-ok "\{ use fatal; |(4$_ 5) }", "$_ doesn't warn on parenthesized flattening (range)";
    eval-lives-ok "\{ use fatal; (|4)$_ 5 }", "$_ doesn't warn on parenthesized flattening (endpoint)";
    eval-lives-ok "\{ use fatal; ~(4$_ 5) }", "$_ doesn't warn on parenthesized stringification (range)";
    eval-lives-ok "\{ use fatal; (~4)$_ 5 }", "$_ doesn't warn on parenthesized stringification (endpoint)";
}

# vim: ft=perl6
