use v6;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;

=begin pod

String transliteration

=end pod

# L<S05/Transliteration>

plan 65;

is("ABC".trans( ('A'=>'a'), ('B'=>'b'), ('C'=>'c') ),
    "abc",
    "Each side can be individual characters");

is("XYZ".trans( ('XYZ' => 'xyz') ),
    "xyz",
    "The two sides of the any pair can be strings interpreted as tr/// would multichar");

is("ABC".trans( ('A..C' => 'a..c') ),
    "abc",
    "The two sides of the any pair can be strings interpreted as tr/// would range");

is("ABC-DEF".trans(("- AB..Z" => "_ a..z")),
    "abc_def",
    "If the first character is a dash it isn't part of a range");

is("ABC-DEF".trans(("A..YZ-" => "a..z_")),
    "abc_def",
    "If the last character is a dash it isn't part of a range");

is("ABCDEF".trans( ('AB..E' => 'ab..e') ),
    "abcdeF",
    "The two sides can consists of both chars and ranges");

is("ABCDEFGH".trans( ('A..CE..G' => 'a..ce..g') ),
    "abcDefgH",
    "The two sides can consist of multiple ranges");

is("ABCXYZ".trans( (['A'..'C'] => ['a'..'c']), (<X Y Z> => <x y z>) ),
    "abcxyz",
    "The two sides of each pair may also be array references" );

is("abcde".trans( ('a..e' => 'A'..'E') ), "ABCDE",
	   "Using string range on one side and array reference on the other");

is("ABCDE".trans( (['A' .. 'E'] => "a..e") ), "abcde",
	   "Using array reference on one side and string range on the other");

is("&nbsp;&lt;&gt;&amp;".trans( (['&nbsp;', '&lt;', '&gt;', '&amp;'] =>
    [' ',      '<',    '>',    '&'     ])),
    " <>&","The array version can map one characters to one-or-more characters");

is(" <>&".trans( ([' ',      '<',    '>',    '&'    ] =>
                  ['&nbsp;', '&lt;', '&gt;', '&amp;' ])),
                  "&nbsp;&lt;&gt;&amp;",
    "The array version can map one-or-more characters to one-or-more characters");

is("&nbsp;&lt;&gt;&amp;".trans( (['&nbsp;', '&nbsp;&lt;', '&lt;', '&gt;', '&amp;'] =>
                                 [' ',      'AB',         '<',    '>',    '&'    ])),
                                "AB>&",
    "The array version can map one characters to one-or-more characters, using leftmost longest match");

is("Whfg nabgure Crey unpxre".trans('a'..'z' => ['n'..'z','a'..'m'], 'A'..'Z' => ['N'..'Z','A'..'M']),
    "Just another Perl hacker",
    "Ranges can be grouped");

is("Whfg nabgure Crey unpxre".trans('a..z' => 'n..za..m', 'A..Z' => 'N..ZA..M'),
    "Just another Perl hacker",
    "Multiple ranges interpreted in string");

# Per S05 changes
{
is("Whfg nabgure Crey unpxre".trans(' a..z' => '_n..za..m', 'A..Z' => 'N..ZA..M'),
    "Just_another_Perl_hacker",
    "Spaces in interpreted ranges are not skipped (all spaces are important)");
is("Whfg nabgure Crey unpxre".trans('a .. z' => 'n .. za .. m', 'A .. Z' => 'N .. ZA .. M'),
    "Whfg nnbgure Crey unpxre",
    "Spaces in interpreted ranges are not skipped (all spaces are important)");
};

my $a = "abcdefghijklmnopqrstuvwxyz";

my $b = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

is($a.trans('a..z' => 'A..Z'), $b);

is($b.trans('A..Z' => 'a..z'), $a);

is($a.trans('b..y' => 'B..Y'), 'aBCDEFGHIJKLMNOPQRSTUVWXYz');

is("I\xcaJ".trans('I..J' => 'i..j'), "i\xcaj");

