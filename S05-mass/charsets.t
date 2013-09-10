use v6;

use Test;

=begin pod

tests over character sets. currently limited to ascii.

=end pod

# L<S05/Extensible metasyntax (C<< <...> >>)/"The special named assertions include">

plan 11;

#?niecza skip 'Tests not completing under niecza'
{
    my $ascii-chars = [~] chr(0)..chr(0xFF);

    is $ascii-chars.comb(/<ident>/).join(" "), "ABCDEFGHIJKLMNOPQRSTUVWXYZ _ abcdefghijklmnopqrstuvwxyz ª µ º ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö øùúûüýþÿ", 'ident chars';

    is $ascii-chars.comb(/<alpha>/).join, "ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyzªµºÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ", 'alpha chars';

    is $ascii-chars.comb(/<space>/)>>.ord.join(","), ([~] (9..13,32,133,160).join(",")), 'space chars';

    is $ascii-chars.comb(/<digit>/).join, "0123456789", 'digit chars';

    is $ascii-chars.comb(/<alnum>/).join, "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyzªµºÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ", 'alnum chars';

    #?rakudo.parrot todo 'blank characters'
    is $ascii-chars.comb(/<blank>/)>>.ord.join(","), '9,32,160', 'blank chars';

    is $ascii-chars.comb(/<cntrl>/)>>.ord.join(","), ([~] (0..31, 127..159).join(",")), 'cntrl chars';

    #?rakudo.parrot todo 'lower characters'
    is $ascii-chars.comb(/<lower>/).join, "abcdefghijklmnopqrstuvwxyzªµºßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ", 'lower chars';

    #?rakudo.parrot todo 'punct characters'
    is $ascii-chars.comb(/<punct>/).join, q<!"#%&'()*,-./:;?@[\]_{}¡«·»¿>, 'punct chars';

    is $ascii-chars.comb(/<upper>/).join, "ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞ", 'upper chars';

    is $ascii-chars.comb(/<xdigit>/).join, "0123456789ABCDEFabcdef", 'xdigit chars';

}
