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

#?pugs todo
ok("\c[DIGIT ZERO]" ~~ m/^<:ASCIIHexDigit>$/, q{Match <:ASCIIHexDigit>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:!ASCIIHexDigit>$/ ), q{Don't match negated <ASCIIHexDigit>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-:ASCIIHexDigit>$/ ), q{Don't match inverted <ASCIIHexDigit>} );
ok(!( "\x[53BA]"  ~~ m/^<:ASCIIHexDigit>$/ ), q{Don't match unrelated <ASCIIHexDigit>} );
#?pugs todo
ok("\x[53BA]"  ~~ m/^<:!ASCIIHexDigit>$/, q{Match unrelated negated <ASCIIHexDigit>} );
#?pugs todo
ok("\x[53BA]"  ~~ m/^<-:ASCIIHexDigit>$/, q{Match unrelated inverted <ASCIIHexDigit>} );
#?pugs todo
ok("\x[53BA]\c[DIGIT ZERO]" ~~ m/<:ASCIIHexDigit>/, q{Match unanchored <ASCIIHexDigit>} );

# Dash


#?pugs todo
ok("\c[HYPHEN-MINUS]" ~~ m/^<:Dash>$/, q{Match <:Dash>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<:!Dash>$/ ), q{Don't match negated <Dash>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<-:Dash>$/ ), q{Don't match inverted <Dash>} );
ok(!( "\x[53F7]"  ~~ m/^<:Dash>$/ ), q{Don't match unrelated <Dash>} );
#?pugs todo
ok("\x[53F7]"  ~~ m/^<:!Dash>$/, q{Match unrelated negated <Dash>} );
#?pugs todo
ok("\x[53F7]"  ~~ m/^<-:Dash>$/, q{Match unrelated inverted <Dash>} );
#?pugs todo
ok("\x[53F7]\c[HYPHEN-MINUS]" ~~ m/<:Dash>/, q{Match unanchored <Dash>} );

# Diacritic


#?pugs todo
ok("\c[MODIFIER LETTER CAPITAL A]" ~~ m/^<:Diacritic>$/, q{Match <:Diacritic>} );
ok(!( "\c[MODIFIER LETTER CAPITAL A]" ~~ m/^<:!Diacritic>$/ ), q{Don't match negated <Diacritic>} );
ok(!( "\c[MODIFIER LETTER CAPITAL A]" ~~ m/^<-:Diacritic>$/ ), q{Don't match inverted <Diacritic>} );
ok(!( "\x[1BCD]"  ~~ m/^<:Diacritic>$/ ), q{Don't match unrelated <Diacritic>} );
#?pugs todo
ok("\x[1BCD]"  ~~ m/^<:!Diacritic>$/, q{Match unrelated negated <Diacritic>} );
#?pugs todo
ok("\x[1BCD]"  ~~ m/^<-:Diacritic>$/, q{Match unrelated inverted <Diacritic>} );
#?pugs todo
ok("\x[1BCD]\c[MODIFIER LETTER CAPITAL A]" ~~ m/<:Diacritic>/, q{Match unanchored <Diacritic>} );

# Extender


#?pugs todo
ok("\c[MIDDLE DOT]" ~~ m/^<:Extender>$/, q{Match <:Extender>} );
ok(!( "\c[MIDDLE DOT]" ~~ m/^<:!Extender>$/ ), q{Don't match negated <Extender>} );
ok(!( "\c[MIDDLE DOT]" ~~ m/^<-:Extender>$/ ), q{Don't match inverted <Extender>} );
ok(!( "\x[3A18]"  ~~ m/^<:Extender>$/ ), q{Don't match unrelated <Extender>} );
#?pugs todo
ok("\x[3A18]"  ~~ m/^<:!Extender>$/, q{Match unrelated negated <Extender>} );
#?pugs todo
ok("\x[3A18]"  ~~ m/^<-:Extender>$/, q{Match unrelated inverted <Extender>} );
#?pugs todo
ok("\x[3A18]\c[MIDDLE DOT]" ~~ m/<:Extender>/, q{Match unanchored <Extender>} );

# GraphemeLink


#?pugs todo
#?rakudo.jvm    7 skip "isGraphemeLink"
ok("\c[HANUNOO SIGN PAMUDPOD]" ~~ m/^<:GraphemeLink>$/, q{Match <:GraphemeLink>} );
ok(!( "\c[HANUNOO SIGN PAMUDPOD]" ~~ m/^<:!GraphemeLink>$/ ), q{Don't match negated <GraphemeLink>} );
ok(!( "\c[HANUNOO SIGN PAMUDPOD]" ~~ m/^<-:GraphemeLink>$/ ), q{Don't match inverted <GraphemeLink>} );
ok(!( "\x[4989]"  ~~ m/^<:GraphemeLink>$/ ), q{Don't match unrelated <GraphemeLink>} );
#?pugs todo
ok("\x[4989]"  ~~ m/^<:!GraphemeLink>$/, q{Match unrelated negated <GraphemeLink>} );
#?pugs todo
ok("\x[4989]"  ~~ m/^<-:GraphemeLink>$/, q{Match unrelated inverted <GraphemeLink>} );
#?pugs todo
ok("\x[4989]\c[HANUNOO SIGN PAMUDPOD]" ~~ m/<:GraphemeLink>/, q{Match unanchored <GraphemeLink>} );

# HexDigit


#?pugs todo
ok("\c[DIGIT ZERO]" ~~ m/^<:HexDigit>$/, q{Match <:HexDigit>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:!HexDigit>$/ ), q{Don't match negated <HexDigit>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-:HexDigit>$/ ), q{Don't match inverted <HexDigit>} );
ok(!( "\x[6292]"  ~~ m/^<:HexDigit>$/ ), q{Don't match unrelated <HexDigit>} );
#?pugs todo
ok("\x[6292]"  ~~ m/^<:!HexDigit>$/, q{Match unrelated negated <HexDigit>} );
#?pugs todo
ok("\x[6292]"  ~~ m/^<-:HexDigit>$/, q{Match unrelated inverted <HexDigit>} );
#?pugs todo
ok("\x[6292]\c[DIGIT ZERO]" ~~ m/<:HexDigit>/, q{Match unanchored <HexDigit>} );

# Hyphen

#?pugs todo
ok("\c[KATAKANA MIDDLE DOT]" ~~ m/^<:Hyphen>$/, q{Match <:Hyphen>} );
ok(!( "\c[KATAKANA MIDDLE DOT]" ~~ m/^<:!Hyphen>$/ ), q{Don't match negated <Hyphen>} );
ok(!( "\c[KATAKANA MIDDLE DOT]" ~~ m/^<-:Hyphen>$/ ), q{Don't match inverted <Hyphen>} );
ok(!( "\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]"  ~~ m/^<:Hyphen>$/ ), q{Don't match unrelated <Hyphen>} );
#?pugs todo
ok("\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]"  ~~ m/^<:!Hyphen>$/, q{Match unrelated negated <Hyphen>} );
#?pugs todo
ok("\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]"  ~~ m/^<-:Hyphen>$/, q{Match unrelated inverted <Hyphen>} );
#?pugs todo
ok("\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]\c[KATAKANA MIDDLE DOT]" ~~ m/<:Hyphen>/, q{Match unanchored <Hyphen>} );

# Ideographic


#?pugs todo
ok("\x[8AB0]" ~~ m/^<:Ideographic>$/, q{Match <:Ideographic>} );
ok(!( "\x[8AB0]" ~~ m/^<:!Ideographic>$/ ), q{Don't match negated <Ideographic>} );
ok(!( "\x[8AB0]" ~~ m/^<-:Ideographic>$/ ), q{Don't match inverted <Ideographic>} );
ok(!( "\x[9FCD]"  ~~ m/^<:Ideographic>$/ ), q{Don't match unrelated <Ideographic>} );
#?pugs todo
ok("\x[9FCD]"  ~~ m/^<:!Ideographic>$/, q{Match unrelated negated <Ideographic>} );
#?pugs todo
ok("\x[9FCD]"  ~~ m/^<-:Ideographic>$/, q{Match unrelated inverted <Ideographic>} );
#?pugs todo
ok("\x[9FCD]\x[8AB0]" ~~ m/<:Ideographic>/, q{Match unanchored <Ideographic>} );

# IDSBinaryOperator


#?pugs todo
ok("\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<:IDSBinaryOperator>$/, q{Match <:IDSBinaryOperator>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<:!IDSBinaryOperator>$/ ), q{Don't match negated <IDSBinaryOperator>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<-:IDSBinaryOperator>$/ ), q{Don't match inverted <IDSBinaryOperator>} );
ok(!( "\x[59E9]"  ~~ m/^<:IDSBinaryOperator>$/ ), q{Don't match unrelated <IDSBinaryOperator>} );
#?pugs todo
ok("\x[59E9]"  ~~ m/^<:!IDSBinaryOperator>$/, q{Match unrelated negated <IDSBinaryOperator>} );
#?pugs todo
ok("\x[59E9]"  ~~ m/^<-:IDSBinaryOperator>$/, q{Match unrelated inverted <IDSBinaryOperator>} );
#?pugs todo
ok("\x[59E9]\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/<:IDSBinaryOperator>/, q{Match unanchored <IDSBinaryOperator>} );

# IDSTrinaryOperator

#?pugs todo
ok("\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/^<:IDSTrinaryOperator>$/, q{Match <:IDSTrinaryOperator>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/^<:!IDSTrinaryOperator>$/ ), q{Don't match negated <IDSTrinaryOperator>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/^<-:IDSTrinaryOperator>$/ ), q{Don't match inverted <IDSTrinaryOperator>} );
ok(!( "\x[9224]"  ~~ m/^<:IDSTrinaryOperator>$/ ), q{Don't match unrelated <IDSTrinaryOperator>} );
#?pugs todo
ok("\x[9224]"  ~~ m/^<:!IDSTrinaryOperator>$/, q{Match unrelated negated <IDSTrinaryOperator>} );
#?pugs todo
ok("\x[9224]"  ~~ m/^<-:IDSTrinaryOperator>$/, q{Match unrelated inverted <IDSTrinaryOperator>} );
#?pugs todo
ok("\x[9224]\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/<:IDSTrinaryOperator>/, q{Match unanchored <IDSTrinaryOperator>} );

# JoinControl


#?pugs todo
ok("\c[ZERO WIDTH NON-JOINER]" ~~ m/^<:JoinControl>$/, q{Match <:JoinControl>} );
ok(!( "\c[ZERO WIDTH NON-JOINER]" ~~ m/^<:!JoinControl>$/ ), q{Don't match negated <JoinControl>} );
ok(!( "\c[ZERO WIDTH NON-JOINER]" ~~ m/^<-:JoinControl>$/ ), q{Don't match inverted <JoinControl>} );
ok(!( "\c[BENGALI LETTER DDHA]"  ~~ m/^<:JoinControl>$/ ), q{Don't match unrelated <JoinControl>} );
#?niecza todo
#?pugs todo
ok("\c[BENGALI LETTER DDHA]"  ~~ m/^<:!JoinControl>$/, q{Match unrelated negated <JoinControl>} );
#?pugs todo
ok("\c[BENGALI LETTER DDHA]"  ~~ m/^<-:JoinControl>$/, q{Match unrelated inverted <JoinControl>} );
#?pugs todo
ok("\c[BENGALI LETTER DDHA]\c[ZERO WIDTH NON-JOINER]" ~~ m/<:JoinControl>/, q{Match unanchored <JoinControl>} );

# LogicalOrderException


#?pugs todo
ok("\c[THAI CHARACTER SARA E]" ~~ m/^<:LogicalOrderException>$/, q{Match <:LogicalOrderException>} );
ok(!( "\c[THAI CHARACTER SARA E]" ~~ m/^<:!LogicalOrderException>$/ ), q{Don't match negated <LogicalOrderException>} );
ok(!( "\c[THAI CHARACTER SARA E]" ~~ m/^<-:LogicalOrderException>$/ ), q{Don't match inverted <LogicalOrderException>} );
ok(!( "\x[857B]"  ~~ m/^<:LogicalOrderException>$/ ), q{Don't match unrelated <LogicalOrderException>} );
#?pugs todo
ok("\x[857B]"  ~~ m/^<:!LogicalOrderException>$/, q{Match unrelated negated <LogicalOrderException>} );
#?pugs todo
ok("\x[857B]"  ~~ m/^<-:LogicalOrderException>$/, q{Match unrelated inverted <LogicalOrderException>} );
ok(!( "\x[857B]" ~~ m/^<:LogicalOrderException>$/ ), q{Don't match related <LogicalOrderException>} );
#?pugs todo
ok("\x[857B]" ~~ m/^<:!LogicalOrderException>$/, q{Match related negated <LogicalOrderException>} );
#?pugs todo
ok("\x[857B]" ~~ m/^<-:LogicalOrderException>$/, q{Match related inverted <LogicalOrderException>} );
#?pugs todo
ok("\x[857B]\x[857B]\c[THAI CHARACTER SARA E]" ~~ m/<:LogicalOrderException>/, q{Match unanchored <LogicalOrderException>} );

# NoncharacterCodePoint

ok(!( "\c[LATIN LETTER REVERSED GLOTTAL STOP WITH STROKE]"  ~~ m/^<:NoncharacterCodePoint>$/ ), q{Don't match unrelated <NoncharacterCodePoint>} );
#?niecza todo
#?pugs todo
ok("\c[LATIN LETTER REVERSED GLOTTAL STOP WITH STROKE]"  ~~ m/^<:!NoncharacterCodePoint>$/, q{Match unrelated negated <NoncharacterCodePoint>} );
#?pugs todo
ok("\c[LATIN LETTER REVERSED GLOTTAL STOP WITH STROKE]"  ~~ m/^<-:NoncharacterCodePoint>$/, q{Match unrelated inverted <NoncharacterCodePoint>} );
ok(!( "\c[ARABIC-INDIC DIGIT ZERO]" ~~ m/^<:NoncharacterCodePoint>$/ ), q{Don't match related <NoncharacterCodePoint>} );
#?niecza todo
#?pugs todo
ok("\c[ARABIC-INDIC DIGIT ZERO]" ~~ m/^<:!NoncharacterCodePoint>$/, q{Match related negated <NoncharacterCodePoint>} );
#?pugs todo
ok("\c[ARABIC-INDIC DIGIT ZERO]" ~~ m/^<-:NoncharacterCodePoint>$/, q{Match related inverted <NoncharacterCodePoint>} );

# OtherAlphabetic

#?rakudo.jvm 42 skip "isOther* not implemented"
#?rakudo.parrot 42 skip "isOther* not implemented"
#?pugs todo
ok("\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<:OtherAlphabetic>$/, q{Match <:OtherAlphabetic>} );
ok(!( "\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<:!OtherAlphabetic>$/ ), q{Don't match negated <OtherAlphabetic>} );
ok(!( "\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<-:OtherAlphabetic>$/ ), q{Don't match inverted <OtherAlphabetic>} );
ok(!( "\x[413C]"  ~~ m/^<:OtherAlphabetic>$/ ), q{Don't match unrelated <OtherAlphabetic>} );
#?pugs todo
ok("\x[413C]"  ~~ m/^<:!OtherAlphabetic>$/, q{Match unrelated negated <OtherAlphabetic>} );
#?pugs todo
ok("\x[413C]"  ~~ m/^<-:OtherAlphabetic>$/, q{Match unrelated inverted <OtherAlphabetic>} );
#?pugs todo
ok("\x[413C]\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/<:OtherAlphabetic>/, q{Match unanchored <OtherAlphabetic>} );

# OtherDefaultIgnorableCodePoint


#?pugs todo
ok("\c[HANGUL FILLER]" ~~ m/^<:OtherDefaultIgnorableCodePoint>$/, q{Match <:OtherDefaultIgnorableCodePoint>} );
ok(!( "\c[HANGUL FILLER]" ~~ m/^<:!OtherDefaultIgnorableCodePoint>$/ ), q{Don't match negated <OtherDefaultIgnorableCodePoint>} );
ok(!( "\c[HANGUL FILLER]" ~~ m/^<-:OtherDefaultIgnorableCodePoint>$/ ), q{Don't match inverted <OtherDefaultIgnorableCodePoint>} );
ok(!( "\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<:OtherDefaultIgnorableCodePoint>$/ ), q{Don't match unrelated <OtherDefaultIgnorableCodePoint>} );
#?pugs todo
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<:!OtherDefaultIgnorableCodePoint>$/, q{Match unrelated negated <OtherDefaultIgnorableCodePoint>} );
#?pugs todo
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<-:OtherDefaultIgnorableCodePoint>$/, q{Match unrelated inverted <OtherDefaultIgnorableCodePoint>} );
#?pugs todo
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]\c[HANGUL FILLER]" ~~ m/<:OtherDefaultIgnorableCodePoint>/, q{Match unanchored <OtherDefaultIgnorableCodePoint>} );

# OtherGraphemeExtend


#?pugs todo
ok("\c[BENGALI VOWEL SIGN AA]" ~~ m/^<:OtherGraphemeExtend>$/, q{Match <:OtherGraphemeExtend>} );
ok(!( "\c[BENGALI VOWEL SIGN AA]" ~~ m/^<:!OtherGraphemeExtend>$/ ), q{Don't match negated <OtherGraphemeExtend>} );
ok(!( "\c[BENGALI VOWEL SIGN AA]" ~~ m/^<-:OtherGraphemeExtend>$/ ), q{Don't match inverted <OtherGraphemeExtend>} );
ok(!( "\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<:OtherGraphemeExtend>$/ ), q{Don't match unrelated <OtherGraphemeExtend>} );
#?pugs todo
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<:!OtherGraphemeExtend>$/, q{Match unrelated negated <OtherGraphemeExtend>} );
#?pugs todo
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<-:OtherGraphemeExtend>$/, q{Match unrelated inverted <OtherGraphemeExtend>} );
#?pugs todo
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]\c[BENGALI VOWEL SIGN AA]" ~~ m/<:OtherGraphemeExtend>/, q{Match unanchored <OtherGraphemeExtend>} );

# OtherLowercase


#?pugs todo
ok("\c[MODIFIER LETTER SMALL H]" ~~ m/^<:OtherLowercase>$/, q{Match <:OtherLowercase>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<:!OtherLowercase>$/ ), q{Don't match negated <OtherLowercase>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<-:OtherLowercase>$/ ), q{Don't match inverted <OtherLowercase>} );
ok(!( "\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<:OtherLowercase>$/ ), q{Don't match unrelated <OtherLowercase>} );
#?pugs todo
ok("\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<:!OtherLowercase>$/, q{Match unrelated negated <OtherLowercase>} );
#?pugs todo
ok("\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<-:OtherLowercase>$/, q{Match unrelated inverted <OtherLowercase>} );
#?pugs todo
ok("\c[HANGUL LETTER NIEUN-CIEUC]\c[MODIFIER LETTER SMALL H]" ~~ m/<:OtherLowercase>/, q{Match unanchored <OtherLowercase>} );

# OtherMath


#?niecza todo
#?pugs todo
ok("\c[LEFT PARENTHESIS]" ~~ m/^<:OtherMath>$/, q{Match <:OtherMath>} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<:!OtherMath>$/ ), q{Don't match negated <OtherMath>} );
#?niecza todo
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<-:OtherMath>$/ ), q{Don't match inverted <OtherMath>} );
ok(!( "\x[B43A]"  ~~ m/^<:OtherMath>$/ ), q{Don't match unrelated <OtherMath>} );
#?pugs todo
ok("\x[B43A]"  ~~ m/^<:!OtherMath>$/, q{Match unrelated negated <OtherMath>} );
#?pugs todo
ok("\x[B43A]"  ~~ m/^<-:OtherMath>$/, q{Match unrelated inverted <OtherMath>} );
#?niecza todo
#?pugs todo
ok("\x[B43A]\c[LEFT PARENTHESIS]" ~~ m/<:OtherMath>/, q{Match unanchored <OtherMath>} );

# OtherUppercase


#?pugs todo
ok("\c[ROMAN NUMERAL ONE]" ~~ m/^<:OtherUppercase>$/, q{Match <:OtherUppercase>} );
ok(!( "\c[ROMAN NUMERAL ONE]" ~~ m/^<:!OtherUppercase>$/ ), q{Don't match negated <OtherUppercase>} );
ok(!( "\c[ROMAN NUMERAL ONE]" ~~ m/^<-:OtherUppercase>$/ ), q{Don't match inverted <OtherUppercase>} );
ok(!( "\x[D246]"  ~~ m/^<:OtherUppercase>$/ ), q{Don't match unrelated <OtherUppercase>} );
#?pugs todo
ok("\x[D246]"  ~~ m/^<:!OtherUppercase>$/, q{Match unrelated negated <OtherUppercase>} );
#?pugs todo
ok("\x[D246]"  ~~ m/^<-:OtherUppercase>$/, q{Match unrelated inverted <OtherUppercase>} );
#?pugs todo
ok("\x[D246]\c[ROMAN NUMERAL ONE]" ~~ m/<:OtherUppercase>/, q{Match unanchored <OtherUppercase>} );

# QuotationMark


#?pugs todo
ok("\c[QUOTATION MARK]" ~~ m/^<:QuotationMark>$/, q{Match <:QuotationMark>} );
ok(!( "\c[QUOTATION MARK]" ~~ m/^<:!QuotationMark>$/ ), q{Don't match negated <QuotationMark>} );
ok(!( "\c[QUOTATION MARK]" ~~ m/^<-:QuotationMark>$/ ), q{Don't match inverted <QuotationMark>} );
ok(!( "\x[C890]"  ~~ m/^<:QuotationMark>$/ ), q{Don't match unrelated <QuotationMark>} );
#?pugs todo
ok("\x[C890]"  ~~ m/^<:!QuotationMark>$/, q{Match unrelated negated <QuotationMark>} );
#?pugs todo
ok("\x[C890]"  ~~ m/^<-:QuotationMark>$/, q{Match unrelated inverted <QuotationMark>} );
#?pugs todo
ok("\x[C890]\c[QUOTATION MARK]" ~~ m/<:QuotationMark>/, q{Match unanchored <QuotationMark>} );

# Radical


#?pugs todo
ok("\c[CJK RADICAL REPEAT]" ~~ m/^<:Radical>$/, q{Match <:Radical>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<:!Radical>$/ ), q{Don't match negated <Radical>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<-:Radical>$/ ), q{Don't match inverted <Radical>} );
ok(!( "\c[HANGUL JONGSEONG CHIEUCH]"  ~~ m/^<:Radical>$/ ), q{Don't match unrelated <Radical>} );
#?niecza todo
#?pugs todo
ok("\c[HANGUL JONGSEONG CHIEUCH]"  ~~ m/^<:!Radical>$/, q{Match unrelated negated <Radical>} );
#?pugs todo
ok("\c[HANGUL JONGSEONG CHIEUCH]"  ~~ m/^<-:Radical>$/, q{Match unrelated inverted <Radical>} );
#?pugs todo
ok("\c[HANGUL JONGSEONG CHIEUCH]\c[CJK RADICAL REPEAT]" ~~ m/<:Radical>/, q{Match unanchored <Radical>} );

# SoftDotted


#?pugs todo
ok("\c[LATIN SMALL LETTER I]" ~~ m/^<:SoftDotted>$/, q{Match <:SoftDotted>} );
ok(!( "\c[LATIN SMALL LETTER I]" ~~ m/^<:!SoftDotted>$/ ), q{Don't match negated <SoftDotted>} );
ok(!( "\c[LATIN SMALL LETTER I]" ~~ m/^<-:SoftDotted>$/ ), q{Don't match inverted <SoftDotted>} );
ok(!( "\x[ADEF]"  ~~ m/^<:SoftDotted>$/ ), q{Don't match unrelated <SoftDotted>} );
#?pugs todo
ok("\x[ADEF]"  ~~ m/^<:!SoftDotted>$/, q{Match unrelated negated <SoftDotted>} );
#?pugs todo
ok("\x[ADEF]"  ~~ m/^<-:SoftDotted>$/, q{Match unrelated inverted <SoftDotted>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<:SoftDotted>$/ ), q{Don't match related <SoftDotted>} );
#?niecza todo
#?pugs todo
ok("\c[DOLLAR SIGN]" ~~ m/^<:!SoftDotted>$/, q{Match related negated <SoftDotted>} );
#?pugs todo
ok("\c[DOLLAR SIGN]" ~~ m/^<-:SoftDotted>$/, q{Match related inverted <SoftDotted>} );
#?pugs todo
ok("\x[ADEF]\c[DOLLAR SIGN]\c[LATIN SMALL LETTER I]" ~~ m/<:SoftDotted>/, q{Match unanchored <SoftDotted>} );

# TerminalPunctuation


#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<:TerminalPunctuation>$/, q{Match <:TerminalPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:!TerminalPunctuation>$/ ), q{Don't match negated <TerminalPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-:TerminalPunctuation>$/ ), q{Don't match inverted <TerminalPunctuation>} );
ok(!( "\x[3C9D]"  ~~ m/^<:TerminalPunctuation>$/ ), q{Don't match unrelated <TerminalPunctuation>} );
#?pugs todo
ok("\x[3C9D]"  ~~ m/^<:!TerminalPunctuation>$/, q{Match unrelated negated <TerminalPunctuation>} );
#?pugs todo
ok("\x[3C9D]"  ~~ m/^<-:TerminalPunctuation>$/, q{Match unrelated inverted <TerminalPunctuation>} );
#?pugs todo
ok("\x[3C9D]\c[EXCLAMATION MARK]" ~~ m/<:TerminalPunctuation>/, q{Match unanchored <TerminalPunctuation>} );

# UnifiedIdeograph


#?pugs todo
ok("\x[7896]" ~~ m/^<:UnifiedIdeograph>$/, q{Match <:UnifiedIdeograph>} );
ok(!( "\x[7896]" ~~ m/^<:!UnifiedIdeograph>$/ ), q{Don't match negated <UnifiedIdeograph>} );
ok(!( "\x[7896]" ~~ m/^<-:UnifiedIdeograph>$/ ), q{Don't match inverted <UnifiedIdeograph>} );
#?rakudo.jvm 3 skip 'icu'
#?rakudo.parrot 3 skip 'icu'
#?niecza 3 todo
ok(!( "\x[9FC4]"  ~~ m/^<:UnifiedIdeograph>$/ ), q{Don't match unrelated <UnifiedIdeograph>} );
#?pugs todo
ok("\x[9FC4]"  ~~ m/^<:!UnifiedIdeograph>$/, q{Match unrelated negated <UnifiedIdeograph>} );
#?pugs todo
ok("\x[9FC4]"  ~~ m/^<-:UnifiedIdeograph>$/, q{Match unrelated inverted <UnifiedIdeograph>} );
#?pugs todo
ok("\x[9FC4]\x[7896]" ~~ m/<:UnifiedIdeograph>/, q{Match unanchored <UnifiedIdeograph>} );

# WhiteSpace


#?pugs todo
ok("\c[CHARACTER TABULATION]" ~~ m/^<:WhiteSpace>$/, q{Match <:WhiteSpace>} );
ok(!( "\c[CHARACTER TABULATION]" ~~ m/^<:!WhiteSpace>$/ ), q{Don't match negated <WhiteSpace>} );
ok(!( "\c[CHARACTER TABULATION]" ~~ m/^<-:WhiteSpace>$/ ), q{Don't match inverted <WhiteSpace>} );
ok(!( "\x[6358]"  ~~ m/^<:WhiteSpace>$/ ), q{Don't match unrelated <WhiteSpace>} );
#?pugs todo
ok("\x[6358]"  ~~ m/^<:!WhiteSpace>$/, q{Match unrelated negated <WhiteSpace>} );
#?pugs todo
ok("\x[6358]"  ~~ m/^<-:WhiteSpace>$/, q{Match unrelated inverted <WhiteSpace>} );
#?pugs todo
ok("\x[6358]\c[CHARACTER TABULATION]" ~~ m/<:WhiteSpace>/, q{Match unanchored <WhiteSpace>} );

# Alphabetic      # Lu + Ll + Lt + Lm + Lo + OtherAlphabetic


#?pugs todo
ok("\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<:Alphabetic>$/, q{Match (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<:!Alphabetic>$/ ), q{Don't match negated (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<-:Alphabetic>$/ ), q{Don't match inverted (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok(!( "\x[297C]"  ~~ m/^<:Alphabetic>$/ ), q{Don't match unrelated (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
#?pugs todo
ok("\x[297C]"  ~~ m/^<:!Alphabetic>$/, q{Match unrelated negated (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
#?pugs todo
ok("\x[297C]"  ~~ m/^<-:Alphabetic>$/, q{Match unrelated inverted (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
#?pugs todo
ok("\x[297C]\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/<:Alphabetic>/, q{Match unanchored (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );

# Lowercase       # Ll + OtherLowercase


#?pugs todo
ok("\c[LATIN SMALL LETTER A]" ~~ m/^<:Lowercase>$/, q{Match (Ll + OtherLowercase)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<:!Lowercase>$/ ), q{Don't match negated (Ll + OtherLowercase)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<-:Lowercase>$/ ), q{Don't match inverted (Ll + OtherLowercase)} );
ok(!( "\x[6220]"  ~~ m/^<:Lowercase>$/ ), q{Don't match unrelated (Ll + OtherLowercase)} );
#?pugs todo
ok("\x[6220]"  ~~ m/^<:!Lowercase>$/, q{Match unrelated negated (Ll + OtherLowercase)} );
#?pugs todo
ok("\x[6220]"  ~~ m/^<-:Lowercase>$/, q{Match unrelated inverted (Ll + OtherLowercase)} );
ok(!( "\x[6220]" ~~ m/^<:Lowercase>$/ ), q{Don't match related (Ll + OtherLowercase)} );
#?pugs todo
ok("\x[6220]" ~~ m/^<:!Lowercase>$/, q{Match related negated (Ll + OtherLowercase)} );
#?pugs todo
ok("\x[6220]" ~~ m/^<-:Lowercase>$/, q{Match related inverted (Ll + OtherLowercase)} );
#?pugs todo
ok("\x[6220]\x[6220]\c[LATIN SMALL LETTER A]" ~~ m/<:Lowercase>/, q{Match unanchored (Ll + OtherLowercase)} );

# Uppercase       # Lu + OtherUppercase


#?pugs todo
ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<:Uppercase>$/, q{Match (Lu + OtherUppercase)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<:!Uppercase>$/ ), q{Don't match negated (Lu + OtherUppercase)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-:Uppercase>$/ ), q{Don't match inverted (Lu + OtherUppercase)} );
ok(!( "\x[C080]"  ~~ m/^<:Uppercase>$/ ), q{Don't match unrelated (Lu + OtherUppercase)} );
#?pugs todo
ok("\x[C080]"  ~~ m/^<:!Uppercase>$/, q{Match unrelated negated (Lu + OtherUppercase)} );
#?pugs todo
ok("\x[C080]"  ~~ m/^<-:Uppercase>$/, q{Match unrelated inverted (Lu + OtherUppercase)} );
#?pugs todo
ok("\x[C080]\c[LATIN CAPITAL LETTER A]" ~~ m/<:Uppercase>/, q{Match unanchored (Lu + OtherUppercase)} );

# Math            # Sm + OtherMath


#?pugs todo
ok("\c[PLUS SIGN]" ~~ m/^<:Math>$/, q{Match (Sm + OtherMath)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<:!Math>$/ ), q{Don't match negated (Sm + OtherMath)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<-:Math>$/ ), q{Don't match inverted (Sm + OtherMath)} );
ok(!( "\x[D4D2]"  ~~ m/^<:Math>$/ ), q{Don't match unrelated (Sm + OtherMath)} );
#?pugs todo
ok("\x[D4D2]"  ~~ m/^<:!Math>$/, q{Match unrelated negated (Sm + OtherMath)} );
#?pugs todo
ok("\x[D4D2]"  ~~ m/^<-:Math>$/, q{Match unrelated inverted (Sm + OtherMath)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Math>$/ ), q{Don't match related (Sm + OtherMath)} );
#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!Math>$/, q{Match related negated (Sm + OtherMath)} );
#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Math>$/, q{Match related inverted (Sm + OtherMath)} );
#?pugs todo
ok("\x[D4D2]\c[COMBINING GRAVE ACCENT]\c[PLUS SIGN]" ~~ m/<:Math>/, q{Match unanchored (Sm + OtherMath)} );

# ID_Start        # Lu + Ll + Lt + Lm + Lo + Nl


#?pugs todo
ok("\x[C276]" ~~ m/^<:ID_Start>$/, q{Match (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok(!( "\x[C276]" ~~ m/^<:!ID_Start>$/ ), q{Don't match negated (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok(!( "\x[C276]" ~~ m/^<-:ID_Start>$/ ), q{Don't match inverted (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok(!( "\x[D7A4]"  ~~ m/^<:ID_Start>$/ ), q{Don't match unrelated (Lu + Ll + Lt + Lm + Lo + Nl)} );
#?pugs todo
ok("\x[D7A4]"  ~~ m/^<:!ID_Start>$/, q{Match unrelated negated (Lu + Ll + Lt + Lm + Lo + Nl)} );
#?pugs todo
ok("\x[D7A4]"  ~~ m/^<-:ID_Start>$/, q{Match unrelated inverted (Lu + Ll + Lt + Lm + Lo + Nl)} );
#?pugs todo
ok("\x[D7A4]\x[C276]" ~~ m/<:ID_Start>/, q{Match unanchored (Lu + Ll + Lt + Lm + Lo + Nl)} );

# ID_Continue     # ID_Start + Mn + Mc + Nd + Pc


#?pugs todo
ok("\x[949B]" ~~ m/^<:ID_Continue>$/, q{Match (ID_Start + Mn + Mc + Nd + Pc)} );
ok(!( "\x[949B]" ~~ m/^<:!ID_Continue>$/ ), q{Don't match negated (ID_Start + Mn + Mc + Nd + Pc)} );
ok(!( "\x[949B]" ~~ m/^<-:ID_Continue>$/ ), q{Don't match inverted (ID_Start + Mn + Mc + Nd + Pc)} );
#?rakudo.jvm 3 skip 'icu'
#?rakudo.parrot 3 skip 'icu'
#?niecza 3 todo
ok(!( "\x[9FC4]"  ~~ m/^<:ID_Continue>$/ ), q{Don't match unrelated (ID_Start + Mn + Mc + Nd + Pc)} );
#?pugs todo
ok("\x[9FC4]"  ~~ m/^<:!ID_Continue>$/, q{Match unrelated negated (ID_Start + Mn + Mc + Nd + Pc)} );
#?pugs todo
ok("\x[9FC4]"  ~~ m/^<-:ID_Continue>$/, q{Match unrelated inverted (ID_Start + Mn + Mc + Nd + Pc)} );
#?pugs todo
ok("\x[9FC4]\x[949B]" ~~ m/<:ID_Continue>/, q{Match unanchored (ID_Start + Mn + Mc + Nd + Pc)} );

# Any             # Any character

#?rakudo.jvm 4 skip 'isAny not implemented'
#?rakudo.parrot 4 skip 'isAny not implemented'
#?pugs todo
ok("\x[C709]" ~~ m/^<:Any>$/, q{Match (Any character)} );
ok(!( "\x[C709]" ~~ m/^<:!Any>$/ ), q{Don't match negated (Any character)} );
ok(!( "\x[C709]" ~~ m/^<-:Any>$/ ), q{Don't match inverted (Any character)} );
#?pugs todo
ok("\x[C709]" ~~ m/<:Any>/, q{Match unanchored (Any character)} );

# Assigned        # Any non-Cn character (i.e. synonym for \P{Cn})


#?rakudo.jvm 7 skip 'isAssigned not implemented'
#?rakudo.parrot 7 skip 'isAssigned not implemented'
#?pugs todo
ok("\x[C99D]" ~~ m/^<:Assigned>$/, q<Match (Any non-Cn character (i.e. synonym for \P{Cn}))> );
ok(!( "\x[C99D]" ~~ m/^<:!Assigned>$/ ), q<Don't match negated (Any non-Cn character (i.e. synonym for \P{Cn}))> );
ok(!( "\x[C99D]" ~~ m/^<-:Assigned>$/ ), q<Don't match inverted (Any non-Cn character (i.e. synonym for \P{Cn}))> );
ok(!( "\x[D7A4]"  ~~ m/^<:Assigned>$/ ), q<Don't match unrelated (Any non-Cn character (i.e. synonym for \P{Cn}))> );
#?pugs todo
ok("\x[D7A4]"  ~~ m/^<:!Assigned>$/, q<Match unrelated negated (Any non-Cn character (i.e. synonym for \P{Cn}))> );
#?pugs todo
ok("\x[D7A4]"  ~~ m/^<-:Assigned>$/, q<Match unrelated inverted (Any non-Cn character (i.e. synonym for \P{Cn}))> );
#?pugs todo
ok("\x[D7A4]\x[C99D]" ~~ m/<:Assigned>/, q<Match unanchored (Any non-Cn character (i.e. synonym for \P{Cn}))> );

# Unassigned      # Synonym for \p{Cn}


#?rakudo.jvm 7 skip 'isUnassigned not implemented'
#?rakudo.parrot 7 skip 'isUnassigned not implemented'
#?niecza 3 todo
#?pugs todo
ok("\x[27EC]" ~~ m/^<:Unassigned>$/, q<Match (Synonym for \p{Cn})> );
ok(!( "\x[27EC]" ~~ m/^<:!Unassigned>$/ ), q<Don't match negated (Synonym for \p{Cn})> );
ok(!( "\x[27EC]" ~~ m/^<-:Unassigned>$/ ), q<Don't match inverted (Synonym for \p{Cn})> );
ok(!( "\c[RIGHT OUTER JOIN]"  ~~ m/^<:Unassigned>$/ ), q<Don't match unrelated (Synonym for \p{Cn})> );
#?pugs todo
ok("\c[RIGHT OUTER JOIN]"  ~~ m/^<:!Unassigned>$/, q<Match unrelated negated (Synonym for \p{Cn})> );
#?pugs todo
ok("\c[RIGHT OUTER JOIN]"  ~~ m/^<-:Unassigned>$/, q<Match unrelated inverted (Synonym for \p{Cn})> );
#?niecza todo
#?pugs todo
ok("\c[RIGHT OUTER JOIN]\x[27EC]" ~~ m/<:Unassigned>/, q<Match unanchored (Synonym for \p{Cn})> );

# Common          # Codepoint not explicitly assigned to a script


#?rakudo.jvm 10 skip 'isCommon not implemented'
#?rakudo.parrot 10 skip 'isCommon not implemented'
#?niecza 3 todo
#?pugs todo
ok("\x[0C7E]" ~~ m/^<:Common>$/, q{Match (Codepoint not explicitly assigned to a script)} );
ok(!( "\x[0C7E]" ~~ m/^<:!Common>$/ ), q{Don't match negated (Codepoint not explicitly assigned to a script)} );
ok(!( "\x[0C7E]" ~~ m/^<-:Common>$/ ), q{Don't match inverted (Codepoint not explicitly assigned to a script)} );
ok(!( "\c[KANNADA SIGN ANUSVARA]"  ~~ m/^<:Common>$/ ), q{Don't match unrelated (Codepoint not explicitly assigned to a script)} );
#?pugs todo
ok("\c[KANNADA SIGN ANUSVARA]"  ~~ m/^<:!Common>$/, q{Match unrelated negated (Codepoint not explicitly assigned to a script)} );
#?pugs todo
ok("\c[KANNADA SIGN ANUSVARA]"  ~~ m/^<-:Common>$/, q{Match unrelated inverted (Codepoint not explicitly assigned to a script)} );
ok(!( "\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<:Common>$/ ), q{Don't match related (Codepoint not explicitly assigned to a script)} );
#?pugs todo
ok("\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<:!Common>$/, q{Match related negated (Codepoint not explicitly assigned to a script)} );
#?pugs todo
ok("\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<-:Common>$/, q{Match related inverted (Codepoint not explicitly assigned to a script)} );
#?niecza todo
#?pugs todo
ok("\c[KANNADA SIGN ANUSVARA]\c[KHMER VOWEL INHERENT AQ]\x[0C7E]" ~~ m/<:Common>/, q{Match unanchored (Codepoint not explicitly assigned to a script)} );

# TODO: missing properties which are broken up to Perl 5.10 e.g.
# Grapheme_Base
# Grapheme_Extend
# Grapheme_Cluster_Break=CN
# Grapheme_Cluster_Break=Control
# Grapheme_Cluster_Break=CR
# Grapheme_Cluster_Break=EX
# Grapheme_Cluster_Break=Extend
# Grapheme_Cluster_Break=L
# Grapheme_Cluster_Break=LF
# Grapheme_Cluster_Break=LV
# Grapheme_Cluster_Break=LVT
# Grapheme_Cluster_Break=Other
# Grapheme_Cluster_Break=PP
# Grapheme_Cluster_Break=Prepend
# Grapheme_Cluster_Break=SM
# Grapheme_Cluster_Break=SpacingMark
# Grapheme_Cluster_Break=T
# Grapheme_Cluster_Break=V
# Grapheme_Cluster_Break=XX

# vim: ft=perl6
