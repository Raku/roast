use v6;
use Test;

plan 70;

#L<S02/Literals>
# TODO:
# 
# * review shell quoting semantics of «»
# * arrays in «»

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
    my $s = q⦍blah blah blah⦎;
    is $s, 'blah blah blah',
        'q-style string with LEFT SQUARE BRACKET WITH TICK IN TOP CORNER and
RIGHT SQUARE BRACKET WITH TICK IN BOTTOM CORNER(U+298D/U+298E)';
}

{
    my $s = q〝blah blah blah〞;
    is $s, 'blah blah blah',
        'q-style string with REVERSED DOUBLE PRIME QUOTATION MARK and 
DOUBLE PRIME QUOTATION MARK(U+301D/U+301E)';
}

#?DOES 70
#?rakudo skip 'unicode'
{
    my %ps_pe = (
            '(' => ')', '[' => ']', '{' => '}', '༺' => '༻', '༼' => '༽',
            '᚛' => '᚜', '⁅' => '⁆', '⁽' => '⁾', '₍' => '₎', '〈' => '〉',
            '❨' => '❩', '❪' => '❫', '❬' => '❭', '❮' => '❯', '❰' => '❱', 
            '❲' => '❳', '❴' => '❵', '⟅' => '⟆', '⟦' => '⟧', '⟨' => '⟩', 
            '⟪' => '⟫', '⦃' => '⦄', '⦅' => '⦆', '⦇' => '⦈', '⦉' => '⦊',
            '⦋' => '⦌', '⦍' => '⦎', '⦏' => '⦐', '⦑' => '⦒', '⦓' => '⦔', 
            '⦕' => '⦖', '⦗' => '⦘', '⧘' => '⧙', '⧚' => '⧛', '⧼' => '⧽', 
            '〈' => '〉', '《' => '》', '「' => '」', '『' => '』', 
            '【' => '】', '〔' => '〕', '〖' => '〗', '〘' => '〙', 
            '〚' => '〛', '〝' => '〞', '﴾' => '﴿', '︗' => '︘', '︵' => '︶',
            '︷' => '︸', '︹' => '︺', '︻' => '︼', '︽' => '︾',
            '︿' => '﹀', '﹁' => '﹂', '﹃' => '﹄', '﹇' => '﹈',
            '﹙' => '﹚', '﹛' => '﹜', '﹝' => '﹞', '（' => '）', 
            '［' => '］', '｛' => '｝', '｟' => '｠', '｢' => '｣',
            );
    for keys %ps_pe {
        next if $_ eq '('; # skip '(' => ')' because q() is a sub call 
        my $string = 'q' ~ $_ ~ 'abc' ~ %ps_pe{$_};
        is eval($string), 'abc', $string;
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
