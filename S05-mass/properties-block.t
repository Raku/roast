use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/properties_slow_to_compile.t.

XXX needs more clarification on the case of the rules, 
ie letter vs. Letter vs isLetter

=end pod

plan 670;

# InAlphabeticPresentationForms

ok(!( "\x[531A]"  ~~ m/^<:InAlphabeticPresentationForms>$/ ), q{Don't match unrelated <InAlphabeticPresentationForms>} );
#?pugs todo
ok("\x[531A]"  ~~ m/^<:!InAlphabeticPresentationForms>$/, q{Match unrelated negated <InAlphabeticPresentationForms>} );
#?pugs todo
ok("\x[531A]"  ~~ m/^<-:InAlphabeticPresentationForms>$/, q{Match unrelated inverted <InAlphabeticPresentationForms>} );

# InArabic


#?pugs todo
ok("\c[ARABIC NUMBER SIGN]" ~~ m/^<:InArabic>$/, q{Match <:InArabic>} );
ok(!( "\c[ARABIC NUMBER SIGN]" ~~ m/^<:!InArabic>$/ ), q{Don't match negated <InArabic>} );
ok(!( "\c[ARABIC NUMBER SIGN]" ~~ m/^<-:InArabic>$/ ), q{Don't match inverted <InArabic>} );
ok(!( "\x[7315]"  ~~ m/^<:InArabic>$/ ), q{Don't match unrelated <InArabic>} );
#?pugs todo
ok("\x[7315]"  ~~ m/^<:!InArabic>$/, q{Match unrelated negated <InArabic>} );
#?pugs todo
ok("\x[7315]"  ~~ m/^<-:InArabic>$/, q{Match unrelated inverted <InArabic>} );
#?pugs todo
ok("\x[7315]\c[ARABIC NUMBER SIGN]" ~~ m/<:InArabic>/, q{Match unanchored <InArabic>} );

# InArabicPresentationFormsA


ok(!( "\x[8340]"  ~~ m/^<:InArabicPresentationFormsA>$/ ), q{Don't match unrelated <InArabicPresentationFormsA>} );
#?pugs todo
ok("\x[8340]"  ~~ m/^<:!InArabicPresentationFormsA>$/, q{Match unrelated negated <InArabicPresentationFormsA>} );
#?pugs todo
ok("\x[8340]"  ~~ m/^<-:InArabicPresentationFormsA>$/, q{Match unrelated inverted <InArabicPresentationFormsA>} );

# InArabicPresentationFormsB


ok(!( "\x[BEEC]"  ~~ m/^<:InArabicPresentationFormsB>$/ ), q{Don't match unrelated <InArabicPresentationFormsB>} );
#?pugs todo
ok("\x[BEEC]"  ~~ m/^<:!InArabicPresentationFormsB>$/, q{Match unrelated negated <InArabicPresentationFormsB>} );
#?pugs todo
ok("\x[BEEC]"  ~~ m/^<-:InArabicPresentationFormsB>$/, q{Match unrelated inverted <InArabicPresentationFormsB>} );

# InArmenian


#?pugs todo
ok("\x[0530]" ~~ m/^<:InArmenian>$/, q{Match <:InArmenian>} );
ok(!( "\x[0530]" ~~ m/^<:!InArmenian>$/ ), q{Don't match negated <InArmenian>} );
ok(!( "\x[0530]" ~~ m/^<-:InArmenian>$/ ), q{Don't match inverted <InArmenian>} );
ok(!( "\x[3B0D]"  ~~ m/^<:InArmenian>$/ ), q{Don't match unrelated <InArmenian>} );
#?pugs todo
ok("\x[3B0D]"  ~~ m/^<:!InArmenian>$/, q{Match unrelated negated <InArmenian>} );
#?pugs todo
ok("\x[3B0D]"  ~~ m/^<-:InArmenian>$/, q{Match unrelated inverted <InArmenian>} );
#?pugs todo
ok("\x[3B0D]\x[0530]" ~~ m/<:InArmenian>/, q{Match unanchored <InArmenian>} );

# InArrows


#?pugs todo
ok("\c[LEFTWARDS ARROW]" ~~ m/^<:InArrows>$/, q{Match <:InArrows>} );
ok(!( "\c[LEFTWARDS ARROW]" ~~ m/^<:!InArrows>$/ ), q{Don't match negated <InArrows>} );
ok(!( "\c[LEFTWARDS ARROW]" ~~ m/^<-:InArrows>$/ ), q{Don't match inverted <InArrows>} );
ok(!( "\x[C401]"  ~~ m/^<:InArrows>$/ ), q{Don't match unrelated <InArrows>} );
#?pugs todo
ok("\x[C401]"  ~~ m/^<:!InArrows>$/, q{Match unrelated negated <InArrows>} );
#?pugs todo
ok("\x[C401]"  ~~ m/^<-:InArrows>$/, q{Match unrelated inverted <InArrows>} );
#?pugs todo
ok("\x[C401]\c[LEFTWARDS ARROW]" ~~ m/<:InArrows>/, q{Match unanchored <InArrows>} );


# InBasicLatin


#?pugs todo
ok("\c[NULL]" ~~ m/^<:InBasicLatin>$/, q{Match <:InBasicLatin>} );
ok(!( "\c[NULL]" ~~ m/^<:!InBasicLatin>$/ ), q{Don't match negated <InBasicLatin>} );
ok(!( "\c[NULL]" ~~ m/^<-:InBasicLatin>$/ ), q{Don't match inverted <InBasicLatin>} );
ok(!( "\x[46EA]"  ~~ m/^<:InBasicLatin>$/ ), q{Don't match unrelated <InBasicLatin>} );
#?pugs todo
ok("\x[46EA]"  ~~ m/^<:!InBasicLatin>$/, q{Match unrelated negated <InBasicLatin>} );
#?pugs todo
ok("\x[46EA]"  ~~ m/^<-:InBasicLatin>$/, q{Match unrelated inverted <InBasicLatin>} );
#?pugs todo
ok("\x[46EA]\c[NULL]" ~~ m/<:InBasicLatin>/, q{Match unanchored <InBasicLatin>} );

# InBengali


#?pugs todo
ok("\x[0980]" ~~ m/^<:InBengali>$/, q{Match <:InBengali>} );
ok(!( "\x[0980]" ~~ m/^<:!InBengali>$/ ), q{Don't match negated <InBengali>} );
ok(!( "\x[0980]" ~~ m/^<-:InBengali>$/ ), q{Don't match inverted <InBengali>} );
ok(!( "\c[YI SYLLABLE HMY]"  ~~ m/^<:InBengali>$/ ), q{Don't match unrelated <InBengali>} );
#?pugs todo
ok("\c[YI SYLLABLE HMY]"  ~~ m/^<:!InBengali>$/, q{Match unrelated negated <InBengali>} );
#?pugs todo
ok("\c[YI SYLLABLE HMY]"  ~~ m/^<-:InBengali>$/, q{Match unrelated inverted <InBengali>} );
#?pugs todo
ok("\c[YI SYLLABLE HMY]\x[0980]" ~~ m/<:InBengali>/, q{Match unanchored <InBengali>} );

# InBlockElements


#?pugs todo
ok("\c[UPPER HALF BLOCK]" ~~ m/^<:InBlockElements>$/, q{Match <:InBlockElements>} );
ok(!( "\c[UPPER HALF BLOCK]" ~~ m/^<:!InBlockElements>$/ ), q{Don't match negated <InBlockElements>} );
ok(!( "\c[UPPER HALF BLOCK]" ~~ m/^<-:InBlockElements>$/ ), q{Don't match inverted <InBlockElements>} );
ok(!( "\x[5F41]"  ~~ m/^<:InBlockElements>$/ ), q{Don't match unrelated <InBlockElements>} );
#?pugs todo
ok("\x[5F41]"  ~~ m/^<:!InBlockElements>$/, q{Match unrelated negated <InBlockElements>} );
#?pugs todo
ok("\x[5F41]"  ~~ m/^<-:InBlockElements>$/, q{Match unrelated inverted <InBlockElements>} );
#?pugs todo
ok("\x[5F41]\c[UPPER HALF BLOCK]" ~~ m/<:InBlockElements>/, q{Match unanchored <InBlockElements>} );

# InBopomofo


#?pugs todo
ok("\x[3100]" ~~ m/^<:InBopomofo>$/, q{Match <:InBopomofo>} );
ok(!( "\x[3100]" ~~ m/^<:!InBopomofo>$/ ), q{Don't match negated <InBopomofo>} );
ok(!( "\x[3100]" ~~ m/^<-:InBopomofo>$/ ), q{Don't match inverted <InBopomofo>} );
ok(!( "\x[9F8E]"  ~~ m/^<:InBopomofo>$/ ), q{Don't match unrelated <InBopomofo>} );
#?pugs todo
ok("\x[9F8E]"  ~~ m/^<:!InBopomofo>$/, q{Match unrelated negated <InBopomofo>} );
#?pugs todo
ok("\x[9F8E]"  ~~ m/^<-:InBopomofo>$/, q{Match unrelated inverted <InBopomofo>} );
#?pugs todo
ok("\x[9F8E]\x[3100]" ~~ m/<:InBopomofo>/, q{Match unanchored <InBopomofo>} );

# InBopomofoExtended


#?pugs todo
ok("\c[BOPOMOFO LETTER BU]" ~~ m/^<:InBopomofoExtended>$/, q{Match <:InBopomofoExtended>} );
ok(!( "\c[BOPOMOFO LETTER BU]" ~~ m/^<:!InBopomofoExtended>$/ ), q{Don't match negated <InBopomofoExtended>} );
ok(!( "\c[BOPOMOFO LETTER BU]" ~~ m/^<-:InBopomofoExtended>$/ ), q{Don't match inverted <InBopomofoExtended>} );
ok(!( "\x[43A6]"  ~~ m/^<:InBopomofoExtended>$/ ), q{Don't match unrelated <InBopomofoExtended>} );
#?pugs todo
ok("\x[43A6]"  ~~ m/^<:!InBopomofoExtended>$/, q{Match unrelated negated <InBopomofoExtended>} );
#?pugs todo
ok("\x[43A6]"  ~~ m/^<-:InBopomofoExtended>$/, q{Match unrelated inverted <InBopomofoExtended>} );
#?pugs todo
ok("\x[43A6]\c[BOPOMOFO LETTER BU]" ~~ m/<:InBopomofoExtended>/, q{Match unanchored <InBopomofoExtended>} );

# InBoxDrawing


#?pugs todo
ok("\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/^<:InBoxDrawing>$/, q{Match <:InBoxDrawing>} );
ok(!( "\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/^<:!InBoxDrawing>$/ ), q{Don't match negated <InBoxDrawing>} );
ok(!( "\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/^<-:InBoxDrawing>$/ ), q{Don't match inverted <InBoxDrawing>} );
ok(!( "\x[7865]"  ~~ m/^<:InBoxDrawing>$/ ), q{Don't match unrelated <InBoxDrawing>} );
#?pugs todo
ok("\x[7865]"  ~~ m/^<:!InBoxDrawing>$/, q{Match unrelated negated <InBoxDrawing>} );
#?pugs todo
ok("\x[7865]"  ~~ m/^<-:InBoxDrawing>$/, q{Match unrelated inverted <InBoxDrawing>} );
#?pugs todo
ok("\x[7865]\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/<:InBoxDrawing>/, q{Match unanchored <InBoxDrawing>} );

# InBraillePatterns


#?pugs todo
ok("\c[BRAILLE PATTERN BLANK]" ~~ m/^<:InBraillePatterns>$/, q{Match <:InBraillePatterns>} );
ok(!( "\c[BRAILLE PATTERN BLANK]" ~~ m/^<:!InBraillePatterns>$/ ), q{Don't match negated <InBraillePatterns>} );
ok(!( "\c[BRAILLE PATTERN BLANK]" ~~ m/^<-:InBraillePatterns>$/ ), q{Don't match inverted <InBraillePatterns>} );
ok(!( "\c[THAI CHARACTER KHO KHAI]"  ~~ m/^<:InBraillePatterns>$/ ), q{Don't match unrelated <InBraillePatterns>} );
#?pugs todo
ok("\c[THAI CHARACTER KHO KHAI]"  ~~ m/^<:!InBraillePatterns>$/, q{Match unrelated negated <InBraillePatterns>} );
#?pugs todo
ok("\c[THAI CHARACTER KHO KHAI]"  ~~ m/^<-:InBraillePatterns>$/, q{Match unrelated inverted <InBraillePatterns>} );
#?pugs todo
ok("\c[THAI CHARACTER KHO KHAI]\c[BRAILLE PATTERN BLANK]" ~~ m/<:InBraillePatterns>/, q{Match unanchored <InBraillePatterns>} );

# InBuhid


#?pugs todo
ok("\c[BUHID LETTER A]" ~~ m/^<:InBuhid>$/, q{Match <:InBuhid>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<:!InBuhid>$/ ), q{Don't match negated <InBuhid>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<-:InBuhid>$/ ), q{Don't match inverted <InBuhid>} );
ok(!( "\x[D208]"  ~~ m/^<:InBuhid>$/ ), q{Don't match unrelated <InBuhid>} );
#?pugs todo
ok("\x[D208]"  ~~ m/^<:!InBuhid>$/, q{Match unrelated negated <InBuhid>} );
#?pugs todo
ok("\x[D208]"  ~~ m/^<-:InBuhid>$/, q{Match unrelated inverted <InBuhid>} );
#?pugs todo
ok("\x[D208]\c[BUHID LETTER A]" ~~ m/<:InBuhid>/, q{Match unanchored <InBuhid>} );

# InByzantineMusicalSymbols


ok(!( "\x[9B1D]"  ~~ m/^<:InByzantineMusicalSymbols>$/ ), q{Don't match unrelated <InByzantineMusicalSymbols>} );
#?pugs todo
ok("\x[9B1D]"  ~~ m/^<:!InByzantineMusicalSymbols>$/, q{Match unrelated negated <InByzantineMusicalSymbols>} );
#?pugs todo
ok("\x[9B1D]"  ~~ m/^<-:InByzantineMusicalSymbols>$/, q{Match unrelated inverted <InByzantineMusicalSymbols>} );

# InCJKCompatibility


#?pugs todo
ok("\c[SQUARE APAATO]" ~~ m/^<:InCJKCompatibility>$/, q{Match <:InCJKCompatibility>} );
ok(!( "\c[SQUARE APAATO]" ~~ m/^<:!InCJKCompatibility>$/ ), q{Don't match negated <InCJKCompatibility>} );
ok(!( "\c[SQUARE APAATO]" ~~ m/^<-:InCJKCompatibility>$/ ), q{Don't match inverted <InCJKCompatibility>} );
ok(!( "\x[B8A5]"  ~~ m/^<:InCJKCompatibility>$/ ), q{Don't match unrelated <InCJKCompatibility>} );
#?pugs todo
ok("\x[B8A5]"  ~~ m/^<:!InCJKCompatibility>$/, q{Match unrelated negated <InCJKCompatibility>} );
#?pugs todo
ok("\x[B8A5]"  ~~ m/^<-:InCJKCompatibility>$/, q{Match unrelated inverted <InCJKCompatibility>} );
#?pugs todo
ok("\x[B8A5]\c[SQUARE APAATO]" ~~ m/<:InCJKCompatibility>/, q{Match unanchored <InCJKCompatibility>} );

# InCJKCompatibilityForms


ok(!( "\x[3528]"  ~~ m/^<:InCJKCompatibilityForms>$/ ), q{Don't match unrelated <InCJKCompatibilityForms>} );
#?pugs todo
ok("\x[3528]"  ~~ m/^<:!InCJKCompatibilityForms>$/, q{Match unrelated negated <InCJKCompatibilityForms>} );
#?pugs todo
ok("\x[3528]"  ~~ m/^<-:InCJKCompatibilityForms>$/, q{Match unrelated inverted <InCJKCompatibilityForms>} );

# InCJKCompatibilityIdeographs


ok(!( "\x[69F7]"  ~~ m/^<:InCJKCompatibilityIdeographs>$/ ), q{Don't match unrelated <InCJKCompatibilityIdeographs>} );
#?pugs todo
ok("\x[69F7]"  ~~ m/^<:!InCJKCompatibilityIdeographs>$/, q{Match unrelated negated <InCJKCompatibilityIdeographs>} );
#?pugs todo
ok("\x[69F7]"  ~~ m/^<-:InCJKCompatibilityIdeographs>$/, q{Match unrelated inverted <InCJKCompatibilityIdeographs>} );

# InCJKCompatibilityIdeographsSupplement


ok(!( "\c[CANADIAN SYLLABICS NUNAVIK HO]"  ~~ m/^<:InCJKCompatibilityIdeographsSupplement>$/ ), q{Don't match unrelated <InCJKCompatibilityIdeographsSupplement>} );
#?pugs todo
ok("\c[CANADIAN SYLLABICS NUNAVIK HO]"  ~~ m/^<:!InCJKCompatibilityIdeographsSupplement>$/, q{Match unrelated negated <InCJKCompatibilityIdeographsSupplement>} );
#?pugs todo
ok("\c[CANADIAN SYLLABICS NUNAVIK HO]"  ~~ m/^<-:InCJKCompatibilityIdeographsSupplement>$/, q{Match unrelated inverted <InCJKCompatibilityIdeographsSupplement>} );

# InCJKRadicalsSupplement


#?pugs todo
ok("\c[CJK RADICAL REPEAT]" ~~ m/^<:InCJKRadicalsSupplement>$/, q{Match <:InCJKRadicalsSupplement>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<:!InCJKRadicalsSupplement>$/ ), q{Don't match negated <InCJKRadicalsSupplement>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<-:InCJKRadicalsSupplement>$/ ), q{Don't match inverted <InCJKRadicalsSupplement>} );
ok(!( "\x[37B4]"  ~~ m/^<:InCJKRadicalsSupplement>$/ ), q{Don't match unrelated <InCJKRadicalsSupplement>} );
#?pugs todo
ok("\x[37B4]"  ~~ m/^<:!InCJKRadicalsSupplement>$/, q{Match unrelated negated <InCJKRadicalsSupplement>} );
#?pugs todo
ok("\x[37B4]"  ~~ m/^<-:InCJKRadicalsSupplement>$/, q{Match unrelated inverted <InCJKRadicalsSupplement>} );
#?pugs todo
ok("\x[37B4]\c[CJK RADICAL REPEAT]" ~~ m/<:InCJKRadicalsSupplement>/, q{Match unanchored <InCJKRadicalsSupplement>} );

# InCJKSymbolsAndPunctuation


#?pugs todo
ok("\c[IDEOGRAPHIC SPACE]" ~~ m/^<:InCJKSymbolsAndPunctuation>$/, q{Match <:InCJKSymbolsAndPunctuation>} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<:!InCJKSymbolsAndPunctuation>$/ ), q{Don't match negated <InCJKSymbolsAndPunctuation>} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<-:InCJKSymbolsAndPunctuation>$/ ), q{Don't match inverted <InCJKSymbolsAndPunctuation>} );
ok(!( "\x[80AA]"  ~~ m/^<:InCJKSymbolsAndPunctuation>$/ ), q{Don't match unrelated <InCJKSymbolsAndPunctuation>} );
#?pugs todo
ok("\x[80AA]"  ~~ m/^<:!InCJKSymbolsAndPunctuation>$/, q{Match unrelated negated <InCJKSymbolsAndPunctuation>} );
#?pugs todo
ok("\x[80AA]"  ~~ m/^<-:InCJKSymbolsAndPunctuation>$/, q{Match unrelated inverted <InCJKSymbolsAndPunctuation>} );
#?pugs todo
ok("\x[80AA]\c[IDEOGRAPHIC SPACE]" ~~ m/<:InCJKSymbolsAndPunctuation>/, q{Match unanchored <InCJKSymbolsAndPunctuation>} );

# InCJKUnifiedIdeographs


#?pugs todo
ok("\x[4E00]" ~~ m/^<:InCJKUnifiedIdeographs>$/, q{Match <:InCJKUnifiedIdeographs>} );
ok(!( "\x[4E00]" ~~ m/^<:!InCJKUnifiedIdeographs>$/ ), q{Don't match negated <InCJKUnifiedIdeographs>} );
ok(!( "\x[4E00]" ~~ m/^<-:InCJKUnifiedIdeographs>$/ ), q{Don't match inverted <InCJKUnifiedIdeographs>} );
ok(!( "\x[3613]"  ~~ m/^<:InCJKUnifiedIdeographs>$/ ), q{Don't match unrelated <InCJKUnifiedIdeographs>} );
#?pugs todo
ok("\x[3613]"  ~~ m/^<:!InCJKUnifiedIdeographs>$/, q{Match unrelated negated <InCJKUnifiedIdeographs>} );
#?pugs todo
ok("\x[3613]"  ~~ m/^<-:InCJKUnifiedIdeographs>$/, q{Match unrelated inverted <InCJKUnifiedIdeographs>} );
#?pugs todo
ok("\x[3613]\x[4E00]" ~~ m/<:InCJKUnifiedIdeographs>/, q{Match unanchored <InCJKUnifiedIdeographs>} );

# InCJKUnifiedIdeographsExtensionA


#?pugs todo
ok("\x[3400]" ~~ m/^<:InCJKUnifiedIdeographsExtensionA>$/, q{Match <:InCJKUnifiedIdeographsExtensionA>} );
ok(!( "\x[3400]" ~~ m/^<:!InCJKUnifiedIdeographsExtensionA>$/ ), q{Don't match negated <InCJKUnifiedIdeographsExtensionA>} );
ok(!( "\x[3400]" ~~ m/^<-:InCJKUnifiedIdeographsExtensionA>$/ ), q{Don't match inverted <InCJKUnifiedIdeographsExtensionA>} );
ok(!( "\c[SQUARE HOORU]"  ~~ m/^<:InCJKUnifiedIdeographsExtensionA>$/ ), q{Don't match unrelated <InCJKUnifiedIdeographsExtensionA>} );
#?pugs todo
ok("\c[SQUARE HOORU]"  ~~ m/^<:!InCJKUnifiedIdeographsExtensionA>$/, q{Match unrelated negated <InCJKUnifiedIdeographsExtensionA>} );
#?pugs todo
ok("\c[SQUARE HOORU]"  ~~ m/^<-:InCJKUnifiedIdeographsExtensionA>$/, q{Match unrelated inverted <InCJKUnifiedIdeographsExtensionA>} );
#?pugs todo
ok("\c[SQUARE HOORU]\x[3400]" ~~ m/<:InCJKUnifiedIdeographsExtensionA>/, q{Match unanchored <InCJKUnifiedIdeographsExtensionA>} );

# InCJKUnifiedIdeographsExtensionB


ok(!( "\x[AC3B]"  ~~ m/^<:InCJKUnifiedIdeographsExtensionB>$/ ), q{Don't match unrelated <InCJKUnifiedIdeographsExtensionB>} );
#?pugs todo
ok("\x[AC3B]"  ~~ m/^<:!InCJKUnifiedIdeographsExtensionB>$/, q{Match unrelated negated <InCJKUnifiedIdeographsExtensionB>} );
#?pugs todo
ok("\x[AC3B]"  ~~ m/^<-:InCJKUnifiedIdeographsExtensionB>$/, q{Match unrelated inverted <InCJKUnifiedIdeographsExtensionB>} );

# InCherokee


#?pugs todo
ok("\c[CHEROKEE LETTER A]" ~~ m/^<:InCherokee>$/, q{Match <:InCherokee>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<:!InCherokee>$/ ), q{Don't match negated <InCherokee>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<-:InCherokee>$/ ), q{Don't match inverted <InCherokee>} );
ok(!( "\x[985F]"  ~~ m/^<:InCherokee>$/ ), q{Don't match unrelated <InCherokee>} );
#?pugs todo
ok("\x[985F]"  ~~ m/^<:!InCherokee>$/, q{Match unrelated negated <InCherokee>} );
#?pugs todo
ok("\x[985F]"  ~~ m/^<-:InCherokee>$/, q{Match unrelated inverted <InCherokee>} );
#?pugs todo
ok("\x[985F]\c[CHEROKEE LETTER A]" ~~ m/<:InCherokee>/, q{Match unanchored <InCherokee>} );

# InCombiningDiacriticalMarks


#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:InCombiningDiacriticalMarks>$/, q{Match <:InCombiningDiacriticalMarks>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!InCombiningDiacriticalMarks>$/ ), q{Don't match negated <InCombiningDiacriticalMarks>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:InCombiningDiacriticalMarks>$/ ), q{Don't match inverted <InCombiningDiacriticalMarks>} );
ok(!( "\x[76DA]"  ~~ m/^<:InCombiningDiacriticalMarks>$/ ), q{Don't match unrelated <InCombiningDiacriticalMarks>} );
#?pugs todo
ok("\x[76DA]"  ~~ m/^<:!InCombiningDiacriticalMarks>$/, q{Match unrelated negated <InCombiningDiacriticalMarks>} );
#?pugs todo
ok("\x[76DA]"  ~~ m/^<-:InCombiningDiacriticalMarks>$/, q{Match unrelated inverted <InCombiningDiacriticalMarks>} );
#?pugs todo
ok("\x[76DA]\c[COMBINING GRAVE ACCENT]" ~~ m/<:InCombiningDiacriticalMarks>/, q{Match unanchored <InCombiningDiacriticalMarks>} );

# InCombiningDiacriticalMarksforSymbols


#?pugs todo
ok("\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/^<:InCombiningDiacriticalMarksforSymbols>$/, q{Match <:InCombiningDiacriticalMarksforSymbols>} );
ok(!( "\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/^<:!InCombiningDiacriticalMarksforSymbols>$/ ), q{Don't match negated <InCombiningDiacriticalMarksforSymbols>} );
ok(!( "\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/^<-:InCombiningDiacriticalMarksforSymbols>$/ ), q{Don't match inverted <InCombiningDiacriticalMarksforSymbols>} );
ok(!( "\x[7345]"  ~~ m/^<:InCombiningDiacriticalMarksforSymbols>$/ ), q{Don't match unrelated <InCombiningDiacriticalMarksforSymbols>} );
#?pugs todo
ok("\x[7345]"  ~~ m/^<:!InCombiningDiacriticalMarksforSymbols>$/, q{Match unrelated negated <InCombiningDiacriticalMarksforSymbols>} );
#?pugs todo
ok("\x[7345]"  ~~ m/^<-:InCombiningDiacriticalMarksforSymbols>$/, q{Match unrelated inverted <InCombiningDiacriticalMarksforSymbols>} );
#?pugs todo
ok("\x[7345]\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/<:InCombiningDiacriticalMarksforSymbols>/, q{Match unanchored <InCombiningDiacriticalMarksforSymbols>} );

# InCombiningHalfMarks


ok(!( "\x[6C2E]"  ~~ m/^<:InCombiningHalfMarks>$/ ), q{Don't match unrelated <InCombiningHalfMarks>} );
#?pugs todo
ok("\x[6C2E]"  ~~ m/^<:!InCombiningHalfMarks>$/, q{Match unrelated negated <InCombiningHalfMarks>} );
#?pugs todo
ok("\x[6C2E]"  ~~ m/^<-:InCombiningHalfMarks>$/, q{Match unrelated inverted <InCombiningHalfMarks>} );

# InControlPictures


#?pugs todo
ok("\c[SYMBOL FOR NULL]" ~~ m/^<:InControlPictures>$/, q{Match <:InControlPictures>} );
ok(!( "\c[SYMBOL FOR NULL]" ~~ m/^<:!InControlPictures>$/ ), q{Don't match negated <InControlPictures>} );
ok(!( "\c[SYMBOL FOR NULL]" ~~ m/^<-:InControlPictures>$/ ), q{Don't match inverted <InControlPictures>} );
ok(!( "\x[BCE2]"  ~~ m/^<:InControlPictures>$/ ), q{Don't match unrelated <InControlPictures>} );
#?pugs todo
ok("\x[BCE2]"  ~~ m/^<:!InControlPictures>$/, q{Match unrelated negated <InControlPictures>} );
#?pugs todo
ok("\x[BCE2]"  ~~ m/^<-:InControlPictures>$/, q{Match unrelated inverted <InControlPictures>} );
#?pugs todo
ok("\x[BCE2]\c[SYMBOL FOR NULL]" ~~ m/<:InControlPictures>/, q{Match unanchored <InControlPictures>} );

# InCurrencySymbols


#?pugs todo
ok("\c[EURO-CURRENCY SIGN]" ~~ m/^<:InCurrencySymbols>$/, q{Match <:InCurrencySymbols>} );
ok(!( "\c[EURO-CURRENCY SIGN]" ~~ m/^<:!InCurrencySymbols>$/ ), q{Don't match negated <InCurrencySymbols>} );
ok(!( "\c[EURO-CURRENCY SIGN]" ~~ m/^<-:InCurrencySymbols>$/ ), q{Don't match inverted <InCurrencySymbols>} );
ok(!( "\x[8596]"  ~~ m/^<:InCurrencySymbols>$/ ), q{Don't match unrelated <InCurrencySymbols>} );
#?pugs todo
ok("\x[8596]"  ~~ m/^<:!InCurrencySymbols>$/, q{Match unrelated negated <InCurrencySymbols>} );
#?pugs todo
ok("\x[8596]"  ~~ m/^<-:InCurrencySymbols>$/, q{Match unrelated inverted <InCurrencySymbols>} );
#?pugs todo
ok("\x[8596]\c[EURO-CURRENCY SIGN]" ~~ m/<:InCurrencySymbols>/, q{Match unanchored <InCurrencySymbols>} );

# InCyrillic


#?pugs todo
ok("\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<:InCyrillic>$/, q{Match <:InCyrillic>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<:!InCyrillic>$/ ), q{Don't match negated <InCyrillic>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<-:InCyrillic>$/ ), q{Don't match inverted <InCyrillic>} );
ok(!( "\x[51B2]"  ~~ m/^<:InCyrillic>$/ ), q{Don't match unrelated <InCyrillic>} );
#?pugs todo
ok("\x[51B2]"  ~~ m/^<:!InCyrillic>$/, q{Match unrelated negated <InCyrillic>} );
#?pugs todo
ok("\x[51B2]"  ~~ m/^<-:InCyrillic>$/, q{Match unrelated inverted <InCyrillic>} );
#?pugs todo
ok("\x[51B2]\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/<:InCyrillic>/, q{Match unanchored <InCyrillic>} );

# InCyrillicSupplementary


#?pugs todo
ok("\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/^<:InCyrillicSupplementary>$/, q{Match <:InCyrillicSupplementary>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/^<:!InCyrillicSupplementary>$/ ), q{Don't match negated <InCyrillicSupplementary>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/^<-:InCyrillicSupplementary>$/ ), q{Don't match inverted <InCyrillicSupplementary>} );
ok(!( "\x[7BD9]"  ~~ m/^<:InCyrillicSupplementary>$/ ), q{Don't match unrelated <InCyrillicSupplementary>} );
#?pugs todo
ok("\x[7BD9]"  ~~ m/^<:!InCyrillicSupplementary>$/, q{Match unrelated negated <InCyrillicSupplementary>} );
#?pugs todo
ok("\x[7BD9]"  ~~ m/^<-:InCyrillicSupplementary>$/, q{Match unrelated inverted <InCyrillicSupplementary>} );
#?pugs todo
ok("\x[7BD9]\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/<:InCyrillicSupplementary>/, q{Match unanchored <InCyrillicSupplementary>} );

# InDeseret


ok(!( "\c[TAMIL DIGIT FOUR]"  ~~ m/^<:InDeseret>$/ ), q{Don't match unrelated <InDeseret>} );
#?pugs todo
ok("\c[TAMIL DIGIT FOUR]"  ~~ m/^<:!InDeseret>$/, q{Match unrelated negated <InDeseret>} );
#?pugs todo
ok("\c[TAMIL DIGIT FOUR]"  ~~ m/^<-:InDeseret>$/, q{Match unrelated inverted <InDeseret>} );

# InDevanagari


#?pugs todo
ok("\x[0900]" ~~ m/^<:InDevanagari>$/, q{Match <:InDevanagari>} );
ok(!( "\x[0900]" ~~ m/^<:!InDevanagari>$/ ), q{Don't match negated <InDevanagari>} );
ok(!( "\x[0900]" ~~ m/^<-:InDevanagari>$/ ), q{Don't match inverted <InDevanagari>} );
ok(!( "\x[BB12]"  ~~ m/^<:InDevanagari>$/ ), q{Don't match unrelated <InDevanagari>} );
#?pugs todo
ok("\x[BB12]"  ~~ m/^<:!InDevanagari>$/, q{Match unrelated negated <InDevanagari>} );
#?pugs todo
ok("\x[BB12]"  ~~ m/^<-:InDevanagari>$/, q{Match unrelated inverted <InDevanagari>} );
#?pugs todo
ok("\x[BB12]\x[0900]" ~~ m/<:InDevanagari>/, q{Match unanchored <InDevanagari>} );

# InDingbats


#?pugs todo
ok("\x[2700]" ~~ m/^<:InDingbats>$/, q{Match <:InDingbats>} );
ok(!( "\x[2700]" ~~ m/^<:!InDingbats>$/ ), q{Don't match negated <InDingbats>} );
ok(!( "\x[2700]" ~~ m/^<-:InDingbats>$/ ), q{Don't match inverted <InDingbats>} );
ok(!( "\x[D7A8]"  ~~ m/^<:InDingbats>$/ ), q{Don't match unrelated <InDingbats>} );
#?pugs todo
ok("\x[D7A8]"  ~~ m/^<:!InDingbats>$/, q{Match unrelated negated <InDingbats>} );
#?pugs todo
ok("\x[D7A8]"  ~~ m/^<-:InDingbats>$/, q{Match unrelated inverted <InDingbats>} );
#?pugs todo
ok("\x[D7A8]\x[2700]" ~~ m/<:InDingbats>/, q{Match unanchored <InDingbats>} );

# InEnclosedAlphanumerics


#?pugs todo
ok("\c[CIRCLED DIGIT ONE]" ~~ m/^<:InEnclosedAlphanumerics>$/, q{Match <:InEnclosedAlphanumerics>} );
ok(!( "\c[CIRCLED DIGIT ONE]" ~~ m/^<:!InEnclosedAlphanumerics>$/ ), q{Don't match negated <InEnclosedAlphanumerics>} );
ok(!( "\c[CIRCLED DIGIT ONE]" ~~ m/^<-:InEnclosedAlphanumerics>$/ ), q{Don't match inverted <InEnclosedAlphanumerics>} );
ok(!( "\x[C3A2]"  ~~ m/^<:InEnclosedAlphanumerics>$/ ), q{Don't match unrelated <InEnclosedAlphanumerics>} );
#?pugs todo
ok("\x[C3A2]"  ~~ m/^<:!InEnclosedAlphanumerics>$/, q{Match unrelated negated <InEnclosedAlphanumerics>} );
#?pugs todo
ok("\x[C3A2]"  ~~ m/^<-:InEnclosedAlphanumerics>$/, q{Match unrelated inverted <InEnclosedAlphanumerics>} );
#?pugs todo
ok("\x[C3A2]\c[CIRCLED DIGIT ONE]" ~~ m/<:InEnclosedAlphanumerics>/, q{Match unanchored <InEnclosedAlphanumerics>} );

# InEnclosedCJKLettersAndMonths


#?pugs todo
ok("\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/^<:InEnclosedCJKLettersAndMonths>$/, q{Match <:InEnclosedCJKLettersAndMonths>} );
ok(!( "\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/^<:!InEnclosedCJKLettersAndMonths>$/ ), q{Don't match negated <InEnclosedCJKLettersAndMonths>} );
ok(!( "\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/^<-:InEnclosedCJKLettersAndMonths>$/ ), q{Don't match inverted <InEnclosedCJKLettersAndMonths>} );
ok(!( "\x[5B44]"  ~~ m/^<:InEnclosedCJKLettersAndMonths>$/ ), q{Don't match unrelated <InEnclosedCJKLettersAndMonths>} );
#?pugs todo
ok("\x[5B44]"  ~~ m/^<:!InEnclosedCJKLettersAndMonths>$/, q{Match unrelated negated <InEnclosedCJKLettersAndMonths>} );
#?pugs todo
ok("\x[5B44]"  ~~ m/^<-:InEnclosedCJKLettersAndMonths>$/, q{Match unrelated inverted <InEnclosedCJKLettersAndMonths>} );
#?pugs todo
ok("\x[5B44]\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/<:InEnclosedCJKLettersAndMonths>/, q{Match unanchored <InEnclosedCJKLettersAndMonths>} );

# InEthiopic


#?pugs todo
ok("\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<:InEthiopic>$/, q{Match <:InEthiopic>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<:!InEthiopic>$/ ), q{Don't match negated <InEthiopic>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<-:InEthiopic>$/ ), q{Don't match inverted <InEthiopic>} );
ok(!( "\x[BBAE]"  ~~ m/^<:InEthiopic>$/ ), q{Don't match unrelated <InEthiopic>} );
#?pugs todo
ok("\x[BBAE]"  ~~ m/^<:!InEthiopic>$/, q{Match unrelated negated <InEthiopic>} );
#?pugs todo
ok("\x[BBAE]"  ~~ m/^<-:InEthiopic>$/, q{Match unrelated inverted <InEthiopic>} );
#?pugs todo
ok("\x[BBAE]\c[ETHIOPIC SYLLABLE HA]" ~~ m/<:InEthiopic>/, q{Match unanchored <InEthiopic>} );

# InGeneralPunctuation


#?pugs todo
ok("\c[EN QUAD]" ~~ m/^<:InGeneralPunctuation>$/, q{Match <:InGeneralPunctuation>} );
ok(!( "\c[EN QUAD]" ~~ m/^<:!InGeneralPunctuation>$/ ), q{Don't match negated <InGeneralPunctuation>} );
ok(!( "\c[EN QUAD]" ~~ m/^<-:InGeneralPunctuation>$/ ), q{Don't match inverted <InGeneralPunctuation>} );
ok(!( "\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]"  ~~ m/^<:InGeneralPunctuation>$/ ), q{Don't match unrelated <InGeneralPunctuation>} );
#?pugs todo
ok("\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]"  ~~ m/^<:!InGeneralPunctuation>$/, q{Match unrelated negated <InGeneralPunctuation>} );
#?pugs todo
ok("\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]"  ~~ m/^<-:InGeneralPunctuation>$/, q{Match unrelated inverted <InGeneralPunctuation>} );
#?pugs todo
ok("\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]\c[EN QUAD]" ~~ m/<:InGeneralPunctuation>/, q{Match unanchored <InGeneralPunctuation>} );

# InGeometricShapes


#?pugs todo
ok("\c[BLACK SQUARE]" ~~ m/^<:InGeometricShapes>$/, q{Match <:InGeometricShapes>} );
ok(!( "\c[BLACK SQUARE]" ~~ m/^<:!InGeometricShapes>$/ ), q{Don't match negated <InGeometricShapes>} );
ok(!( "\c[BLACK SQUARE]" ~~ m/^<-:InGeometricShapes>$/ ), q{Don't match inverted <InGeometricShapes>} );
ok(!( "\x[B700]"  ~~ m/^<:InGeometricShapes>$/ ), q{Don't match unrelated <InGeometricShapes>} );
#?pugs todo
ok("\x[B700]"  ~~ m/^<:!InGeometricShapes>$/, q{Match unrelated negated <InGeometricShapes>} );
#?pugs todo
ok("\x[B700]"  ~~ m/^<-:InGeometricShapes>$/, q{Match unrelated inverted <InGeometricShapes>} );
#?pugs todo
ok("\x[B700]\c[BLACK SQUARE]" ~~ m/<:InGeometricShapes>/, q{Match unanchored <InGeometricShapes>} );


# InGeorgian


#?pugs todo
ok("\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<:InGeorgian>$/, q{Match <:InGeorgian>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<:!InGeorgian>$/ ), q{Don't match negated <InGeorgian>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<-:InGeorgian>$/ ), q{Don't match inverted <InGeorgian>} );
ok(!( "\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]"  ~~ m/^<:InGeorgian>$/ ), q{Don't match unrelated <InGeorgian>} );
#?pugs todo
ok("\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]"  ~~ m/^<:!InGeorgian>$/, q{Match unrelated negated <InGeorgian>} );
#?pugs todo
ok("\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]"  ~~ m/^<-:InGeorgian>$/, q{Match unrelated inverted <InGeorgian>} );
#?pugs todo
ok("\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/<:InGeorgian>/, q{Match unanchored <InGeorgian>} );

# InGothic


ok(!( "\x[4825]"  ~~ m/^<:InGothic>$/ ), q{Don't match unrelated <InGothic>} );
#?pugs todo
ok("\x[4825]"  ~~ m/^<:!InGothic>$/, q{Match unrelated negated <InGothic>} );
#?pugs todo
ok("\x[4825]"  ~~ m/^<-:InGothic>$/, q{Match unrelated inverted <InGothic>} );

# InGreekExtended


#?pugs todo
ok("\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/^<:InGreekExtended>$/, q{Match <:InGreekExtended>} );
ok(!( "\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/^<:!InGreekExtended>$/ ), q{Don't match negated <InGreekExtended>} );
ok(!( "\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/^<-:InGreekExtended>$/ ), q{Don't match inverted <InGreekExtended>} );
ok(!( "\x[B9B7]"  ~~ m/^<:InGreekExtended>$/ ), q{Don't match unrelated <InGreekExtended>} );
#?pugs todo
ok("\x[B9B7]"  ~~ m/^<:!InGreekExtended>$/, q{Match unrelated negated <InGreekExtended>} );
#?pugs todo
ok("\x[B9B7]"  ~~ m/^<-:InGreekExtended>$/, q{Match unrelated inverted <InGreekExtended>} );
#?pugs todo
ok("\x[B9B7]\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/<:InGreekExtended>/, q{Match unanchored <InGreekExtended>} );

# InGreekAndCoptic


#?pugs todo
ok("\x[0370]" ~~ m/^<:InGreekAndCoptic>$/, q{Match <:InGreekAndCoptic>} );
ok(!( "\x[0370]" ~~ m/^<:!InGreekAndCoptic>$/ ), q{Don't match negated <InGreekAndCoptic>} );
ok(!( "\x[0370]" ~~ m/^<-:InGreekAndCoptic>$/ ), q{Don't match inverted <InGreekAndCoptic>} );
ok(!( "\x[7197]"  ~~ m/^<:InGreekAndCoptic>$/ ), q{Don't match unrelated <InGreekAndCoptic>} );
#?pugs todo
ok("\x[7197]"  ~~ m/^<:!InGreekAndCoptic>$/, q{Match unrelated negated <InGreekAndCoptic>} );
#?pugs todo
ok("\x[7197]"  ~~ m/^<-:InGreekAndCoptic>$/, q{Match unrelated inverted <InGreekAndCoptic>} );
#?pugs todo
ok("\x[7197]\x[0370]" ~~ m/<:InGreekAndCoptic>/, q{Match unanchored <InGreekAndCoptic>} );

# InGujarati


#?pugs todo
ok("\x[0A80]" ~~ m/^<:InGujarati>$/, q{Match <:InGujarati>} );
ok(!( "\x[0A80]" ~~ m/^<:!InGujarati>$/ ), q{Don't match negated <InGujarati>} );
ok(!( "\x[0A80]" ~~ m/^<-:InGujarati>$/ ), q{Don't match inverted <InGujarati>} );
ok(!( "\x[3B63]"  ~~ m/^<:InGujarati>$/ ), q{Don't match unrelated <InGujarati>} );
#?pugs todo
ok("\x[3B63]"  ~~ m/^<:!InGujarati>$/, q{Match unrelated negated <InGujarati>} );
#?pugs todo
ok("\x[3B63]"  ~~ m/^<-:InGujarati>$/, q{Match unrelated inverted <InGujarati>} );
#?pugs todo
ok("\x[3B63]\x[0A80]" ~~ m/<:InGujarati>/, q{Match unanchored <InGujarati>} );

# InGurmukhi


#?pugs todo
ok("\x[0A00]" ~~ m/^<:InGurmukhi>$/, q{Match <:InGurmukhi>} );
ok(!( "\x[0A00]" ~~ m/^<:!InGurmukhi>$/ ), q{Don't match negated <InGurmukhi>} );
ok(!( "\x[0A00]" ~~ m/^<-:InGurmukhi>$/ ), q{Don't match inverted <InGurmukhi>} );
ok(!( "\x[10C8]"  ~~ m/^<:InGurmukhi>$/ ), q{Don't match unrelated <InGurmukhi>} );
#?pugs todo
ok("\x[10C8]"  ~~ m/^<:!InGurmukhi>$/, q{Match unrelated negated <InGurmukhi>} );
#?pugs todo
ok("\x[10C8]"  ~~ m/^<-:InGurmukhi>$/, q{Match unrelated inverted <InGurmukhi>} );
#?pugs todo
ok("\x[10C8]\x[0A00]" ~~ m/<:InGurmukhi>/, q{Match unanchored <InGurmukhi>} );

# InHalfwidthAndFullwidthForms


ok(!( "\x[CA55]"  ~~ m/^<:InHalfwidthAndFullwidthForms>$/ ), q{Don't match unrelated <InHalfwidthAndFullwidthForms>} );
#?pugs todo
ok("\x[CA55]"  ~~ m/^<:!InHalfwidthAndFullwidthForms>$/, q{Match unrelated negated <InHalfwidthAndFullwidthForms>} );
#?pugs todo
ok("\x[CA55]"  ~~ m/^<-:InHalfwidthAndFullwidthForms>$/, q{Match unrelated inverted <InHalfwidthAndFullwidthForms>} );

# InHangulCompatibilityJamo


#?pugs todo
ok("\x[3130]" ~~ m/^<:InHangulCompatibilityJamo>$/, q{Match <:InHangulCompatibilityJamo>} );
ok(!( "\x[3130]" ~~ m/^<:!InHangulCompatibilityJamo>$/ ), q{Don't match negated <InHangulCompatibilityJamo>} );
ok(!( "\x[3130]" ~~ m/^<-:InHangulCompatibilityJamo>$/ ), q{Don't match inverted <InHangulCompatibilityJamo>} );
ok(!( "\c[MEASURED BY]"  ~~ m/^<:InHangulCompatibilityJamo>$/ ), q{Don't match unrelated <InHangulCompatibilityJamo>} );
#?pugs todo
ok("\c[MEASURED BY]"  ~~ m/^<:!InHangulCompatibilityJamo>$/, q{Match unrelated negated <InHangulCompatibilityJamo>} );
#?pugs todo
ok("\c[MEASURED BY]"  ~~ m/^<-:InHangulCompatibilityJamo>$/, q{Match unrelated inverted <InHangulCompatibilityJamo>} );
#?pugs todo
ok("\c[MEASURED BY]\x[3130]" ~~ m/<:InHangulCompatibilityJamo>/, q{Match unanchored <InHangulCompatibilityJamo>} );

# InHangulJamo


#?pugs todo
ok("\c[HANGUL CHOSEONG KIYEOK]" ~~ m/^<:InHangulJamo>$/, q{Match <:InHangulJamo>} );
ok(!( "\c[HANGUL CHOSEONG KIYEOK]" ~~ m/^<:!InHangulJamo>$/ ), q{Don't match negated <InHangulJamo>} );
ok(!( "\c[HANGUL CHOSEONG KIYEOK]" ~~ m/^<-:InHangulJamo>$/ ), q{Don't match inverted <InHangulJamo>} );
ok(!( "\x[3B72]"  ~~ m/^<:InHangulJamo>$/ ), q{Don't match unrelated <InHangulJamo>} );
#?pugs todo
ok("\x[3B72]"  ~~ m/^<:!InHangulJamo>$/, q{Match unrelated negated <InHangulJamo>} );
#?pugs todo
ok("\x[3B72]"  ~~ m/^<-:InHangulJamo>$/, q{Match unrelated inverted <InHangulJamo>} );
#?pugs todo
ok("\x[3B72]\c[HANGUL CHOSEONG KIYEOK]" ~~ m/<:InHangulJamo>/, q{Match unanchored <InHangulJamo>} );

# InHangulSyllables


#?pugs todo
ok("\x[CD95]" ~~ m/^<:InHangulSyllables>$/, q{Match <:InHangulSyllables>} );
ok(!( "\x[CD95]" ~~ m/^<:!InHangulSyllables>$/ ), q{Don't match negated <InHangulSyllables>} );
ok(!( "\x[CD95]" ~~ m/^<-:InHangulSyllables>$/ ), q{Don't match inverted <InHangulSyllables>} );
ok(!( "\x[D7B0]"  ~~ m/^<:InHangulSyllables>$/ ), q{Don't match unrelated <InHangulSyllables>} );
#?pugs todo
ok("\x[D7B0]"  ~~ m/^<:!InHangulSyllables>$/, q{Match unrelated negated <InHangulSyllables>} );
#?pugs todo
ok("\x[D7B0]"  ~~ m/^<-:InHangulSyllables>$/, q{Match unrelated inverted <InHangulSyllables>} );
#?pugs todo
ok("\x[D7B0]\x[CD95]" ~~ m/<:InHangulSyllables>/, q{Match unanchored <InHangulSyllables>} );

# InHanunoo


#?pugs todo
ok("\c[HANUNOO LETTER A]" ~~ m/^<:InHanunoo>$/, q{Match <:InHanunoo>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<:!InHanunoo>$/ ), q{Don't match negated <InHanunoo>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<-:InHanunoo>$/ ), q{Don't match inverted <InHanunoo>} );
ok(!( "\x[6F4F]"  ~~ m/^<:InHanunoo>$/ ), q{Don't match unrelated <InHanunoo>} );
#?pugs todo
ok("\x[6F4F]"  ~~ m/^<:!InHanunoo>$/, q{Match unrelated negated <InHanunoo>} );
#?pugs todo
ok("\x[6F4F]"  ~~ m/^<-:InHanunoo>$/, q{Match unrelated inverted <InHanunoo>} );
#?pugs todo
ok("\x[6F4F]\c[HANUNOO LETTER A]" ~~ m/<:InHanunoo>/, q{Match unanchored <InHanunoo>} );

# InHebrew


#?pugs todo
ok("\x[0590]" ~~ m/^<:InHebrew>$/, q{Match <:InHebrew>} );
ok(!( "\x[0590]" ~~ m/^<:!InHebrew>$/ ), q{Don't match negated <InHebrew>} );
ok(!( "\x[0590]" ~~ m/^<-:InHebrew>$/ ), q{Don't match inverted <InHebrew>} );
ok(!( "\x[0777]"  ~~ m/^<:InHebrew>$/ ), q{Don't match unrelated <InHebrew>} );
#?pugs todo
ok("\x[0777]"  ~~ m/^<:!InHebrew>$/, q{Match unrelated negated <InHebrew>} );
#?pugs todo
ok("\x[0777]"  ~~ m/^<-:InHebrew>$/, q{Match unrelated inverted <InHebrew>} );
#?pugs todo
ok("\x[0777]\x[0590]" ~~ m/<:InHebrew>/, q{Match unanchored <InHebrew>} );

# InHighPrivateUseSurrogates


ok(!( "\x[D04F]"  ~~ m/^<:InHighPrivateUseSurrogates>$/ ), q{Don't match unrelated <InHighPrivateUseSurrogates>} );
#?pugs todo
ok("\x[D04F]"  ~~ m/^<:!InHighPrivateUseSurrogates>$/, q{Match unrelated negated <InHighPrivateUseSurrogates>} );
#?pugs todo
ok("\x[D04F]"  ~~ m/^<-:InHighPrivateUseSurrogates>$/, q{Match unrelated inverted <InHighPrivateUseSurrogates>} );

# InHighSurrogates


ok(!( "\x[D085]"  ~~ m/^<:InHighSurrogates>$/ ), q{Don't match unrelated <InHighSurrogates>} );
#?pugs todo
ok("\x[D085]"  ~~ m/^<:!InHighSurrogates>$/, q{Match unrelated negated <InHighSurrogates>} );
#?pugs todo
ok("\x[D085]"  ~~ m/^<-:InHighSurrogates>$/, q{Match unrelated inverted <InHighSurrogates>} );

# InHiragana


#?pugs todo
ok("\x[3040]" ~~ m/^<:InHiragana>$/, q{Match <:InHiragana>} );
ok(!( "\x[3040]" ~~ m/^<:!InHiragana>$/ ), q{Don't match negated <InHiragana>} );
ok(!( "\x[3040]" ~~ m/^<-:InHiragana>$/ ), q{Don't match inverted <InHiragana>} );
ok(!( "\x[AC7C]"  ~~ m/^<:InHiragana>$/ ), q{Don't match unrelated <InHiragana>} );
#?pugs todo
ok("\x[AC7C]"  ~~ m/^<:!InHiragana>$/, q{Match unrelated negated <InHiragana>} );
#?pugs todo
ok("\x[AC7C]"  ~~ m/^<-:InHiragana>$/, q{Match unrelated inverted <InHiragana>} );
#?pugs todo
ok("\x[AC7C]\x[3040]" ~~ m/<:InHiragana>/, q{Match unanchored <InHiragana>} );

# InIPAExtensions


#?pugs todo
ok("\c[LATIN SMALL LETTER TURNED A]" ~~ m/^<:InIPAExtensions>$/, q{Match <:InIPAExtensions>} );
ok(!( "\c[LATIN SMALL LETTER TURNED A]" ~~ m/^<:!InIPAExtensions>$/ ), q{Don't match negated <InIPAExtensions>} );
ok(!( "\c[LATIN SMALL LETTER TURNED A]" ~~ m/^<-:InIPAExtensions>$/ ), q{Don't match inverted <InIPAExtensions>} );
ok(!( "\c[HANGUL LETTER SSANGIEUNG]"  ~~ m/^<:InIPAExtensions>$/ ), q{Don't match unrelated <InIPAExtensions>} );
#?pugs todo
ok("\c[HANGUL LETTER SSANGIEUNG]"  ~~ m/^<:!InIPAExtensions>$/, q{Match unrelated negated <InIPAExtensions>} );
#?pugs todo
ok("\c[HANGUL LETTER SSANGIEUNG]"  ~~ m/^<-:InIPAExtensions>$/, q{Match unrelated inverted <InIPAExtensions>} );
#?pugs todo
ok("\c[HANGUL LETTER SSANGIEUNG]\c[LATIN SMALL LETTER TURNED A]" ~~ m/<:InIPAExtensions>/, q{Match unanchored <InIPAExtensions>} );

# InIdeographicDescriptionCharacters


#?pugs todo
ok("\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<:InIdeographicDescriptionCharacters>$/, q{Match <:InIdeographicDescriptionCharacters>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<:!InIdeographicDescriptionCharacters>$/ ), q{Don't match negated <InIdeographicDescriptionCharacters>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<-:InIdeographicDescriptionCharacters>$/ ), q{Don't match inverted <InIdeographicDescriptionCharacters>} );
ok(!( "\x[9160]"  ~~ m/^<:InIdeographicDescriptionCharacters>$/ ), q{Don't match unrelated <InIdeographicDescriptionCharacters>} );
#?pugs todo
ok("\x[9160]"  ~~ m/^<:!InIdeographicDescriptionCharacters>$/, q{Match unrelated negated <InIdeographicDescriptionCharacters>} );
#?pugs todo
ok("\x[9160]"  ~~ m/^<-:InIdeographicDescriptionCharacters>$/, q{Match unrelated inverted <InIdeographicDescriptionCharacters>} );
#?pugs todo
ok("\x[9160]\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/<:InIdeographicDescriptionCharacters>/, q{Match unanchored <InIdeographicDescriptionCharacters>} );

# InKanbun


#?pugs todo
ok("\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/^<:InKanbun>$/, q{Match <:InKanbun>} );
ok(!( "\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/^<:!InKanbun>$/ ), q{Don't match negated <InKanbun>} );
ok(!( "\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/^<-:InKanbun>$/ ), q{Don't match inverted <InKanbun>} );
ok(!( "\x[A80C]"  ~~ m/^<:InKanbun>$/ ), q{Don't match unrelated <InKanbun>} );
#?pugs todo
ok("\x[A80C]"  ~~ m/^<:!InKanbun>$/, q{Match unrelated negated <InKanbun>} );
#?pugs todo
ok("\x[A80C]"  ~~ m/^<-:InKanbun>$/, q{Match unrelated inverted <InKanbun>} );
#?pugs todo
ok("\x[A80C]\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/<:InKanbun>/, q{Match unanchored <InKanbun>} );

# InKangxiRadicals


#?pugs todo
ok("\c[KANGXI RADICAL ONE]" ~~ m/^<:InKangxiRadicals>$/, q{Match <:InKangxiRadicals>} );
ok(!( "\c[KANGXI RADICAL ONE]" ~~ m/^<:!InKangxiRadicals>$/ ), q{Don't match negated <InKangxiRadicals>} );
ok(!( "\c[KANGXI RADICAL ONE]" ~~ m/^<-:InKangxiRadicals>$/ ), q{Don't match inverted <InKangxiRadicals>} );
ok(!( "\x[891A]"  ~~ m/^<:InKangxiRadicals>$/ ), q{Don't match unrelated <InKangxiRadicals>} );
#?pugs todo
ok("\x[891A]"  ~~ m/^<:!InKangxiRadicals>$/, q{Match unrelated negated <InKangxiRadicals>} );
#?pugs todo
ok("\x[891A]"  ~~ m/^<-:InKangxiRadicals>$/, q{Match unrelated inverted <InKangxiRadicals>} );
#?pugs todo
ok("\x[891A]\c[KANGXI RADICAL ONE]" ~~ m/<:InKangxiRadicals>/, q{Match unanchored <InKangxiRadicals>} );

# InKannada


#?pugs todo
ok("\x[0C80]" ~~ m/^<:InKannada>$/, q{Match <:InKannada>} );
ok(!( "\x[0C80]" ~~ m/^<:!InKannada>$/ ), q{Don't match negated <InKannada>} );
ok(!( "\x[0C80]" ~~ m/^<-:InKannada>$/ ), q{Don't match inverted <InKannada>} );
ok(!( "\x[B614]"  ~~ m/^<:InKannada>$/ ), q{Don't match unrelated <InKannada>} );
#?pugs todo
ok("\x[B614]"  ~~ m/^<:!InKannada>$/, q{Match unrelated negated <InKannada>} );
#?pugs todo
ok("\x[B614]"  ~~ m/^<-:InKannada>$/, q{Match unrelated inverted <InKannada>} );
#?pugs todo
ok("\x[B614]\x[0C80]" ~~ m/<:InKannada>/, q{Match unanchored <InKannada>} );

# InKatakana


#?pugs todo
ok("\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/^<:InKatakana>$/, q{Match <:InKatakana>} );
ok(!( "\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/^<:!InKatakana>$/ ), q{Don't match negated <InKatakana>} );
ok(!( "\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/^<-:InKatakana>$/ ), q{Don't match inverted <InKatakana>} );
ok(!( "\x[7EB8]"  ~~ m/^<:InKatakana>$/ ), q{Don't match unrelated <InKatakana>} );
#?pugs todo
ok("\x[7EB8]"  ~~ m/^<:!InKatakana>$/, q{Match unrelated negated <InKatakana>} );
#?pugs todo
ok("\x[7EB8]"  ~~ m/^<-:InKatakana>$/, q{Match unrelated inverted <InKatakana>} );
#?pugs todo
ok("\x[7EB8]\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/<:InKatakana>/, q{Match unanchored <InKatakana>} );

# InKatakanaPhoneticExtensions


#?pugs todo
ok("\c[KATAKANA LETTER SMALL KU]" ~~ m/^<:InKatakanaPhoneticExtensions>$/, q{Match <:InKatakanaPhoneticExtensions>} );
ok(!( "\c[KATAKANA LETTER SMALL KU]" ~~ m/^<:!InKatakanaPhoneticExtensions>$/ ), q{Don't match negated <InKatakanaPhoneticExtensions>} );
ok(!( "\c[KATAKANA LETTER SMALL KU]" ~~ m/^<-:InKatakanaPhoneticExtensions>$/ ), q{Don't match inverted <InKatakanaPhoneticExtensions>} );
ok(!( "\x[97C2]"  ~~ m/^<:InKatakanaPhoneticExtensions>$/ ), q{Don't match unrelated <InKatakanaPhoneticExtensions>} );
#?pugs todo
ok("\x[97C2]"  ~~ m/^<:!InKatakanaPhoneticExtensions>$/, q{Match unrelated negated <InKatakanaPhoneticExtensions>} );
#?pugs todo
ok("\x[97C2]"  ~~ m/^<-:InKatakanaPhoneticExtensions>$/, q{Match unrelated inverted <InKatakanaPhoneticExtensions>} );
#?pugs todo
ok("\x[97C2]\c[KATAKANA LETTER SMALL KU]" ~~ m/<:InKatakanaPhoneticExtensions>/, q{Match unanchored <InKatakanaPhoneticExtensions>} );

# InKhmer

#?pugs todo
ok("\c[KHMER LETTER KA]" ~~ m/^<:InKhmer>$/, q{Match <:InKhmer>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<:!InKhmer>$/ ), q{Don't match negated <InKhmer>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<-:InKhmer>$/ ), q{Don't match inverted <InKhmer>} );
ok(!( "\x[CAFA]"  ~~ m/^<:InKhmer>$/ ), q{Don't match unrelated <InKhmer>} );
#?pugs todo
ok("\x[CAFA]"  ~~ m/^<:!InKhmer>$/, q{Match unrelated negated <InKhmer>} );
#?pugs todo
ok("\x[CAFA]"  ~~ m/^<-:InKhmer>$/, q{Match unrelated inverted <InKhmer>} );
#?pugs todo
ok("\x[CAFA]\c[KHMER LETTER KA]" ~~ m/<:InKhmer>/, q{Match unanchored <InKhmer>} );

# InLao


#?pugs todo
ok("\x[0E80]" ~~ m/^<:InLao>$/, q{Match <:InLao>} );
ok(!( "\x[0E80]" ~~ m/^<:!InLao>$/ ), q{Don't match negated <InLao>} );
ok(!( "\x[0E80]" ~~ m/^<-:InLao>$/ ), q{Don't match inverted <InLao>} );
ok(!( "\x[07BF]"  ~~ m/^<:InLao>$/ ), q{Don't match unrelated <InLao>} );
#?pugs todo
ok("\x[07BF]"  ~~ m/^<:!InLao>$/, q{Match unrelated negated <InLao>} );
#?pugs todo
ok("\x[07BF]"  ~~ m/^<-:InLao>$/, q{Match unrelated inverted <InLao>} );
#?pugs todo
ok("\x[07BF]\x[0E80]" ~~ m/<:InLao>/, q{Match unanchored <InLao>} );

# InLatin1Supplement


#?pugs todo
ok("\x[0080]" ~~ m/^<:InLatin1Supplement>$/, q{Match <:InLatin1Supplement>} );
ok(!( "\x[0080]" ~~ m/^<:!InLatin1Supplement>$/ ), q{Don't match negated <InLatin1Supplement>} );
ok(!( "\x[0080]" ~~ m/^<-:InLatin1Supplement>$/ ), q{Don't match inverted <InLatin1Supplement>} );
ok(!( "\x[D062]"  ~~ m/^<:InLatin1Supplement>$/ ), q{Don't match unrelated <InLatin1Supplement>} );
#?pugs todo
ok("\x[D062]"  ~~ m/^<:!InLatin1Supplement>$/, q{Match unrelated negated <InLatin1Supplement>} );
#?pugs todo
ok("\x[D062]"  ~~ m/^<-:InLatin1Supplement>$/, q{Match unrelated inverted <InLatin1Supplement>} );
#?rakudo skip "Malformed UTF-8 string"
#?pugs todo
ok("\x[D062]\x[0080]" ~~ m/<:InLatin1Supplement>/, q{Match unanchored <InLatin1Supplement>} );

# InLatinExtendedA


#?pugs todo
ok("\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/^<:InLatinExtendedA>$/, q{Match <:InLatinExtendedA>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/^<:!InLatinExtendedA>$/ ), q{Don't match negated <InLatinExtendedA>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/^<-:InLatinExtendedA>$/ ), q{Don't match inverted <InLatinExtendedA>} );
ok(!( "\c[IDEOGRAPHIC ANNOTATION EARTH MARK]"  ~~ m/^<:InLatinExtendedA>$/ ), q{Don't match unrelated <InLatinExtendedA>} );
#?pugs todo
ok("\c[IDEOGRAPHIC ANNOTATION EARTH MARK]"  ~~ m/^<:!InLatinExtendedA>$/, q{Match unrelated negated <InLatinExtendedA>} );
#?pugs todo
ok("\c[IDEOGRAPHIC ANNOTATION EARTH MARK]"  ~~ m/^<-:InLatinExtendedA>$/, q{Match unrelated inverted <InLatinExtendedA>} );
#?pugs todo
ok("\c[IDEOGRAPHIC ANNOTATION EARTH MARK]\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/<:InLatinExtendedA>/, q{Match unanchored <InLatinExtendedA>} );

# InLatinExtendedAdditional


#?pugs todo
ok("\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/^<:InLatinExtendedAdditional>$/, q{Match <:InLatinExtendedAdditional>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/^<:!InLatinExtendedAdditional>$/ ), q{Don't match negated <InLatinExtendedAdditional>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/^<-:InLatinExtendedAdditional>$/ ), q{Don't match inverted <InLatinExtendedAdditional>} );
ok(!( "\x[9A44]"  ~~ m/^<:InLatinExtendedAdditional>$/ ), q{Don't match unrelated <InLatinExtendedAdditional>} );
#?pugs todo
ok("\x[9A44]"  ~~ m/^<:!InLatinExtendedAdditional>$/, q{Match unrelated negated <InLatinExtendedAdditional>} );
#?pugs todo
ok("\x[9A44]"  ~~ m/^<-:InLatinExtendedAdditional>$/, q{Match unrelated inverted <InLatinExtendedAdditional>} );
#?pugs todo
ok("\x[9A44]\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/<:InLatinExtendedAdditional>/, q{Match unanchored <InLatinExtendedAdditional>} );

# InLatinExtendedB


#?pugs todo
ok("\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/^<:InLatinExtendedB>$/, q{Match <:InLatinExtendedB>} );
ok(!( "\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/^<:!InLatinExtendedB>$/ ), q{Don't match negated <InLatinExtendedB>} );
ok(!( "\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/^<-:InLatinExtendedB>$/ ), q{Don't match inverted <InLatinExtendedB>} );
ok(!( "\x[7544]"  ~~ m/^<:InLatinExtendedB>$/ ), q{Don't match unrelated <InLatinExtendedB>} );
#?pugs todo
ok("\x[7544]"  ~~ m/^<:!InLatinExtendedB>$/, q{Match unrelated negated <InLatinExtendedB>} );
#?pugs todo
ok("\x[7544]"  ~~ m/^<-:InLatinExtendedB>$/, q{Match unrelated inverted <InLatinExtendedB>} );
#?pugs todo
ok("\x[7544]\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/<:InLatinExtendedB>/, q{Match unanchored <InLatinExtendedB>} );

# InLetterlikeSymbols


#?pugs todo
ok("\c[ACCOUNT OF]" ~~ m/^<:InLetterlikeSymbols>$/, q{Match <:InLetterlikeSymbols>} );
ok(!( "\c[ACCOUNT OF]" ~~ m/^<:!InLetterlikeSymbols>$/ ), q{Don't match negated <InLetterlikeSymbols>} );
ok(!( "\c[ACCOUNT OF]" ~~ m/^<-:InLetterlikeSymbols>$/ ), q{Don't match inverted <InLetterlikeSymbols>} );
ok(!( "\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]"  ~~ m/^<:InLetterlikeSymbols>$/ ), q{Don't match unrelated <InLetterlikeSymbols>} );
#?pugs todo
ok("\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]"  ~~ m/^<:!InLetterlikeSymbols>$/, q{Match unrelated negated <InLetterlikeSymbols>} );
#?pugs todo
ok("\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]"  ~~ m/^<-:InLetterlikeSymbols>$/, q{Match unrelated inverted <InLetterlikeSymbols>} );
#?pugs todo
ok("\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]\c[ACCOUNT OF]" ~~ m/<:InLetterlikeSymbols>/, q{Match unanchored <InLetterlikeSymbols>} );

# InLowSurrogates


ok(!( "\x[5ECC]"  ~~ m/^<:InLowSurrogates>$/ ), q{Don't match unrelated <InLowSurrogates>} );
#?pugs todo
ok("\x[5ECC]"  ~~ m/^<:!InLowSurrogates>$/, q{Match unrelated negated <InLowSurrogates>} );
#?pugs todo
ok("\x[5ECC]"  ~~ m/^<-:InLowSurrogates>$/, q{Match unrelated inverted <InLowSurrogates>} );

# InMalayalam


#?pugs todo
ok("\x[0D00]" ~~ m/^<:InMalayalam>$/, q{Match <:InMalayalam>} );
ok(!( "\x[0D00]" ~~ m/^<:!InMalayalam>$/ ), q{Don't match negated <InMalayalam>} );
ok(!( "\x[0D00]" ~~ m/^<-:InMalayalam>$/ ), q{Don't match inverted <InMalayalam>} );
ok(!( "\x[3457]"  ~~ m/^<:InMalayalam>$/ ), q{Don't match unrelated <InMalayalam>} );
#?pugs todo
ok("\x[3457]"  ~~ m/^<:!InMalayalam>$/, q{Match unrelated negated <InMalayalam>} );
#?pugs todo
ok("\x[3457]"  ~~ m/^<-:InMalayalam>$/, q{Match unrelated inverted <InMalayalam>} );
#?pugs todo
ok("\x[3457]\x[0D00]" ~~ m/<:InMalayalam>/, q{Match unanchored <InMalayalam>} );

# InMathematicalAlphanumericSymbols


ok(!( "\x[6B79]"  ~~ m/^<:InMathematicalAlphanumericSymbols>$/ ), q{Don't match unrelated <InMathematicalAlphanumericSymbols>} );
#?pugs todo
ok("\x[6B79]"  ~~ m/^<:!InMathematicalAlphanumericSymbols>$/, q{Match unrelated negated <InMathematicalAlphanumericSymbols>} );
#?pugs todo
ok("\x[6B79]"  ~~ m/^<-:InMathematicalAlphanumericSymbols>$/, q{Match unrelated inverted <InMathematicalAlphanumericSymbols>} );

# InMathematicalOperators


#?pugs todo
ok("\c[FOR ALL]" ~~ m/^<:InMathematicalOperators>$/, q{Match <:InMathematicalOperators>} );
ok(!( "\c[FOR ALL]" ~~ m/^<:!InMathematicalOperators>$/ ), q{Don't match negated <InMathematicalOperators>} );
ok(!( "\c[FOR ALL]" ~~ m/^<-:InMathematicalOperators>$/ ), q{Don't match inverted <InMathematicalOperators>} );
ok(!( "\x[BBC6]"  ~~ m/^<:InMathematicalOperators>$/ ), q{Don't match unrelated <InMathematicalOperators>} );
#?pugs todo
ok("\x[BBC6]"  ~~ m/^<:!InMathematicalOperators>$/, q{Match unrelated negated <InMathematicalOperators>} );
#?pugs todo
ok("\x[BBC6]"  ~~ m/^<-:InMathematicalOperators>$/, q{Match unrelated inverted <InMathematicalOperators>} );
#?pugs todo
ok("\x[BBC6]\c[FOR ALL]" ~~ m/<:InMathematicalOperators>/, q{Match unanchored <InMathematicalOperators>} );

# InMiscellaneousMathematicalSymbolsA


#?pugs todo
ok("\x[27C0]" ~~ m/^<:InMiscellaneousMathematicalSymbolsA>$/, q{Match <:InMiscellaneousMathematicalSymbolsA>} );
ok(!( "\x[27C0]" ~~ m/^<:!InMiscellaneousMathematicalSymbolsA>$/ ), q{Don't match negated <InMiscellaneousMathematicalSymbolsA>} );
ok(!( "\x[27C0]" ~~ m/^<-:InMiscellaneousMathematicalSymbolsA>$/ ), q{Don't match inverted <InMiscellaneousMathematicalSymbolsA>} );
ok(!( "\x[065D]"  ~~ m/^<:InMiscellaneousMathematicalSymbolsA>$/ ), q{Don't match unrelated <InMiscellaneousMathematicalSymbolsA>} );
#?pugs todo
ok("\x[065D]"  ~~ m/^<:!InMiscellaneousMathematicalSymbolsA>$/, q{Match unrelated negated <InMiscellaneousMathematicalSymbolsA>} );
#?pugs todo
ok("\x[065D]"  ~~ m/^<-:InMiscellaneousMathematicalSymbolsA>$/, q{Match unrelated inverted <InMiscellaneousMathematicalSymbolsA>} );
#?pugs todo
ok("\x[065D]\x[27C0]" ~~ m/<:InMiscellaneousMathematicalSymbolsA>/, q{Match unanchored <InMiscellaneousMathematicalSymbolsA>} );

# InMiscellaneousMathematicalSymbolsB


#?pugs todo
ok("\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/^<:InMiscellaneousMathematicalSymbolsB>$/, q{Match <:InMiscellaneousMathematicalSymbolsB>} );
ok(!( "\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/^<:!InMiscellaneousMathematicalSymbolsB>$/ ), q{Don't match negated <InMiscellaneousMathematicalSymbolsB>} );
ok(!( "\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/^<-:InMiscellaneousMathematicalSymbolsB>$/ ), q{Don't match inverted <InMiscellaneousMathematicalSymbolsB>} );
ok(!( "\x[56A6]"  ~~ m/^<:InMiscellaneousMathematicalSymbolsB>$/ ), q{Don't match unrelated <InMiscellaneousMathematicalSymbolsB>} );
#?pugs todo
ok("\x[56A6]"  ~~ m/^<:!InMiscellaneousMathematicalSymbolsB>$/, q{Match unrelated negated <InMiscellaneousMathematicalSymbolsB>} );
#?pugs todo
ok("\x[56A6]"  ~~ m/^<-:InMiscellaneousMathematicalSymbolsB>$/, q{Match unrelated inverted <InMiscellaneousMathematicalSymbolsB>} );
#?pugs todo
ok("\x[56A6]\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/<:InMiscellaneousMathematicalSymbolsB>/, q{Match unanchored <InMiscellaneousMathematicalSymbolsB>} );

# InMiscellaneousSymbols


#?pugs todo
ok("\c[BLACK SUN WITH RAYS]" ~~ m/^<:InMiscellaneousSymbols>$/, q{Match <:InMiscellaneousSymbols>} );
ok(!( "\c[BLACK SUN WITH RAYS]" ~~ m/^<:!InMiscellaneousSymbols>$/ ), q{Don't match negated <InMiscellaneousSymbols>} );
ok(!( "\c[BLACK SUN WITH RAYS]" ~~ m/^<-:InMiscellaneousSymbols>$/ ), q{Don't match inverted <InMiscellaneousSymbols>} );
ok(!( "\x[3EE7]"  ~~ m/^<:InMiscellaneousSymbols>$/ ), q{Don't match unrelated <InMiscellaneousSymbols>} );
#?pugs todo
ok("\x[3EE7]"  ~~ m/^<:!InMiscellaneousSymbols>$/, q{Match unrelated negated <InMiscellaneousSymbols>} );
#?pugs todo
ok("\x[3EE7]"  ~~ m/^<-:InMiscellaneousSymbols>$/, q{Match unrelated inverted <InMiscellaneousSymbols>} );
#?pugs todo
ok("\x[3EE7]\c[BLACK SUN WITH RAYS]" ~~ m/<:InMiscellaneousSymbols>/, q{Match unanchored <InMiscellaneousSymbols>} );

# InMiscellaneousTechnical


#?pugs todo
ok("\c[DIAMETER SIGN]" ~~ m/^<:InMiscellaneousTechnical>$/, q{Match <:InMiscellaneousTechnical>} );
ok(!( "\c[DIAMETER SIGN]" ~~ m/^<:!InMiscellaneousTechnical>$/ ), q{Don't match negated <InMiscellaneousTechnical>} );
ok(!( "\c[DIAMETER SIGN]" ~~ m/^<-:InMiscellaneousTechnical>$/ ), q{Don't match inverted <InMiscellaneousTechnical>} );
ok(!( "\x[2EFC]"  ~~ m/^<:InMiscellaneousTechnical>$/ ), q{Don't match unrelated <InMiscellaneousTechnical>} );
#?pugs todo
ok("\x[2EFC]"  ~~ m/^<:!InMiscellaneousTechnical>$/, q{Match unrelated negated <InMiscellaneousTechnical>} );
#?pugs todo
ok("\x[2EFC]"  ~~ m/^<-:InMiscellaneousTechnical>$/, q{Match unrelated inverted <InMiscellaneousTechnical>} );
#?pugs todo
ok("\x[2EFC]\c[DIAMETER SIGN]" ~~ m/<:InMiscellaneousTechnical>/, q{Match unanchored <InMiscellaneousTechnical>} );

# InMongolian


#?pugs todo
ok("\c[MONGOLIAN BIRGA]" ~~ m/^<:InMongolian>$/, q{Match <:InMongolian>} );
ok(!( "\c[MONGOLIAN BIRGA]" ~~ m/^<:!InMongolian>$/ ), q{Don't match negated <InMongolian>} );
ok(!( "\c[MONGOLIAN BIRGA]" ~~ m/^<-:InMongolian>$/ ), q{Don't match inverted <InMongolian>} );
ok(!( "\x[AFB4]"  ~~ m/^<:InMongolian>$/ ), q{Don't match unrelated <InMongolian>} );
#?pugs todo
ok("\x[AFB4]"  ~~ m/^<:!InMongolian>$/, q{Match unrelated negated <InMongolian>} );
#?pugs todo
ok("\x[AFB4]"  ~~ m/^<-:InMongolian>$/, q{Match unrelated inverted <InMongolian>} );
#?pugs todo
ok("\x[AFB4]\c[MONGOLIAN BIRGA]" ~~ m/<:InMongolian>/, q{Match unanchored <InMongolian>} );

# InMusicalSymbols


ok(!( "\x[0CE4]"  ~~ m/^<:InMusicalSymbols>$/ ), q{Don't match unrelated <InMusicalSymbols>} );
#?pugs todo
ok("\x[0CE4]"  ~~ m/^<:!InMusicalSymbols>$/, q{Match unrelated negated <InMusicalSymbols>} );
#?pugs todo
ok("\x[0CE4]"  ~~ m/^<-:InMusicalSymbols>$/, q{Match unrelated inverted <InMusicalSymbols>} );

# InMyanmar


#?pugs todo
ok("\c[MYANMAR LETTER KA]" ~~ m/^<:InMyanmar>$/, q{Match <:InMyanmar>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<:!InMyanmar>$/ ), q{Don't match negated <InMyanmar>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<-:InMyanmar>$/ ), q{Don't match inverted <InMyanmar>} );
ok(!( "\x[1DDB]"  ~~ m/^<:InMyanmar>$/ ), q{Don't match unrelated <InMyanmar>} );
#?pugs todo
ok("\x[1DDB]"  ~~ m/^<:!InMyanmar>$/, q{Match unrelated negated <InMyanmar>} );
#?pugs todo
ok("\x[1DDB]"  ~~ m/^<-:InMyanmar>$/, q{Match unrelated inverted <InMyanmar>} );
#?pugs todo
ok("\x[1DDB]\c[MYANMAR LETTER KA]" ~~ m/<:InMyanmar>/, q{Match unanchored <InMyanmar>} );

# InNumberForms

#?pugs todo
ok("\x[2150]" ~~ m/^<:InNumberForms>$/, q{Match <:InNumberForms>} );
ok(!( "\x[2150]" ~~ m/^<:!InNumberForms>$/ ), q{Don't match negated <InNumberForms>} );
ok(!( "\x[2150]" ~~ m/^<-:InNumberForms>$/ ), q{Don't match inverted <InNumberForms>} );
ok(!( "\c[BLACK RIGHT-POINTING SMALL TRIANGLE]"  ~~ m/^<:InNumberForms>$/ ), q{Don't match unrelated <InNumberForms>} );
#?pugs todo
ok("\c[BLACK RIGHT-POINTING SMALL TRIANGLE]"  ~~ m/^<:!InNumberForms>$/, q{Match unrelated negated <InNumberForms>} );
#?pugs todo
ok("\c[BLACK RIGHT-POINTING SMALL TRIANGLE]"  ~~ m/^<-:InNumberForms>$/, q{Match unrelated inverted <InNumberForms>} );
#?pugs todo
ok("\c[BLACK RIGHT-POINTING SMALL TRIANGLE]\x[2150]" ~~ m/<:InNumberForms>/, q{Match unanchored <InNumberForms>} );

# InOgham


#?pugs todo
ok("\c[OGHAM SPACE MARK]" ~~ m/^<:InOgham>$/, q{Match <:InOgham>} );
ok(!( "\c[OGHAM SPACE MARK]" ~~ m/^<:!InOgham>$/ ), q{Don't match negated <InOgham>} );
ok(!( "\c[OGHAM SPACE MARK]" ~~ m/^<-:InOgham>$/ ), q{Don't match inverted <InOgham>} );
ok(!( "\x[768C]"  ~~ m/^<:InOgham>$/ ), q{Don't match unrelated <InOgham>} );
#?pugs todo
ok("\x[768C]"  ~~ m/^<:!InOgham>$/, q{Match unrelated negated <InOgham>} );
#?pugs todo
ok("\x[768C]"  ~~ m/^<-:InOgham>$/, q{Match unrelated inverted <InOgham>} );
#?pugs todo
ok("\x[768C]\c[OGHAM SPACE MARK]" ~~ m/<:InOgham>/, q{Match unanchored <InOgham>} );

# InOldItalic


ok(!( "\x[C597]"  ~~ m/^<:InOldItalic>$/ ), q{Don't match unrelated <InOldItalic>} );
#?pugs todo
ok("\x[C597]"  ~~ m/^<:!InOldItalic>$/, q{Match unrelated negated <InOldItalic>} );
#?pugs todo
ok("\x[C597]"  ~~ m/^<-:InOldItalic>$/, q{Match unrelated inverted <InOldItalic>} );

# InOpticalCharacterRecognition


#?pugs todo
ok("\c[OCR HOOK]" ~~ m/^<:InOpticalCharacterRecognition>$/, q{Match <:InOpticalCharacterRecognition>} );
ok(!( "\c[OCR HOOK]" ~~ m/^<:!InOpticalCharacterRecognition>$/ ), q{Don't match negated <InOpticalCharacterRecognition>} );
ok(!( "\c[OCR HOOK]" ~~ m/^<-:InOpticalCharacterRecognition>$/ ), q{Don't match inverted <InOpticalCharacterRecognition>} );
ok(!( "\x[BE80]"  ~~ m/^<:InOpticalCharacterRecognition>$/ ), q{Don't match unrelated <InOpticalCharacterRecognition>} );
#?pugs todo
ok("\x[BE80]"  ~~ m/^<:!InOpticalCharacterRecognition>$/, q{Match unrelated negated <InOpticalCharacterRecognition>} );
#?pugs todo
ok("\x[BE80]"  ~~ m/^<-:InOpticalCharacterRecognition>$/, q{Match unrelated inverted <InOpticalCharacterRecognition>} );
#?pugs todo
ok("\x[BE80]\c[OCR HOOK]" ~~ m/<:InOpticalCharacterRecognition>/, q{Match unanchored <InOpticalCharacterRecognition>} );

# InOriya


#?pugs todo
ok("\x[0B00]" ~~ m/^<:InOriya>$/, q{Match <:InOriya>} );
ok(!( "\x[0B00]" ~~ m/^<:!InOriya>$/ ), q{Don't match negated <InOriya>} );
ok(!( "\x[0B00]" ~~ m/^<-:InOriya>$/ ), q{Don't match inverted <InOriya>} );
ok(!( "\c[YI SYLLABLE GGEX]"  ~~ m/^<:InOriya>$/ ), q{Don't match unrelated <InOriya>} );
#?pugs todo
ok("\c[YI SYLLABLE GGEX]"  ~~ m/^<:!InOriya>$/, q{Match unrelated negated <InOriya>} );
#?pugs todo
ok("\c[YI SYLLABLE GGEX]"  ~~ m/^<-:InOriya>$/, q{Match unrelated inverted <InOriya>} );
#?pugs todo
ok("\c[YI SYLLABLE GGEX]\x[0B00]" ~~ m/<:InOriya>/, q{Match unanchored <InOriya>} );

# InPrivateUseArea


ok(!( "\x[B6B1]"  ~~ m/^<:InPrivateUseArea>$/ ), q{Don't match unrelated <InPrivateUseArea>} );
#?pugs todo
ok("\x[B6B1]"  ~~ m/^<:!InPrivateUseArea>$/, q{Match unrelated negated <InPrivateUseArea>} );
#?pugs todo
ok("\x[B6B1]"  ~~ m/^<-:InPrivateUseArea>$/, q{Match unrelated inverted <InPrivateUseArea>} );

# InRunic


#?pugs todo
ok("\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<:InRunic>$/, q{Match <:InRunic>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<:!InRunic>$/ ), q{Don't match negated <InRunic>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<-:InRunic>$/ ), q{Don't match inverted <InRunic>} );
ok(!( "\c[SINHALA LETTER MAHAAPRAANA KAYANNA]"  ~~ m/^<:InRunic>$/ ), q{Don't match unrelated <InRunic>} );
#?pugs todo
ok("\c[SINHALA LETTER MAHAAPRAANA KAYANNA]"  ~~ m/^<:!InRunic>$/, q{Match unrelated negated <InRunic>} );
#?pugs todo
ok("\c[SINHALA LETTER MAHAAPRAANA KAYANNA]"  ~~ m/^<-:InRunic>$/, q{Match unrelated inverted <InRunic>} );
#?pugs todo
ok("\c[SINHALA LETTER MAHAAPRAANA KAYANNA]\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/<:InRunic>/, q{Match unanchored <InRunic>} );

# InSinhala


#?pugs todo
ok("\x[0D80]" ~~ m/^<:InSinhala>$/, q{Match <:InSinhala>} );
ok(!( "\x[0D80]" ~~ m/^<:!InSinhala>$/ ), q{Don't match negated <InSinhala>} );
ok(!( "\x[0D80]" ~~ m/^<-:InSinhala>$/ ), q{Don't match inverted <InSinhala>} );
ok(!( "\x[1060]"  ~~ m/^<:InSinhala>$/ ), q{Don't match unrelated <InSinhala>} );
#?pugs todo
ok("\x[1060]"  ~~ m/^<:!InSinhala>$/, q{Match unrelated negated <InSinhala>} );
#?pugs todo
ok("\x[1060]"  ~~ m/^<-:InSinhala>$/, q{Match unrelated inverted <InSinhala>} );
#?pugs todo
ok("\x[1060]\x[0D80]" ~~ m/<:InSinhala>/, q{Match unanchored <InSinhala>} );

# InSmallFormVariants


ok(!( "\x[5285]"  ~~ m/^<:InSmallFormVariants>$/ ), q{Don't match unrelated <InSmallFormVariants>} );
#?pugs todo
ok("\x[5285]"  ~~ m/^<:!InSmallFormVariants>$/, q{Match unrelated negated <InSmallFormVariants>} );
#?pugs todo
ok("\x[5285]"  ~~ m/^<-:InSmallFormVariants>$/, q{Match unrelated inverted <InSmallFormVariants>} );

# InSpacingModifierLetters


#?pugs todo
ok("\c[MODIFIER LETTER SMALL H]" ~~ m/^<:InSpacingModifierLetters>$/, q{Match <:InSpacingModifierLetters>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<:!InSpacingModifierLetters>$/ ), q{Don't match negated <InSpacingModifierLetters>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<-:InSpacingModifierLetters>$/ ), q{Don't match inverted <InSpacingModifierLetters>} );
ok(!( "\x[5326]"  ~~ m/^<:InSpacingModifierLetters>$/ ), q{Don't match unrelated <InSpacingModifierLetters>} );
#?pugs todo
ok("\x[5326]"  ~~ m/^<:!InSpacingModifierLetters>$/, q{Match unrelated negated <InSpacingModifierLetters>} );
#?pugs todo
ok("\x[5326]"  ~~ m/^<-:InSpacingModifierLetters>$/, q{Match unrelated inverted <InSpacingModifierLetters>} );
#?pugs todo
ok("\x[5326]\c[MODIFIER LETTER SMALL H]" ~~ m/<:InSpacingModifierLetters>/, q{Match unanchored <InSpacingModifierLetters>} );

# InSpecials


ok(!( "\x[3DF1]"  ~~ m/^<:InSpecials>$/ ), q{Don't match unrelated <InSpecials>} );
#?pugs todo
ok("\x[3DF1]"  ~~ m/^<:!InSpecials>$/, q{Match unrelated negated <InSpecials>} );
#?pugs todo
ok("\x[3DF1]"  ~~ m/^<-:InSpecials>$/, q{Match unrelated inverted <InSpecials>} );

# InSuperscriptsAndSubscripts


#?pugs todo
ok("\c[SUPERSCRIPT ZERO]" ~~ m/^<:InSuperscriptsAndSubscripts>$/, q{Match <:InSuperscriptsAndSubscripts>} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<:!InSuperscriptsAndSubscripts>$/ ), q{Don't match negated <InSuperscriptsAndSubscripts>} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<-:InSuperscriptsAndSubscripts>$/ ), q{Don't match inverted <InSuperscriptsAndSubscripts>} );
ok(!( "\x[3E71]"  ~~ m/^<:InSuperscriptsAndSubscripts>$/ ), q{Don't match unrelated <InSuperscriptsAndSubscripts>} );
#?pugs todo
ok("\x[3E71]"  ~~ m/^<:!InSuperscriptsAndSubscripts>$/, q{Match unrelated negated <InSuperscriptsAndSubscripts>} );
#?pugs todo
ok("\x[3E71]"  ~~ m/^<-:InSuperscriptsAndSubscripts>$/, q{Match unrelated inverted <InSuperscriptsAndSubscripts>} );
#?pugs todo
ok("\x[3E71]\c[SUPERSCRIPT ZERO]" ~~ m/<:InSuperscriptsAndSubscripts>/, q{Match unanchored <InSuperscriptsAndSubscripts>} );

# InSupplementalArrowsA


#?pugs todo
ok("\c[UPWARDS QUADRUPLE ARROW]" ~~ m/^<:InSupplementalArrowsA>$/, q{Match <:InSupplementalArrowsA>} );
ok(!( "\c[UPWARDS QUADRUPLE ARROW]" ~~ m/^<:!InSupplementalArrowsA>$/ ), q{Don't match negated <InSupplementalArrowsA>} );
ok(!( "\c[UPWARDS QUADRUPLE ARROW]" ~~ m/^<-:InSupplementalArrowsA>$/ ), q{Don't match inverted <InSupplementalArrowsA>} );
ok(!( "\c[GREEK SMALL LETTER OMICRON WITH TONOS]"  ~~ m/^<:InSupplementalArrowsA>$/ ), q{Don't match unrelated <InSupplementalArrowsA>} );
#?pugs todo
ok("\c[GREEK SMALL LETTER OMICRON WITH TONOS]"  ~~ m/^<:!InSupplementalArrowsA>$/, q{Match unrelated negated <InSupplementalArrowsA>} );
#?pugs todo
ok("\c[GREEK SMALL LETTER OMICRON WITH TONOS]"  ~~ m/^<-:InSupplementalArrowsA>$/, q{Match unrelated inverted <InSupplementalArrowsA>} );
#?pugs todo
ok("\c[GREEK SMALL LETTER OMICRON WITH TONOS]\c[UPWARDS QUADRUPLE ARROW]" ~~ m/<:InSupplementalArrowsA>/, q{Match unanchored <InSupplementalArrowsA>} );

# InSupplementalArrowsB


#?pugs todo
ok("\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/^<:InSupplementalArrowsB>$/, q{Match <:InSupplementalArrowsB>} );
ok(!( "\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/^<:!InSupplementalArrowsB>$/ ), q{Don't match negated <InSupplementalArrowsB>} );
ok(!( "\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/^<-:InSupplementalArrowsB>$/ ), q{Don't match inverted <InSupplementalArrowsB>} );
ok(!( "\x[C1A9]"  ~~ m/^<:InSupplementalArrowsB>$/ ), q{Don't match unrelated <InSupplementalArrowsB>} );
#?pugs todo
ok("\x[C1A9]"  ~~ m/^<:!InSupplementalArrowsB>$/, q{Match unrelated negated <InSupplementalArrowsB>} );
#?pugs todo
ok("\x[C1A9]"  ~~ m/^<-:InSupplementalArrowsB>$/, q{Match unrelated inverted <InSupplementalArrowsB>} );
#?pugs todo
ok("\x[C1A9]\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/<:InSupplementalArrowsB>/, q{Match unanchored <InSupplementalArrowsB>} );

# InSupplementalMathematicalOperators


#?pugs todo
ok("\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/^<:InSupplementalMathematicalOperators>$/, q{Match <:InSupplementalMathematicalOperators>} );
ok(!( "\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/^<:!InSupplementalMathematicalOperators>$/ ), q{Don't match negated <InSupplementalMathematicalOperators>} );
ok(!( "\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/^<-:InSupplementalMathematicalOperators>$/ ), q{Don't match inverted <InSupplementalMathematicalOperators>} );
ok(!( "\x[9EBD]"  ~~ m/^<:InSupplementalMathematicalOperators>$/ ), q{Don't match unrelated <InSupplementalMathematicalOperators>} );
#?pugs todo
ok("\x[9EBD]"  ~~ m/^<:!InSupplementalMathematicalOperators>$/, q{Match unrelated negated <InSupplementalMathematicalOperators>} );
#?pugs todo
ok("\x[9EBD]"  ~~ m/^<-:InSupplementalMathematicalOperators>$/, q{Match unrelated inverted <InSupplementalMathematicalOperators>} );
#?pugs todo
ok("\x[9EBD]\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/<:InSupplementalMathematicalOperators>/, q{Match unanchored <InSupplementalMathematicalOperators>} );

# InSupplementaryPrivateUseAreaA


ok(!( "\x[07E3]"  ~~ m/^<:InSupplementaryPrivateUseAreaA>$/ ), q{Don't match unrelated <InSupplementaryPrivateUseAreaA>} );
#?pugs todo
ok("\x[07E3]"  ~~ m/^<:!InSupplementaryPrivateUseAreaA>$/, q{Match unrelated negated <InSupplementaryPrivateUseAreaA>} );
#?pugs todo
ok("\x[07E3]"  ~~ m/^<-:InSupplementaryPrivateUseAreaA>$/, q{Match unrelated inverted <InSupplementaryPrivateUseAreaA>} );

# InSupplementaryPrivateUseAreaB


ok(!( "\x[4C48]"  ~~ m/^<:InSupplementaryPrivateUseAreaB>$/ ), q{Don't match unrelated <InSupplementaryPrivateUseAreaB>} );
#?pugs todo
ok("\x[4C48]"  ~~ m/^<:!InSupplementaryPrivateUseAreaB>$/, q{Match unrelated negated <InSupplementaryPrivateUseAreaB>} );
#?pugs todo
ok("\x[4C48]"  ~~ m/^<-:InSupplementaryPrivateUseAreaB>$/, q{Match unrelated inverted <InSupplementaryPrivateUseAreaB>} );

# InSyriac


#?pugs todo
ok("\c[SYRIAC END OF PARAGRAPH]" ~~ m/^<:InSyriac>$/, q{Match <:InSyriac>} );
ok(!( "\c[SYRIAC END OF PARAGRAPH]" ~~ m/^<:!InSyriac>$/ ), q{Don't match negated <InSyriac>} );
ok(!( "\c[SYRIAC END OF PARAGRAPH]" ~~ m/^<-:InSyriac>$/ ), q{Don't match inverted <InSyriac>} );
ok(!( "\c[YI SYLLABLE NZIEP]"  ~~ m/^<:InSyriac>$/ ), q{Don't match unrelated <InSyriac>} );
#?pugs todo
ok("\c[YI SYLLABLE NZIEP]"  ~~ m/^<:!InSyriac>$/, q{Match unrelated negated <InSyriac>} );
#?pugs todo
ok("\c[YI SYLLABLE NZIEP]"  ~~ m/^<-:InSyriac>$/, q{Match unrelated inverted <InSyriac>} );
#?pugs todo
ok("\c[YI SYLLABLE NZIEP]\c[SYRIAC END OF PARAGRAPH]" ~~ m/<:InSyriac>/, q{Match unanchored <InSyriac>} );

# InTagalog


#?pugs todo
ok("\c[TAGALOG LETTER A]" ~~ m/^<:InTagalog>$/, q{Match <:InTagalog>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<:!InTagalog>$/ ), q{Don't match negated <InTagalog>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<-:InTagalog>$/ ), q{Don't match inverted <InTagalog>} );
ok(!( "\c[GEORGIAN LETTER BAN]"  ~~ m/^<:InTagalog>$/ ), q{Don't match unrelated <InTagalog>} );
#?pugs todo
ok("\c[GEORGIAN LETTER BAN]"  ~~ m/^<:!InTagalog>$/, q{Match unrelated negated <InTagalog>} );
#?pugs todo
ok("\c[GEORGIAN LETTER BAN]"  ~~ m/^<-:InTagalog>$/, q{Match unrelated inverted <InTagalog>} );
#?pugs todo
ok("\c[GEORGIAN LETTER BAN]\c[TAGALOG LETTER A]" ~~ m/<:InTagalog>/, q{Match unanchored <InTagalog>} );

# InTagbanwa


#?pugs todo
ok("\c[TAGBANWA LETTER A]" ~~ m/^<:InTagbanwa>$/, q{Match <:InTagbanwa>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<:!InTagbanwa>$/ ), q{Don't match negated <InTagbanwa>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<-:InTagbanwa>$/ ), q{Don't match inverted <InTagbanwa>} );
ok(!( "\x[5776]"  ~~ m/^<:InTagbanwa>$/ ), q{Don't match unrelated <InTagbanwa>} );
#?pugs todo
ok("\x[5776]"  ~~ m/^<:!InTagbanwa>$/, q{Match unrelated negated <InTagbanwa>} );
#?pugs todo
ok("\x[5776]"  ~~ m/^<-:InTagbanwa>$/, q{Match unrelated inverted <InTagbanwa>} );
#?pugs todo
ok("\x[5776]\c[TAGBANWA LETTER A]" ~~ m/<:InTagbanwa>/, q{Match unanchored <InTagbanwa>} );

# InTags


ok(!( "\x[3674]"  ~~ m/^<:InTags>$/ ), q{Don't match unrelated <InTags>} );
#?pugs todo
ok("\x[3674]"  ~~ m/^<:!InTags>$/, q{Match unrelated negated <InTags>} );
#?pugs todo
ok("\x[3674]"  ~~ m/^<-:InTags>$/, q{Match unrelated inverted <InTags>} );

# InTamil


#?pugs todo
ok("\x[0B80]" ~~ m/^<:InTamil>$/, q{Match <:InTamil>} );
ok(!( "\x[0B80]" ~~ m/^<:!InTamil>$/ ), q{Don't match negated <InTamil>} );
ok(!( "\x[0B80]" ~~ m/^<-:InTamil>$/ ), q{Don't match inverted <InTamil>} );
ok(!( "\x[B58F]"  ~~ m/^<:InTamil>$/ ), q{Don't match unrelated <InTamil>} );
#?pugs todo
ok("\x[B58F]"  ~~ m/^<:!InTamil>$/, q{Match unrelated negated <InTamil>} );
#?pugs todo
ok("\x[B58F]"  ~~ m/^<-:InTamil>$/, q{Match unrelated inverted <InTamil>} );
#?pugs todo
ok("\x[B58F]\x[0B80]" ~~ m/<:InTamil>/, q{Match unanchored <InTamil>} );

# InTelugu


#?pugs todo
ok("\x[0C00]" ~~ m/^<:InTelugu>$/, q{Match <:InTelugu>} );
ok(!( "\x[0C00]" ~~ m/^<:!InTelugu>$/ ), q{Don't match negated <InTelugu>} );
ok(!( "\x[0C00]" ~~ m/^<-:InTelugu>$/ ), q{Don't match inverted <InTelugu>} );
ok(!( "\x[8AC5]"  ~~ m/^<:InTelugu>$/ ), q{Don't match unrelated <InTelugu>} );
#?pugs todo
ok("\x[8AC5]"  ~~ m/^<:!InTelugu>$/, q{Match unrelated negated <InTelugu>} );
#?pugs todo
ok("\x[8AC5]"  ~~ m/^<-:InTelugu>$/, q{Match unrelated inverted <InTelugu>} );
#?pugs todo
ok("\x[8AC5]\x[0C00]" ~~ m/<:InTelugu>/, q{Match unanchored <InTelugu>} );

# InThaana


#?pugs todo
ok("\c[THAANA LETTER HAA]" ~~ m/^<:InThaana>$/, q{Match <:InThaana>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<:!InThaana>$/ ), q{Don't match negated <InThaana>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<-:InThaana>$/ ), q{Don't match inverted <InThaana>} );
ok(!( "\x[BB8F]"  ~~ m/^<:InThaana>$/ ), q{Don't match unrelated <InThaana>} );
#?pugs todo
ok("\x[BB8F]"  ~~ m/^<:!InThaana>$/, q{Match unrelated negated <InThaana>} );
#?pugs todo
ok("\x[BB8F]"  ~~ m/^<-:InThaana>$/, q{Match unrelated inverted <InThaana>} );
#?pugs todo
ok("\x[BB8F]\c[THAANA LETTER HAA]" ~~ m/<:InThaana>/, q{Match unanchored <InThaana>} );

# InThai


#?pugs todo
ok("\x[0E00]" ~~ m/^<:InThai>$/, q{Match <:InThai>} );
ok(!( "\x[0E00]" ~~ m/^<:!InThai>$/ ), q{Don't match negated <InThai>} );
ok(!( "\x[0E00]" ~~ m/^<-:InThai>$/ ), q{Don't match inverted <InThai>} );
ok(!( "\x[9395]"  ~~ m/^<:InThai>$/ ), q{Don't match unrelated <InThai>} );
#?pugs todo
ok("\x[9395]"  ~~ m/^<:!InThai>$/, q{Match unrelated negated <InThai>} );
#?pugs todo
ok("\x[9395]"  ~~ m/^<-:InThai>$/, q{Match unrelated inverted <InThai>} );
#?pugs todo
ok("\x[9395]\x[0E00]" ~~ m/<:InThai>/, q{Match unanchored <InThai>} );

# InTibetan


#?pugs todo
ok("\c[TIBETAN SYLLABLE OM]" ~~ m/^<:InTibetan>$/, q{Match <:InTibetan>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<:!InTibetan>$/ ), q{Don't match negated <InTibetan>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<-:InTibetan>$/ ), q{Don't match inverted <InTibetan>} );
ok(!( "\x[957A]"  ~~ m/^<:InTibetan>$/ ), q{Don't match unrelated <InTibetan>} );
#?pugs todo
ok("\x[957A]"  ~~ m/^<:!InTibetan>$/, q{Match unrelated negated <InTibetan>} );
#?pugs todo
ok("\x[957A]"  ~~ m/^<-:InTibetan>$/, q{Match unrelated inverted <InTibetan>} );
#?pugs todo
ok("\x[957A]\c[TIBETAN SYLLABLE OM]" ~~ m/<:InTibetan>/, q{Match unanchored <InTibetan>} );

# InUnifiedCanadianAboriginalSyllabics


#?pugs todo
ok("\x[1400]" ~~ m/^<:InUnifiedCanadianAboriginalSyllabics>$/, q{Match <:InUnifiedCanadianAboriginalSyllabics>} );
ok(!( "\x[1400]" ~~ m/^<:!InUnifiedCanadianAboriginalSyllabics>$/ ), q{Don't match negated <InUnifiedCanadianAboriginalSyllabics>} );
ok(!( "\x[1400]" ~~ m/^<-:InUnifiedCanadianAboriginalSyllabics>$/ ), q{Don't match inverted <InUnifiedCanadianAboriginalSyllabics>} );
ok(!( "\x[9470]"  ~~ m/^<:InUnifiedCanadianAboriginalSyllabics>$/ ), q{Don't match unrelated <InUnifiedCanadianAboriginalSyllabics>} );
#?pugs todo
ok("\x[9470]"  ~~ m/^<:!InUnifiedCanadianAboriginalSyllabics>$/, q{Match unrelated negated <InUnifiedCanadianAboriginalSyllabics>} );
#?pugs todo
ok("\x[9470]"  ~~ m/^<-:InUnifiedCanadianAboriginalSyllabics>$/, q{Match unrelated inverted <InUnifiedCanadianAboriginalSyllabics>} );
#?pugs todo
ok("\x[9470]\x[1400]" ~~ m/<:InUnifiedCanadianAboriginalSyllabics>/, q{Match unanchored <InUnifiedCanadianAboriginalSyllabics>} );

# InVariationSelectors


ok(!( "\x[764D]"  ~~ m/^<:InVariationSelectors>$/ ), q{Don't match unrelated <InVariationSelectors>} );
#?pugs todo
ok("\x[764D]"  ~~ m/^<:!InVariationSelectors>$/, q{Match unrelated negated <InVariationSelectors>} );
#?pugs todo
ok("\x[764D]"  ~~ m/^<-:InVariationSelectors>$/, q{Match unrelated inverted <InVariationSelectors>} );

# InYiRadicals


#?pugs todo
ok("\c[YI RADICAL QOT]" ~~ m/^<:InYiRadicals>$/, q{Match <:InYiRadicals>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:!InYiRadicals>$/ ), q{Don't match negated <InYiRadicals>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-:InYiRadicals>$/ ), q{Don't match inverted <InYiRadicals>} );
ok(!( "\x[3A4E]"  ~~ m/^<:InYiRadicals>$/ ), q{Don't match unrelated <InYiRadicals>} );
#?pugs todo
ok("\x[3A4E]"  ~~ m/^<:!InYiRadicals>$/, q{Match unrelated negated <InYiRadicals>} );
#?pugs todo
ok("\x[3A4E]"  ~~ m/^<-:InYiRadicals>$/, q{Match unrelated inverted <InYiRadicals>} );
#?pugs todo
ok("\x[3A4E]\c[YI RADICAL QOT]" ~~ m/<:InYiRadicals>/, q{Match unanchored <InYiRadicals>} );

# InYiSyllables


#?pugs todo
ok("\c[YI SYLLABLE IT]" ~~ m/^<:InYiSyllables>$/, q{Match <:InYiSyllables>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<:!InYiSyllables>$/ ), q{Don't match negated <InYiSyllables>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<-:InYiSyllables>$/ ), q{Don't match inverted <InYiSyllables>} );
ok(!( "\c[PARALLEL WITH HORIZONTAL STROKE]"  ~~ m/^<:InYiSyllables>$/ ), q{Don't match unrelated <InYiSyllables>} );
#?pugs todo
ok("\c[PARALLEL WITH HORIZONTAL STROKE]"  ~~ m/^<:!InYiSyllables>$/, q{Match unrelated negated <InYiSyllables>} );
#?pugs todo
ok("\c[PARALLEL WITH HORIZONTAL STROKE]"  ~~ m/^<-:InYiSyllables>$/, q{Match unrelated inverted <InYiSyllables>} );
#?pugs todo
ok("\c[PARALLEL WITH HORIZONTAL STROKE]\c[YI SYLLABLE IT]" ~~ m/<:InYiSyllables>/, q{Match unanchored <InYiSyllables>} );



# vim: ft=perl6
