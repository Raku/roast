use v6;

use Test;

# L<S05/Extensible metasyntax (C<< <...> >>)/"The special named assertions include">

plan 17;

#?niecza skip 'Tests not completing under niecza'
{
    my $latin-chars = [~] chr(0)..chr(0xFF);

    is $latin-chars.comb(/<ident>/).join(" "), "ABCDEFGHIJKLMNOPQRSTUVWXYZ _ abcdefghijklmnopqrstuvwxyz ª µ º ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö øùúûüýþÿ", 'ident chars';

    is $latin-chars.comb(/<alpha>/).join, "ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyzªµºÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ", 'alpha chars';

    is $latin-chars.comb(/<space>/)>>.ord.join(","), ((9..13,32,133,160).join(",")), 'space chars';

    is $latin-chars.comb(/<digit>/).join, "0123456789", 'digit chars';

    is $latin-chars.comb(/<alnum>/).join, "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyzªµºÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ", 'alnum chars';

    #?rakudo.parrot todo 'blank characters'
    is $latin-chars.comb(/<blank>/)>>.ord.join(","), '9,32,160', 'blank chars';

    is $latin-chars.comb(/<cntrl>/)>>.ord.join(","), ((0..31, 127..159).join(",")), 'cntrl chars';

    #?rakudo.jvm todo 'Unicode 6.3 -- lower characters'
    is $latin-chars.comb(/<lower>/).join, "abcdefghijklmnopqrstuvwxyzµßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ", 'lower chars';

    # unicode 6.0 reclassifies § and ¶ as punctuation characters, so actual results may vary depending on
    # on unicode version bundled with jdk, icu etc.
    #?rakudo.parrot todo 'punct characters'
    #?rakudo.jvm todo 'Unicode 6.3 -- punct characters'
    is $latin-chars.comb(/<punct>/).join, q<!"#%&'()*,-./:;?@[\]_{}¡§«¶·»¿>, 'punct chars';
    #?rakudo.jvm todo 'Unicode 6.3 -- punct characters'
    is $latin-chars.comb(/<:Punctuation>/).join, q<!"#%&'()*,-./:;?@[\]_{}¡§«¶·»¿>, ':Punctuation chars';

    is $latin-chars.comb(/<upper>/).join, "ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞ", 'upper chars';

    is $latin-chars.comb(/<xdigit>/).join, "0123456789ABCDEFabcdef", 'xdigit chars';

    is $latin-chars.comb(/<:Letter>/).join, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzªµºÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ", 'unicode Letter chars';

    is $latin-chars.comb(/<+ xdigit - lower >/).join, "0123456789ABCDEF", 'combined builtin classes';
    is $latin-chars.comb(/<+ :HexDigit - :Upper >/).join, "0123456789abcdef", 'combined unicode classes';
    is $latin-chars.comb(/<+ :HexDigit - lower >/).join, "0123456789ABCDEF", 'combined unicode and builtins';

}

# RT #121365
{
    'o' ~~ /<:!Upper>*/;
    is ~$/, 'o', 'Can match negated quantified character class';
}
