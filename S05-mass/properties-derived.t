use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/properties_slow_to_compile.t.

XXX needs more clarification on the case of the rules, 
ie letter vs. Letter vs isLetter

Some notes regarding specific unicode codepoints chosen below
(based on Unicode 5.1):

   U+9FC4 : just beyond the CJK Unified Ideographs block

=end pod

plan 256;

# ASCIIHexDigit

ok("\c[DIGIT ZERO]" ~~ m/^<:ASCIIHexDigit>$/, q{Match <:ASCIIHexDigit>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:!ASCIIHexDigit>$/ ), q{Don't match negated <isASCIIHexDigit>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-:ASCIIHexDigit>$/ ), q{Don't match inverted <isASCIIHexDigit>} );
ok(!( "\x[53BA]"  ~~ m/^<:ASCIIHexDigit>$/ ), q{Don't match unrelated <isASCIIHexDigit>} );
ok("\x[53BA]"  ~~ m/^<:!ASCIIHexDigit>$/, q{Match unrelated negated <isASCIIHexDigit>} );
ok("\x[53BA]"  ~~ m/^<-:ASCIIHexDigit>$/, q{Match unrelated inverted <isASCIIHexDigit>} );
ok("\x[53BA]\c[DIGIT ZERO]" ~~ m/<:ASCIIHexDigit>/, q{Match unanchored <isASCIIHexDigit>} );

# Dash


ok("\c[HYPHEN-MINUS]" ~~ m/^<:Dash>$/, q{Match <:Dash>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<:!Dash>$/ ), q{Don't match negated <isDash>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<-:Dash>$/ ), q{Don't match inverted <isDash>} );
ok(!( "\x[53F7]"  ~~ m/^<:Dash>$/ ), q{Don't match unrelated <isDash>} );
ok("\x[53F7]"  ~~ m/^<:!Dash>$/, q{Match unrelated negated <isDash>} );
ok("\x[53F7]"  ~~ m/^<-:Dash>$/, q{Match unrelated inverted <isDash>} );
ok("\x[53F7]\c[HYPHEN-MINUS]" ~~ m/<:Dash>/, q{Match unanchored <isDash>} );

# Diacritic


ok("\c[MODIFIER LETTER CAPITAL A]" ~~ m/^<:Diacritic>$/, q{Match <:Diacritic>} );
ok(!( "\c[MODIFIER LETTER CAPITAL A]" ~~ m/^<:!Diacritic>$/ ), q{Don't match negated <isDiacritic>} );
ok(!( "\c[MODIFIER LETTER CAPITAL A]" ~~ m/^<-:Diacritic>$/ ), q{Don't match inverted <isDiacritic>} );
ok(!( "\x[1BCD]"  ~~ m/^<:Diacritic>$/ ), q{Don't match unrelated <isDiacritic>} );
ok("\x[1BCD]"  ~~ m/^<:!Diacritic>$/, q{Match unrelated negated <isDiacritic>} );
ok("\x[1BCD]"  ~~ m/^<-:Diacritic>$/, q{Match unrelated inverted <isDiacritic>} );
ok("\x[1BCD]\c[MODIFIER LETTER CAPITAL A]" ~~ m/<:Diacritic>/, q{Match unanchored <isDiacritic>} );

# Extender


ok("\c[MIDDLE DOT]" ~~ m/^<:Extender>$/, q{Match <:Extender>} );
ok(!( "\c[MIDDLE DOT]" ~~ m/^<:!Extender>$/ ), q{Don't match negated <isExtender>} );
ok(!( "\c[MIDDLE DOT]" ~~ m/^<-:Extender>$/ ), q{Don't match inverted <isExtender>} );
ok(!( "\x[3A18]"  ~~ m/^<:Extender>$/ ), q{Don't match unrelated <isExtender>} );
ok("\x[3A18]"  ~~ m/^<:!Extender>$/, q{Match unrelated negated <isExtender>} );
ok("\x[3A18]"  ~~ m/^<-:Extender>$/, q{Match unrelated inverted <isExtender>} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[3A18]\c[MIDDLE DOT]" ~~ m/<:Extender>/, q{Match unanchored <isExtender>} );

# GraphemeLink


#?rakudo 7 skip "isGraphemeLink"
ok("\c[COMBINING GRAPHEME JOINER]" ~~ m/^<:GraphemeLink>$/, q{Match <:GraphemeLink>} );
ok(!( "\c[COMBINING GRAPHEME JOINER]" ~~ m/^<:!GraphemeLink>$/ ), q{Don't match negated <isGraphemeLink>} );
ok(!( "\c[COMBINING GRAPHEME JOINER]" ~~ m/^<-:GraphemeLink>$/ ), q{Don't match inverted <isGraphemeLink>} );
ok(!( "\x[4989]"  ~~ m/^<:GraphemeLink>$/ ), q{Don't match unrelated <isGraphemeLink>} );
ok("\x[4989]"  ~~ m/^<:!GraphemeLink>$/, q{Match unrelated negated <isGraphemeLink>} );
ok("\x[4989]"  ~~ m/^<-:GraphemeLink>$/, q{Match unrelated inverted <isGraphemeLink>} );
ok("\x[4989]\c[COMBINING GRAPHEME JOINER]" ~~ m/<:GraphemeLink>/, q{Match unanchored <isGraphemeLink>} );

# HexDigit


ok("\c[DIGIT ZERO]" ~~ m/^<:HexDigit>$/, q{Match <:HexDigit>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:!HexDigit>$/ ), q{Don't match negated <isHexDigit>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-:HexDigit>$/ ), q{Don't match inverted <isHexDigit>} );
ok(!( "\x[6292]"  ~~ m/^<:HexDigit>$/ ), q{Don't match unrelated <isHexDigit>} );
ok("\x[6292]"  ~~ m/^<:!HexDigit>$/, q{Match unrelated negated <isHexDigit>} );
ok("\x[6292]"  ~~ m/^<-:HexDigit>$/, q{Match unrelated inverted <isHexDigit>} );
ok("\x[6292]\c[DIGIT ZERO]" ~~ m/<:HexDigit>/, q{Match unanchored <isHexDigit>} );

# Hyphen

ok("\c[KATAKANA MIDDLE DOT]" ~~ m/^<:Hyphen>$/, q{Match <:Hyphen>} );
ok(!( "\c[KATAKANA MIDDLE DOT]" ~~ m/^<:!Hyphen>$/ ), q{Don't match negated <isHyphen>} );
ok(!( "\c[KATAKANA MIDDLE DOT]" ~~ m/^<-:Hyphen>$/ ), q{Don't match inverted <isHyphen>} );
ok(!( "\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]"  ~~ m/^<:Hyphen>$/ ), q{Don't match unrelated <isHyphen>} );
ok("\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]"  ~~ m/^<:!Hyphen>$/, q{Match unrelated negated <isHyphen>} );
ok("\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]"  ~~ m/^<-:Hyphen>$/, q{Match unrelated inverted <isHyphen>} );
ok("\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]\c[KATAKANA MIDDLE DOT]" ~~ m/<:Hyphen>/, q{Match unanchored <isHyphen>} );

# Ideographic


ok("\x[8AB0]" ~~ m/^<:Ideographic>$/, q{Match <:Ideographic>} );
ok(!( "\x[8AB0]" ~~ m/^<:!Ideographic>$/ ), q{Don't match negated <isIdeographic>} );
ok(!( "\x[8AB0]" ~~ m/^<-:Ideographic>$/ ), q{Don't match inverted <isIdeographic>} );
#?rakudo 3 skip 'icu problems'
ok(!( "\x[9FC4]"  ~~ m/^<:Ideographic>$/ ), q{Don't match unrelated <isIdeographic>} );
ok("\x[9FC4]"  ~~ m/^<:!Ideographic>$/, q{Match unrelated negated <isIdeographic>} );
ok("\x[9FC4]"  ~~ m/^<-:Ideographic>$/, q{Match unrelated inverted <isIdeographic>} );
ok("\x[9FC4]\x[8AB0]" ~~ m/<:Ideographic>/, q{Match unanchored <isIdeographic>} );

# IDSBinaryOperator


ok("\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<:IDSBinaryOperator>$/, q{Match <:IDSBinaryOperator>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<:!IDSBinaryOperator>$/ ), q{Don't match negated <isIDSBinaryOperator>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<-:IDSBinaryOperator>$/ ), q{Don't match inverted <isIDSBinaryOperator>} );
ok(!( "\x[59E9]"  ~~ m/^<:IDSBinaryOperator>$/ ), q{Don't match unrelated <isIDSBinaryOperator>} );
ok("\x[59E9]"  ~~ m/^<:!IDSBinaryOperator>$/, q{Match unrelated negated <isIDSBinaryOperator>} );
ok("\x[59E9]"  ~~ m/^<-:IDSBinaryOperator>$/, q{Match unrelated inverted <isIDSBinaryOperator>} );
ok("\x[59E9]\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/<:IDSBinaryOperator>/, q{Match unanchored <isIDSBinaryOperator>} );

# IDSTrinaryOperator

ok("\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/^<:IDSTrinaryOperator>$/, q{Match <:IDSTrinaryOperator>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/^<:!IDSTrinaryOperator>$/ ), q{Don't match negated <isIDSTrinaryOperator>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/^<-:IDSTrinaryOperator>$/ ), q{Don't match inverted <isIDSTrinaryOperator>} );
ok(!( "\x[9224]"  ~~ m/^<:IDSTrinaryOperator>$/ ), q{Don't match unrelated <isIDSTrinaryOperator>} );
ok("\x[9224]"  ~~ m/^<:!IDSTrinaryOperator>$/, q{Match unrelated negated <isIDSTrinaryOperator>} );
ok("\x[9224]"  ~~ m/^<-:IDSTrinaryOperator>$/, q{Match unrelated inverted <isIDSTrinaryOperator>} );
ok("\x[9224]\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/<:IDSTrinaryOperator>/, q{Match unanchored <isIDSTrinaryOperator>} );

# JoinControl


ok("\c[ZERO WIDTH NON-JOINER]" ~~ m/^<:JoinControl>$/, q{Match <:JoinControl>} );
ok(!( "\c[ZERO WIDTH NON-JOINER]" ~~ m/^<:!JoinControl>$/ ), q{Don't match negated <isJoinControl>} );
ok(!( "\c[ZERO WIDTH NON-JOINER]" ~~ m/^<-:JoinControl>$/ ), q{Don't match inverted <isJoinControl>} );
ok(!( "\c[BENGALI LETTER DDHA]"  ~~ m/^<:JoinControl>$/ ), q{Don't match unrelated <isJoinControl>} );
ok("\c[BENGALI LETTER DDHA]"  ~~ m/^<:!JoinControl>$/, q{Match unrelated negated <isJoinControl>} );
ok("\c[BENGALI LETTER DDHA]"  ~~ m/^<-:JoinControl>$/, q{Match unrelated inverted <isJoinControl>} );
ok("\c[BENGALI LETTER DDHA]\c[ZERO WIDTH NON-JOINER]" ~~ m/<:JoinControl>/, q{Match unanchored <isJoinControl>} );

# LogicalOrderException


ok("\c[THAI CHARACTER SARA E]" ~~ m/^<:LogicalOrderException>$/, q{Match <:LogicalOrderException>} );
ok(!( "\c[THAI CHARACTER SARA E]" ~~ m/^<:!LogicalOrderException>$/ ), q{Don't match negated <isLogicalOrderException>} );
ok(!( "\c[THAI CHARACTER SARA E]" ~~ m/^<-:LogicalOrderException>$/ ), q{Don't match inverted <isLogicalOrderException>} );
ok(!( "\x[857B]"  ~~ m/^<:LogicalOrderException>$/ ), q{Don't match unrelated <isLogicalOrderException>} );
ok("\x[857B]"  ~~ m/^<:!LogicalOrderException>$/, q{Match unrelated negated <isLogicalOrderException>} );
ok("\x[857B]"  ~~ m/^<-:LogicalOrderException>$/, q{Match unrelated inverted <isLogicalOrderException>} );
ok(!( "\x[857B]" ~~ m/^<:LogicalOrderException>$/ ), q{Don't match related <isLogicalOrderException>} );
ok("\x[857B]" ~~ m/^<:!LogicalOrderException>$/, q{Match related negated <isLogicalOrderException>} );
ok("\x[857B]" ~~ m/^<-:LogicalOrderException>$/, q{Match related inverted <isLogicalOrderException>} );
ok("\x[857B]\x[857B]\c[THAI CHARACTER SARA E]" ~~ m/<:LogicalOrderException>/, q{Match unanchored <isLogicalOrderException>} );

# NoncharacterCodePoint

ok(!( "\c[LATIN LETTER REVERSED GLOTTAL STOP WITH STROKE]"  ~~ m/^<:NoncharacterCodePoint>$/ ), q{Don't match unrelated <isNoncharacterCodePoint>} );
ok("\c[LATIN LETTER REVERSED GLOTTAL STOP WITH STROKE]"  ~~ m/^<:!NoncharacterCodePoint>$/, q{Match unrelated negated <isNoncharacterCodePoint>} );
ok("\c[LATIN LETTER REVERSED GLOTTAL STOP WITH STROKE]"  ~~ m/^<-:NoncharacterCodePoint>$/, q{Match unrelated inverted <isNoncharacterCodePoint>} );
ok(!( "\c[ARABIC-INDIC DIGIT ZERO]" ~~ m/^<:NoncharacterCodePoint>$/ ), q{Don't match related <isNoncharacterCodePoint>} );
ok("\c[ARABIC-INDIC DIGIT ZERO]" ~~ m/^<:!NoncharacterCodePoint>$/, q{Match related negated <isNoncharacterCodePoint>} );
ok("\c[ARABIC-INDIC DIGIT ZERO]" ~~ m/^<-:NoncharacterCodePoint>$/, q{Match related inverted <isNoncharacterCodePoint>} );

# OtherAlphabetic

#?rakudo 42 skip "isOther* not implemented"
ok("\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<:OtherAlphabetic>$/, q{Match <:OtherAlphabetic>} );
ok(!( "\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<:!OtherAlphabetic>$/ ), q{Don't match negated <isOtherAlphabetic>} );
ok(!( "\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<-:OtherAlphabetic>$/ ), q{Don't match inverted <isOtherAlphabetic>} );
ok(!( "\x[413C]"  ~~ m/^<:OtherAlphabetic>$/ ), q{Don't match unrelated <isOtherAlphabetic>} );
ok("\x[413C]"  ~~ m/^<:!OtherAlphabetic>$/, q{Match unrelated negated <isOtherAlphabetic>} );
ok("\x[413C]"  ~~ m/^<-:OtherAlphabetic>$/, q{Match unrelated inverted <isOtherAlphabetic>} );
ok("\x[413C]\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/<:OtherAlphabetic>/, q{Match unanchored <isOtherAlphabetic>} );

# OtherDefaultIgnorableCodePoint


ok("\c[HANGUL FILLER]" ~~ m/^<:OtherDefaultIgnorableCodePoint>$/, q{Match <:OtherDefaultIgnorableCodePoint>} );
ok(!( "\c[HANGUL FILLER]" ~~ m/^<:!OtherDefaultIgnorableCodePoint>$/ ), q{Don't match negated <isOtherDefaultIgnorableCodePoint>} );
ok(!( "\c[HANGUL FILLER]" ~~ m/^<-:OtherDefaultIgnorableCodePoint>$/ ), q{Don't match inverted <isOtherDefaultIgnorableCodePoint>} );
ok(!( "\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<:OtherDefaultIgnorableCodePoint>$/ ), q{Don't match unrelated <isOtherDefaultIgnorableCodePoint>} );
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<:!OtherDefaultIgnorableCodePoint>$/, q{Match unrelated negated <isOtherDefaultIgnorableCodePoint>} );
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<-:OtherDefaultIgnorableCodePoint>$/, q{Match unrelated inverted <isOtherDefaultIgnorableCodePoint>} );
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]\c[HANGUL FILLER]" ~~ m/<:OtherDefaultIgnorableCodePoint>/, q{Match unanchored <isOtherDefaultIgnorableCodePoint>} );

# OtherGraphemeExtend


ok("\c[BENGALI VOWEL SIGN AA]" ~~ m/^<:OtherGraphemeExtend>$/, q{Match <:OtherGraphemeExtend>} );
ok(!( "\c[BENGALI VOWEL SIGN AA]" ~~ m/^<:!OtherGraphemeExtend>$/ ), q{Don't match negated <isOtherGraphemeExtend>} );
ok(!( "\c[BENGALI VOWEL SIGN AA]" ~~ m/^<-:OtherGraphemeExtend>$/ ), q{Don't match inverted <isOtherGraphemeExtend>} );
ok(!( "\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<:OtherGraphemeExtend>$/ ), q{Don't match unrelated <isOtherGraphemeExtend>} );
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<:!OtherGraphemeExtend>$/, q{Match unrelated negated <isOtherGraphemeExtend>} );
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<-:OtherGraphemeExtend>$/, q{Match unrelated inverted <isOtherGraphemeExtend>} );
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]\c[BENGALI VOWEL SIGN AA]" ~~ m/<:OtherGraphemeExtend>/, q{Match unanchored <isOtherGraphemeExtend>} );

# OtherLowercase


ok("\c[MODIFIER LETTER SMALL H]" ~~ m/^<:OtherLowercase>$/, q{Match <:OtherLowercase>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<:!OtherLowercase>$/ ), q{Don't match negated <isOtherLowercase>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<-:OtherLowercase>$/ ), q{Don't match inverted <isOtherLowercase>} );
ok(!( "\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<:OtherLowercase>$/ ), q{Don't match unrelated <isOtherLowercase>} );
ok("\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<:!OtherLowercase>$/, q{Match unrelated negated <isOtherLowercase>} );
ok("\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<-:OtherLowercase>$/, q{Match unrelated inverted <isOtherLowercase>} );
ok("\c[HANGUL LETTER NIEUN-CIEUC]\c[MODIFIER LETTER SMALL H]" ~~ m/<:OtherLowercase>/, q{Match unanchored <isOtherLowercase>} );

# OtherMath


ok("\c[LEFT PARENTHESIS]" ~~ m/^<:OtherMath>$/, q{Match <:OtherMath>} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<:!OtherMath>$/ ), q{Don't match negated <isOtherMath>} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<-:OtherMath>$/ ), q{Don't match inverted <isOtherMath>} );
ok(!( "\x[B43A]"  ~~ m/^<:OtherMath>$/ ), q{Don't match unrelated <isOtherMath>} );
ok("\x[B43A]"  ~~ m/^<:!OtherMath>$/, q{Match unrelated negated <isOtherMath>} );
ok("\x[B43A]"  ~~ m/^<-:OtherMath>$/, q{Match unrelated inverted <isOtherMath>} );
ok("\x[B43A]\c[LEFT PARENTHESIS]" ~~ m/<:OtherMath>/, q{Match unanchored <isOtherMath>} );

# OtherUppercase


ok("\c[ROMAN NUMERAL ONE]" ~~ m/^<:OtherUppercase>$/, q{Match <:OtherUppercase>} );
ok(!( "\c[ROMAN NUMERAL ONE]" ~~ m/^<:!OtherUppercase>$/ ), q{Don't match negated <isOtherUppercase>} );
ok(!( "\c[ROMAN NUMERAL ONE]" ~~ m/^<-:OtherUppercase>$/ ), q{Don't match inverted <isOtherUppercase>} );
ok(!( "\x[D246]"  ~~ m/^<:OtherUppercase>$/ ), q{Don't match unrelated <isOtherUppercase>} );
ok("\x[D246]"  ~~ m/^<:!OtherUppercase>$/, q{Match unrelated negated <isOtherUppercase>} );
ok("\x[D246]"  ~~ m/^<-:OtherUppercase>$/, q{Match unrelated inverted <isOtherUppercase>} );
ok("\x[D246]\c[ROMAN NUMERAL ONE]" ~~ m/<:OtherUppercase>/, q{Match unanchored <isOtherUppercase>} );

# QuotationMark


ok("\c[QUOTATION MARK]" ~~ m/^<:QuotationMark>$/, q{Match <:QuotationMark>} );
ok(!( "\c[QUOTATION MARK]" ~~ m/^<:!QuotationMark>$/ ), q{Don't match negated <isQuotationMark>} );
ok(!( "\c[QUOTATION MARK]" ~~ m/^<-:QuotationMark>$/ ), q{Don't match inverted <isQuotationMark>} );
ok(!( "\x[C890]"  ~~ m/^<:QuotationMark>$/ ), q{Don't match unrelated <isQuotationMark>} );
ok("\x[C890]"  ~~ m/^<:!QuotationMark>$/, q{Match unrelated negated <isQuotationMark>} );
ok("\x[C890]"  ~~ m/^<-:QuotationMark>$/, q{Match unrelated inverted <isQuotationMark>} );
ok("\x[C890]\c[QUOTATION MARK]" ~~ m/<:QuotationMark>/, q{Match unanchored <isQuotationMark>} );

# Radical


ok("\c[CJK RADICAL REPEAT]" ~~ m/^<:Radical>$/, q{Match <:Radical>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<:!Radical>$/ ), q{Don't match negated <isRadical>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<-:Radical>$/ ), q{Don't match inverted <isRadical>} );
ok(!( "\c[HANGUL JONGSEONG CHIEUCH]"  ~~ m/^<:Radical>$/ ), q{Don't match unrelated <isRadical>} );
ok("\c[HANGUL JONGSEONG CHIEUCH]"  ~~ m/^<:!Radical>$/, q{Match unrelated negated <isRadical>} );
ok("\c[HANGUL JONGSEONG CHIEUCH]"  ~~ m/^<-:Radical>$/, q{Match unrelated inverted <isRadical>} );
ok("\c[HANGUL JONGSEONG CHIEUCH]\c[CJK RADICAL REPEAT]" ~~ m/<:Radical>/, q{Match unanchored <isRadical>} );

# SoftDotted


ok("\c[LATIN SMALL LETTER I]" ~~ m/^<:SoftDotted>$/, q{Match <:SoftDotted>} );
ok(!( "\c[LATIN SMALL LETTER I]" ~~ m/^<:!SoftDotted>$/ ), q{Don't match negated <isSoftDotted>} );
ok(!( "\c[LATIN SMALL LETTER I]" ~~ m/^<-:SoftDotted>$/ ), q{Don't match inverted <isSoftDotted>} );
ok(!( "\x[ADEF]"  ~~ m/^<:SoftDotted>$/ ), q{Don't match unrelated <isSoftDotted>} );
ok("\x[ADEF]"  ~~ m/^<:!SoftDotted>$/, q{Match unrelated negated <isSoftDotted>} );
ok("\x[ADEF]"  ~~ m/^<-:SoftDotted>$/, q{Match unrelated inverted <isSoftDotted>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<:SoftDotted>$/ ), q{Don't match related <isSoftDotted>} );
ok("\c[DOLLAR SIGN]" ~~ m/^<:!SoftDotted>$/, q{Match related negated <isSoftDotted>} );
ok("\c[DOLLAR SIGN]" ~~ m/^<-:SoftDotted>$/, q{Match related inverted <isSoftDotted>} );
ok("\x[ADEF]\c[DOLLAR SIGN]\c[LATIN SMALL LETTER I]" ~~ m/<:SoftDotted>/, q{Match unanchored <isSoftDotted>} );

# TerminalPunctuation


ok("\c[EXCLAMATION MARK]" ~~ m/^<:TerminalPunctuation>$/, q{Match <:TerminalPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:!TerminalPunctuation>$/ ), q{Don't match negated <isTerminalPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-:TerminalPunctuation>$/ ), q{Don't match inverted <isTerminalPunctuation>} );
ok(!( "\x[3C9D]"  ~~ m/^<:TerminalPunctuation>$/ ), q{Don't match unrelated <isTerminalPunctuation>} );
ok("\x[3C9D]"  ~~ m/^<:!TerminalPunctuation>$/, q{Match unrelated negated <isTerminalPunctuation>} );
ok("\x[3C9D]"  ~~ m/^<-:TerminalPunctuation>$/, q{Match unrelated inverted <isTerminalPunctuation>} );
ok("\x[3C9D]\c[EXCLAMATION MARK]" ~~ m/<:TerminalPunctuation>/, q{Match unanchored <isTerminalPunctuation>} );

# UnifiedIdeograph


ok("\x[7896]" ~~ m/^<:UnifiedIdeograph>$/, q{Match <:UnifiedIdeograph>} );
ok(!( "\x[7896]" ~~ m/^<:!UnifiedIdeograph>$/ ), q{Don't match negated <isUnifiedIdeograph>} );
ok(!( "\x[7896]" ~~ m/^<-:UnifiedIdeograph>$/ ), q{Don't match inverted <isUnifiedIdeograph>} );
#?rakudo 3 skip 'icu'
ok(!( "\x[9FC4]"  ~~ m/^<:UnifiedIdeograph>$/ ), q{Don't match unrelated <isUnifiedIdeograph>} );
ok("\x[9FC4]"  ~~ m/^<:!UnifiedIdeograph>$/, q{Match unrelated negated <isUnifiedIdeograph>} );
ok("\x[9FC4]"  ~~ m/^<-:UnifiedIdeograph>$/, q{Match unrelated inverted <isUnifiedIdeograph>} );
ok("\x[9FC4]\x[7896]" ~~ m/<:UnifiedIdeograph>/, q{Match unanchored <isUnifiedIdeograph>} );

# WhiteSpace


ok("\c[CHARACTER TABULATION]" ~~ m/^<:WhiteSpace>$/, q{Match <:WhiteSpace>} );
ok(!( "\c[CHARACTER TABULATION]" ~~ m/^<:!WhiteSpace>$/ ), q{Don't match negated <isWhiteSpace>} );
ok(!( "\c[CHARACTER TABULATION]" ~~ m/^<-:WhiteSpace>$/ ), q{Don't match inverted <isWhiteSpace>} );
ok(!( "\x[6358]"  ~~ m/^<:WhiteSpace>$/ ), q{Don't match unrelated <isWhiteSpace>} );
ok("\x[6358]"  ~~ m/^<:!WhiteSpace>$/, q{Match unrelated negated <isWhiteSpace>} );
ok("\x[6358]"  ~~ m/^<-:WhiteSpace>$/, q{Match unrelated inverted <isWhiteSpace>} );
ok("\x[6358]\c[CHARACTER TABULATION]" ~~ m/<:WhiteSpace>/, q{Match unanchored <isWhiteSpace>} );

# Alphabetic      # Lu + Ll + Lt + Lm + Lo + OtherAlphabetic


ok("\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<:Alphabetic>$/, q{Match (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<:!Alphabetic>$/ ), q{Don't match negated (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<-:Alphabetic>$/ ), q{Don't match inverted (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok(!( "\x[297C]"  ~~ m/^<:Alphabetic>$/ ), q{Don't match unrelated (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok("\x[297C]"  ~~ m/^<:!Alphabetic>$/, q{Match unrelated negated (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok("\x[297C]"  ~~ m/^<-:Alphabetic>$/, q{Match unrelated inverted (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok("\x[297C]\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/<:Alphabetic>/, q{Match unanchored (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );

# Lowercase       # Ll + OtherLowercase


ok("\c[LATIN SMALL LETTER A]" ~~ m/^<:Lowercase>$/, q{Match (Ll + OtherLowercase)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<:!Lowercase>$/ ), q{Don't match negated (Ll + OtherLowercase)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<-:Lowercase>$/ ), q{Don't match inverted (Ll + OtherLowercase)} );
ok(!( "\x[6220]"  ~~ m/^<:Lowercase>$/ ), q{Don't match unrelated (Ll + OtherLowercase)} );
ok("\x[6220]"  ~~ m/^<:!Lowercase>$/, q{Match unrelated negated (Ll + OtherLowercase)} );
ok("\x[6220]"  ~~ m/^<-:Lowercase>$/, q{Match unrelated inverted (Ll + OtherLowercase)} );
ok(!( "\x[6220]" ~~ m/^<:Lowercase>$/ ), q{Don't match related (Ll + OtherLowercase)} );
ok("\x[6220]" ~~ m/^<:!Lowercase>$/, q{Match related negated (Ll + OtherLowercase)} );
ok("\x[6220]" ~~ m/^<-:Lowercase>$/, q{Match related inverted (Ll + OtherLowercase)} );
ok("\x[6220]\x[6220]\c[LATIN SMALL LETTER A]" ~~ m/<:Lowercase>/, q{Match unanchored (Ll + OtherLowercase)} );

# Uppercase       # Lu + OtherUppercase


ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<:Uppercase>$/, q{Match (Lu + OtherUppercase)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<:!Uppercase>$/ ), q{Don't match negated (Lu + OtherUppercase)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-:Uppercase>$/ ), q{Don't match inverted (Lu + OtherUppercase)} );
ok(!( "\x[C080]"  ~~ m/^<:Uppercase>$/ ), q{Don't match unrelated (Lu + OtherUppercase)} );
ok("\x[C080]"  ~~ m/^<:!Uppercase>$/, q{Match unrelated negated (Lu + OtherUppercase)} );
ok("\x[C080]"  ~~ m/^<-:Uppercase>$/, q{Match unrelated inverted (Lu + OtherUppercase)} );
ok("\x[C080]\c[LATIN CAPITAL LETTER A]" ~~ m/<:Uppercase>/, q{Match unanchored (Lu + OtherUppercase)} );

# Math            # Sm + OtherMath


ok("\c[PLUS SIGN]" ~~ m/^<:Math>$/, q{Match (Sm + OtherMath)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<:!Math>$/ ), q{Don't match negated (Sm + OtherMath)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<-:Math>$/ ), q{Don't match inverted (Sm + OtherMath)} );
ok(!( "\x[D4D2]"  ~~ m/^<:Math>$/ ), q{Don't match unrelated (Sm + OtherMath)} );
ok("\x[D4D2]"  ~~ m/^<:!Math>$/, q{Match unrelated negated (Sm + OtherMath)} );
ok("\x[D4D2]"  ~~ m/^<-:Math>$/, q{Match unrelated inverted (Sm + OtherMath)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Math>$/ ), q{Don't match related (Sm + OtherMath)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!Math>$/, q{Match related negated (Sm + OtherMath)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Math>$/, q{Match related inverted (Sm + OtherMath)} );
ok("\x[D4D2]\c[COMBINING GRAVE ACCENT]\c[PLUS SIGN]" ~~ m/<:Math>/, q{Match unanchored (Sm + OtherMath)} );

# ID_Start        # Lu + Ll + Lt + Lm + Lo + Nl


ok("\x[C276]" ~~ m/^<:ID_Start>$/, q{Match (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok(!( "\x[C276]" ~~ m/^<:!ID_Start>$/ ), q{Don't match negated (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok(!( "\x[C276]" ~~ m/^<-:ID_Start>$/ ), q{Don't match inverted (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok(!( "\x[D7A4]"  ~~ m/^<:ID_Start>$/ ), q{Don't match unrelated (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok("\x[D7A4]"  ~~ m/^<:!ID_Start>$/, q{Match unrelated negated (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok("\x[D7A4]"  ~~ m/^<-:ID_Start>$/, q{Match unrelated inverted (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok("\x[D7A4]\x[C276]" ~~ m/<:ID_Start>/, q{Match unanchored (Lu + Ll + Lt + Lm + Lo + Nl)} );

# ID_Continue     # ID_Start + Mn + Mc + Nd + Pc


ok("\x[949B]" ~~ m/^<:ID_Continue>$/, q{Match (ID_Start + Mn + Mc + Nd + Pc)} );
ok(!( "\x[949B]" ~~ m/^<:!ID_Continue>$/ ), q{Don't match negated (ID_Start + Mn + Mc + Nd + Pc)} );
ok(!( "\x[949B]" ~~ m/^<-:ID_Continue>$/ ), q{Don't match inverted (ID_Start + Mn + Mc + Nd + Pc)} );
#?rakudo 3 skip 'icu'
ok(!( "\x[9FC4]"  ~~ m/^<:ID_Continue>$/ ), q{Don't match unrelated (ID_Start + Mn + Mc + Nd + Pc)} );
ok("\x[9FC4]"  ~~ m/^<:!ID_Continue>$/, q{Match unrelated negated (ID_Start + Mn + Mc + Nd + Pc)} );
ok("\x[9FC4]"  ~~ m/^<-:ID_Continue>$/, q{Match unrelated inverted (ID_Start + Mn + Mc + Nd + Pc)} );
ok("\x[9FC4]\x[949B]" ~~ m/<:ID_Continue>/, q{Match unanchored (ID_Start + Mn + Mc + Nd + Pc)} );

# Any             # Any character

#?rakudo 4 skip 'isAny not implemented'
ok("\x[C709]" ~~ m/^<:Any>$/, q{Match (Any character)} );
ok(!( "\x[C709]" ~~ m/^<:!Any>$/ ), q{Don't match negated (Any character)} );
ok(!( "\x[C709]" ~~ m/^<-:Any>$/ ), q{Don't match inverted (Any character)} );
ok("\x[C709]" ~~ m/<:Any>/, q{Match unanchored (Any character)} );

# Assigned        # Any non-Cn character (i.e. synonym for \P{Cn})


#?rakudo 7 skip 'isAssigned not implemented'
ok("\x[C99D]" ~~ m/^<:Assigned>$/, q<Match (Any non-Cn character (i.e. synonym for \P{Cn}))> );
ok(!( "\x[C99D]" ~~ m/^<:!Assigned>$/ ), q<Don't match negated (Any non-Cn character (i.e. synonym for \P{Cn}))> );
ok(!( "\x[C99D]" ~~ m/^<-:Assigned>$/ ), q<Don't match inverted (Any non-Cn character (i.e. synonym for \P{Cn}))> );
ok(!( "\x[D7A4]"  ~~ m/^<:Assigned>$/ ), q<Don't match unrelated (Any non-Cn character (i.e. synonym for \P{Cn}))> );
ok("\x[D7A4]"  ~~ m/^<:!Assigned>$/, q<Match unrelated negated (Any non-Cn character (i.e. synonym for \P{Cn}))> );
ok("\x[D7A4]"  ~~ m/^<-:Assigned>$/, q<Match unrelated inverted (Any non-Cn character (i.e. synonym for \P{Cn}))> );
ok("\x[D7A4]\x[C99D]" ~~ m/<:Assigned>/, q<Match unanchored (Any non-Cn character (i.e. synonym for \P{Cn}))> );

# Unassigned      # Synonym for \p{Cn}


#?rakudo 7 skip 'isUnassigned not implemented'
ok("\x[27EC]" ~~ m/^<:Unassigned>$/, q<Match (Synonym for \p{Cn})> );
ok(!( "\x[27EC]" ~~ m/^<:!Unassigned>$/ ), q<Don't match negated (Synonym for \p{Cn})> );
ok(!( "\x[27EC]" ~~ m/^<-:Unassigned>$/ ), q<Don't match inverted (Synonym for \p{Cn})> );
ok(!( "\c[RIGHT OUTER JOIN]"  ~~ m/^<:Unassigned>$/ ), q<Don't match unrelated (Synonym for \p{Cn})> );
ok("\c[RIGHT OUTER JOIN]"  ~~ m/^<:!Unassigned>$/, q<Match unrelated negated (Synonym for \p{Cn})> );
ok("\c[RIGHT OUTER JOIN]"  ~~ m/^<-:Unassigned>$/, q<Match unrelated inverted (Synonym for \p{Cn})> );
ok("\c[RIGHT OUTER JOIN]\x[27EC]" ~~ m/<:Unassigned>/, q<Match unanchored (Synonym for \p{Cn})> );

# Common          # Codepoint not explicitly assigned to a script


#?rakudo 10 skip 'isCommon not implemented'
ok("\x[0C7E]" ~~ m/^<:Common>$/, q{Match (Codepoint not explicitly assigned to a script)} );
ok(!( "\x[0C7E]" ~~ m/^<:!Common>$/ ), q{Don't match negated (Codepoint not explicitly assigned to a script)} );
ok(!( "\x[0C7E]" ~~ m/^<-:Common>$/ ), q{Don't match inverted (Codepoint not explicitly assigned to a script)} );
ok(!( "\c[KANNADA SIGN ANUSVARA]"  ~~ m/^<:Common>$/ ), q{Don't match unrelated (Codepoint not explicitly assigned to a script)} );
ok("\c[KANNADA SIGN ANUSVARA]"  ~~ m/^<:!Common>$/, q{Match unrelated negated (Codepoint not explicitly assigned to a script)} );
ok("\c[KANNADA SIGN ANUSVARA]"  ~~ m/^<-:Common>$/, q{Match unrelated inverted (Codepoint not explicitly assigned to a script)} );
ok(!( "\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<:Common>$/ ), q{Don't match related (Codepoint not explicitly assigned to a script)} );
ok("\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<:!Common>$/, q{Match related negated (Codepoint not explicitly assigned to a script)} );
ok("\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<-:Common>$/, q{Match related inverted (Codepoint not explicitly assigned to a script)} );
ok("\c[KANNADA SIGN ANUSVARA]\c[KHMER VOWEL INHERENT AQ]\x[0C7E]" ~~ m/<:Common>/, q{Match unanchored (Codepoint not explicitly assigned to a script)} );


# vim: ft=perl6
