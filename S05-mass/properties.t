use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/properties_slow_to_compile.t.

XXX needs more clarification on the case of the rules, 
ie letter vs. Letter vs isLetter

=end pod

plan 1881;

if !eval('("a" ~~ /a/)') {
  skip_rest "skipped tests - rules support appears to be missing";
} else {


#?pugs emit  force_todo(4,5,6,11,12,13,99,100,101,103,107,108,110,111,112,134,135,151,152,168,169,410,411,447,448,544,545,546,550,592,593,595,599,600,601,602,606,607,608,609,613,614,615,616,620,621,622,623,627,628,629,833,834,843,844,853,854,1008,1009,1010,1077,1078,1079,1083,1125,1126,1127,1160,1161,1162,1167,1168,1169,1175,1180,1181,1182,1202,1203,1204,1206,1207,1211,1393,1397,1398,1399,1609,1663,1664);

# L           Letter


ok("\x[846D]" ~~ m/^<isL>$/, q{Match <isL> (Letter)} );
ok(!( "\x[846D]" ~~ m/^<!isL>.$/ ), q{Don't match negated <isL> (Letter)} );
ok(!( "\x[846D]" ~~ m/^<-isL>$/ ), q{Don't match inverted <isL> (Letter)} );
ok(!( "\x[9FA6]"  ~~ m/^<isL>$/ ), q{Don't match unrelated <isL> (Letter)} );
ok("\x[9FA6]"  ~~ m/^<!isL>.$/, q{Match unrelated negated <isL> (Letter)} );
ok("\x[9FA6]"  ~~ m/^<-isL>$/, q{Match unrelated inverted <isL> (Letter)} );
ok("\x[9FA6]\x[846D]" ~~ m/<isL>/, q{Match unanchored <isL> (Letter)} );

ok("\x[6DF7]" ~~ m/^<?isLetter>$/, q{Match <?isLetter>} );
ok(!( "\x[6DF7]" ~~ m/^<!isLetter>.$/ ), q{Don't match negated <?isLetter>} );
ok(!( "\x[6DF7]" ~~ m/^<-isLetter>$/ ), q{Don't match inverted <?isLetter>} );
ok(!( "\x[9FA6]"  ~~ m/^<?isLetter>$/ ), q{Don't match unrelated <?isLetter>} );
ok("\x[9FA6]"  ~~ m/^<!isLetter>.$/, q{Match unrelated negated <?isLetter>} );
ok("\x[9FA6]"  ~~ m/^<-isLetter>$/, q{Match unrelated inverted <?isLetter>} );
ok("\x[9FA6]\x[6DF7]" ~~ m/<?isLetter>/, q{Match unanchored <?isLetter>} );

# Lu          UppercaseLetter


ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<?isLu>$/, q{Match <?isLu> (UppercaseLetter)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<!isLu>.$/ ), q{Don't match negated <?isLu> (UppercaseLetter)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-isLu>$/ ), q{Don't match inverted <?isLu> (UppercaseLetter)} );
ok(!( "\x[C767]"  ~~ m/^<?isLu>$/ ), q{Don't match unrelated <?isLu> (UppercaseLetter)} );
ok("\x[C767]"  ~~ m/^<!isLu>.$/, q{Match unrelated negated <?isLu> (UppercaseLetter)} );
ok("\x[C767]"  ~~ m/^<-isLu>$/, q{Match unrelated inverted <?isLu> (UppercaseLetter)} );
ok(!( "\x[C767]" ~~ m/^<?isLu>$/ ), q{Don't match related <?isLu> (UppercaseLetter)} );
ok("\x[C767]" ~~ m/^<!isLu>.$/, q{Match related negated <?isLu> (UppercaseLetter)} );
ok("\x[C767]" ~~ m/^<-isLu>$/, q{Match related inverted <?isLu> (UppercaseLetter)} );
ok("\x[C767]\x[C767]\c[LATIN CAPITAL LETTER A]" ~~ m/<?isLu>/, q{Match unanchored <?isLu> (UppercaseLetter)} );

ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<?isUppercaseLetter>$/, q{Match <?isUppercaseLetter>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<!isUppercaseLetter>.$/ ), q{Don't match negated <?isUppercaseLetter>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-isUppercaseLetter>$/ ), q{Don't match inverted <?isUppercaseLetter>} );
ok(!( "\c[YI SYLLABLE NBA]"  ~~ m/^<?isUppercaseLetter>$/ ), q{Don't match unrelated <?isUppercaseLetter>} );
ok("\c[YI SYLLABLE NBA]"  ~~ m/^<!isUppercaseLetter>.$/, q{Match unrelated negated <?isUppercaseLetter>} );
ok("\c[YI SYLLABLE NBA]"  ~~ m/^<-isUppercaseLetter>$/, q{Match unrelated inverted <?isUppercaseLetter>} );
ok("\c[YI SYLLABLE NBA]\c[LATIN CAPITAL LETTER A]" ~~ m/<?isUppercaseLetter>/, q{Match unanchored <?isUppercaseLetter>} );

# Ll          LowercaseLetter


ok("\c[LATIN SMALL LETTER A]" ~~ m/^<?isLl>$/, q{Match <?isLl> (LowercaseLetter)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<!isLl>.$/ ), q{Don't match negated <?isLl> (LowercaseLetter)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<-isLl>$/ ), q{Don't match inverted <?isLl> (LowercaseLetter)} );
ok(!( "\c[BOPOMOFO FINAL LETTER H]"  ~~ m/^<?isLl>$/ ), q{Don't match unrelated <?isLl> (LowercaseLetter)} );
ok("\c[BOPOMOFO FINAL LETTER H]"  ~~ m/^<!isLl>.$/, q{Match unrelated negated <?isLl> (LowercaseLetter)} );
ok("\c[BOPOMOFO FINAL LETTER H]"  ~~ m/^<-isLl>$/, q{Match unrelated inverted <?isLl> (LowercaseLetter)} );
ok(!( "\c[BOPOMOFO FINAL LETTER H]" ~~ m/^<?isLl>$/ ), q{Don't match related <?isLl> (LowercaseLetter)} );
ok("\c[BOPOMOFO FINAL LETTER H]" ~~ m/^<!isLl>.$/, q{Match related negated <?isLl> (LowercaseLetter)} );
ok("\c[BOPOMOFO FINAL LETTER H]" ~~ m/^<-isLl>$/, q{Match related inverted <?isLl> (LowercaseLetter)} );
ok("\c[BOPOMOFO FINAL LETTER H]\c[BOPOMOFO FINAL LETTER H]\c[LATIN SMALL LETTER A]" ~~ m/<?isLl>/, q{Match unanchored <?isLl> (LowercaseLetter)} );

ok("\c[LATIN SMALL LETTER A]" ~~ m/^<?isLowercaseLetter>$/, q{Match <?isLowercaseLetter>} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<!isLowercaseLetter>.$/ ), q{Don't match negated <?isLowercaseLetter>} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<-isLowercaseLetter>$/ ), q{Don't match inverted <?isLowercaseLetter>} );
ok(!( "\x[86CA]"  ~~ m/^<?isLowercaseLetter>$/ ), q{Don't match unrelated <?isLowercaseLetter>} );
ok("\x[86CA]"  ~~ m/^<!isLowercaseLetter>.$/, q{Match unrelated negated <?isLowercaseLetter>} );
ok("\x[86CA]"  ~~ m/^<-isLowercaseLetter>$/, q{Match unrelated inverted <?isLowercaseLetter>} );
ok(!( "\x[86CA]" ~~ m/^<?isLowercaseLetter>$/ ), q{Don't match related <?isLowercaseLetter>} );
ok("\x[86CA]" ~~ m/^<!isLowercaseLetter>.$/, q{Match related negated <?isLowercaseLetter>} );
ok("\x[86CA]" ~~ m/^<-isLowercaseLetter>$/, q{Match related inverted <?isLowercaseLetter>} );
ok("\x[86CA]\x[86CA]\c[LATIN SMALL LETTER A]" ~~ m/<?isLowercaseLetter>/, q{Match unanchored <?isLowercaseLetter>} );

# Lt          TitlecaseLetter


ok("\c[LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON]" ~~ m/^<?isLt>$/, q{Match <?isLt> (TitlecaseLetter)} );
ok(!( "\c[LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON]" ~~ m/^<!isLt>.$/ ), q{Don't match negated <?isLt> (TitlecaseLetter)} );
ok(!( "\c[LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON]" ~~ m/^<-isLt>$/ ), q{Don't match inverted <?isLt> (TitlecaseLetter)} );
ok(!( "\x[6DC8]"  ~~ m/^<?isLt>$/ ), q{Don't match unrelated <?isLt> (TitlecaseLetter)} );
ok("\x[6DC8]"  ~~ m/^<!isLt>.$/, q{Match unrelated negated <?isLt> (TitlecaseLetter)} );
ok("\x[6DC8]"  ~~ m/^<-isLt>$/, q{Match unrelated inverted <?isLt> (TitlecaseLetter)} );
ok(!( "\x[6DC8]" ~~ m/^<?isLt>$/ ), q{Don't match related <?isLt> (TitlecaseLetter)} );
ok("\x[6DC8]" ~~ m/^<!isLt>.$/, q{Match related negated <?isLt> (TitlecaseLetter)} );
ok("\x[6DC8]" ~~ m/^<-isLt>$/, q{Match related inverted <?isLt> (TitlecaseLetter)} );
ok("\x[6DC8]\x[6DC8]\c[LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON]" ~~ m/<?isLt>/, q{Match unanchored <?isLt> (TitlecaseLetter)} );

ok("\c[GREEK CAPITAL LETTER ALPHA WITH PSILI AND PROSGEGRAMMENI]" ~~ m/^<?isTitlecaseLetter>$/, q{Match <?isTitlecaseLetter>} );
ok(!( "\c[GREEK CAPITAL LETTER ALPHA WITH PSILI AND PROSGEGRAMMENI]" ~~ m/^<!isTitlecaseLetter>.$/ ), q{Don't match negated <?isTitlecaseLetter>} );
ok(!( "\c[GREEK CAPITAL LETTER ALPHA WITH PSILI AND PROSGEGRAMMENI]" ~~ m/^<-isTitlecaseLetter>$/ ), q{Don't match inverted <?isTitlecaseLetter>} );
ok(!( "\x[0C4E]"  ~~ m/^<?isTitlecaseLetter>$/ ), q{Don't match unrelated <?isTitlecaseLetter>} );
ok("\x[0C4E]"  ~~ m/^<!isTitlecaseLetter>.$/, q{Match unrelated negated <?isTitlecaseLetter>} );
ok("\x[0C4E]"  ~~ m/^<-isTitlecaseLetter>$/, q{Match unrelated inverted <?isTitlecaseLetter>} );
ok("\x[0C4E]\c[GREEK CAPITAL LETTER ALPHA WITH PSILI AND PROSGEGRAMMENI]" ~~ m/<?isTitlecaseLetter>/, q{Match unanchored <?isTitlecaseLetter>} );

# Lm          ModifierLetter


ok("\c[IDEOGRAPHIC ITERATION MARK]" ~~ m/^<?isLm>$/, q{Match <?isLm> (ModifierLetter)} );
ok(!( "\c[IDEOGRAPHIC ITERATION MARK]" ~~ m/^<!isLm>.$/ ), q{Don't match negated <?isLm> (ModifierLetter)} );
ok(!( "\c[IDEOGRAPHIC ITERATION MARK]" ~~ m/^<-isLm>$/ ), q{Don't match inverted <?isLm> (ModifierLetter)} );
ok(!( "\x[2B61]"  ~~ m/^<?isLm>$/ ), q{Don't match unrelated <?isLm> (ModifierLetter)} );
ok("\x[2B61]"  ~~ m/^<!isLm>.$/, q{Match unrelated negated <?isLm> (ModifierLetter)} );
ok("\x[2B61]"  ~~ m/^<-isLm>$/, q{Match unrelated inverted <?isLm> (ModifierLetter)} );
ok(!( "\c[IDEOGRAPHIC CLOSING MARK]" ~~ m/^<?isLm>$/ ), q{Don't match related <?isLm> (ModifierLetter)} );
ok("\c[IDEOGRAPHIC CLOSING MARK]" ~~ m/^<!isLm>.$/, q{Match related negated <?isLm> (ModifierLetter)} );
ok("\c[IDEOGRAPHIC CLOSING MARK]" ~~ m/^<-isLm>$/, q{Match related inverted <?isLm> (ModifierLetter)} );
ok("\x[2B61]\c[IDEOGRAPHIC CLOSING MARK]\c[IDEOGRAPHIC ITERATION MARK]" ~~ m/<?isLm>/, q{Match unanchored <?isLm> (ModifierLetter)} );

ok("\c[MODIFIER LETTER SMALL H]" ~~ m/^<?isModifierLetter>$/, q{Match <?isModifierLetter>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<!isModifierLetter>.$/ ), q{Don't match negated <?isModifierLetter>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<-isModifierLetter>$/ ), q{Don't match inverted <?isModifierLetter>} );
ok(!( "\c[YI SYLLABLE HA]"  ~~ m/^<?isModifierLetter>$/ ), q{Don't match unrelated <?isModifierLetter>} );
ok("\c[YI SYLLABLE HA]"  ~~ m/^<!isModifierLetter>.$/, q{Match unrelated negated <?isModifierLetter>} );
ok("\c[YI SYLLABLE HA]"  ~~ m/^<-isModifierLetter>$/, q{Match unrelated inverted <?isModifierLetter>} );
ok("\c[YI SYLLABLE HA]\c[MODIFIER LETTER SMALL H]" ~~ m/<?isModifierLetter>/, q{Match unanchored <?isModifierLetter>} );

# Lo          OtherLetter


ok("\c[LATIN LETTER TWO WITH STROKE]" ~~ m/^<?isLo>$/, q{Match <?isLo> (OtherLetter)} );
ok(!( "\c[LATIN LETTER TWO WITH STROKE]" ~~ m/^<!isLo>.$/ ), q{Don't match negated <?isLo> (OtherLetter)} );
ok(!( "\c[LATIN LETTER TWO WITH STROKE]" ~~ m/^<-isLo>$/ ), q{Don't match inverted <?isLo> (OtherLetter)} );
ok(!( "\c[LATIN SMALL LETTER TURNED DELTA]"  ~~ m/^<?isLo>$/ ), q{Don't match unrelated <?isLo> (OtherLetter)} );
ok("\c[LATIN SMALL LETTER TURNED DELTA]"  ~~ m/^<!isLo>.$/, q{Match unrelated negated <?isLo> (OtherLetter)} );
ok("\c[LATIN SMALL LETTER TURNED DELTA]"  ~~ m/^<-isLo>$/, q{Match unrelated inverted <?isLo> (OtherLetter)} );
ok(!( "\c[LATIN SMALL LETTER TURNED DELTA]" ~~ m/^<?isLo>$/ ), q{Don't match related <?isLo> (OtherLetter)} );
ok("\c[LATIN SMALL LETTER TURNED DELTA]" ~~ m/^<!isLo>.$/, q{Match related negated <?isLo> (OtherLetter)} );
ok("\c[LATIN SMALL LETTER TURNED DELTA]" ~~ m/^<-isLo>$/, q{Match related inverted <?isLo> (OtherLetter)} );
ok("\c[LATIN SMALL LETTER TURNED DELTA]\c[LATIN SMALL LETTER TURNED DELTA]\c[LATIN LETTER TWO WITH STROKE]" ~~ m/<?isLo>/, q{Match unanchored <?isLo> (OtherLetter)} );

ok("\c[ETHIOPIC SYLLABLE GLOTTAL A]" ~~ m/^<?isOtherLetter>$/, q{Match <?isOtherLetter>} );
ok(!( "\c[ETHIOPIC SYLLABLE GLOTTAL A]" ~~ m/^<!isOtherLetter>.$/ ), q{Don't match negated <?isOtherLetter>} );
ok(!( "\c[ETHIOPIC SYLLABLE GLOTTAL A]" ~~ m/^<-isOtherLetter>$/ ), q{Don't match inverted <?isOtherLetter>} );
ok(!( "\x[12AF]"  ~~ m/^<?isOtherLetter>$/ ), q{Don't match unrelated <?isOtherLetter>} );
ok("\x[12AF]"  ~~ m/^<!isOtherLetter>.$/, q{Match unrelated negated <?isOtherLetter>} );
ok("\x[12AF]"  ~~ m/^<-isOtherLetter>$/, q{Match unrelated inverted <?isOtherLetter>} );
ok("\x[12AF]\c[ETHIOPIC SYLLABLE GLOTTAL A]" ~~ m/<?isOtherLetter>/, q{Match unanchored <?isOtherLetter>} );

# Lr             # Alias for "Ll", "Lu", and "Lt".


ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<?isLr>$/, q{Match (Alias for "Ll", "Lu", and "Lt".)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<!isLr>.$/ ), q{Don't match negated (Alias for "Ll", "Lu", and "Lt".)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-isLr>$/ ), q{Don't match inverted (Alias for "Ll", "Lu", and "Lt".)} );
ok(!( "\x[87B5]"  ~~ m/^<?isLr>$/ ), q{Don't match unrelated (Alias for "Ll", "Lu", and "Lt".)} );
ok("\x[87B5]"  ~~ m/^<!isLr>.$/, q{Match unrelated negated (Alias for "Ll", "Lu", and "Lt".)} );
ok("\x[87B5]"  ~~ m/^<-isLr>$/, q{Match unrelated inverted (Alias for "Ll", "Lu", and "Lt".)} );
ok(!( "\x[87B5]" ~~ m/^<?isLr>$/ ), q{Don't match related (Alias for "Ll", "Lu", and "Lt".)} );
ok("\x[87B5]" ~~ m/^<!isLr>.$/, q{Match related negated (Alias for "Ll", "Lu", and "Lt".)} );
ok("\x[87B5]" ~~ m/^<-isLr>$/, q{Match related inverted (Alias for "Ll", "Lu", and "Lt".)} );
ok("\x[87B5]\x[87B5]\c[LATIN CAPITAL LETTER A]" ~~ m/<?isLr>/, q{Match unanchored (Alias for "Ll", "Lu", and "Lt".)} );

# M           Mark


ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<isM>$/, q{Match <isM> (Mark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isM>.$/ ), q{Don't match negated <isM> (Mark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isM>$/ ), q{Don't match inverted <isM> (Mark)} );
ok(!( "\x[D0AA]"  ~~ m/^<isM>$/ ), q{Don't match unrelated <isM> (Mark)} );
ok("\x[D0AA]"  ~~ m/^<!isM>.$/, q{Match unrelated negated <isM> (Mark)} );
ok("\x[D0AA]"  ~~ m/^<-isM>$/, q{Match unrelated inverted <isM> (Mark)} );
ok("\x[D0AA]\c[COMBINING GRAVE ACCENT]" ~~ m/<isM>/, q{Match unanchored <isM> (Mark)} );

ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<?isMark>$/, q{Match <?isMark>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isMark>.$/ ), q{Don't match negated <?isMark>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isMark>$/ ), q{Don't match inverted <?isMark>} );
ok(!( "\x[BE64]"  ~~ m/^<?isMark>$/ ), q{Don't match unrelated <?isMark>} );
ok("\x[BE64]"  ~~ m/^<!isMark>.$/, q{Match unrelated negated <?isMark>} );
ok("\x[BE64]"  ~~ m/^<-isMark>$/, q{Match unrelated inverted <?isMark>} );
ok("\x[BE64]\c[COMBINING GRAVE ACCENT]" ~~ m/<?isMark>/, q{Match unanchored <?isMark>} );

# Mn          NonspacingMark


ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<?isMn>$/, q{Match <?isMn> (NonspacingMark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isMn>.$/ ), q{Don't match negated <?isMn> (NonspacingMark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isMn>$/ ), q{Don't match inverted <?isMn> (NonspacingMark)} );
ok(!( "\x[47A5]"  ~~ m/^<?isMn>$/ ), q{Don't match unrelated <?isMn> (NonspacingMark)} );
ok("\x[47A5]"  ~~ m/^<!isMn>.$/, q{Match unrelated negated <?isMn> (NonspacingMark)} );
ok("\x[47A5]"  ~~ m/^<-isMn>$/, q{Match unrelated inverted <?isMn> (NonspacingMark)} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<?isMn>$/ ), q{Don't match related <?isMn> (NonspacingMark)} );
ok("\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<!isMn>.$/, q{Match related negated <?isMn> (NonspacingMark)} );
ok("\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<-isMn>$/, q{Match related inverted <?isMn> (NonspacingMark)} );
ok("\x[47A5]\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]\c[COMBINING GRAVE ACCENT]" ~~ m/<?isMn>/, q{Match unanchored <?isMn> (NonspacingMark)} );

ok("\c[TAGALOG VOWEL SIGN I]" ~~ m/^<?isNonspacingMark>$/, q{Match <?isNonspacingMark>} );
ok(!( "\c[TAGALOG VOWEL SIGN I]" ~~ m/^<!isNonspacingMark>.$/ ), q{Don't match negated <?isNonspacingMark>} );
ok(!( "\c[TAGALOG VOWEL SIGN I]" ~~ m/^<-isNonspacingMark>$/ ), q{Don't match inverted <?isNonspacingMark>} );
ok(!( "\c[CANADIAN SYLLABICS TYA]"  ~~ m/^<?isNonspacingMark>$/ ), q{Don't match unrelated <?isNonspacingMark>} );
ok("\c[CANADIAN SYLLABICS TYA]"  ~~ m/^<!isNonspacingMark>.$/, q{Match unrelated negated <?isNonspacingMark>} );
ok("\c[CANADIAN SYLLABICS TYA]"  ~~ m/^<-isNonspacingMark>$/, q{Match unrelated inverted <?isNonspacingMark>} );
ok("\c[CANADIAN SYLLABICS TYA]\c[TAGALOG VOWEL SIGN I]" ~~ m/<?isNonspacingMark>/, q{Match unanchored <?isNonspacingMark>} );

# Mc          SpacingMark


ok("\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<?isMc>$/, q{Match <?isMc> (SpacingMark)} );
ok(!( "\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<!isMc>.$/ ), q{Don't match negated <?isMc> (SpacingMark)} );
ok(!( "\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<-isMc>$/ ), q{Don't match inverted <?isMc> (SpacingMark)} );
ok(!( "\x[9981]"  ~~ m/^<?isMc>$/ ), q{Don't match unrelated <?isMc> (SpacingMark)} );
ok("\x[9981]"  ~~ m/^<!isMc>.$/, q{Match unrelated negated <?isMc> (SpacingMark)} );
ok("\x[9981]"  ~~ m/^<-isMc>$/, q{Match unrelated inverted <?isMc> (SpacingMark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<?isMc>$/ ), q{Don't match related <?isMc> (SpacingMark)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isMc>.$/, q{Match related negated <?isMc> (SpacingMark)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isMc>$/, q{Match related inverted <?isMc> (SpacingMark)} );
ok("\x[9981]\c[COMBINING GRAVE ACCENT]\c[DEVANAGARI SIGN VISARGA]" ~~ m/<?isMc>/, q{Match unanchored <?isMc> (SpacingMark)} );

ok("\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<?isSpacingMark>$/, q{Match <?isSpacingMark>} );
ok(!( "\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<!isSpacingMark>.$/ ), q{Don't match negated <?isSpacingMark>} );
ok(!( "\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<-isSpacingMark>$/ ), q{Don't match inverted <?isSpacingMark>} );
ok(!( "\x[35E3]"  ~~ m/^<?isSpacingMark>$/ ), q{Don't match unrelated <?isSpacingMark>} );
ok("\x[35E3]"  ~~ m/^<!isSpacingMark>.$/, q{Match unrelated negated <?isSpacingMark>} );
ok("\x[35E3]"  ~~ m/^<-isSpacingMark>$/, q{Match unrelated inverted <?isSpacingMark>} );
ok("\x[35E3]\c[DEVANAGARI SIGN VISARGA]" ~~ m/<?isSpacingMark>/, q{Match unanchored <?isSpacingMark>} );

# Me          EnclosingMark


ok("\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<?isMe>$/, q{Match <?isMe> (EnclosingMark)} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<!isMe>.$/ ), q{Don't match negated <?isMe> (EnclosingMark)} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<-isMe>$/ ), q{Don't match inverted <?isMe> (EnclosingMark)} );
ok(!( "\x[9400]"  ~~ m/^<?isMe>$/ ), q{Don't match unrelated <?isMe> (EnclosingMark)} );
ok("\x[9400]"  ~~ m/^<!isMe>.$/, q{Match unrelated negated <?isMe> (EnclosingMark)} );
ok("\x[9400]"  ~~ m/^<-isMe>$/, q{Match unrelated inverted <?isMe> (EnclosingMark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<?isMe>$/ ), q{Don't match related <?isMe> (EnclosingMark)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isMe>.$/, q{Match related negated <?isMe> (EnclosingMark)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isMe>$/, q{Match related inverted <?isMe> (EnclosingMark)} );
ok("\x[9400]\c[COMBINING GRAVE ACCENT]\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/<?isMe>/, q{Match unanchored <?isMe> (EnclosingMark)} );

ok("\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<?isEnclosingMark>$/, q{Match <?isEnclosingMark>} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<!isEnclosingMark>.$/ ), q{Don't match negated <?isEnclosingMark>} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<-isEnclosingMark>$/ ), q{Don't match inverted <?isEnclosingMark>} );
ok(!( "\x[7C68]"  ~~ m/^<?isEnclosingMark>$/ ), q{Don't match unrelated <?isEnclosingMark>} );
ok("\x[7C68]"  ~~ m/^<!isEnclosingMark>.$/, q{Match unrelated negated <?isEnclosingMark>} );
ok("\x[7C68]"  ~~ m/^<-isEnclosingMark>$/, q{Match unrelated inverted <?isEnclosingMark>} );
ok("\x[7C68]\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/<?isEnclosingMark>/, q{Match unanchored <?isEnclosingMark>} );

# N           Number


ok("\c[SUPERSCRIPT ZERO]" ~~ m/^<isN>$/, q{Match <isN> (Number)} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<!isN>.$/ ), q{Don't match negated <isN> (Number)} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<-isN>$/ ), q{Don't match inverted <isN> (Number)} );
ok(!( "\c[LATIN LETTER SMALL CAPITAL E]"  ~~ m/^<isN>$/ ), q{Don't match unrelated <isN> (Number)} );
ok("\c[LATIN LETTER SMALL CAPITAL E]"  ~~ m/^<!isN>.$/, q{Match unrelated negated <isN> (Number)} );
ok("\c[LATIN LETTER SMALL CAPITAL E]"  ~~ m/^<-isN>$/, q{Match unrelated inverted <isN> (Number)} );
ok("\c[LATIN LETTER SMALL CAPITAL E]\c[SUPERSCRIPT ZERO]" ~~ m/<isN>/, q{Match unanchored <isN> (Number)} );

ok("\c[DIGIT ZERO]" ~~ m/^<?isNumber>$/, q{Match <?isNumber>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<!isNumber>.$/ ), q{Don't match negated <?isNumber>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-isNumber>$/ ), q{Don't match inverted <?isNumber>} );
ok(!( "\x[A994]"  ~~ m/^<?isNumber>$/ ), q{Don't match unrelated <?isNumber>} );
ok("\x[A994]"  ~~ m/^<!isNumber>.$/, q{Match unrelated negated <?isNumber>} );
ok("\x[A994]"  ~~ m/^<-isNumber>$/, q{Match unrelated inverted <?isNumber>} );
ok("\x[A994]\c[DIGIT ZERO]" ~~ m/<?isNumber>/, q{Match unanchored <?isNumber>} );

# Nd          DecimalNumber


ok("\c[DIGIT ZERO]" ~~ m/^<?isNd>$/, q{Match <?isNd> (DecimalNumber)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<!isNd>.$/ ), q{Don't match negated <?isNd> (DecimalNumber)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-isNd>$/ ), q{Don't match inverted <?isNd> (DecimalNumber)} );
ok(!( "\x[4E2C]"  ~~ m/^<?isNd>$/ ), q{Don't match unrelated <?isNd> (DecimalNumber)} );
ok("\x[4E2C]"  ~~ m/^<!isNd>.$/, q{Match unrelated negated <?isNd> (DecimalNumber)} );
ok("\x[4E2C]"  ~~ m/^<-isNd>$/, q{Match unrelated inverted <?isNd> (DecimalNumber)} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<?isNd>$/ ), q{Don't match related <?isNd> (DecimalNumber)} );
ok("\c[SUPERSCRIPT TWO]" ~~ m/^<!isNd>.$/, q{Match related negated <?isNd> (DecimalNumber)} );
ok("\c[SUPERSCRIPT TWO]" ~~ m/^<-isNd>$/, q{Match related inverted <?isNd> (DecimalNumber)} );
ok("\x[4E2C]\c[SUPERSCRIPT TWO]\c[DIGIT ZERO]" ~~ m/<?isNd>/, q{Match unanchored <?isNd> (DecimalNumber)} );

ok("\c[DIGIT ZERO]" ~~ m/^<?isDecimalNumber>$/, q{Match <?isDecimalNumber>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<!isDecimalNumber>.$/ ), q{Don't match negated <?isDecimalNumber>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-isDecimalNumber>$/ ), q{Don't match inverted <?isDecimalNumber>} );
ok(!( "\x[A652]"  ~~ m/^<?isDecimalNumber>$/ ), q{Don't match unrelated <?isDecimalNumber>} );
ok("\x[A652]"  ~~ m/^<!isDecimalNumber>.$/, q{Match unrelated negated <?isDecimalNumber>} );
ok("\x[A652]"  ~~ m/^<-isDecimalNumber>$/, q{Match unrelated inverted <?isDecimalNumber>} );
ok("\x[A652]\c[DIGIT ZERO]" ~~ m/<?isDecimalNumber>/, q{Match unanchored <?isDecimalNumber>} );

# Nl          LetterNumber


ok("\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<?isNl>$/, q{Match <?isNl> (LetterNumber)} );
ok(!( "\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<!isNl>.$/ ), q{Don't match negated <?isNl> (LetterNumber)} );
ok(!( "\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<-isNl>$/ ), q{Don't match inverted <?isNl> (LetterNumber)} );
ok(!( "\x[6C2F]"  ~~ m/^<?isNl>$/ ), q{Don't match unrelated <?isNl> (LetterNumber)} );
ok("\x[6C2F]"  ~~ m/^<!isNl>.$/, q{Match unrelated negated <?isNl> (LetterNumber)} );
ok("\x[6C2F]"  ~~ m/^<-isNl>$/, q{Match unrelated inverted <?isNl> (LetterNumber)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<?isNl>$/ ), q{Don't match related <?isNl> (LetterNumber)} );
ok("\c[DIGIT ZERO]" ~~ m/^<!isNl>.$/, q{Match related negated <?isNl> (LetterNumber)} );
ok("\c[DIGIT ZERO]" ~~ m/^<-isNl>$/, q{Match related inverted <?isNl> (LetterNumber)} );
ok("\x[6C2F]\c[DIGIT ZERO]\c[RUNIC ARLAUG SYMBOL]" ~~ m/<?isNl>/, q{Match unanchored <?isNl> (LetterNumber)} );

ok("\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<?isLetterNumber>$/, q{Match <?isLetterNumber>} );
ok(!( "\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<!isLetterNumber>.$/ ), q{Don't match negated <?isLetterNumber>} );
ok(!( "\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<-isLetterNumber>$/ ), q{Don't match inverted <?isLetterNumber>} );
ok(!( "\x[80A5]"  ~~ m/^<?isLetterNumber>$/ ), q{Don't match unrelated <?isLetterNumber>} );
ok("\x[80A5]"  ~~ m/^<!isLetterNumber>.$/, q{Match unrelated negated <?isLetterNumber>} );
ok("\x[80A5]"  ~~ m/^<-isLetterNumber>$/, q{Match unrelated inverted <?isLetterNumber>} );
ok(!( "\x[80A5]" ~~ m/^<?isLetterNumber>$/ ), q{Don't match related <?isLetterNumber>} );
ok("\x[80A5]" ~~ m/^<!isLetterNumber>.$/, q{Match related negated <?isLetterNumber>} );
ok("\x[80A5]" ~~ m/^<-isLetterNumber>$/, q{Match related inverted <?isLetterNumber>} );
ok("\x[80A5]\x[80A5]\c[RUNIC ARLAUG SYMBOL]" ~~ m/<?isLetterNumber>/, q{Match unanchored <?isLetterNumber>} );

# No          OtherNumber


ok("\c[SUPERSCRIPT TWO]" ~~ m/^<?isNo>$/, q{Match <?isNo> (OtherNumber)} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<!isNo>.$/ ), q{Don't match negated <?isNo> (OtherNumber)} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<-isNo>$/ ), q{Don't match inverted <?isNo> (OtherNumber)} );
ok(!( "\x[92F3]"  ~~ m/^<?isNo>$/ ), q{Don't match unrelated <?isNo> (OtherNumber)} );
ok("\x[92F3]"  ~~ m/^<!isNo>.$/, q{Match unrelated negated <?isNo> (OtherNumber)} );
ok("\x[92F3]"  ~~ m/^<-isNo>$/, q{Match unrelated inverted <?isNo> (OtherNumber)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<?isNo>$/ ), q{Don't match related <?isNo> (OtherNumber)} );
ok("\c[DIGIT ZERO]" ~~ m/^<!isNo>.$/, q{Match related negated <?isNo> (OtherNumber)} );
ok("\c[DIGIT ZERO]" ~~ m/^<-isNo>$/, q{Match related inverted <?isNo> (OtherNumber)} );
ok("\x[92F3]\c[DIGIT ZERO]\c[SUPERSCRIPT TWO]" ~~ m/<?isNo>/, q{Match unanchored <?isNo> (OtherNumber)} );

ok("\c[SUPERSCRIPT TWO]" ~~ m/^<?isOtherNumber>$/, q{Match <?isOtherNumber>} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<!isOtherNumber>.$/ ), q{Don't match negated <?isOtherNumber>} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<-isOtherNumber>$/ ), q{Don't match inverted <?isOtherNumber>} );
ok(!( "\x[5363]"  ~~ m/^<?isOtherNumber>$/ ), q{Don't match unrelated <?isOtherNumber>} );
ok("\x[5363]"  ~~ m/^<!isOtherNumber>.$/, q{Match unrelated negated <?isOtherNumber>} );
ok("\x[5363]"  ~~ m/^<-isOtherNumber>$/, q{Match unrelated inverted <?isOtherNumber>} );
ok("\x[5363]\c[SUPERSCRIPT TWO]" ~~ m/<?isOtherNumber>/, q{Match unanchored <?isOtherNumber>} );

# P           Punctuation


ok("\c[EXCLAMATION MARK]" ~~ m/^<isP>$/, q{Match <isP> (Punctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<!isP>.$/ ), q{Don't match negated <isP> (Punctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-isP>$/ ), q{Don't match inverted <isP> (Punctuation)} );
ok(!( "\x[A918]"  ~~ m/^<isP>$/ ), q{Don't match unrelated <isP> (Punctuation)} );
ok("\x[A918]"  ~~ m/^<!isP>.$/, q{Match unrelated negated <isP> (Punctuation)} );
ok("\x[A918]"  ~~ m/^<-isP>$/, q{Match unrelated inverted <isP> (Punctuation)} );
ok("\x[A918]\c[EXCLAMATION MARK]" ~~ m/<isP>/, q{Match unanchored <isP> (Punctuation)} );

ok("\c[EXCLAMATION MARK]" ~~ m/^<?isPunctuation>$/, q{Match <?isPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<!isPunctuation>.$/ ), q{Don't match negated <?isPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-isPunctuation>$/ ), q{Don't match inverted <?isPunctuation>} );
ok(!( "\x[CE60]"  ~~ m/^<?isPunctuation>$/ ), q{Don't match unrelated <?isPunctuation>} );
ok("\x[CE60]"  ~~ m/^<!isPunctuation>.$/, q{Match unrelated negated <?isPunctuation>} );
ok("\x[CE60]"  ~~ m/^<-isPunctuation>$/, q{Match unrelated inverted <?isPunctuation>} );
ok("\x[CE60]\c[EXCLAMATION MARK]" ~~ m/<?isPunctuation>/, q{Match unanchored <?isPunctuation>} );

# Pc          ConnectorPunctuation


ok("\c[LOW LINE]" ~~ m/^<?isPc>$/, q{Match <?isPc> (ConnectorPunctuation)} );
ok(!( "\c[LOW LINE]" ~~ m/^<!isPc>.$/ ), q{Don't match negated <?isPc> (ConnectorPunctuation)} );
ok(!( "\c[LOW LINE]" ~~ m/^<-isPc>$/ ), q{Don't match inverted <?isPc> (ConnectorPunctuation)} );
ok(!( "\x[5F19]"  ~~ m/^<?isPc>$/ ), q{Don't match unrelated <?isPc> (ConnectorPunctuation)} );
ok("\x[5F19]"  ~~ m/^<!isPc>.$/, q{Match unrelated negated <?isPc> (ConnectorPunctuation)} );
ok("\x[5F19]"  ~~ m/^<-isPc>$/, q{Match unrelated inverted <?isPc> (ConnectorPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<?isPc>$/ ), q{Don't match related <?isPc> (ConnectorPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<!isPc>.$/, q{Match related negated <?isPc> (ConnectorPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-isPc>$/, q{Match related inverted <?isPc> (ConnectorPunctuation)} );
ok("\x[5F19]\c[EXCLAMATION MARK]\c[LOW LINE]" ~~ m/<?isPc>/, q{Match unanchored <?isPc> (ConnectorPunctuation)} );

ok("\c[LOW LINE]" ~~ m/^<?isConnectorPunctuation>$/, q{Match <?isConnectorPunctuation>} );
ok(!( "\c[LOW LINE]" ~~ m/^<!isConnectorPunctuation>.$/ ), q{Don't match negated <?isConnectorPunctuation>} );
ok(!( "\c[LOW LINE]" ~~ m/^<-isConnectorPunctuation>$/ ), q{Don't match inverted <?isConnectorPunctuation>} );
ok(!( "\c[YI SYLLABLE MGOX]"  ~~ m/^<?isConnectorPunctuation>$/ ), q{Don't match unrelated <?isConnectorPunctuation>} );
ok("\c[YI SYLLABLE MGOX]"  ~~ m/^<!isConnectorPunctuation>.$/, q{Match unrelated negated <?isConnectorPunctuation>} );
ok("\c[YI SYLLABLE MGOX]"  ~~ m/^<-isConnectorPunctuation>$/, q{Match unrelated inverted <?isConnectorPunctuation>} );
ok("\c[YI SYLLABLE MGOX]\c[LOW LINE]" ~~ m/<?isConnectorPunctuation>/, q{Match unanchored <?isConnectorPunctuation>} );

# Pd          DashPunctuation


ok("\c[HYPHEN-MINUS]" ~~ m/^<?isPd>$/, q{Match <?isPd> (DashPunctuation)} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<!isPd>.$/ ), q{Don't match negated <?isPd> (DashPunctuation)} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<-isPd>$/ ), q{Don't match inverted <?isPd> (DashPunctuation)} );
ok(!( "\x[49A1]"  ~~ m/^<?isPd>$/ ), q{Don't match unrelated <?isPd> (DashPunctuation)} );
ok("\x[49A1]"  ~~ m/^<!isPd>.$/, q{Match unrelated negated <?isPd> (DashPunctuation)} );
ok("\x[49A1]"  ~~ m/^<-isPd>$/, q{Match unrelated inverted <?isPd> (DashPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<?isPd>$/ ), q{Don't match related <?isPd> (DashPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<!isPd>.$/, q{Match related negated <?isPd> (DashPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-isPd>$/, q{Match related inverted <?isPd> (DashPunctuation)} );
ok("\x[49A1]\c[EXCLAMATION MARK]\c[HYPHEN-MINUS]" ~~ m/<?isPd>/, q{Match unanchored <?isPd> (DashPunctuation)} );

ok("\c[HYPHEN-MINUS]" ~~ m/^<?isDashPunctuation>$/, q{Match <?isDashPunctuation>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<!isDashPunctuation>.$/ ), q{Don't match negated <?isDashPunctuation>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<-isDashPunctuation>$/ ), q{Don't match inverted <?isDashPunctuation>} );
ok(!( "\x[3C6E]"  ~~ m/^<?isDashPunctuation>$/ ), q{Don't match unrelated <?isDashPunctuation>} );
ok("\x[3C6E]"  ~~ m/^<!isDashPunctuation>.$/, q{Match unrelated negated <?isDashPunctuation>} );
ok("\x[3C6E]"  ~~ m/^<-isDashPunctuation>$/, q{Match unrelated inverted <?isDashPunctuation>} );
ok("\x[3C6E]\c[HYPHEN-MINUS]" ~~ m/<?isDashPunctuation>/, q{Match unanchored <?isDashPunctuation>} );

# Ps          OpenPunctuation


ok("\c[LEFT PARENTHESIS]" ~~ m/^<?isPs>$/, q{Match <?isPs> (OpenPunctuation)} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<!isPs>.$/ ), q{Don't match negated <?isPs> (OpenPunctuation)} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<-isPs>$/ ), q{Don't match inverted <?isPs> (OpenPunctuation)} );
ok(!( "\x[C8A5]"  ~~ m/^<?isPs>$/ ), q{Don't match unrelated <?isPs> (OpenPunctuation)} );
ok("\x[C8A5]"  ~~ m/^<!isPs>.$/, q{Match unrelated negated <?isPs> (OpenPunctuation)} );
ok("\x[C8A5]"  ~~ m/^<-isPs>$/, q{Match unrelated inverted <?isPs> (OpenPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<?isPs>$/ ), q{Don't match related <?isPs> (OpenPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<!isPs>.$/, q{Match related negated <?isPs> (OpenPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-isPs>$/, q{Match related inverted <?isPs> (OpenPunctuation)} );
ok("\x[C8A5]\c[EXCLAMATION MARK]\c[LEFT PARENTHESIS]" ~~ m/<?isPs>/, q{Match unanchored <?isPs> (OpenPunctuation)} );

ok("\c[LEFT PARENTHESIS]" ~~ m/^<?isOpenPunctuation>$/, q{Match <?isOpenPunctuation>} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<!isOpenPunctuation>.$/ ), q{Don't match negated <?isOpenPunctuation>} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<-isOpenPunctuation>$/ ), q{Don't match inverted <?isOpenPunctuation>} );
ok(!( "\x[84B8]"  ~~ m/^<?isOpenPunctuation>$/ ), q{Don't match unrelated <?isOpenPunctuation>} );
ok("\x[84B8]"  ~~ m/^<!isOpenPunctuation>.$/, q{Match unrelated negated <?isOpenPunctuation>} );
ok("\x[84B8]"  ~~ m/^<-isOpenPunctuation>$/, q{Match unrelated inverted <?isOpenPunctuation>} );
ok("\x[84B8]\c[LEFT PARENTHESIS]" ~~ m/<?isOpenPunctuation>/, q{Match unanchored <?isOpenPunctuation>} );

# Pe          ClosePunctuation


ok("\c[RIGHT PARENTHESIS]" ~~ m/^<?isPe>$/, q{Match <?isPe> (ClosePunctuation)} );
ok(!( "\c[RIGHT PARENTHESIS]" ~~ m/^<!isPe>.$/ ), q{Don't match negated <?isPe> (ClosePunctuation)} );
ok(!( "\c[RIGHT PARENTHESIS]" ~~ m/^<-isPe>$/ ), q{Don't match inverted <?isPe> (ClosePunctuation)} );
ok(!( "\x[BB92]"  ~~ m/^<?isPe>$/ ), q{Don't match unrelated <?isPe> (ClosePunctuation)} );
ok("\x[BB92]"  ~~ m/^<!isPe>.$/, q{Match unrelated negated <?isPe> (ClosePunctuation)} );
ok("\x[BB92]"  ~~ m/^<-isPe>$/, q{Match unrelated inverted <?isPe> (ClosePunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<?isPe>$/ ), q{Don't match related <?isPe> (ClosePunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<!isPe>.$/, q{Match related negated <?isPe> (ClosePunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-isPe>$/, q{Match related inverted <?isPe> (ClosePunctuation)} );
ok("\x[BB92]\c[EXCLAMATION MARK]\c[RIGHT PARENTHESIS]" ~~ m/<?isPe>/, q{Match unanchored <?isPe> (ClosePunctuation)} );

ok("\c[RIGHT PARENTHESIS]" ~~ m/^<?isClosePunctuation>$/, q{Match <?isClosePunctuation>} );
ok(!( "\c[RIGHT PARENTHESIS]" ~~ m/^<!isClosePunctuation>.$/ ), q{Don't match negated <?isClosePunctuation>} );
ok(!( "\c[RIGHT PARENTHESIS]" ~~ m/^<-isClosePunctuation>$/ ), q{Don't match inverted <?isClosePunctuation>} );
ok(!( "\x[D55D]"  ~~ m/^<?isClosePunctuation>$/ ), q{Don't match unrelated <?isClosePunctuation>} );
ok("\x[D55D]"  ~~ m/^<!isClosePunctuation>.$/, q{Match unrelated negated <?isClosePunctuation>} );
ok("\x[D55D]"  ~~ m/^<-isClosePunctuation>$/, q{Match unrelated inverted <?isClosePunctuation>} );
ok("\x[D55D]\c[RIGHT PARENTHESIS]" ~~ m/<?isClosePunctuation>/, q{Match unanchored <?isClosePunctuation>} );

# Pi          InitialPunctuation


ok("\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<?isPi>$/, q{Match <?isPi> (InitialPunctuation)} );
ok(!( "\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<!isPi>.$/ ), q{Don't match negated <?isPi> (InitialPunctuation)} );
ok(!( "\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<-isPi>$/ ), q{Don't match inverted <?isPi> (InitialPunctuation)} );
ok(!( "\x[3A35]"  ~~ m/^<?isPi>$/ ), q{Don't match unrelated <?isPi> (InitialPunctuation)} );
ok("\x[3A35]"  ~~ m/^<!isPi>.$/, q{Match unrelated negated <?isPi> (InitialPunctuation)} );
ok("\x[3A35]"  ~~ m/^<-isPi>$/, q{Match unrelated inverted <?isPi> (InitialPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<?isPi>$/ ), q{Don't match related <?isPi> (InitialPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<!isPi>.$/, q{Match related negated <?isPi> (InitialPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-isPi>$/, q{Match related inverted <?isPi> (InitialPunctuation)} );
ok("\x[3A35]\c[EXCLAMATION MARK]\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/<?isPi>/, q{Match unanchored <?isPi> (InitialPunctuation)} );

ok("\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<?isInitialPunctuation>$/, q{Match <?isInitialPunctuation>} );
ok(!( "\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<!isInitialPunctuation>.$/ ), q{Don't match negated <?isInitialPunctuation>} );
ok(!( "\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<-isInitialPunctuation>$/ ), q{Don't match inverted <?isInitialPunctuation>} );
ok(!( "\x[B84F]"  ~~ m/^<?isInitialPunctuation>$/ ), q{Don't match unrelated <?isInitialPunctuation>} );
ok("\x[B84F]"  ~~ m/^<!isInitialPunctuation>.$/, q{Match unrelated negated <?isInitialPunctuation>} );
ok("\x[B84F]"  ~~ m/^<-isInitialPunctuation>$/, q{Match unrelated inverted <?isInitialPunctuation>} );
ok("\x[B84F]\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/<?isInitialPunctuation>/, q{Match unanchored <?isInitialPunctuation>} );

# Pf          FinalPunctuation


ok("\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<?isPf>$/, q{Match <?isPf> (FinalPunctuation)} );
ok(!( "\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<!isPf>.$/ ), q{Don't match negated <?isPf> (FinalPunctuation)} );
ok(!( "\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<-isPf>$/ ), q{Don't match inverted <?isPf> (FinalPunctuation)} );
ok(!( "\x[27CF]"  ~~ m/^<?isPf>$/ ), q{Don't match unrelated <?isPf> (FinalPunctuation)} );
ok("\x[27CF]"  ~~ m/^<!isPf>.$/, q{Match unrelated negated <?isPf> (FinalPunctuation)} );
ok("\x[27CF]"  ~~ m/^<-isPf>$/, q{Match unrelated inverted <?isPf> (FinalPunctuation)} );
ok(!( "\c[MATHEMATICAL LEFT WHITE SQUARE BRACKET]" ~~ m/^<?isPf>$/ ), q{Don't match related <?isPf> (FinalPunctuation)} );
ok("\c[MATHEMATICAL LEFT WHITE SQUARE BRACKET]" ~~ m/^<!isPf>.$/, q{Match related negated <?isPf> (FinalPunctuation)} );
ok("\c[MATHEMATICAL LEFT WHITE SQUARE BRACKET]" ~~ m/^<-isPf>$/, q{Match related inverted <?isPf> (FinalPunctuation)} );
ok("\x[27CF]\c[MATHEMATICAL LEFT WHITE SQUARE BRACKET]\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/<?isPf>/, q{Match unanchored <?isPf> (FinalPunctuation)} );

ok("\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<?isFinalPunctuation>$/, q{Match <?isFinalPunctuation>} );
ok(!( "\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<!isFinalPunctuation>.$/ ), q{Don't match negated <?isFinalPunctuation>} );
ok(!( "\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<-isFinalPunctuation>$/ ), q{Don't match inverted <?isFinalPunctuation>} );
ok(!( "\x[4F65]"  ~~ m/^<?isFinalPunctuation>$/ ), q{Don't match unrelated <?isFinalPunctuation>} );
ok("\x[4F65]"  ~~ m/^<!isFinalPunctuation>.$/, q{Match unrelated negated <?isFinalPunctuation>} );
ok("\x[4F65]"  ~~ m/^<-isFinalPunctuation>$/, q{Match unrelated inverted <?isFinalPunctuation>} );
ok("\x[4F65]\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/<?isFinalPunctuation>/, q{Match unanchored <?isFinalPunctuation>} );

# Po          OtherPunctuation


ok("\c[EXCLAMATION MARK]" ~~ m/^<?isPo>$/, q{Match <?isPo> (OtherPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<!isPo>.$/ ), q{Don't match negated <?isPo> (OtherPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-isPo>$/ ), q{Don't match inverted <?isPo> (OtherPunctuation)} );
ok(!( "\x[AA74]"  ~~ m/^<?isPo>$/ ), q{Don't match unrelated <?isPo> (OtherPunctuation)} );
ok("\x[AA74]"  ~~ m/^<!isPo>.$/, q{Match unrelated negated <?isPo> (OtherPunctuation)} );
ok("\x[AA74]"  ~~ m/^<-isPo>$/, q{Match unrelated inverted <?isPo> (OtherPunctuation)} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<?isPo>$/ ), q{Don't match related <?isPo> (OtherPunctuation)} );
ok("\c[LEFT PARENTHESIS]" ~~ m/^<!isPo>.$/, q{Match related negated <?isPo> (OtherPunctuation)} );
ok("\c[LEFT PARENTHESIS]" ~~ m/^<-isPo>$/, q{Match related inverted <?isPo> (OtherPunctuation)} );
ok("\x[AA74]\c[LEFT PARENTHESIS]\c[EXCLAMATION MARK]" ~~ m/<?isPo>/, q{Match unanchored <?isPo> (OtherPunctuation)} );

ok("\c[EXCLAMATION MARK]" ~~ m/^<?isOtherPunctuation>$/, q{Match <?isOtherPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<!isOtherPunctuation>.$/ ), q{Don't match negated <?isOtherPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-isOtherPunctuation>$/ ), q{Don't match inverted <?isOtherPunctuation>} );
ok(!( "\x[7DD2]"  ~~ m/^<?isOtherPunctuation>$/ ), q{Don't match unrelated <?isOtherPunctuation>} );
ok("\x[7DD2]"  ~~ m/^<!isOtherPunctuation>.$/, q{Match unrelated negated <?isOtherPunctuation>} );
ok("\x[7DD2]"  ~~ m/^<-isOtherPunctuation>$/, q{Match unrelated inverted <?isOtherPunctuation>} );
ok("\x[7DD2]\c[EXCLAMATION MARK]" ~~ m/<?isOtherPunctuation>/, q{Match unanchored <?isOtherPunctuation>} );

# S           Symbol


ok("\c[YI RADICAL QOT]" ~~ m/^<isS>$/, q{Match <isS> (Symbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<!isS>.$/ ), q{Don't match negated <isS> (Symbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-isS>$/ ), q{Don't match inverted <isS> (Symbol)} );
ok(!( "\x[8839]"  ~~ m/^<isS>$/ ), q{Don't match unrelated <isS> (Symbol)} );
ok("\x[8839]"  ~~ m/^<!isS>.$/, q{Match unrelated negated <isS> (Symbol)} );
ok("\x[8839]"  ~~ m/^<-isS>$/, q{Match unrelated inverted <isS> (Symbol)} );
ok("\x[8839]\c[YI RADICAL QOT]" ~~ m/<isS>/, q{Match unanchored <isS> (Symbol)} );

ok("\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<?isSymbol>$/, q{Match <?isSymbol>} );
ok(!( "\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<!isSymbol>.$/ ), q{Don't match negated <?isSymbol>} );
ok(!( "\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<-isSymbol>$/ ), q{Don't match inverted <?isSymbol>} );
ok(!( "\x[4A1C]"  ~~ m/^<?isSymbol>$/ ), q{Don't match unrelated <?isSymbol>} );
ok("\x[4A1C]"  ~~ m/^<!isSymbol>.$/, q{Match unrelated negated <?isSymbol>} );
ok("\x[4A1C]"  ~~ m/^<-isSymbol>$/, q{Match unrelated inverted <?isSymbol>} );
ok("\x[4A1C]\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/<?isSymbol>/, q{Match unanchored <?isSymbol>} );

# Sm          MathSymbol


ok("\c[PLUS SIGN]" ~~ m/^<?isSm>$/, q{Match <?isSm> (MathSymbol)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<!isSm>.$/ ), q{Don't match negated <?isSm> (MathSymbol)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<-isSm>$/ ), q{Don't match inverted <?isSm> (MathSymbol)} );
ok(!( "\x[B258]"  ~~ m/^<?isSm>$/ ), q{Don't match unrelated <?isSm> (MathSymbol)} );
ok("\x[B258]"  ~~ m/^<!isSm>.$/, q{Match unrelated negated <?isSm> (MathSymbol)} );
ok("\x[B258]"  ~~ m/^<-isSm>$/, q{Match unrelated inverted <?isSm> (MathSymbol)} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<?isSm>$/ ), q{Don't match related <?isSm> (MathSymbol)} );
ok("\c[DOLLAR SIGN]" ~~ m/^<!isSm>.$/, q{Match related negated <?isSm> (MathSymbol)} );
ok("\c[DOLLAR SIGN]" ~~ m/^<-isSm>$/, q{Match related inverted <?isSm> (MathSymbol)} );
ok("\x[B258]\c[DOLLAR SIGN]\c[PLUS SIGN]" ~~ m/<?isSm>/, q{Match unanchored <?isSm> (MathSymbol)} );

ok("\c[PLUS SIGN]" ~~ m/^<?isMathSymbol>$/, q{Match <?isMathSymbol>} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<!isMathSymbol>.$/ ), q{Don't match negated <?isMathSymbol>} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<-isMathSymbol>$/ ), q{Don't match inverted <?isMathSymbol>} );
ok(!( "\x[98FF]"  ~~ m/^<?isMathSymbol>$/ ), q{Don't match unrelated <?isMathSymbol>} );
ok("\x[98FF]"  ~~ m/^<!isMathSymbol>.$/, q{Match unrelated negated <?isMathSymbol>} );
ok("\x[98FF]"  ~~ m/^<-isMathSymbol>$/, q{Match unrelated inverted <?isMathSymbol>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<?isMathSymbol>$/ ), q{Don't match related <?isMathSymbol>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isMathSymbol>.$/, q{Match related negated <?isMathSymbol>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isMathSymbol>$/, q{Match related inverted <?isMathSymbol>} );
ok("\x[98FF]\c[COMBINING GRAVE ACCENT]\c[PLUS SIGN]" ~~ m/<?isMathSymbol>/, q{Match unanchored <?isMathSymbol>} );

# Sc          CurrencySymbol


ok("\c[DOLLAR SIGN]" ~~ m/^<?isSc>$/, q{Match <?isSc> (CurrencySymbol)} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<!isSc>.$/ ), q{Don't match negated <?isSc> (CurrencySymbol)} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<-isSc>$/ ), q{Don't match inverted <?isSc> (CurrencySymbol)} );
ok(!( "\x[994C]"  ~~ m/^<?isSc>$/ ), q{Don't match unrelated <?isSc> (CurrencySymbol)} );
ok("\x[994C]"  ~~ m/^<!isSc>.$/, q{Match unrelated negated <?isSc> (CurrencySymbol)} );
ok("\x[994C]"  ~~ m/^<-isSc>$/, q{Match unrelated inverted <?isSc> (CurrencySymbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<?isSc>$/ ), q{Don't match related <?isSc> (CurrencySymbol)} );
ok("\c[YI RADICAL QOT]" ~~ m/^<!isSc>.$/, q{Match related negated <?isSc> (CurrencySymbol)} );
ok("\c[YI RADICAL QOT]" ~~ m/^<-isSc>$/, q{Match related inverted <?isSc> (CurrencySymbol)} );
ok("\x[994C]\c[YI RADICAL QOT]\c[DOLLAR SIGN]" ~~ m/<?isSc>/, q{Match unanchored <?isSc> (CurrencySymbol)} );

ok("\c[DOLLAR SIGN]" ~~ m/^<?isCurrencySymbol>$/, q{Match <?isCurrencySymbol>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<!isCurrencySymbol>.$/ ), q{Don't match negated <?isCurrencySymbol>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<-isCurrencySymbol>$/ ), q{Don't match inverted <?isCurrencySymbol>} );
ok(!( "\x[37C0]"  ~~ m/^<?isCurrencySymbol>$/ ), q{Don't match unrelated <?isCurrencySymbol>} );
ok("\x[37C0]"  ~~ m/^<!isCurrencySymbol>.$/, q{Match unrelated negated <?isCurrencySymbol>} );
ok("\x[37C0]"  ~~ m/^<-isCurrencySymbol>$/, q{Match unrelated inverted <?isCurrencySymbol>} );
ok("\x[37C0]\c[DOLLAR SIGN]" ~~ m/<?isCurrencySymbol>/, q{Match unanchored <?isCurrencySymbol>} );

# Sk          ModifierSymbol


ok("\c[CIRCUMFLEX ACCENT]" ~~ m/^<?isSk>$/, q{Match <?isSk> (ModifierSymbol)} );
ok(!( "\c[CIRCUMFLEX ACCENT]" ~~ m/^<!isSk>.$/ ), q{Don't match negated <?isSk> (ModifierSymbol)} );
ok(!( "\c[CIRCUMFLEX ACCENT]" ~~ m/^<-isSk>$/ ), q{Don't match inverted <?isSk> (ModifierSymbol)} );
ok(!( "\x[4578]"  ~~ m/^<?isSk>$/ ), q{Don't match unrelated <?isSk> (ModifierSymbol)} );
ok("\x[4578]"  ~~ m/^<!isSk>.$/, q{Match unrelated negated <?isSk> (ModifierSymbol)} );
ok("\x[4578]"  ~~ m/^<-isSk>$/, q{Match unrelated inverted <?isSk> (ModifierSymbol)} );
ok(!( "\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<?isSk>$/ ), q{Don't match related <?isSk> (ModifierSymbol)} );
ok("\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<!isSk>.$/, q{Match related negated <?isSk> (ModifierSymbol)} );
ok("\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<-isSk>$/, q{Match related inverted <?isSk> (ModifierSymbol)} );
ok("\x[4578]\c[HEXAGRAM FOR THE CREATIVE HEAVEN]\c[CIRCUMFLEX ACCENT]" ~~ m/<?isSk>/, q{Match unanchored <?isSk> (ModifierSymbol)} );

ok("\c[CIRCUMFLEX ACCENT]" ~~ m/^<?isModifierSymbol>$/, q{Match <?isModifierSymbol>} );
ok(!( "\c[CIRCUMFLEX ACCENT]" ~~ m/^<!isModifierSymbol>.$/ ), q{Don't match negated <?isModifierSymbol>} );
ok(!( "\c[CIRCUMFLEX ACCENT]" ~~ m/^<-isModifierSymbol>$/ ), q{Don't match inverted <?isModifierSymbol>} );
ok(!( "\x[42F1]"  ~~ m/^<?isModifierSymbol>$/ ), q{Don't match unrelated <?isModifierSymbol>} );
ok("\x[42F1]"  ~~ m/^<!isModifierSymbol>.$/, q{Match unrelated negated <?isModifierSymbol>} );
ok("\x[42F1]"  ~~ m/^<-isModifierSymbol>$/, q{Match unrelated inverted <?isModifierSymbol>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<?isModifierSymbol>$/ ), q{Don't match related <?isModifierSymbol>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isModifierSymbol>.$/, q{Match related negated <?isModifierSymbol>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isModifierSymbol>$/, q{Match related inverted <?isModifierSymbol>} );
ok("\x[42F1]\c[COMBINING GRAVE ACCENT]\c[CIRCUMFLEX ACCENT]" ~~ m/<?isModifierSymbol>/, q{Match unanchored <?isModifierSymbol>} );

# So          OtherSymbol


ok("\c[YI RADICAL QOT]" ~~ m/^<?isSo>$/, q{Match <?isSo> (OtherSymbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<!isSo>.$/ ), q{Don't match negated <?isSo> (OtherSymbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-isSo>$/ ), q{Don't match inverted <?isSo> (OtherSymbol)} );
ok(!( "\x[83DE]"  ~~ m/^<?isSo>$/ ), q{Don't match unrelated <?isSo> (OtherSymbol)} );
ok("\x[83DE]"  ~~ m/^<!isSo>.$/, q{Match unrelated negated <?isSo> (OtherSymbol)} );
ok("\x[83DE]"  ~~ m/^<-isSo>$/, q{Match unrelated inverted <?isSo> (OtherSymbol)} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<?isSo>$/ ), q{Don't match related <?isSo> (OtherSymbol)} );
ok("\c[DOLLAR SIGN]" ~~ m/^<!isSo>.$/, q{Match related negated <?isSo> (OtherSymbol)} );
ok("\c[DOLLAR SIGN]" ~~ m/^<-isSo>$/, q{Match related inverted <?isSo> (OtherSymbol)} );
ok("\x[83DE]\c[DOLLAR SIGN]\c[YI RADICAL QOT]" ~~ m/<?isSo>/, q{Match unanchored <?isSo> (OtherSymbol)} );

ok("\c[YI RADICAL QOT]" ~~ m/^<?isOtherSymbol>$/, q{Match <?isOtherSymbol>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<!isOtherSymbol>.$/ ), q{Don't match negated <?isOtherSymbol>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-isOtherSymbol>$/ ), q{Don't match inverted <?isOtherSymbol>} );
ok(!( "\x[9B2C]"  ~~ m/^<?isOtherSymbol>$/ ), q{Don't match unrelated <?isOtherSymbol>} );
ok("\x[9B2C]"  ~~ m/^<!isOtherSymbol>.$/, q{Match unrelated negated <?isOtherSymbol>} );
ok("\x[9B2C]"  ~~ m/^<-isOtherSymbol>$/, q{Match unrelated inverted <?isOtherSymbol>} );
ok("\x[9B2C]\c[YI RADICAL QOT]" ~~ m/<?isOtherSymbol>/, q{Match unanchored <?isOtherSymbol>} );

# Z           Separator


ok("\c[IDEOGRAPHIC SPACE]" ~~ m/^<isZ>$/, q{Match <isZ> (Separator)} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<!isZ>.$/ ), q{Don't match negated <isZ> (Separator)} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<-isZ>$/ ), q{Don't match inverted <isZ> (Separator)} );
ok(!( "\x[2C08]"  ~~ m/^<isZ>$/ ), q{Don't match unrelated <isZ> (Separator)} );
ok("\x[2C08]"  ~~ m/^<!isZ>.$/, q{Match unrelated negated <isZ> (Separator)} );
ok("\x[2C08]"  ~~ m/^<-isZ>$/, q{Match unrelated inverted <isZ> (Separator)} );
ok("\x[2C08]\c[IDEOGRAPHIC SPACE]" ~~ m/<isZ>/, q{Match unanchored <isZ> (Separator)} );

ok("\c[SPACE]" ~~ m/^<?isSeparator>$/, q{Match <?isSeparator>} );
ok(!( "\c[SPACE]" ~~ m/^<!isSeparator>.$/ ), q{Don't match negated <?isSeparator>} );
ok(!( "\c[SPACE]" ~~ m/^<-isSeparator>$/ ), q{Don't match inverted <?isSeparator>} );
ok(!( "\c[YI SYLLABLE SOX]"  ~~ m/^<?isSeparator>$/ ), q{Don't match unrelated <?isSeparator>} );
ok("\c[YI SYLLABLE SOX]"  ~~ m/^<!isSeparator>.$/, q{Match unrelated negated <?isSeparator>} );
ok("\c[YI SYLLABLE SOX]"  ~~ m/^<-isSeparator>$/, q{Match unrelated inverted <?isSeparator>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<?isSeparator>$/ ), q{Don't match related <?isSeparator>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<!isSeparator>.$/, q{Match related negated <?isSeparator>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<-isSeparator>$/, q{Match related inverted <?isSeparator>} );
ok("\c[YI SYLLABLE SOX]\c[YI RADICAL QOT]\c[SPACE]" ~~ m/<?isSeparator>/, q{Match unanchored <?isSeparator>} );

# Zs          SpaceSeparator


ok("\c[SPACE]" ~~ m/^<?isZs>$/, q{Match <?isZs> (SpaceSeparator)} );
ok(!( "\c[SPACE]" ~~ m/^<!isZs>.$/ ), q{Don't match negated <?isZs> (SpaceSeparator)} );
ok(!( "\c[SPACE]" ~~ m/^<-isZs>$/ ), q{Don't match inverted <?isZs> (SpaceSeparator)} );
ok(!( "\x[88DD]"  ~~ m/^<?isZs>$/ ), q{Don't match unrelated <?isZs> (SpaceSeparator)} );
ok("\x[88DD]"  ~~ m/^<!isZs>.$/, q{Match unrelated negated <?isZs> (SpaceSeparator)} );
ok("\x[88DD]"  ~~ m/^<-isZs>$/, q{Match unrelated inverted <?isZs> (SpaceSeparator)} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<?isZs>$/ ), q{Don't match related <?isZs> (SpaceSeparator)} );
ok("\c[LINE SEPARATOR]" ~~ m/^<!isZs>.$/, q{Match related negated <?isZs> (SpaceSeparator)} );
ok("\c[LINE SEPARATOR]" ~~ m/^<-isZs>$/, q{Match related inverted <?isZs> (SpaceSeparator)} );
ok("\x[88DD]\c[LINE SEPARATOR]\c[SPACE]" ~~ m/<?isZs>/, q{Match unanchored <?isZs> (SpaceSeparator)} );

ok("\c[SPACE]" ~~ m/^<?isSpaceSeparator>$/, q{Match <?isSpaceSeparator>} );
ok(!( "\c[SPACE]" ~~ m/^<!isSpaceSeparator>.$/ ), q{Don't match negated <?isSpaceSeparator>} );
ok(!( "\c[SPACE]" ~~ m/^<-isSpaceSeparator>$/ ), q{Don't match inverted <?isSpaceSeparator>} );
ok(!( "\x[C808]"  ~~ m/^<?isSpaceSeparator>$/ ), q{Don't match unrelated <?isSpaceSeparator>} );
ok("\x[C808]"  ~~ m/^<!isSpaceSeparator>.$/, q{Match unrelated negated <?isSpaceSeparator>} );
ok("\x[C808]"  ~~ m/^<-isSpaceSeparator>$/, q{Match unrelated inverted <?isSpaceSeparator>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<?isSpaceSeparator>$/ ), q{Don't match related <?isSpaceSeparator>} );
ok("\c[DOLLAR SIGN]" ~~ m/^<!isSpaceSeparator>.$/, q{Match related negated <?isSpaceSeparator>} );
ok("\c[DOLLAR SIGN]" ~~ m/^<-isSpaceSeparator>$/, q{Match related inverted <?isSpaceSeparator>} );
ok("\x[C808]\c[DOLLAR SIGN]\c[SPACE]" ~~ m/<?isSpaceSeparator>/, q{Match unanchored <?isSpaceSeparator>} );

# Zl          LineSeparator


ok("\c[LINE SEPARATOR]" ~~ m/^<?isZl>$/, q{Match <?isZl> (LineSeparator)} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<!isZl>.$/ ), q{Don't match negated <?isZl> (LineSeparator)} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<-isZl>$/ ), q{Don't match inverted <?isZl> (LineSeparator)} );
ok(!( "\x[B822]"  ~~ m/^<?isZl>$/ ), q{Don't match unrelated <?isZl> (LineSeparator)} );
ok("\x[B822]"  ~~ m/^<!isZl>.$/, q{Match unrelated negated <?isZl> (LineSeparator)} );
ok("\x[B822]"  ~~ m/^<-isZl>$/, q{Match unrelated inverted <?isZl> (LineSeparator)} );
ok(!( "\c[SPACE]" ~~ m/^<?isZl>$/ ), q{Don't match related <?isZl> (LineSeparator)} );
ok("\c[SPACE]" ~~ m/^<!isZl>.$/, q{Match related negated <?isZl> (LineSeparator)} );
ok("\c[SPACE]" ~~ m/^<-isZl>$/, q{Match related inverted <?isZl> (LineSeparator)} );
ok("\x[B822]\c[SPACE]\c[LINE SEPARATOR]" ~~ m/<?isZl>/, q{Match unanchored <?isZl> (LineSeparator)} );

ok("\c[LINE SEPARATOR]" ~~ m/^<?isLineSeparator>$/, q{Match <?isLineSeparator>} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<!isLineSeparator>.$/ ), q{Don't match negated <?isLineSeparator>} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<-isLineSeparator>$/ ), q{Don't match inverted <?isLineSeparator>} );
ok(!( "\x[1390]"  ~~ m/^<?isLineSeparator>$/ ), q{Don't match unrelated <?isLineSeparator>} );
ok("\x[1390]"  ~~ m/^<!isLineSeparator>.$/, q{Match unrelated negated <?isLineSeparator>} );
ok("\x[1390]"  ~~ m/^<-isLineSeparator>$/, q{Match unrelated inverted <?isLineSeparator>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<?isLineSeparator>$/ ), q{Don't match related <?isLineSeparator>} );
ok("\c[CHEROKEE LETTER A]" ~~ m/^<!isLineSeparator>.$/, q{Match related negated <?isLineSeparator>} );
ok("\c[CHEROKEE LETTER A]" ~~ m/^<-isLineSeparator>$/, q{Match related inverted <?isLineSeparator>} );
ok("\x[1390]\c[CHEROKEE LETTER A]\c[LINE SEPARATOR]" ~~ m/<?isLineSeparator>/, q{Match unanchored <?isLineSeparator>} );

# Zp          ParagraphSeparator


ok("\c[PARAGRAPH SEPARATOR]" ~~ m/^<?isZp>$/, q{Match <?isZp> (ParagraphSeparator)} );
ok(!( "\c[PARAGRAPH SEPARATOR]" ~~ m/^<!isZp>.$/ ), q{Don't match negated <?isZp> (ParagraphSeparator)} );
ok(!( "\c[PARAGRAPH SEPARATOR]" ~~ m/^<-isZp>$/ ), q{Don't match inverted <?isZp> (ParagraphSeparator)} );
ok(!( "\x[5FDE]"  ~~ m/^<?isZp>$/ ), q{Don't match unrelated <?isZp> (ParagraphSeparator)} );
ok("\x[5FDE]"  ~~ m/^<!isZp>.$/, q{Match unrelated negated <?isZp> (ParagraphSeparator)} );
ok("\x[5FDE]"  ~~ m/^<-isZp>$/, q{Match unrelated inverted <?isZp> (ParagraphSeparator)} );
ok(!( "\c[SPACE]" ~~ m/^<?isZp>$/ ), q{Don't match related <?isZp> (ParagraphSeparator)} );
ok("\c[SPACE]" ~~ m/^<!isZp>.$/, q{Match related negated <?isZp> (ParagraphSeparator)} );
ok("\c[SPACE]" ~~ m/^<-isZp>$/, q{Match related inverted <?isZp> (ParagraphSeparator)} );
ok("\x[5FDE]\c[SPACE]\c[PARAGRAPH SEPARATOR]" ~~ m/<?isZp>/, q{Match unanchored <?isZp> (ParagraphSeparator)} );

ok("\c[PARAGRAPH SEPARATOR]" ~~ m/^<?isParagraphSeparator>$/, q{Match <?isParagraphSeparator>} );
ok(!( "\c[PARAGRAPH SEPARATOR]" ~~ m/^<!isParagraphSeparator>.$/ ), q{Don't match negated <?isParagraphSeparator>} );
ok(!( "\c[PARAGRAPH SEPARATOR]" ~~ m/^<-isParagraphSeparator>$/ ), q{Don't match inverted <?isParagraphSeparator>} );
ok(!( "\x[345B]"  ~~ m/^<?isParagraphSeparator>$/ ), q{Don't match unrelated <?isParagraphSeparator>} );
ok("\x[345B]"  ~~ m/^<!isParagraphSeparator>.$/, q{Match unrelated negated <?isParagraphSeparator>} );
ok("\x[345B]"  ~~ m/^<-isParagraphSeparator>$/, q{Match unrelated inverted <?isParagraphSeparator>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<?isParagraphSeparator>$/ ), q{Don't match related <?isParagraphSeparator>} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<!isParagraphSeparator>.$/, q{Match related negated <?isParagraphSeparator>} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-isParagraphSeparator>$/, q{Match related inverted <?isParagraphSeparator>} );
ok("\x[345B]\c[EXCLAMATION MARK]\c[PARAGRAPH SEPARATOR]" ~~ m/<?isParagraphSeparator>/, q{Match unanchored <?isParagraphSeparator>} );

# C           Other


ok("\x[9FA6]" ~~ m/^<isC>$/, q{Match <isC> (Other)} );
ok(!( "\x[9FA6]" ~~ m/^<!isC>.$/ ), q{Don't match negated <isC> (Other)} );
ok(!( "\x[9FA6]" ~~ m/^<-isC>$/ ), q{Don't match inverted <isC> (Other)} );
ok(!( "\x[6A3F]"  ~~ m/^<isC>$/ ), q{Don't match unrelated <isC> (Other)} );
ok("\x[6A3F]"  ~~ m/^<!isC>.$/, q{Match unrelated negated <isC> (Other)} );
ok("\x[6A3F]"  ~~ m/^<-isC>$/, q{Match unrelated inverted <isC> (Other)} );
ok("\x[6A3F]\x[9FA6]" ~~ m/<isC>/, q{Match unanchored <isC> (Other)} );

ok("\x[A679]" ~~ m/^<?isOther>$/, q{Match <?isOther>} );
ok(!( "\x[A679]" ~~ m/^<!isOther>.$/ ), q{Don't match negated <?isOther>} );
ok(!( "\x[A679]" ~~ m/^<-isOther>$/ ), q{Don't match inverted <?isOther>} );
ok(!( "\x[AC00]"  ~~ m/^<?isOther>$/ ), q{Don't match unrelated <?isOther>} );
ok("\x[AC00]"  ~~ m/^<!isOther>.$/, q{Match unrelated negated <?isOther>} );
ok("\x[AC00]"  ~~ m/^<-isOther>$/, q{Match unrelated inverted <?isOther>} );
ok("\x[AC00]\x[A679]" ~~ m/<?isOther>/, q{Match unanchored <?isOther>} );

# Cc          Control


ok("\c[NULL]" ~~ m/^<?isCc>$/, q{Match <?isCc> (Control)} );
ok(!( "\c[NULL]" ~~ m/^<!isCc>.$/ ), q{Don't match negated <?isCc> (Control)} );
ok(!( "\c[NULL]" ~~ m/^<-isCc>$/ ), q{Don't match inverted <?isCc> (Control)} );
ok(!( "\x[0A7A]"  ~~ m/^<?isCc>$/ ), q{Don't match unrelated <?isCc> (Control)} );
ok("\x[0A7A]"  ~~ m/^<!isCc>.$/, q{Match unrelated negated <?isCc> (Control)} );
ok("\x[0A7A]"  ~~ m/^<-isCc>$/, q{Match unrelated inverted <?isCc> (Control)} );
ok(!( "\x[0A7A]" ~~ m/^<?isCc>$/ ), q{Don't match related <?isCc> (Control)} );
ok("\x[0A7A]" ~~ m/^<!isCc>.$/, q{Match related negated <?isCc> (Control)} );
ok("\x[0A7A]" ~~ m/^<-isCc>$/, q{Match related inverted <?isCc> (Control)} );
ok("\x[0A7A]\x[0A7A]\c[NULL]" ~~ m/<?isCc>/, q{Match unanchored <?isCc> (Control)} );

ok("\c[NULL]" ~~ m/^<?isControl>$/, q{Match <?isControl>} );
ok(!( "\c[NULL]" ~~ m/^<!isControl>.$/ ), q{Don't match negated <?isControl>} );
ok(!( "\c[NULL]" ~~ m/^<-isControl>$/ ), q{Don't match inverted <?isControl>} );
ok(!( "\x[4886]"  ~~ m/^<?isControl>$/ ), q{Don't match unrelated <?isControl>} );
ok("\x[4886]"  ~~ m/^<!isControl>.$/, q{Match unrelated negated <?isControl>} );
ok("\x[4886]"  ~~ m/^<-isControl>$/, q{Match unrelated inverted <?isControl>} );
ok(!( "\x[4DB6]" ~~ m/^<?isControl>$/ ), q{Don't match related <?isControl>} );
ok("\x[4DB6]" ~~ m/^<!isControl>.$/, q{Match related negated <?isControl>} );
ok("\x[4DB6]" ~~ m/^<-isControl>$/, q{Match related inverted <?isControl>} );
ok("\x[4886]\x[4DB6]\c[NULL]" ~~ m/<?isControl>/, q{Match unanchored <?isControl>} );

# Cf          Format


ok("\c[SOFT HYPHEN]" ~~ m/^<?isCf>$/, q{Match <?isCf> (Format)} );
ok(!( "\c[SOFT HYPHEN]" ~~ m/^<!isCf>.$/ ), q{Don't match negated <?isCf> (Format)} );
ok(!( "\c[SOFT HYPHEN]" ~~ m/^<-isCf>$/ ), q{Don't match inverted <?isCf> (Format)} );
ok(!( "\x[77B8]"  ~~ m/^<?isCf>$/ ), q{Don't match unrelated <?isCf> (Format)} );
ok("\x[77B8]"  ~~ m/^<!isCf>.$/, q{Match unrelated negated <?isCf> (Format)} );
ok("\x[77B8]"  ~~ m/^<-isCf>$/, q{Match unrelated inverted <?isCf> (Format)} );
ok(!( "\x[9FA6]" ~~ m/^<?isCf>$/ ), q{Don't match related <?isCf> (Format)} );
ok("\x[9FA6]" ~~ m/^<!isCf>.$/, q{Match related negated <?isCf> (Format)} );
ok("\x[9FA6]" ~~ m/^<-isCf>$/, q{Match related inverted <?isCf> (Format)} );
ok("\x[77B8]\x[9FA6]\c[SOFT HYPHEN]" ~~ m/<?isCf>/, q{Match unanchored <?isCf> (Format)} );

ok("\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<?isFormat>$/, q{Match <?isFormat>} );
ok(!( "\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<!isFormat>.$/ ), q{Don't match negated <?isFormat>} );
ok(!( "\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<-isFormat>$/ ), q{Don't match inverted <?isFormat>} );
ok(!( "\c[DEVANAGARI VOWEL SIGN AU]"  ~~ m/^<?isFormat>$/ ), q{Don't match unrelated <?isFormat>} );
ok("\c[DEVANAGARI VOWEL SIGN AU]"  ~~ m/^<!isFormat>.$/, q{Match unrelated negated <?isFormat>} );
ok("\c[DEVANAGARI VOWEL SIGN AU]"  ~~ m/^<-isFormat>$/, q{Match unrelated inverted <?isFormat>} );
ok("\c[DEVANAGARI VOWEL SIGN AU]\c[KHMER VOWEL INHERENT AQ]" ~~ m/<?isFormat>/, q{Match unanchored <?isFormat>} );

# BidiL       # Left-to-Right


ok("\c[YI SYLLABLE IT]" ~~ m/^<?isBidiL>$/, q{Match (Left-to-Right)} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<!isBidiL>.$/ ), q{Don't match negated (Left-to-Right)} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<-isBidiL>$/ ), q{Don't match inverted (Left-to-Right)} );
ok(!( "\x[5A87]"  ~~ m/^<?isBidiL>$/ ), q{Don't match unrelated (Left-to-Right)} );
ok("\x[5A87]"  ~~ m/^<!isBidiL>.$/, q{Match unrelated negated (Left-to-Right)} );
ok("\x[5A87]"  ~~ m/^<-isBidiL>$/, q{Match unrelated inverted (Left-to-Right)} );
ok("\x[5A87]\c[YI SYLLABLE IT]" ~~ m/<?isBidiL>/, q{Match unanchored (Left-to-Right)} );

# BidiEN      # European Number


ok("\c[DIGIT ZERO]" ~~ m/^<?isBidiEN>$/, q{Match (European Number)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<!isBidiEN>.$/ ), q{Don't match negated (European Number)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-isBidiEN>$/ ), q{Don't match inverted (European Number)} );
ok(!( "\x[AFFB]"  ~~ m/^<?isBidiEN>$/ ), q{Don't match unrelated (European Number)} );
ok("\x[AFFB]"  ~~ m/^<!isBidiEN>.$/, q{Match unrelated negated (European Number)} );
ok("\x[AFFB]"  ~~ m/^<-isBidiEN>$/, q{Match unrelated inverted (European Number)} );
ok("\x[AFFB]\c[DIGIT ZERO]" ~~ m/<?isBidiEN>/, q{Match unanchored (European Number)} );

# BidiES      # European Number Separator


ok("\c[SOLIDUS]" ~~ m/^<?isBidiES>$/, q{Match (European Number Separator)} );
ok(!( "\c[SOLIDUS]" ~~ m/^<!isBidiES>.$/ ), q{Don't match negated (European Number Separator)} );
ok(!( "\c[SOLIDUS]" ~~ m/^<-isBidiES>$/ ), q{Don't match inverted (European Number Separator)} );
ok(!( "\x[7B89]"  ~~ m/^<?isBidiES>$/ ), q{Don't match unrelated (European Number Separator)} );
ok("\x[7B89]"  ~~ m/^<!isBidiES>.$/, q{Match unrelated negated (European Number Separator)} );
ok("\x[7B89]"  ~~ m/^<-isBidiES>$/, q{Match unrelated inverted (European Number Separator)} );
ok("\x[7B89]\c[SOLIDUS]" ~~ m/<?isBidiES>/, q{Match unanchored (European Number Separator)} );

# BidiET      # European Number Terminator


ok("\c[NUMBER SIGN]" ~~ m/^<?isBidiET>$/, q{Match (European Number Terminator)} );
ok(!( "\c[NUMBER SIGN]" ~~ m/^<!isBidiET>.$/ ), q{Don't match negated (European Number Terminator)} );
ok(!( "\c[NUMBER SIGN]" ~~ m/^<-isBidiET>$/ ), q{Don't match inverted (European Number Terminator)} );
ok(!( "\x[6780]"  ~~ m/^<?isBidiET>$/ ), q{Don't match unrelated (European Number Terminator)} );
ok("\x[6780]"  ~~ m/^<!isBidiET>.$/, q{Match unrelated negated (European Number Terminator)} );
ok("\x[6780]"  ~~ m/^<-isBidiET>$/, q{Match unrelated inverted (European Number Terminator)} );
ok("\x[6780]\c[NUMBER SIGN]" ~~ m/<?isBidiET>/, q{Match unanchored (European Number Terminator)} );

# BidiWS      # Whitespace


ok("\c[FORM FEED (FF)]" ~~ m/^<?isBidiWS>$/, q{Match (Whitespace)} );
ok(!( "\c[FORM FEED (FF)]" ~~ m/^<!isBidiWS>.$/ ), q{Don't match negated (Whitespace)} );
ok(!( "\c[FORM FEED (FF)]" ~~ m/^<-isBidiWS>$/ ), q{Don't match inverted (Whitespace)} );
ok(!( "\x[6CF9]"  ~~ m/^<?isBidiWS>$/ ), q{Don't match unrelated (Whitespace)} );
ok("\x[6CF9]"  ~~ m/^<!isBidiWS>.$/, q{Match unrelated negated (Whitespace)} );
ok("\x[6CF9]"  ~~ m/^<-isBidiWS>$/, q{Match unrelated inverted (Whitespace)} );
ok("\x[6CF9]\c[FORM FEED (FF)]" ~~ m/<?isBidiWS>/, q{Match unanchored (Whitespace)} );

# Arabic


ok("\c[ARABIC LETTER HAMZA]" ~~ m/^<?isArabic>$/, q{Match <?isArabic>} );
ok(!( "\c[ARABIC LETTER HAMZA]" ~~ m/^<!isArabic>.$/ ), q{Don't match negated <?isArabic>} );
ok(!( "\c[ARABIC LETTER HAMZA]" ~~ m/^<-isArabic>$/ ), q{Don't match inverted <?isArabic>} );
ok(!( "\x[A649]"  ~~ m/^<?isArabic>$/ ), q{Don't match unrelated <?isArabic>} );
ok("\x[A649]"  ~~ m/^<!isArabic>.$/, q{Match unrelated negated <?isArabic>} );
ok("\x[A649]"  ~~ m/^<-isArabic>$/, q{Match unrelated inverted <?isArabic>} );
ok("\x[A649]\c[ARABIC LETTER HAMZA]" ~~ m/<?isArabic>/, q{Match unanchored <?isArabic>} );

# Armenian


ok("\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/^<?isArmenian>$/, q{Match <?isArmenian>} );
ok(!( "\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/^<!isArmenian>.$/ ), q{Don't match negated <?isArmenian>} );
ok(!( "\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/^<-isArmenian>$/ ), q{Don't match inverted <?isArmenian>} );
ok(!( "\x[CBFF]"  ~~ m/^<?isArmenian>$/ ), q{Don't match unrelated <?isArmenian>} );
ok("\x[CBFF]"  ~~ m/^<!isArmenian>.$/, q{Match unrelated negated <?isArmenian>} );
ok("\x[CBFF]"  ~~ m/^<-isArmenian>$/, q{Match unrelated inverted <?isArmenian>} );
ok("\x[CBFF]\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/<?isArmenian>/, q{Match unanchored <?isArmenian>} );

# Bengali


ok("\c[BENGALI SIGN CANDRABINDU]" ~~ m/^<?isBengali>$/, q{Match <?isBengali>} );
ok(!( "\c[BENGALI SIGN CANDRABINDU]" ~~ m/^<!isBengali>.$/ ), q{Don't match negated <?isBengali>} );
ok(!( "\c[BENGALI SIGN CANDRABINDU]" ~~ m/^<-isBengali>$/ ), q{Don't match inverted <?isBengali>} );
ok(!( "\x[D1E8]"  ~~ m/^<?isBengali>$/ ), q{Don't match unrelated <?isBengali>} );
ok("\x[D1E8]"  ~~ m/^<!isBengali>.$/, q{Match unrelated negated <?isBengali>} );
ok("\x[D1E8]"  ~~ m/^<-isBengali>$/, q{Match unrelated inverted <?isBengali>} );
ok("\x[D1E8]\c[BENGALI SIGN CANDRABINDU]" ~~ m/<?isBengali>/, q{Match unanchored <?isBengali>} );

# Bopomofo


ok("\c[BOPOMOFO LETTER B]" ~~ m/^<?isBopomofo>$/, q{Match <?isBopomofo>} );
ok(!( "\c[BOPOMOFO LETTER B]" ~~ m/^<!isBopomofo>.$/ ), q{Don't match negated <?isBopomofo>} );
ok(!( "\c[BOPOMOFO LETTER B]" ~~ m/^<-isBopomofo>$/ ), q{Don't match inverted <?isBopomofo>} );
ok(!( "\x[B093]"  ~~ m/^<?isBopomofo>$/ ), q{Don't match unrelated <?isBopomofo>} );
ok("\x[B093]"  ~~ m/^<!isBopomofo>.$/, q{Match unrelated negated <?isBopomofo>} );
ok("\x[B093]"  ~~ m/^<-isBopomofo>$/, q{Match unrelated inverted <?isBopomofo>} );
ok("\x[B093]\c[BOPOMOFO LETTER B]" ~~ m/<?isBopomofo>/, q{Match unanchored <?isBopomofo>} );

# Buhid


ok("\c[BUHID LETTER A]" ~~ m/^<?isBuhid>$/, q{Match <?isBuhid>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<!isBuhid>.$/ ), q{Don't match negated <?isBuhid>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<-isBuhid>$/ ), q{Don't match inverted <?isBuhid>} );
ok(!( "\x[C682]"  ~~ m/^<?isBuhid>$/ ), q{Don't match unrelated <?isBuhid>} );
ok("\x[C682]"  ~~ m/^<!isBuhid>.$/, q{Match unrelated negated <?isBuhid>} );
ok("\x[C682]"  ~~ m/^<-isBuhid>$/, q{Match unrelated inverted <?isBuhid>} );
ok("\x[C682]\c[BUHID LETTER A]" ~~ m/<?isBuhid>/, q{Match unanchored <?isBuhid>} );

# CanadianAboriginal


ok("\c[CANADIAN SYLLABICS E]" ~~ m/^<?isCanadianAboriginal>$/, q{Match <?isCanadianAboriginal>} );
ok(!( "\c[CANADIAN SYLLABICS E]" ~~ m/^<!isCanadianAboriginal>.$/ ), q{Don't match negated <?isCanadianAboriginal>} );
ok(!( "\c[CANADIAN SYLLABICS E]" ~~ m/^<-isCanadianAboriginal>$/ ), q{Don't match inverted <?isCanadianAboriginal>} );
ok(!( "\x[888B]"  ~~ m/^<?isCanadianAboriginal>$/ ), q{Don't match unrelated <?isCanadianAboriginal>} );
ok("\x[888B]"  ~~ m/^<!isCanadianAboriginal>.$/, q{Match unrelated negated <?isCanadianAboriginal>} );
ok("\x[888B]"  ~~ m/^<-isCanadianAboriginal>$/, q{Match unrelated inverted <?isCanadianAboriginal>} );
ok(!( "\x[9FA6]" ~~ m/^<?isCanadianAboriginal>$/ ), q{Don't match related <?isCanadianAboriginal>} );
ok("\x[9FA6]" ~~ m/^<!isCanadianAboriginal>.$/, q{Match related negated <?isCanadianAboriginal>} );
ok("\x[9FA6]" ~~ m/^<-isCanadianAboriginal>$/, q{Match related inverted <?isCanadianAboriginal>} );
ok("\x[888B]\x[9FA6]\c[CANADIAN SYLLABICS E]" ~~ m/<?isCanadianAboriginal>/, q{Match unanchored <?isCanadianAboriginal>} );

# Cherokee


ok("\c[CHEROKEE LETTER A]" ~~ m/^<?isCherokee>$/, q{Match <?isCherokee>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<!isCherokee>.$/ ), q{Don't match negated <?isCherokee>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<-isCherokee>$/ ), q{Don't match inverted <?isCherokee>} );
ok(!( "\x[8260]"  ~~ m/^<?isCherokee>$/ ), q{Don't match unrelated <?isCherokee>} );
ok("\x[8260]"  ~~ m/^<!isCherokee>.$/, q{Match unrelated negated <?isCherokee>} );
ok("\x[8260]"  ~~ m/^<-isCherokee>$/, q{Match unrelated inverted <?isCherokee>} );
ok(!( "\x[9FA6]" ~~ m/^<?isCherokee>$/ ), q{Don't match related <?isCherokee>} );
ok("\x[9FA6]" ~~ m/^<!isCherokee>.$/, q{Match related negated <?isCherokee>} );
ok("\x[9FA6]" ~~ m/^<-isCherokee>$/, q{Match related inverted <?isCherokee>} );
ok("\x[8260]\x[9FA6]\c[CHEROKEE LETTER A]" ~~ m/<?isCherokee>/, q{Match unanchored <?isCherokee>} );

# Cyrillic


ok("\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<?isCyrillic>$/, q{Match <?isCyrillic>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<!isCyrillic>.$/ ), q{Don't match negated <?isCyrillic>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<-isCyrillic>$/ ), q{Don't match inverted <?isCyrillic>} );
ok(!( "\x[B7DF]"  ~~ m/^<?isCyrillic>$/ ), q{Don't match unrelated <?isCyrillic>} );
ok("\x[B7DF]"  ~~ m/^<!isCyrillic>.$/, q{Match unrelated negated <?isCyrillic>} );
ok("\x[B7DF]"  ~~ m/^<-isCyrillic>$/, q{Match unrelated inverted <?isCyrillic>} );
ok(!( "\x[D7A4]" ~~ m/^<?isCyrillic>$/ ), q{Don't match related <?isCyrillic>} );
ok("\x[D7A4]" ~~ m/^<!isCyrillic>.$/, q{Match related negated <?isCyrillic>} );
ok("\x[D7A4]" ~~ m/^<-isCyrillic>$/, q{Match related inverted <?isCyrillic>} );
ok("\x[B7DF]\x[D7A4]\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/<?isCyrillic>/, q{Match unanchored <?isCyrillic>} );

# Deseret


ok(!( "\x[A8A0]"  ~~ m/^<?isDeseret>$/ ), q{Don't match unrelated <?isDeseret>} );
ok("\x[A8A0]"  ~~ m/^<!isDeseret>.$/, q{Match unrelated negated <?isDeseret>} );
ok("\x[A8A0]"  ~~ m/^<-isDeseret>$/, q{Match unrelated inverted <?isDeseret>} );

# Devanagari


ok("\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<?isDevanagari>$/, q{Match <?isDevanagari>} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<!isDevanagari>.$/ ), q{Don't match negated <?isDevanagari>} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<-isDevanagari>$/ ), q{Don't match inverted <?isDevanagari>} );
ok(!( "\x[D291]"  ~~ m/^<?isDevanagari>$/ ), q{Don't match unrelated <?isDevanagari>} );
ok("\x[D291]"  ~~ m/^<!isDevanagari>.$/, q{Match unrelated negated <?isDevanagari>} );
ok("\x[D291]"  ~~ m/^<-isDevanagari>$/, q{Match unrelated inverted <?isDevanagari>} );
ok("\x[D291]\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/<?isDevanagari>/, q{Match unanchored <?isDevanagari>} );

# Ethiopic


ok("\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<?isEthiopic>$/, q{Match <?isEthiopic>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<!isEthiopic>.$/ ), q{Don't match negated <?isEthiopic>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<-isEthiopic>$/ ), q{Don't match inverted <?isEthiopic>} );
ok(!( "\x[A9FA]"  ~~ m/^<?isEthiopic>$/ ), q{Don't match unrelated <?isEthiopic>} );
ok("\x[A9FA]"  ~~ m/^<!isEthiopic>.$/, q{Match unrelated negated <?isEthiopic>} );
ok("\x[A9FA]"  ~~ m/^<-isEthiopic>$/, q{Match unrelated inverted <?isEthiopic>} );
ok("\x[A9FA]\c[ETHIOPIC SYLLABLE HA]" ~~ m/<?isEthiopic>/, q{Match unanchored <?isEthiopic>} );

# Georgian


ok("\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<?isGeorgian>$/, q{Match <?isGeorgian>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<!isGeorgian>.$/ ), q{Don't match negated <?isGeorgian>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<-isGeorgian>$/ ), q{Don't match inverted <?isGeorgian>} );
ok(!( "\x[BBC9]"  ~~ m/^<?isGeorgian>$/ ), q{Don't match unrelated <?isGeorgian>} );
ok("\x[BBC9]"  ~~ m/^<!isGeorgian>.$/, q{Match unrelated negated <?isGeorgian>} );
ok("\x[BBC9]"  ~~ m/^<-isGeorgian>$/, q{Match unrelated inverted <?isGeorgian>} );
ok("\x[BBC9]\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/<?isGeorgian>/, q{Match unanchored <?isGeorgian>} );

# Gothic


ok(!( "\x[5888]"  ~~ m/^<?isGothic>$/ ), q{Don't match unrelated <?isGothic>} );
ok("\x[5888]"  ~~ m/^<!isGothic>.$/, q{Match unrelated negated <?isGothic>} );
ok("\x[5888]"  ~~ m/^<-isGothic>$/, q{Match unrelated inverted <?isGothic>} );

# Greek


ok("\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/^<?isGreek>$/, q{Match <?isGreek>} );
ok(!( "\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/^<!isGreek>.$/ ), q{Don't match negated <?isGreek>} );
ok(!( "\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/^<-isGreek>$/ ), q{Don't match inverted <?isGreek>} );
ok(!( "\c[ETHIOPIC SYLLABLE KEE]"  ~~ m/^<?isGreek>$/ ), q{Don't match unrelated <?isGreek>} );
ok("\c[ETHIOPIC SYLLABLE KEE]"  ~~ m/^<!isGreek>.$/, q{Match unrelated negated <?isGreek>} );
ok("\c[ETHIOPIC SYLLABLE KEE]"  ~~ m/^<-isGreek>$/, q{Match unrelated inverted <?isGreek>} );
ok("\c[ETHIOPIC SYLLABLE KEE]\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/<?isGreek>/, q{Match unanchored <?isGreek>} );

# Gujarati


ok("\c[GUJARATI SIGN CANDRABINDU]" ~~ m/^<?isGujarati>$/, q{Match <?isGujarati>} );
ok(!( "\c[GUJARATI SIGN CANDRABINDU]" ~~ m/^<!isGujarati>.$/ ), q{Don't match negated <?isGujarati>} );
ok(!( "\c[GUJARATI SIGN CANDRABINDU]" ~~ m/^<-isGujarati>$/ ), q{Don't match inverted <?isGujarati>} );
ok(!( "\x[D108]"  ~~ m/^<?isGujarati>$/ ), q{Don't match unrelated <?isGujarati>} );
ok("\x[D108]"  ~~ m/^<!isGujarati>.$/, q{Match unrelated negated <?isGujarati>} );
ok("\x[D108]"  ~~ m/^<-isGujarati>$/, q{Match unrelated inverted <?isGujarati>} );
ok("\x[D108]\c[GUJARATI SIGN CANDRABINDU]" ~~ m/<?isGujarati>/, q{Match unanchored <?isGujarati>} );

# Gurmukhi


ok("\c[GURMUKHI SIGN BINDI]" ~~ m/^<?isGurmukhi>$/, q{Match <?isGurmukhi>} );
ok(!( "\c[GURMUKHI SIGN BINDI]" ~~ m/^<!isGurmukhi>.$/ ), q{Don't match negated <?isGurmukhi>} );
ok(!( "\c[GURMUKHI SIGN BINDI]" ~~ m/^<-isGurmukhi>$/ ), q{Don't match inverted <?isGurmukhi>} );
ok(!( "\x[5E05]"  ~~ m/^<?isGurmukhi>$/ ), q{Don't match unrelated <?isGurmukhi>} );
ok("\x[5E05]"  ~~ m/^<!isGurmukhi>.$/, q{Match unrelated negated <?isGurmukhi>} );
ok("\x[5E05]"  ~~ m/^<-isGurmukhi>$/, q{Match unrelated inverted <?isGurmukhi>} );
ok("\x[5E05]\c[GURMUKHI SIGN BINDI]" ~~ m/<?isGurmukhi>/, q{Match unanchored <?isGurmukhi>} );

# Han


ok("\c[CJK RADICAL REPEAT]" ~~ m/^<?isHan>$/, q{Match <?isHan>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<!isHan>.$/ ), q{Don't match negated <?isHan>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<-isHan>$/ ), q{Don't match inverted <?isHan>} );
ok(!( "\c[CANADIAN SYLLABICS KAA]"  ~~ m/^<?isHan>$/ ), q{Don't match unrelated <?isHan>} );
ok("\c[CANADIAN SYLLABICS KAA]"  ~~ m/^<!isHan>.$/, q{Match unrelated negated <?isHan>} );
ok("\c[CANADIAN SYLLABICS KAA]"  ~~ m/^<-isHan>$/, q{Match unrelated inverted <?isHan>} );
ok("\c[CANADIAN SYLLABICS KAA]\c[CJK RADICAL REPEAT]" ~~ m/<?isHan>/, q{Match unanchored <?isHan>} );

# Hangul


ok("\x[AC00]" ~~ m/^<?isHangul>$/, q{Match <?isHangul>} );
ok(!( "\x[AC00]" ~~ m/^<!isHangul>.$/ ), q{Don't match negated <?isHangul>} );
ok(!( "\x[AC00]" ~~ m/^<-isHangul>$/ ), q{Don't match inverted <?isHangul>} );
ok(!( "\x[9583]"  ~~ m/^<?isHangul>$/ ), q{Don't match unrelated <?isHangul>} );
ok("\x[9583]"  ~~ m/^<!isHangul>.$/, q{Match unrelated negated <?isHangul>} );
ok("\x[9583]"  ~~ m/^<-isHangul>$/, q{Match unrelated inverted <?isHangul>} );
ok("\x[9583]\x[AC00]" ~~ m/<?isHangul>/, q{Match unanchored <?isHangul>} );

# Hanunoo


ok("\c[HANUNOO LETTER A]" ~~ m/^<?isHanunoo>$/, q{Match <?isHanunoo>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<!isHanunoo>.$/ ), q{Don't match negated <?isHanunoo>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<-isHanunoo>$/ ), q{Don't match inverted <?isHanunoo>} );
ok(!( "\x[7625]"  ~~ m/^<?isHanunoo>$/ ), q{Don't match unrelated <?isHanunoo>} );
ok("\x[7625]"  ~~ m/^<!isHanunoo>.$/, q{Match unrelated negated <?isHanunoo>} );
ok("\x[7625]"  ~~ m/^<-isHanunoo>$/, q{Match unrelated inverted <?isHanunoo>} );
ok("\x[7625]\c[HANUNOO LETTER A]" ~~ m/<?isHanunoo>/, q{Match unanchored <?isHanunoo>} );

# Hebrew


ok("\c[HEBREW LETTER ALEF]" ~~ m/^<?isHebrew>$/, q{Match <?isHebrew>} );
ok(!( "\c[HEBREW LETTER ALEF]" ~~ m/^<!isHebrew>.$/ ), q{Don't match negated <?isHebrew>} );
ok(!( "\c[HEBREW LETTER ALEF]" ~~ m/^<-isHebrew>$/ ), q{Don't match inverted <?isHebrew>} );
ok(!( "\c[YI SYLLABLE SSIT]"  ~~ m/^<?isHebrew>$/ ), q{Don't match unrelated <?isHebrew>} );
ok("\c[YI SYLLABLE SSIT]"  ~~ m/^<!isHebrew>.$/, q{Match unrelated negated <?isHebrew>} );
ok("\c[YI SYLLABLE SSIT]"  ~~ m/^<-isHebrew>$/, q{Match unrelated inverted <?isHebrew>} );
ok("\c[YI SYLLABLE SSIT]\c[HEBREW LETTER ALEF]" ~~ m/<?isHebrew>/, q{Match unanchored <?isHebrew>} );

# Hiragana


ok("\c[HIRAGANA LETTER SMALL A]" ~~ m/^<?isHiragana>$/, q{Match <?isHiragana>} );
ok(!( "\c[HIRAGANA LETTER SMALL A]" ~~ m/^<!isHiragana>.$/ ), q{Don't match negated <?isHiragana>} );
ok(!( "\c[HIRAGANA LETTER SMALL A]" ~~ m/^<-isHiragana>$/ ), q{Don't match inverted <?isHiragana>} );
ok(!( "\c[CANADIAN SYLLABICS Y]"  ~~ m/^<?isHiragana>$/ ), q{Don't match unrelated <?isHiragana>} );
ok("\c[CANADIAN SYLLABICS Y]"  ~~ m/^<!isHiragana>.$/, q{Match unrelated negated <?isHiragana>} );
ok("\c[CANADIAN SYLLABICS Y]"  ~~ m/^<-isHiragana>$/, q{Match unrelated inverted <?isHiragana>} );
ok("\c[CANADIAN SYLLABICS Y]\c[HIRAGANA LETTER SMALL A]" ~~ m/<?isHiragana>/, q{Match unanchored <?isHiragana>} );

# Inherited


ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<?isInherited>$/, q{Match <?isInherited>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isInherited>.$/ ), q{Don't match negated <?isInherited>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isInherited>$/ ), q{Don't match inverted <?isInherited>} );
ok(!( "\x[75FA]"  ~~ m/^<?isInherited>$/ ), q{Don't match unrelated <?isInherited>} );
ok("\x[75FA]"  ~~ m/^<!isInherited>.$/, q{Match unrelated negated <?isInherited>} );
ok("\x[75FA]"  ~~ m/^<-isInherited>$/, q{Match unrelated inverted <?isInherited>} );
ok("\x[75FA]\c[COMBINING GRAVE ACCENT]" ~~ m/<?isInherited>/, q{Match unanchored <?isInherited>} );

# Kannada


ok("\c[KANNADA SIGN ANUSVARA]" ~~ m/^<?isKannada>$/, q{Match <?isKannada>} );
ok(!( "\c[KANNADA SIGN ANUSVARA]" ~~ m/^<!isKannada>.$/ ), q{Don't match negated <?isKannada>} );
ok(!( "\c[KANNADA SIGN ANUSVARA]" ~~ m/^<-isKannada>$/ ), q{Don't match inverted <?isKannada>} );
ok(!( "\x[C1DF]"  ~~ m/^<?isKannada>$/ ), q{Don't match unrelated <?isKannada>} );
ok("\x[C1DF]"  ~~ m/^<!isKannada>.$/, q{Match unrelated negated <?isKannada>} );
ok("\x[C1DF]"  ~~ m/^<-isKannada>$/, q{Match unrelated inverted <?isKannada>} );
ok("\x[C1DF]\c[KANNADA SIGN ANUSVARA]" ~~ m/<?isKannada>/, q{Match unanchored <?isKannada>} );

# Katakana


ok("\c[KATAKANA LETTER SMALL A]" ~~ m/^<?isKatakana>$/, q{Match <?isKatakana>} );
ok(!( "\c[KATAKANA LETTER SMALL A]" ~~ m/^<!isKatakana>.$/ ), q{Don't match negated <?isKatakana>} );
ok(!( "\c[KATAKANA LETTER SMALL A]" ~~ m/^<-isKatakana>$/ ), q{Don't match inverted <?isKatakana>} );
ok(!( "\x[177A]"  ~~ m/^<?isKatakana>$/ ), q{Don't match unrelated <?isKatakana>} );
ok("\x[177A]"  ~~ m/^<!isKatakana>.$/, q{Match unrelated negated <?isKatakana>} );
ok("\x[177A]"  ~~ m/^<-isKatakana>$/, q{Match unrelated inverted <?isKatakana>} );
ok("\x[177A]\c[KATAKANA LETTER SMALL A]" ~~ m/<?isKatakana>/, q{Match unanchored <?isKatakana>} );

# Khmer


ok("\c[KHMER LETTER KA]" ~~ m/^<?isKhmer>$/, q{Match <?isKhmer>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<!isKhmer>.$/ ), q{Don't match negated <?isKhmer>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<-isKhmer>$/ ), q{Don't match inverted <?isKhmer>} );
ok(!( "\c[GEORGIAN LETTER QAR]"  ~~ m/^<?isKhmer>$/ ), q{Don't match unrelated <?isKhmer>} );
ok("\c[GEORGIAN LETTER QAR]"  ~~ m/^<!isKhmer>.$/, q{Match unrelated negated <?isKhmer>} );
ok("\c[GEORGIAN LETTER QAR]"  ~~ m/^<-isKhmer>$/, q{Match unrelated inverted <?isKhmer>} );
ok("\c[GEORGIAN LETTER QAR]\c[KHMER LETTER KA]" ~~ m/<?isKhmer>/, q{Match unanchored <?isKhmer>} );

# Lao


ok("\c[LAO LETTER KO]" ~~ m/^<?isLao>$/, q{Match <?isLao>} );
ok(!( "\c[LAO LETTER KO]" ~~ m/^<!isLao>.$/ ), q{Don't match negated <?isLao>} );
ok(!( "\c[LAO LETTER KO]" ~~ m/^<-isLao>$/ ), q{Don't match inverted <?isLao>} );
ok(!( "\x[3DA9]"  ~~ m/^<?isLao>$/ ), q{Don't match unrelated <?isLao>} );
ok("\x[3DA9]"  ~~ m/^<!isLao>.$/, q{Match unrelated negated <?isLao>} );
ok("\x[3DA9]"  ~~ m/^<-isLao>$/, q{Match unrelated inverted <?isLao>} );
ok(!( "\x[3DA9]" ~~ m/^<?isLao>$/ ), q{Don't match related <?isLao>} );
ok("\x[3DA9]" ~~ m/^<!isLao>.$/, q{Match related negated <?isLao>} );
ok("\x[3DA9]" ~~ m/^<-isLao>$/, q{Match related inverted <?isLao>} );
ok("\x[3DA9]\x[3DA9]\c[LAO LETTER KO]" ~~ m/<?isLao>/, q{Match unanchored <?isLao>} );

# Latin


ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<?isLatin>$/, q{Match <?isLatin>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<!isLatin>.$/ ), q{Don't match negated <?isLatin>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-isLatin>$/ ), q{Don't match inverted <?isLatin>} );
ok(!( "\x[C549]"  ~~ m/^<?isLatin>$/ ), q{Don't match unrelated <?isLatin>} );
ok("\x[C549]"  ~~ m/^<!isLatin>.$/, q{Match unrelated negated <?isLatin>} );
ok("\x[C549]"  ~~ m/^<-isLatin>$/, q{Match unrelated inverted <?isLatin>} );
ok(!( "\x[C549]" ~~ m/^<?isLatin>$/ ), q{Don't match related <?isLatin>} );
ok("\x[C549]" ~~ m/^<!isLatin>.$/, q{Match related negated <?isLatin>} );
ok("\x[C549]" ~~ m/^<-isLatin>$/, q{Match related inverted <?isLatin>} );
ok("\x[C549]\x[C549]\c[LATIN CAPITAL LETTER A]" ~~ m/<?isLatin>/, q{Match unanchored <?isLatin>} );

# Malayalam


ok("\c[MALAYALAM SIGN ANUSVARA]" ~~ m/^<?isMalayalam>$/, q{Match <?isMalayalam>} );
ok(!( "\c[MALAYALAM SIGN ANUSVARA]" ~~ m/^<!isMalayalam>.$/ ), q{Don't match negated <?isMalayalam>} );
ok(!( "\c[MALAYALAM SIGN ANUSVARA]" ~~ m/^<-isMalayalam>$/ ), q{Don't match inverted <?isMalayalam>} );
ok(!( "\x[625C]"  ~~ m/^<?isMalayalam>$/ ), q{Don't match unrelated <?isMalayalam>} );
ok("\x[625C]"  ~~ m/^<!isMalayalam>.$/, q{Match unrelated negated <?isMalayalam>} );
ok("\x[625C]"  ~~ m/^<-isMalayalam>$/, q{Match unrelated inverted <?isMalayalam>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<?isMalayalam>$/ ), q{Don't match related <?isMalayalam>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isMalayalam>.$/, q{Match related negated <?isMalayalam>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isMalayalam>$/, q{Match related inverted <?isMalayalam>} );
ok("\x[625C]\c[COMBINING GRAVE ACCENT]\c[MALAYALAM SIGN ANUSVARA]" ~~ m/<?isMalayalam>/, q{Match unanchored <?isMalayalam>} );

# Mongolian


ok("\c[MONGOLIAN DIGIT ZERO]" ~~ m/^<?isMongolian>$/, q{Match <?isMongolian>} );
ok(!( "\c[MONGOLIAN DIGIT ZERO]" ~~ m/^<!isMongolian>.$/ ), q{Don't match negated <?isMongolian>} );
ok(!( "\c[MONGOLIAN DIGIT ZERO]" ~~ m/^<-isMongolian>$/ ), q{Don't match inverted <?isMongolian>} );
ok(!( "\x[5F93]"  ~~ m/^<?isMongolian>$/ ), q{Don't match unrelated <?isMongolian>} );
ok("\x[5F93]"  ~~ m/^<!isMongolian>.$/, q{Match unrelated negated <?isMongolian>} );
ok("\x[5F93]"  ~~ m/^<-isMongolian>$/, q{Match unrelated inverted <?isMongolian>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<?isMongolian>$/ ), q{Don't match related <?isMongolian>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isMongolian>.$/, q{Match related negated <?isMongolian>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isMongolian>$/, q{Match related inverted <?isMongolian>} );
ok("\x[5F93]\c[COMBINING GRAVE ACCENT]\c[MONGOLIAN DIGIT ZERO]" ~~ m/<?isMongolian>/, q{Match unanchored <?isMongolian>} );

# Myanmar


ok("\c[MYANMAR LETTER KA]" ~~ m/^<?isMyanmar>$/, q{Match <?isMyanmar>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<!isMyanmar>.$/ ), q{Don't match negated <?isMyanmar>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<-isMyanmar>$/ ), q{Don't match inverted <?isMyanmar>} );
ok(!( "\x[649A]"  ~~ m/^<?isMyanmar>$/ ), q{Don't match unrelated <?isMyanmar>} );
ok("\x[649A]"  ~~ m/^<!isMyanmar>.$/, q{Match unrelated negated <?isMyanmar>} );
ok("\x[649A]"  ~~ m/^<-isMyanmar>$/, q{Match unrelated inverted <?isMyanmar>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<?isMyanmar>$/ ), q{Don't match related <?isMyanmar>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isMyanmar>.$/, q{Match related negated <?isMyanmar>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isMyanmar>$/, q{Match related inverted <?isMyanmar>} );
ok("\x[649A]\c[COMBINING GRAVE ACCENT]\c[MYANMAR LETTER KA]" ~~ m/<?isMyanmar>/, q{Match unanchored <?isMyanmar>} );

# Ogham


ok("\c[OGHAM LETTER BEITH]" ~~ m/^<?isOgham>$/, q{Match <?isOgham>} );
ok(!( "\c[OGHAM LETTER BEITH]" ~~ m/^<!isOgham>.$/ ), q{Don't match negated <?isOgham>} );
ok(!( "\c[OGHAM LETTER BEITH]" ~~ m/^<-isOgham>$/ ), q{Don't match inverted <?isOgham>} );
ok(!( "\c[KATAKANA LETTER KA]"  ~~ m/^<?isOgham>$/ ), q{Don't match unrelated <?isOgham>} );
ok("\c[KATAKANA LETTER KA]"  ~~ m/^<!isOgham>.$/, q{Match unrelated negated <?isOgham>} );
ok("\c[KATAKANA LETTER KA]"  ~~ m/^<-isOgham>$/, q{Match unrelated inverted <?isOgham>} );
ok("\c[KATAKANA LETTER KA]\c[OGHAM LETTER BEITH]" ~~ m/<?isOgham>/, q{Match unanchored <?isOgham>} );

# OldItalic


ok(!( "\x[8BB7]"  ~~ m/^<?isOldItalic>$/ ), q{Don't match unrelated <?isOldItalic>} );
ok("\x[8BB7]"  ~~ m/^<!isOldItalic>.$/, q{Match unrelated negated <?isOldItalic>} );
ok("\x[8BB7]"  ~~ m/^<-isOldItalic>$/, q{Match unrelated inverted <?isOldItalic>} );

# Oriya


ok("\c[ORIYA SIGN CANDRABINDU]" ~~ m/^<?isOriya>$/, q{Match <?isOriya>} );
ok(!( "\c[ORIYA SIGN CANDRABINDU]" ~~ m/^<!isOriya>.$/ ), q{Don't match negated <?isOriya>} );
ok(!( "\c[ORIYA SIGN CANDRABINDU]" ~~ m/^<-isOriya>$/ ), q{Don't match inverted <?isOriya>} );
ok(!( "\x[4292]"  ~~ m/^<?isOriya>$/ ), q{Don't match unrelated <?isOriya>} );
ok("\x[4292]"  ~~ m/^<!isOriya>.$/, q{Match unrelated negated <?isOriya>} );
ok("\x[4292]"  ~~ m/^<-isOriya>$/, q{Match unrelated inverted <?isOriya>} );
ok("\x[4292]\c[ORIYA SIGN CANDRABINDU]" ~~ m/<?isOriya>/, q{Match unanchored <?isOriya>} );

# Runic


ok("\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<?isRunic>$/, q{Match <?isRunic>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<!isRunic>.$/ ), q{Don't match negated <?isRunic>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<-isRunic>$/ ), q{Don't match inverted <?isRunic>} );
ok(!( "\x[9857]"  ~~ m/^<?isRunic>$/ ), q{Don't match unrelated <?isRunic>} );
ok("\x[9857]"  ~~ m/^<!isRunic>.$/, q{Match unrelated negated <?isRunic>} );
ok("\x[9857]"  ~~ m/^<-isRunic>$/, q{Match unrelated inverted <?isRunic>} );
ok("\x[9857]\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/<?isRunic>/, q{Match unanchored <?isRunic>} );

# Sinhala


ok("\c[SINHALA SIGN ANUSVARAYA]" ~~ m/^<?isSinhala>$/, q{Match <?isSinhala>} );
ok(!( "\c[SINHALA SIGN ANUSVARAYA]" ~~ m/^<!isSinhala>.$/ ), q{Don't match negated <?isSinhala>} );
ok(!( "\c[SINHALA SIGN ANUSVARAYA]" ~~ m/^<-isSinhala>$/ ), q{Don't match inverted <?isSinhala>} );
ok(!( "\x[5DF5]"  ~~ m/^<?isSinhala>$/ ), q{Don't match unrelated <?isSinhala>} );
ok("\x[5DF5]"  ~~ m/^<!isSinhala>.$/, q{Match unrelated negated <?isSinhala>} );
ok("\x[5DF5]"  ~~ m/^<-isSinhala>$/, q{Match unrelated inverted <?isSinhala>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<?isSinhala>$/ ), q{Don't match related <?isSinhala>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<!isSinhala>.$/, q{Match related negated <?isSinhala>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<-isSinhala>$/, q{Match related inverted <?isSinhala>} );
ok("\x[5DF5]\c[YI RADICAL QOT]\c[SINHALA SIGN ANUSVARAYA]" ~~ m/<?isSinhala>/, q{Match unanchored <?isSinhala>} );

# Syriac


ok("\c[SYRIAC LETTER ALAPH]" ~~ m/^<?isSyriac>$/, q{Match <?isSyriac>} );
ok(!( "\c[SYRIAC LETTER ALAPH]" ~~ m/^<!isSyriac>.$/ ), q{Don't match negated <?isSyriac>} );
ok(!( "\c[SYRIAC LETTER ALAPH]" ~~ m/^<-isSyriac>$/ ), q{Don't match inverted <?isSyriac>} );
ok(!( "\x[57F0]"  ~~ m/^<?isSyriac>$/ ), q{Don't match unrelated <?isSyriac>} );
ok("\x[57F0]"  ~~ m/^<!isSyriac>.$/, q{Match unrelated negated <?isSyriac>} );
ok("\x[57F0]"  ~~ m/^<-isSyriac>$/, q{Match unrelated inverted <?isSyriac>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<?isSyriac>$/ ), q{Don't match related <?isSyriac>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<!isSyriac>.$/, q{Match related negated <?isSyriac>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<-isSyriac>$/, q{Match related inverted <?isSyriac>} );
ok("\x[57F0]\c[YI RADICAL QOT]\c[SYRIAC LETTER ALAPH]" ~~ m/<?isSyriac>/, q{Match unanchored <?isSyriac>} );

# Tagalog


ok("\c[TAGALOG LETTER A]" ~~ m/^<?isTagalog>$/, q{Match <?isTagalog>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<!isTagalog>.$/ ), q{Don't match negated <?isTagalog>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<-isTagalog>$/ ), q{Don't match inverted <?isTagalog>} );
ok(!( "\x[3DE8]"  ~~ m/^<?isTagalog>$/ ), q{Don't match unrelated <?isTagalog>} );
ok("\x[3DE8]"  ~~ m/^<!isTagalog>.$/, q{Match unrelated negated <?isTagalog>} );
ok("\x[3DE8]"  ~~ m/^<-isTagalog>$/, q{Match unrelated inverted <?isTagalog>} );
ok("\x[3DE8]\c[TAGALOG LETTER A]" ~~ m/<?isTagalog>/, q{Match unanchored <?isTagalog>} );

# Tagbanwa


ok("\c[TAGBANWA LETTER A]" ~~ m/^<?isTagbanwa>$/, q{Match <?isTagbanwa>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<!isTagbanwa>.$/ ), q{Don't match negated <?isTagbanwa>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<-isTagbanwa>$/ ), q{Don't match inverted <?isTagbanwa>} );
ok(!( "\c[CHEROKEE LETTER TLV]"  ~~ m/^<?isTagbanwa>$/ ), q{Don't match unrelated <?isTagbanwa>} );
ok("\c[CHEROKEE LETTER TLV]"  ~~ m/^<!isTagbanwa>.$/, q{Match unrelated negated <?isTagbanwa>} );
ok("\c[CHEROKEE LETTER TLV]"  ~~ m/^<-isTagbanwa>$/, q{Match unrelated inverted <?isTagbanwa>} );
ok("\c[CHEROKEE LETTER TLV]\c[TAGBANWA LETTER A]" ~~ m/<?isTagbanwa>/, q{Match unanchored <?isTagbanwa>} );

# Tamil


ok("\c[TAMIL SIGN ANUSVARA]" ~~ m/^<?isTamil>$/, q{Match <?isTamil>} );
ok(!( "\c[TAMIL SIGN ANUSVARA]" ~~ m/^<!isTamil>.$/ ), q{Don't match negated <?isTamil>} );
ok(!( "\c[TAMIL SIGN ANUSVARA]" ~~ m/^<-isTamil>$/ ), q{Don't match inverted <?isTamil>} );
ok(!( "\x[8DF2]"  ~~ m/^<?isTamil>$/ ), q{Don't match unrelated <?isTamil>} );
ok("\x[8DF2]"  ~~ m/^<!isTamil>.$/, q{Match unrelated negated <?isTamil>} );
ok("\x[8DF2]"  ~~ m/^<-isTamil>$/, q{Match unrelated inverted <?isTamil>} );
ok("\x[8DF2]\c[TAMIL SIGN ANUSVARA]" ~~ m/<?isTamil>/, q{Match unanchored <?isTamil>} );

# Telugu


ok("\c[TELUGU SIGN CANDRABINDU]" ~~ m/^<?isTelugu>$/, q{Match <?isTelugu>} );
ok(!( "\c[TELUGU SIGN CANDRABINDU]" ~~ m/^<!isTelugu>.$/ ), q{Don't match negated <?isTelugu>} );
ok(!( "\c[TELUGU SIGN CANDRABINDU]" ~~ m/^<-isTelugu>$/ ), q{Don't match inverted <?isTelugu>} );
ok(!( "\x[8088]"  ~~ m/^<?isTelugu>$/ ), q{Don't match unrelated <?isTelugu>} );
ok("\x[8088]"  ~~ m/^<!isTelugu>.$/, q{Match unrelated negated <?isTelugu>} );
ok("\x[8088]"  ~~ m/^<-isTelugu>$/, q{Match unrelated inverted <?isTelugu>} );
ok("\x[8088]\c[TELUGU SIGN CANDRABINDU]" ~~ m/<?isTelugu>/, q{Match unanchored <?isTelugu>} );

# Thaana


ok("\c[THAANA LETTER HAA]" ~~ m/^<?isThaana>$/, q{Match <?isThaana>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<!isThaana>.$/ ), q{Don't match negated <?isThaana>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<-isThaana>$/ ), q{Don't match inverted <?isThaana>} );
ok(!( "\x[5240]"  ~~ m/^<?isThaana>$/ ), q{Don't match unrelated <?isThaana>} );
ok("\x[5240]"  ~~ m/^<!isThaana>.$/, q{Match unrelated negated <?isThaana>} );
ok("\x[5240]"  ~~ m/^<-isThaana>$/, q{Match unrelated inverted <?isThaana>} );
ok("\x[5240]\c[THAANA LETTER HAA]" ~~ m/<?isThaana>/, q{Match unanchored <?isThaana>} );

# Thai


ok("\c[THAI CHARACTER KO KAI]" ~~ m/^<?isThai>$/, q{Match <?isThai>} );
ok(!( "\c[THAI CHARACTER KO KAI]" ~~ m/^<!isThai>.$/ ), q{Don't match negated <?isThai>} );
ok(!( "\c[THAI CHARACTER KO KAI]" ~~ m/^<-isThai>$/ ), q{Don't match inverted <?isThai>} );
ok(!( "\x[CAD3]"  ~~ m/^<?isThai>$/ ), q{Don't match unrelated <?isThai>} );
ok("\x[CAD3]"  ~~ m/^<!isThai>.$/, q{Match unrelated negated <?isThai>} );
ok("\x[CAD3]"  ~~ m/^<-isThai>$/, q{Match unrelated inverted <?isThai>} );
ok("\x[CAD3]\c[THAI CHARACTER KO KAI]" ~~ m/<?isThai>/, q{Match unanchored <?isThai>} );

# Tibetan


ok("\c[TIBETAN SYLLABLE OM]" ~~ m/^<?isTibetan>$/, q{Match <?isTibetan>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<!isTibetan>.$/ ), q{Don't match negated <?isTibetan>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<-isTibetan>$/ ), q{Don't match inverted <?isTibetan>} );
ok(!( "\x[8557]"  ~~ m/^<?isTibetan>$/ ), q{Don't match unrelated <?isTibetan>} );
ok("\x[8557]"  ~~ m/^<!isTibetan>.$/, q{Match unrelated negated <?isTibetan>} );
ok("\x[8557]"  ~~ m/^<-isTibetan>$/, q{Match unrelated inverted <?isTibetan>} );
ok("\x[8557]\c[TIBETAN SYLLABLE OM]" ~~ m/<?isTibetan>/, q{Match unanchored <?isTibetan>} );

# Yi


ok("\c[YI SYLLABLE IT]" ~~ m/^<?isYi>$/, q{Match <?isYi>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<!isYi>.$/ ), q{Don't match negated <?isYi>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<-isYi>$/ ), q{Don't match inverted <?isYi>} );
ok(!( "\x[BCD0]"  ~~ m/^<?isYi>$/ ), q{Don't match unrelated <?isYi>} );
ok("\x[BCD0]"  ~~ m/^<!isYi>.$/, q{Match unrelated negated <?isYi>} );
ok("\x[BCD0]"  ~~ m/^<-isYi>$/, q{Match unrelated inverted <?isYi>} );
ok("\x[BCD0]\c[YI SYLLABLE IT]" ~~ m/<?isYi>/, q{Match unanchored <?isYi>} );

# ASCIIHexDigit


ok("\c[DIGIT ZERO]" ~~ m/^<?isASCIIHexDigit>$/, q{Match <?isASCIIHexDigit>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<!isASCIIHexDigit>.$/ ), q{Don't match negated <?isASCIIHexDigit>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-isASCIIHexDigit>$/ ), q{Don't match inverted <?isASCIIHexDigit>} );
ok(!( "\x[53BA]"  ~~ m/^<?isASCIIHexDigit>$/ ), q{Don't match unrelated <?isASCIIHexDigit>} );
ok("\x[53BA]"  ~~ m/^<!isASCIIHexDigit>.$/, q{Match unrelated negated <?isASCIIHexDigit>} );
ok("\x[53BA]"  ~~ m/^<-isASCIIHexDigit>$/, q{Match unrelated inverted <?isASCIIHexDigit>} );
ok("\x[53BA]\c[DIGIT ZERO]" ~~ m/<?isASCIIHexDigit>/, q{Match unanchored <?isASCIIHexDigit>} );

# Dash


ok("\c[HYPHEN-MINUS]" ~~ m/^<?isDash>$/, q{Match <?isDash>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<!isDash>.$/ ), q{Don't match negated <?isDash>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<-isDash>$/ ), q{Don't match inverted <?isDash>} );
ok(!( "\x[53F7]"  ~~ m/^<?isDash>$/ ), q{Don't match unrelated <?isDash>} );
ok("\x[53F7]"  ~~ m/^<!isDash>.$/, q{Match unrelated negated <?isDash>} );
ok("\x[53F7]"  ~~ m/^<-isDash>$/, q{Match unrelated inverted <?isDash>} );
ok("\x[53F7]\c[HYPHEN-MINUS]" ~~ m/<?isDash>/, q{Match unanchored <?isDash>} );

# Diacritic


ok("\c[MODIFIER LETTER CAPITAL A]" ~~ m/^<?isDiacritic>$/, q{Match <?isDiacritic>} );
ok(!( "\c[MODIFIER LETTER CAPITAL A]" ~~ m/^<!isDiacritic>.$/ ), q{Don't match negated <?isDiacritic>} );
ok(!( "\c[MODIFIER LETTER CAPITAL A]" ~~ m/^<-isDiacritic>$/ ), q{Don't match inverted <?isDiacritic>} );
ok(!( "\x[1BCD]"  ~~ m/^<?isDiacritic>$/ ), q{Don't match unrelated <?isDiacritic>} );
ok("\x[1BCD]"  ~~ m/^<!isDiacritic>.$/, q{Match unrelated negated <?isDiacritic>} );
ok("\x[1BCD]"  ~~ m/^<-isDiacritic>$/, q{Match unrelated inverted <?isDiacritic>} );
ok("\x[1BCD]\c[MODIFIER LETTER CAPITAL A]" ~~ m/<?isDiacritic>/, q{Match unanchored <?isDiacritic>} );

# Extender


ok("\c[MIDDLE DOT]" ~~ m/^<?isExtender>$/, q{Match <?isExtender>} );
ok(!( "\c[MIDDLE DOT]" ~~ m/^<!isExtender>.$/ ), q{Don't match negated <?isExtender>} );
ok(!( "\c[MIDDLE DOT]" ~~ m/^<-isExtender>$/ ), q{Don't match inverted <?isExtender>} );
ok(!( "\x[3A18]"  ~~ m/^<?isExtender>$/ ), q{Don't match unrelated <?isExtender>} );
ok("\x[3A18]"  ~~ m/^<!isExtender>.$/, q{Match unrelated negated <?isExtender>} );
ok("\x[3A18]"  ~~ m/^<-isExtender>$/, q{Match unrelated inverted <?isExtender>} );
ok("\x[3A18]\c[MIDDLE DOT]" ~~ m/<?isExtender>/, q{Match unanchored <?isExtender>} );

# GraphemeLink


ok("\c[COMBINING GRAPHEME JOINER]" ~~ m/^<?isGraphemeLink>$/, q{Match <?isGraphemeLink>} );
ok(!( "\c[COMBINING GRAPHEME JOINER]" ~~ m/^<!isGraphemeLink>.$/ ), q{Don't match negated <?isGraphemeLink>} );
ok(!( "\c[COMBINING GRAPHEME JOINER]" ~~ m/^<-isGraphemeLink>$/ ), q{Don't match inverted <?isGraphemeLink>} );
ok(!( "\x[4989]"  ~~ m/^<?isGraphemeLink>$/ ), q{Don't match unrelated <?isGraphemeLink>} );
ok("\x[4989]"  ~~ m/^<!isGraphemeLink>.$/, q{Match unrelated negated <?isGraphemeLink>} );
ok("\x[4989]"  ~~ m/^<-isGraphemeLink>$/, q{Match unrelated inverted <?isGraphemeLink>} );
ok("\x[4989]\c[COMBINING GRAPHEME JOINER]" ~~ m/<?isGraphemeLink>/, q{Match unanchored <?isGraphemeLink>} );

# HexDigit


ok("\c[DIGIT ZERO]" ~~ m/^<?isHexDigit>$/, q{Match <?isHexDigit>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<!isHexDigit>.$/ ), q{Don't match negated <?isHexDigit>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-isHexDigit>$/ ), q{Don't match inverted <?isHexDigit>} );
ok(!( "\x[6292]"  ~~ m/^<?isHexDigit>$/ ), q{Don't match unrelated <?isHexDigit>} );
ok("\x[6292]"  ~~ m/^<!isHexDigit>.$/, q{Match unrelated negated <?isHexDigit>} );
ok("\x[6292]"  ~~ m/^<-isHexDigit>$/, q{Match unrelated inverted <?isHexDigit>} );
ok("\x[6292]\c[DIGIT ZERO]" ~~ m/<?isHexDigit>/, q{Match unanchored <?isHexDigit>} );

# Hyphen

ok("\c[KATAKANA MIDDLE DOT]" ~~ m/^<?isHyphen>$/, q{Match <?isHyphen>} );
ok(!( "\c[KATAKANA MIDDLE DOT]" ~~ m/^<!isHyphen>.$/ ), q{Don't match negated <?isHyphen>} );
ok(!( "\c[KATAKANA MIDDLE DOT]" ~~ m/^<-isHyphen>$/ ), q{Don't match inverted <?isHyphen>} );
ok(!( "\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]"  ~~ m/^<?isHyphen>$/ ), q{Don't match unrelated <?isHyphen>} );
ok("\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]"  ~~ m/^<!isHyphen>.$/, q{Match unrelated negated <?isHyphen>} );
ok("\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]"  ~~ m/^<-isHyphen>$/, q{Match unrelated inverted <?isHyphen>} );
ok("\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]\c[KATAKANA MIDDLE DOT]" ~~ m/<?isHyphen>/, q{Match unanchored <?isHyphen>} );

# Ideographic


ok("\x[8AB0]" ~~ m/^<?isIdeographic>$/, q{Match <?isIdeographic>} );
ok(!( "\x[8AB0]" ~~ m/^<!isIdeographic>.$/ ), q{Don't match negated <?isIdeographic>} );
ok(!( "\x[8AB0]" ~~ m/^<-isIdeographic>$/ ), q{Don't match inverted <?isIdeographic>} );
ok(!( "\x[9FA6]"  ~~ m/^<?isIdeographic>$/ ), q{Don't match unrelated <?isIdeographic>} );
ok("\x[9FA6]"  ~~ m/^<!isIdeographic>.$/, q{Match unrelated negated <?isIdeographic>} );
ok("\x[9FA6]"  ~~ m/^<-isIdeographic>$/, q{Match unrelated inverted <?isIdeographic>} );
ok("\x[9FA6]\x[8AB0]" ~~ m/<?isIdeographic>/, q{Match unanchored <?isIdeographic>} );

# IDSBinaryOperator


ok("\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<?isIDSBinaryOperator>$/, q{Match <?isIDSBinaryOperator>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<!isIDSBinaryOperator>.$/ ), q{Don't match negated <?isIDSBinaryOperator>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<-isIDSBinaryOperator>$/ ), q{Don't match inverted <?isIDSBinaryOperator>} );
ok(!( "\x[59E9]"  ~~ m/^<?isIDSBinaryOperator>$/ ), q{Don't match unrelated <?isIDSBinaryOperator>} );
ok("\x[59E9]"  ~~ m/^<!isIDSBinaryOperator>.$/, q{Match unrelated negated <?isIDSBinaryOperator>} );
ok("\x[59E9]"  ~~ m/^<-isIDSBinaryOperator>$/, q{Match unrelated inverted <?isIDSBinaryOperator>} );
ok("\x[59E9]\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/<?isIDSBinaryOperator>/, q{Match unanchored <?isIDSBinaryOperator>} );

# IDSTrinaryOperator


ok("\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/^<?isIDSTrinaryOperator>$/, q{Match <?isIDSTrinaryOperator>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/^<!isIDSTrinaryOperator>.$/ ), q{Don't match negated <?isIDSTrinaryOperator>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/^<-isIDSTrinaryOperator>$/ ), q{Don't match inverted <?isIDSTrinaryOperator>} );
ok(!( "\x[9224]"  ~~ m/^<?isIDSTrinaryOperator>$/ ), q{Don't match unrelated <?isIDSTrinaryOperator>} );
ok("\x[9224]"  ~~ m/^<!isIDSTrinaryOperator>.$/, q{Match unrelated negated <?isIDSTrinaryOperator>} );
ok("\x[9224]"  ~~ m/^<-isIDSTrinaryOperator>$/, q{Match unrelated inverted <?isIDSTrinaryOperator>} );
ok("\x[9224]\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/<?isIDSTrinaryOperator>/, q{Match unanchored <?isIDSTrinaryOperator>} );

# JoinControl


ok("\c[ZERO WIDTH NON-JOINER]" ~~ m/^<?isJoinControl>$/, q{Match <?isJoinControl>} );
ok(!( "\c[ZERO WIDTH NON-JOINER]" ~~ m/^<!isJoinControl>.$/ ), q{Don't match negated <?isJoinControl>} );
ok(!( "\c[ZERO WIDTH NON-JOINER]" ~~ m/^<-isJoinControl>$/ ), q{Don't match inverted <?isJoinControl>} );
ok(!( "\c[BENGALI LETTER DDHA]"  ~~ m/^<?isJoinControl>$/ ), q{Don't match unrelated <?isJoinControl>} );
ok("\c[BENGALI LETTER DDHA]"  ~~ m/^<!isJoinControl>.$/, q{Match unrelated negated <?isJoinControl>} );
ok("\c[BENGALI LETTER DDHA]"  ~~ m/^<-isJoinControl>$/, q{Match unrelated inverted <?isJoinControl>} );
ok("\c[BENGALI LETTER DDHA]\c[ZERO WIDTH NON-JOINER]" ~~ m/<?isJoinControl>/, q{Match unanchored <?isJoinControl>} );

# LogicalOrderException


ok("\c[THAI CHARACTER SARA E]" ~~ m/^<?isLogicalOrderException>$/, q{Match <?isLogicalOrderException>} );
ok(!( "\c[THAI CHARACTER SARA E]" ~~ m/^<!isLogicalOrderException>.$/ ), q{Don't match negated <?isLogicalOrderException>} );
ok(!( "\c[THAI CHARACTER SARA E]" ~~ m/^<-isLogicalOrderException>$/ ), q{Don't match inverted <?isLogicalOrderException>} );
ok(!( "\x[857B]"  ~~ m/^<?isLogicalOrderException>$/ ), q{Don't match unrelated <?isLogicalOrderException>} );
ok("\x[857B]"  ~~ m/^<!isLogicalOrderException>.$/, q{Match unrelated negated <?isLogicalOrderException>} );
ok("\x[857B]"  ~~ m/^<-isLogicalOrderException>$/, q{Match unrelated inverted <?isLogicalOrderException>} );
ok(!( "\x[857B]" ~~ m/^<?isLogicalOrderException>$/ ), q{Don't match related <?isLogicalOrderException>} );
ok("\x[857B]" ~~ m/^<!isLogicalOrderException>.$/, q{Match related negated <?isLogicalOrderException>} );
ok("\x[857B]" ~~ m/^<-isLogicalOrderException>$/, q{Match related inverted <?isLogicalOrderException>} );
ok("\x[857B]\x[857B]\c[THAI CHARACTER SARA E]" ~~ m/<?isLogicalOrderException>/, q{Match unanchored <?isLogicalOrderException>} );

# NoncharacterCodePoint


ok(!( "\c[LATIN LETTER REVERSED GLOTTAL STOP WITH STROKE]"  ~~ m/^<?isNoncharacterCodePoint>$/ ), q{Don't match unrelated <?isNoncharacterCodePoint>} );
ok("\c[LATIN LETTER REVERSED GLOTTAL STOP WITH STROKE]"  ~~ m/^<!isNoncharacterCodePoint>.$/, q{Match unrelated negated <?isNoncharacterCodePoint>} );
ok("\c[LATIN LETTER REVERSED GLOTTAL STOP WITH STROKE]"  ~~ m/^<-isNoncharacterCodePoint>$/, q{Match unrelated inverted <?isNoncharacterCodePoint>} );
ok(!( "\c[ARABIC-INDIC DIGIT ZERO]" ~~ m/^<?isNoncharacterCodePoint>$/ ), q{Don't match related <?isNoncharacterCodePoint>} );
ok("\c[ARABIC-INDIC DIGIT ZERO]" ~~ m/^<!isNoncharacterCodePoint>.$/, q{Match related negated <?isNoncharacterCodePoint>} );
ok("\c[ARABIC-INDIC DIGIT ZERO]" ~~ m/^<-isNoncharacterCodePoint>$/, q{Match related inverted <?isNoncharacterCodePoint>} );

# OtherAlphabetic


ok("\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<?isOtherAlphabetic>$/, q{Match <?isOtherAlphabetic>} );
ok(!( "\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<!isOtherAlphabetic>.$/ ), q{Don't match negated <?isOtherAlphabetic>} );
ok(!( "\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<-isOtherAlphabetic>$/ ), q{Don't match inverted <?isOtherAlphabetic>} );
ok(!( "\x[413C]"  ~~ m/^<?isOtherAlphabetic>$/ ), q{Don't match unrelated <?isOtherAlphabetic>} );
ok("\x[413C]"  ~~ m/^<!isOtherAlphabetic>.$/, q{Match unrelated negated <?isOtherAlphabetic>} );
ok("\x[413C]"  ~~ m/^<-isOtherAlphabetic>$/, q{Match unrelated inverted <?isOtherAlphabetic>} );
ok("\x[413C]\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/<?isOtherAlphabetic>/, q{Match unanchored <?isOtherAlphabetic>} );

# OtherDefaultIgnorableCodePoint


ok("\c[HANGUL FILLER]" ~~ m/^<?isOtherDefaultIgnorableCodePoint>$/, q{Match <?isOtherDefaultIgnorableCodePoint>} );
ok(!( "\c[HANGUL FILLER]" ~~ m/^<!isOtherDefaultIgnorableCodePoint>.$/ ), q{Don't match negated <?isOtherDefaultIgnorableCodePoint>} );
ok(!( "\c[HANGUL FILLER]" ~~ m/^<-isOtherDefaultIgnorableCodePoint>$/ ), q{Don't match inverted <?isOtherDefaultIgnorableCodePoint>} );
ok(!( "\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<?isOtherDefaultIgnorableCodePoint>$/ ), q{Don't match unrelated <?isOtherDefaultIgnorableCodePoint>} );
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<!isOtherDefaultIgnorableCodePoint>.$/, q{Match unrelated negated <?isOtherDefaultIgnorableCodePoint>} );
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<-isOtherDefaultIgnorableCodePoint>$/, q{Match unrelated inverted <?isOtherDefaultIgnorableCodePoint>} );
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]\c[HANGUL FILLER]" ~~ m/<?isOtherDefaultIgnorableCodePoint>/, q{Match unanchored <?isOtherDefaultIgnorableCodePoint>} );

# OtherGraphemeExtend


ok("\c[BENGALI VOWEL SIGN AA]" ~~ m/^<?isOtherGraphemeExtend>$/, q{Match <?isOtherGraphemeExtend>} );
ok(!( "\c[BENGALI VOWEL SIGN AA]" ~~ m/^<!isOtherGraphemeExtend>.$/ ), q{Don't match negated <?isOtherGraphemeExtend>} );
ok(!( "\c[BENGALI VOWEL SIGN AA]" ~~ m/^<-isOtherGraphemeExtend>$/ ), q{Don't match inverted <?isOtherGraphemeExtend>} );
ok(!( "\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<?isOtherGraphemeExtend>$/ ), q{Don't match unrelated <?isOtherGraphemeExtend>} );
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<!isOtherGraphemeExtend>.$/, q{Match unrelated negated <?isOtherGraphemeExtend>} );
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<-isOtherGraphemeExtend>$/, q{Match unrelated inverted <?isOtherGraphemeExtend>} );
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]\c[BENGALI VOWEL SIGN AA]" ~~ m/<?isOtherGraphemeExtend>/, q{Match unanchored <?isOtherGraphemeExtend>} );

# OtherLowercase


ok("\c[MODIFIER LETTER SMALL H]" ~~ m/^<?isOtherLowercase>$/, q{Match <?isOtherLowercase>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<!isOtherLowercase>.$/ ), q{Don't match negated <?isOtherLowercase>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<-isOtherLowercase>$/ ), q{Don't match inverted <?isOtherLowercase>} );
ok(!( "\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<?isOtherLowercase>$/ ), q{Don't match unrelated <?isOtherLowercase>} );
ok("\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<!isOtherLowercase>.$/, q{Match unrelated negated <?isOtherLowercase>} );
ok("\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<-isOtherLowercase>$/, q{Match unrelated inverted <?isOtherLowercase>} );
ok("\c[HANGUL LETTER NIEUN-CIEUC]\c[MODIFIER LETTER SMALL H]" ~~ m/<?isOtherLowercase>/, q{Match unanchored <?isOtherLowercase>} );

# OtherMath


ok("\c[LEFT PARENTHESIS]" ~~ m/^<?isOtherMath>$/, q{Match <?isOtherMath>} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<!isOtherMath>.$/ ), q{Don't match negated <?isOtherMath>} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<-isOtherMath>$/ ), q{Don't match inverted <?isOtherMath>} );
ok(!( "\x[B43A]"  ~~ m/^<?isOtherMath>$/ ), q{Don't match unrelated <?isOtherMath>} );
ok("\x[B43A]"  ~~ m/^<!isOtherMath>.$/, q{Match unrelated negated <?isOtherMath>} );
ok("\x[B43A]"  ~~ m/^<-isOtherMath>$/, q{Match unrelated inverted <?isOtherMath>} );
ok("\x[B43A]\c[LEFT PARENTHESIS]" ~~ m/<?isOtherMath>/, q{Match unanchored <?isOtherMath>} );

# OtherUppercase


ok("\c[ROMAN NUMERAL ONE]" ~~ m/^<?isOtherUppercase>$/, q{Match <?isOtherUppercase>} );
ok(!( "\c[ROMAN NUMERAL ONE]" ~~ m/^<!isOtherUppercase>.$/ ), q{Don't match negated <?isOtherUppercase>} );
ok(!( "\c[ROMAN NUMERAL ONE]" ~~ m/^<-isOtherUppercase>$/ ), q{Don't match inverted <?isOtherUppercase>} );
ok(!( "\x[D246]"  ~~ m/^<?isOtherUppercase>$/ ), q{Don't match unrelated <?isOtherUppercase>} );
ok("\x[D246]"  ~~ m/^<!isOtherUppercase>.$/, q{Match unrelated negated <?isOtherUppercase>} );
ok("\x[D246]"  ~~ m/^<-isOtherUppercase>$/, q{Match unrelated inverted <?isOtherUppercase>} );
ok("\x[D246]\c[ROMAN NUMERAL ONE]" ~~ m/<?isOtherUppercase>/, q{Match unanchored <?isOtherUppercase>} );

# QuotationMark


ok("\c[QUOTATION MARK]" ~~ m/^<?isQuotationMark>$/, q{Match <?isQuotationMark>} );
ok(!( "\c[QUOTATION MARK]" ~~ m/^<!isQuotationMark>.$/ ), q{Don't match negated <?isQuotationMark>} );
ok(!( "\c[QUOTATION MARK]" ~~ m/^<-isQuotationMark>$/ ), q{Don't match inverted <?isQuotationMark>} );
ok(!( "\x[C890]"  ~~ m/^<?isQuotationMark>$/ ), q{Don't match unrelated <?isQuotationMark>} );
ok("\x[C890]"  ~~ m/^<!isQuotationMark>.$/, q{Match unrelated negated <?isQuotationMark>} );
ok("\x[C890]"  ~~ m/^<-isQuotationMark>$/, q{Match unrelated inverted <?isQuotationMark>} );
ok("\x[C890]\c[QUOTATION MARK]" ~~ m/<?isQuotationMark>/, q{Match unanchored <?isQuotationMark>} );

# Radical


ok("\c[CJK RADICAL REPEAT]" ~~ m/^<?isRadical>$/, q{Match <?isRadical>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<!isRadical>.$/ ), q{Don't match negated <?isRadical>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<-isRadical>$/ ), q{Don't match inverted <?isRadical>} );
ok(!( "\c[HANGUL JONGSEONG CHIEUCH]"  ~~ m/^<?isRadical>$/ ), q{Don't match unrelated <?isRadical>} );
ok("\c[HANGUL JONGSEONG CHIEUCH]"  ~~ m/^<!isRadical>.$/, q{Match unrelated negated <?isRadical>} );
ok("\c[HANGUL JONGSEONG CHIEUCH]"  ~~ m/^<-isRadical>$/, q{Match unrelated inverted <?isRadical>} );
ok("\c[HANGUL JONGSEONG CHIEUCH]\c[CJK RADICAL REPEAT]" ~~ m/<?isRadical>/, q{Match unanchored <?isRadical>} );

# SoftDotted


ok("\c[LATIN SMALL LETTER I]" ~~ m/^<?isSoftDotted>$/, q{Match <?isSoftDotted>} );
ok(!( "\c[LATIN SMALL LETTER I]" ~~ m/^<!isSoftDotted>.$/ ), q{Don't match negated <?isSoftDotted>} );
ok(!( "\c[LATIN SMALL LETTER I]" ~~ m/^<-isSoftDotted>$/ ), q{Don't match inverted <?isSoftDotted>} );
ok(!( "\x[ADEF]"  ~~ m/^<?isSoftDotted>$/ ), q{Don't match unrelated <?isSoftDotted>} );
ok("\x[ADEF]"  ~~ m/^<!isSoftDotted>.$/, q{Match unrelated negated <?isSoftDotted>} );
ok("\x[ADEF]"  ~~ m/^<-isSoftDotted>$/, q{Match unrelated inverted <?isSoftDotted>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<?isSoftDotted>$/ ), q{Don't match related <?isSoftDotted>} );
ok("\c[DOLLAR SIGN]" ~~ m/^<!isSoftDotted>.$/, q{Match related negated <?isSoftDotted>} );
ok("\c[DOLLAR SIGN]" ~~ m/^<-isSoftDotted>$/, q{Match related inverted <?isSoftDotted>} );
ok("\x[ADEF]\c[DOLLAR SIGN]\c[LATIN SMALL LETTER I]" ~~ m/<?isSoftDotted>/, q{Match unanchored <?isSoftDotted>} );

# TerminalPunctuation


ok("\c[EXCLAMATION MARK]" ~~ m/^<?isTerminalPunctuation>$/, q{Match <?isTerminalPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<!isTerminalPunctuation>.$/ ), q{Don't match negated <?isTerminalPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-isTerminalPunctuation>$/ ), q{Don't match inverted <?isTerminalPunctuation>} );
ok(!( "\x[3C9D]"  ~~ m/^<?isTerminalPunctuation>$/ ), q{Don't match unrelated <?isTerminalPunctuation>} );
ok("\x[3C9D]"  ~~ m/^<!isTerminalPunctuation>.$/, q{Match unrelated negated <?isTerminalPunctuation>} );
ok("\x[3C9D]"  ~~ m/^<-isTerminalPunctuation>$/, q{Match unrelated inverted <?isTerminalPunctuation>} );
ok("\x[3C9D]\c[EXCLAMATION MARK]" ~~ m/<?isTerminalPunctuation>/, q{Match unanchored <?isTerminalPunctuation>} );

# UnifiedIdeograph


ok("\x[7896]" ~~ m/^<?isUnifiedIdeograph>$/, q{Match <?isUnifiedIdeograph>} );
ok(!( "\x[7896]" ~~ m/^<!isUnifiedIdeograph>.$/ ), q{Don't match negated <?isUnifiedIdeograph>} );
ok(!( "\x[7896]" ~~ m/^<-isUnifiedIdeograph>$/ ), q{Don't match inverted <?isUnifiedIdeograph>} );
ok(!( "\x[9FA6]"  ~~ m/^<?isUnifiedIdeograph>$/ ), q{Don't match unrelated <?isUnifiedIdeograph>} );
ok("\x[9FA6]"  ~~ m/^<!isUnifiedIdeograph>.$/, q{Match unrelated negated <?isUnifiedIdeograph>} );
ok("\x[9FA6]"  ~~ m/^<-isUnifiedIdeograph>$/, q{Match unrelated inverted <?isUnifiedIdeograph>} );
ok("\x[9FA6]\x[7896]" ~~ m/<?isUnifiedIdeograph>/, q{Match unanchored <?isUnifiedIdeograph>} );

# WhiteSpace


ok("\c[CHARACTER TABULATION]" ~~ m/^<?isWhiteSpace>$/, q{Match <?isWhiteSpace>} );
ok(!( "\c[CHARACTER TABULATION]" ~~ m/^<!isWhiteSpace>.$/ ), q{Don't match negated <?isWhiteSpace>} );
ok(!( "\c[CHARACTER TABULATION]" ~~ m/^<-isWhiteSpace>$/ ), q{Don't match inverted <?isWhiteSpace>} );
ok(!( "\x[6358]"  ~~ m/^<?isWhiteSpace>$/ ), q{Don't match unrelated <?isWhiteSpace>} );
ok("\x[6358]"  ~~ m/^<!isWhiteSpace>.$/, q{Match unrelated negated <?isWhiteSpace>} );
ok("\x[6358]"  ~~ m/^<-isWhiteSpace>$/, q{Match unrelated inverted <?isWhiteSpace>} );
ok("\x[6358]\c[CHARACTER TABULATION]" ~~ m/<?isWhiteSpace>/, q{Match unanchored <?isWhiteSpace>} );

# Alphabetic      # Lu + Ll + Lt + Lm + Lo + OtherAlphabetic


ok("\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<?isAlphabetic>$/, q{Match (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<!isAlphabetic>.$/ ), q{Don't match negated (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<-isAlphabetic>$/ ), q{Don't match inverted (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok(!( "\x[0855]"  ~~ m/^<?isAlphabetic>$/ ), q{Don't match unrelated (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok("\x[0855]"  ~~ m/^<!isAlphabetic>.$/, q{Match unrelated negated (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok("\x[0855]"  ~~ m/^<-isAlphabetic>$/, q{Match unrelated inverted (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );
ok("\x[0855]\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/<?isAlphabetic>/, q{Match unanchored (Lu + Ll + Lt + Lm + Lo + OtherAlphabetic)} );

# Lowercase       # Ll + OtherLowercase


ok("\c[LATIN SMALL LETTER A]" ~~ m/^<?isLowercase>$/, q{Match (Ll + OtherLowercase)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<!isLowercase>.$/ ), q{Don't match negated (Ll + OtherLowercase)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<-isLowercase>$/ ), q{Don't match inverted (Ll + OtherLowercase)} );
ok(!( "\x[6220]"  ~~ m/^<?isLowercase>$/ ), q{Don't match unrelated (Ll + OtherLowercase)} );
ok("\x[6220]"  ~~ m/^<!isLowercase>.$/, q{Match unrelated negated (Ll + OtherLowercase)} );
ok("\x[6220]"  ~~ m/^<-isLowercase>$/, q{Match unrelated inverted (Ll + OtherLowercase)} );
ok(!( "\x[6220]" ~~ m/^<?isLowercase>$/ ), q{Don't match related (Ll + OtherLowercase)} );
ok("\x[6220]" ~~ m/^<!isLowercase>.$/, q{Match related negated (Ll + OtherLowercase)} );
ok("\x[6220]" ~~ m/^<-isLowercase>$/, q{Match related inverted (Ll + OtherLowercase)} );
ok("\x[6220]\x[6220]\c[LATIN SMALL LETTER A]" ~~ m/<?isLowercase>/, q{Match unanchored (Ll + OtherLowercase)} );

# Uppercase       # Lu + OtherUppercase


ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<?isUppercase>$/, q{Match (Lu + OtherUppercase)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<!isUppercase>.$/ ), q{Don't match negated (Lu + OtherUppercase)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-isUppercase>$/ ), q{Don't match inverted (Lu + OtherUppercase)} );
ok(!( "\x[C080]"  ~~ m/^<?isUppercase>$/ ), q{Don't match unrelated (Lu + OtherUppercase)} );
ok("\x[C080]"  ~~ m/^<!isUppercase>.$/, q{Match unrelated negated (Lu + OtherUppercase)} );
ok("\x[C080]"  ~~ m/^<-isUppercase>$/, q{Match unrelated inverted (Lu + OtherUppercase)} );
ok("\x[C080]\c[LATIN CAPITAL LETTER A]" ~~ m/<?isUppercase>/, q{Match unanchored (Lu + OtherUppercase)} );

# Math            # Sm + OtherMath


ok("\c[LEFT PARENTHESIS]" ~~ m/^<?isMath>$/, q{Match (Sm + OtherMath)} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<!isMath>.$/ ), q{Don't match negated (Sm + OtherMath)} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<-isMath>$/ ), q{Don't match inverted (Sm + OtherMath)} );
ok(!( "\x[D4D2]"  ~~ m/^<?isMath>$/ ), q{Don't match unrelated (Sm + OtherMath)} );
ok("\x[D4D2]"  ~~ m/^<!isMath>.$/, q{Match unrelated negated (Sm + OtherMath)} );
ok("\x[D4D2]"  ~~ m/^<-isMath>$/, q{Match unrelated inverted (Sm + OtherMath)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<?isMath>$/ ), q{Don't match related (Sm + OtherMath)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isMath>.$/, q{Match related negated (Sm + OtherMath)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isMath>$/, q{Match related inverted (Sm + OtherMath)} );
ok("\x[D4D2]\c[COMBINING GRAVE ACCENT]\c[LEFT PARENTHESIS]" ~~ m/<?isMath>/, q{Match unanchored (Sm + OtherMath)} );

# ID_Start        # Lu + Ll + Lt + Lm + Lo + Nl


ok("\x[C276]" ~~ m/^<?isID_Start>$/, q{Match (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok(!( "\x[C276]" ~~ m/^<!isID_Start>.$/ ), q{Don't match negated (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok(!( "\x[C276]" ~~ m/^<-isID_Start>$/ ), q{Don't match inverted (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok(!( "\x[D7A4]"  ~~ m/^<?isID_Start>$/ ), q{Don't match unrelated (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok("\x[D7A4]"  ~~ m/^<!isID_Start>.$/, q{Match unrelated negated (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok("\x[D7A4]"  ~~ m/^<-isID_Start>$/, q{Match unrelated inverted (Lu + Ll + Lt + Lm + Lo + Nl)} );
ok("\x[D7A4]\x[C276]" ~~ m/<?isID_Start>/, q{Match unanchored (Lu + Ll + Lt + Lm + Lo + Nl)} );

# ID_Continue     # ID_Start + Mn + Mc + Nd + Pc


ok("\x[949B]" ~~ m/^<?isID_Continue>$/, q{Match (ID_Start + Mn + Mc + Nd + Pc)} );
ok(!( "\x[949B]" ~~ m/^<!isID_Continue>.$/ ), q{Don't match negated (ID_Start + Mn + Mc + Nd + Pc)} );
ok(!( "\x[949B]" ~~ m/^<-isID_Continue>$/ ), q{Don't match inverted (ID_Start + Mn + Mc + Nd + Pc)} );
ok(!( "\x[9FA6]"  ~~ m/^<?isID_Continue>$/ ), q{Don't match unrelated (ID_Start + Mn + Mc + Nd + Pc)} );
ok("\x[9FA6]"  ~~ m/^<!isID_Continue>.$/, q{Match unrelated negated (ID_Start + Mn + Mc + Nd + Pc)} );
ok("\x[9FA6]"  ~~ m/^<-isID_Continue>$/, q{Match unrelated inverted (ID_Start + Mn + Mc + Nd + Pc)} );
ok("\x[9FA6]\x[949B]" ~~ m/<?isID_Continue>/, q{Match unanchored (ID_Start + Mn + Mc + Nd + Pc)} );

# Any             # Any character


ok("\x[C709]" ~~ m/^<?isAny>$/, q{Match (Any character)} );
ok(!( "\x[C709]" ~~ m/^<!isAny>.$/ ), q{Don't match negated (Any character)} );
ok(!( "\x[C709]" ~~ m/^<-isAny>$/ ), q{Don't match inverted (Any character)} );
ok("\x[C709]" ~~ m/<?isAny>/, q{Match unanchored (Any character)} );

# Assigned        # Any non-Cn character (i.e. synonym for \P{Cn})


ok("\x[C99D]" ~~ m/^<?isAssigned>$/, q{Match (Any non-Cn character (i.e. synonym for \P{Cn}))} );
ok(!( "\x[C99D]" ~~ m/^<!isAssigned>.$/ ), q{Don't match negated (Any non-Cn character (i.e. synonym for \P{Cn}))} );
ok(!( "\x[C99D]" ~~ m/^<-isAssigned>$/ ), q{Don't match inverted (Any non-Cn character (i.e. synonym for \P{Cn}))} );
ok(!( "\x[D7A4]"  ~~ m/^<?isAssigned>$/ ), q{Don't match unrelated (Any non-Cn character (i.e. synonym for \P{Cn}))} );
ok("\x[D7A4]"  ~~ m/^<!isAssigned>.$/, q{Match unrelated negated (Any non-Cn character (i.e. synonym for \P{Cn}))} );
ok("\x[D7A4]"  ~~ m/^<-isAssigned>$/, q{Match unrelated inverted (Any non-Cn character (i.e. synonym for \P{Cn}))} );
ok("\x[D7A4]\x[C99D]" ~~ m/<?isAssigned>/, q{Match unanchored (Any non-Cn character (i.e. synonym for \P{Cn}))} );

# Unassigned      # Synonym for \p{Cn}


ok("\x[27EC]" ~~ m/^<?isUnassigned>$/, q{Match (Synonym for \p{Cn})} );
ok(!( "\x[27EC]" ~~ m/^<!isUnassigned>.$/ ), q{Don't match negated (Synonym for \p{Cn})} );
ok(!( "\x[27EC]" ~~ m/^<-isUnassigned>$/ ), q{Don't match inverted (Synonym for \p{Cn})} );
ok(!( "\c[RIGHT OUTER JOIN]"  ~~ m/^<?isUnassigned>$/ ), q{Don't match unrelated (Synonym for \p{Cn})} );
ok("\c[RIGHT OUTER JOIN]"  ~~ m/^<!isUnassigned>.$/, q{Match unrelated negated (Synonym for \p{Cn})} );
ok("\c[RIGHT OUTER JOIN]"  ~~ m/^<-isUnassigned>$/, q{Match unrelated inverted (Synonym for \p{Cn})} );
ok("\c[RIGHT OUTER JOIN]\x[27EC]" ~~ m/<?isUnassigned>/, q{Match unanchored (Synonym for \p{Cn})} );

# Common          # Codepoint not explicitly assigned to a script


ok("\x[0C7E]" ~~ m/^<?isCommon>$/, q{Match (Codepoint not explicitly assigned to a script)} );
ok(!( "\x[0C7E]" ~~ m/^<!isCommon>.$/ ), q{Don't match negated (Codepoint not explicitly assigned to a script)} );
ok(!( "\x[0C7E]" ~~ m/^<-isCommon>$/ ), q{Don't match inverted (Codepoint not explicitly assigned to a script)} );
ok(!( "\c[KANNADA SIGN ANUSVARA]"  ~~ m/^<?isCommon>$/ ), q{Don't match unrelated (Codepoint not explicitly assigned to a script)} );
ok("\c[KANNADA SIGN ANUSVARA]"  ~~ m/^<!isCommon>.$/, q{Match unrelated negated (Codepoint not explicitly assigned to a script)} );
ok("\c[KANNADA SIGN ANUSVARA]"  ~~ m/^<-isCommon>$/, q{Match unrelated inverted (Codepoint not explicitly assigned to a script)} );
ok(!( "\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<?isCommon>$/ ), q{Don't match related (Codepoint not explicitly assigned to a script)} );
ok("\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<!isCommon>.$/, q{Match related negated (Codepoint not explicitly assigned to a script)} );
ok("\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<-isCommon>$/, q{Match related inverted (Codepoint not explicitly assigned to a script)} );
ok("\c[KANNADA SIGN ANUSVARA]\c[KHMER VOWEL INHERENT AQ]\x[0C7E]" ~~ m/<?isCommon>/, q{Match unanchored (Codepoint not explicitly assigned to a script)} );

# InAlphabeticPresentationForms


ok(!( "\x[531A]"  ~~ m/^<?isInAlphabeticPresentationForms>$/ ), q{Don't match unrelated <?isInAlphabeticPresentationForms>} );
ok("\x[531A]"  ~~ m/^<!isInAlphabeticPresentationForms>.$/, q{Match unrelated negated <?isInAlphabeticPresentationForms>} );
ok("\x[531A]"  ~~ m/^<-isInAlphabeticPresentationForms>$/, q{Match unrelated inverted <?isInAlphabeticPresentationForms>} );

# InArabic


ok("\c[ARABIC NUMBER SIGN]" ~~ m/^<?isInArabic>$/, q{Match <?isInArabic>} );
ok(!( "\c[ARABIC NUMBER SIGN]" ~~ m/^<!isInArabic>.$/ ), q{Don't match negated <?isInArabic>} );
ok(!( "\c[ARABIC NUMBER SIGN]" ~~ m/^<-isInArabic>$/ ), q{Don't match inverted <?isInArabic>} );
ok(!( "\x[7315]"  ~~ m/^<?isInArabic>$/ ), q{Don't match unrelated <?isInArabic>} );
ok("\x[7315]"  ~~ m/^<!isInArabic>.$/, q{Match unrelated negated <?isInArabic>} );
ok("\x[7315]"  ~~ m/^<-isInArabic>$/, q{Match unrelated inverted <?isInArabic>} );
ok("\x[7315]\c[ARABIC NUMBER SIGN]" ~~ m/<?isInArabic>/, q{Match unanchored <?isInArabic>} );

# InArabicPresentationFormsA


ok(!( "\x[8340]"  ~~ m/^<?isInArabicPresentationFormsA>$/ ), q{Don't match unrelated <?isInArabicPresentationFormsA>} );
ok("\x[8340]"  ~~ m/^<!isInArabicPresentationFormsA>.$/, q{Match unrelated negated <?isInArabicPresentationFormsA>} );
ok("\x[8340]"  ~~ m/^<-isInArabicPresentationFormsA>$/, q{Match unrelated inverted <?isInArabicPresentationFormsA>} );

# InArabicPresentationFormsB


ok(!( "\x[BEEC]"  ~~ m/^<?isInArabicPresentationFormsB>$/ ), q{Don't match unrelated <?isInArabicPresentationFormsB>} );
ok("\x[BEEC]"  ~~ m/^<!isInArabicPresentationFormsB>.$/, q{Match unrelated negated <?isInArabicPresentationFormsB>} );
ok("\x[BEEC]"  ~~ m/^<-isInArabicPresentationFormsB>$/, q{Match unrelated inverted <?isInArabicPresentationFormsB>} );

# InArmenian


ok("\x[0530]" ~~ m/^<?isInArmenian>$/, q{Match <?isInArmenian>} );
ok(!( "\x[0530]" ~~ m/^<!isInArmenian>.$/ ), q{Don't match negated <?isInArmenian>} );
ok(!( "\x[0530]" ~~ m/^<-isInArmenian>$/ ), q{Don't match inverted <?isInArmenian>} );
ok(!( "\x[3B0D]"  ~~ m/^<?isInArmenian>$/ ), q{Don't match unrelated <?isInArmenian>} );
ok("\x[3B0D]"  ~~ m/^<!isInArmenian>.$/, q{Match unrelated negated <?isInArmenian>} );
ok("\x[3B0D]"  ~~ m/^<-isInArmenian>$/, q{Match unrelated inverted <?isInArmenian>} );
ok("\x[3B0D]\x[0530]" ~~ m/<?isInArmenian>/, q{Match unanchored <?isInArmenian>} );

# InArrows


ok("\c[LEFTWARDS ARROW]" ~~ m/^<?isInArrows>$/, q{Match <?isInArrows>} );
ok(!( "\c[LEFTWARDS ARROW]" ~~ m/^<!isInArrows>.$/ ), q{Don't match negated <?isInArrows>} );
ok(!( "\c[LEFTWARDS ARROW]" ~~ m/^<-isInArrows>$/ ), q{Don't match inverted <?isInArrows>} );
ok(!( "\x[C401]"  ~~ m/^<?isInArrows>$/ ), q{Don't match unrelated <?isInArrows>} );
ok("\x[C401]"  ~~ m/^<!isInArrows>.$/, q{Match unrelated negated <?isInArrows>} );
ok("\x[C401]"  ~~ m/^<-isInArrows>$/, q{Match unrelated inverted <?isInArrows>} );
ok("\x[C401]\c[LEFTWARDS ARROW]" ~~ m/<?isInArrows>/, q{Match unanchored <?isInArrows>} );

# InBasicLatin


ok("\c[NULL]" ~~ m/^<?isInBasicLatin>$/, q{Match <?isInBasicLatin>} );
ok(!( "\c[NULL]" ~~ m/^<!isInBasicLatin>.$/ ), q{Don't match negated <?isInBasicLatin>} );
ok(!( "\c[NULL]" ~~ m/^<-isInBasicLatin>$/ ), q{Don't match inverted <?isInBasicLatin>} );
ok(!( "\x[46EA]"  ~~ m/^<?isInBasicLatin>$/ ), q{Don't match unrelated <?isInBasicLatin>} );
ok("\x[46EA]"  ~~ m/^<!isInBasicLatin>.$/, q{Match unrelated negated <?isInBasicLatin>} );
ok("\x[46EA]"  ~~ m/^<-isInBasicLatin>$/, q{Match unrelated inverted <?isInBasicLatin>} );
ok("\x[46EA]\c[NULL]" ~~ m/<?isInBasicLatin>/, q{Match unanchored <?isInBasicLatin>} );

# InBengali


ok("\x[0980]" ~~ m/^<?isInBengali>$/, q{Match <?isInBengali>} );
ok(!( "\x[0980]" ~~ m/^<!isInBengali>.$/ ), q{Don't match negated <?isInBengali>} );
ok(!( "\x[0980]" ~~ m/^<-isInBengali>$/ ), q{Don't match inverted <?isInBengali>} );
ok(!( "\c[YI SYLLABLE HMY]"  ~~ m/^<?isInBengali>$/ ), q{Don't match unrelated <?isInBengali>} );
ok("\c[YI SYLLABLE HMY]"  ~~ m/^<!isInBengali>.$/, q{Match unrelated negated <?isInBengali>} );
ok("\c[YI SYLLABLE HMY]"  ~~ m/^<-isInBengali>$/, q{Match unrelated inverted <?isInBengali>} );
ok("\c[YI SYLLABLE HMY]\x[0980]" ~~ m/<?isInBengali>/, q{Match unanchored <?isInBengali>} );

# InBlockElements


ok("\c[UPPER HALF BLOCK]" ~~ m/^<?isInBlockElements>$/, q{Match <?isInBlockElements>} );
ok(!( "\c[UPPER HALF BLOCK]" ~~ m/^<!isInBlockElements>.$/ ), q{Don't match negated <?isInBlockElements>} );
ok(!( "\c[UPPER HALF BLOCK]" ~~ m/^<-isInBlockElements>$/ ), q{Don't match inverted <?isInBlockElements>} );
ok(!( "\x[5F41]"  ~~ m/^<?isInBlockElements>$/ ), q{Don't match unrelated <?isInBlockElements>} );
ok("\x[5F41]"  ~~ m/^<!isInBlockElements>.$/, q{Match unrelated negated <?isInBlockElements>} );
ok("\x[5F41]"  ~~ m/^<-isInBlockElements>$/, q{Match unrelated inverted <?isInBlockElements>} );
ok("\x[5F41]\c[UPPER HALF BLOCK]" ~~ m/<?isInBlockElements>/, q{Match unanchored <?isInBlockElements>} );

# InBopomofo


ok("\x[3100]" ~~ m/^<?isInBopomofo>$/, q{Match <?isInBopomofo>} );
ok(!( "\x[3100]" ~~ m/^<!isInBopomofo>.$/ ), q{Don't match negated <?isInBopomofo>} );
ok(!( "\x[3100]" ~~ m/^<-isInBopomofo>$/ ), q{Don't match inverted <?isInBopomofo>} );
ok(!( "\x[9F8E]"  ~~ m/^<?isInBopomofo>$/ ), q{Don't match unrelated <?isInBopomofo>} );
ok("\x[9F8E]"  ~~ m/^<!isInBopomofo>.$/, q{Match unrelated negated <?isInBopomofo>} );
ok("\x[9F8E]"  ~~ m/^<-isInBopomofo>$/, q{Match unrelated inverted <?isInBopomofo>} );
ok("\x[9F8E]\x[3100]" ~~ m/<?isInBopomofo>/, q{Match unanchored <?isInBopomofo>} );

# InBopomofoExtended


ok("\c[BOPOMOFO LETTER BU]" ~~ m/^<?isInBopomofoExtended>$/, q{Match <?isInBopomofoExtended>} );
ok(!( "\c[BOPOMOFO LETTER BU]" ~~ m/^<!isInBopomofoExtended>.$/ ), q{Don't match negated <?isInBopomofoExtended>} );
ok(!( "\c[BOPOMOFO LETTER BU]" ~~ m/^<-isInBopomofoExtended>$/ ), q{Don't match inverted <?isInBopomofoExtended>} );
ok(!( "\x[43A6]"  ~~ m/^<?isInBopomofoExtended>$/ ), q{Don't match unrelated <?isInBopomofoExtended>} );
ok("\x[43A6]"  ~~ m/^<!isInBopomofoExtended>.$/, q{Match unrelated negated <?isInBopomofoExtended>} );
ok("\x[43A6]"  ~~ m/^<-isInBopomofoExtended>$/, q{Match unrelated inverted <?isInBopomofoExtended>} );
ok("\x[43A6]\c[BOPOMOFO LETTER BU]" ~~ m/<?isInBopomofoExtended>/, q{Match unanchored <?isInBopomofoExtended>} );

# InBoxDrawing


ok("\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/^<?isInBoxDrawing>$/, q{Match <?isInBoxDrawing>} );
ok(!( "\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/^<!isInBoxDrawing>.$/ ), q{Don't match negated <?isInBoxDrawing>} );
ok(!( "\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/^<-isInBoxDrawing>$/ ), q{Don't match inverted <?isInBoxDrawing>} );
ok(!( "\x[7865]"  ~~ m/^<?isInBoxDrawing>$/ ), q{Don't match unrelated <?isInBoxDrawing>} );
ok("\x[7865]"  ~~ m/^<!isInBoxDrawing>.$/, q{Match unrelated negated <?isInBoxDrawing>} );
ok("\x[7865]"  ~~ m/^<-isInBoxDrawing>$/, q{Match unrelated inverted <?isInBoxDrawing>} );
ok("\x[7865]\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/<?isInBoxDrawing>/, q{Match unanchored <?isInBoxDrawing>} );

# InBraillePatterns


ok("\c[BRAILLE PATTERN BLANK]" ~~ m/^<?isInBraillePatterns>$/, q{Match <?isInBraillePatterns>} );
ok(!( "\c[BRAILLE PATTERN BLANK]" ~~ m/^<!isInBraillePatterns>.$/ ), q{Don't match negated <?isInBraillePatterns>} );
ok(!( "\c[BRAILLE PATTERN BLANK]" ~~ m/^<-isInBraillePatterns>$/ ), q{Don't match inverted <?isInBraillePatterns>} );
ok(!( "\c[THAI CHARACTER KHO KHAI]"  ~~ m/^<?isInBraillePatterns>$/ ), q{Don't match unrelated <?isInBraillePatterns>} );
ok("\c[THAI CHARACTER KHO KHAI]"  ~~ m/^<!isInBraillePatterns>.$/, q{Match unrelated negated <?isInBraillePatterns>} );
ok("\c[THAI CHARACTER KHO KHAI]"  ~~ m/^<-isInBraillePatterns>$/, q{Match unrelated inverted <?isInBraillePatterns>} );
ok("\c[THAI CHARACTER KHO KHAI]\c[BRAILLE PATTERN BLANK]" ~~ m/<?isInBraillePatterns>/, q{Match unanchored <?isInBraillePatterns>} );

# InBuhid


ok("\c[BUHID LETTER A]" ~~ m/^<?isInBuhid>$/, q{Match <?isInBuhid>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<!isInBuhid>.$/ ), q{Don't match negated <?isInBuhid>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<-isInBuhid>$/ ), q{Don't match inverted <?isInBuhid>} );
ok(!( "\x[D208]"  ~~ m/^<?isInBuhid>$/ ), q{Don't match unrelated <?isInBuhid>} );
ok("\x[D208]"  ~~ m/^<!isInBuhid>.$/, q{Match unrelated negated <?isInBuhid>} );
ok("\x[D208]"  ~~ m/^<-isInBuhid>$/, q{Match unrelated inverted <?isInBuhid>} );
ok("\x[D208]\c[BUHID LETTER A]" ~~ m/<?isInBuhid>/, q{Match unanchored <?isInBuhid>} );

# InByzantineMusicalSymbols


ok(!( "\x[9B1D]"  ~~ m/^<?isInByzantineMusicalSymbols>$/ ), q{Don't match unrelated <?isInByzantineMusicalSymbols>} );
ok("\x[9B1D]"  ~~ m/^<!isInByzantineMusicalSymbols>.$/, q{Match unrelated negated <?isInByzantineMusicalSymbols>} );
ok("\x[9B1D]"  ~~ m/^<-isInByzantineMusicalSymbols>$/, q{Match unrelated inverted <?isInByzantineMusicalSymbols>} );

# InCJKCompatibility


ok("\c[SQUARE APAATO]" ~~ m/^<?isInCJKCompatibility>$/, q{Match <?isInCJKCompatibility>} );
ok(!( "\c[SQUARE APAATO]" ~~ m/^<!isInCJKCompatibility>.$/ ), q{Don't match negated <?isInCJKCompatibility>} );
ok(!( "\c[SQUARE APAATO]" ~~ m/^<-isInCJKCompatibility>$/ ), q{Don't match inverted <?isInCJKCompatibility>} );
ok(!( "\x[B8A5]"  ~~ m/^<?isInCJKCompatibility>$/ ), q{Don't match unrelated <?isInCJKCompatibility>} );
ok("\x[B8A5]"  ~~ m/^<!isInCJKCompatibility>.$/, q{Match unrelated negated <?isInCJKCompatibility>} );
ok("\x[B8A5]"  ~~ m/^<-isInCJKCompatibility>$/, q{Match unrelated inverted <?isInCJKCompatibility>} );
ok("\x[B8A5]\c[SQUARE APAATO]" ~~ m/<?isInCJKCompatibility>/, q{Match unanchored <?isInCJKCompatibility>} );

# InCJKCompatibilityForms


ok(!( "\x[3528]"  ~~ m/^<?isInCJKCompatibilityForms>$/ ), q{Don't match unrelated <?isInCJKCompatibilityForms>} );
ok("\x[3528]"  ~~ m/^<!isInCJKCompatibilityForms>.$/, q{Match unrelated negated <?isInCJKCompatibilityForms>} );
ok("\x[3528]"  ~~ m/^<-isInCJKCompatibilityForms>$/, q{Match unrelated inverted <?isInCJKCompatibilityForms>} );

# InCJKCompatibilityIdeographs


ok(!( "\x[69F7]"  ~~ m/^<?isInCJKCompatibilityIdeographs>$/ ), q{Don't match unrelated <?isInCJKCompatibilityIdeographs>} );
ok("\x[69F7]"  ~~ m/^<!isInCJKCompatibilityIdeographs>.$/, q{Match unrelated negated <?isInCJKCompatibilityIdeographs>} );
ok("\x[69F7]"  ~~ m/^<-isInCJKCompatibilityIdeographs>$/, q{Match unrelated inverted <?isInCJKCompatibilityIdeographs>} );

# InCJKCompatibilityIdeographsSupplement


ok(!( "\c[CANADIAN SYLLABICS NUNAVIK HO]"  ~~ m/^<?isInCJKCompatibilityIdeographsSupplement>$/ ), q{Don't match unrelated <?isInCJKCompatibilityIdeographsSupplement>} );
ok("\c[CANADIAN SYLLABICS NUNAVIK HO]"  ~~ m/^<!isInCJKCompatibilityIdeographsSupplement>.$/, q{Match unrelated negated <?isInCJKCompatibilityIdeographsSupplement>} );
ok("\c[CANADIAN SYLLABICS NUNAVIK HO]"  ~~ m/^<-isInCJKCompatibilityIdeographsSupplement>$/, q{Match unrelated inverted <?isInCJKCompatibilityIdeographsSupplement>} );

# InCJKRadicalsSupplement


ok("\c[CJK RADICAL REPEAT]" ~~ m/^<?isInCJKRadicalsSupplement>$/, q{Match <?isInCJKRadicalsSupplement>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<!isInCJKRadicalsSupplement>.$/ ), q{Don't match negated <?isInCJKRadicalsSupplement>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<-isInCJKRadicalsSupplement>$/ ), q{Don't match inverted <?isInCJKRadicalsSupplement>} );
ok(!( "\x[37B4]"  ~~ m/^<?isInCJKRadicalsSupplement>$/ ), q{Don't match unrelated <?isInCJKRadicalsSupplement>} );
ok("\x[37B4]"  ~~ m/^<!isInCJKRadicalsSupplement>.$/, q{Match unrelated negated <?isInCJKRadicalsSupplement>} );
ok("\x[37B4]"  ~~ m/^<-isInCJKRadicalsSupplement>$/, q{Match unrelated inverted <?isInCJKRadicalsSupplement>} );
ok("\x[37B4]\c[CJK RADICAL REPEAT]" ~~ m/<?isInCJKRadicalsSupplement>/, q{Match unanchored <?isInCJKRadicalsSupplement>} );

# InCJKSymbolsAndPunctuation


ok("\c[IDEOGRAPHIC SPACE]" ~~ m/^<?isInCJKSymbolsAndPunctuation>$/, q{Match <?isInCJKSymbolsAndPunctuation>} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<!isInCJKSymbolsAndPunctuation>.$/ ), q{Don't match negated <?isInCJKSymbolsAndPunctuation>} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<-isInCJKSymbolsAndPunctuation>$/ ), q{Don't match inverted <?isInCJKSymbolsAndPunctuation>} );
ok(!( "\x[80AA]"  ~~ m/^<?isInCJKSymbolsAndPunctuation>$/ ), q{Don't match unrelated <?isInCJKSymbolsAndPunctuation>} );
ok("\x[80AA]"  ~~ m/^<!isInCJKSymbolsAndPunctuation>.$/, q{Match unrelated negated <?isInCJKSymbolsAndPunctuation>} );
ok("\x[80AA]"  ~~ m/^<-isInCJKSymbolsAndPunctuation>$/, q{Match unrelated inverted <?isInCJKSymbolsAndPunctuation>} );
ok("\x[80AA]\c[IDEOGRAPHIC SPACE]" ~~ m/<?isInCJKSymbolsAndPunctuation>/, q{Match unanchored <?isInCJKSymbolsAndPunctuation>} );

# InCJKUnifiedIdeographs


ok("\x[4E00]" ~~ m/^<?isInCJKUnifiedIdeographs>$/, q{Match <?isInCJKUnifiedIdeographs>} );
ok(!( "\x[4E00]" ~~ m/^<!isInCJKUnifiedIdeographs>.$/ ), q{Don't match negated <?isInCJKUnifiedIdeographs>} );
ok(!( "\x[4E00]" ~~ m/^<-isInCJKUnifiedIdeographs>$/ ), q{Don't match inverted <?isInCJKUnifiedIdeographs>} );
ok(!( "\x[3613]"  ~~ m/^<?isInCJKUnifiedIdeographs>$/ ), q{Don't match unrelated <?isInCJKUnifiedIdeographs>} );
ok("\x[3613]"  ~~ m/^<!isInCJKUnifiedIdeographs>.$/, q{Match unrelated negated <?isInCJKUnifiedIdeographs>} );
ok("\x[3613]"  ~~ m/^<-isInCJKUnifiedIdeographs>$/, q{Match unrelated inverted <?isInCJKUnifiedIdeographs>} );
ok("\x[3613]\x[4E00]" ~~ m/<?isInCJKUnifiedIdeographs>/, q{Match unanchored <?isInCJKUnifiedIdeographs>} );

# InCJKUnifiedIdeographsExtensionA


ok("\x[3400]" ~~ m/^<?isInCJKUnifiedIdeographsExtensionA>$/, q{Match <?isInCJKUnifiedIdeographsExtensionA>} );
ok(!( "\x[3400]" ~~ m/^<!isInCJKUnifiedIdeographsExtensionA>.$/ ), q{Don't match negated <?isInCJKUnifiedIdeographsExtensionA>} );
ok(!( "\x[3400]" ~~ m/^<-isInCJKUnifiedIdeographsExtensionA>$/ ), q{Don't match inverted <?isInCJKUnifiedIdeographsExtensionA>} );
ok(!( "\c[SQUARE HOORU]"  ~~ m/^<?isInCJKUnifiedIdeographsExtensionA>$/ ), q{Don't match unrelated <?isInCJKUnifiedIdeographsExtensionA>} );
ok("\c[SQUARE HOORU]"  ~~ m/^<!isInCJKUnifiedIdeographsExtensionA>.$/, q{Match unrelated negated <?isInCJKUnifiedIdeographsExtensionA>} );
ok("\c[SQUARE HOORU]"  ~~ m/^<-isInCJKUnifiedIdeographsExtensionA>$/, q{Match unrelated inverted <?isInCJKUnifiedIdeographsExtensionA>} );
ok("\c[SQUARE HOORU]\x[3400]" ~~ m/<?isInCJKUnifiedIdeographsExtensionA>/, q{Match unanchored <?isInCJKUnifiedIdeographsExtensionA>} );

# InCJKUnifiedIdeographsExtensionB


ok(!( "\x[AC3B]"  ~~ m/^<?isInCJKUnifiedIdeographsExtensionB>$/ ), q{Don't match unrelated <?isInCJKUnifiedIdeographsExtensionB>} );
ok("\x[AC3B]"  ~~ m/^<!isInCJKUnifiedIdeographsExtensionB>.$/, q{Match unrelated negated <?isInCJKUnifiedIdeographsExtensionB>} );
ok("\x[AC3B]"  ~~ m/^<-isInCJKUnifiedIdeographsExtensionB>$/, q{Match unrelated inverted <?isInCJKUnifiedIdeographsExtensionB>} );

# InCherokee


ok("\c[CHEROKEE LETTER A]" ~~ m/^<?isInCherokee>$/, q{Match <?isInCherokee>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<!isInCherokee>.$/ ), q{Don't match negated <?isInCherokee>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<-isInCherokee>$/ ), q{Don't match inverted <?isInCherokee>} );
ok(!( "\x[985F]"  ~~ m/^<?isInCherokee>$/ ), q{Don't match unrelated <?isInCherokee>} );
ok("\x[985F]"  ~~ m/^<!isInCherokee>.$/, q{Match unrelated negated <?isInCherokee>} );
ok("\x[985F]"  ~~ m/^<-isInCherokee>$/, q{Match unrelated inverted <?isInCherokee>} );
ok("\x[985F]\c[CHEROKEE LETTER A]" ~~ m/<?isInCherokee>/, q{Match unanchored <?isInCherokee>} );

# InCombiningDiacriticalMarks


ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<?isInCombiningDiacriticalMarks>$/, q{Match <?isInCombiningDiacriticalMarks>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isInCombiningDiacriticalMarks>.$/ ), q{Don't match negated <?isInCombiningDiacriticalMarks>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isInCombiningDiacriticalMarks>$/ ), q{Don't match inverted <?isInCombiningDiacriticalMarks>} );
ok(!( "\x[76DA]"  ~~ m/^<?isInCombiningDiacriticalMarks>$/ ), q{Don't match unrelated <?isInCombiningDiacriticalMarks>} );
ok("\x[76DA]"  ~~ m/^<!isInCombiningDiacriticalMarks>.$/, q{Match unrelated negated <?isInCombiningDiacriticalMarks>} );
ok("\x[76DA]"  ~~ m/^<-isInCombiningDiacriticalMarks>$/, q{Match unrelated inverted <?isInCombiningDiacriticalMarks>} );
ok("\x[76DA]\c[COMBINING GRAVE ACCENT]" ~~ m/<?isInCombiningDiacriticalMarks>/, q{Match unanchored <?isInCombiningDiacriticalMarks>} );

# InCombiningDiacriticalMarksforSymbols


ok("\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/^<?isInCombiningDiacriticalMarksforSymbols>$/, q{Match <?isInCombiningDiacriticalMarksforSymbols>} );
ok(!( "\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/^<!isInCombiningDiacriticalMarksforSymbols>.$/ ), q{Don't match negated <?isInCombiningDiacriticalMarksforSymbols>} );
ok(!( "\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/^<-isInCombiningDiacriticalMarksforSymbols>$/ ), q{Don't match inverted <?isInCombiningDiacriticalMarksforSymbols>} );
ok(!( "\x[7345]"  ~~ m/^<?isInCombiningDiacriticalMarksforSymbols>$/ ), q{Don't match unrelated <?isInCombiningDiacriticalMarksforSymbols>} );
ok("\x[7345]"  ~~ m/^<!isInCombiningDiacriticalMarksforSymbols>.$/, q{Match unrelated negated <?isInCombiningDiacriticalMarksforSymbols>} );
ok("\x[7345]"  ~~ m/^<-isInCombiningDiacriticalMarksforSymbols>$/, q{Match unrelated inverted <?isInCombiningDiacriticalMarksforSymbols>} );
ok("\x[7345]\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/<?isInCombiningDiacriticalMarksforSymbols>/, q{Match unanchored <?isInCombiningDiacriticalMarksforSymbols>} );

# InCombiningHalfMarks


ok(!( "\x[6C2E]"  ~~ m/^<?isInCombiningHalfMarks>$/ ), q{Don't match unrelated <?isInCombiningHalfMarks>} );
ok("\x[6C2E]"  ~~ m/^<!isInCombiningHalfMarks>.$/, q{Match unrelated negated <?isInCombiningHalfMarks>} );
ok("\x[6C2E]"  ~~ m/^<-isInCombiningHalfMarks>$/, q{Match unrelated inverted <?isInCombiningHalfMarks>} );

# InControlPictures


ok("\c[SYMBOL FOR NULL]" ~~ m/^<?isInControlPictures>$/, q{Match <?isInControlPictures>} );
ok(!( "\c[SYMBOL FOR NULL]" ~~ m/^<!isInControlPictures>.$/ ), q{Don't match negated <?isInControlPictures>} );
ok(!( "\c[SYMBOL FOR NULL]" ~~ m/^<-isInControlPictures>$/ ), q{Don't match inverted <?isInControlPictures>} );
ok(!( "\x[BCE2]"  ~~ m/^<?isInControlPictures>$/ ), q{Don't match unrelated <?isInControlPictures>} );
ok("\x[BCE2]"  ~~ m/^<!isInControlPictures>.$/, q{Match unrelated negated <?isInControlPictures>} );
ok("\x[BCE2]"  ~~ m/^<-isInControlPictures>$/, q{Match unrelated inverted <?isInControlPictures>} );
ok("\x[BCE2]\c[SYMBOL FOR NULL]" ~~ m/<?isInControlPictures>/, q{Match unanchored <?isInControlPictures>} );

# InCurrencySymbols


ok("\c[EURO-CURRENCY SIGN]" ~~ m/^<?isInCurrencySymbols>$/, q{Match <?isInCurrencySymbols>} );
ok(!( "\c[EURO-CURRENCY SIGN]" ~~ m/^<!isInCurrencySymbols>.$/ ), q{Don't match negated <?isInCurrencySymbols>} );
ok(!( "\c[EURO-CURRENCY SIGN]" ~~ m/^<-isInCurrencySymbols>$/ ), q{Don't match inverted <?isInCurrencySymbols>} );
ok(!( "\x[8596]"  ~~ m/^<?isInCurrencySymbols>$/ ), q{Don't match unrelated <?isInCurrencySymbols>} );
ok("\x[8596]"  ~~ m/^<!isInCurrencySymbols>.$/, q{Match unrelated negated <?isInCurrencySymbols>} );
ok("\x[8596]"  ~~ m/^<-isInCurrencySymbols>$/, q{Match unrelated inverted <?isInCurrencySymbols>} );
ok("\x[8596]\c[EURO-CURRENCY SIGN]" ~~ m/<?isInCurrencySymbols>/, q{Match unanchored <?isInCurrencySymbols>} );

# InCyrillic


ok("\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<?isInCyrillic>$/, q{Match <?isInCyrillic>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<!isInCyrillic>.$/ ), q{Don't match negated <?isInCyrillic>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<-isInCyrillic>$/ ), q{Don't match inverted <?isInCyrillic>} );
ok(!( "\x[51B2]"  ~~ m/^<?isInCyrillic>$/ ), q{Don't match unrelated <?isInCyrillic>} );
ok("\x[51B2]"  ~~ m/^<!isInCyrillic>.$/, q{Match unrelated negated <?isInCyrillic>} );
ok("\x[51B2]"  ~~ m/^<-isInCyrillic>$/, q{Match unrelated inverted <?isInCyrillic>} );
ok("\x[51B2]\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/<?isInCyrillic>/, q{Match unanchored <?isInCyrillic>} );

# InCyrillicSupplementary


ok("\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/^<?isInCyrillicSupplementary>$/, q{Match <?isInCyrillicSupplementary>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/^<!isInCyrillicSupplementary>.$/ ), q{Don't match negated <?isInCyrillicSupplementary>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/^<-isInCyrillicSupplementary>$/ ), q{Don't match inverted <?isInCyrillicSupplementary>} );
ok(!( "\x[7BD9]"  ~~ m/^<?isInCyrillicSupplementary>$/ ), q{Don't match unrelated <?isInCyrillicSupplementary>} );
ok("\x[7BD9]"  ~~ m/^<!isInCyrillicSupplementary>.$/, q{Match unrelated negated <?isInCyrillicSupplementary>} );
ok("\x[7BD9]"  ~~ m/^<-isInCyrillicSupplementary>$/, q{Match unrelated inverted <?isInCyrillicSupplementary>} );
ok("\x[7BD9]\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/<?isInCyrillicSupplementary>/, q{Match unanchored <?isInCyrillicSupplementary>} );

# InDeseret


ok(!( "\c[TAMIL DIGIT FOUR]"  ~~ m/^<?isInDeseret>$/ ), q{Don't match unrelated <?isInDeseret>} );
ok("\c[TAMIL DIGIT FOUR]"  ~~ m/^<!isInDeseret>.$/, q{Match unrelated negated <?isInDeseret>} );
ok("\c[TAMIL DIGIT FOUR]"  ~~ m/^<-isInDeseret>$/, q{Match unrelated inverted <?isInDeseret>} );

# InDevanagari


ok("\x[0900]" ~~ m/^<?isInDevanagari>$/, q{Match <?isInDevanagari>} );
ok(!( "\x[0900]" ~~ m/^<!isInDevanagari>.$/ ), q{Don't match negated <?isInDevanagari>} );
ok(!( "\x[0900]" ~~ m/^<-isInDevanagari>$/ ), q{Don't match inverted <?isInDevanagari>} );
ok(!( "\x[BB12]"  ~~ m/^<?isInDevanagari>$/ ), q{Don't match unrelated <?isInDevanagari>} );
ok("\x[BB12]"  ~~ m/^<!isInDevanagari>.$/, q{Match unrelated negated <?isInDevanagari>} );
ok("\x[BB12]"  ~~ m/^<-isInDevanagari>$/, q{Match unrelated inverted <?isInDevanagari>} );
ok("\x[BB12]\x[0900]" ~~ m/<?isInDevanagari>/, q{Match unanchored <?isInDevanagari>} );

# InDingbats


ok("\x[2700]" ~~ m/^<?isInDingbats>$/, q{Match <?isInDingbats>} );
ok(!( "\x[2700]" ~~ m/^<!isInDingbats>.$/ ), q{Don't match negated <?isInDingbats>} );
ok(!( "\x[2700]" ~~ m/^<-isInDingbats>$/ ), q{Don't match inverted <?isInDingbats>} );
ok(!( "\x[D7A8]"  ~~ m/^<?isInDingbats>$/ ), q{Don't match unrelated <?isInDingbats>} );
ok("\x[D7A8]"  ~~ m/^<!isInDingbats>.$/, q{Match unrelated negated <?isInDingbats>} );
ok("\x[D7A8]"  ~~ m/^<-isInDingbats>$/, q{Match unrelated inverted <?isInDingbats>} );
ok("\x[D7A8]\x[2700]" ~~ m/<?isInDingbats>/, q{Match unanchored <?isInDingbats>} );

# InEnclosedAlphanumerics


ok("\c[CIRCLED DIGIT ONE]" ~~ m/^<?isInEnclosedAlphanumerics>$/, q{Match <?isInEnclosedAlphanumerics>} );
ok(!( "\c[CIRCLED DIGIT ONE]" ~~ m/^<!isInEnclosedAlphanumerics>.$/ ), q{Don't match negated <?isInEnclosedAlphanumerics>} );
ok(!( "\c[CIRCLED DIGIT ONE]" ~~ m/^<-isInEnclosedAlphanumerics>$/ ), q{Don't match inverted <?isInEnclosedAlphanumerics>} );
ok(!( "\x[C3A2]"  ~~ m/^<?isInEnclosedAlphanumerics>$/ ), q{Don't match unrelated <?isInEnclosedAlphanumerics>} );
ok("\x[C3A2]"  ~~ m/^<!isInEnclosedAlphanumerics>.$/, q{Match unrelated negated <?isInEnclosedAlphanumerics>} );
ok("\x[C3A2]"  ~~ m/^<-isInEnclosedAlphanumerics>$/, q{Match unrelated inverted <?isInEnclosedAlphanumerics>} );
ok("\x[C3A2]\c[CIRCLED DIGIT ONE]" ~~ m/<?isInEnclosedAlphanumerics>/, q{Match unanchored <?isInEnclosedAlphanumerics>} );

# InEnclosedCJKLettersAndMonths


ok("\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/^<?isInEnclosedCJKLettersAndMonths>$/, q{Match <?isInEnclosedCJKLettersAndMonths>} );
ok(!( "\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/^<!isInEnclosedCJKLettersAndMonths>.$/ ), q{Don't match negated <?isInEnclosedCJKLettersAndMonths>} );
ok(!( "\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/^<-isInEnclosedCJKLettersAndMonths>$/ ), q{Don't match inverted <?isInEnclosedCJKLettersAndMonths>} );
ok(!( "\x[5B44]"  ~~ m/^<?isInEnclosedCJKLettersAndMonths>$/ ), q{Don't match unrelated <?isInEnclosedCJKLettersAndMonths>} );
ok("\x[5B44]"  ~~ m/^<!isInEnclosedCJKLettersAndMonths>.$/, q{Match unrelated negated <?isInEnclosedCJKLettersAndMonths>} );
ok("\x[5B44]"  ~~ m/^<-isInEnclosedCJKLettersAndMonths>$/, q{Match unrelated inverted <?isInEnclosedCJKLettersAndMonths>} );
ok("\x[5B44]\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/<?isInEnclosedCJKLettersAndMonths>/, q{Match unanchored <?isInEnclosedCJKLettersAndMonths>} );

# InEthiopic


ok("\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<?isInEthiopic>$/, q{Match <?isInEthiopic>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<!isInEthiopic>.$/ ), q{Don't match negated <?isInEthiopic>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<-isInEthiopic>$/ ), q{Don't match inverted <?isInEthiopic>} );
ok(!( "\x[BBAE]"  ~~ m/^<?isInEthiopic>$/ ), q{Don't match unrelated <?isInEthiopic>} );
ok("\x[BBAE]"  ~~ m/^<!isInEthiopic>.$/, q{Match unrelated negated <?isInEthiopic>} );
ok("\x[BBAE]"  ~~ m/^<-isInEthiopic>$/, q{Match unrelated inverted <?isInEthiopic>} );
ok("\x[BBAE]\c[ETHIOPIC SYLLABLE HA]" ~~ m/<?isInEthiopic>/, q{Match unanchored <?isInEthiopic>} );

# InGeneralPunctuation


ok("\c[EN QUAD]" ~~ m/^<?isInGeneralPunctuation>$/, q{Match <?isInGeneralPunctuation>} );
ok(!( "\c[EN QUAD]" ~~ m/^<!isInGeneralPunctuation>.$/ ), q{Don't match negated <?isInGeneralPunctuation>} );
ok(!( "\c[EN QUAD]" ~~ m/^<-isInGeneralPunctuation>$/ ), q{Don't match inverted <?isInGeneralPunctuation>} );
ok(!( "\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]"  ~~ m/^<?isInGeneralPunctuation>$/ ), q{Don't match unrelated <?isInGeneralPunctuation>} );
ok("\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]"  ~~ m/^<!isInGeneralPunctuation>.$/, q{Match unrelated negated <?isInGeneralPunctuation>} );
ok("\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]"  ~~ m/^<-isInGeneralPunctuation>$/, q{Match unrelated inverted <?isInGeneralPunctuation>} );
ok("\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]\c[EN QUAD]" ~~ m/<?isInGeneralPunctuation>/, q{Match unanchored <?isInGeneralPunctuation>} );

# InGeometricShapes


ok("\c[BLACK SQUARE]" ~~ m/^<?isInGeometricShapes>$/, q{Match <?isInGeometricShapes>} );
ok(!( "\c[BLACK SQUARE]" ~~ m/^<!isInGeometricShapes>.$/ ), q{Don't match negated <?isInGeometricShapes>} );
ok(!( "\c[BLACK SQUARE]" ~~ m/^<-isInGeometricShapes>$/ ), q{Don't match inverted <?isInGeometricShapes>} );
ok(!( "\x[B700]"  ~~ m/^<?isInGeometricShapes>$/ ), q{Don't match unrelated <?isInGeometricShapes>} );
ok("\x[B700]"  ~~ m/^<!isInGeometricShapes>.$/, q{Match unrelated negated <?isInGeometricShapes>} );
ok("\x[B700]"  ~~ m/^<-isInGeometricShapes>$/, q{Match unrelated inverted <?isInGeometricShapes>} );
ok("\x[B700]\c[BLACK SQUARE]" ~~ m/<?isInGeometricShapes>/, q{Match unanchored <?isInGeometricShapes>} );

# InGeorgian


ok("\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<?isInGeorgian>$/, q{Match <?isInGeorgian>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<!isInGeorgian>.$/ ), q{Don't match negated <?isInGeorgian>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<-isInGeorgian>$/ ), q{Don't match inverted <?isInGeorgian>} );
ok(!( "\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]"  ~~ m/^<?isInGeorgian>$/ ), q{Don't match unrelated <?isInGeorgian>} );
ok("\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]"  ~~ m/^<!isInGeorgian>.$/, q{Match unrelated negated <?isInGeorgian>} );
ok("\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]"  ~~ m/^<-isInGeorgian>$/, q{Match unrelated inverted <?isInGeorgian>} );
ok("\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/<?isInGeorgian>/, q{Match unanchored <?isInGeorgian>} );

# InGothic


ok(!( "\x[4825]"  ~~ m/^<?isInGothic>$/ ), q{Don't match unrelated <?isInGothic>} );
ok("\x[4825]"  ~~ m/^<!isInGothic>.$/, q{Match unrelated negated <?isInGothic>} );
ok("\x[4825]"  ~~ m/^<-isInGothic>$/, q{Match unrelated inverted <?isInGothic>} );

# InGreekExtended


ok("\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/^<?isInGreekExtended>$/, q{Match <?isInGreekExtended>} );
ok(!( "\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/^<!isInGreekExtended>.$/ ), q{Don't match negated <?isInGreekExtended>} );
ok(!( "\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/^<-isInGreekExtended>$/ ), q{Don't match inverted <?isInGreekExtended>} );
ok(!( "\x[B9B7]"  ~~ m/^<?isInGreekExtended>$/ ), q{Don't match unrelated <?isInGreekExtended>} );
ok("\x[B9B7]"  ~~ m/^<!isInGreekExtended>.$/, q{Match unrelated negated <?isInGreekExtended>} );
ok("\x[B9B7]"  ~~ m/^<-isInGreekExtended>$/, q{Match unrelated inverted <?isInGreekExtended>} );
ok("\x[B9B7]\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/<?isInGreekExtended>/, q{Match unanchored <?isInGreekExtended>} );

# InGreekAndCoptic


ok("\x[0370]" ~~ m/^<?isInGreekAndCoptic>$/, q{Match <?isInGreekAndCoptic>} );
ok(!( "\x[0370]" ~~ m/^<!isInGreekAndCoptic>.$/ ), q{Don't match negated <?isInGreekAndCoptic>} );
ok(!( "\x[0370]" ~~ m/^<-isInGreekAndCoptic>$/ ), q{Don't match inverted <?isInGreekAndCoptic>} );
ok(!( "\x[7197]"  ~~ m/^<?isInGreekAndCoptic>$/ ), q{Don't match unrelated <?isInGreekAndCoptic>} );
ok("\x[7197]"  ~~ m/^<!isInGreekAndCoptic>.$/, q{Match unrelated negated <?isInGreekAndCoptic>} );
ok("\x[7197]"  ~~ m/^<-isInGreekAndCoptic>$/, q{Match unrelated inverted <?isInGreekAndCoptic>} );
ok("\x[7197]\x[0370]" ~~ m/<?isInGreekAndCoptic>/, q{Match unanchored <?isInGreekAndCoptic>} );

# InGujarati


ok("\x[0A80]" ~~ m/^<?isInGujarati>$/, q{Match <?isInGujarati>} );
ok(!( "\x[0A80]" ~~ m/^<!isInGujarati>.$/ ), q{Don't match negated <?isInGujarati>} );
ok(!( "\x[0A80]" ~~ m/^<-isInGujarati>$/ ), q{Don't match inverted <?isInGujarati>} );
ok(!( "\x[3B63]"  ~~ m/^<?isInGujarati>$/ ), q{Don't match unrelated <?isInGujarati>} );
ok("\x[3B63]"  ~~ m/^<!isInGujarati>.$/, q{Match unrelated negated <?isInGujarati>} );
ok("\x[3B63]"  ~~ m/^<-isInGujarati>$/, q{Match unrelated inverted <?isInGujarati>} );
ok("\x[3B63]\x[0A80]" ~~ m/<?isInGujarati>/, q{Match unanchored <?isInGujarati>} );

# InGurmukhi


ok("\x[0A00]" ~~ m/^<?isInGurmukhi>$/, q{Match <?isInGurmukhi>} );
ok(!( "\x[0A00]" ~~ m/^<!isInGurmukhi>.$/ ), q{Don't match negated <?isInGurmukhi>} );
ok(!( "\x[0A00]" ~~ m/^<-isInGurmukhi>$/ ), q{Don't match inverted <?isInGurmukhi>} );
ok(!( "\x[10C8]"  ~~ m/^<?isInGurmukhi>$/ ), q{Don't match unrelated <?isInGurmukhi>} );
ok("\x[10C8]"  ~~ m/^<!isInGurmukhi>.$/, q{Match unrelated negated <?isInGurmukhi>} );
ok("\x[10C8]"  ~~ m/^<-isInGurmukhi>$/, q{Match unrelated inverted <?isInGurmukhi>} );
ok("\x[10C8]\x[0A00]" ~~ m/<?isInGurmukhi>/, q{Match unanchored <?isInGurmukhi>} );

# InHalfwidthAndFullwidthForms


ok(!( "\x[CA55]"  ~~ m/^<?isInHalfwidthAndFullwidthForms>$/ ), q{Don't match unrelated <?isInHalfwidthAndFullwidthForms>} );
ok("\x[CA55]"  ~~ m/^<!isInHalfwidthAndFullwidthForms>.$/, q{Match unrelated negated <?isInHalfwidthAndFullwidthForms>} );
ok("\x[CA55]"  ~~ m/^<-isInHalfwidthAndFullwidthForms>$/, q{Match unrelated inverted <?isInHalfwidthAndFullwidthForms>} );

# InHangulCompatibilityJamo


ok("\x[3130]" ~~ m/^<?isInHangulCompatibilityJamo>$/, q{Match <?isInHangulCompatibilityJamo>} );
ok(!( "\x[3130]" ~~ m/^<!isInHangulCompatibilityJamo>.$/ ), q{Don't match negated <?isInHangulCompatibilityJamo>} );
ok(!( "\x[3130]" ~~ m/^<-isInHangulCompatibilityJamo>$/ ), q{Don't match inverted <?isInHangulCompatibilityJamo>} );
ok(!( "\c[MEASURED BY]"  ~~ m/^<?isInHangulCompatibilityJamo>$/ ), q{Don't match unrelated <?isInHangulCompatibilityJamo>} );
ok("\c[MEASURED BY]"  ~~ m/^<!isInHangulCompatibilityJamo>.$/, q{Match unrelated negated <?isInHangulCompatibilityJamo>} );
ok("\c[MEASURED BY]"  ~~ m/^<-isInHangulCompatibilityJamo>$/, q{Match unrelated inverted <?isInHangulCompatibilityJamo>} );
ok("\c[MEASURED BY]\x[3130]" ~~ m/<?isInHangulCompatibilityJamo>/, q{Match unanchored <?isInHangulCompatibilityJamo>} );

# InHangulJamo


ok("\c[HANGUL CHOSEONG KIYEOK]" ~~ m/^<?isInHangulJamo>$/, q{Match <?isInHangulJamo>} );
ok(!( "\c[HANGUL CHOSEONG KIYEOK]" ~~ m/^<!isInHangulJamo>.$/ ), q{Don't match negated <?isInHangulJamo>} );
ok(!( "\c[HANGUL CHOSEONG KIYEOK]" ~~ m/^<-isInHangulJamo>$/ ), q{Don't match inverted <?isInHangulJamo>} );
ok(!( "\x[3B72]"  ~~ m/^<?isInHangulJamo>$/ ), q{Don't match unrelated <?isInHangulJamo>} );
ok("\x[3B72]"  ~~ m/^<!isInHangulJamo>.$/, q{Match unrelated negated <?isInHangulJamo>} );
ok("\x[3B72]"  ~~ m/^<-isInHangulJamo>$/, q{Match unrelated inverted <?isInHangulJamo>} );
ok("\x[3B72]\c[HANGUL CHOSEONG KIYEOK]" ~~ m/<?isInHangulJamo>/, q{Match unanchored <?isInHangulJamo>} );

# InHangulSyllables


ok("\x[CD95]" ~~ m/^<?isInHangulSyllables>$/, q{Match <?isInHangulSyllables>} );
ok(!( "\x[CD95]" ~~ m/^<!isInHangulSyllables>.$/ ), q{Don't match negated <?isInHangulSyllables>} );
ok(!( "\x[CD95]" ~~ m/^<-isInHangulSyllables>$/ ), q{Don't match inverted <?isInHangulSyllables>} );
ok(!( "\x[D7B0]"  ~~ m/^<?isInHangulSyllables>$/ ), q{Don't match unrelated <?isInHangulSyllables>} );
ok("\x[D7B0]"  ~~ m/^<!isInHangulSyllables>.$/, q{Match unrelated negated <?isInHangulSyllables>} );
ok("\x[D7B0]"  ~~ m/^<-isInHangulSyllables>$/, q{Match unrelated inverted <?isInHangulSyllables>} );
ok("\x[D7B0]\x[CD95]" ~~ m/<?isInHangulSyllables>/, q{Match unanchored <?isInHangulSyllables>} );

# InHanunoo


ok("\c[HANUNOO LETTER A]" ~~ m/^<?isInHanunoo>$/, q{Match <?isInHanunoo>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<!isInHanunoo>.$/ ), q{Don't match negated <?isInHanunoo>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<-isInHanunoo>$/ ), q{Don't match inverted <?isInHanunoo>} );
ok(!( "\x[6F4F]"  ~~ m/^<?isInHanunoo>$/ ), q{Don't match unrelated <?isInHanunoo>} );
ok("\x[6F4F]"  ~~ m/^<!isInHanunoo>.$/, q{Match unrelated negated <?isInHanunoo>} );
ok("\x[6F4F]"  ~~ m/^<-isInHanunoo>$/, q{Match unrelated inverted <?isInHanunoo>} );
ok("\x[6F4F]\c[HANUNOO LETTER A]" ~~ m/<?isInHanunoo>/, q{Match unanchored <?isInHanunoo>} );

# InHebrew


ok("\x[0590]" ~~ m/^<?isInHebrew>$/, q{Match <?isInHebrew>} );
ok(!( "\x[0590]" ~~ m/^<!isInHebrew>.$/ ), q{Don't match negated <?isInHebrew>} );
ok(!( "\x[0590]" ~~ m/^<-isInHebrew>$/ ), q{Don't match inverted <?isInHebrew>} );
ok(!( "\x[0777]"  ~~ m/^<?isInHebrew>$/ ), q{Don't match unrelated <?isInHebrew>} );
ok("\x[0777]"  ~~ m/^<!isInHebrew>.$/, q{Match unrelated negated <?isInHebrew>} );
ok("\x[0777]"  ~~ m/^<-isInHebrew>$/, q{Match unrelated inverted <?isInHebrew>} );
ok("\x[0777]\x[0590]" ~~ m/<?isInHebrew>/, q{Match unanchored <?isInHebrew>} );

# InHighPrivateUseSurrogates


ok(!( "\x[D04F]"  ~~ m/^<?isInHighPrivateUseSurrogates>$/ ), q{Don't match unrelated <?isInHighPrivateUseSurrogates>} );
ok("\x[D04F]"  ~~ m/^<!isInHighPrivateUseSurrogates>.$/, q{Match unrelated negated <?isInHighPrivateUseSurrogates>} );
ok("\x[D04F]"  ~~ m/^<-isInHighPrivateUseSurrogates>$/, q{Match unrelated inverted <?isInHighPrivateUseSurrogates>} );

# InHighSurrogates


ok(!( "\x[D085]"  ~~ m/^<?isInHighSurrogates>$/ ), q{Don't match unrelated <?isInHighSurrogates>} );
ok("\x[D085]"  ~~ m/^<!isInHighSurrogates>.$/, q{Match unrelated negated <?isInHighSurrogates>} );
ok("\x[D085]"  ~~ m/^<-isInHighSurrogates>$/, q{Match unrelated inverted <?isInHighSurrogates>} );

# InHiragana


ok("\x[3040]" ~~ m/^<?isInHiragana>$/, q{Match <?isInHiragana>} );
ok(!( "\x[3040]" ~~ m/^<!isInHiragana>.$/ ), q{Don't match negated <?isInHiragana>} );
ok(!( "\x[3040]" ~~ m/^<-isInHiragana>$/ ), q{Don't match inverted <?isInHiragana>} );
ok(!( "\x[AC7C]"  ~~ m/^<?isInHiragana>$/ ), q{Don't match unrelated <?isInHiragana>} );
ok("\x[AC7C]"  ~~ m/^<!isInHiragana>.$/, q{Match unrelated negated <?isInHiragana>} );
ok("\x[AC7C]"  ~~ m/^<-isInHiragana>$/, q{Match unrelated inverted <?isInHiragana>} );
ok("\x[AC7C]\x[3040]" ~~ m/<?isInHiragana>/, q{Match unanchored <?isInHiragana>} );

# InIPAExtensions


ok("\c[LATIN SMALL LETTER TURNED A]" ~~ m/^<?isInIPAExtensions>$/, q{Match <?isInIPAExtensions>} );
ok(!( "\c[LATIN SMALL LETTER TURNED A]" ~~ m/^<!isInIPAExtensions>.$/ ), q{Don't match negated <?isInIPAExtensions>} );
ok(!( "\c[LATIN SMALL LETTER TURNED A]" ~~ m/^<-isInIPAExtensions>$/ ), q{Don't match inverted <?isInIPAExtensions>} );
ok(!( "\c[HANGUL LETTER SSANGIEUNG]"  ~~ m/^<?isInIPAExtensions>$/ ), q{Don't match unrelated <?isInIPAExtensions>} );
ok("\c[HANGUL LETTER SSANGIEUNG]"  ~~ m/^<!isInIPAExtensions>.$/, q{Match unrelated negated <?isInIPAExtensions>} );
ok("\c[HANGUL LETTER SSANGIEUNG]"  ~~ m/^<-isInIPAExtensions>$/, q{Match unrelated inverted <?isInIPAExtensions>} );
ok("\c[HANGUL LETTER SSANGIEUNG]\c[LATIN SMALL LETTER TURNED A]" ~~ m/<?isInIPAExtensions>/, q{Match unanchored <?isInIPAExtensions>} );

# InIdeographicDescriptionCharacters


ok("\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<?isInIdeographicDescriptionCharacters>$/, q{Match <?isInIdeographicDescriptionCharacters>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<!isInIdeographicDescriptionCharacters>.$/ ), q{Don't match negated <?isInIdeographicDescriptionCharacters>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<-isInIdeographicDescriptionCharacters>$/ ), q{Don't match inverted <?isInIdeographicDescriptionCharacters>} );
ok(!( "\x[9160]"  ~~ m/^<?isInIdeographicDescriptionCharacters>$/ ), q{Don't match unrelated <?isInIdeographicDescriptionCharacters>} );
ok("\x[9160]"  ~~ m/^<!isInIdeographicDescriptionCharacters>.$/, q{Match unrelated negated <?isInIdeographicDescriptionCharacters>} );
ok("\x[9160]"  ~~ m/^<-isInIdeographicDescriptionCharacters>$/, q{Match unrelated inverted <?isInIdeographicDescriptionCharacters>} );
ok("\x[9160]\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/<?isInIdeographicDescriptionCharacters>/, q{Match unanchored <?isInIdeographicDescriptionCharacters>} );

# InKanbun


ok("\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/^<?isInKanbun>$/, q{Match <?isInKanbun>} );
ok(!( "\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/^<!isInKanbun>.$/ ), q{Don't match negated <?isInKanbun>} );
ok(!( "\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/^<-isInKanbun>$/ ), q{Don't match inverted <?isInKanbun>} );
ok(!( "\x[A80C]"  ~~ m/^<?isInKanbun>$/ ), q{Don't match unrelated <?isInKanbun>} );
ok("\x[A80C]"  ~~ m/^<!isInKanbun>.$/, q{Match unrelated negated <?isInKanbun>} );
ok("\x[A80C]"  ~~ m/^<-isInKanbun>$/, q{Match unrelated inverted <?isInKanbun>} );
ok("\x[A80C]\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/<?isInKanbun>/, q{Match unanchored <?isInKanbun>} );

# InKangxiRadicals


ok("\c[KANGXI RADICAL ONE]" ~~ m/^<?isInKangxiRadicals>$/, q{Match <?isInKangxiRadicals>} );
ok(!( "\c[KANGXI RADICAL ONE]" ~~ m/^<!isInKangxiRadicals>.$/ ), q{Don't match negated <?isInKangxiRadicals>} );
ok(!( "\c[KANGXI RADICAL ONE]" ~~ m/^<-isInKangxiRadicals>$/ ), q{Don't match inverted <?isInKangxiRadicals>} );
ok(!( "\x[891A]"  ~~ m/^<?isInKangxiRadicals>$/ ), q{Don't match unrelated <?isInKangxiRadicals>} );
ok("\x[891A]"  ~~ m/^<!isInKangxiRadicals>.$/, q{Match unrelated negated <?isInKangxiRadicals>} );
ok("\x[891A]"  ~~ m/^<-isInKangxiRadicals>$/, q{Match unrelated inverted <?isInKangxiRadicals>} );
ok("\x[891A]\c[KANGXI RADICAL ONE]" ~~ m/<?isInKangxiRadicals>/, q{Match unanchored <?isInKangxiRadicals>} );

# InKannada


ok("\x[0C80]" ~~ m/^<?isInKannada>$/, q{Match <?isInKannada>} );
ok(!( "\x[0C80]" ~~ m/^<!isInKannada>.$/ ), q{Don't match negated <?isInKannada>} );
ok(!( "\x[0C80]" ~~ m/^<-isInKannada>$/ ), q{Don't match inverted <?isInKannada>} );
ok(!( "\x[B614]"  ~~ m/^<?isInKannada>$/ ), q{Don't match unrelated <?isInKannada>} );
ok("\x[B614]"  ~~ m/^<!isInKannada>.$/, q{Match unrelated negated <?isInKannada>} );
ok("\x[B614]"  ~~ m/^<-isInKannada>$/, q{Match unrelated inverted <?isInKannada>} );
ok("\x[B614]\x[0C80]" ~~ m/<?isInKannada>/, q{Match unanchored <?isInKannada>} );

# InKatakana


ok("\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/^<?isInKatakana>$/, q{Match <?isInKatakana>} );
ok(!( "\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/^<!isInKatakana>.$/ ), q{Don't match negated <?isInKatakana>} );
ok(!( "\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/^<-isInKatakana>$/ ), q{Don't match inverted <?isInKatakana>} );
ok(!( "\x[7EB8]"  ~~ m/^<?isInKatakana>$/ ), q{Don't match unrelated <?isInKatakana>} );
ok("\x[7EB8]"  ~~ m/^<!isInKatakana>.$/, q{Match unrelated negated <?isInKatakana>} );
ok("\x[7EB8]"  ~~ m/^<-isInKatakana>$/, q{Match unrelated inverted <?isInKatakana>} );
ok("\x[7EB8]\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/<?isInKatakana>/, q{Match unanchored <?isInKatakana>} );

# InKatakanaPhoneticExtensions


ok("\c[KATAKANA LETTER SMALL KU]" ~~ m/^<?isInKatakanaPhoneticExtensions>$/, q{Match <?isInKatakanaPhoneticExtensions>} );
ok(!( "\c[KATAKANA LETTER SMALL KU]" ~~ m/^<!isInKatakanaPhoneticExtensions>.$/ ), q{Don't match negated <?isInKatakanaPhoneticExtensions>} );
ok(!( "\c[KATAKANA LETTER SMALL KU]" ~~ m/^<-isInKatakanaPhoneticExtensions>$/ ), q{Don't match inverted <?isInKatakanaPhoneticExtensions>} );
ok(!( "\x[97C2]"  ~~ m/^<?isInKatakanaPhoneticExtensions>$/ ), q{Don't match unrelated <?isInKatakanaPhoneticExtensions>} );
ok("\x[97C2]"  ~~ m/^<!isInKatakanaPhoneticExtensions>.$/, q{Match unrelated negated <?isInKatakanaPhoneticExtensions>} );
ok("\x[97C2]"  ~~ m/^<-isInKatakanaPhoneticExtensions>$/, q{Match unrelated inverted <?isInKatakanaPhoneticExtensions>} );
ok("\x[97C2]\c[KATAKANA LETTER SMALL KU]" ~~ m/<?isInKatakanaPhoneticExtensions>/, q{Match unanchored <?isInKatakanaPhoneticExtensions>} );

# InKhmer


ok("\c[KHMER LETTER KA]" ~~ m/^<?isInKhmer>$/, q{Match <?isInKhmer>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<!isInKhmer>.$/ ), q{Don't match negated <?isInKhmer>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<-isInKhmer>$/ ), q{Don't match inverted <?isInKhmer>} );
ok(!( "\x[CAFA]"  ~~ m/^<?isInKhmer>$/ ), q{Don't match unrelated <?isInKhmer>} );
ok("\x[CAFA]"  ~~ m/^<!isInKhmer>.$/, q{Match unrelated negated <?isInKhmer>} );
ok("\x[CAFA]"  ~~ m/^<-isInKhmer>$/, q{Match unrelated inverted <?isInKhmer>} );
ok("\x[CAFA]\c[KHMER LETTER KA]" ~~ m/<?isInKhmer>/, q{Match unanchored <?isInKhmer>} );

# InLao


ok("\x[0E80]" ~~ m/^<?isInLao>$/, q{Match <?isInLao>} );
ok(!( "\x[0E80]" ~~ m/^<!isInLao>.$/ ), q{Don't match negated <?isInLao>} );
ok(!( "\x[0E80]" ~~ m/^<-isInLao>$/ ), q{Don't match inverted <?isInLao>} );
ok(!( "\x[07BF]"  ~~ m/^<?isInLao>$/ ), q{Don't match unrelated <?isInLao>} );
ok("\x[07BF]"  ~~ m/^<!isInLao>.$/, q{Match unrelated negated <?isInLao>} );
ok("\x[07BF]"  ~~ m/^<-isInLao>$/, q{Match unrelated inverted <?isInLao>} );
ok("\x[07BF]\x[0E80]" ~~ m/<?isInLao>/, q{Match unanchored <?isInLao>} );

# InLatin1Supplement


ok("\x[0080]" ~~ m/^<?isInLatin1Supplement>$/, q{Match <?isInLatin1Supplement>} );
ok(!( "\x[0080]" ~~ m/^<!isInLatin1Supplement>.$/ ), q{Don't match negated <?isInLatin1Supplement>} );
ok(!( "\x[0080]" ~~ m/^<-isInLatin1Supplement>$/ ), q{Don't match inverted <?isInLatin1Supplement>} );
ok(!( "\x[D062]"  ~~ m/^<?isInLatin1Supplement>$/ ), q{Don't match unrelated <?isInLatin1Supplement>} );
ok("\x[D062]"  ~~ m/^<!isInLatin1Supplement>.$/, q{Match unrelated negated <?isInLatin1Supplement>} );
ok("\x[D062]"  ~~ m/^<-isInLatin1Supplement>$/, q{Match unrelated inverted <?isInLatin1Supplement>} );
ok("\x[D062]\x[0080]" ~~ m/<?isInLatin1Supplement>/, q{Match unanchored <?isInLatin1Supplement>} );

# InLatinExtendedA


ok("\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/^<?isInLatinExtendedA>$/, q{Match <?isInLatinExtendedA>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/^<!isInLatinExtendedA>.$/ ), q{Don't match negated <?isInLatinExtendedA>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/^<-isInLatinExtendedA>$/ ), q{Don't match inverted <?isInLatinExtendedA>} );
ok(!( "\c[IDEOGRAPHIC ANNOTATION EARTH MARK]"  ~~ m/^<?isInLatinExtendedA>$/ ), q{Don't match unrelated <?isInLatinExtendedA>} );
ok("\c[IDEOGRAPHIC ANNOTATION EARTH MARK]"  ~~ m/^<!isInLatinExtendedA>.$/, q{Match unrelated negated <?isInLatinExtendedA>} );
ok("\c[IDEOGRAPHIC ANNOTATION EARTH MARK]"  ~~ m/^<-isInLatinExtendedA>$/, q{Match unrelated inverted <?isInLatinExtendedA>} );
ok("\c[IDEOGRAPHIC ANNOTATION EARTH MARK]\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/<?isInLatinExtendedA>/, q{Match unanchored <?isInLatinExtendedA>} );

# InLatinExtendedAdditional


ok("\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/^<?isInLatinExtendedAdditional>$/, q{Match <?isInLatinExtendedAdditional>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/^<!isInLatinExtendedAdditional>.$/ ), q{Don't match negated <?isInLatinExtendedAdditional>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/^<-isInLatinExtendedAdditional>$/ ), q{Don't match inverted <?isInLatinExtendedAdditional>} );
ok(!( "\x[9A44]"  ~~ m/^<?isInLatinExtendedAdditional>$/ ), q{Don't match unrelated <?isInLatinExtendedAdditional>} );
ok("\x[9A44]"  ~~ m/^<!isInLatinExtendedAdditional>.$/, q{Match unrelated negated <?isInLatinExtendedAdditional>} );
ok("\x[9A44]"  ~~ m/^<-isInLatinExtendedAdditional>$/, q{Match unrelated inverted <?isInLatinExtendedAdditional>} );
ok("\x[9A44]\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/<?isInLatinExtendedAdditional>/, q{Match unanchored <?isInLatinExtendedAdditional>} );

# InLatinExtendedB


ok("\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/^<?isInLatinExtendedB>$/, q{Match <?isInLatinExtendedB>} );
ok(!( "\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/^<!isInLatinExtendedB>.$/ ), q{Don't match negated <?isInLatinExtendedB>} );
ok(!( "\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/^<-isInLatinExtendedB>$/ ), q{Don't match inverted <?isInLatinExtendedB>} );
ok(!( "\x[7544]"  ~~ m/^<?isInLatinExtendedB>$/ ), q{Don't match unrelated <?isInLatinExtendedB>} );
ok("\x[7544]"  ~~ m/^<!isInLatinExtendedB>.$/, q{Match unrelated negated <?isInLatinExtendedB>} );
ok("\x[7544]"  ~~ m/^<-isInLatinExtendedB>$/, q{Match unrelated inverted <?isInLatinExtendedB>} );
ok("\x[7544]\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/<?isInLatinExtendedB>/, q{Match unanchored <?isInLatinExtendedB>} );

# InLetterlikeSymbols


ok("\c[ACCOUNT OF]" ~~ m/^<?isInLetterlikeSymbols>$/, q{Match <?isInLetterlikeSymbols>} );
ok(!( "\c[ACCOUNT OF]" ~~ m/^<!isInLetterlikeSymbols>.$/ ), q{Don't match negated <?isInLetterlikeSymbols>} );
ok(!( "\c[ACCOUNT OF]" ~~ m/^<-isInLetterlikeSymbols>$/ ), q{Don't match inverted <?isInLetterlikeSymbols>} );
ok(!( "\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]"  ~~ m/^<?isInLetterlikeSymbols>$/ ), q{Don't match unrelated <?isInLetterlikeSymbols>} );
ok("\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]"  ~~ m/^<!isInLetterlikeSymbols>.$/, q{Match unrelated negated <?isInLetterlikeSymbols>} );
ok("\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]"  ~~ m/^<-isInLetterlikeSymbols>$/, q{Match unrelated inverted <?isInLetterlikeSymbols>} );
ok("\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]\c[ACCOUNT OF]" ~~ m/<?isInLetterlikeSymbols>/, q{Match unanchored <?isInLetterlikeSymbols>} );

# InLowSurrogates


ok(!( "\x[5ECC]"  ~~ m/^<?isInLowSurrogates>$/ ), q{Don't match unrelated <?isInLowSurrogates>} );
ok("\x[5ECC]"  ~~ m/^<!isInLowSurrogates>.$/, q{Match unrelated negated <?isInLowSurrogates>} );
ok("\x[5ECC]"  ~~ m/^<-isInLowSurrogates>$/, q{Match unrelated inverted <?isInLowSurrogates>} );

# InMalayalam


ok("\x[0D00]" ~~ m/^<?isInMalayalam>$/, q{Match <?isInMalayalam>} );
ok(!( "\x[0D00]" ~~ m/^<!isInMalayalam>.$/ ), q{Don't match negated <?isInMalayalam>} );
ok(!( "\x[0D00]" ~~ m/^<-isInMalayalam>$/ ), q{Don't match inverted <?isInMalayalam>} );
ok(!( "\x[3457]"  ~~ m/^<?isInMalayalam>$/ ), q{Don't match unrelated <?isInMalayalam>} );
ok("\x[3457]"  ~~ m/^<!isInMalayalam>.$/, q{Match unrelated negated <?isInMalayalam>} );
ok("\x[3457]"  ~~ m/^<-isInMalayalam>$/, q{Match unrelated inverted <?isInMalayalam>} );
ok("\x[3457]\x[0D00]" ~~ m/<?isInMalayalam>/, q{Match unanchored <?isInMalayalam>} );

# InMathematicalAlphanumericSymbols


ok(!( "\x[6B79]"  ~~ m/^<?isInMathematicalAlphanumericSymbols>$/ ), q{Don't match unrelated <?isInMathematicalAlphanumericSymbols>} );
ok("\x[6B79]"  ~~ m/^<!isInMathematicalAlphanumericSymbols>.$/, q{Match unrelated negated <?isInMathematicalAlphanumericSymbols>} );
ok("\x[6B79]"  ~~ m/^<-isInMathematicalAlphanumericSymbols>$/, q{Match unrelated inverted <?isInMathematicalAlphanumericSymbols>} );

# InMathematicalOperators


ok("\c[FOR ALL]" ~~ m/^<?isInMathematicalOperators>$/, q{Match <?isInMathematicalOperators>} );
ok(!( "\c[FOR ALL]" ~~ m/^<!isInMathematicalOperators>.$/ ), q{Don't match negated <?isInMathematicalOperators>} );
ok(!( "\c[FOR ALL]" ~~ m/^<-isInMathematicalOperators>$/ ), q{Don't match inverted <?isInMathematicalOperators>} );
ok(!( "\x[BBC6]"  ~~ m/^<?isInMathematicalOperators>$/ ), q{Don't match unrelated <?isInMathematicalOperators>} );
ok("\x[BBC6]"  ~~ m/^<!isInMathematicalOperators>.$/, q{Match unrelated negated <?isInMathematicalOperators>} );
ok("\x[BBC6]"  ~~ m/^<-isInMathematicalOperators>$/, q{Match unrelated inverted <?isInMathematicalOperators>} );
ok("\x[BBC6]\c[FOR ALL]" ~~ m/<?isInMathematicalOperators>/, q{Match unanchored <?isInMathematicalOperators>} );

# InMiscellaneousMathematicalSymbolsA


ok("\x[27C0]" ~~ m/^<?isInMiscellaneousMathematicalSymbolsA>$/, q{Match <?isInMiscellaneousMathematicalSymbolsA>} );
ok(!( "\x[27C0]" ~~ m/^<!isInMiscellaneousMathematicalSymbolsA>.$/ ), q{Don't match negated <?isInMiscellaneousMathematicalSymbolsA>} );
ok(!( "\x[27C0]" ~~ m/^<-isInMiscellaneousMathematicalSymbolsA>$/ ), q{Don't match inverted <?isInMiscellaneousMathematicalSymbolsA>} );
ok(!( "\x[065D]"  ~~ m/^<?isInMiscellaneousMathematicalSymbolsA>$/ ), q{Don't match unrelated <?isInMiscellaneousMathematicalSymbolsA>} );
ok("\x[065D]"  ~~ m/^<!isInMiscellaneousMathematicalSymbolsA>.$/, q{Match unrelated negated <?isInMiscellaneousMathematicalSymbolsA>} );
ok("\x[065D]"  ~~ m/^<-isInMiscellaneousMathematicalSymbolsA>$/, q{Match unrelated inverted <?isInMiscellaneousMathematicalSymbolsA>} );
ok("\x[065D]\x[27C0]" ~~ m/<?isInMiscellaneousMathematicalSymbolsA>/, q{Match unanchored <?isInMiscellaneousMathematicalSymbolsA>} );

# InMiscellaneousMathematicalSymbolsB


ok("\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/^<?isInMiscellaneousMathematicalSymbolsB>$/, q{Match <?isInMiscellaneousMathematicalSymbolsB>} );
ok(!( "\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/^<!isInMiscellaneousMathematicalSymbolsB>.$/ ), q{Don't match negated <?isInMiscellaneousMathematicalSymbolsB>} );
ok(!( "\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/^<-isInMiscellaneousMathematicalSymbolsB>$/ ), q{Don't match inverted <?isInMiscellaneousMathematicalSymbolsB>} );
ok(!( "\x[56A6]"  ~~ m/^<?isInMiscellaneousMathematicalSymbolsB>$/ ), q{Don't match unrelated <?isInMiscellaneousMathematicalSymbolsB>} );
ok("\x[56A6]"  ~~ m/^<!isInMiscellaneousMathematicalSymbolsB>.$/, q{Match unrelated negated <?isInMiscellaneousMathematicalSymbolsB>} );
ok("\x[56A6]"  ~~ m/^<-isInMiscellaneousMathematicalSymbolsB>$/, q{Match unrelated inverted <?isInMiscellaneousMathematicalSymbolsB>} );
ok("\x[56A6]\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/<?isInMiscellaneousMathematicalSymbolsB>/, q{Match unanchored <?isInMiscellaneousMathematicalSymbolsB>} );

# InMiscellaneousSymbols


ok("\c[BLACK SUN WITH RAYS]" ~~ m/^<?isInMiscellaneousSymbols>$/, q{Match <?isInMiscellaneousSymbols>} );
ok(!( "\c[BLACK SUN WITH RAYS]" ~~ m/^<!isInMiscellaneousSymbols>.$/ ), q{Don't match negated <?isInMiscellaneousSymbols>} );
ok(!( "\c[BLACK SUN WITH RAYS]" ~~ m/^<-isInMiscellaneousSymbols>$/ ), q{Don't match inverted <?isInMiscellaneousSymbols>} );
ok(!( "\x[3EE7]"  ~~ m/^<?isInMiscellaneousSymbols>$/ ), q{Don't match unrelated <?isInMiscellaneousSymbols>} );
ok("\x[3EE7]"  ~~ m/^<!isInMiscellaneousSymbols>.$/, q{Match unrelated negated <?isInMiscellaneousSymbols>} );
ok("\x[3EE7]"  ~~ m/^<-isInMiscellaneousSymbols>$/, q{Match unrelated inverted <?isInMiscellaneousSymbols>} );
ok("\x[3EE7]\c[BLACK SUN WITH RAYS]" ~~ m/<?isInMiscellaneousSymbols>/, q{Match unanchored <?isInMiscellaneousSymbols>} );

# InMiscellaneousTechnical


ok("\c[DIAMETER SIGN]" ~~ m/^<?isInMiscellaneousTechnical>$/, q{Match <?isInMiscellaneousTechnical>} );
ok(!( "\c[DIAMETER SIGN]" ~~ m/^<!isInMiscellaneousTechnical>.$/ ), q{Don't match negated <?isInMiscellaneousTechnical>} );
ok(!( "\c[DIAMETER SIGN]" ~~ m/^<-isInMiscellaneousTechnical>$/ ), q{Don't match inverted <?isInMiscellaneousTechnical>} );
ok(!( "\x[2EFC]"  ~~ m/^<?isInMiscellaneousTechnical>$/ ), q{Don't match unrelated <?isInMiscellaneousTechnical>} );
ok("\x[2EFC]"  ~~ m/^<!isInMiscellaneousTechnical>.$/, q{Match unrelated negated <?isInMiscellaneousTechnical>} );
ok("\x[2EFC]"  ~~ m/^<-isInMiscellaneousTechnical>$/, q{Match unrelated inverted <?isInMiscellaneousTechnical>} );
ok("\x[2EFC]\c[DIAMETER SIGN]" ~~ m/<?isInMiscellaneousTechnical>/, q{Match unanchored <?isInMiscellaneousTechnical>} );

# InMongolian


ok("\c[MONGOLIAN BIRGA]" ~~ m/^<?isInMongolian>$/, q{Match <?isInMongolian>} );
ok(!( "\c[MONGOLIAN BIRGA]" ~~ m/^<!isInMongolian>.$/ ), q{Don't match negated <?isInMongolian>} );
ok(!( "\c[MONGOLIAN BIRGA]" ~~ m/^<-isInMongolian>$/ ), q{Don't match inverted <?isInMongolian>} );
ok(!( "\x[AFB4]"  ~~ m/^<?isInMongolian>$/ ), q{Don't match unrelated <?isInMongolian>} );
ok("\x[AFB4]"  ~~ m/^<!isInMongolian>.$/, q{Match unrelated negated <?isInMongolian>} );
ok("\x[AFB4]"  ~~ m/^<-isInMongolian>$/, q{Match unrelated inverted <?isInMongolian>} );
ok("\x[AFB4]\c[MONGOLIAN BIRGA]" ~~ m/<?isInMongolian>/, q{Match unanchored <?isInMongolian>} );

# InMusicalSymbols


ok(!( "\x[0CE4]"  ~~ m/^<?isInMusicalSymbols>$/ ), q{Don't match unrelated <?isInMusicalSymbols>} );
ok("\x[0CE4]"  ~~ m/^<!isInMusicalSymbols>.$/, q{Match unrelated negated <?isInMusicalSymbols>} );
ok("\x[0CE4]"  ~~ m/^<-isInMusicalSymbols>$/, q{Match unrelated inverted <?isInMusicalSymbols>} );

# InMyanmar


ok("\c[MYANMAR LETTER KA]" ~~ m/^<?isInMyanmar>$/, q{Match <?isInMyanmar>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<!isInMyanmar>.$/ ), q{Don't match negated <?isInMyanmar>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<-isInMyanmar>$/ ), q{Don't match inverted <?isInMyanmar>} );
ok(!( "\x[1DDB]"  ~~ m/^<?isInMyanmar>$/ ), q{Don't match unrelated <?isInMyanmar>} );
ok("\x[1DDB]"  ~~ m/^<!isInMyanmar>.$/, q{Match unrelated negated <?isInMyanmar>} );
ok("\x[1DDB]"  ~~ m/^<-isInMyanmar>$/, q{Match unrelated inverted <?isInMyanmar>} );
ok("\x[1DDB]\c[MYANMAR LETTER KA]" ~~ m/<?isInMyanmar>/, q{Match unanchored <?isInMyanmar>} );

# InNumberForms


ok("\x[2150]" ~~ m/^<?isInNumberForms>$/, q{Match <?isInNumberForms>} );
ok(!( "\x[2150]" ~~ m/^<!isInNumberForms>.$/ ), q{Don't match negated <?isInNumberForms>} );
ok(!( "\x[2150]" ~~ m/^<-isInNumberForms>$/ ), q{Don't match inverted <?isInNumberForms>} );
ok(!( "\c[BLACK RIGHT-POINTING SMALL TRIANGLE]"  ~~ m/^<?isInNumberForms>$/ ), q{Don't match unrelated <?isInNumberForms>} );
ok("\c[BLACK RIGHT-POINTING SMALL TRIANGLE]"  ~~ m/^<!isInNumberForms>.$/, q{Match unrelated negated <?isInNumberForms>} );
ok("\c[BLACK RIGHT-POINTING SMALL TRIANGLE]"  ~~ m/^<-isInNumberForms>$/, q{Match unrelated inverted <?isInNumberForms>} );
ok("\c[BLACK RIGHT-POINTING SMALL TRIANGLE]\x[2150]" ~~ m/<?isInNumberForms>/, q{Match unanchored <?isInNumberForms>} );

# InOgham


ok("\c[OGHAM SPACE MARK]" ~~ m/^<?isInOgham>$/, q{Match <?isInOgham>} );
ok(!( "\c[OGHAM SPACE MARK]" ~~ m/^<!isInOgham>.$/ ), q{Don't match negated <?isInOgham>} );
ok(!( "\c[OGHAM SPACE MARK]" ~~ m/^<-isInOgham>$/ ), q{Don't match inverted <?isInOgham>} );
ok(!( "\x[768C]"  ~~ m/^<?isInOgham>$/ ), q{Don't match unrelated <?isInOgham>} );
ok("\x[768C]"  ~~ m/^<!isInOgham>.$/, q{Match unrelated negated <?isInOgham>} );
ok("\x[768C]"  ~~ m/^<-isInOgham>$/, q{Match unrelated inverted <?isInOgham>} );
ok("\x[768C]\c[OGHAM SPACE MARK]" ~~ m/<?isInOgham>/, q{Match unanchored <?isInOgham>} );

# InOldItalic


ok(!( "\x[C597]"  ~~ m/^<?isInOldItalic>$/ ), q{Don't match unrelated <?isInOldItalic>} );
ok("\x[C597]"  ~~ m/^<!isInOldItalic>.$/, q{Match unrelated negated <?isInOldItalic>} );
ok("\x[C597]"  ~~ m/^<-isInOldItalic>$/, q{Match unrelated inverted <?isInOldItalic>} );

# InOpticalCharacterRecognition


ok("\c[OCR HOOK]" ~~ m/^<?isInOpticalCharacterRecognition>$/, q{Match <?isInOpticalCharacterRecognition>} );
ok(!( "\c[OCR HOOK]" ~~ m/^<!isInOpticalCharacterRecognition>.$/ ), q{Don't match negated <?isInOpticalCharacterRecognition>} );
ok(!( "\c[OCR HOOK]" ~~ m/^<-isInOpticalCharacterRecognition>$/ ), q{Don't match inverted <?isInOpticalCharacterRecognition>} );
ok(!( "\x[BE80]"  ~~ m/^<?isInOpticalCharacterRecognition>$/ ), q{Don't match unrelated <?isInOpticalCharacterRecognition>} );
ok("\x[BE80]"  ~~ m/^<!isInOpticalCharacterRecognition>.$/, q{Match unrelated negated <?isInOpticalCharacterRecognition>} );
ok("\x[BE80]"  ~~ m/^<-isInOpticalCharacterRecognition>$/, q{Match unrelated inverted <?isInOpticalCharacterRecognition>} );
ok("\x[BE80]\c[OCR HOOK]" ~~ m/<?isInOpticalCharacterRecognition>/, q{Match unanchored <?isInOpticalCharacterRecognition>} );

# InOriya


ok("\x[0B00]" ~~ m/^<?isInOriya>$/, q{Match <?isInOriya>} );
ok(!( "\x[0B00]" ~~ m/^<!isInOriya>.$/ ), q{Don't match negated <?isInOriya>} );
ok(!( "\x[0B00]" ~~ m/^<-isInOriya>$/ ), q{Don't match inverted <?isInOriya>} );
ok(!( "\c[YI SYLLABLE GGEX]"  ~~ m/^<?isInOriya>$/ ), q{Don't match unrelated <?isInOriya>} );
ok("\c[YI SYLLABLE GGEX]"  ~~ m/^<!isInOriya>.$/, q{Match unrelated negated <?isInOriya>} );
ok("\c[YI SYLLABLE GGEX]"  ~~ m/^<-isInOriya>$/, q{Match unrelated inverted <?isInOriya>} );
ok("\c[YI SYLLABLE GGEX]\x[0B00]" ~~ m/<?isInOriya>/, q{Match unanchored <?isInOriya>} );

# InPrivateUseArea


ok(!( "\x[B6B1]"  ~~ m/^<?isInPrivateUseArea>$/ ), q{Don't match unrelated <?isInPrivateUseArea>} );
ok("\x[B6B1]"  ~~ m/^<!isInPrivateUseArea>.$/, q{Match unrelated negated <?isInPrivateUseArea>} );
ok("\x[B6B1]"  ~~ m/^<-isInPrivateUseArea>$/, q{Match unrelated inverted <?isInPrivateUseArea>} );

# InRunic


ok("\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<?isInRunic>$/, q{Match <?isInRunic>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<!isInRunic>.$/ ), q{Don't match negated <?isInRunic>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<-isInRunic>$/ ), q{Don't match inverted <?isInRunic>} );
ok(!( "\c[SINHALA LETTER MAHAAPRAANA KAYANNA]"  ~~ m/^<?isInRunic>$/ ), q{Don't match unrelated <?isInRunic>} );
ok("\c[SINHALA LETTER MAHAAPRAANA KAYANNA]"  ~~ m/^<!isInRunic>.$/, q{Match unrelated negated <?isInRunic>} );
ok("\c[SINHALA LETTER MAHAAPRAANA KAYANNA]"  ~~ m/^<-isInRunic>$/, q{Match unrelated inverted <?isInRunic>} );
ok("\c[SINHALA LETTER MAHAAPRAANA KAYANNA]\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/<?isInRunic>/, q{Match unanchored <?isInRunic>} );

# InSinhala


ok("\x[0D80]" ~~ m/^<?isInSinhala>$/, q{Match <?isInSinhala>} );
ok(!( "\x[0D80]" ~~ m/^<!isInSinhala>.$/ ), q{Don't match negated <?isInSinhala>} );
ok(!( "\x[0D80]" ~~ m/^<-isInSinhala>$/ ), q{Don't match inverted <?isInSinhala>} );
ok(!( "\x[1060]"  ~~ m/^<?isInSinhala>$/ ), q{Don't match unrelated <?isInSinhala>} );
ok("\x[1060]"  ~~ m/^<!isInSinhala>.$/, q{Match unrelated negated <?isInSinhala>} );
ok("\x[1060]"  ~~ m/^<-isInSinhala>$/, q{Match unrelated inverted <?isInSinhala>} );
ok("\x[1060]\x[0D80]" ~~ m/<?isInSinhala>/, q{Match unanchored <?isInSinhala>} );

# InSmallFormVariants


ok(!( "\x[5285]"  ~~ m/^<?isInSmallFormVariants>$/ ), q{Don't match unrelated <?isInSmallFormVariants>} );
ok("\x[5285]"  ~~ m/^<!isInSmallFormVariants>.$/, q{Match unrelated negated <?isInSmallFormVariants>} );
ok("\x[5285]"  ~~ m/^<-isInSmallFormVariants>$/, q{Match unrelated inverted <?isInSmallFormVariants>} );

# InSpacingModifierLetters


ok("\c[MODIFIER LETTER SMALL H]" ~~ m/^<?isInSpacingModifierLetters>$/, q{Match <?isInSpacingModifierLetters>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<!isInSpacingModifierLetters>.$/ ), q{Don't match negated <?isInSpacingModifierLetters>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<-isInSpacingModifierLetters>$/ ), q{Don't match inverted <?isInSpacingModifierLetters>} );
ok(!( "\x[5326]"  ~~ m/^<?isInSpacingModifierLetters>$/ ), q{Don't match unrelated <?isInSpacingModifierLetters>} );
ok("\x[5326]"  ~~ m/^<!isInSpacingModifierLetters>.$/, q{Match unrelated negated <?isInSpacingModifierLetters>} );
ok("\x[5326]"  ~~ m/^<-isInSpacingModifierLetters>$/, q{Match unrelated inverted <?isInSpacingModifierLetters>} );
ok("\x[5326]\c[MODIFIER LETTER SMALL H]" ~~ m/<?isInSpacingModifierLetters>/, q{Match unanchored <?isInSpacingModifierLetters>} );

# InSpecials


ok(!( "\x[3DF1]"  ~~ m/^<?isInSpecials>$/ ), q{Don't match unrelated <?isInSpecials>} );
ok("\x[3DF1]"  ~~ m/^<!isInSpecials>.$/, q{Match unrelated negated <?isInSpecials>} );
ok("\x[3DF1]"  ~~ m/^<-isInSpecials>$/, q{Match unrelated inverted <?isInSpecials>} );

# InSuperscriptsAndSubscripts


ok("\c[SUPERSCRIPT ZERO]" ~~ m/^<?isInSuperscriptsAndSubscripts>$/, q{Match <?isInSuperscriptsAndSubscripts>} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<!isInSuperscriptsAndSubscripts>.$/ ), q{Don't match negated <?isInSuperscriptsAndSubscripts>} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<-isInSuperscriptsAndSubscripts>$/ ), q{Don't match inverted <?isInSuperscriptsAndSubscripts>} );
ok(!( "\x[3E71]"  ~~ m/^<?isInSuperscriptsAndSubscripts>$/ ), q{Don't match unrelated <?isInSuperscriptsAndSubscripts>} );
ok("\x[3E71]"  ~~ m/^<!isInSuperscriptsAndSubscripts>.$/, q{Match unrelated negated <?isInSuperscriptsAndSubscripts>} );
ok("\x[3E71]"  ~~ m/^<-isInSuperscriptsAndSubscripts>$/, q{Match unrelated inverted <?isInSuperscriptsAndSubscripts>} );
ok("\x[3E71]\c[SUPERSCRIPT ZERO]" ~~ m/<?isInSuperscriptsAndSubscripts>/, q{Match unanchored <?isInSuperscriptsAndSubscripts>} );

# InSupplementalArrowsA


ok("\c[UPWARDS QUADRUPLE ARROW]" ~~ m/^<?isInSupplementalArrowsA>$/, q{Match <?isInSupplementalArrowsA>} );
ok(!( "\c[UPWARDS QUADRUPLE ARROW]" ~~ m/^<!isInSupplementalArrowsA>.$/ ), q{Don't match negated <?isInSupplementalArrowsA>} );
ok(!( "\c[UPWARDS QUADRUPLE ARROW]" ~~ m/^<-isInSupplementalArrowsA>$/ ), q{Don't match inverted <?isInSupplementalArrowsA>} );
ok(!( "\c[GREEK SMALL LETTER OMICRON WITH TONOS]"  ~~ m/^<?isInSupplementalArrowsA>$/ ), q{Don't match unrelated <?isInSupplementalArrowsA>} );
ok("\c[GREEK SMALL LETTER OMICRON WITH TONOS]"  ~~ m/^<!isInSupplementalArrowsA>.$/, q{Match unrelated negated <?isInSupplementalArrowsA>} );
ok("\c[GREEK SMALL LETTER OMICRON WITH TONOS]"  ~~ m/^<-isInSupplementalArrowsA>$/, q{Match unrelated inverted <?isInSupplementalArrowsA>} );
ok("\c[GREEK SMALL LETTER OMICRON WITH TONOS]\c[UPWARDS QUADRUPLE ARROW]" ~~ m/<?isInSupplementalArrowsA>/, q{Match unanchored <?isInSupplementalArrowsA>} );

# InSupplementalArrowsB


ok("\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/^<?isInSupplementalArrowsB>$/, q{Match <?isInSupplementalArrowsB>} );
ok(!( "\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/^<!isInSupplementalArrowsB>.$/ ), q{Don't match negated <?isInSupplementalArrowsB>} );
ok(!( "\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/^<-isInSupplementalArrowsB>$/ ), q{Don't match inverted <?isInSupplementalArrowsB>} );
ok(!( "\x[C1A9]"  ~~ m/^<?isInSupplementalArrowsB>$/ ), q{Don't match unrelated <?isInSupplementalArrowsB>} );
ok("\x[C1A9]"  ~~ m/^<!isInSupplementalArrowsB>.$/, q{Match unrelated negated <?isInSupplementalArrowsB>} );
ok("\x[C1A9]"  ~~ m/^<-isInSupplementalArrowsB>$/, q{Match unrelated inverted <?isInSupplementalArrowsB>} );
ok("\x[C1A9]\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/<?isInSupplementalArrowsB>/, q{Match unanchored <?isInSupplementalArrowsB>} );

# InSupplementalMathematicalOperators


ok("\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/^<?isInSupplementalMathematicalOperators>$/, q{Match <?isInSupplementalMathematicalOperators>} );
ok(!( "\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/^<!isInSupplementalMathematicalOperators>.$/ ), q{Don't match negated <?isInSupplementalMathematicalOperators>} );
ok(!( "\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/^<-isInSupplementalMathematicalOperators>$/ ), q{Don't match inverted <?isInSupplementalMathematicalOperators>} );
ok(!( "\x[9EBD]"  ~~ m/^<?isInSupplementalMathematicalOperators>$/ ), q{Don't match unrelated <?isInSupplementalMathematicalOperators>} );
ok("\x[9EBD]"  ~~ m/^<!isInSupplementalMathematicalOperators>.$/, q{Match unrelated negated <?isInSupplementalMathematicalOperators>} );
ok("\x[9EBD]"  ~~ m/^<-isInSupplementalMathematicalOperators>$/, q{Match unrelated inverted <?isInSupplementalMathematicalOperators>} );
ok("\x[9EBD]\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/<?isInSupplementalMathematicalOperators>/, q{Match unanchored <?isInSupplementalMathematicalOperators>} );

# InSupplementaryPrivateUseAreaA


ok(!( "\x[07E3]"  ~~ m/^<?isInSupplementaryPrivateUseAreaA>$/ ), q{Don't match unrelated <?isInSupplementaryPrivateUseAreaA>} );
ok("\x[07E3]"  ~~ m/^<!isInSupplementaryPrivateUseAreaA>.$/, q{Match unrelated negated <?isInSupplementaryPrivateUseAreaA>} );
ok("\x[07E3]"  ~~ m/^<-isInSupplementaryPrivateUseAreaA>$/, q{Match unrelated inverted <?isInSupplementaryPrivateUseAreaA>} );

# InSupplementaryPrivateUseAreaB


ok(!( "\x[4C48]"  ~~ m/^<?isInSupplementaryPrivateUseAreaB>$/ ), q{Don't match unrelated <?isInSupplementaryPrivateUseAreaB>} );
ok("\x[4C48]"  ~~ m/^<!isInSupplementaryPrivateUseAreaB>.$/, q{Match unrelated negated <?isInSupplementaryPrivateUseAreaB>} );
ok("\x[4C48]"  ~~ m/^<-isInSupplementaryPrivateUseAreaB>$/, q{Match unrelated inverted <?isInSupplementaryPrivateUseAreaB>} );

# InSyriac


ok("\c[SYRIAC END OF PARAGRAPH]" ~~ m/^<?isInSyriac>$/, q{Match <?isInSyriac>} );
ok(!( "\c[SYRIAC END OF PARAGRAPH]" ~~ m/^<!isInSyriac>.$/ ), q{Don't match negated <?isInSyriac>} );
ok(!( "\c[SYRIAC END OF PARAGRAPH]" ~~ m/^<-isInSyriac>$/ ), q{Don't match inverted <?isInSyriac>} );
ok(!( "\c[YI SYLLABLE NZIEP]"  ~~ m/^<?isInSyriac>$/ ), q{Don't match unrelated <?isInSyriac>} );
ok("\c[YI SYLLABLE NZIEP]"  ~~ m/^<!isInSyriac>.$/, q{Match unrelated negated <?isInSyriac>} );
ok("\c[YI SYLLABLE NZIEP]"  ~~ m/^<-isInSyriac>$/, q{Match unrelated inverted <?isInSyriac>} );
ok("\c[YI SYLLABLE NZIEP]\c[SYRIAC END OF PARAGRAPH]" ~~ m/<?isInSyriac>/, q{Match unanchored <?isInSyriac>} );

# InTagalog


ok("\c[TAGALOG LETTER A]" ~~ m/^<?isInTagalog>$/, q{Match <?isInTagalog>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<!isInTagalog>.$/ ), q{Don't match negated <?isInTagalog>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<-isInTagalog>$/ ), q{Don't match inverted <?isInTagalog>} );
ok(!( "\c[GEORGIAN LETTER BAN]"  ~~ m/^<?isInTagalog>$/ ), q{Don't match unrelated <?isInTagalog>} );
ok("\c[GEORGIAN LETTER BAN]"  ~~ m/^<!isInTagalog>.$/, q{Match unrelated negated <?isInTagalog>} );
ok("\c[GEORGIAN LETTER BAN]"  ~~ m/^<-isInTagalog>$/, q{Match unrelated inverted <?isInTagalog>} );
ok("\c[GEORGIAN LETTER BAN]\c[TAGALOG LETTER A]" ~~ m/<?isInTagalog>/, q{Match unanchored <?isInTagalog>} );

# InTagbanwa


ok("\c[TAGBANWA LETTER A]" ~~ m/^<?isInTagbanwa>$/, q{Match <?isInTagbanwa>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<!isInTagbanwa>.$/ ), q{Don't match negated <?isInTagbanwa>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<-isInTagbanwa>$/ ), q{Don't match inverted <?isInTagbanwa>} );
ok(!( "\x[5776]"  ~~ m/^<?isInTagbanwa>$/ ), q{Don't match unrelated <?isInTagbanwa>} );
ok("\x[5776]"  ~~ m/^<!isInTagbanwa>.$/, q{Match unrelated negated <?isInTagbanwa>} );
ok("\x[5776]"  ~~ m/^<-isInTagbanwa>$/, q{Match unrelated inverted <?isInTagbanwa>} );
ok("\x[5776]\c[TAGBANWA LETTER A]" ~~ m/<?isInTagbanwa>/, q{Match unanchored <?isInTagbanwa>} );

# InTags


ok(!( "\x[3674]"  ~~ m/^<?isInTags>$/ ), q{Don't match unrelated <?isInTags>} );
ok("\x[3674]"  ~~ m/^<!isInTags>.$/, q{Match unrelated negated <?isInTags>} );
ok("\x[3674]"  ~~ m/^<-isInTags>$/, q{Match unrelated inverted <?isInTags>} );

# InTamil


ok("\x[0B80]" ~~ m/^<?isInTamil>$/, q{Match <?isInTamil>} );
ok(!( "\x[0B80]" ~~ m/^<!isInTamil>.$/ ), q{Don't match negated <?isInTamil>} );
ok(!( "\x[0B80]" ~~ m/^<-isInTamil>$/ ), q{Don't match inverted <?isInTamil>} );
ok(!( "\x[B58F]"  ~~ m/^<?isInTamil>$/ ), q{Don't match unrelated <?isInTamil>} );
ok("\x[B58F]"  ~~ m/^<!isInTamil>.$/, q{Match unrelated negated <?isInTamil>} );
ok("\x[B58F]"  ~~ m/^<-isInTamil>$/, q{Match unrelated inverted <?isInTamil>} );
ok("\x[B58F]\x[0B80]" ~~ m/<?isInTamil>/, q{Match unanchored <?isInTamil>} );

# InTelugu


ok("\x[0C00]" ~~ m/^<?isInTelugu>$/, q{Match <?isInTelugu>} );
ok(!( "\x[0C00]" ~~ m/^<!isInTelugu>.$/ ), q{Don't match negated <?isInTelugu>} );
ok(!( "\x[0C00]" ~~ m/^<-isInTelugu>$/ ), q{Don't match inverted <?isInTelugu>} );
ok(!( "\x[8AC5]"  ~~ m/^<?isInTelugu>$/ ), q{Don't match unrelated <?isInTelugu>} );
ok("\x[8AC5]"  ~~ m/^<!isInTelugu>.$/, q{Match unrelated negated <?isInTelugu>} );
ok("\x[8AC5]"  ~~ m/^<-isInTelugu>$/, q{Match unrelated inverted <?isInTelugu>} );
ok("\x[8AC5]\x[0C00]" ~~ m/<?isInTelugu>/, q{Match unanchored <?isInTelugu>} );

# InThaana


ok("\c[THAANA LETTER HAA]" ~~ m/^<?isInThaana>$/, q{Match <?isInThaana>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<!isInThaana>.$/ ), q{Don't match negated <?isInThaana>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<-isInThaana>$/ ), q{Don't match inverted <?isInThaana>} );
ok(!( "\x[BB8F]"  ~~ m/^<?isInThaana>$/ ), q{Don't match unrelated <?isInThaana>} );
ok("\x[BB8F]"  ~~ m/^<!isInThaana>.$/, q{Match unrelated negated <?isInThaana>} );
ok("\x[BB8F]"  ~~ m/^<-isInThaana>$/, q{Match unrelated inverted <?isInThaana>} );
ok("\x[BB8F]\c[THAANA LETTER HAA]" ~~ m/<?isInThaana>/, q{Match unanchored <?isInThaana>} );

# InThai


ok("\x[0E00]" ~~ m/^<?isInThai>$/, q{Match <?isInThai>} );
ok(!( "\x[0E00]" ~~ m/^<!isInThai>.$/ ), q{Don't match negated <?isInThai>} );
ok(!( "\x[0E00]" ~~ m/^<-isInThai>$/ ), q{Don't match inverted <?isInThai>} );
ok(!( "\x[9395]"  ~~ m/^<?isInThai>$/ ), q{Don't match unrelated <?isInThai>} );
ok("\x[9395]"  ~~ m/^<!isInThai>.$/, q{Match unrelated negated <?isInThai>} );
ok("\x[9395]"  ~~ m/^<-isInThai>$/, q{Match unrelated inverted <?isInThai>} );
ok("\x[9395]\x[0E00]" ~~ m/<?isInThai>/, q{Match unanchored <?isInThai>} );

# InTibetan


ok("\c[TIBETAN SYLLABLE OM]" ~~ m/^<?isInTibetan>$/, q{Match <?isInTibetan>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<!isInTibetan>.$/ ), q{Don't match negated <?isInTibetan>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<-isInTibetan>$/ ), q{Don't match inverted <?isInTibetan>} );
ok(!( "\x[957A]"  ~~ m/^<?isInTibetan>$/ ), q{Don't match unrelated <?isInTibetan>} );
ok("\x[957A]"  ~~ m/^<!isInTibetan>.$/, q{Match unrelated negated <?isInTibetan>} );
ok("\x[957A]"  ~~ m/^<-isInTibetan>$/, q{Match unrelated inverted <?isInTibetan>} );
ok("\x[957A]\c[TIBETAN SYLLABLE OM]" ~~ m/<?isInTibetan>/, q{Match unanchored <?isInTibetan>} );

# InUnifiedCanadianAboriginalSyllabics


ok("\x[1400]" ~~ m/^<?isInUnifiedCanadianAboriginalSyllabics>$/, q{Match <?isInUnifiedCanadianAboriginalSyllabics>} );
ok(!( "\x[1400]" ~~ m/^<!isInUnifiedCanadianAboriginalSyllabics>.$/ ), q{Don't match negated <?isInUnifiedCanadianAboriginalSyllabics>} );
ok(!( "\x[1400]" ~~ m/^<-isInUnifiedCanadianAboriginalSyllabics>$/ ), q{Don't match inverted <?isInUnifiedCanadianAboriginalSyllabics>} );
ok(!( "\x[9470]"  ~~ m/^<?isInUnifiedCanadianAboriginalSyllabics>$/ ), q{Don't match unrelated <?isInUnifiedCanadianAboriginalSyllabics>} );
ok("\x[9470]"  ~~ m/^<!isInUnifiedCanadianAboriginalSyllabics>.$/, q{Match unrelated negated <?isInUnifiedCanadianAboriginalSyllabics>} );
ok("\x[9470]"  ~~ m/^<-isInUnifiedCanadianAboriginalSyllabics>$/, q{Match unrelated inverted <?isInUnifiedCanadianAboriginalSyllabics>} );
ok("\x[9470]\x[1400]" ~~ m/<?isInUnifiedCanadianAboriginalSyllabics>/, q{Match unanchored <?isInUnifiedCanadianAboriginalSyllabics>} );

# InVariationSelectors


ok(!( "\x[764D]"  ~~ m/^<?isInVariationSelectors>$/ ), q{Don't match unrelated <?isInVariationSelectors>} );
ok("\x[764D]"  ~~ m/^<!isInVariationSelectors>.$/, q{Match unrelated negated <?isInVariationSelectors>} );
ok("\x[764D]"  ~~ m/^<-isInVariationSelectors>$/, q{Match unrelated inverted <?isInVariationSelectors>} );

# InYiRadicals


ok("\c[YI RADICAL QOT]" ~~ m/^<?isInYiRadicals>$/, q{Match <?isInYiRadicals>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<!isInYiRadicals>.$/ ), q{Don't match negated <?isInYiRadicals>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-isInYiRadicals>$/ ), q{Don't match inverted <?isInYiRadicals>} );
ok(!( "\x[3A4E]"  ~~ m/^<?isInYiRadicals>$/ ), q{Don't match unrelated <?isInYiRadicals>} );
ok("\x[3A4E]"  ~~ m/^<!isInYiRadicals>.$/, q{Match unrelated negated <?isInYiRadicals>} );
ok("\x[3A4E]"  ~~ m/^<-isInYiRadicals>$/, q{Match unrelated inverted <?isInYiRadicals>} );
ok("\x[3A4E]\c[YI RADICAL QOT]" ~~ m/<?isInYiRadicals>/, q{Match unanchored <?isInYiRadicals>} );

# InYiSyllables


ok("\c[YI SYLLABLE IT]" ~~ m/^<?isInYiSyllables>$/, q{Match <?isInYiSyllables>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<!isInYiSyllables>.$/ ), q{Don't match negated <?isInYiSyllables>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<-isInYiSyllables>$/ ), q{Don't match inverted <?isInYiSyllables>} );
ok(!( "\c[PARALLEL WITH HORIZONTAL STROKE]"  ~~ m/^<?isInYiSyllables>$/ ), q{Don't match unrelated <?isInYiSyllables>} );
ok("\c[PARALLEL WITH HORIZONTAL STROKE]"  ~~ m/^<!isInYiSyllables>.$/, q{Match unrelated negated <?isInYiSyllables>} );
ok("\c[PARALLEL WITH HORIZONTAL STROKE]"  ~~ m/^<-isInYiSyllables>$/, q{Match unrelated inverted <?isInYiSyllables>} );
ok("\c[PARALLEL WITH HORIZONTAL STROKE]\c[YI SYLLABLE IT]" ~~ m/<?isInYiSyllables>/, q{Match unanchored <?isInYiSyllables>} );


}

