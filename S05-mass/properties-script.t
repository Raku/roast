use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/properties_slow_to_compile.t.

XXX needs more clarification on the case of the rules, 
ie letter vs. Letter vs isLetter

=end pod

plan 361;

# BidiL       # Left-to-Right

## #?rakudo 35 skip 'Bidi* not recognized'
ok("\c[YI SYLLABLE IT]" ~~ m/^<:BidiL>$/, q{Match (Left-to-Right)} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<:!BidiL>.$/ ), q{Don't match negated (Left-to-Right)} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<-:BidiL>$/ ), q{Don't match inverted (Left-to-Right)} );
ok(!( "\x[05D0]"  ~~ m/^<:BidiL>$/ ), q{Don't match unrelated (Left-to-Right)} );
ok("\x[05D0]"  ~~ m/^<:!BidiL>.$/, q{Match unrelated negated (Left-to-Right)} );
ok("\x[05D0]"  ~~ m/^<-:BidiL>$/, q{Match unrelated inverted (Left-to-Right)} );
ok("\x[05D0]\c[YI SYLLABLE IT]" ~~ m/<:BidiL>/, q{Match unanchored (Left-to-Right)} );

# BidiEN      # European Number


ok("\c[DIGIT ZERO]" ~~ m/^<:BidiEN>$/, q{Match (European Number)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:!BidiEN>.$/ ), q{Don't match negated (European Number)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-:BidiEN>$/ ), q{Don't match inverted (European Number)} );
ok(!( "\x[AFFB]"  ~~ m/^<:BidiEN>$/ ), q{Don't match unrelated (European Number)} );
ok("\x[AFFB]"  ~~ m/^<:!BidiEN>.$/, q{Match unrelated negated (European Number)} );
ok("\x[AFFB]"  ~~ m/^<-:BidiEN>$/, q{Match unrelated inverted (European Number)} );
ok("\x[AFFB]\c[DIGIT ZERO]" ~~ m/<:BidiEN>/, q{Match unanchored (European Number)} );

# BidiES      # European Number Separator


ok("\c[PLUS SIGN]" ~~ m/^<:BidiES>$/, q{Match (European Number Separator)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<:!BidiES>.$/ ), q{Don't match negated (European Number Separator)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<-:BidiES>$/ ), q{Don't match inverted (European Number Separator)} );
ok(!( "\x[7B89]"  ~~ m/^<:BidiES>$/ ), q{Don't match unrelated (European Number Separator)} );
ok("\x[7B89]"  ~~ m/^<:!BidiES>.$/, q{Match unrelated negated (European Number Separator)} );
ok("\x[7B89]"  ~~ m/^<-:BidiES>$/, q{Match unrelated inverted (European Number Separator)} );
ok("\x[7B89]\c[PLUS SIGN]" ~~ m/<:BidiES>/, q{Match unanchored (European Number Separator)} );

# BidiET      # European Number Terminator


ok("\c[NUMBER SIGN]" ~~ m/^<:BidiET>$/, q{Match (European Number Terminator)} );
ok(!( "\c[NUMBER SIGN]" ~~ m/^<:!BidiET>.$/ ), q{Don't match negated (European Number Terminator)} );
ok(!( "\c[NUMBER SIGN]" ~~ m/^<-:BidiET>$/ ), q{Don't match inverted (European Number Terminator)} );
ok(!( "\x[6780]"  ~~ m/^<:BidiET>$/ ), q{Don't match unrelated (European Number Terminator)} );
ok("\x[6780]"  ~~ m/^<:!BidiET>.$/, q{Match unrelated negated (European Number Terminator)} );
ok("\x[6780]"  ~~ m/^<-:BidiET>$/, q{Match unrelated inverted (European Number Terminator)} );
ok("\x[6780]\c[NUMBER SIGN]" ~~ m/<:BidiET>/, q{Match unanchored (European Number Terminator)} );

# BidiWS      # Whitespace


ok("\c[FORM FEED (FF)]" ~~ m/^<:BidiWS>$/, q{Match (Whitespace)} );
ok(!( "\c[FORM FEED (FF)]" ~~ m/^<:!BidiWS>.$/ ), q{Don't match negated (Whitespace)} );
ok(!( "\c[FORM FEED (FF)]" ~~ m/^<-:BidiWS>$/ ), q{Don't match inverted (Whitespace)} );
ok(!( "\x[6CF9]"  ~~ m/^<:BidiWS>$/ ), q{Don't match unrelated (Whitespace)} );
ok("\x[6CF9]"  ~~ m/^<:!BidiWS>.$/, q{Match unrelated negated (Whitespace)} );
ok("\x[6CF9]"  ~~ m/^<-:BidiWS>$/, q{Match unrelated inverted (Whitespace)} );
ok("\x[6CF9]\c[FORM FEED (FF)]" ~~ m/<:BidiWS>/, q{Match unanchored (Whitespace)} );


# Arabic


ok("\c[ARABIC LETTER HAMZA]" ~~ m/^<:Arabic>$/, q{Match <:Arabic>} );
ok(!( "\c[ARABIC LETTER HAMZA]" ~~ m/^<:!Arabic>.$/ ), q{Don't match negated <isArabic>} );
ok(!( "\c[ARABIC LETTER HAMZA]" ~~ m/^<-:Arabic>$/ ), q{Don't match inverted <isArabic>} );
ok(!( "\x[A649]"  ~~ m/^<:Arabic>$/ ), q{Don't match unrelated <isArabic>} );
ok("\x[A649]"  ~~ m/^<:!Arabic>.$/, q{Match unrelated negated <isArabic>} );
ok("\x[A649]"  ~~ m/^<-:Arabic>$/, q{Match unrelated inverted <isArabic>} );
ok("\x[A649]\c[ARABIC LETTER HAMZA]" ~~ m/<:Arabic>/, q{Match unanchored <isArabic>} );

# Armenian


ok("\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/^<:Armenian>$/, q{Match <:Armenian>} );
ok(!( "\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/^<:!Armenian>.$/ ), q{Don't match negated <isArmenian>} );
ok(!( "\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/^<-:Armenian>$/ ), q{Don't match inverted <isArmenian>} );
ok(!( "\x[CBFF]"  ~~ m/^<:Armenian>$/ ), q{Don't match unrelated <isArmenian>} );
ok("\x[CBFF]"  ~~ m/^<:!Armenian>.$/, q{Match unrelated negated <isArmenian>} );
ok("\x[CBFF]"  ~~ m/^<-:Armenian>$/, q{Match unrelated inverted <isArmenian>} );
ok("\x[CBFF]\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/<:Armenian>/, q{Match unanchored <isArmenian>} );

# Bengali


ok("\c[BENGALI SIGN CANDRABINDU]" ~~ m/^<:Bengali>$/, q{Match <:Bengali>} );
ok(!( "\c[BENGALI SIGN CANDRABINDU]" ~~ m/^<:!Bengali>.$/ ), q{Don't match negated <isBengali>} );
ok(!( "\c[BENGALI SIGN CANDRABINDU]" ~~ m/^<-:Bengali>$/ ), q{Don't match inverted <isBengali>} );
ok(!( "\x[D1E8]"  ~~ m/^<:Bengali>$/ ), q{Don't match unrelated <isBengali>} );
ok("\x[D1E8]"  ~~ m/^<:!Bengali>.$/, q{Match unrelated negated <isBengali>} );
ok("\x[D1E8]"  ~~ m/^<-:Bengali>$/, q{Match unrelated inverted <isBengali>} );
ok("\x[D1E8]\c[BENGALI SIGN CANDRABINDU]" ~~ m/<:Bengali>/, q{Match unanchored <isBengali>} );

# Bopomofo


ok("\c[BOPOMOFO LETTER B]" ~~ m/^<:Bopomofo>$/, q{Match <:Bopomofo>} );
ok(!( "\c[BOPOMOFO LETTER B]" ~~ m/^<:!Bopomofo>.$/ ), q{Don't match negated <isBopomofo>} );
ok(!( "\c[BOPOMOFO LETTER B]" ~~ m/^<-:Bopomofo>$/ ), q{Don't match inverted <isBopomofo>} );
ok(!( "\x[B093]"  ~~ m/^<:Bopomofo>$/ ), q{Don't match unrelated <isBopomofo>} );
ok("\x[B093]"  ~~ m/^<:!Bopomofo>.$/, q{Match unrelated negated <isBopomofo>} );
ok("\x[B093]"  ~~ m/^<-:Bopomofo>$/, q{Match unrelated inverted <isBopomofo>} );
ok("\x[B093]\c[BOPOMOFO LETTER B]" ~~ m/<:Bopomofo>/, q{Match unanchored <isBopomofo>} );

# Buhid


ok("\c[BUHID LETTER A]" ~~ m/^<:Buhid>$/, q{Match <:Buhid>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<:!Buhid>.$/ ), q{Don't match negated <isBuhid>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<-:Buhid>$/ ), q{Don't match inverted <isBuhid>} );
ok(!( "\x[C682]"  ~~ m/^<:Buhid>$/ ), q{Don't match unrelated <isBuhid>} );
ok("\x[C682]"  ~~ m/^<:!Buhid>.$/, q{Match unrelated negated <isBuhid>} );
ok("\x[C682]"  ~~ m/^<-:Buhid>$/, q{Match unrelated inverted <isBuhid>} );
ok("\x[C682]\c[BUHID LETTER A]" ~~ m/<:Buhid>/, q{Match unanchored <isBuhid>} );

# CanadianAboriginal


ok("\c[CANADIAN SYLLABICS E]" ~~ m/^<:CanadianAboriginal>$/, q{Match <:CanadianAboriginal>} );
ok(!( "\c[CANADIAN SYLLABICS E]" ~~ m/^<:!CanadianAboriginal>.$/ ), q{Don't match negated <isCanadianAboriginal>} );
ok(!( "\c[CANADIAN SYLLABICS E]" ~~ m/^<-:CanadianAboriginal>$/ ), q{Don't match inverted <isCanadianAboriginal>} );
ok(!( "\x[888B]"  ~~ m/^<:CanadianAboriginal>$/ ), q{Don't match unrelated <isCanadianAboriginal>} );
ok("\x[888B]"  ~~ m/^<:!CanadianAboriginal>.$/, q{Match unrelated negated <isCanadianAboriginal>} );
ok("\x[888B]"  ~~ m/^<-:CanadianAboriginal>$/, q{Match unrelated inverted <isCanadianAboriginal>} );
ok(!( "\x[9FA6]" ~~ m/^<:CanadianAboriginal>$/ ), q{Don't match related <isCanadianAboriginal>} );
ok("\x[9FA6]" ~~ m/^<:!CanadianAboriginal>.$/, q{Match related negated <isCanadianAboriginal>} );
ok("\x[9FA6]" ~~ m/^<-:CanadianAboriginal>$/, q{Match related inverted <isCanadianAboriginal>} );
ok("\x[888B]\x[9FA6]\c[CANADIAN SYLLABICS E]" ~~ m/<:CanadianAboriginal>/, q{Match unanchored <isCanadianAboriginal>} );

# Cherokee


ok("\c[CHEROKEE LETTER A]" ~~ m/^<:Cherokee>$/, q{Match <:Cherokee>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<:!Cherokee>.$/ ), q{Don't match negated <isCherokee>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<-:Cherokee>$/ ), q{Don't match inverted <isCherokee>} );
ok(!( "\x[8260]"  ~~ m/^<:Cherokee>$/ ), q{Don't match unrelated <isCherokee>} );
ok("\x[8260]"  ~~ m/^<:!Cherokee>.$/, q{Match unrelated negated <isCherokee>} );
ok("\x[8260]"  ~~ m/^<-:Cherokee>$/, q{Match unrelated inverted <isCherokee>} );
ok(!( "\x[9FA6]" ~~ m/^<:Cherokee>$/ ), q{Don't match related <isCherokee>} );
ok("\x[9FA6]" ~~ m/^<:!Cherokee>.$/, q{Match related negated <isCherokee>} );
ok("\x[9FA6]" ~~ m/^<-:Cherokee>$/, q{Match related inverted <isCherokee>} );
ok("\x[8260]\x[9FA6]\c[CHEROKEE LETTER A]" ~~ m/<:Cherokee>/, q{Match unanchored <isCherokee>} );

# Cyrillic


ok("\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<:Cyrillic>$/, q{Match <:Cyrillic>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<:!Cyrillic>.$/ ), q{Don't match negated <isCyrillic>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<-:Cyrillic>$/ ), q{Don't match inverted <isCyrillic>} );
ok(!( "\x[B7DF]"  ~~ m/^<:Cyrillic>$/ ), q{Don't match unrelated <isCyrillic>} );
ok("\x[B7DF]"  ~~ m/^<:!Cyrillic>.$/, q{Match unrelated negated <isCyrillic>} );
ok("\x[B7DF]"  ~~ m/^<-:Cyrillic>$/, q{Match unrelated inverted <isCyrillic>} );
ok(!( "\x[D7A4]" ~~ m/^<:Cyrillic>$/ ), q{Don't match related <isCyrillic>} );
ok("\x[D7A4]" ~~ m/^<:!Cyrillic>.$/, q{Match related negated <isCyrillic>} );
ok("\x[D7A4]" ~~ m/^<-:Cyrillic>$/, q{Match related inverted <isCyrillic>} );
ok("\x[B7DF]\x[D7A4]\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/<:Cyrillic>/, q{Match unanchored <isCyrillic>} );

# Deseret


ok(!( "\x[A8A0]"  ~~ m/^<:Deseret>$/ ), q{Don't match unrelated <isDeseret>} );
ok("\x[A8A0]"  ~~ m/^<:!Deseret>.$/, q{Match unrelated negated <isDeseret>} );
ok("\x[A8A0]"  ~~ m/^<-:Deseret>$/, q{Match unrelated inverted <isDeseret>} );

# Devanagari


ok("\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<:Devanagari>$/, q{Match <:Devanagari>} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<:!Devanagari>.$/ ), q{Don't match negated <isDevanagari>} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<-:Devanagari>$/ ), q{Don't match inverted <isDevanagari>} );
ok(!( "\x[D291]"  ~~ m/^<:Devanagari>$/ ), q{Don't match unrelated <isDevanagari>} );
ok("\x[D291]"  ~~ m/^<:!Devanagari>.$/, q{Match unrelated negated <isDevanagari>} );
ok("\x[D291]"  ~~ m/^<-:Devanagari>$/, q{Match unrelated inverted <isDevanagari>} );
ok("\x[D291]\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/<:Devanagari>/, q{Match unanchored <isDevanagari>} );

# Ethiopic


ok("\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<:Ethiopic>$/, q{Match <:Ethiopic>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<:!Ethiopic>.$/ ), q{Don't match negated <isEthiopic>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<-:Ethiopic>$/ ), q{Don't match inverted <isEthiopic>} );
ok(!( "\x[A9FA]"  ~~ m/^<:Ethiopic>$/ ), q{Don't match unrelated <isEthiopic>} );
ok("\x[A9FA]"  ~~ m/^<:!Ethiopic>.$/, q{Match unrelated negated <isEthiopic>} );
ok("\x[A9FA]"  ~~ m/^<-:Ethiopic>$/, q{Match unrelated inverted <isEthiopic>} );
ok("\x[A9FA]\c[ETHIOPIC SYLLABLE HA]" ~~ m/<:Ethiopic>/, q{Match unanchored <isEthiopic>} );

# Georgian


ok("\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<:Georgian>$/, q{Match <:Georgian>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<:!Georgian>.$/ ), q{Don't match negated <isGeorgian>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<-:Georgian>$/ ), q{Don't match inverted <isGeorgian>} );
ok(!( "\x[BBC9]"  ~~ m/^<:Georgian>$/ ), q{Don't match unrelated <isGeorgian>} );
ok("\x[BBC9]"  ~~ m/^<:!Georgian>.$/, q{Match unrelated negated <isGeorgian>} );
ok("\x[BBC9]"  ~~ m/^<-:Georgian>$/, q{Match unrelated inverted <isGeorgian>} );
ok("\x[BBC9]\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/<:Georgian>/, q{Match unanchored <isGeorgian>} );

# Gothic


ok(!( "\x[5888]"  ~~ m/^<:Gothic>$/ ), q{Don't match unrelated <isGothic>} );
ok("\x[5888]"  ~~ m/^<:!Gothic>.$/, q{Match unrelated negated <isGothic>} );
ok("\x[5888]"  ~~ m/^<-:Gothic>$/, q{Match unrelated inverted <isGothic>} );

# Greek


ok("\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/^<:Greek>$/, q{Match <:Greek>} );
ok(!( "\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/^<:!Greek>.$/ ), q{Don't match negated <isGreek>} );
ok(!( "\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/^<-:Greek>$/ ), q{Don't match inverted <isGreek>} );
ok(!( "\c[ETHIOPIC SYLLABLE KEE]"  ~~ m/^<:Greek>$/ ), q{Don't match unrelated <isGreek>} );
ok("\c[ETHIOPIC SYLLABLE KEE]"  ~~ m/^<:!Greek>.$/, q{Match unrelated negated <isGreek>} );
ok("\c[ETHIOPIC SYLLABLE KEE]"  ~~ m/^<-:Greek>$/, q{Match unrelated inverted <isGreek>} );
ok("\c[ETHIOPIC SYLLABLE KEE]\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/<:Greek>/, q{Match unanchored <isGreek>} );

# Gujarati


ok("\c[GUJARATI SIGN CANDRABINDU]" ~~ m/^<:Gujarati>$/, q{Match <:Gujarati>} );
ok(!( "\c[GUJARATI SIGN CANDRABINDU]" ~~ m/^<:!Gujarati>.$/ ), q{Don't match negated <isGujarati>} );
ok(!( "\c[GUJARATI SIGN CANDRABINDU]" ~~ m/^<-:Gujarati>$/ ), q{Don't match inverted <isGujarati>} );
ok(!( "\x[D108]"  ~~ m/^<:Gujarati>$/ ), q{Don't match unrelated <isGujarati>} );
ok("\x[D108]"  ~~ m/^<:!Gujarati>.$/, q{Match unrelated negated <isGujarati>} );
ok("\x[D108]"  ~~ m/^<-:Gujarati>$/, q{Match unrelated inverted <isGujarati>} );
ok("\x[D108]\c[GUJARATI SIGN CANDRABINDU]" ~~ m/<:Gujarati>/, q{Match unanchored <isGujarati>} );

# Gurmukhi


ok("\c[GURMUKHI SIGN BINDI]" ~~ m/^<:Gurmukhi>$/, q{Match <:Gurmukhi>} );
ok(!( "\c[GURMUKHI SIGN BINDI]" ~~ m/^<:!Gurmukhi>.$/ ), q{Don't match negated <isGurmukhi>} );
ok(!( "\c[GURMUKHI SIGN BINDI]" ~~ m/^<-:Gurmukhi>$/ ), q{Don't match inverted <isGurmukhi>} );
ok(!( "\x[5E05]"  ~~ m/^<:Gurmukhi>$/ ), q{Don't match unrelated <isGurmukhi>} );
ok("\x[5E05]"  ~~ m/^<:!Gurmukhi>.$/, q{Match unrelated negated <isGurmukhi>} );
ok("\x[5E05]"  ~~ m/^<-:Gurmukhi>$/, q{Match unrelated inverted <isGurmukhi>} );
ok("\x[5E05]\c[GURMUKHI SIGN BINDI]" ~~ m/<:Gurmukhi>/, q{Match unanchored <isGurmukhi>} );

# Han


ok("\c[CJK RADICAL REPEAT]" ~~ m/^<:Han>$/, q{Match <:Han>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<:!Han>.$/ ), q{Don't match negated <isHan>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<-:Han>$/ ), q{Don't match inverted <isHan>} );
ok(!( "\c[CANADIAN SYLLABICS KAA]"  ~~ m/^<:Han>$/ ), q{Don't match unrelated <isHan>} );
ok("\c[CANADIAN SYLLABICS KAA]"  ~~ m/^<:!Han>.$/, q{Match unrelated negated <isHan>} );
ok("\c[CANADIAN SYLLABICS KAA]"  ~~ m/^<-:Han>$/, q{Match unrelated inverted <isHan>} );
ok("\c[CANADIAN SYLLABICS KAA]\c[CJK RADICAL REPEAT]" ~~ m/<:Han>/, q{Match unanchored <isHan>} );

# Hangul


ok("\x[AC00]" ~~ m/^<:Hangul>$/, q{Match <:Hangul>} );
ok(!( "\x[AC00]" ~~ m/^<:!Hangul>.$/ ), q{Don't match negated <isHangul>} );
ok(!( "\x[AC00]" ~~ m/^<-:Hangul>$/ ), q{Don't match inverted <isHangul>} );
ok(!( "\x[9583]"  ~~ m/^<:Hangul>$/ ), q{Don't match unrelated <isHangul>} );
ok("\x[9583]"  ~~ m/^<:!Hangul>.$/, q{Match unrelated negated <isHangul>} );
ok("\x[9583]"  ~~ m/^<-:Hangul>$/, q{Match unrelated inverted <isHangul>} );
ok("\x[9583]\x[AC00]" ~~ m/<:Hangul>/, q{Match unanchored <isHangul>} );

# Hanunoo


ok("\c[HANUNOO LETTER A]" ~~ m/^<:Hanunoo>$/, q{Match <:Hanunoo>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<:!Hanunoo>.$/ ), q{Don't match negated <isHanunoo>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<-:Hanunoo>$/ ), q{Don't match inverted <isHanunoo>} );
ok(!( "\x[7625]"  ~~ m/^<:Hanunoo>$/ ), q{Don't match unrelated <isHanunoo>} );
ok("\x[7625]"  ~~ m/^<:!Hanunoo>.$/, q{Match unrelated negated <isHanunoo>} );
ok("\x[7625]"  ~~ m/^<-:Hanunoo>$/, q{Match unrelated inverted <isHanunoo>} );
ok("\x[7625]\c[HANUNOO LETTER A]" ~~ m/<:Hanunoo>/, q{Match unanchored <isHanunoo>} );

# Hebrew


ok("\c[HEBREW LETTER ALEF]" ~~ m/^<:Hebrew>$/, q{Match <:Hebrew>} );
ok(!( "\c[HEBREW LETTER ALEF]" ~~ m/^<:!Hebrew>.$/ ), q{Don't match negated <isHebrew>} );
ok(!( "\c[HEBREW LETTER ALEF]" ~~ m/^<-:Hebrew>$/ ), q{Don't match inverted <isHebrew>} );
ok(!( "\c[YI SYLLABLE SSIT]"  ~~ m/^<:Hebrew>$/ ), q{Don't match unrelated <isHebrew>} );
ok("\c[YI SYLLABLE SSIT]"  ~~ m/^<:!Hebrew>.$/, q{Match unrelated negated <isHebrew>} );
ok("\c[YI SYLLABLE SSIT]"  ~~ m/^<-:Hebrew>$/, q{Match unrelated inverted <isHebrew>} );
ok("\c[YI SYLLABLE SSIT]\c[HEBREW LETTER ALEF]" ~~ m/<:Hebrew>/, q{Match unanchored <isHebrew>} );

# Hiragana


ok("\c[HIRAGANA LETTER SMALL A]" ~~ m/^<:Hiragana>$/, q{Match <:Hiragana>} );
ok(!( "\c[HIRAGANA LETTER SMALL A]" ~~ m/^<:!Hiragana>.$/ ), q{Don't match negated <isHiragana>} );
ok(!( "\c[HIRAGANA LETTER SMALL A]" ~~ m/^<-:Hiragana>$/ ), q{Don't match inverted <isHiragana>} );
ok(!( "\c[CANADIAN SYLLABICS Y]"  ~~ m/^<:Hiragana>$/ ), q{Don't match unrelated <isHiragana>} );
ok("\c[CANADIAN SYLLABICS Y]"  ~~ m/^<:!Hiragana>.$/, q{Match unrelated negated <isHiragana>} );
ok("\c[CANADIAN SYLLABICS Y]"  ~~ m/^<-:Hiragana>$/, q{Match unrelated inverted <isHiragana>} );
ok("\c[CANADIAN SYLLABICS Y]\c[HIRAGANA LETTER SMALL A]" ~~ m/<:Hiragana>/, q{Match unanchored <isHiragana>} );

# Inherited


ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Inherited>$/, q{Match <:Inherited>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!Inherited>.$/ ), q{Don't match negated <isInherited>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Inherited>$/ ), q{Don't match inverted <isInherited>} );
ok(!( "\x[75FA]"  ~~ m/^<:Inherited>$/ ), q{Don't match unrelated <isInherited>} );
ok("\x[75FA]"  ~~ m/^<:!Inherited>.$/, q{Match unrelated negated <isInherited>} );
ok("\x[75FA]"  ~~ m/^<-:Inherited>$/, q{Match unrelated inverted <isInherited>} );
ok("\x[75FA]\c[COMBINING GRAVE ACCENT]" ~~ m/<:Inherited>/, q{Match unanchored <isInherited>} );

# Kannada


ok("\c[KANNADA SIGN ANUSVARA]" ~~ m/^<:Kannada>$/, q{Match <:Kannada>} );
ok(!( "\c[KANNADA SIGN ANUSVARA]" ~~ m/^<:!Kannada>.$/ ), q{Don't match negated <isKannada>} );
ok(!( "\c[KANNADA SIGN ANUSVARA]" ~~ m/^<-:Kannada>$/ ), q{Don't match inverted <isKannada>} );
ok(!( "\x[C1DF]"  ~~ m/^<:Kannada>$/ ), q{Don't match unrelated <isKannada>} );
ok("\x[C1DF]"  ~~ m/^<:!Kannada>.$/, q{Match unrelated negated <isKannada>} );
ok("\x[C1DF]"  ~~ m/^<-:Kannada>$/, q{Match unrelated inverted <isKannada>} );
ok("\x[C1DF]\c[KANNADA SIGN ANUSVARA]" ~~ m/<:Kannada>/, q{Match unanchored <isKannada>} );

# Katakana


ok("\c[KATAKANA LETTER SMALL A]" ~~ m/^<:Katakana>$/, q{Match <:Katakana>} );
ok(!( "\c[KATAKANA LETTER SMALL A]" ~~ m/^<:!Katakana>.$/ ), q{Don't match negated <isKatakana>} );
ok(!( "\c[KATAKANA LETTER SMALL A]" ~~ m/^<-:Katakana>$/ ), q{Don't match inverted <isKatakana>} );
ok(!( "\x[177A]"  ~~ m/^<:Katakana>$/ ), q{Don't match unrelated <isKatakana>} );
ok("\x[177A]"  ~~ m/^<:!Katakana>.$/, q{Match unrelated negated <isKatakana>} );
ok("\x[177A]"  ~~ m/^<-:Katakana>$/, q{Match unrelated inverted <isKatakana>} );
ok("\x[177A]\c[KATAKANA LETTER SMALL A]" ~~ m/<:Katakana>/, q{Match unanchored <isKatakana>} );

# Khmer


ok("\c[KHMER LETTER KA]" ~~ m/^<:Khmer>$/, q{Match <:Khmer>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<:!Khmer>.$/ ), q{Don't match negated <isKhmer>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<-:Khmer>$/ ), q{Don't match inverted <isKhmer>} );
ok(!( "\c[GEORGIAN LETTER QAR]"  ~~ m/^<:Khmer>$/ ), q{Don't match unrelated <isKhmer>} );
ok("\c[GEORGIAN LETTER QAR]"  ~~ m/^<:!Khmer>.$/, q{Match unrelated negated <isKhmer>} );
ok("\c[GEORGIAN LETTER QAR]"  ~~ m/^<-:Khmer>$/, q{Match unrelated inverted <isKhmer>} );
ok("\c[GEORGIAN LETTER QAR]\c[KHMER LETTER KA]" ~~ m/<:Khmer>/, q{Match unanchored <isKhmer>} );

# Lao


ok("\c[LAO LETTER KO]" ~~ m/^<:Lao>$/, q{Match <:Lao>} );
ok(!( "\c[LAO LETTER KO]" ~~ m/^<:!Lao>.$/ ), q{Don't match negated <isLao>} );
ok(!( "\c[LAO LETTER KO]" ~~ m/^<-:Lao>$/ ), q{Don't match inverted <isLao>} );
ok(!( "\x[3DA9]"  ~~ m/^<:Lao>$/ ), q{Don't match unrelated <isLao>} );
ok("\x[3DA9]"  ~~ m/^<:!Lao>.$/, q{Match unrelated negated <isLao>} );
ok("\x[3DA9]"  ~~ m/^<-:Lao>$/, q{Match unrelated inverted <isLao>} );
ok(!( "\x[3DA9]" ~~ m/^<:Lao>$/ ), q{Don't match related <isLao>} );
ok("\x[3DA9]" ~~ m/^<:!Lao>.$/, q{Match related negated <isLao>} );
ok("\x[3DA9]" ~~ m/^<-:Lao>$/, q{Match related inverted <isLao>} );
ok("\x[3DA9]\x[3DA9]\c[LAO LETTER KO]" ~~ m/<:Lao>/, q{Match unanchored <isLao>} );

# Latin


ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<:Latin>$/, q{Match <:Latin>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<:!Latin>.$/ ), q{Don't match negated <isLatin>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-:Latin>$/ ), q{Don't match inverted <isLatin>} );
ok(!( "\x[C549]"  ~~ m/^<:Latin>$/ ), q{Don't match unrelated <isLatin>} );
ok("\x[C549]"  ~~ m/^<:!Latin>.$/, q{Match unrelated negated <isLatin>} );
ok("\x[C549]"  ~~ m/^<-:Latin>$/, q{Match unrelated inverted <isLatin>} );
ok(!( "\x[C549]" ~~ m/^<:Latin>$/ ), q{Don't match related <isLatin>} );
ok("\x[C549]" ~~ m/^<:!Latin>.$/, q{Match related negated <isLatin>} );
ok("\x[C549]" ~~ m/^<-:Latin>$/, q{Match related inverted <isLatin>} );
ok("\x[C549]\x[C549]\c[LATIN CAPITAL LETTER A]" ~~ m/<:Latin>/, q{Match unanchored <isLatin>} );

# Malayalam


ok("\c[MALAYALAM SIGN ANUSVARA]" ~~ m/^<:Malayalam>$/, q{Match <:Malayalam>} );
ok(!( "\c[MALAYALAM SIGN ANUSVARA]" ~~ m/^<:!Malayalam>.$/ ), q{Don't match negated <isMalayalam>} );
ok(!( "\c[MALAYALAM SIGN ANUSVARA]" ~~ m/^<-:Malayalam>$/ ), q{Don't match inverted <isMalayalam>} );
ok(!( "\x[625C]"  ~~ m/^<:Malayalam>$/ ), q{Don't match unrelated <isMalayalam>} );
ok("\x[625C]"  ~~ m/^<:!Malayalam>.$/, q{Match unrelated negated <isMalayalam>} );
ok("\x[625C]"  ~~ m/^<-:Malayalam>$/, q{Match unrelated inverted <isMalayalam>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Malayalam>$/ ), q{Don't match related <isMalayalam>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!Malayalam>.$/, q{Match related negated <isMalayalam>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Malayalam>$/, q{Match related inverted <isMalayalam>} );
ok("\x[625C]\c[COMBINING GRAVE ACCENT]\c[MALAYALAM SIGN ANUSVARA]" ~~ m/<:Malayalam>/, q{Match unanchored <isMalayalam>} );

# Mongolian


ok("\c[MONGOLIAN DIGIT ZERO]" ~~ m/^<:Mongolian>$/, q{Match <:Mongolian>} );
ok(!( "\c[MONGOLIAN DIGIT ZERO]" ~~ m/^<:!Mongolian>.$/ ), q{Don't match negated <isMongolian>} );
ok(!( "\c[MONGOLIAN DIGIT ZERO]" ~~ m/^<-:Mongolian>$/ ), q{Don't match inverted <isMongolian>} );
ok(!( "\x[5F93]"  ~~ m/^<:Mongolian>$/ ), q{Don't match unrelated <isMongolian>} );
ok("\x[5F93]"  ~~ m/^<:!Mongolian>.$/, q{Match unrelated negated <isMongolian>} );
ok("\x[5F93]"  ~~ m/^<-:Mongolian>$/, q{Match unrelated inverted <isMongolian>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Mongolian>$/ ), q{Don't match related <isMongolian>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!Mongolian>.$/, q{Match related negated <isMongolian>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Mongolian>$/, q{Match related inverted <isMongolian>} );
ok("\x[5F93]\c[COMBINING GRAVE ACCENT]\c[MONGOLIAN DIGIT ZERO]" ~~ m/<:Mongolian>/, q{Match unanchored <isMongolian>} );

# Myanmar


ok("\c[MYANMAR LETTER KA]" ~~ m/^<:Myanmar>$/, q{Match <:Myanmar>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<:!Myanmar>.$/ ), q{Don't match negated <isMyanmar>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<-:Myanmar>$/ ), q{Don't match inverted <isMyanmar>} );
ok(!( "\x[649A]"  ~~ m/^<:Myanmar>$/ ), q{Don't match unrelated <isMyanmar>} );
ok("\x[649A]"  ~~ m/^<:!Myanmar>.$/, q{Match unrelated negated <isMyanmar>} );
ok("\x[649A]"  ~~ m/^<-:Myanmar>$/, q{Match unrelated inverted <isMyanmar>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Myanmar>$/ ), q{Don't match related <isMyanmar>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!Myanmar>.$/, q{Match related negated <isMyanmar>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Myanmar>$/, q{Match related inverted <isMyanmar>} );
ok("\x[649A]\c[COMBINING GRAVE ACCENT]\c[MYANMAR LETTER KA]" ~~ m/<:Myanmar>/, q{Match unanchored <isMyanmar>} );

# Ogham


ok("\c[OGHAM LETTER BEITH]" ~~ m/^<:Ogham>$/, q{Match <:Ogham>} );
ok(!( "\c[OGHAM LETTER BEITH]" ~~ m/^<:!Ogham>.$/ ), q{Don't match negated <isOgham>} );
ok(!( "\c[OGHAM LETTER BEITH]" ~~ m/^<-:Ogham>$/ ), q{Don't match inverted <isOgham>} );
ok(!( "\c[KATAKANA LETTER KA]"  ~~ m/^<:Ogham>$/ ), q{Don't match unrelated <isOgham>} );
ok("\c[KATAKANA LETTER KA]"  ~~ m/^<:!Ogham>.$/, q{Match unrelated negated <isOgham>} );
ok("\c[KATAKANA LETTER KA]"  ~~ m/^<-:Ogham>$/, q{Match unrelated inverted <isOgham>} );
ok("\c[KATAKANA LETTER KA]\c[OGHAM LETTER BEITH]" ~~ m/<:Ogham>/, q{Match unanchored <isOgham>} );

# OldItalic


ok(!( "\x[8BB7]"  ~~ m/^<:OldItalic>$/ ), q{Don't match unrelated <isOldItalic>} );
ok("\x[8BB7]"  ~~ m/^<:!OldItalic>.$/, q{Match unrelated negated <isOldItalic>} );
ok("\x[8BB7]"  ~~ m/^<-:OldItalic>$/, q{Match unrelated inverted <isOldItalic>} );

# Oriya


ok("\c[ORIYA SIGN CANDRABINDU]" ~~ m/^<:Oriya>$/, q{Match <:Oriya>} );
ok(!( "\c[ORIYA SIGN CANDRABINDU]" ~~ m/^<:!Oriya>.$/ ), q{Don't match negated <isOriya>} );
ok(!( "\c[ORIYA SIGN CANDRABINDU]" ~~ m/^<-:Oriya>$/ ), q{Don't match inverted <isOriya>} );
ok(!( "\x[4292]"  ~~ m/^<:Oriya>$/ ), q{Don't match unrelated <isOriya>} );
ok("\x[4292]"  ~~ m/^<:!Oriya>.$/, q{Match unrelated negated <isOriya>} );
ok("\x[4292]"  ~~ m/^<-:Oriya>$/, q{Match unrelated inverted <isOriya>} );
ok("\x[4292]\c[ORIYA SIGN CANDRABINDU]" ~~ m/<:Oriya>/, q{Match unanchored <isOriya>} );

# Runic


ok("\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<:Runic>$/, q{Match <:Runic>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<:!Runic>.$/ ), q{Don't match negated <isRunic>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<-:Runic>$/ ), q{Don't match inverted <isRunic>} );
ok(!( "\x[9857]"  ~~ m/^<:Runic>$/ ), q{Don't match unrelated <isRunic>} );
ok("\x[9857]"  ~~ m/^<:!Runic>.$/, q{Match unrelated negated <isRunic>} );
ok("\x[9857]"  ~~ m/^<-:Runic>$/, q{Match unrelated inverted <isRunic>} );
ok("\x[9857]\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/<:Runic>/, q{Match unanchored <isRunic>} );

# Sinhala


ok("\c[SINHALA SIGN ANUSVARAYA]" ~~ m/^<:Sinhala>$/, q{Match <:Sinhala>} );
ok(!( "\c[SINHALA SIGN ANUSVARAYA]" ~~ m/^<:!Sinhala>.$/ ), q{Don't match negated <isSinhala>} );
ok(!( "\c[SINHALA SIGN ANUSVARAYA]" ~~ m/^<-:Sinhala>$/ ), q{Don't match inverted <isSinhala>} );
ok(!( "\x[5DF5]"  ~~ m/^<:Sinhala>$/ ), q{Don't match unrelated <isSinhala>} );
ok("\x[5DF5]"  ~~ m/^<:!Sinhala>.$/, q{Match unrelated negated <isSinhala>} );
ok("\x[5DF5]"  ~~ m/^<-:Sinhala>$/, q{Match unrelated inverted <isSinhala>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:Sinhala>$/ ), q{Don't match related <isSinhala>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<:!Sinhala>.$/, q{Match related negated <isSinhala>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<-:Sinhala>$/, q{Match related inverted <isSinhala>} );
ok("\x[5DF5]\c[YI RADICAL QOT]\c[SINHALA SIGN ANUSVARAYA]" ~~ m/<:Sinhala>/, q{Match unanchored <isSinhala>} );

# Syriac


ok("\c[SYRIAC LETTER ALAPH]" ~~ m/^<:Syriac>$/, q{Match <:Syriac>} );
ok(!( "\c[SYRIAC LETTER ALAPH]" ~~ m/^<:!Syriac>.$/ ), q{Don't match negated <isSyriac>} );
ok(!( "\c[SYRIAC LETTER ALAPH]" ~~ m/^<-:Syriac>$/ ), q{Don't match inverted <isSyriac>} );
ok(!( "\x[57F0]"  ~~ m/^<:Syriac>$/ ), q{Don't match unrelated <isSyriac>} );
ok("\x[57F0]"  ~~ m/^<:!Syriac>.$/, q{Match unrelated negated <isSyriac>} );
ok("\x[57F0]"  ~~ m/^<-:Syriac>$/, q{Match unrelated inverted <isSyriac>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:Syriac>$/ ), q{Don't match related <isSyriac>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<:!Syriac>.$/, q{Match related negated <isSyriac>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<-:Syriac>$/, q{Match related inverted <isSyriac>} );
ok("\x[57F0]\c[YI RADICAL QOT]\c[SYRIAC LETTER ALAPH]" ~~ m/<:Syriac>/, q{Match unanchored <isSyriac>} );

# Tagalog


ok("\c[TAGALOG LETTER A]" ~~ m/^<:Tagalog>$/, q{Match <:Tagalog>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<:!Tagalog>.$/ ), q{Don't match negated <isTagalog>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<-:Tagalog>$/ ), q{Don't match inverted <isTagalog>} );
ok(!( "\x[3DE8]"  ~~ m/^<:Tagalog>$/ ), q{Don't match unrelated <isTagalog>} );
ok("\x[3DE8]"  ~~ m/^<:!Tagalog>.$/, q{Match unrelated negated <isTagalog>} );
ok("\x[3DE8]"  ~~ m/^<-:Tagalog>$/, q{Match unrelated inverted <isTagalog>} );
ok("\x[3DE8]\c[TAGALOG LETTER A]" ~~ m/<:Tagalog>/, q{Match unanchored <isTagalog>} );

# Tagbanwa


ok("\c[TAGBANWA LETTER A]" ~~ m/^<:Tagbanwa>$/, q{Match <:Tagbanwa>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<:!Tagbanwa>.$/ ), q{Don't match negated <isTagbanwa>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<-:Tagbanwa>$/ ), q{Don't match inverted <isTagbanwa>} );
ok(!( "\c[CHEROKEE LETTER TLV]"  ~~ m/^<:Tagbanwa>$/ ), q{Don't match unrelated <isTagbanwa>} );
ok("\c[CHEROKEE LETTER TLV]"  ~~ m/^<:!Tagbanwa>.$/, q{Match unrelated negated <isTagbanwa>} );
ok("\c[CHEROKEE LETTER TLV]"  ~~ m/^<-:Tagbanwa>$/, q{Match unrelated inverted <isTagbanwa>} );
ok("\c[CHEROKEE LETTER TLV]\c[TAGBANWA LETTER A]" ~~ m/<:Tagbanwa>/, q{Match unanchored <isTagbanwa>} );

# Tamil


ok("\c[TAMIL SIGN ANUSVARA]" ~~ m/^<:Tamil>$/, q{Match <:Tamil>} );
ok(!( "\c[TAMIL SIGN ANUSVARA]" ~~ m/^<:!Tamil>.$/ ), q{Don't match negated <isTamil>} );
ok(!( "\c[TAMIL SIGN ANUSVARA]" ~~ m/^<-:Tamil>$/ ), q{Don't match inverted <isTamil>} );
ok(!( "\x[8DF2]"  ~~ m/^<:Tamil>$/ ), q{Don't match unrelated <isTamil>} );
ok("\x[8DF2]"  ~~ m/^<:!Tamil>.$/, q{Match unrelated negated <isTamil>} );
ok("\x[8DF2]"  ~~ m/^<-:Tamil>$/, q{Match unrelated inverted <isTamil>} );
ok("\x[8DF2]\c[TAMIL SIGN ANUSVARA]" ~~ m/<:Tamil>/, q{Match unanchored <isTamil>} );

# Telugu


ok("\c[TELUGU SIGN CANDRABINDU]" ~~ m/^<:Telugu>$/, q{Match <:Telugu>} );
ok(!( "\c[TELUGU SIGN CANDRABINDU]" ~~ m/^<:!Telugu>.$/ ), q{Don't match negated <isTelugu>} );
ok(!( "\c[TELUGU SIGN CANDRABINDU]" ~~ m/^<-:Telugu>$/ ), q{Don't match inverted <isTelugu>} );
ok(!( "\x[8088]"  ~~ m/^<:Telugu>$/ ), q{Don't match unrelated <isTelugu>} );
ok("\x[8088]"  ~~ m/^<:!Telugu>.$/, q{Match unrelated negated <isTelugu>} );
ok("\x[8088]"  ~~ m/^<-:Telugu>$/, q{Match unrelated inverted <isTelugu>} );
ok("\x[8088]\c[TELUGU SIGN CANDRABINDU]" ~~ m/<:Telugu>/, q{Match unanchored <isTelugu>} );

# Thaana


ok("\c[THAANA LETTER HAA]" ~~ m/^<:Thaana>$/, q{Match <:Thaana>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<:!Thaana>.$/ ), q{Don't match negated <isThaana>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<-:Thaana>$/ ), q{Don't match inverted <isThaana>} );
ok(!( "\x[5240]"  ~~ m/^<:Thaana>$/ ), q{Don't match unrelated <isThaana>} );
ok("\x[5240]"  ~~ m/^<:!Thaana>.$/, q{Match unrelated negated <isThaana>} );
ok("\x[5240]"  ~~ m/^<-:Thaana>$/, q{Match unrelated inverted <isThaana>} );
ok("\x[5240]\c[THAANA LETTER HAA]" ~~ m/<:Thaana>/, q{Match unanchored <isThaana>} );

# Thai


ok("\c[THAI CHARACTER KO KAI]" ~~ m/^<:Thai>$/, q{Match <:Thai>} );
ok(!( "\c[THAI CHARACTER KO KAI]" ~~ m/^<:!Thai>.$/ ), q{Don't match negated <isThai>} );
ok(!( "\c[THAI CHARACTER KO KAI]" ~~ m/^<-:Thai>$/ ), q{Don't match inverted <isThai>} );
ok(!( "\x[CAD3]"  ~~ m/^<:Thai>$/ ), q{Don't match unrelated <isThai>} );
ok("\x[CAD3]"  ~~ m/^<:!Thai>.$/, q{Match unrelated negated <isThai>} );
ok("\x[CAD3]"  ~~ m/^<-:Thai>$/, q{Match unrelated inverted <isThai>} );
ok("\x[CAD3]\c[THAI CHARACTER KO KAI]" ~~ m/<:Thai>/, q{Match unanchored <isThai>} );

# Tibetan


ok("\c[TIBETAN SYLLABLE OM]" ~~ m/^<:Tibetan>$/, q{Match <:Tibetan>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<:!Tibetan>.$/ ), q{Don't match negated <isTibetan>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<-:Tibetan>$/ ), q{Don't match inverted <isTibetan>} );
ok(!( "\x[8557]"  ~~ m/^<:Tibetan>$/ ), q{Don't match unrelated <isTibetan>} );
ok("\x[8557]"  ~~ m/^<:!Tibetan>.$/, q{Match unrelated negated <isTibetan>} );
ok("\x[8557]"  ~~ m/^<-:Tibetan>$/, q{Match unrelated inverted <isTibetan>} );
ok("\x[8557]\c[TIBETAN SYLLABLE OM]" ~~ m/<:Tibetan>/, q{Match unanchored <isTibetan>} );

# Yi


ok("\c[YI SYLLABLE IT]" ~~ m/^<:Yi>$/, q{Match <:Yi>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<:!Yi>.$/ ), q{Don't match negated <isYi>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<-:Yi>$/ ), q{Don't match inverted <isYi>} );
ok(!( "\x[BCD0]"  ~~ m/^<:Yi>$/ ), q{Don't match unrelated <isYi>} );
ok("\x[BCD0]"  ~~ m/^<:!Yi>.$/, q{Match unrelated negated <isYi>} );
ok("\x[BCD0]"  ~~ m/^<-:Yi>$/, q{Match unrelated inverted <isYi>} );
ok("\x[BCD0]\c[YI SYLLABLE IT]" ~~ m/<:Yi>/, q{Match unanchored <isYi>} );


# vim: ft=perl6
