use v6;
use Test;
plan 101;

#L<S02/Literals>
# TODO:
#
# * review shell quoting semantics of «»
# * arrays in «»

#L<S02/C<Q> Forms/halfwidth corner brackets>
{

    my $s = ｢this is a string\n｣;
    is $s, Q[this is a string\n],
        'Shortform for Q[...] is ｢...｣ (HALFWIDTH LEFT/RIGHT CORNER BRACKET)';
}

{
    my $s = q「this is a string」;
    is $s, 'this is a string',
        'q-style string with LEFT/RIGHT CORNER BRACKET';
}

{
    my $s = q『blah blah blah』;
    is $s, 'blah blah blah',
        'q-style string with LEFT/RIGHT WHITE CORNER BRACKET';
}

{
    my $s = q〝blah blah blah〞;
    is $s, 'blah blah blah',
        'q-style string with REVERSED DOUBLE PRIME QUOTATION MARK and
 DOUBLE PRIME QUOTATION MARK(U+301D/U+301E)';
}

{
    my $upper-tick = 'q' ~ '⦍' ~ 'abc' ~ '⦐';
    my $lower-tick = 'q' ~ '⦏' ~ 'abc' ~ '⦎';
    is EVAL($upper-tick), 'abc',
        "q-style string with LEFT SQUARE BRACKET WITH TICK IN TOP CORNER " ~
        "and RIGHT SQUARE BRACKET WITH TICK IN TOP CORNER(U+298D/U+2990)";
    is EVAL($lower-tick), 'abc',
        "q-style string with LEFT SQUARE BRACKET WITH TICK IN BOTTOM CORNER " ~
        "and RIGHT SQUARE BRACKET WITH TICK IN BOTTOM CORNER(U+298F/U+298E)";
}
{
    my @ps_pe = (
            '(' => ')', '[' => ']', '{' => '}', '༺' => '༻', '༼' => '༽',
            '᚛' => '᚜', '⁅' => '⁆', '⁽' => '⁾', '₍' => '₎', '〈' => '〉',
            '❨' => '❩', '❪' => '❫', '❬' => '❭', '❮' => '❯', '❰' => '❱',
            '❲' => '❳', '❴' => '❵', '⟅' => '⟆', '⟦' => '⟧', '⟨' => '⟩',
            '⟪' => '⟫', '⦃' => '⦄', '⦅' => '⦆', '⦇' => '⦈', '⦉' => '⦊',
            '⦋' => '⦌', '⦑' => '⦒', '⦓' => '⦔',
            '⦕' => '⦖', '⦗' => '⦘', '⧘' => '⧙', '⧚' => '⧛', '⧼' => '⧽',
            '〈' => '〉', '《' => '》', '「' => '」', '『' => '』',
            '【' => '】', '〔' => '〕', '〖' => '〗', '〘' => '〙',
            '〚' => '〛', '〝' => '〞', '︗' => '︘', '︵' => '︶',
            '︷' => '︸', '︹' => '︺', '︻' => '︼', '︽' => '︾',
            '︿' => '﹀', '﹁' => '﹂', '﹃' => '﹄', '﹇' => '﹈',
            '﹙' => '﹚', '﹛' => '﹜', '﹝' => '﹞', '（' => '）',
            '［' => '］', '｛' => '｝', '｟' => '｠', '｢' => '｣',
            '⸨' => '⸩',
            );
    for @ps_pe {
        next if .key eq '('; # skip '(' => ')' because q() is a sub call
        my $string = 'q' ~ .key ~ 'abc' ~ .value;
        is EVAL($string), 'abc', $string ~ sprintf(' (U+%X/U+%X)',.key.ord,.value.ord);
    }
}

{
    my @list = 'a'..'c';

    my $var = @list[ q（2） ];
    is $var, 'c',
        'q-style string with FULLWIDTH LEFT/RIGHT PARENTHESIS';

    $var = @list[ q《0》];
    is $var, 'a',
        'q-style string with LEFT/RIGHT DOUBLE ANGLE BRACKET';

    $var = @list[q〈1〉];
    is $var, 'b', 'q-style string with LEFT/RIGHT ANGLE BRACKET';
}

