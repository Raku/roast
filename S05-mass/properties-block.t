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

ok(!( "\x[531A]"  ~~ m/^<:InAlphabeticPresentationForms>$/ ), q{Don't match unrelated <isInAlphabeticPresentationForms>} );
ok("\x[531A]"  ~~ m/^<:!InAlphabeticPresentationForms>.$/, q{Match unrelated negated <isInAlphabeticPresentationForms>} );
ok("\x[531A]"  ~~ m/^<-:InAlphabeticPresentationForms>$/, q{Match unrelated inverted <isInAlphabeticPresentationForms>} );

# InArabic


ok("\c[ARABIC NUMBER SIGN]" ~~ m/^<:InArabic>$/, q{Match <:InArabic>} );
ok(!( "\c[ARABIC NUMBER SIGN]" ~~ m/^<:!InArabic>.$/ ), q{Don't match negated <isInArabic>} );
ok(!( "\c[ARABIC NUMBER SIGN]" ~~ m/^<-:InArabic>$/ ), q{Don't match inverted <isInArabic>} );
ok(!( "\x[7315]"  ~~ m/^<:InArabic>$/ ), q{Don't match unrelated <isInArabic>} );
ok("\x[7315]"  ~~ m/^<:!InArabic>.$/, q{Match unrelated negated <isInArabic>} );
ok("\x[7315]"  ~~ m/^<-:InArabic>$/, q{Match unrelated inverted <isInArabic>} );
ok("\x[7315]\c[ARABIC NUMBER SIGN]" ~~ m/<:InArabic>/, q{Match unanchored <isInArabic>} );

# InArabicPresentationFormsA


ok(!( "\x[8340]"  ~~ m/^<:InArabicPresentationFormsA>$/ ), q{Don't match unrelated <isInArabicPresentationFormsA>} );
ok("\x[8340]"  ~~ m/^<:!InArabicPresentationFormsA>.$/, q{Match unrelated negated <isInArabicPresentationFormsA>} );
ok("\x[8340]"  ~~ m/^<-:InArabicPresentationFormsA>$/, q{Match unrelated inverted <isInArabicPresentationFormsA>} );

# InArabicPresentationFormsB


ok(!( "\x[BEEC]"  ~~ m/^<:InArabicPresentationFormsB>$/ ), q{Don't match unrelated <isInArabicPresentationFormsB>} );
ok("\x[BEEC]"  ~~ m/^<:!InArabicPresentationFormsB>.$/, q{Match unrelated negated <isInArabicPresentationFormsB>} );
ok("\x[BEEC]"  ~~ m/^<-:InArabicPresentationFormsB>$/, q{Match unrelated inverted <isInArabicPresentationFormsB>} );

# InArmenian


ok("\x[0530]" ~~ m/^<:InArmenian>$/, q{Match <:InArmenian>} );
ok(!( "\x[0530]" ~~ m/^<:!InArmenian>.$/ ), q{Don't match negated <isInArmenian>} );
ok(!( "\x[0530]" ~~ m/^<-:InArmenian>$/ ), q{Don't match inverted <isInArmenian>} );
ok(!( "\x[3B0D]"  ~~ m/^<:InArmenian>$/ ), q{Don't match unrelated <isInArmenian>} );
ok("\x[3B0D]"  ~~ m/^<:!InArmenian>.$/, q{Match unrelated negated <isInArmenian>} );
ok("\x[3B0D]"  ~~ m/^<-:InArmenian>$/, q{Match unrelated inverted <isInArmenian>} );
ok("\x[3B0D]\x[0530]" ~~ m/<:InArmenian>/, q{Match unanchored <isInArmenian>} );

# InArrows


ok("\c[LEFTWARDS ARROW]" ~~ m/^<:InArrows>$/, q{Match <:InArrows>} );
ok(!( "\c[LEFTWARDS ARROW]" ~~ m/^<:!InArrows>.$/ ), q{Don't match negated <isInArrows>} );
ok(!( "\c[LEFTWARDS ARROW]" ~~ m/^<-:InArrows>$/ ), q{Don't match inverted <isInArrows>} );
ok(!( "\x[C401]"  ~~ m/^<:InArrows>$/ ), q{Don't match unrelated <isInArrows>} );
ok("\x[C401]"  ~~ m/^<:!InArrows>.$/, q{Match unrelated negated <isInArrows>} );
ok("\x[C401]"  ~~ m/^<-:InArrows>$/, q{Match unrelated inverted <isInArrows>} );
ok("\x[C401]\c[LEFTWARDS ARROW]" ~~ m/<:InArrows>/, q{Match unanchored <isInArrows>} );


# InBasicLatin


ok("\c[NULL]" ~~ m/^<:InBasicLatin>$/, q{Match <:InBasicLatin>} );
ok(!( "\c[NULL]" ~~ m/^<:!InBasicLatin>.$/ ), q{Don't match negated <isInBasicLatin>} );
ok(!( "\c[NULL]" ~~ m/^<-:InBasicLatin>$/ ), q{Don't match inverted <isInBasicLatin>} );
ok(!( "\x[46EA]"  ~~ m/^<:InBasicLatin>$/ ), q{Don't match unrelated <isInBasicLatin>} );
ok("\x[46EA]"  ~~ m/^<:!InBasicLatin>.$/, q{Match unrelated negated <isInBasicLatin>} );
ok("\x[46EA]"  ~~ m/^<-:InBasicLatin>$/, q{Match unrelated inverted <isInBasicLatin>} );
ok("\x[46EA]\c[NULL]" ~~ m/<:InBasicLatin>/, q{Match unanchored <isInBasicLatin>} );

# InBengali


ok("\x[0980]" ~~ m/^<:InBengali>$/, q{Match <:InBengali>} );
ok(!( "\x[0980]" ~~ m/^<:!InBengali>.$/ ), q{Don't match negated <isInBengali>} );
ok(!( "\x[0980]" ~~ m/^<-:InBengali>$/ ), q{Don't match inverted <isInBengali>} );
ok(!( "\c[YI SYLLABLE HMY]"  ~~ m/^<:InBengali>$/ ), q{Don't match unrelated <isInBengali>} );
ok("\c[YI SYLLABLE HMY]"  ~~ m/^<:!InBengali>.$/, q{Match unrelated negated <isInBengali>} );
ok("\c[YI SYLLABLE HMY]"  ~~ m/^<-:InBengali>$/, q{Match unrelated inverted <isInBengali>} );
ok("\c[YI SYLLABLE HMY]\x[0980]" ~~ m/<:InBengali>/, q{Match unanchored <isInBengali>} );

# InBlockElements


ok("\c[UPPER HALF BLOCK]" ~~ m/^<:InBlockElements>$/, q{Match <:InBlockElements>} );
ok(!( "\c[UPPER HALF BLOCK]" ~~ m/^<:!InBlockElements>.$/ ), q{Don't match negated <isInBlockElements>} );
ok(!( "\c[UPPER HALF BLOCK]" ~~ m/^<-:InBlockElements>$/ ), q{Don't match inverted <isInBlockElements>} );
ok(!( "\x[5F41]"  ~~ m/^<:InBlockElements>$/ ), q{Don't match unrelated <isInBlockElements>} );
ok("\x[5F41]"  ~~ m/^<:!InBlockElements>.$/, q{Match unrelated negated <isInBlockElements>} );
ok("\x[5F41]"  ~~ m/^<-:InBlockElements>$/, q{Match unrelated inverted <isInBlockElements>} );
ok("\x[5F41]\c[UPPER HALF BLOCK]" ~~ m/<:InBlockElements>/, q{Match unanchored <isInBlockElements>} );

# InBopomofo


ok("\x[3100]" ~~ m/^<:InBopomofo>$/, q{Match <:InBopomofo>} );
ok(!( "\x[3100]" ~~ m/^<:!InBopomofo>.$/ ), q{Don't match negated <isInBopomofo>} );
ok(!( "\x[3100]" ~~ m/^<-:InBopomofo>$/ ), q{Don't match inverted <isInBopomofo>} );
ok(!( "\x[9F8E]"  ~~ m/^<:InBopomofo>$/ ), q{Don't match unrelated <isInBopomofo>} );
ok("\x[9F8E]"  ~~ m/^<:!InBopomofo>.$/, q{Match unrelated negated <isInBopomofo>} );
ok("\x[9F8E]"  ~~ m/^<-:InBopomofo>$/, q{Match unrelated inverted <isInBopomofo>} );
ok("\x[9F8E]\x[3100]" ~~ m/<:InBopomofo>/, q{Match unanchored <isInBopomofo>} );

# InBopomofoExtended


ok("\c[BOPOMOFO LETTER BU]" ~~ m/^<:InBopomofoExtended>$/, q{Match <:InBopomofoExtended>} );
ok(!( "\c[BOPOMOFO LETTER BU]" ~~ m/^<:!InBopomofoExtended>.$/ ), q{Don't match negated <isInBopomofoExtended>} );
ok(!( "\c[BOPOMOFO LETTER BU]" ~~ m/^<-:InBopomofoExtended>$/ ), q{Don't match inverted <isInBopomofoExtended>} );
ok(!( "\x[43A6]"  ~~ m/^<:InBopomofoExtended>$/ ), q{Don't match unrelated <isInBopomofoExtended>} );
ok("\x[43A6]"  ~~ m/^<:!InBopomofoExtended>.$/, q{Match unrelated negated <isInBopomofoExtended>} );
ok("\x[43A6]"  ~~ m/^<-:InBopomofoExtended>$/, q{Match unrelated inverted <isInBopomofoExtended>} );
ok("\x[43A6]\c[BOPOMOFO LETTER BU]" ~~ m/<:InBopomofoExtended>/, q{Match unanchored <isInBopomofoExtended>} );

# InBoxDrawing


ok("\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/^<:InBoxDrawing>$/, q{Match <:InBoxDrawing>} );
ok(!( "\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/^<:!InBoxDrawing>.$/ ), q{Don't match negated <isInBoxDrawing>} );
ok(!( "\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/^<-:InBoxDrawing>$/ ), q{Don't match inverted <isInBoxDrawing>} );
ok(!( "\x[7865]"  ~~ m/^<:InBoxDrawing>$/ ), q{Don't match unrelated <isInBoxDrawing>} );
ok("\x[7865]"  ~~ m/^<:!InBoxDrawing>.$/, q{Match unrelated negated <isInBoxDrawing>} );
ok("\x[7865]"  ~~ m/^<-:InBoxDrawing>$/, q{Match unrelated inverted <isInBoxDrawing>} );
ok("\x[7865]\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/<:InBoxDrawing>/, q{Match unanchored <isInBoxDrawing>} );

# InBraillePatterns


ok("\c[BRAILLE PATTERN BLANK]" ~~ m/^<:InBraillePatterns>$/, q{Match <:InBraillePatterns>} );
ok(!( "\c[BRAILLE PATTERN BLANK]" ~~ m/^<:!InBraillePatterns>.$/ ), q{Don't match negated <isInBraillePatterns>} );
ok(!( "\c[BRAILLE PATTERN BLANK]" ~~ m/^<-:InBraillePatterns>$/ ), q{Don't match inverted <isInBraillePatterns>} );
ok(!( "\c[THAI CHARACTER KHO KHAI]"  ~~ m/^<:InBraillePatterns>$/ ), q{Don't match unrelated <isInBraillePatterns>} );
ok("\c[THAI CHARACTER KHO KHAI]"  ~~ m/^<:!InBraillePatterns>.$/, q{Match unrelated negated <isInBraillePatterns>} );
ok("\c[THAI CHARACTER KHO KHAI]"  ~~ m/^<-:InBraillePatterns>$/, q{Match unrelated inverted <isInBraillePatterns>} );
ok("\c[THAI CHARACTER KHO KHAI]\c[BRAILLE PATTERN BLANK]" ~~ m/<:InBraillePatterns>/, q{Match unanchored <isInBraillePatterns>} );

# InBuhid


ok("\c[BUHID LETTER A]" ~~ m/^<:InBuhid>$/, q{Match <:InBuhid>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<:!InBuhid>.$/ ), q{Don't match negated <isInBuhid>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<-:InBuhid>$/ ), q{Don't match inverted <isInBuhid>} );
ok(!( "\x[D208]"  ~~ m/^<:InBuhid>$/ ), q{Don't match unrelated <isInBuhid>} );
ok("\x[D208]"  ~~ m/^<:!InBuhid>.$/, q{Match unrelated negated <isInBuhid>} );
ok("\x[D208]"  ~~ m/^<-:InBuhid>$/, q{Match unrelated inverted <isInBuhid>} );
ok("\x[D208]\c[BUHID LETTER A]" ~~ m/<:InBuhid>/, q{Match unanchored <isInBuhid>} );

# InByzantineMusicalSymbols


ok(!( "\x[9B1D]"  ~~ m/^<:InByzantineMusicalSymbols>$/ ), q{Don't match unrelated <isInByzantineMusicalSymbols>} );
ok("\x[9B1D]"  ~~ m/^<:!InByzantineMusicalSymbols>.$/, q{Match unrelated negated <isInByzantineMusicalSymbols>} );
ok("\x[9B1D]"  ~~ m/^<-:InByzantineMusicalSymbols>$/, q{Match unrelated inverted <isInByzantineMusicalSymbols>} );

# InCJKCompatibility


ok("\c[SQUARE APAATO]" ~~ m/^<:InCJKCompatibility>$/, q{Match <:InCJKCompatibility>} );
ok(!( "\c[SQUARE APAATO]" ~~ m/^<:!InCJKCompatibility>.$/ ), q{Don't match negated <isInCJKCompatibility>} );
ok(!( "\c[SQUARE APAATO]" ~~ m/^<-:InCJKCompatibility>$/ ), q{Don't match inverted <isInCJKCompatibility>} );
ok(!( "\x[B8A5]"  ~~ m/^<:InCJKCompatibility>$/ ), q{Don't match unrelated <isInCJKCompatibility>} );
ok("\x[B8A5]"  ~~ m/^<:!InCJKCompatibility>.$/, q{Match unrelated negated <isInCJKCompatibility>} );
ok("\x[B8A5]"  ~~ m/^<-:InCJKCompatibility>$/, q{Match unrelated inverted <isInCJKCompatibility>} );
ok("\x[B8A5]\c[SQUARE APAATO]" ~~ m/<:InCJKCompatibility>/, q{Match unanchored <isInCJKCompatibility>} );

# InCJKCompatibilityForms


ok(!( "\x[3528]"  ~~ m/^<:InCJKCompatibilityForms>$/ ), q{Don't match unrelated <isInCJKCompatibilityForms>} );
ok("\x[3528]"  ~~ m/^<:!InCJKCompatibilityForms>.$/, q{Match unrelated negated <isInCJKCompatibilityForms>} );
ok("\x[3528]"  ~~ m/^<-:InCJKCompatibilityForms>$/, q{Match unrelated inverted <isInCJKCompatibilityForms>} );

# InCJKCompatibilityIdeographs


ok(!( "\x[69F7]"  ~~ m/^<:InCJKCompatibilityIdeographs>$/ ), q{Don't match unrelated <isInCJKCompatibilityIdeographs>} );
ok("\x[69F7]"  ~~ m/^<:!InCJKCompatibilityIdeographs>.$/, q{Match unrelated negated <isInCJKCompatibilityIdeographs>} );
ok("\x[69F7]"  ~~ m/^<-:InCJKCompatibilityIdeographs>$/, q{Match unrelated inverted <isInCJKCompatibilityIdeographs>} );

# InCJKCompatibilityIdeographsSupplement


ok(!( "\c[CANADIAN SYLLABICS NUNAVIK HO]"  ~~ m/^<:InCJKCompatibilityIdeographsSupplement>$/ ), q{Don't match unrelated <isInCJKCompatibilityIdeographsSupplement>} );
ok("\c[CANADIAN SYLLABICS NUNAVIK HO]"  ~~ m/^<:!InCJKCompatibilityIdeographsSupplement>.$/, q{Match unrelated negated <isInCJKCompatibilityIdeographsSupplement>} );
ok("\c[CANADIAN SYLLABICS NUNAVIK HO]"  ~~ m/^<-:InCJKCompatibilityIdeographsSupplement>$/, q{Match unrelated inverted <isInCJKCompatibilityIdeographsSupplement>} );

# InCJKRadicalsSupplement


ok("\c[CJK RADICAL REPEAT]" ~~ m/^<:InCJKRadicalsSupplement>$/, q{Match <:InCJKRadicalsSupplement>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<:!InCJKRadicalsSupplement>.$/ ), q{Don't match negated <isInCJKRadicalsSupplement>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<-:InCJKRadicalsSupplement>$/ ), q{Don't match inverted <isInCJKRadicalsSupplement>} );
ok(!( "\x[37B4]"  ~~ m/^<:InCJKRadicalsSupplement>$/ ), q{Don't match unrelated <isInCJKRadicalsSupplement>} );
ok("\x[37B4]"  ~~ m/^<:!InCJKRadicalsSupplement>.$/, q{Match unrelated negated <isInCJKRadicalsSupplement>} );
ok("\x[37B4]"  ~~ m/^<-:InCJKRadicalsSupplement>$/, q{Match unrelated inverted <isInCJKRadicalsSupplement>} );
ok("\x[37B4]\c[CJK RADICAL REPEAT]" ~~ m/<:InCJKRadicalsSupplement>/, q{Match unanchored <isInCJKRadicalsSupplement>} );

# InCJKSymbolsAndPunctuation


ok("\c[IDEOGRAPHIC SPACE]" ~~ m/^<:InCJKSymbolsAndPunctuation>$/, q{Match <:InCJKSymbolsAndPunctuation>} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<:!InCJKSymbolsAndPunctuation>.$/ ), q{Don't match negated <isInCJKSymbolsAndPunctuation>} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<-:InCJKSymbolsAndPunctuation>$/ ), q{Don't match inverted <isInCJKSymbolsAndPunctuation>} );
ok(!( "\x[80AA]"  ~~ m/^<:InCJKSymbolsAndPunctuation>$/ ), q{Don't match unrelated <isInCJKSymbolsAndPunctuation>} );
ok("\x[80AA]"  ~~ m/^<:!InCJKSymbolsAndPunctuation>.$/, q{Match unrelated negated <isInCJKSymbolsAndPunctuation>} );
ok("\x[80AA]"  ~~ m/^<-:InCJKSymbolsAndPunctuation>$/, q{Match unrelated inverted <isInCJKSymbolsAndPunctuation>} );
ok("\x[80AA]\c[IDEOGRAPHIC SPACE]" ~~ m/<:InCJKSymbolsAndPunctuation>/, q{Match unanchored <isInCJKSymbolsAndPunctuation>} );

# InCJKUnifiedIdeographs


ok("\x[4E00]" ~~ m/^<:InCJKUnifiedIdeographs>$/, q{Match <:InCJKUnifiedIdeographs>} );
ok(!( "\x[4E00]" ~~ m/^<:!InCJKUnifiedIdeographs>.$/ ), q{Don't match negated <isInCJKUnifiedIdeographs>} );
ok(!( "\x[4E00]" ~~ m/^<-:InCJKUnifiedIdeographs>$/ ), q{Don't match inverted <isInCJKUnifiedIdeographs>} );
ok(!( "\x[3613]"  ~~ m/^<:InCJKUnifiedIdeographs>$/ ), q{Don't match unrelated <isInCJKUnifiedIdeographs>} );
ok("\x[3613]"  ~~ m/^<:!InCJKUnifiedIdeographs>.$/, q{Match unrelated negated <isInCJKUnifiedIdeographs>} );
ok("\x[3613]"  ~~ m/^<-:InCJKUnifiedIdeographs>$/, q{Match unrelated inverted <isInCJKUnifiedIdeographs>} );
ok("\x[3613]\x[4E00]" ~~ m/<:InCJKUnifiedIdeographs>/, q{Match unanchored <isInCJKUnifiedIdeographs>} );

# InCJKUnifiedIdeographsExtensionA


ok("\x[3400]" ~~ m/^<:InCJKUnifiedIdeographsExtensionA>$/, q{Match <:InCJKUnifiedIdeographsExtensionA>} );
ok(!( "\x[3400]" ~~ m/^<:!InCJKUnifiedIdeographsExtensionA>.$/ ), q{Don't match negated <isInCJKUnifiedIdeographsExtensionA>} );
ok(!( "\x[3400]" ~~ m/^<-:InCJKUnifiedIdeographsExtensionA>$/ ), q{Don't match inverted <isInCJKUnifiedIdeographsExtensionA>} );
ok(!( "\c[SQUARE HOORU]"  ~~ m/^<:InCJKUnifiedIdeographsExtensionA>$/ ), q{Don't match unrelated <isInCJKUnifiedIdeographsExtensionA>} );
ok("\c[SQUARE HOORU]"  ~~ m/^<:!InCJKUnifiedIdeographsExtensionA>.$/, q{Match unrelated negated <isInCJKUnifiedIdeographsExtensionA>} );
ok("\c[SQUARE HOORU]"  ~~ m/^<-:InCJKUnifiedIdeographsExtensionA>$/, q{Match unrelated inverted <isInCJKUnifiedIdeographsExtensionA>} );
ok("\c[SQUARE HOORU]\x[3400]" ~~ m/<:InCJKUnifiedIdeographsExtensionA>/, q{Match unanchored <isInCJKUnifiedIdeographsExtensionA>} );

# InCJKUnifiedIdeographsExtensionB


ok(!( "\x[AC3B]"  ~~ m/^<:InCJKUnifiedIdeographsExtensionB>$/ ), q{Don't match unrelated <isInCJKUnifiedIdeographsExtensionB>} );
ok("\x[AC3B]"  ~~ m/^<:!InCJKUnifiedIdeographsExtensionB>.$/, q{Match unrelated negated <isInCJKUnifiedIdeographsExtensionB>} );
ok("\x[AC3B]"  ~~ m/^<-:InCJKUnifiedIdeographsExtensionB>$/, q{Match unrelated inverted <isInCJKUnifiedIdeographsExtensionB>} );

# InCherokee


ok("\c[CHEROKEE LETTER A]" ~~ m/^<:InCherokee>$/, q{Match <:InCherokee>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<:!InCherokee>.$/ ), q{Don't match negated <isInCherokee>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<-:InCherokee>$/ ), q{Don't match inverted <isInCherokee>} );
ok(!( "\x[985F]"  ~~ m/^<:InCherokee>$/ ), q{Don't match unrelated <isInCherokee>} );
ok("\x[985F]"  ~~ m/^<:!InCherokee>.$/, q{Match unrelated negated <isInCherokee>} );
ok("\x[985F]"  ~~ m/^<-:InCherokee>$/, q{Match unrelated inverted <isInCherokee>} );
ok("\x[985F]\c[CHEROKEE LETTER A]" ~~ m/<:InCherokee>/, q{Match unanchored <isInCherokee>} );

# InCombiningDiacriticalMarks


ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:InCombiningDiacriticalMarks>$/, q{Match <:InCombiningDiacriticalMarks>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!InCombiningDiacriticalMarks>.$/ ), q{Don't match negated <isInCombiningDiacriticalMarks>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:InCombiningDiacriticalMarks>$/ ), q{Don't match inverted <isInCombiningDiacriticalMarks>} );
ok(!( "\x[76DA]"  ~~ m/^<:InCombiningDiacriticalMarks>$/ ), q{Don't match unrelated <isInCombiningDiacriticalMarks>} );
ok("\x[76DA]"  ~~ m/^<:!InCombiningDiacriticalMarks>.$/, q{Match unrelated negated <isInCombiningDiacriticalMarks>} );
ok("\x[76DA]"  ~~ m/^<-:InCombiningDiacriticalMarks>$/, q{Match unrelated inverted <isInCombiningDiacriticalMarks>} );
ok("\x[76DA]\c[COMBINING GRAVE ACCENT]" ~~ m/<:InCombiningDiacriticalMarks>/, q{Match unanchored <isInCombiningDiacriticalMarks>} );

# InCombiningDiacriticalMarksforSymbols


ok("\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/^<:InCombiningDiacriticalMarksforSymbols>$/, q{Match <:InCombiningDiacriticalMarksforSymbols>} );
ok(!( "\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/^<:!InCombiningDiacriticalMarksforSymbols>.$/ ), q{Don't match negated <isInCombiningDiacriticalMarksforSymbols>} );
ok(!( "\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/^<-:InCombiningDiacriticalMarksforSymbols>$/ ), q{Don't match inverted <isInCombiningDiacriticalMarksforSymbols>} );
ok(!( "\x[7345]"  ~~ m/^<:InCombiningDiacriticalMarksforSymbols>$/ ), q{Don't match unrelated <isInCombiningDiacriticalMarksforSymbols>} );
ok("\x[7345]"  ~~ m/^<:!InCombiningDiacriticalMarksforSymbols>.$/, q{Match unrelated negated <isInCombiningDiacriticalMarksforSymbols>} );
ok("\x[7345]"  ~~ m/^<-:InCombiningDiacriticalMarksforSymbols>$/, q{Match unrelated inverted <isInCombiningDiacriticalMarksforSymbols>} );
ok("\x[7345]\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/<:InCombiningDiacriticalMarksforSymbols>/, q{Match unanchored <isInCombiningDiacriticalMarksforSymbols>} );

# InCombiningHalfMarks


ok(!( "\x[6C2E]"  ~~ m/^<:InCombiningHalfMarks>$/ ), q{Don't match unrelated <isInCombiningHalfMarks>} );
ok("\x[6C2E]"  ~~ m/^<:!InCombiningHalfMarks>.$/, q{Match unrelated negated <isInCombiningHalfMarks>} );
ok("\x[6C2E]"  ~~ m/^<-:InCombiningHalfMarks>$/, q{Match unrelated inverted <isInCombiningHalfMarks>} );

# InControlPictures


ok("\c[SYMBOL FOR NULL]" ~~ m/^<:InControlPictures>$/, q{Match <:InControlPictures>} );
ok(!( "\c[SYMBOL FOR NULL]" ~~ m/^<:!InControlPictures>.$/ ), q{Don't match negated <isInControlPictures>} );
ok(!( "\c[SYMBOL FOR NULL]" ~~ m/^<-:InControlPictures>$/ ), q{Don't match inverted <isInControlPictures>} );
ok(!( "\x[BCE2]"  ~~ m/^<:InControlPictures>$/ ), q{Don't match unrelated <isInControlPictures>} );
ok("\x[BCE2]"  ~~ m/^<:!InControlPictures>.$/, q{Match unrelated negated <isInControlPictures>} );
ok("\x[BCE2]"  ~~ m/^<-:InControlPictures>$/, q{Match unrelated inverted <isInControlPictures>} );
ok("\x[BCE2]\c[SYMBOL FOR NULL]" ~~ m/<:InControlPictures>/, q{Match unanchored <isInControlPictures>} );

# InCurrencySymbols


ok("\c[EURO-CURRENCY SIGN]" ~~ m/^<:InCurrencySymbols>$/, q{Match <:InCurrencySymbols>} );
ok(!( "\c[EURO-CURRENCY SIGN]" ~~ m/^<:!InCurrencySymbols>.$/ ), q{Don't match negated <isInCurrencySymbols>} );
ok(!( "\c[EURO-CURRENCY SIGN]" ~~ m/^<-:InCurrencySymbols>$/ ), q{Don't match inverted <isInCurrencySymbols>} );
ok(!( "\x[8596]"  ~~ m/^<:InCurrencySymbols>$/ ), q{Don't match unrelated <isInCurrencySymbols>} );
ok("\x[8596]"  ~~ m/^<:!InCurrencySymbols>.$/, q{Match unrelated negated <isInCurrencySymbols>} );
ok("\x[8596]"  ~~ m/^<-:InCurrencySymbols>$/, q{Match unrelated inverted <isInCurrencySymbols>} );
ok("\x[8596]\c[EURO-CURRENCY SIGN]" ~~ m/<:InCurrencySymbols>/, q{Match unanchored <isInCurrencySymbols>} );

# InCyrillic


ok("\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<:InCyrillic>$/, q{Match <:InCyrillic>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<:!InCyrillic>.$/ ), q{Don't match negated <isInCyrillic>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<-:InCyrillic>$/ ), q{Don't match inverted <isInCyrillic>} );
ok(!( "\x[51B2]"  ~~ m/^<:InCyrillic>$/ ), q{Don't match unrelated <isInCyrillic>} );
ok("\x[51B2]"  ~~ m/^<:!InCyrillic>.$/, q{Match unrelated negated <isInCyrillic>} );
ok("\x[51B2]"  ~~ m/^<-:InCyrillic>$/, q{Match unrelated inverted <isInCyrillic>} );
ok("\x[51B2]\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/<:InCyrillic>/, q{Match unanchored <isInCyrillic>} );

# InCyrillicSupplementary


ok("\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/^<:InCyrillicSupplementary>$/, q{Match <:InCyrillicSupplementary>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/^<:!InCyrillicSupplementary>.$/ ), q{Don't match negated <isInCyrillicSupplementary>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/^<-:InCyrillicSupplementary>$/ ), q{Don't match inverted <isInCyrillicSupplementary>} );
ok(!( "\x[7BD9]"  ~~ m/^<:InCyrillicSupplementary>$/ ), q{Don't match unrelated <isInCyrillicSupplementary>} );
ok("\x[7BD9]"  ~~ m/^<:!InCyrillicSupplementary>.$/, q{Match unrelated negated <isInCyrillicSupplementary>} );
ok("\x[7BD9]"  ~~ m/^<-:InCyrillicSupplementary>$/, q{Match unrelated inverted <isInCyrillicSupplementary>} );
ok("\x[7BD9]\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/<:InCyrillicSupplementary>/, q{Match unanchored <isInCyrillicSupplementary>} );

# InDeseret


ok(!( "\c[TAMIL DIGIT FOUR]"  ~~ m/^<:InDeseret>$/ ), q{Don't match unrelated <isInDeseret>} );
ok("\c[TAMIL DIGIT FOUR]"  ~~ m/^<:!InDeseret>.$/, q{Match unrelated negated <isInDeseret>} );
ok("\c[TAMIL DIGIT FOUR]"  ~~ m/^<-:InDeseret>$/, q{Match unrelated inverted <isInDeseret>} );

# InDevanagari


ok("\x[0900]" ~~ m/^<:InDevanagari>$/, q{Match <:InDevanagari>} );
ok(!( "\x[0900]" ~~ m/^<:!InDevanagari>.$/ ), q{Don't match negated <isInDevanagari>} );
ok(!( "\x[0900]" ~~ m/^<-:InDevanagari>$/ ), q{Don't match inverted <isInDevanagari>} );
ok(!( "\x[BB12]"  ~~ m/^<:InDevanagari>$/ ), q{Don't match unrelated <isInDevanagari>} );
ok("\x[BB12]"  ~~ m/^<:!InDevanagari>.$/, q{Match unrelated negated <isInDevanagari>} );
ok("\x[BB12]"  ~~ m/^<-:InDevanagari>$/, q{Match unrelated inverted <isInDevanagari>} );
ok("\x[BB12]\x[0900]" ~~ m/<:InDevanagari>/, q{Match unanchored <isInDevanagari>} );

# InDingbats


ok("\x[2700]" ~~ m/^<:InDingbats>$/, q{Match <:InDingbats>} );
ok(!( "\x[2700]" ~~ m/^<:!InDingbats>.$/ ), q{Don't match negated <isInDingbats>} );
ok(!( "\x[2700]" ~~ m/^<-:InDingbats>$/ ), q{Don't match inverted <isInDingbats>} );
ok(!( "\x[D7A8]"  ~~ m/^<:InDingbats>$/ ), q{Don't match unrelated <isInDingbats>} );
ok("\x[D7A8]"  ~~ m/^<:!InDingbats>.$/, q{Match unrelated negated <isInDingbats>} );
ok("\x[D7A8]"  ~~ m/^<-:InDingbats>$/, q{Match unrelated inverted <isInDingbats>} );
ok("\x[D7A8]\x[2700]" ~~ m/<:InDingbats>/, q{Match unanchored <isInDingbats>} );

# InEnclosedAlphanumerics


ok("\c[CIRCLED DIGIT ONE]" ~~ m/^<:InEnclosedAlphanumerics>$/, q{Match <:InEnclosedAlphanumerics>} );
ok(!( "\c[CIRCLED DIGIT ONE]" ~~ m/^<:!InEnclosedAlphanumerics>.$/ ), q{Don't match negated <isInEnclosedAlphanumerics>} );
ok(!( "\c[CIRCLED DIGIT ONE]" ~~ m/^<-:InEnclosedAlphanumerics>$/ ), q{Don't match inverted <isInEnclosedAlphanumerics>} );
ok(!( "\x[C3A2]"  ~~ m/^<:InEnclosedAlphanumerics>$/ ), q{Don't match unrelated <isInEnclosedAlphanumerics>} );
ok("\x[C3A2]"  ~~ m/^<:!InEnclosedAlphanumerics>.$/, q{Match unrelated negated <isInEnclosedAlphanumerics>} );
ok("\x[C3A2]"  ~~ m/^<-:InEnclosedAlphanumerics>$/, q{Match unrelated inverted <isInEnclosedAlphanumerics>} );
ok("\x[C3A2]\c[CIRCLED DIGIT ONE]" ~~ m/<:InEnclosedAlphanumerics>/, q{Match unanchored <isInEnclosedAlphanumerics>} );

# InEnclosedCJKLettersAndMonths


ok("\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/^<:InEnclosedCJKLettersAndMonths>$/, q{Match <:InEnclosedCJKLettersAndMonths>} );
ok(!( "\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/^<:!InEnclosedCJKLettersAndMonths>.$/ ), q{Don't match negated <isInEnclosedCJKLettersAndMonths>} );
ok(!( "\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/^<-:InEnclosedCJKLettersAndMonths>$/ ), q{Don't match inverted <isInEnclosedCJKLettersAndMonths>} );
ok(!( "\x[5B44]"  ~~ m/^<:InEnclosedCJKLettersAndMonths>$/ ), q{Don't match unrelated <isInEnclosedCJKLettersAndMonths>} );
ok("\x[5B44]"  ~~ m/^<:!InEnclosedCJKLettersAndMonths>.$/, q{Match unrelated negated <isInEnclosedCJKLettersAndMonths>} );
ok("\x[5B44]"  ~~ m/^<-:InEnclosedCJKLettersAndMonths>$/, q{Match unrelated inverted <isInEnclosedCJKLettersAndMonths>} );
ok("\x[5B44]\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/<:InEnclosedCJKLettersAndMonths>/, q{Match unanchored <isInEnclosedCJKLettersAndMonths>} );

# InEthiopic


ok("\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<:InEthiopic>$/, q{Match <:InEthiopic>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<:!InEthiopic>.$/ ), q{Don't match negated <isInEthiopic>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<-:InEthiopic>$/ ), q{Don't match inverted <isInEthiopic>} );
ok(!( "\x[BBAE]"  ~~ m/^<:InEthiopic>$/ ), q{Don't match unrelated <isInEthiopic>} );
ok("\x[BBAE]"  ~~ m/^<:!InEthiopic>.$/, q{Match unrelated negated <isInEthiopic>} );
ok("\x[BBAE]"  ~~ m/^<-:InEthiopic>$/, q{Match unrelated inverted <isInEthiopic>} );
ok("\x[BBAE]\c[ETHIOPIC SYLLABLE HA]" ~~ m/<:InEthiopic>/, q{Match unanchored <isInEthiopic>} );

# InGeneralPunctuation


ok("\c[EN QUAD]" ~~ m/^<:InGeneralPunctuation>$/, q{Match <:InGeneralPunctuation>} );
ok(!( "\c[EN QUAD]" ~~ m/^<:!InGeneralPunctuation>.$/ ), q{Don't match negated <isInGeneralPunctuation>} );
ok(!( "\c[EN QUAD]" ~~ m/^<-:InGeneralPunctuation>$/ ), q{Don't match inverted <isInGeneralPunctuation>} );
ok(!( "\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]"  ~~ m/^<:InGeneralPunctuation>$/ ), q{Don't match unrelated <isInGeneralPunctuation>} );
ok("\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]"  ~~ m/^<:!InGeneralPunctuation>.$/, q{Match unrelated negated <isInGeneralPunctuation>} );
ok("\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]"  ~~ m/^<-:InGeneralPunctuation>$/, q{Match unrelated inverted <isInGeneralPunctuation>} );
ok("\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]\c[EN QUAD]" ~~ m/<:InGeneralPunctuation>/, q{Match unanchored <isInGeneralPunctuation>} );

# InGeometricShapes


ok("\c[BLACK SQUARE]" ~~ m/^<:InGeometricShapes>$/, q{Match <:InGeometricShapes>} );
ok(!( "\c[BLACK SQUARE]" ~~ m/^<:!InGeometricShapes>.$/ ), q{Don't match negated <isInGeometricShapes>} );
ok(!( "\c[BLACK SQUARE]" ~~ m/^<-:InGeometricShapes>$/ ), q{Don't match inverted <isInGeometricShapes>} );
ok(!( "\x[B700]"  ~~ m/^<:InGeometricShapes>$/ ), q{Don't match unrelated <isInGeometricShapes>} );
ok("\x[B700]"  ~~ m/^<:!InGeometricShapes>.$/, q{Match unrelated negated <isInGeometricShapes>} );
ok("\x[B700]"  ~~ m/^<-:InGeometricShapes>$/, q{Match unrelated inverted <isInGeometricShapes>} );
ok("\x[B700]\c[BLACK SQUARE]" ~~ m/<:InGeometricShapes>/, q{Match unanchored <isInGeometricShapes>} );


# InGeorgian


ok("\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<:InGeorgian>$/, q{Match <:InGeorgian>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<:!InGeorgian>.$/ ), q{Don't match negated <isInGeorgian>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<-:InGeorgian>$/ ), q{Don't match inverted <isInGeorgian>} );
ok(!( "\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]"  ~~ m/^<:InGeorgian>$/ ), q{Don't match unrelated <isInGeorgian>} );
ok("\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]"  ~~ m/^<:!InGeorgian>.$/, q{Match unrelated negated <isInGeorgian>} );
ok("\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]"  ~~ m/^<-:InGeorgian>$/, q{Match unrelated inverted <isInGeorgian>} );
ok("\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/<:InGeorgian>/, q{Match unanchored <isInGeorgian>} );

# InGothic


ok(!( "\x[4825]"  ~~ m/^<:InGothic>$/ ), q{Don't match unrelated <isInGothic>} );
ok("\x[4825]"  ~~ m/^<:!InGothic>.$/, q{Match unrelated negated <isInGothic>} );
ok("\x[4825]"  ~~ m/^<-:InGothic>$/, q{Match unrelated inverted <isInGothic>} );

# InGreekExtended


ok("\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/^<:InGreekExtended>$/, q{Match <:InGreekExtended>} );
ok(!( "\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/^<:!InGreekExtended>.$/ ), q{Don't match negated <isInGreekExtended>} );
ok(!( "\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/^<-:InGreekExtended>$/ ), q{Don't match inverted <isInGreekExtended>} );
ok(!( "\x[B9B7]"  ~~ m/^<:InGreekExtended>$/ ), q{Don't match unrelated <isInGreekExtended>} );
ok("\x[B9B7]"  ~~ m/^<:!InGreekExtended>.$/, q{Match unrelated negated <isInGreekExtended>} );
ok("\x[B9B7]"  ~~ m/^<-:InGreekExtended>$/, q{Match unrelated inverted <isInGreekExtended>} );
ok("\x[B9B7]\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/<:InGreekExtended>/, q{Match unanchored <isInGreekExtended>} );

# InGreekAndCoptic


ok("\x[0370]" ~~ m/^<:InGreekAndCoptic>$/, q{Match <:InGreekAndCoptic>} );
ok(!( "\x[0370]" ~~ m/^<:!InGreekAndCoptic>.$/ ), q{Don't match negated <isInGreekAndCoptic>} );
ok(!( "\x[0370]" ~~ m/^<-:InGreekAndCoptic>$/ ), q{Don't match inverted <isInGreekAndCoptic>} );
ok(!( "\x[7197]"  ~~ m/^<:InGreekAndCoptic>$/ ), q{Don't match unrelated <isInGreekAndCoptic>} );
ok("\x[7197]"  ~~ m/^<:!InGreekAndCoptic>.$/, q{Match unrelated negated <isInGreekAndCoptic>} );
ok("\x[7197]"  ~~ m/^<-:InGreekAndCoptic>$/, q{Match unrelated inverted <isInGreekAndCoptic>} );
ok("\x[7197]\x[0370]" ~~ m/<:InGreekAndCoptic>/, q{Match unanchored <isInGreekAndCoptic>} );

# InGujarati


ok("\x[0A80]" ~~ m/^<:InGujarati>$/, q{Match <:InGujarati>} );
ok(!( "\x[0A80]" ~~ m/^<:!InGujarati>.$/ ), q{Don't match negated <isInGujarati>} );
ok(!( "\x[0A80]" ~~ m/^<-:InGujarati>$/ ), q{Don't match inverted <isInGujarati>} );
ok(!( "\x[3B63]"  ~~ m/^<:InGujarati>$/ ), q{Don't match unrelated <isInGujarati>} );
ok("\x[3B63]"  ~~ m/^<:!InGujarati>.$/, q{Match unrelated negated <isInGujarati>} );
ok("\x[3B63]"  ~~ m/^<-:InGujarati>$/, q{Match unrelated inverted <isInGujarati>} );
ok("\x[3B63]\x[0A80]" ~~ m/<:InGujarati>/, q{Match unanchored <isInGujarati>} );

# InGurmukhi


ok("\x[0A00]" ~~ m/^<:InGurmukhi>$/, q{Match <:InGurmukhi>} );
ok(!( "\x[0A00]" ~~ m/^<:!InGurmukhi>.$/ ), q{Don't match negated <isInGurmukhi>} );
ok(!( "\x[0A00]" ~~ m/^<-:InGurmukhi>$/ ), q{Don't match inverted <isInGurmukhi>} );
ok(!( "\x[10C8]"  ~~ m/^<:InGurmukhi>$/ ), q{Don't match unrelated <isInGurmukhi>} );
ok("\x[10C8]"  ~~ m/^<:!InGurmukhi>.$/, q{Match unrelated negated <isInGurmukhi>} );
ok("\x[10C8]"  ~~ m/^<-:InGurmukhi>$/, q{Match unrelated inverted <isInGurmukhi>} );
ok("\x[10C8]\x[0A00]" ~~ m/<:InGurmukhi>/, q{Match unanchored <isInGurmukhi>} );

# InHalfwidthAndFullwidthForms


ok(!( "\x[CA55]"  ~~ m/^<:InHalfwidthAndFullwidthForms>$/ ), q{Don't match unrelated <isInHalfwidthAndFullwidthForms>} );
ok("\x[CA55]"  ~~ m/^<:!InHalfwidthAndFullwidthForms>.$/, q{Match unrelated negated <isInHalfwidthAndFullwidthForms>} );
ok("\x[CA55]"  ~~ m/^<-:InHalfwidthAndFullwidthForms>$/, q{Match unrelated inverted <isInHalfwidthAndFullwidthForms>} );

# InHangulCompatibilityJamo


ok("\x[3130]" ~~ m/^<:InHangulCompatibilityJamo>$/, q{Match <:InHangulCompatibilityJamo>} );
ok(!( "\x[3130]" ~~ m/^<:!InHangulCompatibilityJamo>.$/ ), q{Don't match negated <isInHangulCompatibilityJamo>} );
ok(!( "\x[3130]" ~~ m/^<-:InHangulCompatibilityJamo>$/ ), q{Don't match inverted <isInHangulCompatibilityJamo>} );
ok(!( "\c[MEASURED BY]"  ~~ m/^<:InHangulCompatibilityJamo>$/ ), q{Don't match unrelated <isInHangulCompatibilityJamo>} );
ok("\c[MEASURED BY]"  ~~ m/^<:!InHangulCompatibilityJamo>.$/, q{Match unrelated negated <isInHangulCompatibilityJamo>} );
ok("\c[MEASURED BY]"  ~~ m/^<-:InHangulCompatibilityJamo>$/, q{Match unrelated inverted <isInHangulCompatibilityJamo>} );
ok("\c[MEASURED BY]\x[3130]" ~~ m/<:InHangulCompatibilityJamo>/, q{Match unanchored <isInHangulCompatibilityJamo>} );

# InHangulJamo


ok("\c[HANGUL CHOSEONG KIYEOK]" ~~ m/^<:InHangulJamo>$/, q{Match <:InHangulJamo>} );
ok(!( "\c[HANGUL CHOSEONG KIYEOK]" ~~ m/^<:!InHangulJamo>.$/ ), q{Don't match negated <isInHangulJamo>} );
ok(!( "\c[HANGUL CHOSEONG KIYEOK]" ~~ m/^<-:InHangulJamo>$/ ), q{Don't match inverted <isInHangulJamo>} );
ok(!( "\x[3B72]"  ~~ m/^<:InHangulJamo>$/ ), q{Don't match unrelated <isInHangulJamo>} );
ok("\x[3B72]"  ~~ m/^<:!InHangulJamo>.$/, q{Match unrelated negated <isInHangulJamo>} );
ok("\x[3B72]"  ~~ m/^<-:InHangulJamo>$/, q{Match unrelated inverted <isInHangulJamo>} );
ok("\x[3B72]\c[HANGUL CHOSEONG KIYEOK]" ~~ m/<:InHangulJamo>/, q{Match unanchored <isInHangulJamo>} );

# InHangulSyllables


ok("\x[CD95]" ~~ m/^<:InHangulSyllables>$/, q{Match <:InHangulSyllables>} );
ok(!( "\x[CD95]" ~~ m/^<:!InHangulSyllables>.$/ ), q{Don't match negated <isInHangulSyllables>} );
ok(!( "\x[CD95]" ~~ m/^<-:InHangulSyllables>$/ ), q{Don't match inverted <isInHangulSyllables>} );
ok(!( "\x[D7B0]"  ~~ m/^<:InHangulSyllables>$/ ), q{Don't match unrelated <isInHangulSyllables>} );
ok("\x[D7B0]"  ~~ m/^<:!InHangulSyllables>.$/, q{Match unrelated negated <isInHangulSyllables>} );
ok("\x[D7B0]"  ~~ m/^<-:InHangulSyllables>$/, q{Match unrelated inverted <isInHangulSyllables>} );
ok("\x[D7B0]\x[CD95]" ~~ m/<:InHangulSyllables>/, q{Match unanchored <isInHangulSyllables>} );

# InHanunoo


ok("\c[HANUNOO LETTER A]" ~~ m/^<:InHanunoo>$/, q{Match <:InHanunoo>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<:!InHanunoo>.$/ ), q{Don't match negated <isInHanunoo>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<-:InHanunoo>$/ ), q{Don't match inverted <isInHanunoo>} );
ok(!( "\x[6F4F]"  ~~ m/^<:InHanunoo>$/ ), q{Don't match unrelated <isInHanunoo>} );
ok("\x[6F4F]"  ~~ m/^<:!InHanunoo>.$/, q{Match unrelated negated <isInHanunoo>} );
ok("\x[6F4F]"  ~~ m/^<-:InHanunoo>$/, q{Match unrelated inverted <isInHanunoo>} );
ok("\x[6F4F]\c[HANUNOO LETTER A]" ~~ m/<:InHanunoo>/, q{Match unanchored <isInHanunoo>} );

# InHebrew


ok("\x[0590]" ~~ m/^<:InHebrew>$/, q{Match <:InHebrew>} );
ok(!( "\x[0590]" ~~ m/^<:!InHebrew>.$/ ), q{Don't match negated <isInHebrew>} );
ok(!( "\x[0590]" ~~ m/^<-:InHebrew>$/ ), q{Don't match inverted <isInHebrew>} );
ok(!( "\x[0777]"  ~~ m/^<:InHebrew>$/ ), q{Don't match unrelated <isInHebrew>} );
ok("\x[0777]"  ~~ m/^<:!InHebrew>.$/, q{Match unrelated negated <isInHebrew>} );
ok("\x[0777]"  ~~ m/^<-:InHebrew>$/, q{Match unrelated inverted <isInHebrew>} );
ok("\x[0777]\x[0590]" ~~ m/<:InHebrew>/, q{Match unanchored <isInHebrew>} );

# InHighPrivateUseSurrogates


ok(!( "\x[D04F]"  ~~ m/^<:InHighPrivateUseSurrogates>$/ ), q{Don't match unrelated <isInHighPrivateUseSurrogates>} );
ok("\x[D04F]"  ~~ m/^<:!InHighPrivateUseSurrogates>.$/, q{Match unrelated negated <isInHighPrivateUseSurrogates>} );
ok("\x[D04F]"  ~~ m/^<-:InHighPrivateUseSurrogates>$/, q{Match unrelated inverted <isInHighPrivateUseSurrogates>} );

# InHighSurrogates


ok(!( "\x[D085]"  ~~ m/^<:InHighSurrogates>$/ ), q{Don't match unrelated <isInHighSurrogates>} );
ok("\x[D085]"  ~~ m/^<:!InHighSurrogates>.$/, q{Match unrelated negated <isInHighSurrogates>} );
ok("\x[D085]"  ~~ m/^<-:InHighSurrogates>$/, q{Match unrelated inverted <isInHighSurrogates>} );

# InHiragana


ok("\x[3040]" ~~ m/^<:InHiragana>$/, q{Match <:InHiragana>} );
ok(!( "\x[3040]" ~~ m/^<:!InHiragana>.$/ ), q{Don't match negated <isInHiragana>} );
ok(!( "\x[3040]" ~~ m/^<-:InHiragana>$/ ), q{Don't match inverted <isInHiragana>} );
ok(!( "\x[AC7C]"  ~~ m/^<:InHiragana>$/ ), q{Don't match unrelated <isInHiragana>} );
ok("\x[AC7C]"  ~~ m/^<:!InHiragana>.$/, q{Match unrelated negated <isInHiragana>} );
ok("\x[AC7C]"  ~~ m/^<-:InHiragana>$/, q{Match unrelated inverted <isInHiragana>} );
ok("\x[AC7C]\x[3040]" ~~ m/<:InHiragana>/, q{Match unanchored <isInHiragana>} );

# InIPAExtensions


ok("\c[LATIN SMALL LETTER TURNED A]" ~~ m/^<:InIPAExtensions>$/, q{Match <:InIPAExtensions>} );
ok(!( "\c[LATIN SMALL LETTER TURNED A]" ~~ m/^<:!InIPAExtensions>.$/ ), q{Don't match negated <isInIPAExtensions>} );
ok(!( "\c[LATIN SMALL LETTER TURNED A]" ~~ m/^<-:InIPAExtensions>$/ ), q{Don't match inverted <isInIPAExtensions>} );
ok(!( "\c[HANGUL LETTER SSANGIEUNG]"  ~~ m/^<:InIPAExtensions>$/ ), q{Don't match unrelated <isInIPAExtensions>} );
ok("\c[HANGUL LETTER SSANGIEUNG]"  ~~ m/^<:!InIPAExtensions>.$/, q{Match unrelated negated <isInIPAExtensions>} );
ok("\c[HANGUL LETTER SSANGIEUNG]"  ~~ m/^<-:InIPAExtensions>$/, q{Match unrelated inverted <isInIPAExtensions>} );
ok("\c[HANGUL LETTER SSANGIEUNG]\c[LATIN SMALL LETTER TURNED A]" ~~ m/<:InIPAExtensions>/, q{Match unanchored <isInIPAExtensions>} );

# InIdeographicDescriptionCharacters


ok("\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<:InIdeographicDescriptionCharacters>$/, q{Match <:InIdeographicDescriptionCharacters>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<:!InIdeographicDescriptionCharacters>.$/ ), q{Don't match negated <isInIdeographicDescriptionCharacters>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<-:InIdeographicDescriptionCharacters>$/ ), q{Don't match inverted <isInIdeographicDescriptionCharacters>} );
ok(!( "\x[9160]"  ~~ m/^<:InIdeographicDescriptionCharacters>$/ ), q{Don't match unrelated <isInIdeographicDescriptionCharacters>} );
ok("\x[9160]"  ~~ m/^<:!InIdeographicDescriptionCharacters>.$/, q{Match unrelated negated <isInIdeographicDescriptionCharacters>} );
ok("\x[9160]"  ~~ m/^<-:InIdeographicDescriptionCharacters>$/, q{Match unrelated inverted <isInIdeographicDescriptionCharacters>} );
ok("\x[9160]\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/<:InIdeographicDescriptionCharacters>/, q{Match unanchored <isInIdeographicDescriptionCharacters>} );

# InKanbun


ok("\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/^<:InKanbun>$/, q{Match <:InKanbun>} );
ok(!( "\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/^<:!InKanbun>.$/ ), q{Don't match negated <isInKanbun>} );
ok(!( "\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/^<-:InKanbun>$/ ), q{Don't match inverted <isInKanbun>} );
ok(!( "\x[A80C]"  ~~ m/^<:InKanbun>$/ ), q{Don't match unrelated <isInKanbun>} );
ok("\x[A80C]"  ~~ m/^<:!InKanbun>.$/, q{Match unrelated negated <isInKanbun>} );
ok("\x[A80C]"  ~~ m/^<-:InKanbun>$/, q{Match unrelated inverted <isInKanbun>} );
ok("\x[A80C]\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/<:InKanbun>/, q{Match unanchored <isInKanbun>} );

# InKangxiRadicals


ok("\c[KANGXI RADICAL ONE]" ~~ m/^<:InKangxiRadicals>$/, q{Match <:InKangxiRadicals>} );
ok(!( "\c[KANGXI RADICAL ONE]" ~~ m/^<:!InKangxiRadicals>.$/ ), q{Don't match negated <isInKangxiRadicals>} );
ok(!( "\c[KANGXI RADICAL ONE]" ~~ m/^<-:InKangxiRadicals>$/ ), q{Don't match inverted <isInKangxiRadicals>} );
ok(!( "\x[891A]"  ~~ m/^<:InKangxiRadicals>$/ ), q{Don't match unrelated <isInKangxiRadicals>} );
ok("\x[891A]"  ~~ m/^<:!InKangxiRadicals>.$/, q{Match unrelated negated <isInKangxiRadicals>} );
ok("\x[891A]"  ~~ m/^<-:InKangxiRadicals>$/, q{Match unrelated inverted <isInKangxiRadicals>} );
ok("\x[891A]\c[KANGXI RADICAL ONE]" ~~ m/<:InKangxiRadicals>/, q{Match unanchored <isInKangxiRadicals>} );

# InKannada


ok("\x[0C80]" ~~ m/^<:InKannada>$/, q{Match <:InKannada>} );
ok(!( "\x[0C80]" ~~ m/^<:!InKannada>.$/ ), q{Don't match negated <isInKannada>} );
ok(!( "\x[0C80]" ~~ m/^<-:InKannada>$/ ), q{Don't match inverted <isInKannada>} );
ok(!( "\x[B614]"  ~~ m/^<:InKannada>$/ ), q{Don't match unrelated <isInKannada>} );
ok("\x[B614]"  ~~ m/^<:!InKannada>.$/, q{Match unrelated negated <isInKannada>} );
ok("\x[B614]"  ~~ m/^<-:InKannada>$/, q{Match unrelated inverted <isInKannada>} );
ok("\x[B614]\x[0C80]" ~~ m/<:InKannada>/, q{Match unanchored <isInKannada>} );

# InKatakana


ok("\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/^<:InKatakana>$/, q{Match <:InKatakana>} );
ok(!( "\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/^<:!InKatakana>.$/ ), q{Don't match negated <isInKatakana>} );
ok(!( "\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/^<-:InKatakana>$/ ), q{Don't match inverted <isInKatakana>} );
ok(!( "\x[7EB8]"  ~~ m/^<:InKatakana>$/ ), q{Don't match unrelated <isInKatakana>} );
ok("\x[7EB8]"  ~~ m/^<:!InKatakana>.$/, q{Match unrelated negated <isInKatakana>} );
ok("\x[7EB8]"  ~~ m/^<-:InKatakana>$/, q{Match unrelated inverted <isInKatakana>} );
ok("\x[7EB8]\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/<:InKatakana>/, q{Match unanchored <isInKatakana>} );

# InKatakanaPhoneticExtensions


ok("\c[KATAKANA LETTER SMALL KU]" ~~ m/^<:InKatakanaPhoneticExtensions>$/, q{Match <:InKatakanaPhoneticExtensions>} );
ok(!( "\c[KATAKANA LETTER SMALL KU]" ~~ m/^<:!InKatakanaPhoneticExtensions>.$/ ), q{Don't match negated <isInKatakanaPhoneticExtensions>} );
ok(!( "\c[KATAKANA LETTER SMALL KU]" ~~ m/^<-:InKatakanaPhoneticExtensions>$/ ), q{Don't match inverted <isInKatakanaPhoneticExtensions>} );
ok(!( "\x[97C2]"  ~~ m/^<:InKatakanaPhoneticExtensions>$/ ), q{Don't match unrelated <isInKatakanaPhoneticExtensions>} );
ok("\x[97C2]"  ~~ m/^<:!InKatakanaPhoneticExtensions>.$/, q{Match unrelated negated <isInKatakanaPhoneticExtensions>} );
ok("\x[97C2]"  ~~ m/^<-:InKatakanaPhoneticExtensions>$/, q{Match unrelated inverted <isInKatakanaPhoneticExtensions>} );
ok("\x[97C2]\c[KATAKANA LETTER SMALL KU]" ~~ m/<:InKatakanaPhoneticExtensions>/, q{Match unanchored <isInKatakanaPhoneticExtensions>} );

# InKhmer

ok("\c[KHMER LETTER KA]" ~~ m/^<:InKhmer>$/, q{Match <:InKhmer>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<:!InKhmer>.$/ ), q{Don't match negated <isInKhmer>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<-:InKhmer>$/ ), q{Don't match inverted <isInKhmer>} );
ok(!( "\x[CAFA]"  ~~ m/^<:InKhmer>$/ ), q{Don't match unrelated <isInKhmer>} );
ok("\x[CAFA]"  ~~ m/^<:!InKhmer>.$/, q{Match unrelated negated <isInKhmer>} );
ok("\x[CAFA]"  ~~ m/^<-:InKhmer>$/, q{Match unrelated inverted <isInKhmer>} );
ok("\x[CAFA]\c[KHMER LETTER KA]" ~~ m/<:InKhmer>/, q{Match unanchored <isInKhmer>} );

# InLao


ok("\x[0E80]" ~~ m/^<:InLao>$/, q{Match <:InLao>} );
ok(!( "\x[0E80]" ~~ m/^<:!InLao>.$/ ), q{Don't match negated <isInLao>} );
ok(!( "\x[0E80]" ~~ m/^<-:InLao>$/ ), q{Don't match inverted <isInLao>} );
ok(!( "\x[07BF]"  ~~ m/^<:InLao>$/ ), q{Don't match unrelated <isInLao>} );
ok("\x[07BF]"  ~~ m/^<:!InLao>.$/, q{Match unrelated negated <isInLao>} );
ok("\x[07BF]"  ~~ m/^<-:InLao>$/, q{Match unrelated inverted <isInLao>} );
ok("\x[07BF]\x[0E80]" ~~ m/<:InLao>/, q{Match unanchored <isInLao>} );

# InLatin1Supplement


ok("\x[0080]" ~~ m/^<:InLatin1Supplement>$/, q{Match <:InLatin1Supplement>} );
ok(!( "\x[0080]" ~~ m/^<:!InLatin1Supplement>.$/ ), q{Don't match negated <isInLatin1Supplement>} );
ok(!( "\x[0080]" ~~ m/^<-:InLatin1Supplement>$/ ), q{Don't match inverted <isInLatin1Supplement>} );
ok(!( "\x[D062]"  ~~ m/^<:InLatin1Supplement>$/ ), q{Don't match unrelated <isInLatin1Supplement>} );
ok("\x[D062]"  ~~ m/^<:!InLatin1Supplement>.$/, q{Match unrelated negated <isInLatin1Supplement>} );
ok("\x[D062]"  ~~ m/^<-:InLatin1Supplement>$/, q{Match unrelated inverted <isInLatin1Supplement>} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[D062]\x[0080]" ~~ m/<:InLatin1Supplement>/, q{Match unanchored <isInLatin1Supplement>} );

# InLatinExtendedA


ok("\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/^<:InLatinExtendedA>$/, q{Match <:InLatinExtendedA>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/^<:!InLatinExtendedA>.$/ ), q{Don't match negated <isInLatinExtendedA>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/^<-:InLatinExtendedA>$/ ), q{Don't match inverted <isInLatinExtendedA>} );
ok(!( "\c[IDEOGRAPHIC ANNOTATION EARTH MARK]"  ~~ m/^<:InLatinExtendedA>$/ ), q{Don't match unrelated <isInLatinExtendedA>} );
ok("\c[IDEOGRAPHIC ANNOTATION EARTH MARK]"  ~~ m/^<:!InLatinExtendedA>.$/, q{Match unrelated negated <isInLatinExtendedA>} );
ok("\c[IDEOGRAPHIC ANNOTATION EARTH MARK]"  ~~ m/^<-:InLatinExtendedA>$/, q{Match unrelated inverted <isInLatinExtendedA>} );
ok("\c[IDEOGRAPHIC ANNOTATION EARTH MARK]\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/<:InLatinExtendedA>/, q{Match unanchored <isInLatinExtendedA>} );

# InLatinExtendedAdditional


ok("\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/^<:InLatinExtendedAdditional>$/, q{Match <:InLatinExtendedAdditional>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/^<:!InLatinExtendedAdditional>.$/ ), q{Don't match negated <isInLatinExtendedAdditional>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/^<-:InLatinExtendedAdditional>$/ ), q{Don't match inverted <isInLatinExtendedAdditional>} );
ok(!( "\x[9A44]"  ~~ m/^<:InLatinExtendedAdditional>$/ ), q{Don't match unrelated <isInLatinExtendedAdditional>} );
ok("\x[9A44]"  ~~ m/^<:!InLatinExtendedAdditional>.$/, q{Match unrelated negated <isInLatinExtendedAdditional>} );
ok("\x[9A44]"  ~~ m/^<-:InLatinExtendedAdditional>$/, q{Match unrelated inverted <isInLatinExtendedAdditional>} );
ok("\x[9A44]\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/<:InLatinExtendedAdditional>/, q{Match unanchored <isInLatinExtendedAdditional>} );

# InLatinExtendedB


ok("\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/^<:InLatinExtendedB>$/, q{Match <:InLatinExtendedB>} );
ok(!( "\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/^<:!InLatinExtendedB>.$/ ), q{Don't match negated <isInLatinExtendedB>} );
ok(!( "\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/^<-:InLatinExtendedB>$/ ), q{Don't match inverted <isInLatinExtendedB>} );
ok(!( "\x[7544]"  ~~ m/^<:InLatinExtendedB>$/ ), q{Don't match unrelated <isInLatinExtendedB>} );
ok("\x[7544]"  ~~ m/^<:!InLatinExtendedB>.$/, q{Match unrelated negated <isInLatinExtendedB>} );
ok("\x[7544]"  ~~ m/^<-:InLatinExtendedB>$/, q{Match unrelated inverted <isInLatinExtendedB>} );
ok("\x[7544]\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/<:InLatinExtendedB>/, q{Match unanchored <isInLatinExtendedB>} );

# InLetterlikeSymbols


ok("\c[ACCOUNT OF]" ~~ m/^<:InLetterlikeSymbols>$/, q{Match <:InLetterlikeSymbols>} );
ok(!( "\c[ACCOUNT OF]" ~~ m/^<:!InLetterlikeSymbols>.$/ ), q{Don't match negated <isInLetterlikeSymbols>} );
ok(!( "\c[ACCOUNT OF]" ~~ m/^<-:InLetterlikeSymbols>$/ ), q{Don't match inverted <isInLetterlikeSymbols>} );
ok(!( "\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]"  ~~ m/^<:InLetterlikeSymbols>$/ ), q{Don't match unrelated <isInLetterlikeSymbols>} );
ok("\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]"  ~~ m/^<:!InLetterlikeSymbols>.$/, q{Match unrelated negated <isInLetterlikeSymbols>} );
ok("\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]"  ~~ m/^<-:InLetterlikeSymbols>$/, q{Match unrelated inverted <isInLetterlikeSymbols>} );
ok("\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]\c[ACCOUNT OF]" ~~ m/<:InLetterlikeSymbols>/, q{Match unanchored <isInLetterlikeSymbols>} );

# InLowSurrogates


ok(!( "\x[5ECC]"  ~~ m/^<:InLowSurrogates>$/ ), q{Don't match unrelated <isInLowSurrogates>} );
ok("\x[5ECC]"  ~~ m/^<:!InLowSurrogates>.$/, q{Match unrelated negated <isInLowSurrogates>} );
ok("\x[5ECC]"  ~~ m/^<-:InLowSurrogates>$/, q{Match unrelated inverted <isInLowSurrogates>} );

# InMalayalam


ok("\x[0D00]" ~~ m/^<:InMalayalam>$/, q{Match <:InMalayalam>} );
ok(!( "\x[0D00]" ~~ m/^<:!InMalayalam>.$/ ), q{Don't match negated <isInMalayalam>} );
ok(!( "\x[0D00]" ~~ m/^<-:InMalayalam>$/ ), q{Don't match inverted <isInMalayalam>} );
ok(!( "\x[3457]"  ~~ m/^<:InMalayalam>$/ ), q{Don't match unrelated <isInMalayalam>} );
ok("\x[3457]"  ~~ m/^<:!InMalayalam>.$/, q{Match unrelated negated <isInMalayalam>} );
ok("\x[3457]"  ~~ m/^<-:InMalayalam>$/, q{Match unrelated inverted <isInMalayalam>} );
ok("\x[3457]\x[0D00]" ~~ m/<:InMalayalam>/, q{Match unanchored <isInMalayalam>} );

# InMathematicalAlphanumericSymbols


ok(!( "\x[6B79]"  ~~ m/^<:InMathematicalAlphanumericSymbols>$/ ), q{Don't match unrelated <isInMathematicalAlphanumericSymbols>} );
ok("\x[6B79]"  ~~ m/^<:!InMathematicalAlphanumericSymbols>.$/, q{Match unrelated negated <isInMathematicalAlphanumericSymbols>} );
ok("\x[6B79]"  ~~ m/^<-:InMathematicalAlphanumericSymbols>$/, q{Match unrelated inverted <isInMathematicalAlphanumericSymbols>} );

# InMathematicalOperators


ok("\c[FOR ALL]" ~~ m/^<:InMathematicalOperators>$/, q{Match <:InMathematicalOperators>} );
ok(!( "\c[FOR ALL]" ~~ m/^<:!InMathematicalOperators>.$/ ), q{Don't match negated <isInMathematicalOperators>} );
ok(!( "\c[FOR ALL]" ~~ m/^<-:InMathematicalOperators>$/ ), q{Don't match inverted <isInMathematicalOperators>} );
ok(!( "\x[BBC6]"  ~~ m/^<:InMathematicalOperators>$/ ), q{Don't match unrelated <isInMathematicalOperators>} );
ok("\x[BBC6]"  ~~ m/^<:!InMathematicalOperators>.$/, q{Match unrelated negated <isInMathematicalOperators>} );
ok("\x[BBC6]"  ~~ m/^<-:InMathematicalOperators>$/, q{Match unrelated inverted <isInMathematicalOperators>} );
ok("\x[BBC6]\c[FOR ALL]" ~~ m/<:InMathematicalOperators>/, q{Match unanchored <isInMathematicalOperators>} );

# InMiscellaneousMathematicalSymbolsA


ok("\x[27C0]" ~~ m/^<:InMiscellaneousMathematicalSymbolsA>$/, q{Match <:InMiscellaneousMathematicalSymbolsA>} );
ok(!( "\x[27C0]" ~~ m/^<:!InMiscellaneousMathematicalSymbolsA>.$/ ), q{Don't match negated <isInMiscellaneousMathematicalSymbolsA>} );
ok(!( "\x[27C0]" ~~ m/^<-:InMiscellaneousMathematicalSymbolsA>$/ ), q{Don't match inverted <isInMiscellaneousMathematicalSymbolsA>} );
ok(!( "\x[065D]"  ~~ m/^<:InMiscellaneousMathematicalSymbolsA>$/ ), q{Don't match unrelated <isInMiscellaneousMathematicalSymbolsA>} );
ok("\x[065D]"  ~~ m/^<:!InMiscellaneousMathematicalSymbolsA>.$/, q{Match unrelated negated <isInMiscellaneousMathematicalSymbolsA>} );
ok("\x[065D]"  ~~ m/^<-:InMiscellaneousMathematicalSymbolsA>$/, q{Match unrelated inverted <isInMiscellaneousMathematicalSymbolsA>} );
ok("\x[065D]\x[27C0]" ~~ m/<:InMiscellaneousMathematicalSymbolsA>/, q{Match unanchored <isInMiscellaneousMathematicalSymbolsA>} );

# InMiscellaneousMathematicalSymbolsB


ok("\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/^<:InMiscellaneousMathematicalSymbolsB>$/, q{Match <:InMiscellaneousMathematicalSymbolsB>} );
ok(!( "\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/^<:!InMiscellaneousMathematicalSymbolsB>.$/ ), q{Don't match negated <isInMiscellaneousMathematicalSymbolsB>} );
ok(!( "\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/^<-:InMiscellaneousMathematicalSymbolsB>$/ ), q{Don't match inverted <isInMiscellaneousMathematicalSymbolsB>} );
ok(!( "\x[56A6]"  ~~ m/^<:InMiscellaneousMathematicalSymbolsB>$/ ), q{Don't match unrelated <isInMiscellaneousMathematicalSymbolsB>} );
ok("\x[56A6]"  ~~ m/^<:!InMiscellaneousMathematicalSymbolsB>.$/, q{Match unrelated negated <isInMiscellaneousMathematicalSymbolsB>} );
ok("\x[56A6]"  ~~ m/^<-:InMiscellaneousMathematicalSymbolsB>$/, q{Match unrelated inverted <isInMiscellaneousMathematicalSymbolsB>} );
ok("\x[56A6]\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/<:InMiscellaneousMathematicalSymbolsB>/, q{Match unanchored <isInMiscellaneousMathematicalSymbolsB>} );

# InMiscellaneousSymbols


ok("\c[BLACK SUN WITH RAYS]" ~~ m/^<:InMiscellaneousSymbols>$/, q{Match <:InMiscellaneousSymbols>} );
ok(!( "\c[BLACK SUN WITH RAYS]" ~~ m/^<:!InMiscellaneousSymbols>.$/ ), q{Don't match negated <isInMiscellaneousSymbols>} );
ok(!( "\c[BLACK SUN WITH RAYS]" ~~ m/^<-:InMiscellaneousSymbols>$/ ), q{Don't match inverted <isInMiscellaneousSymbols>} );
ok(!( "\x[3EE7]"  ~~ m/^<:InMiscellaneousSymbols>$/ ), q{Don't match unrelated <isInMiscellaneousSymbols>} );
ok("\x[3EE7]"  ~~ m/^<:!InMiscellaneousSymbols>.$/, q{Match unrelated negated <isInMiscellaneousSymbols>} );
ok("\x[3EE7]"  ~~ m/^<-:InMiscellaneousSymbols>$/, q{Match unrelated inverted <isInMiscellaneousSymbols>} );
ok("\x[3EE7]\c[BLACK SUN WITH RAYS]" ~~ m/<:InMiscellaneousSymbols>/, q{Match unanchored <isInMiscellaneousSymbols>} );

# InMiscellaneousTechnical


ok("\c[DIAMETER SIGN]" ~~ m/^<:InMiscellaneousTechnical>$/, q{Match <:InMiscellaneousTechnical>} );
ok(!( "\c[DIAMETER SIGN]" ~~ m/^<:!InMiscellaneousTechnical>.$/ ), q{Don't match negated <isInMiscellaneousTechnical>} );
ok(!( "\c[DIAMETER SIGN]" ~~ m/^<-:InMiscellaneousTechnical>$/ ), q{Don't match inverted <isInMiscellaneousTechnical>} );
ok(!( "\x[2EFC]"  ~~ m/^<:InMiscellaneousTechnical>$/ ), q{Don't match unrelated <isInMiscellaneousTechnical>} );
ok("\x[2EFC]"  ~~ m/^<:!InMiscellaneousTechnical>.$/, q{Match unrelated negated <isInMiscellaneousTechnical>} );
ok("\x[2EFC]"  ~~ m/^<-:InMiscellaneousTechnical>$/, q{Match unrelated inverted <isInMiscellaneousTechnical>} );
ok("\x[2EFC]\c[DIAMETER SIGN]" ~~ m/<:InMiscellaneousTechnical>/, q{Match unanchored <isInMiscellaneousTechnical>} );

# InMongolian


ok("\c[MONGOLIAN BIRGA]" ~~ m/^<:InMongolian>$/, q{Match <:InMongolian>} );
ok(!( "\c[MONGOLIAN BIRGA]" ~~ m/^<:!InMongolian>.$/ ), q{Don't match negated <isInMongolian>} );
ok(!( "\c[MONGOLIAN BIRGA]" ~~ m/^<-:InMongolian>$/ ), q{Don't match inverted <isInMongolian>} );
ok(!( "\x[AFB4]"  ~~ m/^<:InMongolian>$/ ), q{Don't match unrelated <isInMongolian>} );
ok("\x[AFB4]"  ~~ m/^<:!InMongolian>.$/, q{Match unrelated negated <isInMongolian>} );
ok("\x[AFB4]"  ~~ m/^<-:InMongolian>$/, q{Match unrelated inverted <isInMongolian>} );
ok("\x[AFB4]\c[MONGOLIAN BIRGA]" ~~ m/<:InMongolian>/, q{Match unanchored <isInMongolian>} );

# InMusicalSymbols


ok(!( "\x[0CE4]"  ~~ m/^<:InMusicalSymbols>$/ ), q{Don't match unrelated <isInMusicalSymbols>} );
ok("\x[0CE4]"  ~~ m/^<:!InMusicalSymbols>.$/, q{Match unrelated negated <isInMusicalSymbols>} );
ok("\x[0CE4]"  ~~ m/^<-:InMusicalSymbols>$/, q{Match unrelated inverted <isInMusicalSymbols>} );

# InMyanmar


ok("\c[MYANMAR LETTER KA]" ~~ m/^<:InMyanmar>$/, q{Match <:InMyanmar>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<:!InMyanmar>.$/ ), q{Don't match negated <isInMyanmar>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<-:InMyanmar>$/ ), q{Don't match inverted <isInMyanmar>} );
ok(!( "\x[1DDB]"  ~~ m/^<:InMyanmar>$/ ), q{Don't match unrelated <isInMyanmar>} );
ok("\x[1DDB]"  ~~ m/^<:!InMyanmar>.$/, q{Match unrelated negated <isInMyanmar>} );
ok("\x[1DDB]"  ~~ m/^<-:InMyanmar>$/, q{Match unrelated inverted <isInMyanmar>} );
ok("\x[1DDB]\c[MYANMAR LETTER KA]" ~~ m/<:InMyanmar>/, q{Match unanchored <isInMyanmar>} );

# InNumberForms

ok("\x[2150]" ~~ m/^<:InNumberForms>$/, q{Match <:InNumberForms>} );
ok(!( "\x[2150]" ~~ m/^<:!InNumberForms>.$/ ), q{Don't match negated <isInNumberForms>} );
ok(!( "\x[2150]" ~~ m/^<-:InNumberForms>$/ ), q{Don't match inverted <isInNumberForms>} );
ok(!( "\c[BLACK RIGHT-POINTING SMALL TRIANGLE]"  ~~ m/^<:InNumberForms>$/ ), q{Don't match unrelated <isInNumberForms>} );
ok("\c[BLACK RIGHT-POINTING SMALL TRIANGLE]"  ~~ m/^<:!InNumberForms>.$/, q{Match unrelated negated <isInNumberForms>} );
ok("\c[BLACK RIGHT-POINTING SMALL TRIANGLE]"  ~~ m/^<-:InNumberForms>$/, q{Match unrelated inverted <isInNumberForms>} );
ok("\c[BLACK RIGHT-POINTING SMALL TRIANGLE]\x[2150]" ~~ m/<:InNumberForms>/, q{Match unanchored <isInNumberForms>} );

# InOgham


ok("\c[OGHAM SPACE MARK]" ~~ m/^<:InOgham>$/, q{Match <:InOgham>} );
ok(!( "\c[OGHAM SPACE MARK]" ~~ m/^<:!InOgham>.$/ ), q{Don't match negated <isInOgham>} );
ok(!( "\c[OGHAM SPACE MARK]" ~~ m/^<-:InOgham>$/ ), q{Don't match inverted <isInOgham>} );
ok(!( "\x[768C]"  ~~ m/^<:InOgham>$/ ), q{Don't match unrelated <isInOgham>} );
ok("\x[768C]"  ~~ m/^<:!InOgham>.$/, q{Match unrelated negated <isInOgham>} );
ok("\x[768C]"  ~~ m/^<-:InOgham>$/, q{Match unrelated inverted <isInOgham>} );
ok("\x[768C]\c[OGHAM SPACE MARK]" ~~ m/<:InOgham>/, q{Match unanchored <isInOgham>} );

# InOldItalic


ok(!( "\x[C597]"  ~~ m/^<:InOldItalic>$/ ), q{Don't match unrelated <isInOldItalic>} );
ok("\x[C597]"  ~~ m/^<:!InOldItalic>.$/, q{Match unrelated negated <isInOldItalic>} );
ok("\x[C597]"  ~~ m/^<-:InOldItalic>$/, q{Match unrelated inverted <isInOldItalic>} );

# InOpticalCharacterRecognition


ok("\c[OCR HOOK]" ~~ m/^<:InOpticalCharacterRecognition>$/, q{Match <:InOpticalCharacterRecognition>} );
ok(!( "\c[OCR HOOK]" ~~ m/^<:!InOpticalCharacterRecognition>.$/ ), q{Don't match negated <isInOpticalCharacterRecognition>} );
ok(!( "\c[OCR HOOK]" ~~ m/^<-:InOpticalCharacterRecognition>$/ ), q{Don't match inverted <isInOpticalCharacterRecognition>} );
ok(!( "\x[BE80]"  ~~ m/^<:InOpticalCharacterRecognition>$/ ), q{Don't match unrelated <isInOpticalCharacterRecognition>} );
ok("\x[BE80]"  ~~ m/^<:!InOpticalCharacterRecognition>.$/, q{Match unrelated negated <isInOpticalCharacterRecognition>} );
ok("\x[BE80]"  ~~ m/^<-:InOpticalCharacterRecognition>$/, q{Match unrelated inverted <isInOpticalCharacterRecognition>} );
ok("\x[BE80]\c[OCR HOOK]" ~~ m/<:InOpticalCharacterRecognition>/, q{Match unanchored <isInOpticalCharacterRecognition>} );

# InOriya


ok("\x[0B00]" ~~ m/^<:InOriya>$/, q{Match <:InOriya>} );
ok(!( "\x[0B00]" ~~ m/^<:!InOriya>.$/ ), q{Don't match negated <isInOriya>} );
ok(!( "\x[0B00]" ~~ m/^<-:InOriya>$/ ), q{Don't match inverted <isInOriya>} );
ok(!( "\c[YI SYLLABLE GGEX]"  ~~ m/^<:InOriya>$/ ), q{Don't match unrelated <isInOriya>} );
ok("\c[YI SYLLABLE GGEX]"  ~~ m/^<:!InOriya>.$/, q{Match unrelated negated <isInOriya>} );
ok("\c[YI SYLLABLE GGEX]"  ~~ m/^<-:InOriya>$/, q{Match unrelated inverted <isInOriya>} );
ok("\c[YI SYLLABLE GGEX]\x[0B00]" ~~ m/<:InOriya>/, q{Match unanchored <isInOriya>} );

# InPrivateUseArea


ok(!( "\x[B6B1]"  ~~ m/^<:InPrivateUseArea>$/ ), q{Don't match unrelated <isInPrivateUseArea>} );
ok("\x[B6B1]"  ~~ m/^<:!InPrivateUseArea>.$/, q{Match unrelated negated <isInPrivateUseArea>} );
ok("\x[B6B1]"  ~~ m/^<-:InPrivateUseArea>$/, q{Match unrelated inverted <isInPrivateUseArea>} );

# InRunic


ok("\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<:InRunic>$/, q{Match <:InRunic>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<:!InRunic>.$/ ), q{Don't match negated <isInRunic>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<-:InRunic>$/ ), q{Don't match inverted <isInRunic>} );
ok(!( "\c[SINHALA LETTER MAHAAPRAANA KAYANNA]"  ~~ m/^<:InRunic>$/ ), q{Don't match unrelated <isInRunic>} );
ok("\c[SINHALA LETTER MAHAAPRAANA KAYANNA]"  ~~ m/^<:!InRunic>.$/, q{Match unrelated negated <isInRunic>} );
ok("\c[SINHALA LETTER MAHAAPRAANA KAYANNA]"  ~~ m/^<-:InRunic>$/, q{Match unrelated inverted <isInRunic>} );
ok("\c[SINHALA LETTER MAHAAPRAANA KAYANNA]\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/<:InRunic>/, q{Match unanchored <isInRunic>} );

# InSinhala


ok("\x[0D80]" ~~ m/^<:InSinhala>$/, q{Match <:InSinhala>} );
ok(!( "\x[0D80]" ~~ m/^<:!InSinhala>.$/ ), q{Don't match negated <isInSinhala>} );
ok(!( "\x[0D80]" ~~ m/^<-:InSinhala>$/ ), q{Don't match inverted <isInSinhala>} );
ok(!( "\x[1060]"  ~~ m/^<:InSinhala>$/ ), q{Don't match unrelated <isInSinhala>} );
ok("\x[1060]"  ~~ m/^<:!InSinhala>.$/, q{Match unrelated negated <isInSinhala>} );
ok("\x[1060]"  ~~ m/^<-:InSinhala>$/, q{Match unrelated inverted <isInSinhala>} );
ok("\x[1060]\x[0D80]" ~~ m/<:InSinhala>/, q{Match unanchored <isInSinhala>} );

# InSmallFormVariants


ok(!( "\x[5285]"  ~~ m/^<:InSmallFormVariants>$/ ), q{Don't match unrelated <isInSmallFormVariants>} );
ok("\x[5285]"  ~~ m/^<:!InSmallFormVariants>.$/, q{Match unrelated negated <isInSmallFormVariants>} );
ok("\x[5285]"  ~~ m/^<-:InSmallFormVariants>$/, q{Match unrelated inverted <isInSmallFormVariants>} );

# InSpacingModifierLetters


ok("\c[MODIFIER LETTER SMALL H]" ~~ m/^<:InSpacingModifierLetters>$/, q{Match <:InSpacingModifierLetters>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<:!InSpacingModifierLetters>.$/ ), q{Don't match negated <isInSpacingModifierLetters>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<-:InSpacingModifierLetters>$/ ), q{Don't match inverted <isInSpacingModifierLetters>} );
ok(!( "\x[5326]"  ~~ m/^<:InSpacingModifierLetters>$/ ), q{Don't match unrelated <isInSpacingModifierLetters>} );
ok("\x[5326]"  ~~ m/^<:!InSpacingModifierLetters>.$/, q{Match unrelated negated <isInSpacingModifierLetters>} );
ok("\x[5326]"  ~~ m/^<-:InSpacingModifierLetters>$/, q{Match unrelated inverted <isInSpacingModifierLetters>} );
ok("\x[5326]\c[MODIFIER LETTER SMALL H]" ~~ m/<:InSpacingModifierLetters>/, q{Match unanchored <isInSpacingModifierLetters>} );

# InSpecials


ok(!( "\x[3DF1]"  ~~ m/^<:InSpecials>$/ ), q{Don't match unrelated <isInSpecials>} );
ok("\x[3DF1]"  ~~ m/^<:!InSpecials>.$/, q{Match unrelated negated <isInSpecials>} );
ok("\x[3DF1]"  ~~ m/^<-:InSpecials>$/, q{Match unrelated inverted <isInSpecials>} );

# InSuperscriptsAndSubscripts


ok("\c[SUPERSCRIPT ZERO]" ~~ m/^<:InSuperscriptsAndSubscripts>$/, q{Match <:InSuperscriptsAndSubscripts>} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<:!InSuperscriptsAndSubscripts>.$/ ), q{Don't match negated <isInSuperscriptsAndSubscripts>} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<-:InSuperscriptsAndSubscripts>$/ ), q{Don't match inverted <isInSuperscriptsAndSubscripts>} );
ok(!( "\x[3E71]"  ~~ m/^<:InSuperscriptsAndSubscripts>$/ ), q{Don't match unrelated <isInSuperscriptsAndSubscripts>} );
ok("\x[3E71]"  ~~ m/^<:!InSuperscriptsAndSubscripts>.$/, q{Match unrelated negated <isInSuperscriptsAndSubscripts>} );
ok("\x[3E71]"  ~~ m/^<-:InSuperscriptsAndSubscripts>$/, q{Match unrelated inverted <isInSuperscriptsAndSubscripts>} );
ok("\x[3E71]\c[SUPERSCRIPT ZERO]" ~~ m/<:InSuperscriptsAndSubscripts>/, q{Match unanchored <isInSuperscriptsAndSubscripts>} );

# InSupplementalArrowsA


ok("\c[UPWARDS QUADRUPLE ARROW]" ~~ m/^<:InSupplementalArrowsA>$/, q{Match <:InSupplementalArrowsA>} );
ok(!( "\c[UPWARDS QUADRUPLE ARROW]" ~~ m/^<:!InSupplementalArrowsA>.$/ ), q{Don't match negated <isInSupplementalArrowsA>} );
ok(!( "\c[UPWARDS QUADRUPLE ARROW]" ~~ m/^<-:InSupplementalArrowsA>$/ ), q{Don't match inverted <isInSupplementalArrowsA>} );
ok(!( "\c[GREEK SMALL LETTER OMICRON WITH TONOS]"  ~~ m/^<:InSupplementalArrowsA>$/ ), q{Don't match unrelated <isInSupplementalArrowsA>} );
ok("\c[GREEK SMALL LETTER OMICRON WITH TONOS]"  ~~ m/^<:!InSupplementalArrowsA>.$/, q{Match unrelated negated <isInSupplementalArrowsA>} );
ok("\c[GREEK SMALL LETTER OMICRON WITH TONOS]"  ~~ m/^<-:InSupplementalArrowsA>$/, q{Match unrelated inverted <isInSupplementalArrowsA>} );
ok("\c[GREEK SMALL LETTER OMICRON WITH TONOS]\c[UPWARDS QUADRUPLE ARROW]" ~~ m/<:InSupplementalArrowsA>/, q{Match unanchored <isInSupplementalArrowsA>} );

# InSupplementalArrowsB


ok("\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/^<:InSupplementalArrowsB>$/, q{Match <:InSupplementalArrowsB>} );
ok(!( "\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/^<:!InSupplementalArrowsB>.$/ ), q{Don't match negated <isInSupplementalArrowsB>} );
ok(!( "\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/^<-:InSupplementalArrowsB>$/ ), q{Don't match inverted <isInSupplementalArrowsB>} );
ok(!( "\x[C1A9]"  ~~ m/^<:InSupplementalArrowsB>$/ ), q{Don't match unrelated <isInSupplementalArrowsB>} );
ok("\x[C1A9]"  ~~ m/^<:!InSupplementalArrowsB>.$/, q{Match unrelated negated <isInSupplementalArrowsB>} );
ok("\x[C1A9]"  ~~ m/^<-:InSupplementalArrowsB>$/, q{Match unrelated inverted <isInSupplementalArrowsB>} );
ok("\x[C1A9]\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/<:InSupplementalArrowsB>/, q{Match unanchored <isInSupplementalArrowsB>} );

# InSupplementalMathematicalOperators


ok("\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/^<:InSupplementalMathematicalOperators>$/, q{Match <:InSupplementalMathematicalOperators>} );
ok(!( "\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/^<:!InSupplementalMathematicalOperators>.$/ ), q{Don't match negated <isInSupplementalMathematicalOperators>} );
ok(!( "\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/^<-:InSupplementalMathematicalOperators>$/ ), q{Don't match inverted <isInSupplementalMathematicalOperators>} );
ok(!( "\x[9EBD]"  ~~ m/^<:InSupplementalMathematicalOperators>$/ ), q{Don't match unrelated <isInSupplementalMathematicalOperators>} );
ok("\x[9EBD]"  ~~ m/^<:!InSupplementalMathematicalOperators>.$/, q{Match unrelated negated <isInSupplementalMathematicalOperators>} );
ok("\x[9EBD]"  ~~ m/^<-:InSupplementalMathematicalOperators>$/, q{Match unrelated inverted <isInSupplementalMathematicalOperators>} );
ok("\x[9EBD]\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/<:InSupplementalMathematicalOperators>/, q{Match unanchored <isInSupplementalMathematicalOperators>} );

# InSupplementaryPrivateUseAreaA


ok(!( "\x[07E3]"  ~~ m/^<:InSupplementaryPrivateUseAreaA>$/ ), q{Don't match unrelated <isInSupplementaryPrivateUseAreaA>} );
ok("\x[07E3]"  ~~ m/^<:!InSupplementaryPrivateUseAreaA>.$/, q{Match unrelated negated <isInSupplementaryPrivateUseAreaA>} );
ok("\x[07E3]"  ~~ m/^<-:InSupplementaryPrivateUseAreaA>$/, q{Match unrelated inverted <isInSupplementaryPrivateUseAreaA>} );

# InSupplementaryPrivateUseAreaB


ok(!( "\x[4C48]"  ~~ m/^<:InSupplementaryPrivateUseAreaB>$/ ), q{Don't match unrelated <isInSupplementaryPrivateUseAreaB>} );
ok("\x[4C48]"  ~~ m/^<:!InSupplementaryPrivateUseAreaB>.$/, q{Match unrelated negated <isInSupplementaryPrivateUseAreaB>} );
ok("\x[4C48]"  ~~ m/^<-:InSupplementaryPrivateUseAreaB>$/, q{Match unrelated inverted <isInSupplementaryPrivateUseAreaB>} );

# InSyriac


ok("\c[SYRIAC END OF PARAGRAPH]" ~~ m/^<:InSyriac>$/, q{Match <:InSyriac>} );
ok(!( "\c[SYRIAC END OF PARAGRAPH]" ~~ m/^<:!InSyriac>.$/ ), q{Don't match negated <isInSyriac>} );
ok(!( "\c[SYRIAC END OF PARAGRAPH]" ~~ m/^<-:InSyriac>$/ ), q{Don't match inverted <isInSyriac>} );
ok(!( "\c[YI SYLLABLE NZIEP]"  ~~ m/^<:InSyriac>$/ ), q{Don't match unrelated <isInSyriac>} );
ok("\c[YI SYLLABLE NZIEP]"  ~~ m/^<:!InSyriac>.$/, q{Match unrelated negated <isInSyriac>} );
ok("\c[YI SYLLABLE NZIEP]"  ~~ m/^<-:InSyriac>$/, q{Match unrelated inverted <isInSyriac>} );
ok("\c[YI SYLLABLE NZIEP]\c[SYRIAC END OF PARAGRAPH]" ~~ m/<:InSyriac>/, q{Match unanchored <isInSyriac>} );

# InTagalog


ok("\c[TAGALOG LETTER A]" ~~ m/^<:InTagalog>$/, q{Match <:InTagalog>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<:!InTagalog>.$/ ), q{Don't match negated <isInTagalog>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<-:InTagalog>$/ ), q{Don't match inverted <isInTagalog>} );
ok(!( "\c[GEORGIAN LETTER BAN]"  ~~ m/^<:InTagalog>$/ ), q{Don't match unrelated <isInTagalog>} );
ok("\c[GEORGIAN LETTER BAN]"  ~~ m/^<:!InTagalog>.$/, q{Match unrelated negated <isInTagalog>} );
ok("\c[GEORGIAN LETTER BAN]"  ~~ m/^<-:InTagalog>$/, q{Match unrelated inverted <isInTagalog>} );
ok("\c[GEORGIAN LETTER BAN]\c[TAGALOG LETTER A]" ~~ m/<:InTagalog>/, q{Match unanchored <isInTagalog>} );

# InTagbanwa


ok("\c[TAGBANWA LETTER A]" ~~ m/^<:InTagbanwa>$/, q{Match <:InTagbanwa>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<:!InTagbanwa>.$/ ), q{Don't match negated <isInTagbanwa>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<-:InTagbanwa>$/ ), q{Don't match inverted <isInTagbanwa>} );
ok(!( "\x[5776]"  ~~ m/^<:InTagbanwa>$/ ), q{Don't match unrelated <isInTagbanwa>} );
ok("\x[5776]"  ~~ m/^<:!InTagbanwa>.$/, q{Match unrelated negated <isInTagbanwa>} );
ok("\x[5776]"  ~~ m/^<-:InTagbanwa>$/, q{Match unrelated inverted <isInTagbanwa>} );
ok("\x[5776]\c[TAGBANWA LETTER A]" ~~ m/<:InTagbanwa>/, q{Match unanchored <isInTagbanwa>} );

# InTags


ok(!( "\x[3674]"  ~~ m/^<:InTags>$/ ), q{Don't match unrelated <isInTags>} );
ok("\x[3674]"  ~~ m/^<:!InTags>.$/, q{Match unrelated negated <isInTags>} );
ok("\x[3674]"  ~~ m/^<-:InTags>$/, q{Match unrelated inverted <isInTags>} );

# InTamil


ok("\x[0B80]" ~~ m/^<:InTamil>$/, q{Match <:InTamil>} );
ok(!( "\x[0B80]" ~~ m/^<:!InTamil>.$/ ), q{Don't match negated <isInTamil>} );
ok(!( "\x[0B80]" ~~ m/^<-:InTamil>$/ ), q{Don't match inverted <isInTamil>} );
ok(!( "\x[B58F]"  ~~ m/^<:InTamil>$/ ), q{Don't match unrelated <isInTamil>} );
ok("\x[B58F]"  ~~ m/^<:!InTamil>.$/, q{Match unrelated negated <isInTamil>} );
ok("\x[B58F]"  ~~ m/^<-:InTamil>$/, q{Match unrelated inverted <isInTamil>} );
ok("\x[B58F]\x[0B80]" ~~ m/<:InTamil>/, q{Match unanchored <isInTamil>} );

# InTelugu


ok("\x[0C00]" ~~ m/^<:InTelugu>$/, q{Match <:InTelugu>} );
ok(!( "\x[0C00]" ~~ m/^<:!InTelugu>.$/ ), q{Don't match negated <isInTelugu>} );
ok(!( "\x[0C00]" ~~ m/^<-:InTelugu>$/ ), q{Don't match inverted <isInTelugu>} );
ok(!( "\x[8AC5]"  ~~ m/^<:InTelugu>$/ ), q{Don't match unrelated <isInTelugu>} );
ok("\x[8AC5]"  ~~ m/^<:!InTelugu>.$/, q{Match unrelated negated <isInTelugu>} );
ok("\x[8AC5]"  ~~ m/^<-:InTelugu>$/, q{Match unrelated inverted <isInTelugu>} );
ok("\x[8AC5]\x[0C00]" ~~ m/<:InTelugu>/, q{Match unanchored <isInTelugu>} );

# InThaana


ok("\c[THAANA LETTER HAA]" ~~ m/^<:InThaana>$/, q{Match <:InThaana>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<:!InThaana>.$/ ), q{Don't match negated <isInThaana>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<-:InThaana>$/ ), q{Don't match inverted <isInThaana>} );
ok(!( "\x[BB8F]"  ~~ m/^<:InThaana>$/ ), q{Don't match unrelated <isInThaana>} );
ok("\x[BB8F]"  ~~ m/^<:!InThaana>.$/, q{Match unrelated negated <isInThaana>} );
ok("\x[BB8F]"  ~~ m/^<-:InThaana>$/, q{Match unrelated inverted <isInThaana>} );
ok("\x[BB8F]\c[THAANA LETTER HAA]" ~~ m/<:InThaana>/, q{Match unanchored <isInThaana>} );

# InThai


ok("\x[0E00]" ~~ m/^<:InThai>$/, q{Match <:InThai>} );
ok(!( "\x[0E00]" ~~ m/^<:!InThai>.$/ ), q{Don't match negated <isInThai>} );
ok(!( "\x[0E00]" ~~ m/^<-:InThai>$/ ), q{Don't match inverted <isInThai>} );
ok(!( "\x[9395]"  ~~ m/^<:InThai>$/ ), q{Don't match unrelated <isInThai>} );
ok("\x[9395]"  ~~ m/^<:!InThai>.$/, q{Match unrelated negated <isInThai>} );
ok("\x[9395]"  ~~ m/^<-:InThai>$/, q{Match unrelated inverted <isInThai>} );
ok("\x[9395]\x[0E00]" ~~ m/<:InThai>/, q{Match unanchored <isInThai>} );

# InTibetan


ok("\c[TIBETAN SYLLABLE OM]" ~~ m/^<:InTibetan>$/, q{Match <:InTibetan>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<:!InTibetan>.$/ ), q{Don't match negated <isInTibetan>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<-:InTibetan>$/ ), q{Don't match inverted <isInTibetan>} );
ok(!( "\x[957A]"  ~~ m/^<:InTibetan>$/ ), q{Don't match unrelated <isInTibetan>} );
ok("\x[957A]"  ~~ m/^<:!InTibetan>.$/, q{Match unrelated negated <isInTibetan>} );
ok("\x[957A]"  ~~ m/^<-:InTibetan>$/, q{Match unrelated inverted <isInTibetan>} );
ok("\x[957A]\c[TIBETAN SYLLABLE OM]" ~~ m/<:InTibetan>/, q{Match unanchored <isInTibetan>} );

# InUnifiedCanadianAboriginalSyllabics


ok("\x[1400]" ~~ m/^<:InUnifiedCanadianAboriginalSyllabics>$/, q{Match <:InUnifiedCanadianAboriginalSyllabics>} );
ok(!( "\x[1400]" ~~ m/^<:!InUnifiedCanadianAboriginalSyllabics>.$/ ), q{Don't match negated <isInUnifiedCanadianAboriginalSyllabics>} );
ok(!( "\x[1400]" ~~ m/^<-:InUnifiedCanadianAboriginalSyllabics>$/ ), q{Don't match inverted <isInUnifiedCanadianAboriginalSyllabics>} );
ok(!( "\x[9470]"  ~~ m/^<:InUnifiedCanadianAboriginalSyllabics>$/ ), q{Don't match unrelated <isInUnifiedCanadianAboriginalSyllabics>} );
ok("\x[9470]"  ~~ m/^<:!InUnifiedCanadianAboriginalSyllabics>.$/, q{Match unrelated negated <isInUnifiedCanadianAboriginalSyllabics>} );
ok("\x[9470]"  ~~ m/^<-:InUnifiedCanadianAboriginalSyllabics>$/, q{Match unrelated inverted <isInUnifiedCanadianAboriginalSyllabics>} );
ok("\x[9470]\x[1400]" ~~ m/<:InUnifiedCanadianAboriginalSyllabics>/, q{Match unanchored <isInUnifiedCanadianAboriginalSyllabics>} );

# InVariationSelectors


ok(!( "\x[764D]"  ~~ m/^<:InVariationSelectors>$/ ), q{Don't match unrelated <isInVariationSelectors>} );
ok("\x[764D]"  ~~ m/^<:!InVariationSelectors>.$/, q{Match unrelated negated <isInVariationSelectors>} );
ok("\x[764D]"  ~~ m/^<-:InVariationSelectors>$/, q{Match unrelated inverted <isInVariationSelectors>} );

# InYiRadicals


ok("\c[YI RADICAL QOT]" ~~ m/^<:InYiRadicals>$/, q{Match <:InYiRadicals>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:!InYiRadicals>.$/ ), q{Don't match negated <isInYiRadicals>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-:InYiRadicals>$/ ), q{Don't match inverted <isInYiRadicals>} );
ok(!( "\x[3A4E]"  ~~ m/^<:InYiRadicals>$/ ), q{Don't match unrelated <isInYiRadicals>} );
ok("\x[3A4E]"  ~~ m/^<:!InYiRadicals>.$/, q{Match unrelated negated <isInYiRadicals>} );
ok("\x[3A4E]"  ~~ m/^<-:InYiRadicals>$/, q{Match unrelated inverted <isInYiRadicals>} );
ok("\x[3A4E]\c[YI RADICAL QOT]" ~~ m/<:InYiRadicals>/, q{Match unanchored <isInYiRadicals>} );

# InYiSyllables


ok("\c[YI SYLLABLE IT]" ~~ m/^<:InYiSyllables>$/, q{Match <:InYiSyllables>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<:!InYiSyllables>.$/ ), q{Don't match negated <isInYiSyllables>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<-:InYiSyllables>$/ ), q{Don't match inverted <isInYiSyllables>} );
ok(!( "\c[PARALLEL WITH HORIZONTAL STROKE]"  ~~ m/^<:InYiSyllables>$/ ), q{Don't match unrelated <isInYiSyllables>} );
ok("\c[PARALLEL WITH HORIZONTAL STROKE]"  ~~ m/^<:!InYiSyllables>.$/, q{Match unrelated negated <isInYiSyllables>} );
ok("\c[PARALLEL WITH HORIZONTAL STROKE]"  ~~ m/^<-:InYiSyllables>$/, q{Match unrelated inverted <isInYiSyllables>} );
ok("\c[PARALLEL WITH HORIZONTAL STROKE]\c[YI SYLLABLE IT]" ~~ m/<:InYiSyllables>/, q{Match unanchored <isInYiSyllables>} );



# vim: ft=perl6
