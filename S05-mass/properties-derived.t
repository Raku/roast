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

ok("\c[DIGIT ZERO]" ~~ m/^<.isASCIIHexDigit>$/, q{Match <.isASCIIHexDigit>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<!isASCIIHexDigit>.$/ ), q{Don't match negated <isASCIIHexDigit>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-isASCIIHexDigit>$/ ), q{Don't match inverted <isASCIIHexDigit>} );
ok(!( "\x[53BA]"  ~~ m/^<.isASCIIHexDigit>$/ ), q{Don't match unrelated <isASCIIHexDigit>} );
ok("\x[53BA]"  ~~ m/^<!isASCIIHexDigit>.$/, q{Match unrelated negated <isASCIIHexDigit>} );
ok("\x[53BA]"  ~~ m/^<-isASCIIHexDigit>$/, q{Match unrelated inverted <isASCIIHexDigit>} );
ok("\x[53BA]\c[DIGIT ZERO]" ~~ m/<.isASCIIHexDigit>/, q{Match unanchored <isASCIIHexDigit>} );

# Dash


ok("\c[HYPHEN-MINUS]" ~~ m/^<.isDash>$/, q{Match <.isDash>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<!isDash>.$/ ), q{Don't match negated <isDash>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<-isDash>$/ ), q{Don't match inverted <isDash>} );
ok(!( "\x[53F7]"  ~~ m/^<.isDash>$/ ), q{Don't match unrelated <isDash>} );
ok("\x[53F7]"  ~~ m/^<!isDash>.$/, q{Match unrelated negated <isDash>} );
ok("\x[53F7]"  ~~ m/^<-isDash>$/, q{Match unrelated inverted <isDash>} );
ok("\x[53F7]\c[HYPHEN-MINUS]" ~~ m/<.isDash>/, q{Match unanchored <isDash>} );

# Diacritic


ok("\c[MODIFIER LETTER CAPITAL A]" ~~ m/^<.isDiacritic>$/, q{Match <.isDiacritic>} );
ok(!( "\c[MODIFIER LETTER CAPITAL A]" ~~ m/^<!isDiacritic>.$/ ), q{Don't match negated <isDiacritic>} );
ok(!( "\c[MODIFIER LETTER CAPITAL A]" ~~ m/^<-isDiacritic>$/ ), q{Don't match inverted <isDiacritic>} );
ok(!( "\x[1BCD]"  ~~ m/^<.isDiacritic>$/ ), q{Don't match unrelated <isDiacritic>} );
ok("\x[1BCD]"  ~~ m/^<!isDiacritic>.$/, q{Match unrelated negated <isDiacritic>} );
ok("\x[1BCD]"  ~~ m/^<-isDiacritic>$/, q{Match unrelated inverted <isDiacritic>} );
ok("\x[1BCD]\c[MODIFIER LETTER CAPITAL A]" ~~ m/<.isDiacritic>/, q{Match unanchored <isDiacritic>} );

# Extender


ok("\c[MIDDLE DOT]" ~~ m/^<.isExtender>$/, q{Match <.isExtender>} );
ok(!( "\c[MIDDLE DOT]" ~~ m/^<!isExtender>.$/ ), q{Don't match negated <isExtender>} );
ok(!( "\c[MIDDLE DOT]" ~~ m/^<-isExtender>$/ ), q{Don't match inverted <isExtender>} );
ok(!( "\x[3A18]"  ~~ m/^<.isExtender>$/ ), q{Don't match unrelated <isExtender>} );
ok("\x[3A18]"  ~~ m/^<!isExtender>.$/, q{Match unrelated negated <isExtender>} );
ok("\x[3A18]"  ~~ m/^<-isExtender>$/, q{Match unrelated inverted <isExtender>} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[3A18]\c[MIDDLE DOT]" ~~ m/<.isExtender>/, q{Match unanchored <isExtender>} );

# GraphemeLink


#?rakudo 7 skip "isGraphemeLink"
ok("\c[COMBINING GRAPHEME JOINER]" ~~ m/^<.isGraphemeLink>$/, q{Match <.isGraphemeLink>} );
ok(!( "\c[COMBINING GRAPHEME JOINER]" ~~ m/^<!isGraphemeLink>.$/ ), q{Don't match negated <isGraphemeLink>} );
ok(!( "\c[COMBINING GRAPHEME JOINER]" ~~ m/^<-isGraphemeLink>$/ ), q{Don't match inverted <isGraphemeLink>} );
ok(!( "\x[4989]"  ~~ m/^<.isGraphemeLink>$/ ), q{Don't match unrelated <isGraphemeLink>} );
ok("\x[4989]"  ~~ m/^<!isGraphemeLink>.$/, q{Match unrelated negated <isGraphemeLink>} );
ok("\x[4989]"  ~~ m/^<-isGraphemeLink>$/, q{Match unrelated inverted <isGraphemeLink>} );
ok("\x[4989]\c[COMBINING GRAPHEME JOINER]" ~~ m/<.isGraphemeLink>/, q{Match unanchored <isGraphemeLink>} );

# HexDigit


ok("\c[DIGIT ZERO]" ~~ m/^<.isHexDigit>$/, q{Match <.isHexDigit>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<!isHexDigit>.$/ ), q{Don't match negated <isHexDigit>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-isHexDigit>$/ ), q{Don't match inverted <isHexDigit>} );
ok(!( "\x[6292]"  ~~ m/^<.isHexDigit>$/ ), q{Don't match unrelated <isHexDigit>} );
ok("\x[6292]"  ~~ m/^<!isHexDigit>.$/, q{Match unrelated negated <isHexDigit>} );
ok("\x[6292]"  ~~ m/^<-isHexDigit>$/, q{Match unrelated inverted <isHexDigit>} );
ok("\x[6292]\c[DIGIT ZERO]" ~~ m/<.isHexDigit>/, q{Match unanchored <isHexDigit>} );

# Hyphen

ok("\c[KATAKANA MIDDLE DOT]" ~~ m/^<.isHyphen>$/, q{Match <.isHyphen>} );
ok(!( "\c[KATAKANA MIDDLE DOT]" ~~ m/^<!isHyphen>.$/ ), q{Don't match negated <isHyphen>} );
ok(!( "\c[KATAKANA MIDDLE DOT]" ~~ m/^<-isHyphen>$/ ), q{Don't match inverted <isHyphen>} );
ok(!( "\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]"  ~~ m/^<.isHyphen>$/ ), q{Don't match unrelated <isHyphen>} );
ok("\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]"  ~~ m/^<!isHyphen>.$/, q{Match unrelated negated <isHyphen>} );
ok("\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]"  ~~ m/^<-isHyphen>$/, q{Match unrelated inverted <isHyphen>} );
ok("\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]\c[KATAKANA MIDDLE DOT]" ~~ m/<.isHyphen>/, q{Match unanchored <isHyphen>} );

# Ideographic


ok("\x[8AB0]" ~~ m/^<.isIdeographic>$/, q{Match <.isIdeographic>} );
ok(!( "\x[8AB0]" ~~ m/^<!isIdeographic>.$/ ), q{Don't match negated <isIdeographic>} );
ok(!( "\x[8AB0]" ~~ m/^<-isIdeographic>$/ ), q{Don't match inverted <isIdeographic>} );
ok(!( "\x[9FC4]"  ~~ m/^<.isIdeographic>$/ ), q{Don't match unrelated <isIdeographic>} );
ok("\x[9FC4]"  ~~ m/^<!isIdeographic>.$/, q{Match unrelated negated <isIdeographic>} );
ok("\x[9FC4]"  ~~ m/^<-isIdeographic>$/, q{Match unrelated inverted <isIdeographic>} );
ok("\x[9FC4]\x[8AB0]" ~~ m/<.isIdeographic>/, q{Match unanchored <isIdeographic>} );

# IDSBinaryOperator


ok("\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<.isIDSBinaryOperator>$/, q{Match <.isIDSBinaryOperator>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<!isIDSBinaryOperator>.$/ ), q{Don't match negated <isIDSBinaryOperator>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<-isIDSBinaryOperator>$/ ), q{Don't match inverted <isIDSBinaryOperator>} );
ok(!( "\x[59E9]"  ~~ m/^<.isIDSBinaryOperator>$/ ), q{Don't match unrelated <isIDSBinaryOperator>} );
ok("\x[59E9]"  ~~ m/^<!isIDSBinaryOperator>.$/, q{Match unrelated negated <isIDSBinaryOperator>} );
ok("\x[59E9]"  ~~ m/^<-isIDSBinaryOperator>$/, q{Match unrelated inverted <isIDSBinaryOperator>} );
ok("\x[59E9]\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/<.isIDSBinaryOperator>/, q{Match unanchored <isIDSBinaryOperator>} );

# IDSTrinaryOperator

ok("\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/^<.isIDSTrinaryOperator>$/, q{Match <.isIDSTrinaryOperator>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/^<!isIDSTrinaryOperator>.$/ ), q{Don't match negated <isIDSTrinaryOperator>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/^<-isIDSTrinaryOperator>$/ ), q{Don't match inverted <isIDSTrinaryOperator>} );
ok(!( "\x[9224]"  ~~ m/^<.isIDSTrinaryOperator>$/ ), q{Don't match unrelated <isIDSTrinaryOperator>} );
ok("\x[9224]"  ~~ m/^<!isIDSTrinaryOperator>.$/, q{Match unrelated negated <isIDSTrinaryOperator>} );
ok("\x[9224]"  ~~ m/^<-isIDSTrinaryOperator>$/, q{Match unrelated inverted <isIDSTrinaryOperator>} );
ok("\x[9224]\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/<.isIDSTrinaryOperator>/, q{Match unanchored <isIDSTrinaryOperator>} );

# JoinControl


ok("\c[ZERO WIDTH NON-JOINER]" ~~ m/^<.isJoinControl>$/, q{Match <.isJoinControl>} );
ok(!( "\c[ZERO WIDTH NON-JOINER]" ~~ m/^<!isJoinControl>.$/ ), q{Don't match negated <isJoinControl>} );
ok(!( "\c[ZERO WIDTH NON-JOINER]" ~~ m/^<-isJoinControl>$/ ), q{Don't match inverted <isJoinControl>} );
ok(!( "\c[BENGALI LETTER DDHA]"  ~~ m/^<.isJoinControl>$/ ), q{Don't match unrelated <isJoinControl>} );
ok("\c[BENGALI LETTER DDHA]"  ~~ m/^<!isJoinControl>.$/, q{Match unrelated negated <isJoinControl>} );
ok("\c[BENGALI LETTER DDHA]"  ~~ m/^<-isJoinControl>$/, q{Match unrelated inverted <isJoinControl>} );
ok("\c[BENGALI LETTER DDHA]\c[ZERO WIDTH NON-JOINER]" ~~ m/<.isJoinControl>/, q{Match unanchored <isJoinControl>} );

# LogicalOrderException


ok("\c[THAI CHARACTER SARA E]" ~~ m/^<.isLogicalOrderException>$/, q{Match <.isLogicalOrderException>} );
ok(!( "\c[THAI CHARACTER SARA E]" ~~ m/^<!isLogicalOrderException>.$/ ), q{Don't match negated <isLogicalOrderException>} );
ok(!( "\c[THAI CHARACTER SARA E]" ~~ m/^<-isLogicalOrderException>$/ ), q{Don't match inverted <isLogicalOrderException>} );
ok(!( "\x[857B]"  ~~ m/^<.isLogicalOrderException>$/ ), q{Don't match unrelated <isLogicalOrderException>} );
ok("\x[857B]"  ~~ m/^<!isLogicalOrderException>.$/, q{Match unrelated negated <isLogicalOrderException>} );
ok("\x[857B]"  ~~ m/^<-isLogicalOrderException>$/, q{Match unrelated inverted <isLogicalOrderException>} );
ok(!( "\x[857B]" ~~ m/^<.isLogicalOrderException>$/ ), q{Don't match related <isLogicalOrderException>} );
ok("\x[857B]" ~~ m/^<!isLogicalOrderException>.$/, q{Match related negated <isLogicalOrderException>} );
ok("\x[857B]" ~~ m/^<-isLogicalOrderException>$/, q{Match related inverted <isLogicalOrderException>} );
ok("\x[857B]\x[857B]\c[THAI CHARACTER SARA E]" ~~ m/<.isLogicalOrderException>/, q{Match unanchored <isLogicalOrderException>} );

# NoncharacterCodePoint

ok(!( "\c[LATIN LETTER REVERSED GLOTTAL STOP WITH STROKE]"  ~~ m/^<.isNoncharacterCodePoint>$/ ), q{Don't match unrelated <isNoncharacterCodePoint>} );
ok("\c[LATIN LETTER REVERSED GLOTTAL STOP WITH STROKE]"  ~~ m/^<!isNoncharacterCodePoint>.$/, q{Match unrelated negated <isNoncharacterCodePoint>} );
ok("\c[LATIN LETTER REVERSED GLOTTAL STOP WITH STROKE]"  ~~ m/^<-isNoncharacterCodePoint>$/, q{Match unrelated inverted <isNoncharacterCodePoint>} );
ok(!( "\c[ARABIC-INDIC DIGIT ZERO]" ~~ m/^<.isNoncharacterCodePoint>$/ ), q{Don't match related <isNoncharacterCodePoint>} );
ok("\c[ARABIC-INDIC DIGIT ZERO]" ~~ m/^<!isNoncharacterCodePoint>.$/, q{Match related negated <isNoncharacterCodePoint>} );
ok("\c[ARABIC-INDIC DIGIT ZERO]" ~~ m/^<-isNoncharacterCodePoint>$/, q{Match related inverted <isNoncharacterCodePoint>} );

# OtherAlphabetic

#?rakudo 42 skip "isOther* not implemented"
ok("\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<.isOtherAlphabetic>$/, q{Match <.isOtherAlphabetic>} );
ok(!( "\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<!isOtherAlphabetic>.$/ ), q{Don't match negated <isOtherAlphabetic>} );
ok(!( "\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<-isOtherAlphabetic>$/ ), q{Don't match inverted <isOtherAlphabetic>} );
ok(!( "\x[413C]"  ~~ m/^<.isOtherAlphabetic>$/ ), q{Don't match unrelated <isOtherAlphabetic>} );
ok("\x[413C]"  ~~ m/^<!isOtherAlphabetic>.$/, q{Match unrelated negated <isOtherAlphabetic>} );
ok("\x[413C]"  ~~ m/^<-isOtherAlphabetic>$/, q{Match unrelated inverted <isOtherAlphabetic>} );
ok("\x[413C]\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/<.isOtherAlphabetic>/, q{Match unanchored <isOtherAlphabetic>} );

# OtherDefaultIgnorableCodePoint


ok("\c[HANGUL FILLER]" ~~ m/^<.isOtherDefaultIgnorableCodePoint>$/, q{Match <.isOtherDefaultIgnorableCodePoint>} );
ok(!( "\c[HANGUL FILLER]" ~~ m/^<!isOtherDefaultIgnorableCodePoint>.$/ ), q{Don't match negated <isOtherDefaultIgnorableCodePoint>} );
ok(!( "\c[HANGUL FILLER]" ~~ m/^<-isOtherDefaultIgnorableCodePoint>$/ ), q{Don't match inverted <isOtherDefaultIgnorableCodePoint>} );
ok(!( "\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<.isOtherDefaultIgnorableCodePoint>$/ ), q{Don't match unrelated <isOtherDefaultIgnorableCodePoint>} );
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<!isOtherDefaultIgnorableCodePoint>.$/, q{Match unrelated negated <isOtherDefaultIgnorableCodePoint>} );
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<-isOtherDefaultIgnorableCodePoint>$/, q{Match unrelated inverted <isOtherDefaultIgnorableCodePoint>} );
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]\c[HANGUL FILLER]" ~~ m/<.isOtherDefaultIgnorableCodePoint>/, q{Match unanchored <isOtherDefaultIgnorableCodePoint>} );

# OtherGraphemeExtend


ok("\c[BENGALI VOWEL SIGN AA]" ~~ m/^<.isOtherGraphemeExtend>$/, q{Match <.isOtherGraphemeExtend>} );
ok(!( "\c[BENGALI VOWEL SIGN AA]" ~~ m/^<!isOtherGraphemeExtend>.$/ ), q{Don't match negated <isOtherGraphemeExtend>} );
ok(!( "\c[BENGALI VOWEL SIGN AA]" ~~ m/^<-isOtherGraphemeExtend>$/ ), q{Don't match inverted <isOtherGraphemeExtend>} );
ok(!( "\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<.isOtherGraphemeExtend>$/ ), q{Don't match unrelated <isOtherGraphemeExtend>} );
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<!isOtherGraphemeExtend>.$/, q{Match unrelated negated <isOtherGraphemeExtend>} );
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<-isOtherGraphemeExtend>$/, q{Match unrelated inverted <isOtherGraphemeExtend>} );
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]\c[BENGALI VOWEL SIGN AA]" ~~ m/<.isOtherGraphemeExtend>/, q{Match unanchored <isOtherGraphemeExtend>} );

# OtherLowercase


ok("\c[MODIFIER LETTER SMALL H]" ~~ m/^<.isOtherLowercase>$/, q{Match <.isOtherLowercase>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<!isOtherLowercase>.$/ ), q{Don't match negated <isOtherLowercase>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<-isOtherLowercase>$/ ), q{Don't match inverted <isOtherLowercase>} );
ok(!( "\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<.isOtherLowercase>$/ ), q{Don't match unrelated <isOtherLowercase>} );
ok("\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<!isOtherLowercase>.$/, q{Match unrelated negated <isOtherLowercase>} );
ok("\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<-isOtherLowercase>$/, q{Match unrelated inverted <isOtherLowercase>} );
ok("\c[HANGUL LETTER NIEUN-CIEUC]\c[MODIFIER LETTER SMALL H]" ~~ m/<.isOtherLowercase>/, q{Match unanchored <isOtherLowercase>} );

# OtherMath


ok("\c[LEFT PARENTHESIS]" ~~ m/^<.isOtherMath>$/, q{Match <.isOtherMath>} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<!isOtherMath>.$/ ), q{Don't match negated <isOtherMath>} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<-isOtherMath>$/ ), q{Don't match inverted <isOtherMath>} );
ok(!( "\x[B43A]"  ~~ m/^<.isOtherMath>$/ ), q{Don't match unrelated <isOtherMath>} );
ok("\x[B43A]"  ~~ m/^<!isOtherMath>.$/, q{Match unrelated negated <isOtherMath>} );
ok("\x[B43A]"  ~~ m/^<-isOtherMath>$/, q{Match unrelated inverted <isOtherMath>} );
ok("\x[B43A]\c[LEFT PARENTHESIS]" ~~ m/<.isOtherMath>/, q{Match unanchored <isOtherMath>} );

# OtherUppercase


ok("\c[ROMAN NUMERAL ONE]" ~~ m/^<.isOtherUppercase>$/, q{Match <.isOtherUppercase>} );
ok(!( "\c[ROMAN NUMERAL ONE]" ~~ m/^<!isOtherUppercase>.$/ ), q{Don't match negated <isOtherUppercase>} );
ok(!( "\c[ROMAN NUMERAL ONE]" ~~ m/^<-isOtherUppercase>$/ ), q{Don't match inverted <isOtherUppercase>} );
ok(!( "\x[D246]"  ~~ m/^<.isOtherUppercase>$/ ), q{Don't match unrelated <isOtherUppercase>} );
ok("\x[D246]"  ~~ m/^<!isOtherUppercase>.$/, q{Match unrelated negated <isOtherUppercase>} );
ok("\x[D246]"  ~~ m/^<-isOtherUppercase>$/, q{Match unrelated inverted <isOtherUppercase>} );
ok("\x[D246]\c[ROMAN NUMERAL ONE]" ~~ m/<.isOtherUppercase>/, q{Match unanchored <isOtherUppercase>} );

# QuotationMark


ok("\c[QUOTATION MARK]" ~~ m/^<.isQuotationMark>$/, q{Match <.isQuotationMark>} );
ok(!( "\c[QUOTATION MARK]" ~~ m/^<!isQuotationMark>.$/ ), q{Don't match negated <isQuotationMark>} );
ok(!( "\c[QUOTATION MARK]" ~~ m/^<-isQuotationMark>$/ ), q{Don't match inverted <isQuotationMark>} );
ok(!( "\x[C890]"  ~~ m/^<.isQuotationMark>$/ ), q{Don't match unrelated <isQuotationMark>} );
ok("\x[C890]"  ~~ m/^<!isQuotationMark>.$/, q{Match unrelated negated <isQuotationMark>} );
ok("\x[C890]"  ~~ m/^<-isQuotationMark>$/, q{Match unrelated inverted <isQuotationMark>} );
ok("\x[C890]\c[QUOTATION MARK]" ~~ m/<.isQuotationMark>/, q{Match unanchored <isQuotationMark>} );

# Radical


ok("\c[CJK RADICAL REPEAT]" ~~ m/^<.isRadical>$/, q{Match <.isRadical>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<!isRadical>.$/ ), q{Don't match negated <isRadical>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<-isRadical>$/ ), q{Don't match inverted <isRadical>} );
ok(!( "\c[HANGUL JONGSEONG CHIEUCH]"  ~~ m/^<.isRadical>$/ ), q{Don't match unrelated <isRadical>} );
ok("\c[HANGUL JONGSEONG CHIEUCH]"  ~~ m/^<!isRadical>.$/, q{Match unrelated negated <isRadical>} );
ok("\c[HANGUL JONGSEONG CHIEUCH]"  ~~ m/^<-isRadical>$/, q{Match unrelated inverted <isRadical>} );
ok("\c[HANGUL JONGSEONG CHIEUCH]\c[CJK RADICAL REPEAT]" ~~ m/<.isRadical>/, q{Match unanchored <isRadical>} );

# SoftDotted


ok("\c[LATIN SMALL LETTER I]" ~~ m/^<.isSoftDotted>$/, q{Match <.isSoftDotted>} );
ok(!( "\c[LATIN SMALL LETTER I]" ~~ m/^<!isSoftDotted>.$/ ), q{Don't match negated <isSoftDotted>} );
ok(!( "\c[LATIN SMALL LETTER I]" ~~ m/^<-isSoftDotted>$/ ), q{Don't match inverted <isSoftDotted>} );
ok(!( "\x[ADEF]"  ~~ m/^<.isSoftDotted>$/ ), q{Don't match unrelated <isSoftDotted>} );
ok("\x[ADEF]"  ~~ m/^<!isSoftDotted>.$/, q{Match unrelated negated <isSoftDotted>} );
ok("\x[ADEF]"  ~~ m/^<-isSoftDotted>$/, q{Match unrelated inverted <isSoftDotted>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<.isSoftDotted>$/ ), q{Don't match related <isSoftDotted>} );
ok("\c[DOLLAR SIGN]" ~~ m/^<!isSoftDotted>.$/, q{Match related negated <isSoftDotted>} );
ok("\c[DOLLAR SIGN]" ~~ m/^<-isSoftDotted>$/, q{Match related inverted <isSoftDotted>} );
ok("\x[ADEF]\c[DOLLAR SIGN]\c[LATIN SMALL LETTER I]" ~~ m/<.isSoftDotted>/, q{Match unanchored <isSoftDotted>} );

# TerminalPunctuation


ok("\c[EXCLAMATION MARK]" ~~ m/^<.isTerminalPunctuation>$/, q{Match <.isTerminalPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<!isTerminalPunctuation>.$/ ), q{Don't match negated <isTerminalPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-isTerminalPunctuation>$/ ), q{Don't match inverted <isTerminalPunctuation>} );
ok(!( "\x[3C9D]"  ~~ m/^<.isTerminalPunctuation>$/ ), q{Don't match unrelated <isTerminalPunctuation>} );
ok("\x[3C9D]"  ~~ m/^<!isTerminalPunctuation>.$/, q{Match unrelated negated <isTerminalPunctuation>} );
ok("\x[3C9D]"  ~~ m/^<-isTerminalPunctuation>$/, q{Match unrelated inverted <isTerminalPunctuation>} );
ok("\x[3C9D]\c[EXCLAMATION MARK]" ~~ m/<.isTerminalPunctuation>/, q{Match unanchored <isTerminalPunctuation>} );

# UnifiedIdeograph


ok("\x[7896]" ~~ m/^<.isUnifiedIdeograph>$/, q{Match <.isUnifiedIdeograph>} );
ok(!( "\x[7896]" ~~ m/^<!isUnifiedIdeograph>.$/ ), q{Don't match negated <isUnifiedIdeograph>} );
ok(!( "\x[7896]" ~~ m/^<-isUnifiedIdeograph>$/ ), q{Don't match inverted <isUnifiedIdeograph>} );
ok(!( "\x[9FC4]"  ~~ m/^<.isUnifiedIdeograph>$/ ), q{Don't match unrelated <isUnifiedIdeograph>} );
ok("\x[9FC4]"  ~~ m/^<!isUnifiedIdeograph>.$/, q{Match unrelated negated <isUnifiedIdeograph>} );
ok("\x[9FC4]"  ~~ m/^<-isUnifiedIdeograph>$/, q{Match unrelated inverted <isUnifiedIdeograph>} );
ok("\x[9FC4]\x[7896]" ~~ m/<.isUnifiedIdeograph>/, q{Match unanchored <isUnifiedIdeograph>} );

# WhiteSpace


ok("\c[CHARACTER TABULATION]" ~~ m/^<.isWhiteSpace>$/, q{Match <.isWhiteSpace>} );
ok(!( "\c[CHARACTER TABULATION]" ~~ m/^<!isWhiteSpace>.$/ ), q{Don't match negated <isWhiteSpace>} );
ok(!( "\c[CHARACTER TABULATION]" ~~ m/^<-isWhiteSpace>$/ ), q{Don't match inverted <isWhiteSpace>} );
ok(!( "\x[6358]"  ~~ m/^<.isWhiteSpace>$/ ), q{Don't match unrelated <isWhiteSpace>} );
ok("\x[6358]"  ~~ m/^<!isWhiteSpace>.$/, q{Match unrelated negated <isWhiteSpace>} );
ok("\x[6358]"  ~~ m/^<-isWhiteSpace>$/, q{Match unrelated inverted <isWhiteSpace>} );
ok("\x[6358]\c[CHARACTER TABULATION]" ~~ m/<.isWhiteSpace>/, q{Match unanchored <isWhiteSpace>} );

# Alphabetic      # Lu + Ll + Lt + Lm + Lo + OtherAlphabetic


ok("\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<.isAlphabetic>$/, q{Match (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<!isAlphabetic>.$/ ), q{Don't match negated (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<-isAlphabetic>$/ ), q{Don't match inverted (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok(!( "\x[0855]"  ~~ m/^<.isAlphabetic>$/ ), q{Don't match unrelated (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok("\x[0855]"  ~~ m/^<!isAlphabetic>.$/, q{Match unrelated negated (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok("\x[0855]"  ~~ m/^<-isAlphabetic>$/, q{Match unrelated inverted (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok("\x[0855]\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/<.isAlphabetic>/, q{Match unanchored (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );

# Lowercase       # Ll + OtherLowercase


ok("\c[LATIN SMALL LETTER A]" ~~ m/^<.isLowercase>$/, q{Match (Ll + OtherLowercase)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<!isLowercase>.$/ ), q{Don't match negated (Ll + OtherLowercase)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<-isLowercase>$/ ), q{Don't match inverted (Ll + OtherLowercase)} );
ok(!( "\x[6220]"  ~~ m/^<.isLowercase>$/ ), q{Don't match unrelated (Ll + OtherLowercase)} );
ok("\x[6220]"  ~~ m/^<!isLowercase>.$/, q{Match unrelated negated (Ll + OtherLowercase)} );
ok("\x[6220]"  ~~ m/^<-isLowercase>$/, q{Match unrelated inverted (Ll + OtherLowercase)} );
ok(!( "\x[6220]" ~~ m/^<.isLowercase>$/ ), q{Don't match related (Ll + OtherLowercase)} );
ok("\x[6220]" ~~ m/^<!isLowercase>.$/, q{Match related negated (Ll + OtherLowercase)} );
ok("\x[6220]" ~~ m/^<-isLowercase>$/, q{Match related inverted (Ll + OtherLowercase)} );
ok("\x[6220]\x[6220]\c[LATIN SMALL LETTER A]" ~~ m/<.isLowercase>/, q{Match unanchored (Ll + OtherLowercase)} );

# Uppercase       # Lu + OtherUppercase


ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<.isUppercase>$/, q{Match (Lu + OtherUppercase)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<!isUppercase>.$/ ), q{Don't match negated (Lu + OtherUppercase)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-isUppercase>$/ ), q{Don't match inverted (Lu + OtherUppercase)} );
ok(!( "\x[C080]"  ~~ m/^<.isUppercase>$/ ), q{Don't match unrelated (Lu + OtherUppercase)} );
ok("\x[C080]"  ~~ m/^<!isUppercase>.$/, q{Match unrelated negated (Lu + OtherUppercase)} );
ok("\x[C080]"  ~~ m/^<-isUppercase>$/, q{Match unrelated inverted (Lu + OtherUppercase)} );
ok("\x[C080]\c[LATIN CAPITAL LETTER A]" ~~ m/<.isUppercase>/, q{Match unanchored (Lu + OtherUppercase)} );

# Math            # Sm + OtherMath


ok("\c[PLUS SIGN]" ~~ m/^<.isMath>$/, q{Match (Sm + OtherMath)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<!isMath>.$/ ), q{Don't match negated (Sm + OtherMath)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<-isMath>$/ ), q{Don't match inverted (Sm + OtherMath)} );
ok(!( "\x[D4D2]"  ~~ m/^<.isMath>$/ ), q{Don't match unrelated (Sm + OtherMath)} );
ok("\x[D4D2]"  ~~ m/^<!isMath>.$/, q{Match unrelated negated (Sm + OtherMath)} );
ok("\x[D4D2]"  ~~ m/^<-isMath>$/, q{Match unrelated inverted (Sm + OtherMath)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<.isMath>$/ ), q{Don't match related (Sm + OtherMath)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isMath>.$/, q{Match related negated (Sm + OtherMath)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isMath>$/, q{Match related inverted (Sm + OtherMath)} );
ok("\x[D4D2]\c[COMBINING GRAVE ACCENT]\c[PLUS SIGN]" ~~ m/<.isMath>/, q{Match unanchored (Sm + OtherMath)} );

# ID_Start        # Lu + Ll + Lt + Lm + Lo + Nl


ok("\x[C276]" ~~ m/^<.isID_Start>$/, q{Match (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok(!( "\x[C276]" ~~ m/^<!isID_Start>.$/ ), q{Don't match negated (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok(!( "\x[C276]" ~~ m/^<-isID_Start>$/ ), q{Don't match inverted (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok(!( "\x[D7A4]"  ~~ m/^<.isID_Start>$/ ), q{Don't match unrelated (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok("\x[D7A4]"  ~~ m/^<!isID_Start>.$/, q{Match unrelated negated (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok("\x[D7A4]"  ~~ m/^<-isID_Start>$/, q{Match unrelated inverted (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok("\x[D7A4]\x[C276]" ~~ m/<.isID_Start>/, q{Match unanchored (Lu + Ll + Lt + Lm + Lo + Nl)} );

# ID_Continue     # ID_Start + Mn + Mc + Nd + Pc


ok("\x[949B]" ~~ m/^<.isID_Continue>$/, q{Match (ID_Start + Mn + Mc + Nd + Pc)} );
ok(!( "\x[949B]" ~~ m/^<!isID_Continue>.$/ ), q{Don't match negated (ID_Start + Mn + Mc + Nd + Pc)} );
ok(!( "\x[949B]" ~~ m/^<-isID_Continue>$/ ), q{Don't match inverted (ID_Start + Mn + Mc + Nd + Pc)} );
ok(!( "\x[9FC4]"  ~~ m/^<.isID_Continue>$/ ), q{Don't match unrelated (ID_Start + Mn + Mc + Nd + Pc)} );
ok("\x[9FC4]"  ~~ m/^<!isID_Continue>.$/, q{Match unrelated negated (ID_Start + Mn + Mc + Nd + Pc)} );
ok("\x[9FC4]"  ~~ m/^<-isID_Continue>$/, q{Match unrelated inverted (ID_Start + Mn + Mc + Nd + Pc)} );
ok("\x[9FC4]\x[949B]" ~~ m/<.isID_Continue>/, q{Match unanchored (ID_Start + Mn + Mc + Nd + Pc)} );

# Any             # Any character

#?rakudo 4 skip 'isAny not implemented'
ok("\x[C709]" ~~ m/^<.isAny>$/, q{Match (Any character)} );
ok(!( "\x[C709]" ~~ m/^<!isAny>.$/ ), q{Don't match negated (Any character)} );
ok(!( "\x[C709]" ~~ m/^<-isAny>$/ ), q{Don't match inverted (Any character)} );
ok("\x[C709]" ~~ m/<.isAny>/, q{Match unanchored (Any character)} );

# Assigned        # Any non-Cn character (i.e. synonym for \P{Cn})


#?rakudo 7 skip 'isAssigned not implemented'
ok("\x[C99D]" ~~ m/^<.isAssigned>$/, q<Match (Any non-Cn character (i.e. synonym for \P{Cn}))> );
ok(!( "\x[C99D]" ~~ m/^<!isAssigned>.$/ ), q<Don't match negated (Any non-Cn character (i.e. synonym for \P{Cn}))> );
ok(!( "\x[C99D]" ~~ m/^<-isAssigned>$/ ), q<Don't match inverted (Any non-Cn character (i.e. synonym for \P{Cn}))> );
ok(!( "\x[D7A4]"  ~~ m/^<.isAssigned>$/ ), q<Don't match unrelated (Any non-Cn character (i.e. synonym for \P{Cn}))> );
ok("\x[D7A4]"  ~~ m/^<!isAssigned>.$/, q<Match unrelated negated (Any non-Cn character (i.e. synonym for \P{Cn}))> );
ok("\x[D7A4]"  ~~ m/^<-isAssigned>$/, q<Match unrelated inverted (Any non-Cn character (i.e. synonym for \P{Cn}))> );
ok("\x[D7A4]\x[C99D]" ~~ m/<.isAssigned>/, q<Match unanchored (Any non-Cn character (i.e. synonym for \P{Cn}))> );

# Unassigned      # Synonym for \p{Cn}


#?rakudo 7 skip 'isUnassigned not implemented'
ok("\x[27EC]" ~~ m/^<.isUnassigned>$/, q<Match (Synonym for \p{Cn})> );
ok(!( "\x[27EC]" ~~ m/^<!isUnassigned>.$/ ), q<Don't match negated (Synonym for \p{Cn})> );
ok(!( "\x[27EC]" ~~ m/^<-isUnassigned>$/ ), q<Don't match inverted (Synonym for \p{Cn})> );
ok(!( "\c[RIGHT OUTER JOIN]"  ~~ m/^<.isUnassigned>$/ ), q<Don't match unrelated (Synonym for \p{Cn})> );
ok("\c[RIGHT OUTER JOIN]"  ~~ m/^<!isUnassigned>.$/, q<Match unrelated negated (Synonym for \p{Cn})> );
ok("\c[RIGHT OUTER JOIN]"  ~~ m/^<-isUnassigned>$/, q<Match unrelated inverted (Synonym for \p{Cn})> );
ok("\c[RIGHT OUTER JOIN]\x[27EC]" ~~ m/<.isUnassigned>/, q<Match unanchored (Synonym for \p{Cn})> );

# Common          # Codepoint not explicitly assigned to a script


#?rakudo 10 skip 'isCommon not implemented'
ok("\x[0C7E]" ~~ m/^<.isCommon>$/, q{Match (Codepoint not explicitly assigned to a script)} );
ok(!( "\x[0C7E]" ~~ m/^<!isCommon>.$/ ), q{Don't match negated (Codepoint not explicitly assigned to a script)} );
ok(!( "\x[0C7E]" ~~ m/^<-isCommon>$/ ), q{Don't match inverted (Codepoint not explicitly assigned to a script)} );
ok(!( "\c[KANNADA SIGN ANUSVARA]"  ~~ m/^<.isCommon>$/ ), q{Don't match unrelated (Codepoint not explicitly assigned to a script)} );
ok("\c[KANNADA SIGN ANUSVARA]"  ~~ m/^<!isCommon>.$/, q{Match unrelated negated (Codepoint not explicitly assigned to a script)} );
ok("\c[KANNADA SIGN ANUSVARA]"  ~~ m/^<-isCommon>$/, q{Match unrelated inverted (Codepoint not explicitly assigned to a script)} );
ok(!( "\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<.isCommon>$/ ), q{Don't match related (Codepoint not explicitly assigned to a script)} );
ok("\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<!isCommon>.$/, q{Match related negated (Codepoint not explicitly assigned to a script)} );
ok("\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<-isCommon>$/, q{Match related inverted (Codepoint not explicitly assigned to a script)} );
ok("\c[KANNADA SIGN ANUSVARA]\c[KHMER VOWEL INHERENT AQ]\x[0C7E]" ~~ m/<.isCommon>/, q{Match unanchored (Codepoint not explicitly assigned to a script)} );


# vim: ft=perl6