# https://github.com/Raku/old-issue-tracker/issues/1049
{
    throws-like { EVAL "q\c[SNOWMAN].\c[COMET]" },
      X::Comp,
      "Can't quote a string with a snowman and comet (U+2603 and U+2604)";
    throws-like { EVAL "'RT #66498' ~~ m\c[SNOWMAN].\c[COMET]" },
      X::Comp::Group,
      "Can't quote a regex with a snowman and comet (U+2603 and U+2604)";
}

# curly quotes
{
    is ‘"Beth's Cafe"’, “"Beth's Cafe"”, "curly “” quotes are accepted and not confused with ASCII quotes";
    throws-like { EVAL '“phooey"' },
	X::Comp,
	"Can't mix curly quote with ASCII quote";
    is ‘"Beth's Cafe"’, „"Beth's Cafe"”, "curly „” quotes are accepted and not confused with ASCII quotes";
    throws-like { EVAL '“phooey"' },
	X::Comp,
	"Can't mix curly quote with ASCII quote";
    is ‘"Beth's Cafe"’, „"Beth's Cafe"“, "curly „“ quotes are accepted and not confused with ASCII quotes";

    is ‘"Beth's Cafe"’, ‘"Beth's Cafe"’, "curly ‘’ quotes are accepted and not confused with ASCII quotes";
    throws-like { EVAL "‘phooey'" },
	X::Comp,
	"Can't mix curly quote with ASCII quote";
    is ‘"Beth's Cafe"’, ‚"Beth's Cafe"’, "curly ‚’ quotes are accepted and not confused with ASCII quotes";
    throws-like { EVAL "‚phooey'" },
	X::Comp,
	"Can't mix curly quote with ASCII quote";
    is ‘"Beth's Cafe"’, ‚"Beth's Cafe"‘, "curly ‚‘ quotes are accepted and not confused with ASCII quotes";

    # Allow Swedish, Finnish, Serbian, and Macedonian quotes

    is ‘"Beth's Cafe"’, ”"Beth's Cafe"”, "curly ”” quotes are accepted and not confused with ASCII quotes";
    throws-like { EVAL '”phooey"' },
	X::Comp,
	"Can't mix curly quote with ASCII quote";
    is ‘"Beth's Cafe"’, ”"Beth's Cafe"“, "curly ”“ quotes are accepted and not confused with ASCII quotes";

    is ‘"Beth's Cafe"’, ’"Beth's Cafe"’, "curly ’’ quotes are accepted and not confused with ASCII quotes";
    throws-like { EVAL "’phooey'" },
	X::Comp,
	"Can't mix curly quote with ASCII quote";
    is ‘"Beth's Cafe"’, ’"Beth's Cafe"‘, "curly ’‘ quotes are accepted and not confused with ASCII quotes";
}

# [Issue 1204](https://github.com/rakudo/rakudo/issues/1204)
#
# This block does not exhaustively test arrays in « »
# That is still a todo item, (see todo block at top of file)
{
    my $x = '5 6';
    my @a = 'a', 'b';

    cmp-ok    « $x », '!~~', Slip,  'Single interpolated Scalar does not return as Slip';
    is-deeply « $x », ( <5>, <6> ), 'Single interpolated Scalar correct result';

    cmp-ok    « @a[] », '!~~', Slip, 'Single interpolated Array does not return as Slip';
    is-deeply « @a[] », ('a', 'b'),  'Single interpolated Array correct result';

    cmp-ok    « {21*2} », '!~~', Slip, 'Single interpolated block does not return as Slip';
    is-deeply « {21*2} », (<42>),      'Single interpolated block correct result';

    is-deeply « "$x" », '5 6', 'Single interpolated value in dbl quotes, preserves String';

    is-deeply « z$x », ( 'z', <5>, <6> ),
        'Literal directly precedes interpolated Scalar, no nested List produced';

    is-deeply « z@a[] », ( 'z', 'a', 'b' ),
        'Literal directly precedes interpolated Array, no nested List produced';
    is-deeply « @a[]z », ( 'a', 'b', 'z' ),
        'Literal directly follows interpolated Array, no nested List produced';

    is-deeply « z{21*2} », ( 'z', <42> ),
        'Literal directly precedes interpolated block, no nested List produced';
    is-deeply « {21*2}z », ( <42>, 'z' ),
        'Literal directly follows interpolated block, no nested List produced';

    is-deeply « y{21*2}$x@a[]z », ( 'y', <42>, <5>, <6>, 'a', 'b', 'z' ),
        'Literals directly bookend multiple interpolated, no nested Lists';
}

# vim: expandtab shiftwidth=4
