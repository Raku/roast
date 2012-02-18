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

#?rakudo 35 skip 'Unicode properties with arguments'
#?pugs todo
ok("\c[YI SYLLABLE IT]" ~~ m/^<:bc<L>>$/, q{Match (Left-to-Right)} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<!:bc<L>>.$/ ), q{Don't match negated (Left-to-Right)} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<-:bc<L>>$/ ), q{Don't match inverted (Left-to-Right)} );
ok(!( "\x[05D0]"  ~~ m/^<:bc<L>>$/ ), q{Don't match unrelated (Left-to-Right)} );
#?pugs todo
ok("\x[05D0]"  ~~ m/^<!:bc<L>>.$/, q{Match unrelated negated (Left-to-Right)} );
#?pugs todo
ok("\x[05D0]"  ~~ m/^<-:bc<L>>$/, q{Match unrelated inverted (Left-to-Right)} );
#?pugs todo
ok("\x[05D0]\c[YI SYLLABLE IT]" ~~ m/<:bc<L>>/, q{Match unanchored (Left-to-Right)} );

# bc<EN>      # European Number


#?pugs todo
ok("\c[DIGIT ZERO]" ~~ m/^<:bc<EN>>$/, q{Match (European Number)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<!:bc<EN>>.$/ ), q{Don't match negated (European Number)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-:bc<EN>>$/ ), q{Don't match inverted (European Number)} );
ok(!( "\x[AFFB]"  ~~ m/^<:bc<EN>>$/ ), q{Don't match unrelated (European Number)} );
#?pugs todo
ok("\x[AFFB]"  ~~ m/^<!:bc<EN>>.$/, q{Match unrelated negated (European Number)} );
#?pugs todo
ok("\x[AFFB]"  ~~ m/^<-:bc<EN>>$/, q{Match unrelated inverted (European Number)} );
#?pugs todo
ok("\x[AFFB]\c[DIGIT ZERO]" ~~ m/<:bc<EN>>/, q{Match unanchored (European Number)} );

# bc<ES>      # European Number Separator


#?pugs todo
ok("\c[PLUS SIGN]" ~~ m/^<:bc<ES>>$/, q{Match (European Number Separator)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<!:bc<ES>>.$/ ), q{Don't match negated (European Number Separator)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<-:bc<ES>>$/ ), q{Don't match inverted (European Number Separator)} );
ok(!( "\x[7B89]"  ~~ m/^<:bc<ES>>$/ ), q{Don't match unrelated (European Number Separator)} );
#?pugs todo
ok("\x[7B89]"  ~~ m/^<!:bc<ES>>.$/, q{Match unrelated negated (European Number Separator)} );
#?pugs todo
ok("\x[7B89]"  ~~ m/^<-:bc<ES>>$/, q{Match unrelated inverted (European Number Separator)} );
#?pugs todo
ok("\x[7B89]\c[PLUS SIGN]" ~~ m/<:bc<ES>>/, q{Match unanchored (European Number Separator)} );

# bc<ET>      # European Number Terminator


#?pugs todo
ok("\c[NUMBER SIGN]" ~~ m/^<:bc<ET>>$/, q{Match (European Number Terminator)} );
ok(!( "\c[NUMBER SIGN]" ~~ m/^<!:bc<ET>>.$/ ), q{Don't match negated (European Number Terminator)} );
ok(!( "\c[NUMBER SIGN]" ~~ m/^<-:bc<ET>>$/ ), q{Don't match inverted (European Number Terminator)} );
ok(!( "\x[6780]"  ~~ m/^<:bc<ET>>$/ ), q{Don't match unrelated (European Number Terminator)} );
#?pugs todo
ok("\x[6780]"  ~~ m/^<!:bc<ET>>.$/, q{Match unrelated negated (European Number Terminator)} );
#?pugs todo
ok("\x[6780]"  ~~ m/^<-:bc<ET>>$/, q{Match unrelated inverted (European Number Terminator)} );
#?pugs todo
ok("\x[6780]\c[NUMBER SIGN]" ~~ m/<:bc<ET>>/, q{Match unanchored (European Number Terminator)} );

# bc<WS>      # Whitespace


#?pugs todo
ok("\c[FORM FEED (FF)]" ~~ m/^<:bc<WS>>$/, q{Match (Whitespace)} );
ok(!( "\c[FORM FEED (FF)]" ~~ m/^<!:bc<WS>>.$/ ), q{Don't match negated (Whitespace)} );
ok(!( "\c[FORM FEED (FF)]" ~~ m/^<-:bc<WS>>$/ ), q{Don't match inverted (Whitespace)} );
ok(!( "\x[6CF9]"  ~~ m/^<:bc<WS>>$/ ), q{Don't match unrelated (Whitespace)} );
#?pugs todo
ok("\x[6CF9]"  ~~ m/^<!:bc<WS>>.$/, q{Match unrelated negated (Whitespace)} );
#?pugs todo
ok("\x[6CF9]"  ~~ m/^<-:bc<WS>>$/, q{Match unrelated inverted (Whitespace)} );
#?pugs todo
ok("\x[6CF9]\c[FORM FEED (FF)]" ~~ m/<:bc<WS>>/, q{Match unanchored (Whitespace)} );


# Arabic


#?pugs todo
ok("\c[ARABIC LETTER HAMZA]" ~~ m/^<:Arabic>$/, q{Match <:Arabic>} );
ok(!( "\c[ARABIC LETTER HAMZA]" ~~ m/^<!:Arabic>.$/ ), q{Don't match negated <Arabic>} );
ok(!( "\c[ARABIC LETTER HAMZA]" ~~ m/^<-:Arabic>$/ ), q{Don't match inverted <Arabic>} );
ok(!( "\x[A649]"  ~~ m/^<:Arabic>$/ ), q{Don't match unrelated <Arabic>} );
#?pugs todo
ok("\x[A649]"  ~~ m/^<!:Arabic>.$/, q{Match unrelated negated <Arabic>} );
#?pugs todo
ok("\x[A649]"  ~~ m/^<-:Arabic>$/, q{Match unrelated inverted <Arabic>} );
#?pugs todo
ok("\x[A649]\c[ARABIC LETTER HAMZA]" ~~ m/<:Arabic>/, q{Match unanchored <Arabic>} );

# Armenian


#?pugs todo
ok("\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/^<:Armenian>$/, q{Match <:Armenian>} );
ok(!( "\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/^<!:Armenian>.$/ ), q{Don't match negated <Armenian>} );
ok(!( "\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/^<-:Armenian>$/ ), q{Don't match inverted <Armenian>} );
ok(!( "\x[CBFF]"  ~~ m/^<:Armenian>$/ ), q{Don't match unrelated <Armenian>} );
#?pugs todo
ok("\x[CBFF]"  ~~ m/^<!:Armenian>.$/, q{Match unrelated negated <Armenian>} );
#?pugs todo
ok("\x[CBFF]"  ~~ m/^<-:Armenian>$/, q{Match unrelated inverted <Armenian>} );
#?pugs todo
ok("\x[CBFF]\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/<:Armenian>/, q{Match unanchored <Armenian>} );

# Bengali


#?pugs todo
ok("\c[BENGALI SIGN CANDRABINDU]" ~~ m/^<:Bengali>$/, q{Match <:Bengali>} );
ok(!( "\c[BENGALI SIGN CANDRABINDU]" ~~ m/^<!:Bengali>.$/ ), q{Don't match negated <Bengali>} );
ok(!( "\c[BENGALI SIGN CANDRABINDU]" ~~ m/^<-:Bengali>$/ ), q{Don't match inverted <Bengali>} );
ok(!( "\x[D1E8]"  ~~ m/^<:Bengali>$/ ), q{Don't match unrelated <Bengali>} );
#?pugs todo
ok("\x[D1E8]"  ~~ m/^<!:Bengali>.$/, q{Match unrelated negated <Bengali>} );
#?pugs todo
ok("\x[D1E8]"  ~~ m/^<-:Bengali>$/, q{Match unrelated inverted <Bengali>} );
#?pugs todo
ok("\x[D1E8]\c[BENGALI SIGN CANDRABINDU]" ~~ m/<:Bengali>/, q{Match unanchored <Bengali>} );

# Bopomofo


#?pugs todo
ok("\c[BOPOMOFO LETTER B]" ~~ m/^<:Bopomofo>$/, q{Match <:Bopomofo>} );
ok(!( "\c[BOPOMOFO LETTER B]" ~~ m/^<!:Bopomofo>.$/ ), q{Don't match negated <Bopomofo>} );
ok(!( "\c[BOPOMOFO LETTER B]" ~~ m/^<-:Bopomofo>$/ ), q{Don't match inverted <Bopomofo>} );
ok(!( "\x[B093]"  ~~ m/^<:Bopomofo>$/ ), q{Don't match unrelated <Bopomofo>} );
#?pugs todo
ok("\x[B093]"  ~~ m/^<!:Bopomofo>.$/, q{Match unrelated negated <Bopomofo>} );
#?pugs todo
ok("\x[B093]"  ~~ m/^<-:Bopomofo>$/, q{Match unrelated inverted <Bopomofo>} );
#?pugs todo
ok("\x[B093]\c[BOPOMOFO LETTER B]" ~~ m/<:Bopomofo>/, q{Match unanchored <Bopomofo>} );

# Buhid


#?pugs todo
ok("\c[BUHID LETTER A]" ~~ m/^<:Buhid>$/, q{Match <:Buhid>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<!:Buhid>.$/ ), q{Don't match negated <Buhid>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<-:Buhid>$/ ), q{Don't match inverted <Buhid>} );
ok(!( "\x[C682]"  ~~ m/^<:Buhid>$/ ), q{Don't match unrelated <Buhid>} );
#?pugs todo
ok("\x[C682]"  ~~ m/^<!:Buhid>.$/, q{Match unrelated negated <Buhid>} );
#?pugs todo
ok("\x[C682]"  ~~ m/^<-:Buhid>$/, q{Match unrelated inverted <Buhid>} );
#?pugs todo
ok("\x[C682]\c[BUHID LETTER A]" ~~ m/<:Buhid>/, q{Match unanchored <Buhid>} );

# Canadian_Aboriginal


#?pugs todo
ok("\c[CANADIAN SYLLABICS E]" ~~ m/^<:Canadian_Aboriginal>$/, q{Match <:Canadian_Aboriginal>} );
ok(!( "\c[CANADIAN SYLLABICS E]" ~~ m/^<!:Canadian_Aboriginal>.$/ ), q{Don't match negated <Canadian_Aboriginal>} );
ok(!( "\c[CANADIAN SYLLABICS E]" ~~ m/^<-:Canadian_Aboriginal>$/ ), q{Don't match inverted <Canadian_Aboriginal>} );
ok(!( "\x[888B]"  ~~ m/^<:Canadian_Aboriginal>$/ ), q{Don't match unrelated <Canadian_Aboriginal>} );
#?pugs todo
ok("\x[888B]"  ~~ m/^<!:Canadian_Aboriginal>.$/, q{Match unrelated negated <Canadian_Aboriginal>} );
#?pugs todo
ok("\x[888B]"  ~~ m/^<-:Canadian_Aboriginal>$/, q{Match unrelated inverted <Canadian_Aboriginal>} );
ok(!( "\x[9FA6]" ~~ m/^<:Canadian_Aboriginal>$/ ), q{Don't match related <Canadian_Aboriginal>} );
#?pugs todo
ok("\x[9FA6]" ~~ m/^<!:Canadian_Aboriginal>.$/, q{Match related negated <Canadian_Aboriginal>} );
#?pugs todo
ok("\x[9FA6]" ~~ m/^<-:Canadian_Aboriginal>$/, q{Match related inverted <Canadian_Aboriginal>} );
#?pugs todo
ok("\x[888B]\x[9FA6]\c[CANADIAN SYLLABICS E]" ~~ m/<:Canadian_Aboriginal>/, q{Match unanchored <Canadian_Aboriginal>} );

# Cherokee


#?pugs todo
ok("\c[CHEROKEE LETTER A]" ~~ m/^<:Cherokee>$/, q{Match <:Cherokee>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<!:Cherokee>.$/ ), q{Don't match negated <Cherokee>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<-:Cherokee>$/ ), q{Don't match inverted <Cherokee>} );
ok(!( "\x[8260]"  ~~ m/^<:Cherokee>$/ ), q{Don't match unrelated <Cherokee>} );
#?pugs todo
ok("\x[8260]"  ~~ m/^<!:Cherokee>.$/, q{Match unrelated negated <Cherokee>} );
#?pugs todo
ok("\x[8260]"  ~~ m/^<-:Cherokee>$/, q{Match unrelated inverted <Cherokee>} );
ok(!( "\x[9FA6]" ~~ m/^<:Cherokee>$/ ), q{Don't match related <Cherokee>} );
#?pugs todo
ok("\x[9FA6]" ~~ m/^<!:Cherokee>.$/, q{Match related negated <Cherokee>} );
#?pugs todo
ok("\x[9FA6]" ~~ m/^<-:Cherokee>$/, q{Match related inverted <Cherokee>} );
#?pugs todo
ok("\x[8260]\x[9FA6]\c[CHEROKEE LETTER A]" ~~ m/<:Cherokee>/, q{Match unanchored <Cherokee>} );

# Cyrillic


#?pugs todo
ok("\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<:Cyrillic>$/, q{Match <:Cyrillic>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<!:Cyrillic>.$/ ), q{Don't match negated <Cyrillic>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<-:Cyrillic>$/ ), q{Don't match inverted <Cyrillic>} );
ok(!( "\x[B7DF]"  ~~ m/^<:Cyrillic>$/ ), q{Don't match unrelated <Cyrillic>} );
#?pugs todo
ok("\x[B7DF]"  ~~ m/^<!:Cyrillic>.$/, q{Match unrelated negated <Cyrillic>} );
#?pugs todo
ok("\x[B7DF]"  ~~ m/^<-:Cyrillic>$/, q{Match unrelated inverted <Cyrillic>} );
ok(!( "\x[D7A4]" ~~ m/^<:Cyrillic>$/ ), q{Don't match related <Cyrillic>} );
#?pugs todo
ok("\x[D7A4]" ~~ m/^<!:Cyrillic>.$/, q{Match related negated <Cyrillic>} );
#?pugs todo
ok("\x[D7A4]" ~~ m/^<-:Cyrillic>$/, q{Match related inverted <Cyrillic>} );
#?pugs todo
ok("\x[B7DF]\x[D7A4]\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/<:Cyrillic>/, q{Match unanchored <Cyrillic>} );

# Deseret


ok(!( "\x[A8A0]"  ~~ m/^<:Deseret>$/ ), q{Don't match unrelated <Deseret>} );
#?pugs todo
ok("\x[A8A0]"  ~~ m/^<!:Deseret>.$/, q{Match unrelated negated <Deseret>} );
#?pugs todo
ok("\x[A8A0]"  ~~ m/^<-:Deseret>$/, q{Match unrelated inverted <Deseret>} );

# Devanagari


#?pugs todo
ok("\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<:Devanagari>$/, q{Match <:Devanagari>} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<!:Devanagari>.$/ ), q{Don't match negated <Devanagari>} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<-:Devanagari>$/ ), q{Don't match inverted <Devanagari>} );
ok(!( "\x[D291]"  ~~ m/^<:Devanagari>$/ ), q{Don't match unrelated <Devanagari>} );
#?pugs todo
ok("\x[D291]"  ~~ m/^<!:Devanagari>.$/, q{Match unrelated negated <Devanagari>} );
#?pugs todo
ok("\x[D291]"  ~~ m/^<-:Devanagari>$/, q{Match unrelated inverted <Devanagari>} );
#?pugs todo
ok("\x[D291]\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/<:Devanagari>/, q{Match unanchored <Devanagari>} );

# Ethiopic


#?pugs todo
ok("\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<:Ethiopic>$/, q{Match <:Ethiopic>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<!:Ethiopic>.$/ ), q{Don't match negated <Ethiopic>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<-:Ethiopic>$/ ), q{Don't match inverted <Ethiopic>} );
ok(!( "\x[A9FA]"  ~~ m/^<:Ethiopic>$/ ), q{Don't match unrelated <Ethiopic>} );
#?pugs todo
ok("\x[A9FA]"  ~~ m/^<!:Ethiopic>.$/, q{Match unrelated negated <Ethiopic>} );
#?pugs todo
ok("\x[A9FA]"  ~~ m/^<-:Ethiopic>$/, q{Match unrelated inverted <Ethiopic>} );
#?pugs todo
ok("\x[A9FA]\c[ETHIOPIC SYLLABLE HA]" ~~ m/<:Ethiopic>/, q{Match unanchored <Ethiopic>} );

# Georgian


#?pugs todo
ok("\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<:Georgian>$/, q{Match <:Georgian>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<!:Georgian>.$/ ), q{Don't match negated <Georgian>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<-:Georgian>$/ ), q{Don't match inverted <Georgian>} );
ok(!( "\x[BBC9]"  ~~ m/^<:Georgian>$/ ), q{Don't match unrelated <Georgian>} );
#?pugs todo
ok("\x[BBC9]"  ~~ m/^<!:Georgian>.$/, q{Match unrelated negated <Georgian>} );
#?pugs todo
ok("\x[BBC9]"  ~~ m/^<-:Georgian>$/, q{Match unrelated inverted <Georgian>} );
#?pugs todo
ok("\x[BBC9]\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/<:Georgian>/, q{Match unanchored <Georgian>} );

# Gothic


ok(!( "\x[5888]"  ~~ m/^<:Gothic>$/ ), q{Don't match unrelated <Gothic>} );
#?pugs todo
ok("\x[5888]"  ~~ m/^<!:Gothic>.$/, q{Match unrelated negated <Gothic>} );
#?pugs todo
ok("\x[5888]"  ~~ m/^<-:Gothic>$/, q{Match unrelated inverted <Gothic>} );

# Greek


#?pugs todo
ok("\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/^<:Greek>$/, q{Match <:Greek>} );
ok(!( "\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/^<!:Greek>.$/ ), q{Don't match negated <Greek>} );
ok(!( "\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/^<-:Greek>$/ ), q{Don't match inverted <Greek>} );
ok(!( "\c[ETHIOPIC SYLLABLE KEE]"  ~~ m/^<:Greek>$/ ), q{Don't match unrelated <Greek>} );
#?pugs todo
ok("\c[ETHIOPIC SYLLABLE KEE]"  ~~ m/^<!:Greek>.$/, q{Match unrelated negated <Greek>} );
#?pugs todo
ok("\c[ETHIOPIC SYLLABLE KEE]"  ~~ m/^<-:Greek>$/, q{Match unrelated inverted <Greek>} );
#?pugs todo
ok("\c[ETHIOPIC SYLLABLE KEE]\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/<:Greek>/, q{Match unanchored <Greek>} );

# Gujarati


#?pugs todo
ok("\c[GUJARATI SIGN CANDRABINDU]" ~~ m/^<:Gujarati>$/, q{Match <:Gujarati>} );
ok(!( "\c[GUJARATI SIGN CANDRABINDU]" ~~ m/^<!:Gujarati>.$/ ), q{Don't match negated <Gujarati>} );
ok(!( "\c[GUJARATI SIGN CANDRABINDU]" ~~ m/^<-:Gujarati>$/ ), q{Don't match inverted <Gujarati>} );
ok(!( "\x[D108]"  ~~ m/^<:Gujarati>$/ ), q{Don't match unrelated <Gujarati>} );
#?pugs todo
ok("\x[D108]"  ~~ m/^<!:Gujarati>.$/, q{Match unrelated negated <Gujarati>} );
#?pugs todo
ok("\x[D108]"  ~~ m/^<-:Gujarati>$/, q{Match unrelated inverted <Gujarati>} );
#?pugs todo
ok("\x[D108]\c[GUJARATI SIGN CANDRABINDU]" ~~ m/<:Gujarati>/, q{Match unanchored <Gujarati>} );

# Gurmukhi


#?pugs todo
ok("\c[GURMUKHI SIGN BINDI]" ~~ m/^<:Gurmukhi>$/, q{Match <:Gurmukhi>} );
ok(!( "\c[GURMUKHI SIGN BINDI]" ~~ m/^<!:Gurmukhi>.$/ ), q{Don't match negated <Gurmukhi>} );
ok(!( "\c[GURMUKHI SIGN BINDI]" ~~ m/^<-:Gurmukhi>$/ ), q{Don't match inverted <Gurmukhi>} );
ok(!( "\x[5E05]"  ~~ m/^<:Gurmukhi>$/ ), q{Don't match unrelated <Gurmukhi>} );
#?pugs todo
ok("\x[5E05]"  ~~ m/^<!:Gurmukhi>.$/, q{Match unrelated negated <Gurmukhi>} );
#?pugs todo
ok("\x[5E05]"  ~~ m/^<-:Gurmukhi>$/, q{Match unrelated inverted <Gurmukhi>} );
#?pugs todo
ok("\x[5E05]\c[GURMUKHI SIGN BINDI]" ~~ m/<:Gurmukhi>/, q{Match unanchored <Gurmukhi>} );

# Han


#?pugs todo
ok("\c[CJK RADICAL REPEAT]" ~~ m/^<:Han>$/, q{Match <:Han>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<!:Han>.$/ ), q{Don't match negated <Han>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<-:Han>$/ ), q{Don't match inverted <Han>} );
ok(!( "\c[CANADIAN SYLLABICS KAA]"  ~~ m/^<:Han>$/ ), q{Don't match unrelated <Han>} );
#?pugs todo
ok("\c[CANADIAN SYLLABICS KAA]"  ~~ m/^<!:Han>.$/, q{Match unrelated negated <Han>} );
#?pugs todo
ok("\c[CANADIAN SYLLABICS KAA]"  ~~ m/^<-:Han>$/, q{Match unrelated inverted <Han>} );
#?pugs todo
ok("\c[CANADIAN SYLLABICS KAA]\c[CJK RADICAL REPEAT]" ~~ m/<:Han>/, q{Match unanchored <Han>} );

# Hangul


#?pugs todo
ok("\x[AC00]" ~~ m/^<:Hangul>$/, q{Match <:Hangul>} );
ok(!( "\x[AC00]" ~~ m/^<!:Hangul>.$/ ), q{Don't match negated <Hangul>} );
ok(!( "\x[AC00]" ~~ m/^<-:Hangul>$/ ), q{Don't match inverted <Hangul>} );
ok(!( "\x[9583]"  ~~ m/^<:Hangul>$/ ), q{Don't match unrelated <Hangul>} );
#?pugs todo
ok("\x[9583]"  ~~ m/^<!:Hangul>.$/, q{Match unrelated negated <Hangul>} );
#?pugs todo
ok("\x[9583]"  ~~ m/^<-:Hangul>$/, q{Match unrelated inverted <Hangul>} );
#?pugs todo
ok("\x[9583]\x[AC00]" ~~ m/<:Hangul>/, q{Match unanchored <Hangul>} );

# Hanunoo


#?pugs todo
ok("\c[HANUNOO LETTER A]" ~~ m/^<:Hanunoo>$/, q{Match <:Hanunoo>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<!:Hanunoo>.$/ ), q{Don't match negated <Hanunoo>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<-:Hanunoo>$/ ), q{Don't match inverted <Hanunoo>} );
ok(!( "\x[7625]"  ~~ m/^<:Hanunoo>$/ ), q{Don't match unrelated <Hanunoo>} );
#?pugs todo
ok("\x[7625]"  ~~ m/^<!:Hanunoo>.$/, q{Match unrelated negated <Hanunoo>} );
#?pugs todo
ok("\x[7625]"  ~~ m/^<-:Hanunoo>$/, q{Match unrelated inverted <Hanunoo>} );
#?pugs todo
ok("\x[7625]\c[HANUNOO LETTER A]" ~~ m/<:Hanunoo>/, q{Match unanchored <Hanunoo>} );

# Hebrew


#?pugs todo
ok("\c[HEBREW LETTER ALEF]" ~~ m/^<:Hebrew>$/, q{Match <:Hebrew>} );
ok(!( "\c[HEBREW LETTER ALEF]" ~~ m/^<!:Hebrew>.$/ ), q{Don't match negated <Hebrew>} );
ok(!( "\c[HEBREW LETTER ALEF]" ~~ m/^<-:Hebrew>$/ ), q{Don't match inverted <Hebrew>} );
ok(!( "\c[YI SYLLABLE SSIT]"  ~~ m/^<:Hebrew>$/ ), q{Don't match unrelated <Hebrew>} );
#?pugs todo
ok("\c[YI SYLLABLE SSIT]"  ~~ m/^<!:Hebrew>.$/, q{Match unrelated negated <Hebrew>} );
#?pugs todo
ok("\c[YI SYLLABLE SSIT]"  ~~ m/^<-:Hebrew>$/, q{Match unrelated inverted <Hebrew>} );
#?pugs todo
ok("\c[YI SYLLABLE SSIT]\c[HEBREW LETTER ALEF]" ~~ m/<:Hebrew>/, q{Match unanchored <Hebrew>} );

# Hiragana


#?pugs todo
ok("\c[HIRAGANA LETTER SMALL A]" ~~ m/^<:Hiragana>$/, q{Match <:Hiragana>} );
ok(!( "\c[HIRAGANA LETTER SMALL A]" ~~ m/^<!:Hiragana>.$/ ), q{Don't match negated <Hiragana>} );
ok(!( "\c[HIRAGANA LETTER SMALL A]" ~~ m/^<-:Hiragana>$/ ), q{Don't match inverted <Hiragana>} );
ok(!( "\c[CANADIAN SYLLABICS Y]"  ~~ m/^<:Hiragana>$/ ), q{Don't match unrelated <Hiragana>} );
#?pugs todo
ok("\c[CANADIAN SYLLABICS Y]"  ~~ m/^<!:Hiragana>.$/, q{Match unrelated negated <Hiragana>} );
#?pugs todo
ok("\c[CANADIAN SYLLABICS Y]"  ~~ m/^<-:Hiragana>$/, q{Match unrelated inverted <Hiragana>} );
#?pugs todo
ok("\c[CANADIAN SYLLABICS Y]\c[HIRAGANA LETTER SMALL A]" ~~ m/<:Hiragana>/, q{Match unanchored <Hiragana>} );

# Inherited


#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Inherited>$/, q{Match <:Inherited>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<!:Inherited>.$/ ), q{Don't match negated <Inherited>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Inherited>$/ ), q{Don't match inverted <Inherited>} );
ok(!( "\x[75FA]"  ~~ m/^<:Inherited>$/ ), q{Don't match unrelated <Inherited>} );
#?pugs todo
ok("\x[75FA]"  ~~ m/^<!:Inherited>.$/, q{Match unrelated negated <Inherited>} );
#?pugs todo
ok("\x[75FA]"  ~~ m/^<-:Inherited>$/, q{Match unrelated inverted <Inherited>} );
#?pugs todo
ok("\x[75FA]\c[COMBINING GRAVE ACCENT]" ~~ m/<:Inherited>/, q{Match unanchored <Inherited>} );

# Kannada


#?pugs todo
ok("\c[KANNADA SIGN ANUSVARA]" ~~ m/^<:Kannada>$/, q{Match <:Kannada>} );
ok(!( "\c[KANNADA SIGN ANUSVARA]" ~~ m/^<!:Kannada>.$/ ), q{Don't match negated <Kannada>} );
ok(!( "\c[KANNADA SIGN ANUSVARA]" ~~ m/^<-:Kannada>$/ ), q{Don't match inverted <Kannada>} );
ok(!( "\x[C1DF]"  ~~ m/^<:Kannada>$/ ), q{Don't match unrelated <Kannada>} );
#?pugs todo
ok("\x[C1DF]"  ~~ m/^<!:Kannada>.$/, q{Match unrelated negated <Kannada>} );
#?pugs todo
ok("\x[C1DF]"  ~~ m/^<-:Kannada>$/, q{Match unrelated inverted <Kannada>} );
#?pugs todo
ok("\x[C1DF]\c[KANNADA SIGN ANUSVARA]" ~~ m/<:Kannada>/, q{Match unanchored <Kannada>} );

# Katakana


#?pugs todo
ok("\c[KATAKANA LETTER SMALL A]" ~~ m/^<:Katakana>$/, q{Match <:Katakana>} );
ok(!( "\c[KATAKANA LETTER SMALL A]" ~~ m/^<!:Katakana>.$/ ), q{Don't match negated <Katakana>} );
ok(!( "\c[KATAKANA LETTER SMALL A]" ~~ m/^<-:Katakana>$/ ), q{Don't match inverted <Katakana>} );
ok(!( "\x[177A]"  ~~ m/^<:Katakana>$/ ), q{Don't match unrelated <Katakana>} );
#?pugs todo
ok("\x[177A]"  ~~ m/^<!:Katakana>.$/, q{Match unrelated negated <Katakana>} );
#?pugs todo
ok("\x[177A]"  ~~ m/^<-:Katakana>$/, q{Match unrelated inverted <Katakana>} );
#?pugs todo
ok("\x[177A]\c[KATAKANA LETTER SMALL A]" ~~ m/<:Katakana>/, q{Match unanchored <Katakana>} );

# Khmer


#?pugs todo
ok("\c[KHMER LETTER KA]" ~~ m/^<:Khmer>$/, q{Match <:Khmer>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<!:Khmer>.$/ ), q{Don't match negated <Khmer>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<-:Khmer>$/ ), q{Don't match inverted <Khmer>} );
ok(!( "\c[GEORGIAN LETTER QAR]"  ~~ m/^<:Khmer>$/ ), q{Don't match unrelated <Khmer>} );
#?pugs todo
ok("\c[GEORGIAN LETTER QAR]"  ~~ m/^<!:Khmer>.$/, q{Match unrelated negated <Khmer>} );
#?pugs todo
ok("\c[GEORGIAN LETTER QAR]"  ~~ m/^<-:Khmer>$/, q{Match unrelated inverted <Khmer>} );
#?pugs todo
ok("\c[GEORGIAN LETTER QAR]\c[KHMER LETTER KA]" ~~ m/<:Khmer>/, q{Match unanchored <Khmer>} );

# Lao


#?pugs todo
ok("\c[LAO LETTER KO]" ~~ m/^<:Lao>$/, q{Match <:Lao>} );
ok(!( "\c[LAO LETTER KO]" ~~ m/^<!:Lao>.$/ ), q{Don't match negated <Lao>} );
ok(!( "\c[LAO LETTER KO]" ~~ m/^<-:Lao>$/ ), q{Don't match inverted <Lao>} );
ok(!( "\x[3DA9]"  ~~ m/^<:Lao>$/ ), q{Don't match unrelated <Lao>} );
#?pugs todo
ok("\x[3DA9]"  ~~ m/^<!:Lao>.$/, q{Match unrelated negated <Lao>} );
#?pugs todo
ok("\x[3DA9]"  ~~ m/^<-:Lao>$/, q{Match unrelated inverted <Lao>} );
ok(!( "\x[3DA9]" ~~ m/^<:Lao>$/ ), q{Don't match related <Lao>} );
#?pugs todo
ok("\x[3DA9]" ~~ m/^<!:Lao>.$/, q{Match related negated <Lao>} );
#?pugs todo
ok("\x[3DA9]" ~~ m/^<-:Lao>$/, q{Match related inverted <Lao>} );
#?pugs todo
ok("\x[3DA9]\x[3DA9]\c[LAO LETTER KO]" ~~ m/<:Lao>/, q{Match unanchored <Lao>} );

# Latin


#?pugs todo
ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<:Latin>$/, q{Match <:Latin>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<!:Latin>.$/ ), q{Don't match negated <Latin>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-:Latin>$/ ), q{Don't match inverted <Latin>} );
ok(!( "\x[C549]"  ~~ m/^<:Latin>$/ ), q{Don't match unrelated <Latin>} );
#?pugs todo
ok("\x[C549]"  ~~ m/^<!:Latin>.$/, q{Match unrelated negated <Latin>} );
#?pugs todo
ok("\x[C549]"  ~~ m/^<-:Latin>$/, q{Match unrelated inverted <Latin>} );
ok(!( "\x[C549]" ~~ m/^<:Latin>$/ ), q{Don't match related <Latin>} );
#?pugs todo
ok("\x[C549]" ~~ m/^<!:Latin>.$/, q{Match related negated <Latin>} );
#?pugs todo
ok("\x[C549]" ~~ m/^<-:Latin>$/, q{Match related inverted <Latin>} );
#?pugs todo
ok("\x[C549]\x[C549]\c[LATIN CAPITAL LETTER A]" ~~ m/<:Latin>/, q{Match unanchored <Latin>} );

# Malayalam


#?pugs todo
ok("\c[MALAYALAM SIGN ANUSVARA]" ~~ m/^<:Malayalam>$/, q{Match <:Malayalam>} );
ok(!( "\c[MALAYALAM SIGN ANUSVARA]" ~~ m/^<!:Malayalam>.$/ ), q{Don't match negated <Malayalam>} );
ok(!( "\c[MALAYALAM SIGN ANUSVARA]" ~~ m/^<-:Malayalam>$/ ), q{Don't match inverted <Malayalam>} );
ok(!( "\x[625C]"  ~~ m/^<:Malayalam>$/ ), q{Don't match unrelated <Malayalam>} );
#?pugs todo
ok("\x[625C]"  ~~ m/^<!:Malayalam>.$/, q{Match unrelated negated <Malayalam>} );
#?pugs todo
ok("\x[625C]"  ~~ m/^<-:Malayalam>$/, q{Match unrelated inverted <Malayalam>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Malayalam>$/ ), q{Don't match related <Malayalam>} );
#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!:Malayalam>.$/, q{Match related negated <Malayalam>} );
#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Malayalam>$/, q{Match related inverted <Malayalam>} );
#?pugs todo
ok("\x[625C]\c[COMBINING GRAVE ACCENT]\c[MALAYALAM SIGN ANUSVARA]" ~~ m/<:Malayalam>/, q{Match unanchored <Malayalam>} );

# Mongolian


#?pugs todo
ok("\c[MONGOLIAN DIGIT ZERO]" ~~ m/^<:Mongolian>$/, q{Match <:Mongolian>} );
ok(!( "\c[MONGOLIAN DIGIT ZERO]" ~~ m/^<!:Mongolian>.$/ ), q{Don't match negated <Mongolian>} );
ok(!( "\c[MONGOLIAN DIGIT ZERO]" ~~ m/^<-:Mongolian>$/ ), q{Don't match inverted <Mongolian>} );
ok(!( "\x[5F93]"  ~~ m/^<:Mongolian>$/ ), q{Don't match unrelated <Mongolian>} );
#?pugs todo
ok("\x[5F93]"  ~~ m/^<!:Mongolian>.$/, q{Match unrelated negated <Mongolian>} );
#?pugs todo
ok("\x[5F93]"  ~~ m/^<-:Mongolian>$/, q{Match unrelated inverted <Mongolian>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Mongolian>$/ ), q{Don't match related <Mongolian>} );
#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!:Mongolian>.$/, q{Match related negated <Mongolian>} );
#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Mongolian>$/, q{Match related inverted <Mongolian>} );
#?pugs todo
ok("\x[5F93]\c[COMBINING GRAVE ACCENT]\c[MONGOLIAN DIGIT ZERO]" ~~ m/<:Mongolian>/, q{Match unanchored <Mongolian>} );

# Myanmar


#?pugs todo
ok("\c[MYANMAR LETTER KA]" ~~ m/^<:Myanmar>$/, q{Match <:Myanmar>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<!:Myanmar>.$/ ), q{Don't match negated <Myanmar>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<-:Myanmar>$/ ), q{Don't match inverted <Myanmar>} );
ok(!( "\x[649A]"  ~~ m/^<:Myanmar>$/ ), q{Don't match unrelated <Myanmar>} );
#?pugs todo
ok("\x[649A]"  ~~ m/^<!:Myanmar>.$/, q{Match unrelated negated <Myanmar>} );
#?pugs todo
ok("\x[649A]"  ~~ m/^<-:Myanmar>$/, q{Match unrelated inverted <Myanmar>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Myanmar>$/ ), q{Don't match related <Myanmar>} );
#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!:Myanmar>.$/, q{Match related negated <Myanmar>} );
#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Myanmar>$/, q{Match related inverted <Myanmar>} );
#?pugs todo
ok("\x[649A]\c[COMBINING GRAVE ACCENT]\c[MYANMAR LETTER KA]" ~~ m/<:Myanmar>/, q{Match unanchored <Myanmar>} );

# Ogham


#?pugs todo
ok("\c[OGHAM LETTER BEITH]" ~~ m/^<:Ogham>$/, q{Match <:Ogham>} );
ok(!( "\c[OGHAM LETTER BEITH]" ~~ m/^<!:Ogham>.$/ ), q{Don't match negated <Ogham>} );
ok(!( "\c[OGHAM LETTER BEITH]" ~~ m/^<-:Ogham>$/ ), q{Don't match inverted <Ogham>} );
ok(!( "\c[KATAKANA LETTER KA]"  ~~ m/^<:Ogham>$/ ), q{Don't match unrelated <Ogham>} );
#?pugs todo
ok("\c[KATAKANA LETTER KA]"  ~~ m/^<!:Ogham>.$/, q{Match unrelated negated <Ogham>} );
#?pugs todo
ok("\c[KATAKANA LETTER KA]"  ~~ m/^<-:Ogham>$/, q{Match unrelated inverted <Ogham>} );
#?pugs todo
ok("\c[KATAKANA LETTER KA]\c[OGHAM LETTER BEITH]" ~~ m/<:Ogham>/, q{Match unanchored <Ogham>} );

# Old_Italic


ok(!( "\x[8BB7]"  ~~ m/^<:Old_Italic>$/ ), q{Don't match unrelated <Old_Italic>} );
#?pugs todo
ok("\x[8BB7]"  ~~ m/^<!:Old_Italic>.$/, q{Match unrelated negated <Old_Italic>} );
#?pugs todo
ok("\x[8BB7]"  ~~ m/^<-:Old_Italic>$/, q{Match unrelated inverted <Old_Italic>} );

# Oriya


#?pugs todo
ok("\c[ORIYA SIGN CANDRABINDU]" ~~ m/^<:Oriya>$/, q{Match <:Oriya>} );
ok(!( "\c[ORIYA SIGN CANDRABINDU]" ~~ m/^<!:Oriya>.$/ ), q{Don't match negated <Oriya>} );
ok(!( "\c[ORIYA SIGN CANDRABINDU]" ~~ m/^<-:Oriya>$/ ), q{Don't match inverted <Oriya>} );
ok(!( "\x[4292]"  ~~ m/^<:Oriya>$/ ), q{Don't match unrelated <Oriya>} );
#?pugs todo
ok("\x[4292]"  ~~ m/^<!:Oriya>.$/, q{Match unrelated negated <Oriya>} );
#?pugs todo
ok("\x[4292]"  ~~ m/^<-:Oriya>$/, q{Match unrelated inverted <Oriya>} );
#?pugs todo
ok("\x[4292]\c[ORIYA SIGN CANDRABINDU]" ~~ m/<:Oriya>/, q{Match unanchored <Oriya>} );

# Runic


#?pugs todo
ok("\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<:Runic>$/, q{Match <:Runic>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<!:Runic>.$/ ), q{Don't match negated <Runic>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<-:Runic>$/ ), q{Don't match inverted <Runic>} );
ok(!( "\x[9857]"  ~~ m/^<:Runic>$/ ), q{Don't match unrelated <Runic>} );
#?pugs todo
ok("\x[9857]"  ~~ m/^<!:Runic>.$/, q{Match unrelated negated <Runic>} );
#?pugs todo
ok("\x[9857]"  ~~ m/^<-:Runic>$/, q{Match unrelated inverted <Runic>} );
#?pugs todo
ok("\x[9857]\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/<:Runic>/, q{Match unanchored <Runic>} );

# Sinhala


#?pugs todo
ok("\c[SINHALA SIGN ANUSVARAYA]" ~~ m/^<:Sinhala>$/, q{Match <:Sinhala>} );
ok(!( "\c[SINHALA SIGN ANUSVARAYA]" ~~ m/^<!:Sinhala>.$/ ), q{Don't match negated <Sinhala>} );
ok(!( "\c[SINHALA SIGN ANUSVARAYA]" ~~ m/^<-:Sinhala>$/ ), q{Don't match inverted <Sinhala>} );
ok(!( "\x[5DF5]"  ~~ m/^<:Sinhala>$/ ), q{Don't match unrelated <Sinhala>} );
#?pugs todo
ok("\x[5DF5]"  ~~ m/^<!:Sinhala>.$/, q{Match unrelated negated <Sinhala>} );
#?pugs todo
ok("\x[5DF5]"  ~~ m/^<-:Sinhala>$/, q{Match unrelated inverted <Sinhala>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:Sinhala>$/ ), q{Don't match related <Sinhala>} );
#?pugs todo
ok("\c[YI RADICAL QOT]" ~~ m/^<!:Sinhala>.$/, q{Match related negated <Sinhala>} );
#?pugs todo
ok("\c[YI RADICAL QOT]" ~~ m/^<-:Sinhala>$/, q{Match related inverted <Sinhala>} );
#?pugs todo
ok("\x[5DF5]\c[YI RADICAL QOT]\c[SINHALA SIGN ANUSVARAYA]" ~~ m/<:Sinhala>/, q{Match unanchored <Sinhala>} );

# Syriac


#?pugs todo
ok("\c[SYRIAC LETTER ALAPH]" ~~ m/^<:Syriac>$/, q{Match <:Syriac>} );
ok(!( "\c[SYRIAC LETTER ALAPH]" ~~ m/^<!:Syriac>.$/ ), q{Don't match negated <Syriac>} );
ok(!( "\c[SYRIAC LETTER ALAPH]" ~~ m/^<-:Syriac>$/ ), q{Don't match inverted <Syriac>} );
ok(!( "\x[57F0]"  ~~ m/^<:Syriac>$/ ), q{Don't match unrelated <Syriac>} );
#?pugs todo
ok("\x[57F0]"  ~~ m/^<!:Syriac>.$/, q{Match unrelated negated <Syriac>} );
#?pugs todo
ok("\x[57F0]"  ~~ m/^<-:Syriac>$/, q{Match unrelated inverted <Syriac>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:Syriac>$/ ), q{Don't match related <Syriac>} );
#?pugs todo
ok("\c[YI RADICAL QOT]" ~~ m/^<!:Syriac>.$/, q{Match related negated <Syriac>} );
#?pugs todo
ok("\c[YI RADICAL QOT]" ~~ m/^<-:Syriac>$/, q{Match related inverted <Syriac>} );
#?pugs todo
ok("\x[57F0]\c[YI RADICAL QOT]\c[SYRIAC LETTER ALAPH]" ~~ m/<:Syriac>/, q{Match unanchored <Syriac>} );

# Tagalog


#?pugs todo
ok("\c[TAGALOG LETTER A]" ~~ m/^<:Tagalog>$/, q{Match <:Tagalog>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<!:Tagalog>.$/ ), q{Don't match negated <Tagalog>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<-:Tagalog>$/ ), q{Don't match inverted <Tagalog>} );
ok(!( "\x[3DE8]"  ~~ m/^<:Tagalog>$/ ), q{Don't match unrelated <Tagalog>} );
#?pugs todo
ok("\x[3DE8]"  ~~ m/^<!:Tagalog>.$/, q{Match unrelated negated <Tagalog>} );
#?pugs todo
ok("\x[3DE8]"  ~~ m/^<-:Tagalog>$/, q{Match unrelated inverted <Tagalog>} );
#?pugs todo
ok("\x[3DE8]\c[TAGALOG LETTER A]" ~~ m/<:Tagalog>/, q{Match unanchored <Tagalog>} );

# Tagbanwa


#?pugs todo
ok("\c[TAGBANWA LETTER A]" ~~ m/^<:Tagbanwa>$/, q{Match <:Tagbanwa>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<!:Tagbanwa>.$/ ), q{Don't match negated <Tagbanwa>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<-:Tagbanwa>$/ ), q{Don't match inverted <Tagbanwa>} );
ok(!( "\c[CHEROKEE LETTER TLV]"  ~~ m/^<:Tagbanwa>$/ ), q{Don't match unrelated <Tagbanwa>} );
#?pugs todo
ok("\c[CHEROKEE LETTER TLV]"  ~~ m/^<!:Tagbanwa>.$/, q{Match unrelated negated <Tagbanwa>} );
#?pugs todo
ok("\c[CHEROKEE LETTER TLV]"  ~~ m/^<-:Tagbanwa>$/, q{Match unrelated inverted <Tagbanwa>} );
#?pugs todo
ok("\c[CHEROKEE LETTER TLV]\c[TAGBANWA LETTER A]" ~~ m/<:Tagbanwa>/, q{Match unanchored <Tagbanwa>} );

# Tamil


#?pugs todo
ok("\c[TAMIL SIGN ANUSVARA]" ~~ m/^<:Tamil>$/, q{Match <:Tamil>} );
ok(!( "\c[TAMIL SIGN ANUSVARA]" ~~ m/^<!:Tamil>.$/ ), q{Don't match negated <Tamil>} );
ok(!( "\c[TAMIL SIGN ANUSVARA]" ~~ m/^<-:Tamil>$/ ), q{Don't match inverted <Tamil>} );
ok(!( "\x[8DF2]"  ~~ m/^<:Tamil>$/ ), q{Don't match unrelated <Tamil>} );
#?pugs todo
ok("\x[8DF2]"  ~~ m/^<!:Tamil>.$/, q{Match unrelated negated <Tamil>} );
#?pugs todo
ok("\x[8DF2]"  ~~ m/^<-:Tamil>$/, q{Match unrelated inverted <Tamil>} );
#?pugs todo
ok("\x[8DF2]\c[TAMIL SIGN ANUSVARA]" ~~ m/<:Tamil>/, q{Match unanchored <Tamil>} );

# Telugu


#?pugs todo
ok("\c[TELUGU SIGN CANDRABINDU]" ~~ m/^<:Telugu>$/, q{Match <:Telugu>} );
ok(!( "\c[TELUGU SIGN CANDRABINDU]" ~~ m/^<!:Telugu>.$/ ), q{Don't match negated <Telugu>} );
ok(!( "\c[TELUGU SIGN CANDRABINDU]" ~~ m/^<-:Telugu>$/ ), q{Don't match inverted <Telugu>} );
ok(!( "\x[8088]"  ~~ m/^<:Telugu>$/ ), q{Don't match unrelated <Telugu>} );
#?pugs todo
ok("\x[8088]"  ~~ m/^<!:Telugu>.$/, q{Match unrelated negated <Telugu>} );
#?pugs todo
ok("\x[8088]"  ~~ m/^<-:Telugu>$/, q{Match unrelated inverted <Telugu>} );
#?pugs todo
ok("\x[8088]\c[TELUGU SIGN CANDRABINDU]" ~~ m/<:Telugu>/, q{Match unanchored <Telugu>} );

# Thaana


#?pugs todo
ok("\c[THAANA LETTER HAA]" ~~ m/^<:Thaana>$/, q{Match <:Thaana>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<!:Thaana>.$/ ), q{Don't match negated <Thaana>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<-:Thaana>$/ ), q{Don't match inverted <Thaana>} );
ok(!( "\x[5240]"  ~~ m/^<:Thaana>$/ ), q{Don't match unrelated <Thaana>} );
#?pugs todo
ok("\x[5240]"  ~~ m/^<!:Thaana>.$/, q{Match unrelated negated <Thaana>} );
#?pugs todo
ok("\x[5240]"  ~~ m/^<-:Thaana>$/, q{Match unrelated inverted <Thaana>} );
#?pugs todo
ok("\x[5240]\c[THAANA LETTER HAA]" ~~ m/<:Thaana>/, q{Match unanchored <Thaana>} );

# Thai


#?pugs todo
ok("\c[THAI CHARACTER KO KAI]" ~~ m/^<:Thai>$/, q{Match <:Thai>} );
ok(!( "\c[THAI CHARACTER KO KAI]" ~~ m/^<!:Thai>.$/ ), q{Don't match negated <Thai>} );
ok(!( "\c[THAI CHARACTER KO KAI]" ~~ m/^<-:Thai>$/ ), q{Don't match inverted <Thai>} );
ok(!( "\x[CAD3]"  ~~ m/^<:Thai>$/ ), q{Don't match unrelated <Thai>} );
#?pugs todo
ok("\x[CAD3]"  ~~ m/^<!:Thai>.$/, q{Match unrelated negated <Thai>} );
#?pugs todo
ok("\x[CAD3]"  ~~ m/^<-:Thai>$/, q{Match unrelated inverted <Thai>} );
#?pugs todo
ok("\x[CAD3]\c[THAI CHARACTER KO KAI]" ~~ m/<:Thai>/, q{Match unanchored <Thai>} );

# Tibetan


#?pugs todo
ok("\c[TIBETAN SYLLABLE OM]" ~~ m/^<:Tibetan>$/, q{Match <:Tibetan>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<!:Tibetan>.$/ ), q{Don't match negated <Tibetan>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<-:Tibetan>$/ ), q{Don't match inverted <Tibetan>} );
ok(!( "\x[8557]"  ~~ m/^<:Tibetan>$/ ), q{Don't match unrelated <Tibetan>} );
#?pugs todo
ok("\x[8557]"  ~~ m/^<!:Tibetan>.$/, q{Match unrelated negated <Tibetan>} );
#?pugs todo
ok("\x[8557]"  ~~ m/^<-:Tibetan>$/, q{Match unrelated inverted <Tibetan>} );
#?pugs todo
ok("\x[8557]\c[TIBETAN SYLLABLE OM]" ~~ m/<:Tibetan>/, q{Match unanchored <Tibetan>} );

# Yi


#?pugs todo
ok("\c[YI SYLLABLE IT]" ~~ m/^<:Yi>$/, q{Match <:Yi>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<!:Yi>.$/ ), q{Don't match negated <Yi>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<-:Yi>$/ ), q{Don't match inverted <Yi>} );
ok(!( "\x[BCD0]"  ~~ m/^<:Yi>$/ ), q{Don't match unrelated <Yi>} );
#?pugs todo
ok("\x[BCD0]"  ~~ m/^<!:Yi>.$/, q{Match unrelated negated <Yi>} );
#?pugs todo
ok("\x[BCD0]"  ~~ m/^<-:Yi>$/, q{Match unrelated inverted <Yi>} );
#?pugs todo
ok("\x[BCD0]\c[YI SYLLABLE IT]" ~~ m/<:Yi>/, q{Match unanchored <Yi>} );


# vim: ft=perl6