is("\x12c\x190".trans("\x12c" => "\x190"), "\x190\x190");

# should these be combined?
is($b.trans('A..H..Z' => 'a..h..z'), $a,
    'ambiguous ranges combined');

is($b.trans('..H..Z' => '__h..z'),
    'ABCDEFGhijklmnopqrstuvwxyz',
    'leading ranges interpreted as string');

is($b.trans('A..H..' => 'a..h__'), 'abcdefghIJKLMNOPQRSTUVWXYZ',
    'trailing ranges interpreted as string');

is($b.trans('..A..H..' => '__a..h__'), 'abcdefghIJKLMNOPQRSTUVWXYZ',
    'leading, trailing ranges interpreted as string');

# added as a consequence of RT #76720
is("hello".trans("l" => ""), "heo", "can replace with empty string");

# complement, squeeze/squash, delete

is('bookkeeper'.trans(:s, 'a..z' => 'a..z'), 'bokeper',
    ':s flag (squash)');

is('bookkeeper'.trans(:d, 'ok' => ''), 'beeper',
    ':d flag (delete)');

is('ABC123DEF456GHI'.trans('A..Z' => 'x'), 'xxx123xxx456xxx',
    'no flags');

is('ABC123DEF456GHI'.trans(:c, 'A..Z' => 'x'),'ABCxxxDEFxxxGHI',
    '... with :c');

is('ABC111DEF222GHI'.trans(:s, '0..9' => 'x'),'ABCxDEFxGHI',
    '... with :s');

is('ABC111DEF222GHI'.trans(:c, :s, 'A..Z' => 'x'),'ABCxDEFxGHI',
    '... with :s and :c');

is('ABC111DEF222GHI'.trans(:c, :d, 'A..Z' => ''),'ABCDEFGHI',
    '... with :d and :c');

is('Good&Plenty'.trans('len' => 'x'), 'Good&Pxxxty',
    'no flags');

is('Good&Plenty'.trans(:s, 'len' => 'x',), 'Good&Pxty',
    'squashing depends on replacement repeat, not searchlist repeat');

is('Good&Plenty'.trans(:s, 'len' => 't'), 'Good&Ptty',
    'squashing depends on replacement repeat, not searchlist repeat');

# also checks that :c uses the first element in array (or first char in string)
is("&nbsp;&lt;&gt;&amp;".trans(:c, (['&nbsp;', '&gt;', '&amp;'] =>
    ['???',      'AB',     '>',    '&'    ])),
    '&nbsp;????????????&gt;&amp;',
    'array, many-to-many transliteration, complement');

# fence-post issue with complement
is("&nbsp;&lt;&gt;&amp;".trans(:c, (['&nbsp;', '&gt;'] =>
    ['???',      'AB'])),
    '&nbsp;????????????&gt;???????????????',
    'fence-post issue (make sure to replace end bits as well)');

is("&nbsp;&lt;&gt;&amp;".trans(:c, :s, (['&nbsp;', '&gt;', '&amp;'] =>
    ['???'])),
    '&nbsp;???&gt;&amp;',
    '... and now complement and squash');

{
# remove vowel and character after
    is('abcdefghij'.trans(/<[aeiou]> \w/ => ''), 'cdgh', 'basic regex works');
    is( # vowels become 'y' and whitespace becomes '_'
        "ab\ncd\tef gh".trans(/<[aeiou]>/ => 'y', /\s/ => '_'),
        'yb_cd_yf_gh',
        'regexes pairs work',
    );

    my $i = 0;
    is('ab_cd_ef_gh'.trans('_' => {$i++}), 'ab0cd1ef2gh', 'basic closure');

    $i = 0;
    my $j = 0;
    is(
        'a_b/c_d/e_f'.trans('_' => {$i++}, '/' => {$j++}),
        'a0b0c1d1e2f',
        'closure pairs work',
    );
};

