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

ok(!( "\x[531A]"  ~~ m/^<.isInAlphabeticPresentationForms>$/ ), q{Don't match unrelated <isInAlphabeticPresentationForms>} );
ok("\x[531A]"  ~~ m/^<!isInAlphabeticPresentationForms>.$/, q{Match unrelated negated <isInAlphabeticPresentationForms>} );
ok("\x[531A]"  ~~ m/^<-isInAlphabeticPresentationForms>$/, q{Match unrelated inverted <isInAlphabeticPresentationForms>} );

# InArabic


ok("\c[ARABIC NUMBER SIGN]" ~~ m/^<.isInArabic>$/, q{Match <.isInArabic>} );
ok(!( "\c[ARABIC NUMBER SIGN]" ~~ m/^<!isInArabic>.$/ ), q{Don't match negated <isInArabic>} );
ok(!( "\c[ARABIC NUMBER SIGN]" ~~ m/^<-isInArabic>$/ ), q{Don't match inverted <isInArabic>} );
ok(!( "\x[7315]"  ~~ m/^<.isInArabic>$/ ), q{Don't match unrelated <isInArabic>} );
ok("\x[7315]"  ~~ m/^<!isInArabic>.$/, q{Match unrelated negated <isInArabic>} );
ok("\x[7315]"  ~~ m/^<-isInArabic>$/, q{Match unrelated inverted <isInArabic>} );
ok("\x[7315]\c[ARABIC NUMBER SIGN]" ~~ m/<.isInArabic>/, q{Match unanchored <isInArabic>} );

# InArabicPresentationFormsA


ok(!( "\x[8340]"  ~~ m/^<.isInArabicPresentationFormsA>$/ ), q{Don't match unrelated <isInArabicPresentationFormsA>} );
ok("\x[8340]"  ~~ m/^<!isInArabicPresentationFormsA>.$/, q{Match unrelated negated <isInArabicPresentationFormsA>} );
ok("\x[8340]"  ~~ m/^<-isInArabicPresentationFormsA>$/, q{Match unrelated inverted <isInArabicPresentationFormsA>} );

# InArabicPresentationFormsB


ok(!( "\x[BEEC]"  ~~ m/^<.isInArabicPresentationFormsB>$/ ), q{Don't match unrelated <isInArabicPresentationFormsB>} );
ok("\x[BEEC]"  ~~ m/^<!isInArabicPresentationFormsB>.$/, q{Match unrelated negated <isInArabicPresentationFormsB>} );
ok("\x[BEEC]"  ~~ m/^<-isInArabicPresentationFormsB>$/, q{Match unrelated inverted <isInArabicPresentationFormsB>} );

# InArmenian


ok("\x[0530]" ~~ m/^<.isInArmenian>$/, q{Match <.isInArmenian>} );
ok(!( "\x[0530]" ~~ m/^<!isInArmenian>.$/ ), q{Don't match negated <isInArmenian>} );
ok(!( "\x[0530]" ~~ m/^<-isInArmenian>$/ ), q{Don't match inverted <isInArmenian>} );
ok(!( "\x[3B0D]"  ~~ m/^<.isInArmenian>$/ ), q{Don't match unrelated <isInArmenian>} );
ok("\x[3B0D]"  ~~ m/^<!isInArmenian>.$/, q{Match unrelated negated <isInArmenian>} );
ok("\x[3B0D]"  ~~ m/^<-isInArmenian>$/, q{Match unrelated inverted <isInArmenian>} );
ok("\x[3B0D]\x[0530]" ~~ m/<.isInArmenian>/, q{Match unanchored <isInArmenian>} );

# InArrows


ok("\c[LEFTWARDS ARROW]" ~~ m/^<.isInArrows>$/, q{Match <.isInArrows>} );
ok(!( "\c[LEFTWARDS ARROW]" ~~ m/^<!isInArrows>.$/ ), q{Don't match negated <isInArrows>} );
ok(!( "\c[LEFTWARDS ARROW]" ~~ m/^<-isInArrows>$/ ), q{Don't match inverted <isInArrows>} );
ok(!( "\x[C401]"  ~~ m/^<.isInArrows>$/ ), q{Don't match unrelated <isInArrows>} );
ok("\x[C401]"  ~~ m/^<!isInArrows>.$/, q{Match unrelated negated <isInArrows>} );
ok("\x[C401]"  ~~ m/^<-isInArrows>$/, q{Match unrelated inverted <isInArrows>} );
ok("\x[C401]\c[LEFTWARDS ARROW]" ~~ m/<.isInArrows>/, q{Match unanchored <isInArrows>} );


# InBasicLatin


ok("\c[NULL]" ~~ m/^<.isInBasicLatin>$/, q{Match <.isInBasicLatin>} );
ok(!( "\c[NULL]" ~~ m/^<!isInBasicLatin>.$/ ), q{Don't match negated <isInBasicLatin>} );
ok(!( "\c[NULL]" ~~ m/^<-isInBasicLatin>$/ ), q{Don't match inverted <isInBasicLatin>} );
ok(!( "\x[46EA]"  ~~ m/^<.isInBasicLatin>$/ ), q{Don't match unrelated <isInBasicLatin>} );
ok("\x[46EA]"  ~~ m/^<!isInBasicLatin>.$/, q{Match unrelated negated <isInBasicLatin>} );
ok("\x[46EA]"  ~~ m/^<-isInBasicLatin>$/, q{Match unrelated inverted <isInBasicLatin>} );
ok("\x[46EA]\c[NULL]" ~~ m/<.isInBasicLatin>/, q{Match unanchored <isInBasicLatin>} );

# InBengali


ok("\x[0980]" ~~ m/^<.isInBengali>$/, q{Match <.isInBengali>} );
ok(!( "\x[0980]" ~~ m/^<!isInBengali>.$/ ), q{Don't match negated <isInBengali>} );
ok(!( "\x[0980]" ~~ m/^<-isInBengali>$/ ), q{Don't match inverted <isInBengali>} );
ok(!( "\c[YI SYLLABLE HMY]"  ~~ m/^<.isInBengali>$/ ), q{Don't match unrelated <isInBengali>} );
ok("\c[YI SYLLABLE HMY]"  ~~ m/^<!isInBengali>.$/, q{Match unrelated negated <isInBengali>} );
ok("\c[YI SYLLABLE HMY]"  ~~ m/^<-isInBengali>$/, q{Match unrelated inverted <isInBengali>} );
ok("\c[YI SYLLABLE HMY]\x[0980]" ~~ m/<.isInBengali>/, q{Match unanchored <isInBengali>} );

# InBlockElements


ok("\c[UPPER HALF BLOCK]" ~~ m/^<.isInBlockElements>$/, q{Match <.isInBlockElements>} );
ok(!( "\c[UPPER HALF BLOCK]" ~~ m/^<!isInBlockElements>.$/ ), q{Don't match negated <isInBlockElements>} );
ok(!( "\c[UPPER HALF BLOCK]" ~~ m/^<-isInBlockElements>$/ ), q{Don't match inverted <isInBlockElements>} );
ok(!( "\x[5F41]"  ~~ m/^<.isInBlockElements>$/ ), q{Don't match unrelated <isInBlockElements>} );
ok("\x[5F41]"  ~~ m/^<!isInBlockElements>.$/, q{Match unrelated negated <isInBlockElements>} );
ok("\x[5F41]"  ~~ m/^<-isInBlockElements>$/, q{Match unrelated inverted <isInBlockElements>} );
ok("\x[5F41]\c[UPPER HALF BLOCK]" ~~ m/<.isInBlockElements>/, q{Match unanchored <isInBlockElements>} );

# InBopomofo


ok("\x[3100]" ~~ m/^<.isInBopomofo>$/, q{Match <.isInBopomofo>} );
ok(!( "\x[3100]" ~~ m/^<!isInBopomofo>.$/ ), q{Don't match negated <isInBopomofo>} );
ok(!( "\x[3100]" ~~ m/^<-isInBopomofo>$/ ), q{Don't match inverted <isInBopomofo>} );
ok(!( "\x[9F8E]"  ~~ m/^<.isInBopomofo>$/ ), q{Don't match unrelated <isInBopomofo>} );
ok("\x[9F8E]"  ~~ m/^<!isInBopomofo>.$/, q{Match unrelated negated <isInBopomofo>} );
ok("\x[9F8E]"  ~~ m/^<-isInBopomofo>$/, q{Match unrelated inverted <isInBopomofo>} );
ok("\x[9F8E]\x[3100]" ~~ m/<.isInBopomofo>/, q{Match unanchored <isInBopomofo>} );

# InBopomofoExtended


ok("\c[BOPOMOFO LETTER BU]" ~~ m/^<.isInBopomofoExtended>$/, q{Match <.isInBopomofoExtended>} );
ok(!( "\c[BOPOMOFO LETTER BU]" ~~ m/^<!isInBopomofoExtended>.$/ ), q{Don't match negated <isInBopomofoExtended>} );
ok(!( "\c[BOPOMOFO LETTER BU]" ~~ m/^<-isInBopomofoExtended>$/ ), q{Don't match inverted <isInBopomofoExtended>} );
ok(!( "\x[43A6]"  ~~ m/^<.isInBopomofoExtended>$/ ), q{Don't match unrelated <isInBopomofoExtended>} );
ok("\x[43A6]"  ~~ m/^<!isInBopomofoExtended>.$/, q{Match unrelated negated <isInBopomofoExtended>} );
ok("\x[43A6]"  ~~ m/^<-isInBopomofoExtended>$/, q{Match unrelated inverted <isInBopomofoExtended>} );
ok("\x[43A6]\c[BOPOMOFO LETTER BU]" ~~ m/<.isInBopomofoExtended>/, q{Match unanchored <isInBopomofoExtended>} );

# InBoxDrawing


ok("\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/^<.isInBoxDrawing>$/, q{Match <.isInBoxDrawing>} );
ok(!( "\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/^<!isInBoxDrawing>.$/ ), q{Don't match negated <isInBoxDrawing>} );
ok(!( "\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/^<-isInBoxDrawing>$/ ), q{Don't match inverted <isInBoxDrawing>} );
ok(!( "\x[7865]"  ~~ m/^<.isInBoxDrawing>$/ ), q{Don't match unrelated <isInBoxDrawing>} );
ok("\x[7865]"  ~~ m/^<!isInBoxDrawing>.$/, q{Match unrelated negated <isInBoxDrawing>} );
ok("\x[7865]"  ~~ m/^<-isInBoxDrawing>$/, q{Match unrelated inverted <isInBoxDrawing>} );
ok("\x[7865]\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/<.isInBoxDrawing>/, q{Match unanchored <isInBoxDrawing>} );

# InBraillePatterns


ok("\c[BRAILLE PATTERN BLANK]" ~~ m/^<.isInBraillePatterns>$/, q{Match <.isInBraillePatterns>} );
ok(!( "\c[BRAILLE PATTERN BLANK]" ~~ m/^<!isInBraillePatterns>.$/ ), q{Don't match negated <isInBraillePatterns>} );
ok(!( "\c[BRAILLE PATTERN BLANK]" ~~ m/^<-isInBraillePatterns>$/ ), q{Don't match inverted <isInBraillePatterns>} );
ok(!( "\c[THAI CHARACTER KHO KHAI]"  ~~ m/^<.isInBraillePatterns>$/ ), q{Don't match unrelated <isInBraillePatterns>} );
ok("\c[THAI CHARACTER KHO KHAI]"  ~~ m/^<!isInBraillePatterns>.$/, q{Match unrelated negated <isInBraillePatterns>} );
ok("\c[THAI CHARACTER KHO KHAI]"  ~~ m/^<-isInBraillePatterns>$/, q{Match unrelated inverted <isInBraillePatterns>} );
ok("\c[THAI CHARACTER KHO KHAI]\c[BRAILLE PATTERN BLANK]" ~~ m/<.isInBraillePatterns>/, q{Match unanchored <isInBraillePatterns>} );

# InBuhid


ok("\c[BUHID LETTER A]" ~~ m/^<.isInBuhid>$/, q{Match <.isInBuhid>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<!isInBuhid>.$/ ), q{Don't match negated <isInBuhid>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<-isInBuhid>$/ ), q{Don't match inverted <isInBuhid>} );
ok(!( "\x[D208]"  ~~ m/^<.isInBuhid>$/ ), q{Don't match unrelated <isInBuhid>} );
ok("\x[D208]"  ~~ m/^<!isInBuhid>.$/, q{Match unrelated negated <isInBuhid>} );
ok("\x[D208]"  ~~ m/^<-isInBuhid>$/, q{Match unrelated inverted <isInBuhid>} );
ok("\x[D208]\c[BUHID LETTER A]" ~~ m/<.isInBuhid>/, q{Match unanchored <isInBuhid>} );

# InByzantineMusicalSymbols


ok(!( "\x[9B1D]"  ~~ m/^<.isInByzantineMusicalSymbols>$/ ), q{Don't match unrelated <isInByzantineMusicalSymbols>} );
ok("\x[9B1D]"  ~~ m/^<!isInByzantineMusicalSymbols>.$/, q{Match unrelated negated <isInByzantineMusicalSymbols>} );
ok("\x[9B1D]"  ~~ m/^<-isInByzantineMusicalSymbols>$/, q{Match unrelated inverted <isInByzantineMusicalSymbols>} );

# InCJKCompatibility


ok("\c[SQUARE APAATO]" ~~ m/^<.isInCJKCompatibility>$/, q{Match <.isInCJKCompatibility>} );
ok(!( "\c[SQUARE APAATO]" ~~ m/^<!isInCJKCompatibility>.$/ ), q{Don't match negated <isInCJKCompatibility>} );
ok(!( "\c[SQUARE APAATO]" ~~ m/^<-isInCJKCompatibility>$/ ), q{Don't match inverted <isInCJKCompatibility>} );
ok(!( "\x[B8A5]"  ~~ m/^<.isInCJKCompatibility>$/ ), q{Don't match unrelated <isInCJKCompatibility>} );
ok("\x[B8A5]"  ~~ m/^<!isInCJKCompatibility>.$/, q{Match unrelated negated <isInCJKCompatibility>} );
ok("\x[B8A5]"  ~~ m/^<-isInCJKCompatibility>$/, q{Match unrelated inverted <isInCJKCompatibility>} );
ok("\x[B8A5]\c[SQUARE APAATO]" ~~ m/<.isInCJKCompatibility>/, q{Match unanchored <isInCJKCompatibility>} );

# InCJKCompatibilityForms


ok(!( "\x[3528]"  ~~ m/^<.isInCJKCompatibilityForms>$/ ), q{Don't match unrelated <isInCJKCompatibilityForms>} );
ok("\x[3528]"  ~~ m/^<!isInCJKCompatibilityForms>.$/, q{Match unrelated negated <isInCJKCompatibilityForms>} );
ok("\x[3528]"  ~~ m/^<-isInCJKCompatibilityForms>$/, q{Match unrelated inverted <isInCJKCompatibilityForms>} );

# InCJKCompatibilityIdeographs


ok(!( "\x[69F7]"  ~~ m/^<.isInCJKCompatibilityIdeographs>$/ ), q{Don't match unrelated <isInCJKCompatibilityIdeographs>} );
ok("\x[69F7]"  ~~ m/^<!isInCJKCompatibilityIdeographs>.$/, q{Match unrelated negated <isInCJKCompatibilityIdeographs>} );
ok("\x[69F7]"  ~~ m/^<-isInCJKCompatibilityIdeographs>$/, q{Match unrelated inverted <isInCJKCompatibilityIdeographs>} );

# InCJKCompatibilityIdeographsSupplement


ok(!( "\c[CANADIAN SYLLABICS NUNAVIK HO]"  ~~ m/^<.isInCJKCompatibilityIdeographsSupplement>$/ ), q{Don't match unrelated <isInCJKCompatibilityIdeographsSupplement>} );
ok("\c[CANADIAN SYLLABICS NUNAVIK HO]"  ~~ m/^<!isInCJKCompatibilityIdeographsSupplement>.$/, q{Match unrelated negated <isInCJKCompatibilityIdeographsSupplement>} );
ok("\c[CANADIAN SYLLABICS NUNAVIK HO]"  ~~ m/^<-isInCJKCompatibilityIdeographsSupplement>$/, q{Match unrelated inverted <isInCJKCompatibilityIdeographsSupplement>} );

# InCJKRadicalsSupplement


ok("\c[CJK RADICAL REPEAT]" ~~ m/^<.isInCJKRadicalsSupplement>$/, q{Match <.isInCJKRadicalsSupplement>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<!isInCJKRadicalsSupplement>.$/ ), q{Don't match negated <isInCJKRadicalsSupplement>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<-isInCJKRadicalsSupplement>$/ ), q{Don't match inverted <isInCJKRadicalsSupplement>} );
ok(!( "\x[37B4]"  ~~ m/^<.isInCJKRadicalsSupplement>$/ ), q{Don't match unrelated <isInCJKRadicalsSupplement>} );
ok("\x[37B4]"  ~~ m/^<!isInCJKRadicalsSupplement>.$/, q{Match unrelated negated <isInCJKRadicalsSupplement>} );
ok("\x[37B4]"  ~~ m/^<-isInCJKRadicalsSupplement>$/, q{Match unrelated inverted <isInCJKRadicalsSupplement>} );
ok("\x[37B4]\c[CJK RADICAL REPEAT]" ~~ m/<.isInCJKRadicalsSupplement>/, q{Match unanchored <isInCJKRadicalsSupplement>} );

# InCJKSymbolsAndPunctuation


ok("\c[IDEOGRAPHIC SPACE]" ~~ m/^<.isInCJKSymbolsAndPunctuation>$/, q{Match <.isInCJKSymbolsAndPunctuation>} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<!isInCJKSymbolsAndPunctuation>.$/ ), q{Don't match negated <isInCJKSymbolsAndPunctuation>} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<-isInCJKSymbolsAndPunctuation>$/ ), q{Don't match inverted <isInCJKSymbolsAndPunctuation>} );
ok(!( "\x[80AA]"  ~~ m/^<.isInCJKSymbolsAndPunctuation>$/ ), q{Don't match unrelated <isInCJKSymbolsAndPunctuation>} );
ok("\x[80AA]"  ~~ m/^<!isInCJKSymbolsAndPunctuation>.$/, q{Match unrelated negated <isInCJKSymbolsAndPunctuation>} );
ok("\x[80AA]"  ~~ m/^<-isInCJKSymbolsAndPunctuation>$/, q{Match unrelated inverted <isInCJKSymbolsAndPunctuation>} );
ok("\x[80AA]\c[IDEOGRAPHIC SPACE]" ~~ m/<.isInCJKSymbolsAndPunctuation>/, q{Match unanchored <isInCJKSymbolsAndPunctuation>} );

# InCJKUnifiedIdeographs


ok("\x[4E00]" ~~ m/^<.isInCJKUnifiedIdeographs>$/, q{Match <.isInCJKUnifiedIdeographs>} );
ok(!( "\x[4E00]" ~~ m/^<!isInCJKUnifiedIdeographs>.$/ ), q{Don't match negated <isInCJKUnifiedIdeographs>} );
ok(!( "\x[4E00]" ~~ m/^<-isInCJKUnifiedIdeographs>$/ ), q{Don't match inverted <isInCJKUnifiedIdeographs>} );
ok(!( "\x[3613]"  ~~ m/^<.isInCJKUnifiedIdeographs>$/ ), q{Don't match unrelated <isInCJKUnifiedIdeographs>} );
ok("\x[3613]"  ~~ m/^<!isInCJKUnifiedIdeographs>.$/, q{Match unrelated negated <isInCJKUnifiedIdeographs>} );
ok("\x[3613]"  ~~ m/^<-isInCJKUnifiedIdeographs>$/, q{Match unrelated inverted <isInCJKUnifiedIdeographs>} );
ok("\x[3613]\x[4E00]" ~~ m/<.isInCJKUnifiedIdeographs>/, q{Match unanchored <isInCJKUnifiedIdeographs>} );

# InCJKUnifiedIdeographsExtensionA


ok("\x[3400]" ~~ m/^<.isInCJKUnifiedIdeographsExtensionA>$/, q{Match <.isInCJKUnifiedIdeographsExtensionA>} );
ok(!( "\x[3400]" ~~ m/^<!isInCJKUnifiedIdeographsExtensionA>.$/ ), q{Don't match negated <isInCJKUnifiedIdeographsExtensionA>} );
ok(!( "\x[3400]" ~~ m/^<-isInCJKUnifiedIdeographsExtensionA>$/ ), q{Don't match inverted <isInCJKUnifiedIdeographsExtensionA>} );
ok(!( "\c[SQUARE HOORU]"  ~~ m/^<.isInCJKUnifiedIdeographsExtensionA>$/ ), q{Don't match unrelated <isInCJKUnifiedIdeographsExtensionA>} );
ok("\c[SQUARE HOORU]"  ~~ m/^<!isInCJKUnifiedIdeographsExtensionA>.$/, q{Match unrelated negated <isInCJKUnifiedIdeographsExtensionA>} );
ok("\c[SQUARE HOORU]"  ~~ m/^<-isInCJKUnifiedIdeographsExtensionA>$/, q{Match unrelated inverted <isInCJKUnifiedIdeographsExtensionA>} );
ok("\c[SQUARE HOORU]\x[3400]" ~~ m/<.isInCJKUnifiedIdeographsExtensionA>/, q{Match unanchored <isInCJKUnifiedIdeographsExtensionA>} );

# InCJKUnifiedIdeographsExtensionB


ok(!( "\x[AC3B]"  ~~ m/^<.isInCJKUnifiedIdeographsExtensionB>$/ ), q{Don't match unrelated <isInCJKUnifiedIdeographsExtensionB>} );
ok("\x[AC3B]"  ~~ m/^<!isInCJKUnifiedIdeographsExtensionB>.$/, q{Match unrelated negated <isInCJKUnifiedIdeographsExtensionB>} );
ok("\x[AC3B]"  ~~ m/^<-isInCJKUnifiedIdeographsExtensionB>$/, q{Match unrelated inverted <isInCJKUnifiedIdeographsExtensionB>} );

# InCherokee


ok("\c[CHEROKEE LETTER A]" ~~ m/^<.isInCherokee>$/, q{Match <.isInCherokee>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<!isInCherokee>.$/ ), q{Don't match negated <isInCherokee>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<-isInCherokee>$/ ), q{Don't match inverted <isInCherokee>} );
ok(!( "\x[985F]"  ~~ m/^<.isInCherokee>$/ ), q{Don't match unrelated <isInCherokee>} );
ok("\x[985F]"  ~~ m/^<!isInCherokee>.$/, q{Match unrelated negated <isInCherokee>} );
ok("\x[985F]"  ~~ m/^<-isInCherokee>$/, q{Match unrelated inverted <isInCherokee>} );
ok("\x[985F]\c[CHEROKEE LETTER A]" ~~ m/<.isInCherokee>/, q{Match unanchored <isInCherokee>} );

# InCombiningDiacriticalMarks


ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<.isInCombiningDiacriticalMarks>$/, q{Match <.isInCombiningDiacriticalMarks>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isInCombiningDiacriticalMarks>.$/ ), q{Don't match negated <isInCombiningDiacriticalMarks>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isInCombiningDiacriticalMarks>$/ ), q{Don't match inverted <isInCombiningDiacriticalMarks>} );
ok(!( "\x[76DA]"  ~~ m/^<.isInCombiningDiacriticalMarks>$/ ), q{Don't match unrelated <isInCombiningDiacriticalMarks>} );
ok("\x[76DA]"  ~~ m/^<!isInCombiningDiacriticalMarks>.$/, q{Match unrelated negated <isInCombiningDiacriticalMarks>} );
ok("\x[76DA]"  ~~ m/^<-isInCombiningDiacriticalMarks>$/, q{Match unrelated inverted <isInCombiningDiacriticalMarks>} );
ok("\x[76DA]\c[COMBINING GRAVE ACCENT]" ~~ m/<.isInCombiningDiacriticalMarks>/, q{Match unanchored <isInCombiningDiacriticalMarks>} );

# InCombiningDiacriticalMarksforSymbols


ok("\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/^<.isInCombiningDiacriticalMarksforSymbols>$/, q{Match <.isInCombiningDiacriticalMarksforSymbols>} );
ok(!( "\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/^<!isInCombiningDiacriticalMarksforSymbols>.$/ ), q{Don't match negated <isInCombiningDiacriticalMarksforSymbols>} );
ok(!( "\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/^<-isInCombiningDiacriticalMarksforSymbols>$/ ), q{Don't match inverted <isInCombiningDiacriticalMarksforSymbols>} );
ok(!( "\x[7345]"  ~~ m/^<.isInCombiningDiacriticalMarksforSymbols>$/ ), q{Don't match unrelated <isInCombiningDiacriticalMarksforSymbols>} );
ok("\x[7345]"  ~~ m/^<!isInCombiningDiacriticalMarksforSymbols>.$/, q{Match unrelated negated <isInCombiningDiacriticalMarksforSymbols>} );
ok("\x[7345]"  ~~ m/^<-isInCombiningDiacriticalMarksforSymbols>$/, q{Match unrelated inverted <isInCombiningDiacriticalMarksforSymbols>} );
ok("\x[7345]\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/<.isInCombiningDiacriticalMarksforSymbols>/, q{Match unanchored <isInCombiningDiacriticalMarksforSymbols>} );

# InCombiningHalfMarks


ok(!( "\x[6C2E]"  ~~ m/^<.isInCombiningHalfMarks>$/ ), q{Don't match unrelated <isInCombiningHalfMarks>} );
ok("\x[6C2E]"  ~~ m/^<!isInCombiningHalfMarks>.$/, q{Match unrelated negated <isInCombiningHalfMarks>} );
ok("\x[6C2E]"  ~~ m/^<-isInCombiningHalfMarks>$/, q{Match unrelated inverted <isInCombiningHalfMarks>} );

# InControlPictures


ok("\c[SYMBOL FOR NULL]" ~~ m/^<.isInControlPictures>$/, q{Match <.isInControlPictures>} );
ok(!( "\c[SYMBOL FOR NULL]" ~~ m/^<!isInControlPictures>.$/ ), q{Don't match negated <isInControlPictures>} );
ok(!( "\c[SYMBOL FOR NULL]" ~~ m/^<-isInControlPictures>$/ ), q{Don't match inverted <isInControlPictures>} );
ok(!( "\x[BCE2]"  ~~ m/^<.isInControlPictures>$/ ), q{Don't match unrelated <isInControlPictures>} );
ok("\x[BCE2]"  ~~ m/^<!isInControlPictures>.$/, q{Match unrelated negated <isInControlPictures>} );
ok("\x[BCE2]"  ~~ m/^<-isInControlPictures>$/, q{Match unrelated inverted <isInControlPictures>} );
ok("\x[BCE2]\c[SYMBOL FOR NULL]" ~~ m/<.isInControlPictures>/, q{Match unanchored <isInControlPictures>} );

# InCurrencySymbols


ok("\c[EURO-CURRENCY SIGN]" ~~ m/^<.isInCurrencySymbols>$/, q{Match <.isInCurrencySymbols>} );
ok(!( "\c[EURO-CURRENCY SIGN]" ~~ m/^<!isInCurrencySymbols>.$/ ), q{Don't match negated <isInCurrencySymbols>} );
ok(!( "\c[EURO-CURRENCY SIGN]" ~~ m/^<-isInCurrencySymbols>$/ ), q{Don't match inverted <isInCurrencySymbols>} );
ok(!( "\x[8596]"  ~~ m/^<.isInCurrencySymbols>$/ ), q{Don't match unrelated <isInCurrencySymbols>} );
ok("\x[8596]"  ~~ m/^<!isInCurrencySymbols>.$/, q{Match unrelated negated <isInCurrencySymbols>} );
ok("\x[8596]"  ~~ m/^<-isInCurrencySymbols>$/, q{Match unrelated inverted <isInCurrencySymbols>} );
ok("\x[8596]\c[EURO-CURRENCY SIGN]" ~~ m/<.isInCurrencySymbols>/, q{Match unanchored <isInCurrencySymbols>} );

# InCyrillic


ok("\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<.isInCyrillic>$/, q{Match <.isInCyrillic>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<!isInCyrillic>.$/ ), q{Don't match negated <isInCyrillic>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<-isInCyrillic>$/ ), q{Don't match inverted <isInCyrillic>} );
ok(!( "\x[51B2]"  ~~ m/^<.isInCyrillic>$/ ), q{Don't match unrelated <isInCyrillic>} );
ok("\x[51B2]"  ~~ m/^<!isInCyrillic>.$/, q{Match unrelated negated <isInCyrillic>} );
ok("\x[51B2]"  ~~ m/^<-isInCyrillic>$/, q{Match unrelated inverted <isInCyrillic>} );
ok("\x[51B2]\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/<.isInCyrillic>/, q{Match unanchored <isInCyrillic>} );

# InCyrillicSupplementary


ok("\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/^<.isInCyrillicSupplementary>$/, q{Match <.isInCyrillicSupplementary>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/^<!isInCyrillicSupplementary>.$/ ), q{Don't match negated <isInCyrillicSupplementary>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/^<-isInCyrillicSupplementary>$/ ), q{Don't match inverted <isInCyrillicSupplementary>} );
ok(!( "\x[7BD9]"  ~~ m/^<.isInCyrillicSupplementary>$/ ), q{Don't match unrelated <isInCyrillicSupplementary>} );
ok("\x[7BD9]"  ~~ m/^<!isInCyrillicSupplementary>.$/, q{Match unrelated negated <isInCyrillicSupplementary>} );
ok("\x[7BD9]"  ~~ m/^<-isInCyrillicSupplementary>$/, q{Match unrelated inverted <isInCyrillicSupplementary>} );
ok("\x[7BD9]\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/<.isInCyrillicSupplementary>/, q{Match unanchored <isInCyrillicSupplementary>} );

# InDeseret


ok(!( "\c[TAMIL DIGIT FOUR]"  ~~ m/^<.isInDeseret>$/ ), q{Don't match unrelated <isInDeseret>} );
ok("\c[TAMIL DIGIT FOUR]"  ~~ m/^<!isInDeseret>.$/, q{Match unrelated negated <isInDeseret>} );
ok("\c[TAMIL DIGIT FOUR]"  ~~ m/^<-isInDeseret>$/, q{Match unrelated inverted <isInDeseret>} );

# InDevanagari


ok("\x[0900]" ~~ m/^<.isInDevanagari>$/, q{Match <.isInDevanagari>} );
ok(!( "\x[0900]" ~~ m/^<!isInDevanagari>.$/ ), q{Don't match negated <isInDevanagari>} );
ok(!( "\x[0900]" ~~ m/^<-isInDevanagari>$/ ), q{Don't match inverted <isInDevanagari>} );
ok(!( "\x[BB12]"  ~~ m/^<.isInDevanagari>$/ ), q{Don't match unrelated <isInDevanagari>} );
ok("\x[BB12]"  ~~ m/^<!isInDevanagari>.$/, q{Match unrelated negated <isInDevanagari>} );
ok("\x[BB12]"  ~~ m/^<-isInDevanagari>$/, q{Match unrelated inverted <isInDevanagari>} );
ok("\x[BB12]\x[0900]" ~~ m/<.isInDevanagari>/, q{Match unanchored <isInDevanagari>} );

# InDingbats


ok("\x[2700]" ~~ m/^<.isInDingbats>$/, q{Match <.isInDingbats>} );
ok(!( "\x[2700]" ~~ m/^<!isInDingbats>.$/ ), q{Don't match negated <isInDingbats>} );
ok(!( "\x[2700]" ~~ m/^<-isInDingbats>$/ ), q{Don't match inverted <isInDingbats>} );
ok(!( "\x[D7A8]"  ~~ m/^<.isInDingbats>$/ ), q{Don't match unrelated <isInDingbats>} );
ok("\x[D7A8]"  ~~ m/^<!isInDingbats>.$/, q{Match unrelated negated <isInDingbats>} );
ok("\x[D7A8]"  ~~ m/^<-isInDingbats>$/, q{Match unrelated inverted <isInDingbats>} );
ok("\x[D7A8]\x[2700]" ~~ m/<.isInDingbats>/, q{Match unanchored <isInDingbats>} );

# InEnclosedAlphanumerics


ok("\c[CIRCLED DIGIT ONE]" ~~ m/^<.isInEnclosedAlphanumerics>$/, q{Match <.isInEnclosedAlphanumerics>} );
ok(!( "\c[CIRCLED DIGIT ONE]" ~~ m/^<!isInEnclosedAlphanumerics>.$/ ), q{Don't match negated <isInEnclosedAlphanumerics>} );
ok(!( "\c[CIRCLED DIGIT ONE]" ~~ m/^<-isInEnclosedAlphanumerics>$/ ), q{Don't match inverted <isInEnclosedAlphanumerics>} );
ok(!( "\x[C3A2]"  ~~ m/^<.isInEnclosedAlphanumerics>$/ ), q{Don't match unrelated <isInEnclosedAlphanumerics>} );
ok("\x[C3A2]"  ~~ m/^<!isInEnclosedAlphanumerics>.$/, q{Match unrelated negated <isInEnclosedAlphanumerics>} );
ok("\x[C3A2]"  ~~ m/^<-isInEnclosedAlphanumerics>$/, q{Match unrelated inverted <isInEnclosedAlphanumerics>} );
ok("\x[C3A2]\c[CIRCLED DIGIT ONE]" ~~ m/<.isInEnclosedAlphanumerics>/, q{Match unanchored <isInEnclosedAlphanumerics>} );

# InEnclosedCJKLettersAndMonths


ok("\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/^<.isInEnclosedCJKLettersAndMonths>$/, q{Match <.isInEnclosedCJKLettersAndMonths>} );
ok(!( "\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/^<!isInEnclosedCJKLettersAndMonths>.$/ ), q{Don't match negated <isInEnclosedCJKLettersAndMonths>} );
ok(!( "\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/^<-isInEnclosedCJKLettersAndMonths>$/ ), q{Don't match inverted <isInEnclosedCJKLettersAndMonths>} );
ok(!( "\x[5B44]"  ~~ m/^<.isInEnclosedCJKLettersAndMonths>$/ ), q{Don't match unrelated <isInEnclosedCJKLettersAndMonths>} );
ok("\x[5B44]"  ~~ m/^<!isInEnclosedCJKLettersAndMonths>.$/, q{Match unrelated negated <isInEnclosedCJKLettersAndMonths>} );
ok("\x[5B44]"  ~~ m/^<-isInEnclosedCJKLettersAndMonths>$/, q{Match unrelated inverted <isInEnclosedCJKLettersAndMonths>} );
ok("\x[5B44]\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/<.isInEnclosedCJKLettersAndMonths>/, q{Match unanchored <isInEnclosedCJKLettersAndMonths>} );

# InEthiopic


ok("\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<.isInEthiopic>$/, q{Match <.isInEthiopic>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<!isInEthiopic>.$/ ), q{Don't match negated <isInEthiopic>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<-isInEthiopic>$/ ), q{Don't match inverted <isInEthiopic>} );
ok(!( "\x[BBAE]"  ~~ m/^<.isInEthiopic>$/ ), q{Don't match unrelated <isInEthiopic>} );
ok("\x[BBAE]"  ~~ m/^<!isInEthiopic>.$/, q{Match unrelated negated <isInEthiopic>} );
ok("\x[BBAE]"  ~~ m/^<-isInEthiopic>$/, q{Match unrelated inverted <isInEthiopic>} );
ok("\x[BBAE]\c[ETHIOPIC SYLLABLE HA]" ~~ m/<.isInEthiopic>/, q{Match unanchored <isInEthiopic>} );

# InGeneralPunctuation


ok("\c[EN QUAD]" ~~ m/^<.isInGeneralPunctuation>$/, q{Match <.isInGeneralPunctuation>} );
ok(!( "\c[EN QUAD]" ~~ m/^<!isInGeneralPunctuation>.$/ ), q{Don't match negated <isInGeneralPunctuation>} );
ok(!( "\c[EN QUAD]" ~~ m/^<-isInGeneralPunctuation>$/ ), q{Don't match inverted <isInGeneralPunctuation>} );
ok(!( "\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]"  ~~ m/^<.isInGeneralPunctuation>$/ ), q{Don't match unrelated <isInGeneralPunctuation>} );
ok("\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]"  ~~ m/^<!isInGeneralPunctuation>.$/, q{Match unrelated negated <isInGeneralPunctuation>} );
ok("\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]"  ~~ m/^<-isInGeneralPunctuation>$/, q{Match unrelated inverted <isInGeneralPunctuation>} );
ok("\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]\c[EN QUAD]" ~~ m/<.isInGeneralPunctuation>/, q{Match unanchored <isInGeneralPunctuation>} );

# InGeometricShapes


ok("\c[BLACK SQUARE]" ~~ m/^<.isInGeometricShapes>$/, q{Match <.isInGeometricShapes>} );
ok(!( "\c[BLACK SQUARE]" ~~ m/^<!isInGeometricShapes>.$/ ), q{Don't match negated <isInGeometricShapes>} );
ok(!( "\c[BLACK SQUARE]" ~~ m/^<-isInGeometricShapes>$/ ), q{Don't match inverted <isInGeometricShapes>} );
ok(!( "\x[B700]"  ~~ m/^<.isInGeometricShapes>$/ ), q{Don't match unrelated <isInGeometricShapes>} );
ok("\x[B700]"  ~~ m/^<!isInGeometricShapes>.$/, q{Match unrelated negated <isInGeometricShapes>} );
ok("\x[B700]"  ~~ m/^<-isInGeometricShapes>$/, q{Match unrelated inverted <isInGeometricShapes>} );
ok("\x[B700]\c[BLACK SQUARE]" ~~ m/<.isInGeometricShapes>/, q{Match unanchored <isInGeometricShapes>} );


# InGeorgian


ok("\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<.isInGeorgian>$/, q{Match <.isInGeorgian>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<!isInGeorgian>.$/ ), q{Don't match negated <isInGeorgian>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<-isInGeorgian>$/ ), q{Don't match inverted <isInGeorgian>} );
ok(!( "\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]"  ~~ m/^<.isInGeorgian>$/ ), q{Don't match unrelated <isInGeorgian>} );
ok("\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]"  ~~ m/^<!isInGeorgian>.$/, q{Match unrelated negated <isInGeorgian>} );
ok("\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]"  ~~ m/^<-isInGeorgian>$/, q{Match unrelated inverted <isInGeorgian>} );
ok("\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/<.isInGeorgian>/, q{Match unanchored <isInGeorgian>} );

# InGothic


ok(!( "\x[4825]"  ~~ m/^<.isInGothic>$/ ), q{Don't match unrelated <isInGothic>} );
ok("\x[4825]"  ~~ m/^<!isInGothic>.$/, q{Match unrelated negated <isInGothic>} );
ok("\x[4825]"  ~~ m/^<-isInGothic>$/, q{Match unrelated inverted <isInGothic>} );

# InGreekExtended


ok("\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/^<.isInGreekExtended>$/, q{Match <.isInGreekExtended>} );
ok(!( "\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/^<!isInGreekExtended>.$/ ), q{Don't match negated <isInGreekExtended>} );
ok(!( "\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/^<-isInGreekExtended>$/ ), q{Don't match inverted <isInGreekExtended>} );
ok(!( "\x[B9B7]"  ~~ m/^<.isInGreekExtended>$/ ), q{Don't match unrelated <isInGreekExtended>} );
ok("\x[B9B7]"  ~~ m/^<!isInGreekExtended>.$/, q{Match unrelated negated <isInGreekExtended>} );
ok("\x[B9B7]"  ~~ m/^<-isInGreekExtended>$/, q{Match unrelated inverted <isInGreekExtended>} );
ok("\x[B9B7]\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/<.isInGreekExtended>/, q{Match unanchored <isInGreekExtended>} );

# InGreekAndCoptic


ok("\x[0370]" ~~ m/^<.isInGreekAndCoptic>$/, q{Match <.isInGreekAndCoptic>} );
ok(!( "\x[0370]" ~~ m/^<!isInGreekAndCoptic>.$/ ), q{Don't match negated <isInGreekAndCoptic>} );
ok(!( "\x[0370]" ~~ m/^<-isInGreekAndCoptic>$/ ), q{Don't match inverted <isInGreekAndCoptic>} );
ok(!( "\x[7197]"  ~~ m/^<.isInGreekAndCoptic>$/ ), q{Don't match unrelated <isInGreekAndCoptic>} );
ok("\x[7197]"  ~~ m/^<!isInGreekAndCoptic>.$/, q{Match unrelated negated <isInGreekAndCoptic>} );
ok("\x[7197]"  ~~ m/^<-isInGreekAndCoptic>$/, q{Match unrelated inverted <isInGreekAndCoptic>} );
ok("\x[7197]\x[0370]" ~~ m/<.isInGreekAndCoptic>/, q{Match unanchored <isInGreekAndCoptic>} );

# InGujarati


ok("\x[0A80]" ~~ m/^<.isInGujarati>$/, q{Match <.isInGujarati>} );
ok(!( "\x[0A80]" ~~ m/^<!isInGujarati>.$/ ), q{Don't match negated <isInGujarati>} );
ok(!( "\x[0A80]" ~~ m/^<-isInGujarati>$/ ), q{Don't match inverted <isInGujarati>} );
ok(!( "\x[3B63]"  ~~ m/^<.isInGujarati>$/ ), q{Don't match unrelated <isInGujarati>} );
ok("\x[3B63]"  ~~ m/^<!isInGujarati>.$/, q{Match unrelated negated <isInGujarati>} );
ok("\x[3B63]"  ~~ m/^<-isInGujarati>$/, q{Match unrelated inverted <isInGujarati>} );
ok("\x[3B63]\x[0A80]" ~~ m/<.isInGujarati>/, q{Match unanchored <isInGujarati>} );

# InGurmukhi


ok("\x[0A00]" ~~ m/^<.isInGurmukhi>$/, q{Match <.isInGurmukhi>} );
ok(!( "\x[0A00]" ~~ m/^<!isInGurmukhi>.$/ ), q{Don't match negated <isInGurmukhi>} );
ok(!( "\x[0A00]" ~~ m/^<-isInGurmukhi>$/ ), q{Don't match inverted <isInGurmukhi>} );
ok(!( "\x[10C8]"  ~~ m/^<.isInGurmukhi>$/ ), q{Don't match unrelated <isInGurmukhi>} );
ok("\x[10C8]"  ~~ m/^<!isInGurmukhi>.$/, q{Match unrelated negated <isInGurmukhi>} );
ok("\x[10C8]"  ~~ m/^<-isInGurmukhi>$/, q{Match unrelated inverted <isInGurmukhi>} );
ok("\x[10C8]\x[0A00]" ~~ m/<.isInGurmukhi>/, q{Match unanchored <isInGurmukhi>} );

# InHalfwidthAndFullwidthForms


ok(!( "\x[CA55]"  ~~ m/^<.isInHalfwidthAndFullwidthForms>$/ ), q{Don't match unrelated <isInHalfwidthAndFullwidthForms>} );
ok("\x[CA55]"  ~~ m/^<!isInHalfwidthAndFullwidthForms>.$/, q{Match unrelated negated <isInHalfwidthAndFullwidthForms>} );
ok("\x[CA55]"  ~~ m/^<-isInHalfwidthAndFullwidthForms>$/, q{Match unrelated inverted <isInHalfwidthAndFullwidthForms>} );

# InHangulCompatibilityJamo


ok("\x[3130]" ~~ m/^<.isInHangulCompatibilityJamo>$/, q{Match <.isInHangulCompatibilityJamo>} );
ok(!( "\x[3130]" ~~ m/^<!isInHangulCompatibilityJamo>.$/ ), q{Don't match negated <isInHangulCompatibilityJamo>} );
ok(!( "\x[3130]" ~~ m/^<-isInHangulCompatibilityJamo>$/ ), q{Don't match inverted <isInHangulCompatibilityJamo>} );
ok(!( "\c[MEASURED BY]"  ~~ m/^<.isInHangulCompatibilityJamo>$/ ), q{Don't match unrelated <isInHangulCompatibilityJamo>} );
ok("\c[MEASURED BY]"  ~~ m/^<!isInHangulCompatibilityJamo>.$/, q{Match unrelated negated <isInHangulCompatibilityJamo>} );
ok("\c[MEASURED BY]"  ~~ m/^<-isInHangulCompatibilityJamo>$/, q{Match unrelated inverted <isInHangulCompatibilityJamo>} );
ok("\c[MEASURED BY]\x[3130]" ~~ m/<.isInHangulCompatibilityJamo>/, q{Match unanchored <isInHangulCompatibilityJamo>} );

# InHangulJamo


ok("\c[HANGUL CHOSEONG KIYEOK]" ~~ m/^<.isInHangulJamo>$/, q{Match <.isInHangulJamo>} );
ok(!( "\c[HANGUL CHOSEONG KIYEOK]" ~~ m/^<!isInHangulJamo>.$/ ), q{Don't match negated <isInHangulJamo>} );
ok(!( "\c[HANGUL CHOSEONG KIYEOK]" ~~ m/^<-isInHangulJamo>$/ ), q{Don't match inverted <isInHangulJamo>} );
ok(!( "\x[3B72]"  ~~ m/^<.isInHangulJamo>$/ ), q{Don't match unrelated <isInHangulJamo>} );
ok("\x[3B72]"  ~~ m/^<!isInHangulJamo>.$/, q{Match unrelated negated <isInHangulJamo>} );
ok("\x[3B72]"  ~~ m/^<-isInHangulJamo>$/, q{Match unrelated inverted <isInHangulJamo>} );
ok("\x[3B72]\c[HANGUL CHOSEONG KIYEOK]" ~~ m/<.isInHangulJamo>/, q{Match unanchored <isInHangulJamo>} );

# InHangulSyllables


ok("\x[CD95]" ~~ m/^<.isInHangulSyllables>$/, q{Match <.isInHangulSyllables>} );
ok(!( "\x[CD95]" ~~ m/^<!isInHangulSyllables>.$/ ), q{Don't match negated <isInHangulSyllables>} );
ok(!( "\x[CD95]" ~~ m/^<-isInHangulSyllables>$/ ), q{Don't match inverted <isInHangulSyllables>} );
ok(!( "\x[D7B0]"  ~~ m/^<.isInHangulSyllables>$/ ), q{Don't match unrelated <isInHangulSyllables>} );
ok("\x[D7B0]"  ~~ m/^<!isInHangulSyllables>.$/, q{Match unrelated negated <isInHangulSyllables>} );
ok("\x[D7B0]"  ~~ m/^<-isInHangulSyllables>$/, q{Match unrelated inverted <isInHangulSyllables>} );
ok("\x[D7B0]\x[CD95]" ~~ m/<.isInHangulSyllables>/, q{Match unanchored <isInHangulSyllables>} );

# InHanunoo


ok("\c[HANUNOO LETTER A]" ~~ m/^<.isInHanunoo>$/, q{Match <.isInHanunoo>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<!isInHanunoo>.$/ ), q{Don't match negated <isInHanunoo>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<-isInHanunoo>$/ ), q{Don't match inverted <isInHanunoo>} );
ok(!( "\x[6F4F]"  ~~ m/^<.isInHanunoo>$/ ), q{Don't match unrelated <isInHanunoo>} );
ok("\x[6F4F]"  ~~ m/^<!isInHanunoo>.$/, q{Match unrelated negated <isInHanunoo>} );
ok("\x[6F4F]"  ~~ m/^<-isInHanunoo>$/, q{Match unrelated inverted <isInHanunoo>} );
ok("\x[6F4F]\c[HANUNOO LETTER A]" ~~ m/<.isInHanunoo>/, q{Match unanchored <isInHanunoo>} );

# InHebrew


ok("\x[0590]" ~~ m/^<.isInHebrew>$/, q{Match <.isInHebrew>} );
ok(!( "\x[0590]" ~~ m/^<!isInHebrew>.$/ ), q{Don't match negated <isInHebrew>} );
ok(!( "\x[0590]" ~~ m/^<-isInHebrew>$/ ), q{Don't match inverted <isInHebrew>} );
ok(!( "\x[0777]"  ~~ m/^<.isInHebrew>$/ ), q{Don't match unrelated <isInHebrew>} );
ok("\x[0777]"  ~~ m/^<!isInHebrew>.$/, q{Match unrelated negated <isInHebrew>} );
ok("\x[0777]"  ~~ m/^<-isInHebrew>$/, q{Match unrelated inverted <isInHebrew>} );
ok("\x[0777]\x[0590]" ~~ m/<.isInHebrew>/, q{Match unanchored <isInHebrew>} );

# InHighPrivateUseSurrogates


ok(!( "\x[D04F]"  ~~ m/^<.isInHighPrivateUseSurrogates>$/ ), q{Don't match unrelated <isInHighPrivateUseSurrogates>} );
ok("\x[D04F]"  ~~ m/^<!isInHighPrivateUseSurrogates>.$/, q{Match unrelated negated <isInHighPrivateUseSurrogates>} );
ok("\x[D04F]"  ~~ m/^<-isInHighPrivateUseSurrogates>$/, q{Match unrelated inverted <isInHighPrivateUseSurrogates>} );

# InHighSurrogates


ok(!( "\x[D085]"  ~~ m/^<.isInHighSurrogates>$/ ), q{Don't match unrelated <isInHighSurrogates>} );
ok("\x[D085]"  ~~ m/^<!isInHighSurrogates>.$/, q{Match unrelated negated <isInHighSurrogates>} );
ok("\x[D085]"  ~~ m/^<-isInHighSurrogates>$/, q{Match unrelated inverted <isInHighSurrogates>} );

# InHiragana


ok("\x[3040]" ~~ m/^<.isInHiragana>$/, q{Match <.isInHiragana>} );
ok(!( "\x[3040]" ~~ m/^<!isInHiragana>.$/ ), q{Don't match negated <isInHiragana>} );
ok(!( "\x[3040]" ~~ m/^<-isInHiragana>$/ ), q{Don't match inverted <isInHiragana>} );
ok(!( "\x[AC7C]"  ~~ m/^<.isInHiragana>$/ ), q{Don't match unrelated <isInHiragana>} );
ok("\x[AC7C]"  ~~ m/^<!isInHiragana>.$/, q{Match unrelated negated <isInHiragana>} );
ok("\x[AC7C]"  ~~ m/^<-isInHiragana>$/, q{Match unrelated inverted <isInHiragana>} );
ok("\x[AC7C]\x[3040]" ~~ m/<.isInHiragana>/, q{Match unanchored <isInHiragana>} );

# InIPAExtensions


ok("\c[LATIN SMALL LETTER TURNED A]" ~~ m/^<.isInIPAExtensions>$/, q{Match <.isInIPAExtensions>} );
ok(!( "\c[LATIN SMALL LETTER TURNED A]" ~~ m/^<!isInIPAExtensions>.$/ ), q{Don't match negated <isInIPAExtensions>} );
ok(!( "\c[LATIN SMALL LETTER TURNED A]" ~~ m/^<-isInIPAExtensions>$/ ), q{Don't match inverted <isInIPAExtensions>} );
ok(!( "\c[HANGUL LETTER SSANGIEUNG]"  ~~ m/^<.isInIPAExtensions>$/ ), q{Don't match unrelated <isInIPAExtensions>} );
ok("\c[HANGUL LETTER SSANGIEUNG]"  ~~ m/^<!isInIPAExtensions>.$/, q{Match unrelated negated <isInIPAExtensions>} );
ok("\c[HANGUL LETTER SSANGIEUNG]"  ~~ m/^<-isInIPAExtensions>$/, q{Match unrelated inverted <isInIPAExtensions>} );
ok("\c[HANGUL LETTER SSANGIEUNG]\c[LATIN SMALL LETTER TURNED A]" ~~ m/<.isInIPAExtensions>/, q{Match unanchored <isInIPAExtensions>} );

# InIdeographicDescriptionCharacters


ok("\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<.isInIdeographicDescriptionCharacters>$/, q{Match <.isInIdeographicDescriptionCharacters>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<!isInIdeographicDescriptionCharacters>.$/ ), q{Don't match negated <isInIdeographicDescriptionCharacters>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<-isInIdeographicDescriptionCharacters>$/ ), q{Don't match inverted <isInIdeographicDescriptionCharacters>} );
ok(!( "\x[9160]"  ~~ m/^<.isInIdeographicDescriptionCharacters>$/ ), q{Don't match unrelated <isInIdeographicDescriptionCharacters>} );
ok("\x[9160]"  ~~ m/^<!isInIdeographicDescriptionCharacters>.$/, q{Match unrelated negated <isInIdeographicDescriptionCharacters>} );
ok("\x[9160]"  ~~ m/^<-isInIdeographicDescriptionCharacters>$/, q{Match unrelated inverted <isInIdeographicDescriptionCharacters>} );
ok("\x[9160]\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/<.isInIdeographicDescriptionCharacters>/, q{Match unanchored <isInIdeographicDescriptionCharacters>} );

# InKanbun


ok("\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/^<.isInKanbun>$/, q{Match <.isInKanbun>} );
ok(!( "\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/^<!isInKanbun>.$/ ), q{Don't match negated <isInKanbun>} );
ok(!( "\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/^<-isInKanbun>$/ ), q{Don't match inverted <isInKanbun>} );
ok(!( "\x[A80C]"  ~~ m/^<.isInKanbun>$/ ), q{Don't match unrelated <isInKanbun>} );
ok("\x[A80C]"  ~~ m/^<!isInKanbun>.$/, q{Match unrelated negated <isInKanbun>} );
ok("\x[A80C]"  ~~ m/^<-isInKanbun>$/, q{Match unrelated inverted <isInKanbun>} );
ok("\x[A80C]\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/<.isInKanbun>/, q{Match unanchored <isInKanbun>} );

# InKangxiRadicals


ok("\c[KANGXI RADICAL ONE]" ~~ m/^<.isInKangxiRadicals>$/, q{Match <.isInKangxiRadicals>} );
ok(!( "\c[KANGXI RADICAL ONE]" ~~ m/^<!isInKangxiRadicals>.$/ ), q{Don't match negated <isInKangxiRadicals>} );
ok(!( "\c[KANGXI RADICAL ONE]" ~~ m/^<-isInKangxiRadicals>$/ ), q{Don't match inverted <isInKangxiRadicals>} );
ok(!( "\x[891A]"  ~~ m/^<.isInKangxiRadicals>$/ ), q{Don't match unrelated <isInKangxiRadicals>} );
ok("\x[891A]"  ~~ m/^<!isInKangxiRadicals>.$/, q{Match unrelated negated <isInKangxiRadicals>} );
ok("\x[891A]"  ~~ m/^<-isInKangxiRadicals>$/, q{Match unrelated inverted <isInKangxiRadicals>} );
ok("\x[891A]\c[KANGXI RADICAL ONE]" ~~ m/<.isInKangxiRadicals>/, q{Match unanchored <isInKangxiRadicals>} );

# InKannada


ok("\x[0C80]" ~~ m/^<.isInKannada>$/, q{Match <.isInKannada>} );
ok(!( "\x[0C80]" ~~ m/^<!isInKannada>.$/ ), q{Don't match negated <isInKannada>} );
ok(!( "\x[0C80]" ~~ m/^<-isInKannada>$/ ), q{Don't match inverted <isInKannada>} );
ok(!( "\x[B614]"  ~~ m/^<.isInKannada>$/ ), q{Don't match unrelated <isInKannada>} );
ok("\x[B614]"  ~~ m/^<!isInKannada>.$/, q{Match unrelated negated <isInKannada>} );
ok("\x[B614]"  ~~ m/^<-isInKannada>$/, q{Match unrelated inverted <isInKannada>} );
ok("\x[B614]\x[0C80]" ~~ m/<.isInKannada>/, q{Match unanchored <isInKannada>} );

# InKatakana


ok("\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/^<.isInKatakana>$/, q{Match <.isInKatakana>} );
ok(!( "\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/^<!isInKatakana>.$/ ), q{Don't match negated <isInKatakana>} );
ok(!( "\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/^<-isInKatakana>$/ ), q{Don't match inverted <isInKatakana>} );
ok(!( "\x[7EB8]"  ~~ m/^<.isInKatakana>$/ ), q{Don't match unrelated <isInKatakana>} );
ok("\x[7EB8]"  ~~ m/^<!isInKatakana>.$/, q{Match unrelated negated <isInKatakana>} );
ok("\x[7EB8]"  ~~ m/^<-isInKatakana>$/, q{Match unrelated inverted <isInKatakana>} );
ok("\x[7EB8]\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/<.isInKatakana>/, q{Match unanchored <isInKatakana>} );

# InKatakanaPhoneticExtensions


ok("\c[KATAKANA LETTER SMALL KU]" ~~ m/^<.isInKatakanaPhoneticExtensions>$/, q{Match <.isInKatakanaPhoneticExtensions>} );
ok(!( "\c[KATAKANA LETTER SMALL KU]" ~~ m/^<!isInKatakanaPhoneticExtensions>.$/ ), q{Don't match negated <isInKatakanaPhoneticExtensions>} );
ok(!( "\c[KATAKANA LETTER SMALL KU]" ~~ m/^<-isInKatakanaPhoneticExtensions>$/ ), q{Don't match inverted <isInKatakanaPhoneticExtensions>} );
ok(!( "\x[97C2]"  ~~ m/^<.isInKatakanaPhoneticExtensions>$/ ), q{Don't match unrelated <isInKatakanaPhoneticExtensions>} );
ok("\x[97C2]"  ~~ m/^<!isInKatakanaPhoneticExtensions>.$/, q{Match unrelated negated <isInKatakanaPhoneticExtensions>} );
ok("\x[97C2]"  ~~ m/^<-isInKatakanaPhoneticExtensions>$/, q{Match unrelated inverted <isInKatakanaPhoneticExtensions>} );
ok("\x[97C2]\c[KATAKANA LETTER SMALL KU]" ~~ m/<.isInKatakanaPhoneticExtensions>/, q{Match unanchored <isInKatakanaPhoneticExtensions>} );

# InKhmer

ok("\c[KHMER LETTER KA]" ~~ m/^<.isInKhmer>$/, q{Match <.isInKhmer>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<!isInKhmer>.$/ ), q{Don't match negated <isInKhmer>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<-isInKhmer>$/ ), q{Don't match inverted <isInKhmer>} );
ok(!( "\x[CAFA]"  ~~ m/^<.isInKhmer>$/ ), q{Don't match unrelated <isInKhmer>} );
ok("\x[CAFA]"  ~~ m/^<!isInKhmer>.$/, q{Match unrelated negated <isInKhmer>} );
ok("\x[CAFA]"  ~~ m/^<-isInKhmer>$/, q{Match unrelated inverted <isInKhmer>} );
ok("\x[CAFA]\c[KHMER LETTER KA]" ~~ m/<.isInKhmer>/, q{Match unanchored <isInKhmer>} );

# InLao


ok("\x[0E80]" ~~ m/^<.isInLao>$/, q{Match <.isInLao>} );
ok(!( "\x[0E80]" ~~ m/^<!isInLao>.$/ ), q{Don't match negated <isInLao>} );
ok(!( "\x[0E80]" ~~ m/^<-isInLao>$/ ), q{Don't match inverted <isInLao>} );
ok(!( "\x[07BF]"  ~~ m/^<.isInLao>$/ ), q{Don't match unrelated <isInLao>} );
ok("\x[07BF]"  ~~ m/^<!isInLao>.$/, q{Match unrelated negated <isInLao>} );
ok("\x[07BF]"  ~~ m/^<-isInLao>$/, q{Match unrelated inverted <isInLao>} );
ok("\x[07BF]\x[0E80]" ~~ m/<.isInLao>/, q{Match unanchored <isInLao>} );

# InLatin1Supplement


ok("\x[0080]" ~~ m/^<.isInLatin1Supplement>$/, q{Match <.isInLatin1Supplement>} );
ok(!( "\x[0080]" ~~ m/^<!isInLatin1Supplement>.$/ ), q{Don't match negated <isInLatin1Supplement>} );
ok(!( "\x[0080]" ~~ m/^<-isInLatin1Supplement>$/ ), q{Don't match inverted <isInLatin1Supplement>} );
ok(!( "\x[D062]"  ~~ m/^<.isInLatin1Supplement>$/ ), q{Don't match unrelated <isInLatin1Supplement>} );
ok("\x[D062]"  ~~ m/^<!isInLatin1Supplement>.$/, q{Match unrelated negated <isInLatin1Supplement>} );
ok("\x[D062]"  ~~ m/^<-isInLatin1Supplement>$/, q{Match unrelated inverted <isInLatin1Supplement>} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[D062]\x[0080]" ~~ m/<.isInLatin1Supplement>/, q{Match unanchored <isInLatin1Supplement>} );

# InLatinExtendedA


ok("\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/^<.isInLatinExtendedA>$/, q{Match <.isInLatinExtendedA>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/^<!isInLatinExtendedA>.$/ ), q{Don't match negated <isInLatinExtendedA>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/^<-isInLatinExtendedA>$/ ), q{Don't match inverted <isInLatinExtendedA>} );
ok(!( "\c[IDEOGRAPHIC ANNOTATION EARTH MARK]"  ~~ m/^<.isInLatinExtendedA>$/ ), q{Don't match unrelated <isInLatinExtendedA>} );
ok("\c[IDEOGRAPHIC ANNOTATION EARTH MARK]"  ~~ m/^<!isInLatinExtendedA>.$/, q{Match unrelated negated <isInLatinExtendedA>} );
ok("\c[IDEOGRAPHIC ANNOTATION EARTH MARK]"  ~~ m/^<-isInLatinExtendedA>$/, q{Match unrelated inverted <isInLatinExtendedA>} );
ok("\c[IDEOGRAPHIC ANNOTATION EARTH MARK]\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/<.isInLatinExtendedA>/, q{Match unanchored <isInLatinExtendedA>} );

# InLatinExtendedAdditional


ok("\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/^<.isInLatinExtendedAdditional>$/, q{Match <.isInLatinExtendedAdditional>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/^<!isInLatinExtendedAdditional>.$/ ), q{Don't match negated <isInLatinExtendedAdditional>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/^<-isInLatinExtendedAdditional>$/ ), q{Don't match inverted <isInLatinExtendedAdditional>} );
ok(!( "\x[9A44]"  ~~ m/^<.isInLatinExtendedAdditional>$/ ), q{Don't match unrelated <isInLatinExtendedAdditional>} );
ok("\x[9A44]"  ~~ m/^<!isInLatinExtendedAdditional>.$/, q{Match unrelated negated <isInLatinExtendedAdditional>} );
ok("\x[9A44]"  ~~ m/^<-isInLatinExtendedAdditional>$/, q{Match unrelated inverted <isInLatinExtendedAdditional>} );
ok("\x[9A44]\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/<.isInLatinExtendedAdditional>/, q{Match unanchored <isInLatinExtendedAdditional>} );

# InLatinExtendedB


ok("\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/^<.isInLatinExtendedB>$/, q{Match <.isInLatinExtendedB>} );
ok(!( "\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/^<!isInLatinExtendedB>.$/ ), q{Don't match negated <isInLatinExtendedB>} );
ok(!( "\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/^<-isInLatinExtendedB>$/ ), q{Don't match inverted <isInLatinExtendedB>} );
ok(!( "\x[7544]"  ~~ m/^<.isInLatinExtendedB>$/ ), q{Don't match unrelated <isInLatinExtendedB>} );
ok("\x[7544]"  ~~ m/^<!isInLatinExtendedB>.$/, q{Match unrelated negated <isInLatinExtendedB>} );
ok("\x[7544]"  ~~ m/^<-isInLatinExtendedB>$/, q{Match unrelated inverted <isInLatinExtendedB>} );
ok("\x[7544]\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/<.isInLatinExtendedB>/, q{Match unanchored <isInLatinExtendedB>} );

# InLetterlikeSymbols


ok("\c[ACCOUNT OF]" ~~ m/^<.isInLetterlikeSymbols>$/, q{Match <.isInLetterlikeSymbols>} );
ok(!( "\c[ACCOUNT OF]" ~~ m/^<!isInLetterlikeSymbols>.$/ ), q{Don't match negated <isInLetterlikeSymbols>} );
ok(!( "\c[ACCOUNT OF]" ~~ m/^<-isInLetterlikeSymbols>$/ ), q{Don't match inverted <isInLetterlikeSymbols>} );
ok(!( "\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]"  ~~ m/^<.isInLetterlikeSymbols>$/ ), q{Don't match unrelated <isInLetterlikeSymbols>} );
ok("\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]"  ~~ m/^<!isInLetterlikeSymbols>.$/, q{Match unrelated negated <isInLetterlikeSymbols>} );
ok("\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]"  ~~ m/^<-isInLetterlikeSymbols>$/, q{Match unrelated inverted <isInLetterlikeSymbols>} );
ok("\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]\c[ACCOUNT OF]" ~~ m/<.isInLetterlikeSymbols>/, q{Match unanchored <isInLetterlikeSymbols>} );

# InLowSurrogates


ok(!( "\x[5ECC]"  ~~ m/^<.isInLowSurrogates>$/ ), q{Don't match unrelated <isInLowSurrogates>} );
ok("\x[5ECC]"  ~~ m/^<!isInLowSurrogates>.$/, q{Match unrelated negated <isInLowSurrogates>} );
ok("\x[5ECC]"  ~~ m/^<-isInLowSurrogates>$/, q{Match unrelated inverted <isInLowSurrogates>} );

# InMalayalam


ok("\x[0D00]" ~~ m/^<.isInMalayalam>$/, q{Match <.isInMalayalam>} );
ok(!( "\x[0D00]" ~~ m/^<!isInMalayalam>.$/ ), q{Don't match negated <isInMalayalam>} );
ok(!( "\x[0D00]" ~~ m/^<-isInMalayalam>$/ ), q{Don't match inverted <isInMalayalam>} );
ok(!( "\x[3457]"  ~~ m/^<.isInMalayalam>$/ ), q{Don't match unrelated <isInMalayalam>} );
ok("\x[3457]"  ~~ m/^<!isInMalayalam>.$/, q{Match unrelated negated <isInMalayalam>} );
ok("\x[3457]"  ~~ m/^<-isInMalayalam>$/, q{Match unrelated inverted <isInMalayalam>} );
ok("\x[3457]\x[0D00]" ~~ m/<.isInMalayalam>/, q{Match unanchored <isInMalayalam>} );

# InMathematicalAlphanumericSymbols


ok(!( "\x[6B79]"  ~~ m/^<.isInMathematicalAlphanumericSymbols>$/ ), q{Don't match unrelated <isInMathematicalAlphanumericSymbols>} );
ok("\x[6B79]"  ~~ m/^<!isInMathematicalAlphanumericSymbols>.$/, q{Match unrelated negated <isInMathematicalAlphanumericSymbols>} );
ok("\x[6B79]"  ~~ m/^<-isInMathematicalAlphanumericSymbols>$/, q{Match unrelated inverted <isInMathematicalAlphanumericSymbols>} );

# InMathematicalOperators


ok("\c[FOR ALL]" ~~ m/^<.isInMathematicalOperators>$/, q{Match <.isInMathematicalOperators>} );
ok(!( "\c[FOR ALL]" ~~ m/^<!isInMathematicalOperators>.$/ ), q{Don't match negated <isInMathematicalOperators>} );
ok(!( "\c[FOR ALL]" ~~ m/^<-isInMathematicalOperators>$/ ), q{Don't match inverted <isInMathematicalOperators>} );
ok(!( "\x[BBC6]"  ~~ m/^<.isInMathematicalOperators>$/ ), q{Don't match unrelated <isInMathematicalOperators>} );
ok("\x[BBC6]"  ~~ m/^<!isInMathematicalOperators>.$/, q{Match unrelated negated <isInMathematicalOperators>} );
ok("\x[BBC6]"  ~~ m/^<-isInMathematicalOperators>$/, q{Match unrelated inverted <isInMathematicalOperators>} );
ok("\x[BBC6]\c[FOR ALL]" ~~ m/<.isInMathematicalOperators>/, q{Match unanchored <isInMathematicalOperators>} );

# InMiscellaneousMathematicalSymbolsA


ok("\x[27C0]" ~~ m/^<.isInMiscellaneousMathematicalSymbolsA>$/, q{Match <.isInMiscellaneousMathematicalSymbolsA>} );
ok(!( "\x[27C0]" ~~ m/^<!isInMiscellaneousMathematicalSymbolsA>.$/ ), q{Don't match negated <isInMiscellaneousMathematicalSymbolsA>} );
ok(!( "\x[27C0]" ~~ m/^<-isInMiscellaneousMathematicalSymbolsA>$/ ), q{Don't match inverted <isInMiscellaneousMathematicalSymbolsA>} );
ok(!( "\x[065D]"  ~~ m/^<.isInMiscellaneousMathematicalSymbolsA>$/ ), q{Don't match unrelated <isInMiscellaneousMathematicalSymbolsA>} );
ok("\x[065D]"  ~~ m/^<!isInMiscellaneousMathematicalSymbolsA>.$/, q{Match unrelated negated <isInMiscellaneousMathematicalSymbolsA>} );
ok("\x[065D]"  ~~ m/^<-isInMiscellaneousMathematicalSymbolsA>$/, q{Match unrelated inverted <isInMiscellaneousMathematicalSymbolsA>} );
ok("\x[065D]\x[27C0]" ~~ m/<.isInMiscellaneousMathematicalSymbolsA>/, q{Match unanchored <isInMiscellaneousMathematicalSymbolsA>} );

# InMiscellaneousMathematicalSymbolsB


ok("\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/^<.isInMiscellaneousMathematicalSymbolsB>$/, q{Match <.isInMiscellaneousMathematicalSymbolsB>} );
ok(!( "\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/^<!isInMiscellaneousMathematicalSymbolsB>.$/ ), q{Don't match negated <isInMiscellaneousMathematicalSymbolsB>} );
ok(!( "\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/^<-isInMiscellaneousMathematicalSymbolsB>$/ ), q{Don't match inverted <isInMiscellaneousMathematicalSymbolsB>} );
ok(!( "\x[56A6]"  ~~ m/^<.isInMiscellaneousMathematicalSymbolsB>$/ ), q{Don't match unrelated <isInMiscellaneousMathematicalSymbolsB>} );
ok("\x[56A6]"  ~~ m/^<!isInMiscellaneousMathematicalSymbolsB>.$/, q{Match unrelated negated <isInMiscellaneousMathematicalSymbolsB>} );
ok("\x[56A6]"  ~~ m/^<-isInMiscellaneousMathematicalSymbolsB>$/, q{Match unrelated inverted <isInMiscellaneousMathematicalSymbolsB>} );
ok("\x[56A6]\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/<.isInMiscellaneousMathematicalSymbolsB>/, q{Match unanchored <isInMiscellaneousMathematicalSymbolsB>} );

# InMiscellaneousSymbols


ok("\c[BLACK SUN WITH RAYS]" ~~ m/^<.isInMiscellaneousSymbols>$/, q{Match <.isInMiscellaneousSymbols>} );
ok(!( "\c[BLACK SUN WITH RAYS]" ~~ m/^<!isInMiscellaneousSymbols>.$/ ), q{Don't match negated <isInMiscellaneousSymbols>} );
ok(!( "\c[BLACK SUN WITH RAYS]" ~~ m/^<-isInMiscellaneousSymbols>$/ ), q{Don't match inverted <isInMiscellaneousSymbols>} );
ok(!( "\x[3EE7]"  ~~ m/^<.isInMiscellaneousSymbols>$/ ), q{Don't match unrelated <isInMiscellaneousSymbols>} );
ok("\x[3EE7]"  ~~ m/^<!isInMiscellaneousSymbols>.$/, q{Match unrelated negated <isInMiscellaneousSymbols>} );
ok("\x[3EE7]"  ~~ m/^<-isInMiscellaneousSymbols>$/, q{Match unrelated inverted <isInMiscellaneousSymbols>} );
ok("\x[3EE7]\c[BLACK SUN WITH RAYS]" ~~ m/<.isInMiscellaneousSymbols>/, q{Match unanchored <isInMiscellaneousSymbols>} );

# InMiscellaneousTechnical


ok("\c[DIAMETER SIGN]" ~~ m/^<.isInMiscellaneousTechnical>$/, q{Match <.isInMiscellaneousTechnical>} );
ok(!( "\c[DIAMETER SIGN]" ~~ m/^<!isInMiscellaneousTechnical>.$/ ), q{Don't match negated <isInMiscellaneousTechnical>} );
ok(!( "\c[DIAMETER SIGN]" ~~ m/^<-isInMiscellaneousTechnical>$/ ), q{Don't match inverted <isInMiscellaneousTechnical>} );
ok(!( "\x[2EFC]"  ~~ m/^<.isInMiscellaneousTechnical>$/ ), q{Don't match unrelated <isInMiscellaneousTechnical>} );
ok("\x[2EFC]"  ~~ m/^<!isInMiscellaneousTechnical>.$/, q{Match unrelated negated <isInMiscellaneousTechnical>} );
ok("\x[2EFC]"  ~~ m/^<-isInMiscellaneousTechnical>$/, q{Match unrelated inverted <isInMiscellaneousTechnical>} );
ok("\x[2EFC]\c[DIAMETER SIGN]" ~~ m/<.isInMiscellaneousTechnical>/, q{Match unanchored <isInMiscellaneousTechnical>} );

# InMongolian


ok("\c[MONGOLIAN BIRGA]" ~~ m/^<.isInMongolian>$/, q{Match <.isInMongolian>} );
ok(!( "\c[MONGOLIAN BIRGA]" ~~ m/^<!isInMongolian>.$/ ), q{Don't match negated <isInMongolian>} );
ok(!( "\c[MONGOLIAN BIRGA]" ~~ m/^<-isInMongolian>$/ ), q{Don't match inverted <isInMongolian>} );
ok(!( "\x[AFB4]"  ~~ m/^<.isInMongolian>$/ ), q{Don't match unrelated <isInMongolian>} );
ok("\x[AFB4]"  ~~ m/^<!isInMongolian>.$/, q{Match unrelated negated <isInMongolian>} );
ok("\x[AFB4]"  ~~ m/^<-isInMongolian>$/, q{Match unrelated inverted <isInMongolian>} );
ok("\x[AFB4]\c[MONGOLIAN BIRGA]" ~~ m/<.isInMongolian>/, q{Match unanchored <isInMongolian>} );

# InMusicalSymbols


ok(!( "\x[0CE4]"  ~~ m/^<.isInMusicalSymbols>$/ ), q{Don't match unrelated <isInMusicalSymbols>} );
ok("\x[0CE4]"  ~~ m/^<!isInMusicalSymbols>.$/, q{Match unrelated negated <isInMusicalSymbols>} );
ok("\x[0CE4]"  ~~ m/^<-isInMusicalSymbols>$/, q{Match unrelated inverted <isInMusicalSymbols>} );

# InMyanmar


ok("\c[MYANMAR LETTER KA]" ~~ m/^<.isInMyanmar>$/, q{Match <.isInMyanmar>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<!isInMyanmar>.$/ ), q{Don't match negated <isInMyanmar>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<-isInMyanmar>$/ ), q{Don't match inverted <isInMyanmar>} );
ok(!( "\x[1DDB]"  ~~ m/^<.isInMyanmar>$/ ), q{Don't match unrelated <isInMyanmar>} );
ok("\x[1DDB]"  ~~ m/^<!isInMyanmar>.$/, q{Match unrelated negated <isInMyanmar>} );
ok("\x[1DDB]"  ~~ m/^<-isInMyanmar>$/, q{Match unrelated inverted <isInMyanmar>} );
ok("\x[1DDB]\c[MYANMAR LETTER KA]" ~~ m/<.isInMyanmar>/, q{Match unanchored <isInMyanmar>} );

# InNumberForms

ok("\x[2150]" ~~ m/^<.isInNumberForms>$/, q{Match <.isInNumberForms>} );
ok(!( "\x[2150]" ~~ m/^<!isInNumberForms>.$/ ), q{Don't match negated <isInNumberForms>} );
ok(!( "\x[2150]" ~~ m/^<-isInNumberForms>$/ ), q{Don't match inverted <isInNumberForms>} );
ok(!( "\c[BLACK RIGHT-POINTING SMALL TRIANGLE]"  ~~ m/^<.isInNumberForms>$/ ), q{Don't match unrelated <isInNumberForms>} );
ok("\c[BLACK RIGHT-POINTING SMALL TRIANGLE]"  ~~ m/^<!isInNumberForms>.$/, q{Match unrelated negated <isInNumberForms>} );
ok("\c[BLACK RIGHT-POINTING SMALL TRIANGLE]"  ~~ m/^<-isInNumberForms>$/, q{Match unrelated inverted <isInNumberForms>} );
ok("\c[BLACK RIGHT-POINTING SMALL TRIANGLE]\x[2150]" ~~ m/<.isInNumberForms>/, q{Match unanchored <isInNumberForms>} );

# InOgham


ok("\c[OGHAM SPACE MARK]" ~~ m/^<.isInOgham>$/, q{Match <.isInOgham>} );
ok(!( "\c[OGHAM SPACE MARK]" ~~ m/^<!isInOgham>.$/ ), q{Don't match negated <isInOgham>} );
ok(!( "\c[OGHAM SPACE MARK]" ~~ m/^<-isInOgham>$/ ), q{Don't match inverted <isInOgham>} );
ok(!( "\x[768C]"  ~~ m/^<.isInOgham>$/ ), q{Don't match unrelated <isInOgham>} );
ok("\x[768C]"  ~~ m/^<!isInOgham>.$/, q{Match unrelated negated <isInOgham>} );
ok("\x[768C]"  ~~ m/^<-isInOgham>$/, q{Match unrelated inverted <isInOgham>} );
ok("\x[768C]\c[OGHAM SPACE MARK]" ~~ m/<.isInOgham>/, q{Match unanchored <isInOgham>} );

# InOldItalic


ok(!( "\x[C597]"  ~~ m/^<.isInOldItalic>$/ ), q{Don't match unrelated <isInOldItalic>} );
ok("\x[C597]"  ~~ m/^<!isInOldItalic>.$/, q{Match unrelated negated <isInOldItalic>} );
ok("\x[C597]"  ~~ m/^<-isInOldItalic>$/, q{Match unrelated inverted <isInOldItalic>} );

# InOpticalCharacterRecognition


ok("\c[OCR HOOK]" ~~ m/^<.isInOpticalCharacterRecognition>$/, q{Match <.isInOpticalCharacterRecognition>} );
ok(!( "\c[OCR HOOK]" ~~ m/^<!isInOpticalCharacterRecognition>.$/ ), q{Don't match negated <isInOpticalCharacterRecognition>} );
ok(!( "\c[OCR HOOK]" ~~ m/^<-isInOpticalCharacterRecognition>$/ ), q{Don't match inverted <isInOpticalCharacterRecognition>} );
ok(!( "\x[BE80]"  ~~ m/^<.isInOpticalCharacterRecognition>$/ ), q{Don't match unrelated <isInOpticalCharacterRecognition>} );
ok("\x[BE80]"  ~~ m/^<!isInOpticalCharacterRecognition>.$/, q{Match unrelated negated <isInOpticalCharacterRecognition>} );
ok("\x[BE80]"  ~~ m/^<-isInOpticalCharacterRecognition>$/, q{Match unrelated inverted <isInOpticalCharacterRecognition>} );
ok("\x[BE80]\c[OCR HOOK]" ~~ m/<.isInOpticalCharacterRecognition>/, q{Match unanchored <isInOpticalCharacterRecognition>} );

# InOriya


ok("\x[0B00]" ~~ m/^<.isInOriya>$/, q{Match <.isInOriya>} );
ok(!( "\x[0B00]" ~~ m/^<!isInOriya>.$/ ), q{Don't match negated <isInOriya>} );
ok(!( "\x[0B00]" ~~ m/^<-isInOriya>$/ ), q{Don't match inverted <isInOriya>} );
ok(!( "\c[YI SYLLABLE GGEX]"  ~~ m/^<.isInOriya>$/ ), q{Don't match unrelated <isInOriya>} );
ok("\c[YI SYLLABLE GGEX]"  ~~ m/^<!isInOriya>.$/, q{Match unrelated negated <isInOriya>} );
ok("\c[YI SYLLABLE GGEX]"  ~~ m/^<-isInOriya>$/, q{Match unrelated inverted <isInOriya>} );
ok("\c[YI SYLLABLE GGEX]\x[0B00]" ~~ m/<.isInOriya>/, q{Match unanchored <isInOriya>} );

# InPrivateUseArea


ok(!( "\x[B6B1]"  ~~ m/^<.isInPrivateUseArea>$/ ), q{Don't match unrelated <isInPrivateUseArea>} );
ok("\x[B6B1]"  ~~ m/^<!isInPrivateUseArea>.$/, q{Match unrelated negated <isInPrivateUseArea>} );
ok("\x[B6B1]"  ~~ m/^<-isInPrivateUseArea>$/, q{Match unrelated inverted <isInPrivateUseArea>} );

# InRunic


ok("\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<.isInRunic>$/, q{Match <.isInRunic>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<!isInRunic>.$/ ), q{Don't match negated <isInRunic>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<-isInRunic>$/ ), q{Don't match inverted <isInRunic>} );
ok(!( "\c[SINHALA LETTER MAHAAPRAANA KAYANNA]"  ~~ m/^<.isInRunic>$/ ), q{Don't match unrelated <isInRunic>} );
ok("\c[SINHALA LETTER MAHAAPRAANA KAYANNA]"  ~~ m/^<!isInRunic>.$/, q{Match unrelated negated <isInRunic>} );
ok("\c[SINHALA LETTER MAHAAPRAANA KAYANNA]"  ~~ m/^<-isInRunic>$/, q{Match unrelated inverted <isInRunic>} );
ok("\c[SINHALA LETTER MAHAAPRAANA KAYANNA]\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/<.isInRunic>/, q{Match unanchored <isInRunic>} );

# InSinhala


ok("\x[0D80]" ~~ m/^<.isInSinhala>$/, q{Match <.isInSinhala>} );
ok(!( "\x[0D80]" ~~ m/^<!isInSinhala>.$/ ), q{Don't match negated <isInSinhala>} );
ok(!( "\x[0D80]" ~~ m/^<-isInSinhala>$/ ), q{Don't match inverted <isInSinhala>} );
ok(!( "\x[1060]"  ~~ m/^<.isInSinhala>$/ ), q{Don't match unrelated <isInSinhala>} );
ok("\x[1060]"  ~~ m/^<!isInSinhala>.$/, q{Match unrelated negated <isInSinhala>} );
ok("\x[1060]"  ~~ m/^<-isInSinhala>$/, q{Match unrelated inverted <isInSinhala>} );
ok("\x[1060]\x[0D80]" ~~ m/<.isInSinhala>/, q{Match unanchored <isInSinhala>} );

# InSmallFormVariants


ok(!( "\x[5285]"  ~~ m/^<.isInSmallFormVariants>$/ ), q{Don't match unrelated <isInSmallFormVariants>} );
ok("\x[5285]"  ~~ m/^<!isInSmallFormVariants>.$/, q{Match unrelated negated <isInSmallFormVariants>} );
ok("\x[5285]"  ~~ m/^<-isInSmallFormVariants>$/, q{Match unrelated inverted <isInSmallFormVariants>} );

# InSpacingModifierLetters


ok("\c[MODIFIER LETTER SMALL H]" ~~ m/^<.isInSpacingModifierLetters>$/, q{Match <.isInSpacingModifierLetters>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<!isInSpacingModifierLetters>.$/ ), q{Don't match negated <isInSpacingModifierLetters>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<-isInSpacingModifierLetters>$/ ), q{Don't match inverted <isInSpacingModifierLetters>} );
ok(!( "\x[5326]"  ~~ m/^<.isInSpacingModifierLetters>$/ ), q{Don't match unrelated <isInSpacingModifierLetters>} );
ok("\x[5326]"  ~~ m/^<!isInSpacingModifierLetters>.$/, q{Match unrelated negated <isInSpacingModifierLetters>} );
ok("\x[5326]"  ~~ m/^<-isInSpacingModifierLetters>$/, q{Match unrelated inverted <isInSpacingModifierLetters>} );
ok("\x[5326]\c[MODIFIER LETTER SMALL H]" ~~ m/<.isInSpacingModifierLetters>/, q{Match unanchored <isInSpacingModifierLetters>} );

# InSpecials


ok(!( "\x[3DF1]"  ~~ m/^<.isInSpecials>$/ ), q{Don't match unrelated <isInSpecials>} );
ok("\x[3DF1]"  ~~ m/^<!isInSpecials>.$/, q{Match unrelated negated <isInSpecials>} );
ok("\x[3DF1]"  ~~ m/^<-isInSpecials>$/, q{Match unrelated inverted <isInSpecials>} );

# InSuperscriptsAndSubscripts


ok("\c[SUPERSCRIPT ZERO]" ~~ m/^<.isInSuperscriptsAndSubscripts>$/, q{Match <.isInSuperscriptsAndSubscripts>} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<!isInSuperscriptsAndSubscripts>.$/ ), q{Don't match negated <isInSuperscriptsAndSubscripts>} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<-isInSuperscriptsAndSubscripts>$/ ), q{Don't match inverted <isInSuperscriptsAndSubscripts>} );
ok(!( "\x[3E71]"  ~~ m/^<.isInSuperscriptsAndSubscripts>$/ ), q{Don't match unrelated <isInSuperscriptsAndSubscripts>} );
ok("\x[3E71]"  ~~ m/^<!isInSuperscriptsAndSubscripts>.$/, q{Match unrelated negated <isInSuperscriptsAndSubscripts>} );
ok("\x[3E71]"  ~~ m/^<-isInSuperscriptsAndSubscripts>$/, q{Match unrelated inverted <isInSuperscriptsAndSubscripts>} );
ok("\x[3E71]\c[SUPERSCRIPT ZERO]" ~~ m/<.isInSuperscriptsAndSubscripts>/, q{Match unanchored <isInSuperscriptsAndSubscripts>} );

# InSupplementalArrowsA


ok("\c[UPWARDS QUADRUPLE ARROW]" ~~ m/^<.isInSupplementalArrowsA>$/, q{Match <.isInSupplementalArrowsA>} );
ok(!( "\c[UPWARDS QUADRUPLE ARROW]" ~~ m/^<!isInSupplementalArrowsA>.$/ ), q{Don't match negated <isInSupplementalArrowsA>} );
ok(!( "\c[UPWARDS QUADRUPLE ARROW]" ~~ m/^<-isInSupplementalArrowsA>$/ ), q{Don't match inverted <isInSupplementalArrowsA>} );
ok(!( "\c[GREEK SMALL LETTER OMICRON WITH TONOS]"  ~~ m/^<.isInSupplementalArrowsA>$/ ), q{Don't match unrelated <isInSupplementalArrowsA>} );
ok("\c[GREEK SMALL LETTER OMICRON WITH TONOS]"  ~~ m/^<!isInSupplementalArrowsA>.$/, q{Match unrelated negated <isInSupplementalArrowsA>} );
ok("\c[GREEK SMALL LETTER OMICRON WITH TONOS]"  ~~ m/^<-isInSupplementalArrowsA>$/, q{Match unrelated inverted <isInSupplementalArrowsA>} );
ok("\c[GREEK SMALL LETTER OMICRON WITH TONOS]\c[UPWARDS QUADRUPLE ARROW]" ~~ m/<.isInSupplementalArrowsA>/, q{Match unanchored <isInSupplementalArrowsA>} );

# InSupplementalArrowsB


ok("\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/^<.isInSupplementalArrowsB>$/, q{Match <.isInSupplementalArrowsB>} );
ok(!( "\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/^<!isInSupplementalArrowsB>.$/ ), q{Don't match negated <isInSupplementalArrowsB>} );
ok(!( "\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/^<-isInSupplementalArrowsB>$/ ), q{Don't match inverted <isInSupplementalArrowsB>} );
ok(!( "\x[C1A9]"  ~~ m/^<.isInSupplementalArrowsB>$/ ), q{Don't match unrelated <isInSupplementalArrowsB>} );
ok("\x[C1A9]"  ~~ m/^<!isInSupplementalArrowsB>.$/, q{Match unrelated negated <isInSupplementalArrowsB>} );
ok("\x[C1A9]"  ~~ m/^<-isInSupplementalArrowsB>$/, q{Match unrelated inverted <isInSupplementalArrowsB>} );
ok("\x[C1A9]\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/<.isInSupplementalArrowsB>/, q{Match unanchored <isInSupplementalArrowsB>} );

# InSupplementalMathematicalOperators


ok("\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/^<.isInSupplementalMathematicalOperators>$/, q{Match <.isInSupplementalMathematicalOperators>} );
ok(!( "\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/^<!isInSupplementalMathematicalOperators>.$/ ), q{Don't match negated <isInSupplementalMathematicalOperators>} );
ok(!( "\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/^<-isInSupplementalMathematicalOperators>$/ ), q{Don't match inverted <isInSupplementalMathematicalOperators>} );
ok(!( "\x[9EBD]"  ~~ m/^<.isInSupplementalMathematicalOperators>$/ ), q{Don't match unrelated <isInSupplementalMathematicalOperators>} );
ok("\x[9EBD]"  ~~ m/^<!isInSupplementalMathematicalOperators>.$/, q{Match unrelated negated <isInSupplementalMathematicalOperators>} );
ok("\x[9EBD]"  ~~ m/^<-isInSupplementalMathematicalOperators>$/, q{Match unrelated inverted <isInSupplementalMathematicalOperators>} );
ok("\x[9EBD]\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/<.isInSupplementalMathematicalOperators>/, q{Match unanchored <isInSupplementalMathematicalOperators>} );

# InSupplementaryPrivateUseAreaA


ok(!( "\x[07E3]"  ~~ m/^<.isInSupplementaryPrivateUseAreaA>$/ ), q{Don't match unrelated <isInSupplementaryPrivateUseAreaA>} );
ok("\x[07E3]"  ~~ m/^<!isInSupplementaryPrivateUseAreaA>.$/, q{Match unrelated negated <isInSupplementaryPrivateUseAreaA>} );
ok("\x[07E3]"  ~~ m/^<-isInSupplementaryPrivateUseAreaA>$/, q{Match unrelated inverted <isInSupplementaryPrivateUseAreaA>} );

# InSupplementaryPrivateUseAreaB


ok(!( "\x[4C48]"  ~~ m/^<.isInSupplementaryPrivateUseAreaB>$/ ), q{Don't match unrelated <isInSupplementaryPrivateUseAreaB>} );
ok("\x[4C48]"  ~~ m/^<!isInSupplementaryPrivateUseAreaB>.$/, q{Match unrelated negated <isInSupplementaryPrivateUseAreaB>} );
ok("\x[4C48]"  ~~ m/^<-isInSupplementaryPrivateUseAreaB>$/, q{Match unrelated inverted <isInSupplementaryPrivateUseAreaB>} );

# InSyriac


ok("\c[SYRIAC END OF PARAGRAPH]" ~~ m/^<.isInSyriac>$/, q{Match <.isInSyriac>} );
ok(!( "\c[SYRIAC END OF PARAGRAPH]" ~~ m/^<!isInSyriac>.$/ ), q{Don't match negated <isInSyriac>} );
ok(!( "\c[SYRIAC END OF PARAGRAPH]" ~~ m/^<-isInSyriac>$/ ), q{Don't match inverted <isInSyriac>} );
ok(!( "\c[YI SYLLABLE NZIEP]"  ~~ m/^<.isInSyriac>$/ ), q{Don't match unrelated <isInSyriac>} );
ok("\c[YI SYLLABLE NZIEP]"  ~~ m/^<!isInSyriac>.$/, q{Match unrelated negated <isInSyriac>} );
ok("\c[YI SYLLABLE NZIEP]"  ~~ m/^<-isInSyriac>$/, q{Match unrelated inverted <isInSyriac>} );
ok("\c[YI SYLLABLE NZIEP]\c[SYRIAC END OF PARAGRAPH]" ~~ m/<.isInSyriac>/, q{Match unanchored <isInSyriac>} );

# InTagalog


ok("\c[TAGALOG LETTER A]" ~~ m/^<.isInTagalog>$/, q{Match <.isInTagalog>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<!isInTagalog>.$/ ), q{Don't match negated <isInTagalog>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<-isInTagalog>$/ ), q{Don't match inverted <isInTagalog>} );
ok(!( "\c[GEORGIAN LETTER BAN]"  ~~ m/^<.isInTagalog>$/ ), q{Don't match unrelated <isInTagalog>} );
ok("\c[GEORGIAN LETTER BAN]"  ~~ m/^<!isInTagalog>.$/, q{Match unrelated negated <isInTagalog>} );
ok("\c[GEORGIAN LETTER BAN]"  ~~ m/^<-isInTagalog>$/, q{Match unrelated inverted <isInTagalog>} );
ok("\c[GEORGIAN LETTER BAN]\c[TAGALOG LETTER A]" ~~ m/<.isInTagalog>/, q{Match unanchored <isInTagalog>} );

# InTagbanwa


ok("\c[TAGBANWA LETTER A]" ~~ m/^<.isInTagbanwa>$/, q{Match <.isInTagbanwa>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<!isInTagbanwa>.$/ ), q{Don't match negated <isInTagbanwa>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<-isInTagbanwa>$/ ), q{Don't match inverted <isInTagbanwa>} );
ok(!( "\x[5776]"  ~~ m/^<.isInTagbanwa>$/ ), q{Don't match unrelated <isInTagbanwa>} );
ok("\x[5776]"  ~~ m/^<!isInTagbanwa>.$/, q{Match unrelated negated <isInTagbanwa>} );
ok("\x[5776]"  ~~ m/^<-isInTagbanwa>$/, q{Match unrelated inverted <isInTagbanwa>} );
ok("\x[5776]\c[TAGBANWA LETTER A]" ~~ m/<.isInTagbanwa>/, q{Match unanchored <isInTagbanwa>} );

# InTags


ok(!( "\x[3674]"  ~~ m/^<.isInTags>$/ ), q{Don't match unrelated <isInTags>} );
ok("\x[3674]"  ~~ m/^<!isInTags>.$/, q{Match unrelated negated <isInTags>} );
ok("\x[3674]"  ~~ m/^<-isInTags>$/, q{Match unrelated inverted <isInTags>} );

# InTamil


ok("\x[0B80]" ~~ m/^<.isInTamil>$/, q{Match <.isInTamil>} );
ok(!( "\x[0B80]" ~~ m/^<!isInTamil>.$/ ), q{Don't match negated <isInTamil>} );
ok(!( "\x[0B80]" ~~ m/^<-isInTamil>$/ ), q{Don't match inverted <isInTamil>} );
ok(!( "\x[B58F]"  ~~ m/^<.isInTamil>$/ ), q{Don't match unrelated <isInTamil>} );
ok("\x[B58F]"  ~~ m/^<!isInTamil>.$/, q{Match unrelated negated <isInTamil>} );
ok("\x[B58F]"  ~~ m/^<-isInTamil>$/, q{Match unrelated inverted <isInTamil>} );
ok("\x[B58F]\x[0B80]" ~~ m/<.isInTamil>/, q{Match unanchored <isInTamil>} );

# InTelugu


ok("\x[0C00]" ~~ m/^<.isInTelugu>$/, q{Match <.isInTelugu>} );
ok(!( "\x[0C00]" ~~ m/^<!isInTelugu>.$/ ), q{Don't match negated <isInTelugu>} );
ok(!( "\x[0C00]" ~~ m/^<-isInTelugu>$/ ), q{Don't match inverted <isInTelugu>} );
ok(!( "\x[8AC5]"  ~~ m/^<.isInTelugu>$/ ), q{Don't match unrelated <isInTelugu>} );
ok("\x[8AC5]"  ~~ m/^<!isInTelugu>.$/, q{Match unrelated negated <isInTelugu>} );
ok("\x[8AC5]"  ~~ m/^<-isInTelugu>$/, q{Match unrelated inverted <isInTelugu>} );
ok("\x[8AC5]\x[0C00]" ~~ m/<.isInTelugu>/, q{Match unanchored <isInTelugu>} );

# InThaana


ok("\c[THAANA LETTER HAA]" ~~ m/^<.isInThaana>$/, q{Match <.isInThaana>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<!isInThaana>.$/ ), q{Don't match negated <isInThaana>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<-isInThaana>$/ ), q{Don't match inverted <isInThaana>} );
ok(!( "\x[BB8F]"  ~~ m/^<.isInThaana>$/ ), q{Don't match unrelated <isInThaana>} );
ok("\x[BB8F]"  ~~ m/^<!isInThaana>.$/, q{Match unrelated negated <isInThaana>} );
ok("\x[BB8F]"  ~~ m/^<-isInThaana>$/, q{Match unrelated inverted <isInThaana>} );
ok("\x[BB8F]\c[THAANA LETTER HAA]" ~~ m/<.isInThaana>/, q{Match unanchored <isInThaana>} );

# InThai


ok("\x[0E00]" ~~ m/^<.isInThai>$/, q{Match <.isInThai>} );
ok(!( "\x[0E00]" ~~ m/^<!isInThai>.$/ ), q{Don't match negated <isInThai>} );
ok(!( "\x[0E00]" ~~ m/^<-isInThai>$/ ), q{Don't match inverted <isInThai>} );
ok(!( "\x[9395]"  ~~ m/^<.isInThai>$/ ), q{Don't match unrelated <isInThai>} );
ok("\x[9395]"  ~~ m/^<!isInThai>.$/, q{Match unrelated negated <isInThai>} );
ok("\x[9395]"  ~~ m/^<-isInThai>$/, q{Match unrelated inverted <isInThai>} );
ok("\x[9395]\x[0E00]" ~~ m/<.isInThai>/, q{Match unanchored <isInThai>} );

# InTibetan


ok("\c[TIBETAN SYLLABLE OM]" ~~ m/^<.isInTibetan>$/, q{Match <.isInTibetan>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<!isInTibetan>.$/ ), q{Don't match negated <isInTibetan>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<-isInTibetan>$/ ), q{Don't match inverted <isInTibetan>} );
ok(!( "\x[957A]"  ~~ m/^<.isInTibetan>$/ ), q{Don't match unrelated <isInTibetan>} );
ok("\x[957A]"  ~~ m/^<!isInTibetan>.$/, q{Match unrelated negated <isInTibetan>} );
ok("\x[957A]"  ~~ m/^<-isInTibetan>$/, q{Match unrelated inverted <isInTibetan>} );
ok("\x[957A]\c[TIBETAN SYLLABLE OM]" ~~ m/<.isInTibetan>/, q{Match unanchored <isInTibetan>} );

# InUnifiedCanadianAboriginalSyllabics


ok("\x[1400]" ~~ m/^<.isInUnifiedCanadianAboriginalSyllabics>$/, q{Match <.isInUnifiedCanadianAboriginalSyllabics>} );
ok(!( "\x[1400]" ~~ m/^<!isInUnifiedCanadianAboriginalSyllabics>.$/ ), q{Don't match negated <isInUnifiedCanadianAboriginalSyllabics>} );
ok(!( "\x[1400]" ~~ m/^<-isInUnifiedCanadianAboriginalSyllabics>$/ ), q{Don't match inverted <isInUnifiedCanadianAboriginalSyllabics>} );
ok(!( "\x[9470]"  ~~ m/^<.isInUnifiedCanadianAboriginalSyllabics>$/ ), q{Don't match unrelated <isInUnifiedCanadianAboriginalSyllabics>} );
ok("\x[9470]"  ~~ m/^<!isInUnifiedCanadianAboriginalSyllabics>.$/, q{Match unrelated negated <isInUnifiedCanadianAboriginalSyllabics>} );
ok("\x[9470]"  ~~ m/^<-isInUnifiedCanadianAboriginalSyllabics>$/, q{Match unrelated inverted <isInUnifiedCanadianAboriginalSyllabics>} );
ok("\x[9470]\x[1400]" ~~ m/<.isInUnifiedCanadianAboriginalSyllabics>/, q{Match unanchored <isInUnifiedCanadianAboriginalSyllabics>} );

# InVariationSelectors


ok(!( "\x[764D]"  ~~ m/^<.isInVariationSelectors>$/ ), q{Don't match unrelated <isInVariationSelectors>} );
ok("\x[764D]"  ~~ m/^<!isInVariationSelectors>.$/, q{Match unrelated negated <isInVariationSelectors>} );
ok("\x[764D]"  ~~ m/^<-isInVariationSelectors>$/, q{Match unrelated inverted <isInVariationSelectors>} );

# InYiRadicals


ok("\c[YI RADICAL QOT]" ~~ m/^<.isInYiRadicals>$/, q{Match <.isInYiRadicals>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<!isInYiRadicals>.$/ ), q{Don't match negated <isInYiRadicals>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-isInYiRadicals>$/ ), q{Don't match inverted <isInYiRadicals>} );
ok(!( "\x[3A4E]"  ~~ m/^<.isInYiRadicals>$/ ), q{Don't match unrelated <isInYiRadicals>} );
ok("\x[3A4E]"  ~~ m/^<!isInYiRadicals>.$/, q{Match unrelated negated <isInYiRadicals>} );
ok("\x[3A4E]"  ~~ m/^<-isInYiRadicals>$/, q{Match unrelated inverted <isInYiRadicals>} );
ok("\x[3A4E]\c[YI RADICAL QOT]" ~~ m/<.isInYiRadicals>/, q{Match unanchored <isInYiRadicals>} );

# InYiSyllables


ok("\c[YI SYLLABLE IT]" ~~ m/^<.isInYiSyllables>$/, q{Match <.isInYiSyllables>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<!isInYiSyllables>.$/ ), q{Don't match negated <isInYiSyllables>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<-isInYiSyllables>$/ ), q{Don't match inverted <isInYiSyllables>} );
ok(!( "\c[PARALLEL WITH HORIZONTAL STROKE]"  ~~ m/^<.isInYiSyllables>$/ ), q{Don't match unrelated <isInYiSyllables>} );
ok("\c[PARALLEL WITH HORIZONTAL STROKE]"  ~~ m/^<!isInYiSyllables>.$/, q{Match unrelated negated <isInYiSyllables>} );
ok("\c[PARALLEL WITH HORIZONTAL STROKE]"  ~~ m/^<-isInYiSyllables>$/, q{Match unrelated inverted <isInYiSyllables>} );
ok("\c[PARALLEL WITH HORIZONTAL STROKE]\c[YI SYLLABLE IT]" ~~ m/<.isInYiSyllables>/, q{Match unanchored <isInYiSyllables>} );


