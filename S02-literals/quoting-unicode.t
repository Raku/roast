use v6;
use Test;
plan 89;

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
            '᚛' => '᚜', '⁅' => '⁆', '⁽' => '⁾', '₍' => '₎', '〈' => '〉',
            '❨' => '❩', '❪' => '❫', '❬' => '❭', '❮' => '❯', '❰' => '❱',
            '❲' => '❳', '❴' => '❵', '⟅' => '⟆', '⟦' => '⟧', '⟨' => '⟩',
            '⟪' => '⟫', '⦃' => '⦄', '⦅' => '⦆', '⦇' => '⦈', '⦉' => '⦊',
            '⦋' => '⦌', '⦑' => '⦒', '⦓' => '⦔',
            '⦕' => '⦖', '⦗' => '⦘', '⧘' => '⧙', '⧚' => '⧛', '⧼' => '⧽',
            '〈' => '〉', '《' => '》', '「' => '」', '『' => '』',
            '【' => '】', '〔' => '〕', '〖' => '〗', '〘' => '〙',
            '〚' => '〛', '〝' => '〞', '﴾' => '﴿', '︗' => '︘', '︵' => '︶',
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

# RT #66498
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
# vim: ft=perl6