{
    # closures and regexes!
    is(
        '[36][38][43]'.trans(/\[(\d+)\]/ => {chr($0)}),
        '$&+',
        'closure and regex'
    );

    is(
        '"foo  &   bar"'.trans(
            /(' '+)/ => {' ' ~ ('&nbsp;' x ($0.chars - 1))},
            /(\W)/ => {"&#{ord($0)};"}
        ),
        '&#34;foo &nbsp;&#38; &nbsp;&nbsp;bar&#34;',
        'pairs of regexes and closures',
    );
}

{
    #?rakudo skip 'feed operator NYI'
    is(EVAL('"abc".trans(<== "a" => "A")'), "Abc",
        "you're allowed to leave off the (...) named arg parens when you use <==");

    # Make sure the tr/// version works, too.

    $_ = "ABC";
    tr/ABC/abc/;
    is($_, 'abc', 'tr/// on $_ with explicit character lists');

    $_ = "abc";
    tr|a..c|A..C|;
    is($_, 'ABC', 'tr||| on $_ with character range');

    my $japh = "Whfg nabgure Crey unpxre";
    $japh ~~ tr[a..zA..Z][n..za..mN..ZA..M];
    is($japh, "Just another Perl hacker", 'tr[][] on lexical var via ~~');

    $_ = '$123';
    tr/$123/X\x20\o40\t/;
    is($_, "X  \t", 'tr/// on $_ with explicit character lists');
}

# y/// is dead
throws-like '$_ = "axbycz"; y/abc/def/', X::Obsolete, 'y/// does not exist any longer';

# RT #71088
{
    lives-ok { "".subst(/x/, "").trans() },
        'trans on subst output lives';
}

is('aaaaabbbbb'.trans(['aaa', 'aa', 'bb', 'bbb'] => ['1', '2', '3', '4']),
   '1243',
   'longest constant token preferred, regardless of declaration order');

is('foobar'.trans(/\w+/ => 'correct', /foo/ => 'RONG'), 'correct',
   'longest regex token preferred, regardless of declaration order');

is('aaaa'.trans(/a/ => '1', /\w/ => '2', /./ => '3'), '1111',
   'in case of a tie between regex lengths, prefer the first one');

is('ababab'.trans([/ab/, 'aba', 'bab', /baba/] =>
                   ['1',  '2',   '3',   '4'   ]),
   '23',
   'longest token still holds, even between constant strings and regexes');

is 'aa'.trans(/^a/ => 'b'), 'ba', 'trans with anchored regex';
is 'aa'.trans(/ <after a> ./ => 'b'), 'ab', 'trans with look-around regex';

# RT #83674
lives-ok { my @a = 1..2; @a>>.trans((1..2) => (14..15,1..2)); }, 'trans works with Cool signature';

# RT #83766
is((1, 2)>>.trans((1..26) => (14..26,1..13)), <14 15>, '.trans with a pair of lists using postfix hypermetaoperator works');
is ("!$_!" for (1, 2)>>.trans((1..26) => (14..26,1..13))), <!14! !15!>, "same with explicit for";

{
    my $f = "foo";
    ok $f ~~ tr/o/u/ eq 'fuu', 'StrDistance stringifies to $!after'
}

# RT #129258
subtest 'Adverbs on Cool.trans work the same as on Str.trans' => {
    is-deeply 912381237    .trans(['7'..'9'] => '0',      :complement),
        '900080007',                                      ':complement';
    is-deeply 912381237    .trans(      '23' => '',       :delete),
        '91817',                                          ':delete';
    is-deeply 9991123881237.trans(  '7'..'9' => '4'..'6', :squash),
        '6112351234',                                     ':squash';
    is-deeply 9991123881237.trans(  '7'..'9' => '0',      :complement, :squash),
        '99908807',                                      ':complement, :squash';
}

# https://irclog.perlgeek.de/perl6/2016-12-06#i_13692293
is_run ｢print '@x'.trans: (/\@/ => '-',), :c｣, {
    :out('@-'), :err(''),
}, '.trans with complement regex pair does not produce spurious warnings';

# vim: ft=perl6
