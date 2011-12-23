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
ok("\c[YI SYLLABLE IT]" ~~ m/^<:bc<L>>$/, q{Match (Left-to-Right)} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<!:bc<L>>.$/ ), q{Don't match negated (Left-to-Right)} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<-:bc<L>>$/ ), q{Don't match inverted (Left-to-Right)} );
ok(!( "\x[05D0]"  ~~ m/^<:bc<L>>$/ ), q{Don't match unrelated (Left-to-Right)} );
ok("\x[05D0]"  ~~ m/^<!:bc<L>>.$/, q{Match unrelated negated (Left-to-Right)} );
ok("\x[05D0]"  ~~ m/^<-:bc<L>>$/, q{Match unrelated inverted (Left-to-Right)} );
ok("\x[05D0]\c[YI SYLLABLE IT]" ~~ m/<:bc<L>>/, q{Match unanchored (Left-to-Right)} );

# bc<EN>      # European Number


ok("\c[DIGIT ZERO]" ~~ m/^<:bc<EN>>$/, q{Match (European Number)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<!:bc<EN>>.$/ ), q{Don't match negated (European Number)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-:bc<EN>>$/ ), q{Don't match inverted (European Number)} );
ok(!( "\x[AFFB]"  ~~ m/^<:bc<EN>>$/ ), q{Don't match unrelated (European Number)} );
ok("\x[AFFB]"  ~~ m/^<!:bc<EN>>.$/, q{Match unrelated negated (European Number)} );
ok("\x[AFFB]"  ~~ m/^<-:bc<EN>>$/, q{Match unrelated inverted (European Number)} );
ok("\x[AFFB]\c[DIGIT ZERO]" ~~ m/<:bc<EN>>/, q{Match unanchored (European Number)} );

# bc<ES>      # European Number Separator


ok("\c[PLUS SIGN]" ~~ m/^<:bc<ES>>$/, q{Match (European Number Separator)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<!:bc<ES>>.$/ ), q{Don't match negated (European Number Separator)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<-:bc<ES>>$/ ), q{Don't match inverted (European Number Separator)} );
ok(!( "\x[7B89]"  ~~ m/^<:bc<ES>>$/ ), q{Don't match unrelated (European Number Separator)} );
ok("\x[7B89]"  ~~ m/^<!:bc<ES>>.$/, q{Match unrelated negated (European Number Separator)} );
ok("\x[7B89]"  ~~ m/^<-:bc<ES>>$/, q{Match unrelated inverted (European Number Separator)} );
ok("\x[7B89]\c[PLUS SIGN]" ~~ m/<:bc<ES>>/, q{Match unanchored (European Number Separator)} );

# bc<ET>      # European Number Terminator


ok("\c[NUMBER SIGN]" ~~ m/^<:bc<ET>>$/, q{Match (European Number Terminator)} );
ok(!( "\c[NUMBER SIGN]" ~~ m/^<!:bc<ET>>.$/ ), q{Don't match negated (European Number Terminator)} );
ok(!( "\c[NUMBER SIGN]" ~~ m/^<-:bc<ET>>$/ ), q{Don't match inverted (European Number Terminator)} );
ok(!( "\x[6780]"  ~~ m/^<:bc<ET>>$/ ), q{Don't match unrelated (European Number Terminator)} );
ok("\x[6780]"  ~~ m/^<!:bc<ET>>.$/, q{Match unrelated negated (European Number Terminator)} );
ok("\x[6780]"  ~~ m/^<-:bc<ET>>$/, q{Match unrelated inverted (European Number Terminator)} );
ok("\x[6780]\c[NUMBER SIGN]" ~~ m/<:bc<ET>>/, q{Match unanchored (European Number Terminator)} );

# bc<WS>      # Whitespace


ok("\c[FORM FEED (FF)]" ~~ m/^<:bc<WS>>$/, q{Match (Whitespace)} );
ok(!( "\c[FORM FEED (FF)]" ~~ m/^<!:bc<WS>>.$/ ), q{Don't match negated (Whitespace)} );
ok(!( "\c[FORM FEED (FF)]" ~~ m/^<-:bc<WS>>$/ ), q{Don't match inverted (Whitespace)} );
ok(!( "\x[6CF9]"  ~~ m/^<:bc<WS>>$/ ), q{Don't match unrelated (Whitespace)} );
ok("\x[6CF9]"  ~~ m/^<!:bc<WS>>.$/, q{Match unrelated negated (Whitespace)} );
ok("\x[6CF9]"  ~~ m/^<-:bc<WS>>$/, q{Match unrelated inverted (Whitespace)} );
ok("\x[6CF9]\c[FORM FEED (FF)]" ~~ m/<:bc<WS>>/, q{Match unanchored (Whitespace)} );


# Arabic


ok("\c[ARABIC LETTER HAMZA]" ~~ m/^<:Arabic>$/, q{Match <:Arabic>} );
ok(!( "\c[ARABIC LETTER HAMZA]" ~~ m/^<!:Arabic>.$/ ), q{Don't match negated <Arabic>} );
ok(!( "\c[ARABIC LETTER HAMZA]" ~~ m/^<-:Arabic>$/ ), q{Don't match inverted <Arabic>} );
ok(!( "\x[A649]"  ~~ m/^<:Arabic>$/ ), q{Don't match unrelated <Arabic>} );
ok("\x[A649]"  ~~ m/^<!:Arabic>.$/, q{Match unrelated negated <Arabic>} );
ok("\x[A649]"  ~~ m/^<-:Arabic>$/, q{Match unrelated inverted <Arabic>} );
ok("\x[A649]\c[ARABIC LETTER HAMZA]" ~~ m/<:Arabic>/, q{Match unanchored <Arabic>} );

# Armenian


ok("\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/^<:Armenian>$/, q{Match <:Armenian>} );
ok(!( "\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/^<!:Armenian>.$/ ), q{Don't match negated <Armenian>} );
ok(!( "\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/^<-:Armenian>$/ ), q{Don't match inverted <Armenian>} );
ok(!( "\x[CBFF]"  ~~ m/^<:Armenian>$/ ), q{Don't match unrelated <Armenian>} );
ok("\x[CBFF]"  ~~ m/^<!:Armenian>.$/, q{Match unrelated negated <Armenian>} );
ok("\x[CBFF]"  ~~ m/^<-:Armenian>$/, q{Match unrelated inverted <Armenian>} );
ok("\x[CBFF]\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/<:Armenian>/, q{Match unanchored <Armenian>} );

# Bengali


ok("\c[BENGALI SIGN CANDRABINDU]" ~~ m/^<:Bengali>$/, q{Match <:Bengali>} );
ok(!( "\c[BENGALI SIGN CANDRABINDU]" ~~ m/^<!:Bengali>.$/ ), q{Don't match negated <Bengali>} );
ok(!( "\c[BENGALI SIGN CANDRABINDU]" ~~ m/^<-:Bengali>$/ ), q{Don't match inverted <Bengali>} );
ok(!( "\x[D1E8]"  ~~ m/^<:Bengali>$/ ), q{Don't match unrelated <Bengali>} );
ok("\x[D1E8]"  ~~ m/^<!:Bengali>.$/, q{Match unrelated negated <Bengali>} );
ok("\x[D1E8]"  ~~ m/^<-:Bengali>$/, q{Match unrelated inverted <Bengali>} );
ok("\x[D1E8]\c[BENGALI SIGN CANDRABINDU]" ~~ m/<:Bengali>/, q{Match unanchored <Bengali>} );

# Bopomofo


ok("\c[BOPOMOFO LETTER B]" ~~ m/^<:Bopomofo>$/, q{Match <:Bopomofo>} );
ok(!( "\c[BOPOMOFO LETTER B]" ~~ m/^<!:Bopomofo>.$/ ), q{Don't match negated <Bopomofo>} );
ok(!( "\c[BOPOMOFO LETTER B]" ~~ m/^<-:Bopomofo>$/ ), q{Don't match inverted <Bopomofo>} );
ok(!( "\x[B093]"  ~~ m/^<:Bopomofo>$/ ), q{Don't match unrelated <Bopomofo>} );
ok("\x[B093]"  ~~ m/^<!:Bopomofo>.$/, q{Match unrelated negated <Bopomofo>} );
ok("\x[B093]"  ~~ m/^<-:Bopomofo>$/, q{Match unrelated inverted <Bopomofo>} );
ok("\x[B093]\c[BOPOMOFO LETTER B]" ~~ m/<:Bopomofo>/, q{Match unanchored <Bopomofo>} );

# Buhid


ok("\c[BUHID LETTER A]" ~~ m/^<:Buhid>$/, q{Match <:Buhid>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<!:Buhid>.$/ ), q{Don't match negated <Buhid>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<-:Buhid>$/ ), q{Don't match inverted <Buhid>} );
ok(!( "\x[C682]"  ~~ m/^<:Buhid>$/ ), q{Don't match unrelated <Buhid>} );
ok("\x[C682]"  ~~ m/^<!:Buhid>.$/, q{Match unrelated negated <Buhid>} );
ok("\x[C682]"  ~~ m/^<-:Buhid>$/, q{Match unrelated inverted <Buhid>} );
ok("\x[C682]\c[BUHID LETTER A]" ~~ m/<:Buhid>/, q{Match unanchored <Buhid>} );

# Canadian_Aboriginal


ok("\c[CANADIAN SYLLABICS E]" ~~ m/^<:Canadian_Aboriginal>$/, q{Match <:Canadian_Aboriginal>} );
ok(!( "\c[CANADIAN SYLLABICS E]" ~~ m/^<!:Canadian_Aboriginal>.$/ ), q{Don't match negated <Canadian_Aboriginal>} );
ok(!( "\c[CANADIAN SYLLABICS E]" ~~ m/^<-:Canadian_Aboriginal>$/ ), q{Don't match inverted <Canadian_Aboriginal>} );
ok(!( "\x[888B]"  ~~ m/^<:Canadian_Aboriginal>$/ ), q{Don't match unrelated <Canadian_Aboriginal>} );
ok("\x[888B]"  ~~ m/^<!:Canadian_Aboriginal>.$/, q{Match unrelated negated <Canadian_Aboriginal>} );
ok("\x[888B]"  ~~ m/^<-:Canadian_Aboriginal>$/, q{Match unrelated inverted <Canadian_Aboriginal>} );
ok(!( "\x[9FA6]" ~~ m/^<:Canadian_Aboriginal>$/ ), q{Don't match related <Canadian_Aboriginal>} );
ok("\x[9FA6]" ~~ m/^<!:Canadian_Aboriginal>.$/, q{Match related negated <Canadian_Aboriginal>} );
ok("\x[9FA6]" ~~ m/^<-:Canadian_Aboriginal>$/, q{Match related inverted <Canadian_Aboriginal>} );
ok("\x[888B]\x[9FA6]\c[CANADIAN SYLLABICS E]" ~~ m/<:Canadian_Aboriginal>/, q{Match unanchored <Canadian_Aboriginal>} );

# Cherokee


ok("\c[CHEROKEE LETTER A]" ~~ m/^<:Cherokee>$/, q{Match <:Cherokee>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<!:Cherokee>.$/ ), q{Don't match negated <Cherokee>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<-:Cherokee>$/ ), q{Don't match inverted <Cherokee>} );
ok(!( "\x[8260]"  ~~ m/^<:Cherokee>$/ ), q{Don't match unrelated <Cherokee>} );
ok("\x[8260]"  ~~ m/^<!:Cherokee>.$/, q{Match unrelated negated <Cherokee>} );
ok("\x[8260]"  ~~ m/^<-:Cherokee>$/, q{Match unrelated inverted <Cherokee>} );
ok(!( "\x[9FA6]" ~~ m/^<:Cherokee>$/ ), q{Don't match related <Cherokee>} );
ok("\x[9FA6]" ~~ m/^<!:Cherokee>.$/, q{Match related negated <Cherokee>} );
ok("\x[9FA6]" ~~ m/^<-:Cherokee>$/, q{Match related inverted <Cherokee>} );
ok("\x[8260]\x[9FA6]\c[CHEROKEE LETTER A]" ~~ m/<:Cherokee>/, q{Match unanchored <Cherokee>} );

# Cyrillic


ok("\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<:Cyrillic>$/, q{Match <:Cyrillic>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<!:Cyrillic>.$/ ), q{Don't match negated <Cyrillic>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<-:Cyrillic>$/ ), q{Don't match inverted <Cyrillic>} );
ok(!( "\x[B7DF]"  ~~ m/^<:Cyrillic>$/ ), q{Don't match unrelated <Cyrillic>} );
ok("\x[B7DF]"  ~~ m/^<!:Cyrillic>.$/, q{Match unrelated negated <Cyrillic>} );
ok("\x[B7DF]"  ~~ m/^<-:Cyrillic>$/, q{Match unrelated inverted <Cyrillic>} );
ok(!( "\x[D7A4]" ~~ m/^<:Cyrillic>$/ ), q{Don't match related <Cyrillic>} );
ok("\x[D7A4]" ~~ m/^<!:Cyrillic>.$/, q{Match related negated <Cyrillic>} );
ok("\x[D7A4]" ~~ m/^<-:Cyrillic>$/, q{Match related inverted <Cyrillic>} );
ok("\x[B7DF]\x[D7A4]\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/<:Cyrillic>/, q{Match unanchored <Cyrillic>} );

# Deseret


ok(!( "\x[A8A0]"  ~~ m/^<:Deseret>$/ ), q{Don't match unrelated <Deseret>} );
ok("\x[A8A0]"  ~~ m/^<!:Deseret>.$/, q{Match unrelated negated <Deseret>} );
ok("\x[A8A0]"  ~~ m/^<-:Deseret>$/, q{Match unrelated inverted <Deseret>} );

# Devanagari


ok("\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<:Devanagari>$/, q{Match <:Devanagari>} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<!:Devanagari>.$/ ), q{Don't match negated <Devanagari>} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<-:Devanagari>$/ ), q{Don't match inverted <Devanagari>} );
ok(!( "\x[D291]"  ~~ m/^<:Devanagari>$/ ), q{Don't match unrelated <Devanagari>} );
ok("\x[D291]"  ~~ m/^<!:Devanagari>.$/, q{Match unrelated negated <Devanagari>} );
ok("\x[D291]"  ~~ m/^<-:Devanagari>$/, q{Match unrelated inverted <Devanagari>} );
ok("\x[D291]\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/<:Devanagari>/, q{Match unanchored <Devanagari>} );

# Ethiopic


ok("\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<:Ethiopic>$/, q{Match <:Ethiopic>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<!:Ethiopic>.$/ ), q{Don't match negated <Ethiopic>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<-:Ethiopic>$/ ), q{Don't match inverted <Ethiopic>} );
ok(!( "\x[A9FA]"  ~~ m/^<:Ethiopic>$/ ), q{Don't match unrelated <Ethiopic>} );
ok("\x[A9FA]"  ~~ m/^<!:Ethiopic>.$/, q{Match unrelated negated <Ethiopic>} );
ok("\x[A9FA]"  ~~ m/^<-:Ethiopic>$/, q{Match unrelated inverted <Ethiopic>} );
ok("\x[A9FA]\c[ETHIOPIC SYLLABLE HA]" ~~ m/<:Ethiopic>/, q{Match unanchored <Ethiopic>} );

# Georgian


ok("\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<:Georgian>$/, q{Match <:Georgian>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<!:Georgian>.$/ ), q{Don't match negated <Georgian>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<-:Georgian>$/ ), q{Don't match inverted <Georgian>} );
ok(!( "\x[BBC9]"  ~~ m/^<:Georgian>$/ ), q{Don't match unrelated <Georgian>} );
ok("\x[BBC9]"  ~~ m/^<!:Georgian>.$/, q{Match unrelated negated <Georgian>} );
ok("\x[BBC9]"  ~~ m/^<-:Georgian>$/, q{Match unrelated inverted <Georgian>} );
ok("\x[BBC9]\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/<:Georgian>/, q{Match unanchored <Georgian>} );

# Gothic


ok(!( "\x[5888]"  ~~ m/^<:Gothic>$/ ), q{Don't match unrelated <Gothic>} );
ok("\x[5888]"  ~~ m/^<!:Gothic>.$/, q{Match unrelated negated <Gothic>} );
ok("\x[5888]"  ~~ m/^<-:Gothic>$/, q{Match unrelated inverted <Gothic>} );

# Greek


ok("\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/^<:Greek>$/, q{Match <:Greek>} );
ok(!( "\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/^<!:Greek>.$/ ), q{Don't match negated <Greek>} );
ok(!( "\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/^<-:Greek>$/ ), q{Don't match inverted <Greek>} );
ok(!( "\c[ETHIOPIC SYLLABLE KEE]"  ~~ m/^<:Greek>$/ ), q{Don't match unrelated <Greek>} );
ok("\c[ETHIOPIC SYLLABLE KEE]"  ~~ m/^<!:Greek>.$/, q{Match unrelated negated <Greek>} );
ok("\c[ETHIOPIC SYLLABLE KEE]"  ~~ m/^<-:Greek>$/, q{Match unrelated inverted <Greek>} );
ok("\c[ETHIOPIC SYLLABLE KEE]\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/<:Greek>/, q{Match unanchored <Greek>} );

# Gujarati


ok("\c[GUJARATI SIGN CANDRABINDU]" ~~ m/^<:Gujarati>$/, q{Match <:Gujarati>} );
ok(!( "\c[GUJARATI SIGN CANDRABINDU]" ~~ m/^<!:Gujarati>.$/ ), q{Don't match negated <Gujarati>} );
ok(!( "\c[GUJARATI SIGN CANDRABINDU]" ~~ m/^<-:Gujarati>$/ ), q{Don't match inverted <Gujarati>} );
ok(!( "\x[D108]"  ~~ m/^<:Gujarati>$/ ), q{Don't match unrelated <Gujarati>} );
ok("\x[D108]"  ~~ m/^<!:Gujarati>.$/, q{Match unrelated negated <Gujarati>} );
ok("\x[D108]"  ~~ m/^<-:Gujarati>$/, q{Match unrelated inverted <Gujarati>} );
ok("\x[D108]\c[GUJARATI SIGN CANDRABINDU]" ~~ m/<:Gujarati>/, q{Match unanchored <Gujarati>} );

# Gurmukhi


ok("\c[GURMUKHI SIGN BINDI]" ~~ m/^<:Gurmukhi>$/, q{Match <:Gurmukhi>} );
ok(!( "\c[GURMUKHI SIGN BINDI]" ~~ m/^<!:Gurmukhi>.$/ ), q{Don't match negated <Gurmukhi>} );
ok(!( "\c[GURMUKHI SIGN BINDI]" ~~ m/^<-:Gurmukhi>$/ ), q{Don't match inverted <Gurmukhi>} );
ok(!( "\x[5E05]"  ~~ m/^<:Gurmukhi>$/ ), q{Don't match unrelated <Gurmukhi>} );
ok("\x[5E05]"  ~~ m/^<!:Gurmukhi>.$/, q{Match unrelated negated <Gurmukhi>} );
ok("\x[5E05]"  ~~ m/^<-:Gurmukhi>$/, q{Match unrelated inverted <Gurmukhi>} );
ok("\x[5E05]\c[GURMUKHI SIGN BINDI]" ~~ m/<:Gurmukhi>/, q{Match unanchored <Gurmukhi>} );

# Han


ok("\c[CJK RADICAL REPEAT]" ~~ m/^<:Han>$/, q{Match <:Han>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<!:Han>.$/ ), q{Don't match negated <Han>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<-:Han>$/ ), q{Don't match inverted <Han>} );
ok(!( "\c[CANADIAN SYLLABICS KAA]"  ~~ m/^<:Han>$/ ), q{Don't match unrelated <Han>} );
ok("\c[CANADIAN SYLLABICS KAA]"  ~~ m/^<!:Han>.$/, q{Match unrelated negated <Han>} );
ok("\c[CANADIAN SYLLABICS KAA]"  ~~ m/^<-:Han>$/, q{Match unrelated inverted <Han>} );
ok("\c[CANADIAN SYLLABICS KAA]\c[CJK RADICAL REPEAT]" ~~ m/<:Han>/, q{Match unanchored <Han>} );

# Hangul


ok("\x[AC00]" ~~ m/^<:Hangul>$/, q{Match <:Hangul>} );
ok(!( "\x[AC00]" ~~ m/^<!:Hangul>.$/ ), q{Don't match negated <Hangul>} );
ok(!( "\x[AC00]" ~~ m/^<-:Hangul>$/ ), q{Don't match inverted <Hangul>} );
ok(!( "\x[9583]"  ~~ m/^<:Hangul>$/ ), q{Don't match unrelated <Hangul>} );
ok("\x[9583]"  ~~ m/^<!:Hangul>.$/, q{Match unrelated negated <Hangul>} );
ok("\x[9583]"  ~~ m/^<-:Hangul>$/, q{Match unrelated inverted <Hangul>} );
ok("\x[9583]\x[AC00]" ~~ m/<:Hangul>/, q{Match unanchored <Hangul>} );

# Hanunoo


ok("\c[HANUNOO LETTER A]" ~~ m/^<:Hanunoo>$/, q{Match <:Hanunoo>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<!:Hanunoo>.$/ ), q{Don't match negated <Hanunoo>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<-:Hanunoo>$/ ), q{Don't match inverted <Hanunoo>} );
ok(!( "\x[7625]"  ~~ m/^<:Hanunoo>$/ ), q{Don't match unrelated <Hanunoo>} );
ok("\x[7625]"  ~~ m/^<!:Hanunoo>.$/, q{Match unrelated negated <Hanunoo>} );
ok("\x[7625]"  ~~ m/^<-:Hanunoo>$/, q{Match unrelated inverted <Hanunoo>} );
ok("\x[7625]\c[HANUNOO LETTER A]" ~~ m/<:Hanunoo>/, q{Match unanchored <Hanunoo>} );

# Hebrew


ok("\c[HEBREW LETTER ALEF]" ~~ m/^<:Hebrew>$/, q{Match <:Hebrew>} );
ok(!( "\c[HEBREW LETTER ALEF]" ~~ m/^<!:Hebrew>.$/ ), q{Don't match negated <Hebrew>} );
ok(!( "\c[HEBREW LETTER ALEF]" ~~ m/^<-:Hebrew>$/ ), q{Don't match inverted <Hebrew>} );
ok(!( "\c[YI SYLLABLE SSIT]"  ~~ m/^<:Hebrew>$/ ), q{Don't match unrelated <Hebrew>} );
ok("\c[YI SYLLABLE SSIT]"  ~~ m/^<!:Hebrew>.$/, q{Match unrelated negated <Hebrew>} );
ok("\c[YI SYLLABLE SSIT]"  ~~ m/^<-:Hebrew>$/, q{Match unrelated inverted <Hebrew>} );
ok("\c[YI SYLLABLE SSIT]\c[HEBREW LETTER ALEF]" ~~ m/<:Hebrew>/, q{Match unanchored <Hebrew>} );

# Hiragana


ok("\c[HIRAGANA LETTER SMALL A]" ~~ m/^<:Hiragana>$/, q{Match <:Hiragana>} );
ok(!( "\c[HIRAGANA LETTER SMALL A]" ~~ m/^<!:Hiragana>.$/ ), q{Don't match negated <Hiragana>} );
ok(!( "\c[HIRAGANA LETTER SMALL A]" ~~ m/^<-:Hiragana>$/ ), q{Don't match inverted <Hiragana>} );
ok(!( "\c[CANADIAN SYLLABICS Y]"  ~~ m/^<:Hiragana>$/ ), q{Don't match unrelated <Hiragana>} );
ok("\c[CANADIAN SYLLABICS Y]"  ~~ m/^<!:Hiragana>.$/, q{Match unrelated negated <Hiragana>} );
ok("\c[CANADIAN SYLLABICS Y]"  ~~ m/^<-:Hiragana>$/, q{Match unrelated inverted <Hiragana>} );
ok("\c[CANADIAN SYLLABICS Y]\c[HIRAGANA LETTER SMALL A]" ~~ m/<:Hiragana>/, q{Match unanchored <Hiragana>} );

# Inherited


ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Inherited>$/, q{Match <:Inherited>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<!:Inherited>.$/ ), q{Don't match negated <Inherited>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Inherited>$/ ), q{Don't match inverted <Inherited>} );
ok(!( "\x[75FA]"  ~~ m/^<:Inherited>$/ ), q{Don't match unrelated <Inherited>} );
ok("\x[75FA]"  ~~ m/^<!:Inherited>.$/, q{Match unrelated negated <Inherited>} );
ok("\x[75FA]"  ~~ m/^<-:Inherited>$/, q{Match unrelated inverted <Inherited>} );
ok("\x[75FA]\c[COMBINING GRAVE ACCENT]" ~~ m/<:Inherited>/, q{Match unanchored <Inherited>} );

# Kannada


ok("\c[KANNADA SIGN ANUSVARA]" ~~ m/^<:Kannada>$/, q{Match <:Kannada>} );
ok(!( "\c[KANNADA SIGN ANUSVARA]" ~~ m/^<!:Kannada>.$/ ), q{Don't match negated <Kannada>} );
ok(!( "\c[KANNADA SIGN ANUSVARA]" ~~ m/^<-:Kannada>$/ ), q{Don't match inverted <Kannada>} );
ok(!( "\x[C1DF]"  ~~ m/^<:Kannada>$/ ), q{Don't match unrelated <Kannada>} );
ok("\x[C1DF]"  ~~ m/^<!:Kannada>.$/, q{Match unrelated negated <Kannada>} );
ok("\x[C1DF]"  ~~ m/^<-:Kannada>$/, q{Match unrelated inverted <Kannada>} );
ok("\x[C1DF]\c[KANNADA SIGN ANUSVARA]" ~~ m/<:Kannada>/, q{Match unanchored <Kannada>} );

# Katakana


ok("\c[KATAKANA LETTER SMALL A]" ~~ m/^<:Katakana>$/, q{Match <:Katakana>} );
ok(!( "\c[KATAKANA LETTER SMALL A]" ~~ m/^<!:Katakana>.$/ ), q{Don't match negated <Katakana>} );
ok(!( "\c[KATAKANA LETTER SMALL A]" ~~ m/^<-:Katakana>$/ ), q{Don't match inverted <Katakana>} );
ok(!( "\x[177A]"  ~~ m/^<:Katakana>$/ ), q{Don't match unrelated <Katakana>} );
ok("\x[177A]"  ~~ m/^<!:Katakana>.$/, q{Match unrelated negated <Katakana>} );
ok("\x[177A]"  ~~ m/^<-:Katakana>$/, q{Match unrelated inverted <Katakana>} );
ok("\x[177A]\c[KATAKANA LETTER SMALL A]" ~~ m/<:Katakana>/, q{Match unanchored <Katakana>} );

# Khmer


ok("\c[KHMER LETTER KA]" ~~ m/^<:Khmer>$/, q{Match <:Khmer>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<!:Khmer>.$/ ), q{Don't match negated <Khmer>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<-:Khmer>$/ ), q{Don't match inverted <Khmer>} );
ok(!( "\c[GEORGIAN LETTER QAR]"  ~~ m/^<:Khmer>$/ ), q{Don't match unrelated <Khmer>} );
ok("\c[GEORGIAN LETTER QAR]"  ~~ m/^<!:Khmer>.$/, q{Match unrelated negated <Khmer>} );
ok("\c[GEORGIAN LETTER QAR]"  ~~ m/^<-:Khmer>$/, q{Match unrelated inverted <Khmer>} );
ok("\c[GEORGIAN LETTER QAR]\c[KHMER LETTER KA]" ~~ m/<:Khmer>/, q{Match unanchored <Khmer>} );

# Lao


ok("\c[LAO LETTER KO]" ~~ m/^<:Lao>$/, q{Match <:Lao>} );
ok(!( "\c[LAO LETTER KO]" ~~ m/^<!:Lao>.$/ ), q{Don't match negated <Lao>} );
ok(!( "\c[LAO LETTER KO]" ~~ m/^<-:Lao>$/ ), q{Don't match inverted <Lao>} );
ok(!( "\x[3DA9]"  ~~ m/^<:Lao>$/ ), q{Don't match unrelated <Lao>} );
ok("\x[3DA9]"  ~~ m/^<!:Lao>.$/, q{Match unrelated negated <Lao>} );
ok("\x[3DA9]"  ~~ m/^<-:Lao>$/, q{Match unrelated inverted <Lao>} );
ok(!( "\x[3DA9]" ~~ m/^<:Lao>$/ ), q{Don't match related <Lao>} );
ok("\x[3DA9]" ~~ m/^<!:Lao>.$/, q{Match related negated <Lao>} );
ok("\x[3DA9]" ~~ m/^<-:Lao>$/, q{Match related inverted <Lao>} );
ok("\x[3DA9]\x[3DA9]\c[LAO LETTER KO]" ~~ m/<:Lao>/, q{Match unanchored <Lao>} );

# Latin


ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<:Latin>$/, q{Match <:Latin>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<!:Latin>.$/ ), q{Don't match negated <Latin>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-:Latin>$/ ), q{Don't match inverted <Latin>} );
ok(!( "\x[C549]"  ~~ m/^<:Latin>$/ ), q{Don't match unrelated <Latin>} );
ok("\x[C549]"  ~~ m/^<!:Latin>.$/, q{Match unrelated negated <Latin>} );
ok("\x[C549]"  ~~ m/^<-:Latin>$/, q{Match unrelated inverted <Latin>} );
ok(!( "\x[C549]" ~~ m/^<:Latin>$/ ), q{Don't match related <Latin>} );
ok("\x[C549]" ~~ m/^<!:Latin>.$/, q{Match related negated <Latin>} );
ok("\x[C549]" ~~ m/^<-:Latin>$/, q{Match related inverted <Latin>} );
ok("\x[C549]\x[C549]\c[LATIN CAPITAL LETTER A]" ~~ m/<:Latin>/, q{Match unanchored <Latin>} );

# Malayalam


ok("\c[MALAYALAM SIGN ANUSVARA]" ~~ m/^<:Malayalam>$/, q{Match <:Malayalam>} );
ok(!( "\c[MALAYALAM SIGN ANUSVARA]" ~~ m/^<!:Malayalam>.$/ ), q{Don't match negated <Malayalam>} );
ok(!( "\c[MALAYALAM SIGN ANUSVARA]" ~~ m/^<-:Malayalam>$/ ), q{Don't match inverted <Malayalam>} );
ok(!( "\x[625C]"  ~~ m/^<:Malayalam>$/ ), q{Don't match unrelated <Malayalam>} );
ok("\x[625C]"  ~~ m/^<!:Malayalam>.$/, q{Match unrelated negated <Malayalam>} );
ok("\x[625C]"  ~~ m/^<-:Malayalam>$/, q{Match unrelated inverted <Malayalam>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Malayalam>$/ ), q{Don't match related <Malayalam>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!:Malayalam>.$/, q{Match related negated <Malayalam>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Malayalam>$/, q{Match related inverted <Malayalam>} );
ok("\x[625C]\c[COMBINING GRAVE ACCENT]\c[MALAYALAM SIGN ANUSVARA]" ~~ m/<:Malayalam>/, q{Match unanchored <Malayalam>} );

# Mongolian


ok("\c[MONGOLIAN DIGIT ZERO]" ~~ m/^<:Mongolian>$/, q{Match <:Mongolian>} );
ok(!( "\c[MONGOLIAN DIGIT ZERO]" ~~ m/^<!:Mongolian>.$/ ), q{Don't match negated <Mongolian>} );
ok(!( "\c[MONGOLIAN DIGIT ZERO]" ~~ m/^<-:Mongolian>$/ ), q{Don't match inverted <Mongolian>} );
ok(!( "\x[5F93]"  ~~ m/^<:Mongolian>$/ ), q{Don't match unrelated <Mongolian>} );
ok("\x[5F93]"  ~~ m/^<!:Mongolian>.$/, q{Match unrelated negated <Mongolian>} );
ok("\x[5F93]"  ~~ m/^<-:Mongolian>$/, q{Match unrelated inverted <Mongolian>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Mongolian>$/ ), q{Don't match related <Mongolian>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!:Mongolian>.$/, q{Match related negated <Mongolian>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Mongolian>$/, q{Match related inverted <Mongolian>} );
ok("\x[5F93]\c[COMBINING GRAVE ACCENT]\c[MONGOLIAN DIGIT ZERO]" ~~ m/<:Mongolian>/, q{Match unanchored <Mongolian>} );

# Myanmar


ok("\c[MYANMAR LETTER KA]" ~~ m/^<:Myanmar>$/, q{Match <:Myanmar>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<!:Myanmar>.$/ ), q{Don't match negated <Myanmar>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<-:Myanmar>$/ ), q{Don't match inverted <Myanmar>} );
ok(!( "\x[649A]"  ~~ m/^<:Myanmar>$/ ), q{Don't match unrelated <Myanmar>} );
ok("\x[649A]"  ~~ m/^<!:Myanmar>.$/, q{Match unrelated negated <Myanmar>} );
ok("\x[649A]"  ~~ m/^<-:Myanmar>$/, q{Match unrelated inverted <Myanmar>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Myanmar>$/ ), q{Don't match related <Myanmar>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!:Myanmar>.$/, q{Match related negated <Myanmar>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Myanmar>$/, q{Match related inverted <Myanmar>} );
ok("\x[649A]\c[COMBINING GRAVE ACCENT]\c[MYANMAR LETTER KA]" ~~ m/<:Myanmar>/, q{Match unanchored <Myanmar>} );

# Ogham


ok("\c[OGHAM LETTER BEITH]" ~~ m/^<:Ogham>$/, q{Match <:Ogham>} );
ok(!( "\c[OGHAM LETTER BEITH]" ~~ m/^<!:Ogham>.$/ ), q{Don't match negated <Ogham>} );
ok(!( "\c[OGHAM LETTER BEITH]" ~~ m/^<-:Ogham>$/ ), q{Don't match inverted <Ogham>} );
ok(!( "\c[KATAKANA LETTER KA]"  ~~ m/^<:Ogham>$/ ), q{Don't match unrelated <Ogham>} );
ok("\c[KATAKANA LETTER KA]"  ~~ m/^<!:Ogham>.$/, q{Match unrelated negated <Ogham>} );
ok("\c[KATAKANA LETTER KA]"  ~~ m/^<-:Ogham>$/, q{Match unrelated inverted <Ogham>} );
ok("\c[KATAKANA LETTER KA]\c[OGHAM LETTER BEITH]" ~~ m/<:Ogham>/, q{Match unanchored <Ogham>} );

# Old_Italic


ok(!( "\x[8BB7]"  ~~ m/^<:Old_Italic>$/ ), q{Don't match unrelated <Old_Italic>} );
ok("\x[8BB7]"  ~~ m/^<!:Old_Italic>.$/, q{Match unrelated negated <Old_Italic>} );
ok("\x[8BB7]"  ~~ m/^<-:Old_Italic>$/, q{Match unrelated inverted <Old_Italic>} );

# Oriya


ok("\c[ORIYA SIGN CANDRABINDU]" ~~ m/^<:Oriya>$/, q{Match <:Oriya>} );
ok(!( "\c[ORIYA SIGN CANDRABINDU]" ~~ m/^<!:Oriya>.$/ ), q{Don't match negated <Oriya>} );
ok(!( "\c[ORIYA SIGN CANDRABINDU]" ~~ m/^<-:Oriya>$/ ), q{Don't match inverted <Oriya>} );
ok(!( "\x[4292]"  ~~ m/^<:Oriya>$/ ), q{Don't match unrelated <Oriya>} );
ok("\x[4292]"  ~~ m/^<!:Oriya>.$/, q{Match unrelated negated <Oriya>} );
ok("\x[4292]"  ~~ m/^<-:Oriya>$/, q{Match unrelated inverted <Oriya>} );
ok("\x[4292]\c[ORIYA SIGN CANDRABINDU]" ~~ m/<:Oriya>/, q{Match unanchored <Oriya>} );

# Runic


ok("\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<:Runic>$/, q{Match <:Runic>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<!:Runic>.$/ ), q{Don't match negated <Runic>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<-:Runic>$/ ), q{Don't match inverted <Runic>} );
ok(!( "\x[9857]"  ~~ m/^<:Runic>$/ ), q{Don't match unrelated <Runic>} );
ok("\x[9857]"  ~~ m/^<!:Runic>.$/, q{Match unrelated negated <Runic>} );
ok("\x[9857]"  ~~ m/^<-:Runic>$/, q{Match unrelated inverted <Runic>} );
ok("\x[9857]\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/<:Runic>/, q{Match unanchored <Runic>} );

# Sinhala


ok("\c[SINHALA SIGN ANUSVARAYA]" ~~ m/^<:Sinhala>$/, q{Match <:Sinhala>} );
ok(!( "\c[SINHALA SIGN ANUSVARAYA]" ~~ m/^<!:Sinhala>.$/ ), q{Don't match negated <Sinhala>} );
ok(!( "\c[SINHALA SIGN ANUSVARAYA]" ~~ m/^<-:Sinhala>$/ ), q{Don't match inverted <Sinhala>} );
ok(!( "\x[5DF5]"  ~~ m/^<:Sinhala>$/ ), q{Don't match unrelated <Sinhala>} );
ok("\x[5DF5]"  ~~ m/^<!:Sinhala>.$/, q{Match unrelated negated <Sinhala>} );
ok("\x[5DF5]"  ~~ m/^<-:Sinhala>$/, q{Match unrelated inverted <Sinhala>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:Sinhala>$/ ), q{Don't match related <Sinhala>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<!:Sinhala>.$/, q{Match related negated <Sinhala>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<-:Sinhala>$/, q{Match related inverted <Sinhala>} );
ok("\x[5DF5]\c[YI RADICAL QOT]\c[SINHALA SIGN ANUSVARAYA]" ~~ m/<:Sinhala>/, q{Match unanchored <Sinhala>} );

# Syriac


ok("\c[SYRIAC LETTER ALAPH]" ~~ m/^<:Syriac>$/, q{Match <:Syriac>} );
ok(!( "\c[SYRIAC LETTER ALAPH]" ~~ m/^<!:Syriac>.$/ ), q{Don't match negated <Syriac>} );
ok(!( "\c[SYRIAC LETTER ALAPH]" ~~ m/^<-:Syriac>$/ ), q{Don't match inverted <Syriac>} );
ok(!( "\x[57F0]"  ~~ m/^<:Syriac>$/ ), q{Don't match unrelated <Syriac>} );
ok("\x[57F0]"  ~~ m/^<!:Syriac>.$/, q{Match unrelated negated <Syriac>} );
ok("\x[57F0]"  ~~ m/^<-:Syriac>$/, q{Match unrelated inverted <Syriac>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:Syriac>$/ ), q{Don't match related <Syriac>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<!:Syriac>.$/, q{Match related negated <Syriac>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<-:Syriac>$/, q{Match related inverted <Syriac>} );
ok("\x[57F0]\c[YI RADICAL QOT]\c[SYRIAC LETTER ALAPH]" ~~ m/<:Syriac>/, q{Match unanchored <Syriac>} );

# Tagalog


ok("\c[TAGALOG LETTER A]" ~~ m/^<:Tagalog>$/, q{Match <:Tagalog>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<!:Tagalog>.$/ ), q{Don't match negated <Tagalog>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<-:Tagalog>$/ ), q{Don't match inverted <Tagalog>} );
ok(!( "\x[3DE8]"  ~~ m/^<:Tagalog>$/ ), q{Don't match unrelated <Tagalog>} );
ok("\x[3DE8]"  ~~ m/^<!:Tagalog>.$/, q{Match unrelated negated <Tagalog>} );
ok("\x[3DE8]"  ~~ m/^<-:Tagalog>$/, q{Match unrelated inverted <Tagalog>} );
ok("\x[3DE8]\c[TAGALOG LETTER A]" ~~ m/<:Tagalog>/, q{Match unanchored <Tagalog>} );

# Tagbanwa


ok("\c[TAGBANWA LETTER A]" ~~ m/^<:Tagbanwa>$/, q{Match <:Tagbanwa>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<!:Tagbanwa>.$/ ), q{Don't match negated <Tagbanwa>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<-:Tagbanwa>$/ ), q{Don't match inverted <Tagbanwa>} );
ok(!( "\c[CHEROKEE LETTER TLV]"  ~~ m/^<:Tagbanwa>$/ ), q{Don't match unrelated <Tagbanwa>} );
ok("\c[CHEROKEE LETTER TLV]"  ~~ m/^<!:Tagbanwa>.$/, q{Match unrelated negated <Tagbanwa>} );
ok("\c[CHEROKEE LETTER TLV]"  ~~ m/^<-:Tagbanwa>$/, q{Match unrelated inverted <Tagbanwa>} );
ok("\c[CHEROKEE LETTER TLV]\c[TAGBANWA LETTER A]" ~~ m/<:Tagbanwa>/, q{Match unanchored <Tagbanwa>} );

# Tamil


ok("\c[TAMIL SIGN ANUSVARA]" ~~ m/^<:Tamil>$/, q{Match <:Tamil>} );
ok(!( "\c[TAMIL SIGN ANUSVARA]" ~~ m/^<!:Tamil>.$/ ), q{Don't match negated <Tamil>} );
ok(!( "\c[TAMIL SIGN ANUSVARA]" ~~ m/^<-:Tamil>$/ ), q{Don't match inverted <Tamil>} );
ok(!( "\x[8DF2]"  ~~ m/^<:Tamil>$/ ), q{Don't match unrelated <Tamil>} );
ok("\x[8DF2]"  ~~ m/^<!:Tamil>.$/, q{Match unrelated negated <Tamil>} );
ok("\x[8DF2]"  ~~ m/^<-:Tamil>$/, q{Match unrelated inverted <Tamil>} );
ok("\x[8DF2]\c[TAMIL SIGN ANUSVARA]" ~~ m/<:Tamil>/, q{Match unanchored <Tamil>} );

# Telugu


ok("\c[TELUGU SIGN CANDRABINDU]" ~~ m/^<:Telugu>$/, q{Match <:Telugu>} );
ok(!( "\c[TELUGU SIGN CANDRABINDU]" ~~ m/^<!:Telugu>.$/ ), q{Don't match negated <Telugu>} );
ok(!( "\c[TELUGU SIGN CANDRABINDU]" ~~ m/^<-:Telugu>$/ ), q{Don't match inverted <Telugu>} );
ok(!( "\x[8088]"  ~~ m/^<:Telugu>$/ ), q{Don't match unrelated <Telugu>} );
ok("\x[8088]"  ~~ m/^<!:Telugu>.$/, q{Match unrelated negated <Telugu>} );
ok("\x[8088]"  ~~ m/^<-:Telugu>$/, q{Match unrelated inverted <Telugu>} );
ok("\x[8088]\c[TELUGU SIGN CANDRABINDU]" ~~ m/<:Telugu>/, q{Match unanchored <Telugu>} );

# Thaana


ok("\c[THAANA LETTER HAA]" ~~ m/^<:Thaana>$/, q{Match <:Thaana>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<!:Thaana>.$/ ), q{Don't match negated <Thaana>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<-:Thaana>$/ ), q{Don't match inverted <Thaana>} );
ok(!( "\x[5240]"  ~~ m/^<:Thaana>$/ ), q{Don't match unrelated <Thaana>} );
ok("\x[5240]"  ~~ m/^<!:Thaana>.$/, q{Match unrelated negated <Thaana>} );
ok("\x[5240]"  ~~ m/^<-:Thaana>$/, q{Match unrelated inverted <Thaana>} );
ok("\x[5240]\c[THAANA LETTER HAA]" ~~ m/<:Thaana>/, q{Match unanchored <Thaana>} );

# Thai


ok("\c[THAI CHARACTER KO KAI]" ~~ m/^<:Thai>$/, q{Match <:Thai>} );
ok(!( "\c[THAI CHARACTER KO KAI]" ~~ m/^<!:Thai>.$/ ), q{Don't match negated <Thai>} );
ok(!( "\c[THAI CHARACTER KO KAI]" ~~ m/^<-:Thai>$/ ), q{Don't match inverted <Thai>} );
ok(!( "\x[CAD3]"  ~~ m/^<:Thai>$/ ), q{Don't match unrelated <Thai>} );
ok("\x[CAD3]"  ~~ m/^<!:Thai>.$/, q{Match unrelated negated <Thai>} );
ok("\x[CAD3]"  ~~ m/^<-:Thai>$/, q{Match unrelated inverted <Thai>} );
ok("\x[CAD3]\c[THAI CHARACTER KO KAI]" ~~ m/<:Thai>/, q{Match unanchored <Thai>} );

# Tibetan


ok("\c[TIBETAN SYLLABLE OM]" ~~ m/^<:Tibetan>$/, q{Match <:Tibetan>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<!:Tibetan>.$/ ), q{Don't match negated <Tibetan>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<-:Tibetan>$/ ), q{Don't match inverted <Tibetan>} );
ok(!( "\x[8557]"  ~~ m/^<:Tibetan>$/ ), q{Don't match unrelated <Tibetan>} );
ok("\x[8557]"  ~~ m/^<!:Tibetan>.$/, q{Match unrelated negated <Tibetan>} );
ok("\x[8557]"  ~~ m/^<-:Tibetan>$/, q{Match unrelated inverted <Tibetan>} );
ok("\x[8557]\c[TIBETAN SYLLABLE OM]" ~~ m/<:Tibetan>/, q{Match unanchored <Tibetan>} );

# Yi


ok("\c[YI SYLLABLE IT]" ~~ m/^<:Yi>$/, q{Match <:Yi>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<!:Yi>.$/ ), q{Don't match negated <Yi>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<-:Yi>$/ ), q{Don't match inverted <Yi>} );
ok(!( "\x[BCD0]"  ~~ m/^<:Yi>$/ ), q{Don't match unrelated <Yi>} );
ok("\x[BCD0]"  ~~ m/^<!:Yi>.$/, q{Match unrelated negated <Yi>} );
ok("\x[BCD0]"  ~~ m/^<-:Yi>$/, q{Match unrelated inverted <Yi>} );
ok("\x[BCD0]\c[YI SYLLABLE IT]" ~~ m/<:Yi>/, q{Match unanchored <Yi>} );


# vim: ft=perl6
