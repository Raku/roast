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
   U+137D : just beyond the Ethiopic block

=end pod

plan 594;

# L           Letter


ok("\x[846D]" ~~ m/^<isL>$/, q{Match <isL> (Letter)} );
ok(!( "\x[846D]" ~~ m/^<!isL>.$/ ), q{Don't match negated <isL> (Letter)} );
ok(!( "\x[846D]" ~~ m/^<-isL>$/ ), q{Don't match inverted <isL> (Letter)} );
#?rakudo 3 skip "Uninvestigated nqp-rx regression"
ok(!( "\x[9FC4]"  ~~ m/^<isL>$/ ), q{Don't match unrelated <isL> (Letter)} );
ok("\x[9FC4]"  ~~ m/^<!isL>.$/, q{Match unrelated negated <isL> (Letter)} );
ok("\x[9FC4]"  ~~ m/^<-isL>$/, q{Match unrelated inverted <isL> (Letter)} );
ok("\x[9FC4]\x[846D]" ~~ m/<isL>/, q{Match unanchored <isL> (Letter)} );

ok("\x[6DF7]" ~~ m/^<.isLetter>$/, q{Match <.isLetter>} );
ok(!( "\x[6DF7]" ~~ m/^<!isLetter>.$/ ), q{Don't match negated <isLetter>} );
ok(!( "\x[6DF7]" ~~ m/^<-isLetter>$/ ), q{Don't match inverted <isLetter>} );
#?rakudo 3 skip "Uninvestigated nqp-rx regression"
ok(!( "\x[9FC4]"  ~~ m/^<.isLetter>$/ ), q{Don't match unrelated <isLetter>} );
ok("\x[9FC4]"  ~~ m/^<!isLetter>.$/, q{Match unrelated negated <isLetter>} );
ok("\x[9FC4]"  ~~ m/^<-isLetter>$/, q{Match unrelated inverted <isLetter>} );
ok("\x[9FC4]\x[6DF7]" ~~ m/<.isLetter>/, q{Match unanchored <isLetter>} );

# Lu          UppercaseLetter


ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<.isLu>$/, q{Match <.isLu> (UppercaseLetter)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<!isLu>.$/ ), q{Don't match negated <isLu> (UppercaseLetter)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-isLu>$/ ), q{Don't match inverted <isLu> (UppercaseLetter)} );
ok(!( "\x[C767]"  ~~ m/^<.isLu>$/ ), q{Don't match unrelated <isLu> (UppercaseLetter)} );
ok("\x[C767]"  ~~ m/^<!isLu>.$/, q{Match unrelated negated <isLu> (UppercaseLetter)} );
ok("\x[C767]"  ~~ m/^<-isLu>$/, q{Match unrelated inverted <isLu> (UppercaseLetter)} );
ok(!( "\x[C767]" ~~ m/^<.isLu>$/ ), q{Don't match related <isLu> (UppercaseLetter)} );
ok("\x[C767]" ~~ m/^<!isLu>.$/, q{Match related negated <isLu> (UppercaseLetter)} );
ok("\x[C767]" ~~ m/^<-isLu>$/, q{Match related inverted <isLu> (UppercaseLetter)} );
ok("\x[C767]\x[C767]\c[LATIN CAPITAL LETTER A]" ~~ m/<.isLu>/, q{Match unanchored <isLu> (UppercaseLetter)} );

ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<.isUppercaseLetter>$/, q{Match <.isUppercaseLetter>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<!isUppercaseLetter>.$/ ), q{Don't match negated <isUppercaseLetter>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-isUppercaseLetter>$/ ), q{Don't match inverted <isUppercaseLetter>} );
ok(!( "\c[YI SYLLABLE NBA]"  ~~ m/^<.isUppercaseLetter>$/ ), q{Don't match unrelated <isUppercaseLetter>} );
ok("\c[YI SYLLABLE NBA]"  ~~ m/^<!isUppercaseLetter>.$/, q{Match unrelated negated <isUppercaseLetter>} );
ok("\c[YI SYLLABLE NBA]"  ~~ m/^<-isUppercaseLetter>$/, q{Match unrelated inverted <isUppercaseLetter>} );
ok("\c[YI SYLLABLE NBA]\c[LATIN CAPITAL LETTER A]" ~~ m/<.isUppercaseLetter>/, q{Match unanchored <isUppercaseLetter>} );

# Ll          LowercaseLetter


ok("\c[LATIN SMALL LETTER A]" ~~ m/^<.isLl>$/, q{Match <.isLl> (LowercaseLetter)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<!isLl>.$/ ), q{Don't match negated <isLl> (LowercaseLetter)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<-isLl>$/ ), q{Don't match inverted <isLl> (LowercaseLetter)} );
ok(!( "\c[BOPOMOFO FINAL LETTER H]"  ~~ m/^<.isLl>$/ ), q{Don't match unrelated <isLl> (LowercaseLetter)} );
ok("\c[BOPOMOFO FINAL LETTER H]"  ~~ m/^<!isLl>.$/, q{Match unrelated negated <isLl> (LowercaseLetter)} );
ok("\c[BOPOMOFO FINAL LETTER H]"  ~~ m/^<-isLl>$/, q{Match unrelated inverted <isLl> (LowercaseLetter)} );
ok(!( "\c[BOPOMOFO FINAL LETTER H]" ~~ m/^<.isLl>$/ ), q{Don't match related <isLl> (LowercaseLetter)} );
ok("\c[BOPOMOFO FINAL LETTER H]" ~~ m/^<!isLl>.$/, q{Match related negated <isLl> (LowercaseLetter)} );
ok("\c[BOPOMOFO FINAL LETTER H]" ~~ m/^<-isLl>$/, q{Match related inverted <isLl> (LowercaseLetter)} );
ok("\c[BOPOMOFO FINAL LETTER H]\c[BOPOMOFO FINAL LETTER H]\c[LATIN SMALL LETTER A]" ~~ m/<.isLl>/, q{Match unanchored <isLl> (LowercaseLetter)} );

ok("\c[LATIN SMALL LETTER A]" ~~ m/^<.isLowercaseLetter>$/, q{Match <.isLowercaseLetter>} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<!isLowercaseLetter>.$/ ), q{Don't match negated <isLowercaseLetter>} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<-isLowercaseLetter>$/ ), q{Don't match inverted <isLowercaseLetter>} );
ok(!( "\x[86CA]"  ~~ m/^<.isLowercaseLetter>$/ ), q{Don't match unrelated <isLowercaseLetter>} );
ok("\x[86CA]"  ~~ m/^<!isLowercaseLetter>.$/, q{Match unrelated negated <isLowercaseLetter>} );
ok("\x[86CA]"  ~~ m/^<-isLowercaseLetter>$/, q{Match unrelated inverted <isLowercaseLetter>} );
ok(!( "\x[86CA]" ~~ m/^<.isLowercaseLetter>$/ ), q{Don't match related <isLowercaseLetter>} );
ok("\x[86CA]" ~~ m/^<!isLowercaseLetter>.$/, q{Match related negated <isLowercaseLetter>} );
ok("\x[86CA]" ~~ m/^<-isLowercaseLetter>$/, q{Match related inverted <isLowercaseLetter>} );
ok("\x[86CA]\x[86CA]\c[LATIN SMALL LETTER A]" ~~ m/<.isLowercaseLetter>/, q{Match unanchored <isLowercaseLetter>} );

# Lt          TitlecaseLetter


ok("\c[LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON]" ~~ m/^<.isLt>$/, q{Match <.isLt> (TitlecaseLetter)} );
ok(!( "\c[LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON]" ~~ m/^<!isLt>.$/ ), q{Don't match negated <isLt> (TitlecaseLetter)} );
ok(!( "\c[LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON]" ~~ m/^<-isLt>$/ ), q{Don't match inverted <isLt> (TitlecaseLetter)} );
ok(!( "\x[6DC8]"  ~~ m/^<.isLt>$/ ), q{Don't match unrelated <isLt> (TitlecaseLetter)} );
ok("\x[6DC8]"  ~~ m/^<!isLt>.$/, q{Match unrelated negated <isLt> (TitlecaseLetter)} );
ok("\x[6DC8]"  ~~ m/^<-isLt>$/, q{Match unrelated inverted <isLt> (TitlecaseLetter)} );
ok(!( "\x[6DC8]" ~~ m/^<.isLt>$/ ), q{Don't match related <isLt> (TitlecaseLetter)} );
ok("\x[6DC8]" ~~ m/^<!isLt>.$/, q{Match related negated <isLt> (TitlecaseLetter)} );
ok("\x[6DC8]" ~~ m/^<-isLt>$/, q{Match related inverted <isLt> (TitlecaseLetter)} );
ok("\x[6DC8]\x[6DC8]\c[LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON]" ~~ m/<.isLt>/, q{Match unanchored <isLt> (TitlecaseLetter)} );

ok("\c[GREEK CAPITAL LETTER ALPHA WITH PSILI AND PROSGEGRAMMENI]" ~~ m/^<.isTitlecaseLetter>$/, q{Match <.isTitlecaseLetter>} );
ok(!( "\c[GREEK CAPITAL LETTER ALPHA WITH PSILI AND PROSGEGRAMMENI]" ~~ m/^<!isTitlecaseLetter>.$/ ), q{Don't match negated <isTitlecaseLetter>} );
ok(!( "\c[GREEK CAPITAL LETTER ALPHA WITH PSILI AND PROSGEGRAMMENI]" ~~ m/^<-isTitlecaseLetter>$/ ), q{Don't match inverted <isTitlecaseLetter>} );
ok(!( "\x[0C4E]"  ~~ m/^<.isTitlecaseLetter>$/ ), q{Don't match unrelated <isTitlecaseLetter>} );
ok("\x[0C4E]"  ~~ m/^<!isTitlecaseLetter>.$/, q{Match unrelated negated <isTitlecaseLetter>} );
ok("\x[0C4E]"  ~~ m/^<-isTitlecaseLetter>$/, q{Match unrelated inverted <isTitlecaseLetter>} );
ok("\x[0C4E]\c[GREEK CAPITAL LETTER ALPHA WITH PSILI AND PROSGEGRAMMENI]" ~~ m/<.isTitlecaseLetter>/, q{Match unanchored <isTitlecaseLetter>} );

# Lm          ModifierLetter


ok("\c[IDEOGRAPHIC ITERATION MARK]" ~~ m/^<.isLm>$/, q{Match <.isLm> (ModifierLetter)} );
ok(!( "\c[IDEOGRAPHIC ITERATION MARK]" ~~ m/^<!isLm>.$/ ), q{Don't match negated <isLm> (ModifierLetter)} );
ok(!( "\c[IDEOGRAPHIC ITERATION MARK]" ~~ m/^<-isLm>$/ ), q{Don't match inverted <isLm> (ModifierLetter)} );
ok(!( "\x[2B61]"  ~~ m/^<.isLm>$/ ), q{Don't match unrelated <isLm> (ModifierLetter)} );
ok("\x[2B61]"  ~~ m/^<!isLm>.$/, q{Match unrelated negated <isLm> (ModifierLetter)} );
ok("\x[2B61]"  ~~ m/^<-isLm>$/, q{Match unrelated inverted <isLm> (ModifierLetter)} );
ok(!( "\c[IDEOGRAPHIC CLOSING MARK]" ~~ m/^<.isLm>$/ ), q{Don't match related <isLm> (ModifierLetter)} );
ok("\c[IDEOGRAPHIC CLOSING MARK]" ~~ m/^<!isLm>.$/, q{Match related negated <isLm> (ModifierLetter)} );
ok("\c[IDEOGRAPHIC CLOSING MARK]" ~~ m/^<-isLm>$/, q{Match related inverted <isLm> (ModifierLetter)} );
ok("\x[2B61]\c[IDEOGRAPHIC CLOSING MARK]\c[IDEOGRAPHIC ITERATION MARK]" ~~ m/<.isLm>/, q{Match unanchored <isLm> (ModifierLetter)} );

ok("\c[MODIFIER LETTER SMALL H]" ~~ m/^<.isModifierLetter>$/, q{Match <.isModifierLetter>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<!isModifierLetter>.$/ ), q{Don't match negated <isModifierLetter>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<-isModifierLetter>$/ ), q{Don't match inverted <isModifierLetter>} );
ok(!( "\c[YI SYLLABLE HA]"  ~~ m/^<.isModifierLetter>$/ ), q{Don't match unrelated <isModifierLetter>} );
ok("\c[YI SYLLABLE HA]"  ~~ m/^<!isModifierLetter>.$/, q{Match unrelated negated <isModifierLetter>} );
ok("\c[YI SYLLABLE HA]"  ~~ m/^<-isModifierLetter>$/, q{Match unrelated inverted <isModifierLetter>} );
ok("\c[YI SYLLABLE HA]\c[MODIFIER LETTER SMALL H]" ~~ m/<.isModifierLetter>/, q{Match unanchored <isModifierLetter>} );

# Lo          OtherLetter


ok("\c[LATIN LETTER TWO WITH STROKE]" ~~ m/^<.isLo>$/, q{Match <.isLo> (OtherLetter)} );
ok(!( "\c[LATIN LETTER TWO WITH STROKE]" ~~ m/^<!isLo>.$/ ), q{Don't match negated <isLo> (OtherLetter)} );
ok(!( "\c[LATIN LETTER TWO WITH STROKE]" ~~ m/^<-isLo>$/ ), q{Don't match inverted <isLo> (OtherLetter)} );
ok(!( "\c[LATIN SMALL LETTER TURNED DELTA]"  ~~ m/^<.isLo>$/ ), q{Don't match unrelated <isLo> (OtherLetter)} );
ok("\c[LATIN SMALL LETTER TURNED DELTA]"  ~~ m/^<!isLo>.$/, q{Match unrelated negated <isLo> (OtherLetter)} );
ok("\c[LATIN SMALL LETTER TURNED DELTA]"  ~~ m/^<-isLo>$/, q{Match unrelated inverted <isLo> (OtherLetter)} );
ok(!( "\c[LATIN SMALL LETTER TURNED DELTA]" ~~ m/^<.isLo>$/ ), q{Don't match related <isLo> (OtherLetter)} );
ok("\c[LATIN SMALL LETTER TURNED DELTA]" ~~ m/^<!isLo>.$/, q{Match related negated <isLo> (OtherLetter)} );
ok("\c[LATIN SMALL LETTER TURNED DELTA]" ~~ m/^<-isLo>$/, q{Match related inverted <isLo> (OtherLetter)} );
ok("\c[LATIN SMALL LETTER TURNED DELTA]\c[LATIN SMALL LETTER TURNED DELTA]\c[LATIN LETTER TWO WITH STROKE]" ~~ m/<.isLo>/, q{Match unanchored <isLo> (OtherLetter)} );

ok("\c[ETHIOPIC SYLLABLE GLOTTAL A]" ~~ m/^<.isOtherLetter>$/, q{Match <.isOtherLetter>} );
ok(!( "\c[ETHIOPIC SYLLABLE GLOTTAL A]" ~~ m/^<!isOtherLetter>.$/ ), q{Don't match negated <isOtherLetter>} );
ok(!( "\c[ETHIOPIC SYLLABLE GLOTTAL A]" ~~ m/^<-isOtherLetter>$/ ), q{Don't match inverted <isOtherLetter>} );
ok(!( "\x[137D]"  ~~ m/^<.isOtherLetter>$/ ), q{Don't match unrelated <isOtherLetter>} );
ok("\x[137D]"  ~~ m/^<!isOtherLetter>.$/, q{Match unrelated negated <isOtherLetter>} );
ok("\x[137D]"  ~~ m/^<-isOtherLetter>$/, q{Match unrelated inverted <isOtherLetter>} );
ok("\x[137D]\c[ETHIOPIC SYLLABLE GLOTTAL A]" ~~ m/<.isOtherLetter>/, q{Match unanchored <isOtherLetter>} );

# Lr             # Alias for "Ll", "Lu", and "Lt".


#?rakudo 10 skip "No [Lr] property defined"
ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<.isLr>$/, q{Match (Alias for "Ll", "Lu", and "Lt".)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<!isLr>.$/ ), q{Don't match negated (Alias for "Ll", "Lu", and "Lt".)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-isLr>$/ ), q{Don't match inverted (Alias for "Ll", "Lu", and "Lt".)} );
ok(!( "\x[87B5]"  ~~ m/^<.isLr>$/ ), q{Don't match unrelated (Alias for "Ll", "Lu", and "Lt".)} );
ok("\x[87B5]"  ~~ m/^<!isLr>.$/, q{Match unrelated negated (Alias for "Ll", "Lu", and "Lt".)} );
ok("\x[87B5]"  ~~ m/^<-isLr>$/, q{Match unrelated inverted (Alias for "Ll", "Lu", and "Lt".)} );
ok(!( "\x[87B5]" ~~ m/^<.isLr>$/ ), q{Don't match related (Alias for "Ll", "Lu", and "Lt".)} );
ok("\x[87B5]" ~~ m/^<!isLr>.$/, q{Match related negated (Alias for "Ll", "Lu", and "Lt".)} );
ok("\x[87B5]" ~~ m/^<-isLr>$/, q{Match related inverted (Alias for "Ll", "Lu", and "Lt".)} );
ok("\x[87B5]\x[87B5]\c[LATIN CAPITAL LETTER A]" ~~ m/<.isLr>/, q{Match unanchored (Alias for "Ll", "Lu", and "Lt".)} );


# M           Mark


ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<isM>$/, q{Match <isM> (Mark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isM>.$/ ), q{Don't match negated <isM> (Mark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isM>$/ ), q{Don't match inverted <isM> (Mark)} );
ok(!( "\x[D0AA]"  ~~ m/^<isM>$/ ), q{Don't match unrelated <isM> (Mark)} );
ok("\x[D0AA]"  ~~ m/^<!isM>.$/, q{Match unrelated negated <isM> (Mark)} );
ok("\x[D0AA]"  ~~ m/^<-isM>$/, q{Match unrelated inverted <isM> (Mark)} );
ok("\x[D0AA]\c[COMBINING GRAVE ACCENT]" ~~ m/<isM>/, q{Match unanchored <isM> (Mark)} );

ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<.isMark>$/, q{Match <.isMark>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isMark>.$/ ), q{Don't match negated <isMark>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isMark>$/ ), q{Don't match inverted <isMark>} );
ok(!( "\x[BE64]"  ~~ m/^<.isMark>$/ ), q{Don't match unrelated <isMark>} );
ok("\x[BE64]"  ~~ m/^<!isMark>.$/, q{Match unrelated negated <isMark>} );
ok("\x[BE64]"  ~~ m/^<-isMark>$/, q{Match unrelated inverted <isMark>} );
ok("\x[BE64]\c[COMBINING GRAVE ACCENT]" ~~ m/<.isMark>/, q{Match unanchored <isMark>} );

# Mn          NonspacingMark


ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<.isMn>$/, q{Match <.isMn> (NonspacingMark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isMn>.$/ ), q{Don't match negated <isMn> (NonspacingMark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isMn>$/ ), q{Don't match inverted <isMn> (NonspacingMark)} );
ok(!( "\x[47A5]"  ~~ m/^<.isMn>$/ ), q{Don't match unrelated <isMn> (NonspacingMark)} );
ok("\x[47A5]"  ~~ m/^<!isMn>.$/, q{Match unrelated negated <isMn> (NonspacingMark)} );
ok("\x[47A5]"  ~~ m/^<-isMn>$/, q{Match unrelated inverted <isMn> (NonspacingMark)} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<.isMn>$/ ), q{Don't match related <isMn> (NonspacingMark)} );
ok("\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<!isMn>.$/, q{Match related negated <isMn> (NonspacingMark)} );
ok("\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<-isMn>$/, q{Match related inverted <isMn> (NonspacingMark)} );
ok("\x[47A5]\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]\c[COMBINING GRAVE ACCENT]" ~~ m/<.isMn>/, q{Match unanchored <isMn> (NonspacingMark)} );

ok("\c[TAGALOG VOWEL SIGN I]" ~~ m/^<.isNonspacingMark>$/, q{Match <.isNonspacingMark>} );
ok(!( "\c[TAGALOG VOWEL SIGN I]" ~~ m/^<!isNonspacingMark>.$/ ), q{Don't match negated <isNonspacingMark>} );
ok(!( "\c[TAGALOG VOWEL SIGN I]" ~~ m/^<-isNonspacingMark>$/ ), q{Don't match inverted <isNonspacingMark>} );
ok(!( "\c[CANADIAN SYLLABICS TYA]"  ~~ m/^<.isNonspacingMark>$/ ), q{Don't match unrelated <isNonspacingMark>} );
ok("\c[CANADIAN SYLLABICS TYA]"  ~~ m/^<!isNonspacingMark>.$/, q{Match unrelated negated <isNonspacingMark>} );
ok("\c[CANADIAN SYLLABICS TYA]"  ~~ m/^<-isNonspacingMark>$/, q{Match unrelated inverted <isNonspacingMark>} );
ok("\c[CANADIAN SYLLABICS TYA]\c[TAGALOG VOWEL SIGN I]" ~~ m/<.isNonspacingMark>/, q{Match unanchored <isNonspacingMark>} );

# Mc          SpacingMark


ok("\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<.isMc>$/, q{Match <.isMc> (SpacingMark)} );
ok(!( "\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<!isMc>.$/ ), q{Don't match negated <isMc> (SpacingMark)} );
ok(!( "\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<-isMc>$/ ), q{Don't match inverted <isMc> (SpacingMark)} );
ok(!( "\x[9981]"  ~~ m/^<.isMc>$/ ), q{Don't match unrelated <isMc> (SpacingMark)} );
ok("\x[9981]"  ~~ m/^<!isMc>.$/, q{Match unrelated negated <isMc> (SpacingMark)} );
ok("\x[9981]"  ~~ m/^<-isMc>$/, q{Match unrelated inverted <isMc> (SpacingMark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<.isMc>$/ ), q{Don't match related <isMc> (SpacingMark)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isMc>.$/, q{Match related negated <isMc> (SpacingMark)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isMc>$/, q{Match related inverted <isMc> (SpacingMark)} );
ok("\x[9981]\c[COMBINING GRAVE ACCENT]\c[DEVANAGARI SIGN VISARGA]" ~~ m/<.isMc>/, q{Match unanchored <isMc> (SpacingMark)} );

ok("\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<.isSpacingMark>$/, q{Match <.isSpacingMark>} );
ok(!( "\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<!isSpacingMark>.$/ ), q{Don't match negated <isSpacingMark>} );
ok(!( "\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<-isSpacingMark>$/ ), q{Don't match inverted <isSpacingMark>} );
ok(!( "\x[35E3]"  ~~ m/^<.isSpacingMark>$/ ), q{Don't match unrelated <isSpacingMark>} );
ok("\x[35E3]"  ~~ m/^<!isSpacingMark>.$/, q{Match unrelated negated <isSpacingMark>} );
ok("\x[35E3]"  ~~ m/^<-isSpacingMark>$/, q{Match unrelated inverted <isSpacingMark>} );
ok("\x[35E3]\c[DEVANAGARI SIGN VISARGA]" ~~ m/<.isSpacingMark>/, q{Match unanchored <isSpacingMark>} );

# Me          EnclosingMark


ok("\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<.isMe>$/, q{Match <.isMe> (EnclosingMark)} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<!isMe>.$/ ), q{Don't match negated <isMe> (EnclosingMark)} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<-isMe>$/ ), q{Don't match inverted <isMe> (EnclosingMark)} );
ok(!( "\x[9400]"  ~~ m/^<.isMe>$/ ), q{Don't match unrelated <isMe> (EnclosingMark)} );
ok("\x[9400]"  ~~ m/^<!isMe>.$/, q{Match unrelated negated <isMe> (EnclosingMark)} );
ok("\x[9400]"  ~~ m/^<-isMe>$/, q{Match unrelated inverted <isMe> (EnclosingMark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<.isMe>$/ ), q{Don't match related <isMe> (EnclosingMark)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isMe>.$/, q{Match related negated <isMe> (EnclosingMark)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isMe>$/, q{Match related inverted <isMe> (EnclosingMark)} );
ok("\x[9400]\c[COMBINING GRAVE ACCENT]\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/<.isMe>/, q{Match unanchored <isMe> (EnclosingMark)} );

ok("\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<.isEnclosingMark>$/, q{Match <.isEnclosingMark>} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<!isEnclosingMark>.$/ ), q{Don't match negated <isEnclosingMark>} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<-isEnclosingMark>$/ ), q{Don't match inverted <isEnclosingMark>} );
ok(!( "\x[7C68]"  ~~ m/^<.isEnclosingMark>$/ ), q{Don't match unrelated <isEnclosingMark>} );
ok("\x[7C68]"  ~~ m/^<!isEnclosingMark>.$/, q{Match unrelated negated <isEnclosingMark>} );
ok("\x[7C68]"  ~~ m/^<-isEnclosingMark>$/, q{Match unrelated inverted <isEnclosingMark>} );
ok("\x[7C68]\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/<.isEnclosingMark>/, q{Match unanchored <isEnclosingMark>} );


# N           Number


ok("\c[SUPERSCRIPT ZERO]" ~~ m/^<isN>$/, q{Match <isN> (Number)} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<!isN>.$/ ), q{Don't match negated <isN> (Number)} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<-isN>$/ ), q{Don't match inverted <isN> (Number)} );
ok(!( "\c[LATIN LETTER SMALL CAPITAL E]"  ~~ m/^<isN>$/ ), q{Don't match unrelated <isN> (Number)} );
ok("\c[LATIN LETTER SMALL CAPITAL E]"  ~~ m/^<!isN>.$/, q{Match unrelated negated <isN> (Number)} );
ok("\c[LATIN LETTER SMALL CAPITAL E]"  ~~ m/^<-isN>$/, q{Match unrelated inverted <isN> (Number)} );
ok("\c[LATIN LETTER SMALL CAPITAL E]\c[SUPERSCRIPT ZERO]" ~~ m/<isN>/, q{Match unanchored <isN> (Number)} );

ok("\c[DIGIT ZERO]" ~~ m/^<.isNumber>$/, q{Match <.isNumber>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<!isNumber>.$/ ), q{Don't match negated <isNumber>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-isNumber>$/ ), q{Don't match inverted <isNumber>} );
ok(!( "\x[A994]"  ~~ m/^<.isNumber>$/ ), q{Don't match unrelated <isNumber>} );
ok("\x[A994]"  ~~ m/^<!isNumber>.$/, q{Match unrelated negated <isNumber>} );
ok("\x[A994]"  ~~ m/^<-isNumber>$/, q{Match unrelated inverted <isNumber>} );
ok("\x[A994]\c[DIGIT ZERO]" ~~ m/<.isNumber>/, q{Match unanchored <isNumber>} );

# Nd          DecimalNumber


ok("\c[DIGIT ZERO]" ~~ m/^<.isNd>$/, q{Match <.isNd> (DecimalNumber)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<!isNd>.$/ ), q{Don't match negated <isNd> (DecimalNumber)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-isNd>$/ ), q{Don't match inverted <isNd> (DecimalNumber)} );
ok(!( "\x[4E2C]"  ~~ m/^<.isNd>$/ ), q{Don't match unrelated <isNd> (DecimalNumber)} );
ok("\x[4E2C]"  ~~ m/^<!isNd>.$/, q{Match unrelated negated <isNd> (DecimalNumber)} );
ok("\x[4E2C]"  ~~ m/^<-isNd>$/, q{Match unrelated inverted <isNd> (DecimalNumber)} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<.isNd>$/ ), q{Don't match related <isNd> (DecimalNumber)} );
ok("\c[SUPERSCRIPT TWO]" ~~ m/^<!isNd>.$/, q{Match related negated <isNd> (DecimalNumber)} );
ok("\c[SUPERSCRIPT TWO]" ~~ m/^<-isNd>$/, q{Match related inverted <isNd> (DecimalNumber)} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[4E2C]\c[SUPERSCRIPT TWO]\c[DIGIT ZERO]" ~~ m/<.isNd>/, q{Match unanchored <isNd> (DecimalNumber)} );
ok("\c[DIGIT ZERO]" ~~ m/^<.isDecimalNumber>$/, q{Match <.isDecimalNumber>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<!isDecimalNumber>.$/ ), q{Don't match negated <isDecimalNumber>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-isDecimalNumber>$/ ), q{Don't match inverted <isDecimalNumber>} );
ok(!( "\x[A652]"  ~~ m/^<.isDecimalNumber>$/ ), q{Don't match unrelated <isDecimalNumber>} );
ok("\x[A652]"  ~~ m/^<!isDecimalNumber>.$/, q{Match unrelated negated <isDecimalNumber>} );
ok("\x[A652]"  ~~ m/^<-isDecimalNumber>$/, q{Match unrelated inverted <isDecimalNumber>} );
ok("\x[A652]\c[DIGIT ZERO]" ~~ m/<.isDecimalNumber>/, q{Match unanchored <isDecimalNumber>} );


# Nl          LetterNumber


ok("\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<.isNl>$/, q{Match <.isNl> (LetterNumber)} );
ok(!( "\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<!isNl>.$/ ), q{Don't match negated <isNl> (LetterNumber)} );
ok(!( "\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<-isNl>$/ ), q{Don't match inverted <isNl> (LetterNumber)} );
ok(!( "\x[6C2F]"  ~~ m/^<.isNl>$/ ), q{Don't match unrelated <isNl> (LetterNumber)} );
ok("\x[6C2F]"  ~~ m/^<!isNl>.$/, q{Match unrelated negated <isNl> (LetterNumber)} );
ok("\x[6C2F]"  ~~ m/^<-isNl>$/, q{Match unrelated inverted <isNl> (LetterNumber)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<.isNl>$/ ), q{Don't match related <isNl> (LetterNumber)} );
ok("\c[DIGIT ZERO]" ~~ m/^<!isNl>.$/, q{Match related negated <isNl> (LetterNumber)} );
ok("\c[DIGIT ZERO]" ~~ m/^<-isNl>$/, q{Match related inverted <isNl> (LetterNumber)} );
ok("\x[6C2F]\c[DIGIT ZERO]\c[RUNIC ARLAUG SYMBOL]" ~~ m/<.isNl>/, q{Match unanchored <isNl> (LetterNumber)} );

ok("\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<.isLetterNumber>$/, q{Match <.isLetterNumber>} );
ok(!( "\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<!isLetterNumber>.$/ ), q{Don't match negated <isLetterNumber>} );
ok(!( "\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<-isLetterNumber>$/ ), q{Don't match inverted <isLetterNumber>} );
ok(!( "\x[80A5]"  ~~ m/^<.isLetterNumber>$/ ), q{Don't match unrelated <isLetterNumber>} );
ok("\x[80A5]"  ~~ m/^<!isLetterNumber>.$/, q{Match unrelated negated <isLetterNumber>} );
ok("\x[80A5]"  ~~ m/^<-isLetterNumber>$/, q{Match unrelated inverted <isLetterNumber>} );
ok(!( "\x[80A5]" ~~ m/^<.isLetterNumber>$/ ), q{Don't match related <isLetterNumber>} );
ok("\x[80A5]" ~~ m/^<!isLetterNumber>.$/, q{Match related negated <isLetterNumber>} );
ok("\x[80A5]" ~~ m/^<-isLetterNumber>$/, q{Match related inverted <isLetterNumber>} );
ok("\x[80A5]\x[80A5]\c[RUNIC ARLAUG SYMBOL]" ~~ m/<.isLetterNumber>/, q{Match unanchored <isLetterNumber>} );

# No          OtherNumber


ok("\c[SUPERSCRIPT TWO]" ~~ m/^<.isNo>$/, q{Match <.isNo> (OtherNumber)} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<!isNo>.$/ ), q{Don't match negated <isNo> (OtherNumber)} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<-isNo>$/ ), q{Don't match inverted <isNo> (OtherNumber)} );
ok(!( "\x[92F3]"  ~~ m/^<.isNo>$/ ), q{Don't match unrelated <isNo> (OtherNumber)} );
ok("\x[92F3]"  ~~ m/^<!isNo>.$/, q{Match unrelated negated <isNo> (OtherNumber)} );
ok("\x[92F3]"  ~~ m/^<-isNo>$/, q{Match unrelated inverted <isNo> (OtherNumber)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<.isNo>$/ ), q{Don't match related <isNo> (OtherNumber)} );
ok("\c[DIGIT ZERO]" ~~ m/^<!isNo>.$/, q{Match related negated <isNo> (OtherNumber)} );
ok("\c[DIGIT ZERO]" ~~ m/^<-isNo>$/, q{Match related inverted <isNo> (OtherNumber)} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[92F3]\c[DIGIT ZERO]\c[SUPERSCRIPT TWO]" ~~ m/<.isNo>/, q{Match unanchored <isNo> (OtherNumber)} );

ok("\c[SUPERSCRIPT TWO]" ~~ m/^<.isOtherNumber>$/, q{Match <.isOtherNumber>} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<!isOtherNumber>.$/ ), q{Don't match negated <isOtherNumber>} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<-isOtherNumber>$/ ), q{Don't match inverted <isOtherNumber>} );
ok(!( "\x[5363]"  ~~ m/^<.isOtherNumber>$/ ), q{Don't match unrelated <isOtherNumber>} );
ok("\x[5363]"  ~~ m/^<!isOtherNumber>.$/, q{Match unrelated negated <isOtherNumber>} );
ok("\x[5363]"  ~~ m/^<-isOtherNumber>$/, q{Match unrelated inverted <isOtherNumber>} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[5363]\c[SUPERSCRIPT TWO]" ~~ m/<.isOtherNumber>/, q{Match unanchored <isOtherNumber>} );

# P           Punctuation


ok("\c[EXCLAMATION MARK]" ~~ m/^<isP>$/, q{Match <isP> (Punctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<!isP>.$/ ), q{Don't match negated <isP> (Punctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-isP>$/ ), q{Don't match inverted <isP> (Punctuation)} );
ok(!( "\x[A918]"  ~~ m/^<isP>$/ ), q{Don't match unrelated <isP> (Punctuation)} );
ok("\x[A918]"  ~~ m/^<!isP>.$/, q{Match unrelated negated <isP> (Punctuation)} );
ok("\x[A918]"  ~~ m/^<-isP>$/, q{Match unrelated inverted <isP> (Punctuation)} );
ok("\x[A918]\c[EXCLAMATION MARK]" ~~ m/<isP>/, q{Match unanchored <isP> (Punctuation)} );

ok("\c[EXCLAMATION MARK]" ~~ m/^<.isPunctuation>$/, q{Match <.isPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<!isPunctuation>.$/ ), q{Don't match negated <isPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-isPunctuation>$/ ), q{Don't match inverted <isPunctuation>} );
ok(!( "\x[CE60]"  ~~ m/^<.isPunctuation>$/ ), q{Don't match unrelated <isPunctuation>} );
ok("\x[CE60]"  ~~ m/^<!isPunctuation>.$/, q{Match unrelated negated <isPunctuation>} );
ok("\x[CE60]"  ~~ m/^<-isPunctuation>$/, q{Match unrelated inverted <isPunctuation>} );
ok("\x[CE60]\c[EXCLAMATION MARK]" ~~ m/<.isPunctuation>/, q{Match unanchored <isPunctuation>} );

# Pc          ConnectorPunctuation


ok("\c[LOW LINE]" ~~ m/^<.isPc>$/, q{Match <.isPc> (ConnectorPunctuation)} );
ok(!( "\c[LOW LINE]" ~~ m/^<!isPc>.$/ ), q{Don't match negated <isPc> (ConnectorPunctuation)} );
ok(!( "\c[LOW LINE]" ~~ m/^<-isPc>$/ ), q{Don't match inverted <isPc> (ConnectorPunctuation)} );
ok(!( "\x[5F19]"  ~~ m/^<.isPc>$/ ), q{Don't match unrelated <isPc> (ConnectorPunctuation)} );
ok("\x[5F19]"  ~~ m/^<!isPc>.$/, q{Match unrelated negated <isPc> (ConnectorPunctuation)} );
ok("\x[5F19]"  ~~ m/^<-isPc>$/, q{Match unrelated inverted <isPc> (ConnectorPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<.isPc>$/ ), q{Don't match related <isPc> (ConnectorPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<!isPc>.$/, q{Match related negated <isPc> (ConnectorPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-isPc>$/, q{Match related inverted <isPc> (ConnectorPunctuation)} );
ok("\x[5F19]\c[EXCLAMATION MARK]\c[LOW LINE]" ~~ m/<.isPc>/, q{Match unanchored <isPc> (ConnectorPunctuation)} );

ok("\c[LOW LINE]" ~~ m/^<.isConnectorPunctuation>$/, q{Match <.isConnectorPunctuation>} );
ok(!( "\c[LOW LINE]" ~~ m/^<!isConnectorPunctuation>.$/ ), q{Don't match negated <isConnectorPunctuation>} );
ok(!( "\c[LOW LINE]" ~~ m/^<-isConnectorPunctuation>$/ ), q{Don't match inverted <isConnectorPunctuation>} );
ok(!( "\c[YI SYLLABLE MGOX]"  ~~ m/^<.isConnectorPunctuation>$/ ), q{Don't match unrelated <isConnectorPunctuation>} );
ok("\c[YI SYLLABLE MGOX]"  ~~ m/^<!isConnectorPunctuation>.$/, q{Match unrelated negated <isConnectorPunctuation>} );
ok("\c[YI SYLLABLE MGOX]"  ~~ m/^<-isConnectorPunctuation>$/, q{Match unrelated inverted <isConnectorPunctuation>} );
ok("\c[YI SYLLABLE MGOX]\c[LOW LINE]" ~~ m/<.isConnectorPunctuation>/, q{Match unanchored <isConnectorPunctuation>} );

# Pd          DashPunctuation


ok("\c[HYPHEN-MINUS]" ~~ m/^<.isPd>$/, q{Match <.isPd> (DashPunctuation)} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<!isPd>.$/ ), q{Don't match negated <isPd> (DashPunctuation)} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<-isPd>$/ ), q{Don't match inverted <isPd> (DashPunctuation)} );
ok(!( "\x[49A1]"  ~~ m/^<.isPd>$/ ), q{Don't match unrelated <isPd> (DashPunctuation)} );
ok("\x[49A1]"  ~~ m/^<!isPd>.$/, q{Match unrelated negated <isPd> (DashPunctuation)} );
ok("\x[49A1]"  ~~ m/^<-isPd>$/, q{Match unrelated inverted <isPd> (DashPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<.isPd>$/ ), q{Don't match related <isPd> (DashPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<!isPd>.$/, q{Match related negated <isPd> (DashPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-isPd>$/, q{Match related inverted <isPd> (DashPunctuation)} );
ok("\x[49A1]\c[EXCLAMATION MARK]\c[HYPHEN-MINUS]" ~~ m/<.isPd>/, q{Match unanchored <isPd> (DashPunctuation)} );

ok("\c[HYPHEN-MINUS]" ~~ m/^<.isDashPunctuation>$/, q{Match <.isDashPunctuation>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<!isDashPunctuation>.$/ ), q{Don't match negated <isDashPunctuation>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<-isDashPunctuation>$/ ), q{Don't match inverted <isDashPunctuation>} );
ok(!( "\x[3C6E]"  ~~ m/^<.isDashPunctuation>$/ ), q{Don't match unrelated <isDashPunctuation>} );
ok("\x[3C6E]"  ~~ m/^<!isDashPunctuation>.$/, q{Match unrelated negated <isDashPunctuation>} );
ok("\x[3C6E]"  ~~ m/^<-isDashPunctuation>$/, q{Match unrelated inverted <isDashPunctuation>} );
ok("\x[3C6E]\c[HYPHEN-MINUS]" ~~ m/<.isDashPunctuation>/, q{Match unanchored <isDashPunctuation>} );

# Ps          OpenPunctuation


ok("\c[LEFT PARENTHESIS]" ~~ m/^<.isPs>$/, q{Match <.isPs> (OpenPunctuation)} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<!isPs>.$/ ), q{Don't match negated <isPs> (OpenPunctuation)} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<-isPs>$/ ), q{Don't match inverted <isPs> (OpenPunctuation)} );
ok(!( "\x[C8A5]"  ~~ m/^<.isPs>$/ ), q{Don't match unrelated <isPs> (OpenPunctuation)} );
ok("\x[C8A5]"  ~~ m/^<!isPs>.$/, q{Match unrelated negated <isPs> (OpenPunctuation)} );
ok("\x[C8A5]"  ~~ m/^<-isPs>$/, q{Match unrelated inverted <isPs> (OpenPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<.isPs>$/ ), q{Don't match related <isPs> (OpenPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<!isPs>.$/, q{Match related negated <isPs> (OpenPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-isPs>$/, q{Match related inverted <isPs> (OpenPunctuation)} );
ok("\x[C8A5]\c[EXCLAMATION MARK]\c[LEFT PARENTHESIS]" ~~ m/<.isPs>/, q{Match unanchored <isPs> (OpenPunctuation)} );

ok("\c[LEFT PARENTHESIS]" ~~ m/^<.isOpenPunctuation>$/, q{Match <.isOpenPunctuation>} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<!isOpenPunctuation>.$/ ), q{Don't match negated <isOpenPunctuation>} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<-isOpenPunctuation>$/ ), q{Don't match inverted <isOpenPunctuation>} );
ok(!( "\x[84B8]"  ~~ m/^<.isOpenPunctuation>$/ ), q{Don't match unrelated <isOpenPunctuation>} );
ok("\x[84B8]"  ~~ m/^<!isOpenPunctuation>.$/, q{Match unrelated negated <isOpenPunctuation>} );
ok("\x[84B8]"  ~~ m/^<-isOpenPunctuation>$/, q{Match unrelated inverted <isOpenPunctuation>} );
ok("\x[84B8]\c[LEFT PARENTHESIS]" ~~ m/<.isOpenPunctuation>/, q{Match unanchored <isOpenPunctuation>} );

# Pe          ClosePunctuation


ok("\c[RIGHT PARENTHESIS]" ~~ m/^<.isPe>$/, q{Match <.isPe> (ClosePunctuation)} );
ok(!( "\c[RIGHT PARENTHESIS]" ~~ m/^<!isPe>.$/ ), q{Don't match negated <isPe> (ClosePunctuation)} );
ok(!( "\c[RIGHT PARENTHESIS]" ~~ m/^<-isPe>$/ ), q{Don't match inverted <isPe> (ClosePunctuation)} );
ok(!( "\x[BB92]"  ~~ m/^<.isPe>$/ ), q{Don't match unrelated <isPe> (ClosePunctuation)} );
ok("\x[BB92]"  ~~ m/^<!isPe>.$/, q{Match unrelated negated <isPe> (ClosePunctuation)} );
ok("\x[BB92]"  ~~ m/^<-isPe>$/, q{Match unrelated inverted <isPe> (ClosePunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<.isPe>$/ ), q{Don't match related <isPe> (ClosePunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<!isPe>.$/, q{Match related negated <isPe> (ClosePunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-isPe>$/, q{Match related inverted <isPe> (ClosePunctuation)} );
ok("\x[BB92]\c[EXCLAMATION MARK]\c[RIGHT PARENTHESIS]" ~~ m/<.isPe>/, q{Match unanchored <isPe> (ClosePunctuation)} );

ok("\c[RIGHT PARENTHESIS]" ~~ m/^<.isClosePunctuation>$/, q{Match <.isClosePunctuation>} );
ok(!( "\c[RIGHT PARENTHESIS]" ~~ m/^<!isClosePunctuation>.$/ ), q{Don't match negated <isClosePunctuation>} );
ok(!( "\c[RIGHT PARENTHESIS]" ~~ m/^<-isClosePunctuation>$/ ), q{Don't match inverted <isClosePunctuation>} );
ok(!( "\x[D55D]"  ~~ m/^<.isClosePunctuation>$/ ), q{Don't match unrelated <isClosePunctuation>} );
ok("\x[D55D]"  ~~ m/^<!isClosePunctuation>.$/, q{Match unrelated negated <isClosePunctuation>} );
ok("\x[D55D]"  ~~ m/^<-isClosePunctuation>$/, q{Match unrelated inverted <isClosePunctuation>} );
ok("\x[D55D]\c[RIGHT PARENTHESIS]" ~~ m/<.isClosePunctuation>/, q{Match unanchored <isClosePunctuation>} );

# Pi          InitialPunctuation


ok("\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<.isPi>$/, q{Match <.isPi> (InitialPunctuation)} );
ok(!( "\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<!isPi>.$/ ), q{Don't match negated <isPi> (InitialPunctuation)} );
ok(!( "\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<-isPi>$/ ), q{Don't match inverted <isPi> (InitialPunctuation)} );
ok(!( "\x[3A35]"  ~~ m/^<.isPi>$/ ), q{Don't match unrelated <isPi> (InitialPunctuation)} );
ok("\x[3A35]"  ~~ m/^<!isPi>.$/, q{Match unrelated negated <isPi> (InitialPunctuation)} );
ok("\x[3A35]"  ~~ m/^<-isPi>$/, q{Match unrelated inverted <isPi> (InitialPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<.isPi>$/ ), q{Don't match related <isPi> (InitialPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<!isPi>.$/, q{Match related negated <isPi> (InitialPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-isPi>$/, q{Match related inverted <isPi> (InitialPunctuation)} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[3A35]\c[EXCLAMATION MARK]\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/<.isPi>/, q{Match unanchored <isPi> (InitialPunctuation)} );

ok("\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<.isInitialPunctuation>$/, q{Match <.isInitialPunctuation>} );
ok(!( "\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<!isInitialPunctuation>.$/ ), q{Don't match negated <isInitialPunctuation>} );
ok(!( "\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<-isInitialPunctuation>$/ ), q{Don't match inverted <isInitialPunctuation>} );
ok(!( "\x[B84F]"  ~~ m/^<.isInitialPunctuation>$/ ), q{Don't match unrelated <isInitialPunctuation>} );
ok("\x[B84F]"  ~~ m/^<!isInitialPunctuation>.$/, q{Match unrelated negated <isInitialPunctuation>} );
ok("\x[B84F]"  ~~ m/^<-isInitialPunctuation>$/, q{Match unrelated inverted <isInitialPunctuation>} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[B84F]\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/<.isInitialPunctuation>/, q{Match unanchored <isInitialPunctuation>} );

# Pf          FinalPunctuation


ok("\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<.isPf>$/, q{Match <.isPf> (FinalPunctuation)} );
ok(!( "\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<!isPf>.$/ ), q{Don't match negated <isPf> (FinalPunctuation)} );
ok(!( "\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<-isPf>$/ ), q{Don't match inverted <isPf> (FinalPunctuation)} );
ok(!( "\x[27CF]"  ~~ m/^<.isPf>$/ ), q{Don't match unrelated <isPf> (FinalPunctuation)} );
ok("\x[27CF]"  ~~ m/^<!isPf>.$/, q{Match unrelated negated <isPf> (FinalPunctuation)} );
ok("\x[27CF]"  ~~ m/^<-isPf>$/, q{Match unrelated inverted <isPf> (FinalPunctuation)} );
ok(!( "\c[MATHEMATICAL LEFT WHITE SQUARE BRACKET]" ~~ m/^<.isPf>$/ ), q{Don't match related <isPf> (FinalPunctuation)} );
ok("\c[MATHEMATICAL LEFT WHITE SQUARE BRACKET]" ~~ m/^<!isPf>.$/, q{Match related negated <isPf> (FinalPunctuation)} );
ok("\c[MATHEMATICAL LEFT WHITE SQUARE BRACKET]" ~~ m/^<-isPf>$/, q{Match related inverted <isPf> (FinalPunctuation)} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[27CF]\c[MATHEMATICAL LEFT WHITE SQUARE BRACKET]\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/<.isPf>/, q{Match unanchored <isPf> (FinalPunctuation)} );

ok("\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<.isFinalPunctuation>$/, q{Match <.isFinalPunctuation>} );
ok(!( "\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<!isFinalPunctuation>.$/ ), q{Don't match negated <isFinalPunctuation>} );
ok(!( "\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<-isFinalPunctuation>$/ ), q{Don't match inverted <isFinalPunctuation>} );
ok(!( "\x[4F65]"  ~~ m/^<.isFinalPunctuation>$/ ), q{Don't match unrelated <isFinalPunctuation>} );
ok("\x[4F65]"  ~~ m/^<!isFinalPunctuation>.$/, q{Match unrelated negated <isFinalPunctuation>} );
ok("\x[4F65]"  ~~ m/^<-isFinalPunctuation>$/, q{Match unrelated inverted <isFinalPunctuation>} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[4F65]\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/<.isFinalPunctuation>/, q{Match unanchored <isFinalPunctuation>} );

# Po          OtherPunctuation


ok("\c[EXCLAMATION MARK]" ~~ m/^<.isPo>$/, q{Match <.isPo> (OtherPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<!isPo>.$/ ), q{Don't match negated <isPo> (OtherPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-isPo>$/ ), q{Don't match inverted <isPo> (OtherPunctuation)} );
ok(!( "\x[AA74]"  ~~ m/^<.isPo>$/ ), q{Don't match unrelated <isPo> (OtherPunctuation)} );
ok("\x[AA74]"  ~~ m/^<!isPo>.$/, q{Match unrelated negated <isPo> (OtherPunctuation)} );
ok("\x[AA74]"  ~~ m/^<-isPo>$/, q{Match unrelated inverted <isPo> (OtherPunctuation)} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<.isPo>$/ ), q{Don't match related <isPo> (OtherPunctuation)} );
ok("\c[LEFT PARENTHESIS]" ~~ m/^<!isPo>.$/, q{Match related negated <isPo> (OtherPunctuation)} );
ok("\c[LEFT PARENTHESIS]" ~~ m/^<-isPo>$/, q{Match related inverted <isPo> (OtherPunctuation)} );
ok("\x[AA74]\c[LEFT PARENTHESIS]\c[EXCLAMATION MARK]" ~~ m/<.isPo>/, q{Match unanchored <isPo> (OtherPunctuation)} );

ok("\c[EXCLAMATION MARK]" ~~ m/^<.isOtherPunctuation>$/, q{Match <.isOtherPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<!isOtherPunctuation>.$/ ), q{Don't match negated <isOtherPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-isOtherPunctuation>$/ ), q{Don't match inverted <isOtherPunctuation>} );
ok(!( "\x[7DD2]"  ~~ m/^<.isOtherPunctuation>$/ ), q{Don't match unrelated <isOtherPunctuation>} );
ok("\x[7DD2]"  ~~ m/^<!isOtherPunctuation>.$/, q{Match unrelated negated <isOtherPunctuation>} );
ok("\x[7DD2]"  ~~ m/^<-isOtherPunctuation>$/, q{Match unrelated inverted <isOtherPunctuation>} );
ok("\x[7DD2]\c[EXCLAMATION MARK]" ~~ m/<.isOtherPunctuation>/, q{Match unanchored <isOtherPunctuation>} );

# S           Symbol


ok("\c[YI RADICAL QOT]" ~~ m/^<isS>$/, q{Match <isS> (Symbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<!isS>.$/ ), q{Don't match negated <isS> (Symbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-isS>$/ ), q{Don't match inverted <isS> (Symbol)} );
ok(!( "\x[8839]"  ~~ m/^<isS>$/ ), q{Don't match unrelated <isS> (Symbol)} );
ok("\x[8839]"  ~~ m/^<!isS>.$/, q{Match unrelated negated <isS> (Symbol)} );
ok("\x[8839]"  ~~ m/^<-isS>$/, q{Match unrelated inverted <isS> (Symbol)} );
ok("\x[8839]\c[YI RADICAL QOT]" ~~ m/<isS>/, q{Match unanchored <isS> (Symbol)} );

ok("\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<.isSymbol>$/, q{Match <.isSymbol>} );
ok(!( "\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<!isSymbol>.$/ ), q{Don't match negated <isSymbol>} );
ok(!( "\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<-isSymbol>$/ ), q{Don't match inverted <isSymbol>} );
ok(!( "\x[4A1C]"  ~~ m/^<.isSymbol>$/ ), q{Don't match unrelated <isSymbol>} );
ok("\x[4A1C]"  ~~ m/^<!isSymbol>.$/, q{Match unrelated negated <isSymbol>} );
ok("\x[4A1C]"  ~~ m/^<-isSymbol>$/, q{Match unrelated inverted <isSymbol>} );
ok("\x[4A1C]\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/<.isSymbol>/, q{Match unanchored <isSymbol>} );

# Sm          MathSymbol


ok("\c[PLUS SIGN]" ~~ m/^<.isSm>$/, q{Match <.isSm> (MathSymbol)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<!isSm>.$/ ), q{Don't match negated <isSm> (MathSymbol)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<-isSm>$/ ), q{Don't match inverted <isSm> (MathSymbol)} );
ok(!( "\x[B258]"  ~~ m/^<.isSm>$/ ), q{Don't match unrelated <isSm> (MathSymbol)} );
ok("\x[B258]"  ~~ m/^<!isSm>.$/, q{Match unrelated negated <isSm> (MathSymbol)} );
ok("\x[B258]"  ~~ m/^<-isSm>$/, q{Match unrelated inverted <isSm> (MathSymbol)} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<.isSm>$/ ), q{Don't match related <isSm> (MathSymbol)} );
ok("\c[DOLLAR SIGN]" ~~ m/^<!isSm>.$/, q{Match related negated <isSm> (MathSymbol)} );
ok("\c[DOLLAR SIGN]" ~~ m/^<-isSm>$/, q{Match related inverted <isSm> (MathSymbol)} );
ok("\x[B258]\c[DOLLAR SIGN]\c[PLUS SIGN]" ~~ m/<.isSm>/, q{Match unanchored <isSm> (MathSymbol)} );

ok("\c[PLUS SIGN]" ~~ m/^<.isMathSymbol>$/, q{Match <.isMathSymbol>} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<!isMathSymbol>.$/ ), q{Don't match negated <isMathSymbol>} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<-isMathSymbol>$/ ), q{Don't match inverted <isMathSymbol>} );
ok(!( "\x[98FF]"  ~~ m/^<.isMathSymbol>$/ ), q{Don't match unrelated <isMathSymbol>} );
ok("\x[98FF]"  ~~ m/^<!isMathSymbol>.$/, q{Match unrelated negated <isMathSymbol>} );
ok("\x[98FF]"  ~~ m/^<-isMathSymbol>$/, q{Match unrelated inverted <isMathSymbol>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<.isMathSymbol>$/ ), q{Don't match related <isMathSymbol>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isMathSymbol>.$/, q{Match related negated <isMathSymbol>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isMathSymbol>$/, q{Match related inverted <isMathSymbol>} );
ok("\x[98FF]\c[COMBINING GRAVE ACCENT]\c[PLUS SIGN]" ~~ m/<.isMathSymbol>/, q{Match unanchored <isMathSymbol>} );

# Sc          CurrencySymbol


ok("\c[DOLLAR SIGN]" ~~ m/^<.isSc>$/, q{Match <.isSc> (CurrencySymbol)} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<!isSc>.$/ ), q{Don't match negated <isSc> (CurrencySymbol)} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<-isSc>$/ ), q{Don't match inverted <isSc> (CurrencySymbol)} );
ok(!( "\x[994C]"  ~~ m/^<.isSc>$/ ), q{Don't match unrelated <isSc> (CurrencySymbol)} );
ok("\x[994C]"  ~~ m/^<!isSc>.$/, q{Match unrelated negated <isSc> (CurrencySymbol)} );
ok("\x[994C]"  ~~ m/^<-isSc>$/, q{Match unrelated inverted <isSc> (CurrencySymbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<.isSc>$/ ), q{Don't match related <isSc> (CurrencySymbol)} );
ok("\c[YI RADICAL QOT]" ~~ m/^<!isSc>.$/, q{Match related negated <isSc> (CurrencySymbol)} );
ok("\c[YI RADICAL QOT]" ~~ m/^<-isSc>$/, q{Match related inverted <isSc> (CurrencySymbol)} );
ok("\x[994C]\c[YI RADICAL QOT]\c[DOLLAR SIGN]" ~~ m/<.isSc>/, q{Match unanchored <isSc> (CurrencySymbol)} );

ok("\c[DOLLAR SIGN]" ~~ m/^<.isCurrencySymbol>$/, q{Match <.isCurrencySymbol>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<!isCurrencySymbol>.$/ ), q{Don't match negated <isCurrencySymbol>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<-isCurrencySymbol>$/ ), q{Don't match inverted <isCurrencySymbol>} );
ok(!( "\x[37C0]"  ~~ m/^<.isCurrencySymbol>$/ ), q{Don't match unrelated <isCurrencySymbol>} );
ok("\x[37C0]"  ~~ m/^<!isCurrencySymbol>.$/, q{Match unrelated negated <isCurrencySymbol>} );
ok("\x[37C0]"  ~~ m/^<-isCurrencySymbol>$/, q{Match unrelated inverted <isCurrencySymbol>} );
ok("\x[37C0]\c[DOLLAR SIGN]" ~~ m/<.isCurrencySymbol>/, q{Match unanchored <isCurrencySymbol>} );

# Sk          ModifierSymbol


ok("\c[CIRCUMFLEX ACCENT]" ~~ m/^<.isSk>$/, q{Match <.isSk> (ModifierSymbol)} );
ok(!( "\c[CIRCUMFLEX ACCENT]" ~~ m/^<!isSk>.$/ ), q{Don't match negated <isSk> (ModifierSymbol)} );
ok(!( "\c[CIRCUMFLEX ACCENT]" ~~ m/^<-isSk>$/ ), q{Don't match inverted <isSk> (ModifierSymbol)} );
ok(!( "\x[4578]"  ~~ m/^<.isSk>$/ ), q{Don't match unrelated <isSk> (ModifierSymbol)} );
ok("\x[4578]"  ~~ m/^<!isSk>.$/, q{Match unrelated negated <isSk> (ModifierSymbol)} );
ok("\x[4578]"  ~~ m/^<-isSk>$/, q{Match unrelated inverted <isSk> (ModifierSymbol)} );
ok(!( "\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<.isSk>$/ ), q{Don't match related <isSk> (ModifierSymbol)} );
ok("\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<!isSk>.$/, q{Match related negated <isSk> (ModifierSymbol)} );
ok("\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<-isSk>$/, q{Match related inverted <isSk> (ModifierSymbol)} );
ok("\x[4578]\c[HEXAGRAM FOR THE CREATIVE HEAVEN]\c[CIRCUMFLEX ACCENT]" ~~ m/<.isSk>/, q{Match unanchored <isSk> (ModifierSymbol)} );

ok("\c[CIRCUMFLEX ACCENT]" ~~ m/^<.isModifierSymbol>$/, q{Match <.isModifierSymbol>} );
ok(!( "\c[CIRCUMFLEX ACCENT]" ~~ m/^<!isModifierSymbol>.$/ ), q{Don't match negated <isModifierSymbol>} );
ok(!( "\c[CIRCUMFLEX ACCENT]" ~~ m/^<-isModifierSymbol>$/ ), q{Don't match inverted <isModifierSymbol>} );
ok(!( "\x[42F1]"  ~~ m/^<.isModifierSymbol>$/ ), q{Don't match unrelated <isModifierSymbol>} );
ok("\x[42F1]"  ~~ m/^<!isModifierSymbol>.$/, q{Match unrelated negated <isModifierSymbol>} );
ok("\x[42F1]"  ~~ m/^<-isModifierSymbol>$/, q{Match unrelated inverted <isModifierSymbol>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<.isModifierSymbol>$/ ), q{Don't match related <isModifierSymbol>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!isModifierSymbol>.$/, q{Match related negated <isModifierSymbol>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-isModifierSymbol>$/, q{Match related inverted <isModifierSymbol>} );
ok("\x[42F1]\c[COMBINING GRAVE ACCENT]\c[CIRCUMFLEX ACCENT]" ~~ m/<.isModifierSymbol>/, q{Match unanchored <isModifierSymbol>} );

# So          OtherSymbol


ok("\c[YI RADICAL QOT]" ~~ m/^<.isSo>$/, q{Match <.isSo> (OtherSymbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<!isSo>.$/ ), q{Don't match negated <isSo> (OtherSymbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-isSo>$/ ), q{Don't match inverted <isSo> (OtherSymbol)} );
ok(!( "\x[83DE]"  ~~ m/^<.isSo>$/ ), q{Don't match unrelated <isSo> (OtherSymbol)} );
ok("\x[83DE]"  ~~ m/^<!isSo>.$/, q{Match unrelated negated <isSo> (OtherSymbol)} );
ok("\x[83DE]"  ~~ m/^<-isSo>$/, q{Match unrelated inverted <isSo> (OtherSymbol)} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<.isSo>$/ ), q{Don't match related <isSo> (OtherSymbol)} );
ok("\c[DOLLAR SIGN]" ~~ m/^<!isSo>.$/, q{Match related negated <isSo> (OtherSymbol)} );
ok("\c[DOLLAR SIGN]" ~~ m/^<-isSo>$/, q{Match related inverted <isSo> (OtherSymbol)} );
ok("\x[83DE]\c[DOLLAR SIGN]\c[YI RADICAL QOT]" ~~ m/<.isSo>/, q{Match unanchored <isSo> (OtherSymbol)} );

ok("\c[YI RADICAL QOT]" ~~ m/^<.isOtherSymbol>$/, q{Match <.isOtherSymbol>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<!isOtherSymbol>.$/ ), q{Don't match negated <isOtherSymbol>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-isOtherSymbol>$/ ), q{Don't match inverted <isOtherSymbol>} );
ok(!( "\x[9B2C]"  ~~ m/^<.isOtherSymbol>$/ ), q{Don't match unrelated <isOtherSymbol>} );
ok("\x[9B2C]"  ~~ m/^<!isOtherSymbol>.$/, q{Match unrelated negated <isOtherSymbol>} );
ok("\x[9B2C]"  ~~ m/^<-isOtherSymbol>$/, q{Match unrelated inverted <isOtherSymbol>} );
ok("\x[9B2C]\c[YI RADICAL QOT]" ~~ m/<.isOtherSymbol>/, q{Match unanchored <isOtherSymbol>} );

# Z           Separator


ok("\c[IDEOGRAPHIC SPACE]" ~~ m/^<isZ>$/, q{Match <isZ> (Separator)} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<!isZ>.$/ ), q{Don't match negated <isZ> (Separator)} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<-isZ>$/ ), q{Don't match inverted <isZ> (Separator)} );
ok(!( "\x[2C08]"  ~~ m/^<isZ>$/ ), q{Don't match unrelated <isZ> (Separator)} );
ok("\x[2C08]"  ~~ m/^<!isZ>.$/, q{Match unrelated negated <isZ> (Separator)} );
ok("\x[2C08]"  ~~ m/^<-isZ>$/, q{Match unrelated inverted <isZ> (Separator)} );
ok("\x[2C08]\c[IDEOGRAPHIC SPACE]" ~~ m/<isZ>/, q{Match unanchored <isZ> (Separator)} );

ok("\c[SPACE]" ~~ m/^<.isSeparator>$/, q{Match <.isSeparator>} );
ok(!( "\c[SPACE]" ~~ m/^<!isSeparator>.$/ ), q{Don't match negated <isSeparator>} );
ok(!( "\c[SPACE]" ~~ m/^<-isSeparator>$/ ), q{Don't match inverted <isSeparator>} );
ok(!( "\c[YI SYLLABLE SOX]"  ~~ m/^<.isSeparator>$/ ), q{Don't match unrelated <isSeparator>} );
ok("\c[YI SYLLABLE SOX]"  ~~ m/^<!isSeparator>.$/, q{Match unrelated negated <isSeparator>} );
ok("\c[YI SYLLABLE SOX]"  ~~ m/^<-isSeparator>$/, q{Match unrelated inverted <isSeparator>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<.isSeparator>$/ ), q{Don't match related <isSeparator>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<!isSeparator>.$/, q{Match related negated <isSeparator>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<-isSeparator>$/, q{Match related inverted <isSeparator>} );
ok("\c[YI SYLLABLE SOX]\c[YI RADICAL QOT]\c[SPACE]" ~~ m/<.isSeparator>/, q{Match unanchored <isSeparator>} );

# Zs          SpaceSeparator


ok("\c[SPACE]" ~~ m/^<.isZs>$/, q{Match <.isZs> (SpaceSeparator)} );
ok(!( "\c[SPACE]" ~~ m/^<!isZs>.$/ ), q{Don't match negated <isZs> (SpaceSeparator)} );
ok(!( "\c[SPACE]" ~~ m/^<-isZs>$/ ), q{Don't match inverted <isZs> (SpaceSeparator)} );
ok(!( "\x[88DD]"  ~~ m/^<.isZs>$/ ), q{Don't match unrelated <isZs> (SpaceSeparator)} );
ok("\x[88DD]"  ~~ m/^<!isZs>.$/, q{Match unrelated negated <isZs> (SpaceSeparator)} );
ok("\x[88DD]"  ~~ m/^<-isZs>$/, q{Match unrelated inverted <isZs> (SpaceSeparator)} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<.isZs>$/ ), q{Don't match related <isZs> (SpaceSeparator)} );
ok("\c[LINE SEPARATOR]" ~~ m/^<!isZs>.$/, q{Match related negated <isZs> (SpaceSeparator)} );
ok("\c[LINE SEPARATOR]" ~~ m/^<-isZs>$/, q{Match related inverted <isZs> (SpaceSeparator)} );
ok("\x[88DD]\c[LINE SEPARATOR]\c[SPACE]" ~~ m/<.isZs>/, q{Match unanchored <isZs> (SpaceSeparator)} );

ok("\c[SPACE]" ~~ m/^<.isSpaceSeparator>$/, q{Match <.isSpaceSeparator>} );
ok(!( "\c[SPACE]" ~~ m/^<!isSpaceSeparator>.$/ ), q{Don't match negated <isSpaceSeparator>} );
ok(!( "\c[SPACE]" ~~ m/^<-isSpaceSeparator>$/ ), q{Don't match inverted <isSpaceSeparator>} );
ok(!( "\x[C808]"  ~~ m/^<.isSpaceSeparator>$/ ), q{Don't match unrelated <isSpaceSeparator>} );
ok("\x[C808]"  ~~ m/^<!isSpaceSeparator>.$/, q{Match unrelated negated <isSpaceSeparator>} );
ok("\x[C808]"  ~~ m/^<-isSpaceSeparator>$/, q{Match unrelated inverted <isSpaceSeparator>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<.isSpaceSeparator>$/ ), q{Don't match related <isSpaceSeparator>} );
ok("\c[DOLLAR SIGN]" ~~ m/^<!isSpaceSeparator>.$/, q{Match related negated <isSpaceSeparator>} );
ok("\c[DOLLAR SIGN]" ~~ m/^<-isSpaceSeparator>$/, q{Match related inverted <isSpaceSeparator>} );
ok("\x[C808]\c[DOLLAR SIGN]\c[SPACE]" ~~ m/<.isSpaceSeparator>/, q{Match unanchored <isSpaceSeparator>} );

# Zl          LineSeparator


ok("\c[LINE SEPARATOR]" ~~ m/^<.isZl>$/, q{Match <.isZl> (LineSeparator)} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<!isZl>.$/ ), q{Don't match negated <isZl> (LineSeparator)} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<-isZl>$/ ), q{Don't match inverted <isZl> (LineSeparator)} );
ok(!( "\x[B822]"  ~~ m/^<.isZl>$/ ), q{Don't match unrelated <isZl> (LineSeparator)} );
ok("\x[B822]"  ~~ m/^<!isZl>.$/, q{Match unrelated negated <isZl> (LineSeparator)} );
ok("\x[B822]"  ~~ m/^<-isZl>$/, q{Match unrelated inverted <isZl> (LineSeparator)} );
ok(!( "\c[SPACE]" ~~ m/^<.isZl>$/ ), q{Don't match related <isZl> (LineSeparator)} );
ok("\c[SPACE]" ~~ m/^<!isZl>.$/, q{Match related negated <isZl> (LineSeparator)} );
ok("\c[SPACE]" ~~ m/^<-isZl>$/, q{Match related inverted <isZl> (LineSeparator)} );
ok("\x[B822]\c[SPACE]\c[LINE SEPARATOR]" ~~ m/<.isZl>/, q{Match unanchored <isZl> (LineSeparator)} );

ok("\c[LINE SEPARATOR]" ~~ m/^<.isLineSeparator>$/, q{Match <.isLineSeparator>} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<!isLineSeparator>.$/ ), q{Don't match negated <isLineSeparator>} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<-isLineSeparator>$/ ), q{Don't match inverted <isLineSeparator>} );
ok(!( "\x[1390]"  ~~ m/^<.isLineSeparator>$/ ), q{Don't match unrelated <isLineSeparator>} );
ok("\x[1390]"  ~~ m/^<!isLineSeparator>.$/, q{Match unrelated negated <isLineSeparator>} );
ok("\x[1390]"  ~~ m/^<-isLineSeparator>$/, q{Match unrelated inverted <isLineSeparator>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<.isLineSeparator>$/ ), q{Don't match related <isLineSeparator>} );
ok("\c[CHEROKEE LETTER A]" ~~ m/^<!isLineSeparator>.$/, q{Match related negated <isLineSeparator>} );
ok("\c[CHEROKEE LETTER A]" ~~ m/^<-isLineSeparator>$/, q{Match related inverted <isLineSeparator>} );
ok("\x[1390]\c[CHEROKEE LETTER A]\c[LINE SEPARATOR]" ~~ m/<.isLineSeparator>/, q{Match unanchored <isLineSeparator>} );

# Zp          ParagraphSeparator


ok("\c[PARAGRAPH SEPARATOR]" ~~ m/^<.isZp>$/, q{Match <.isZp> (ParagraphSeparator)} );
ok(!( "\c[PARAGRAPH SEPARATOR]" ~~ m/^<!isZp>.$/ ), q{Don't match negated <isZp> (ParagraphSeparator)} );
ok(!( "\c[PARAGRAPH SEPARATOR]" ~~ m/^<-isZp>$/ ), q{Don't match inverted <isZp> (ParagraphSeparator)} );
ok(!( "\x[5FDE]"  ~~ m/^<.isZp>$/ ), q{Don't match unrelated <isZp> (ParagraphSeparator)} );
ok("\x[5FDE]"  ~~ m/^<!isZp>.$/, q{Match unrelated negated <isZp> (ParagraphSeparator)} );
ok("\x[5FDE]"  ~~ m/^<-isZp>$/, q{Match unrelated inverted <isZp> (ParagraphSeparator)} );
ok(!( "\c[SPACE]" ~~ m/^<.isZp>$/ ), q{Don't match related <isZp> (ParagraphSeparator)} );
ok("\c[SPACE]" ~~ m/^<!isZp>.$/, q{Match related negated <isZp> (ParagraphSeparator)} );
ok("\c[SPACE]" ~~ m/^<-isZp>$/, q{Match related inverted <isZp> (ParagraphSeparator)} );
ok("\x[5FDE]\c[SPACE]\c[PARAGRAPH SEPARATOR]" ~~ m/<.isZp>/, q{Match unanchored <isZp> (ParagraphSeparator)} );

ok("\c[PARAGRAPH SEPARATOR]" ~~ m/^<.isParagraphSeparator>$/, q{Match <.isParagraphSeparator>} );
ok(!( "\c[PARAGRAPH SEPARATOR]" ~~ m/^<!isParagraphSeparator>.$/ ), q{Don't match negated <isParagraphSeparator>} );
ok(!( "\c[PARAGRAPH SEPARATOR]" ~~ m/^<-isParagraphSeparator>$/ ), q{Don't match inverted <isParagraphSeparator>} );
ok(!( "\x[345B]"  ~~ m/^<.isParagraphSeparator>$/ ), q{Don't match unrelated <isParagraphSeparator>} );
ok("\x[345B]"  ~~ m/^<!isParagraphSeparator>.$/, q{Match unrelated negated <isParagraphSeparator>} );
ok("\x[345B]"  ~~ m/^<-isParagraphSeparator>$/, q{Match unrelated inverted <isParagraphSeparator>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<.isParagraphSeparator>$/ ), q{Don't match related <isParagraphSeparator>} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<!isParagraphSeparator>.$/, q{Match related negated <isParagraphSeparator>} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-isParagraphSeparator>$/, q{Match related inverted <isParagraphSeparator>} );
ok("\x[345B]\c[EXCLAMATION MARK]\c[PARAGRAPH SEPARATOR]" ~~ m/<.isParagraphSeparator>/, q{Match unanchored <isParagraphSeparator>} );

# C           Other


#?rakudo 3 skip "Uninvestigated nqp-rx regression"
ok("\x[9FC4]" ~~ m/^<isC>$/, q{Match <isC> (Other)} );
ok(!( "\x[9FC4]" ~~ m/^<!isC>.$/ ), q{Don't match negated <isC> (Other)} );
ok(!( "\x[9FC4]" ~~ m/^<-isC>$/ ), q{Don't match inverted <isC> (Other)} );
ok(!( "\x[6A3F]"  ~~ m/^<isC>$/ ), q{Don't match unrelated <isC> (Other)} );
ok("\x[6A3F]"  ~~ m/^<!isC>.$/, q{Match unrelated negated <isC> (Other)} );
ok("\x[6A3F]"  ~~ m/^<-isC>$/, q{Match unrelated inverted <isC> (Other)} );
#?rakudo skip "Uninvestigated nqp-rx regression"
ok("\x[6A3F]\x[9FC4]" ~~ m/<isC>/, q{Match unanchored <isC> (Other)} );

ok("\x[A679]" ~~ m/^<.isOther>$/, q{Match <.isOther>} );
ok(!( "\x[A679]" ~~ m/^<!isOther>.$/ ), q{Don't match negated <isOther>} );
ok(!( "\x[A679]" ~~ m/^<-isOther>$/ ), q{Don't match inverted <isOther>} );
ok(!( "\x[AC00]"  ~~ m/^<.isOther>$/ ), q{Don't match unrelated <isOther>} );
ok("\x[AC00]"  ~~ m/^<!isOther>.$/, q{Match unrelated negated <isOther>} );
ok("\x[AC00]"  ~~ m/^<-isOther>$/, q{Match unrelated inverted <isOther>} );
ok("\x[AC00]\x[A679]" ~~ m/<.isOther>/, q{Match unanchored <isOther>} );

# Cc          Control


ok("\c[NULL]" ~~ m/^<.isCc>$/, q{Match <.isCc> (Control)} );
ok(!( "\c[NULL]" ~~ m/^<!isCc>.$/ ), q{Don't match negated <isCc> (Control)} );
ok(!( "\c[NULL]" ~~ m/^<-isCc>$/ ), q{Don't match inverted <isCc> (Control)} );
ok(!( "\x[0A7A]"  ~~ m/^<.isCc>$/ ), q{Don't match unrelated <isCc> (Control)} );
ok("\x[0A7A]"  ~~ m/^<!isCc>.$/, q{Match unrelated negated <isCc> (Control)} );
ok("\x[0A7A]"  ~~ m/^<-isCc>$/, q{Match unrelated inverted <isCc> (Control)} );
ok(!( "\x[0A7A]" ~~ m/^<.isCc>$/ ), q{Don't match related <isCc> (Control)} );
ok("\x[0A7A]" ~~ m/^<!isCc>.$/, q{Match related negated <isCc> (Control)} );
ok("\x[0A7A]" ~~ m/^<-isCc>$/, q{Match related inverted <isCc> (Control)} );
ok("\x[0A7A]\x[0A7A]\c[NULL]" ~~ m/<.isCc>/, q{Match unanchored <isCc> (Control)} );

ok("\c[NULL]" ~~ m/^<.isControl>$/, q{Match <.isControl>} );
ok(!( "\c[NULL]" ~~ m/^<!isControl>.$/ ), q{Don't match negated <isControl>} );
ok(!( "\c[NULL]" ~~ m/^<-isControl>$/ ), q{Don't match inverted <isControl>} );
ok(!( "\x[4886]"  ~~ m/^<.isControl>$/ ), q{Don't match unrelated <isControl>} );
ok("\x[4886]"  ~~ m/^<!isControl>.$/, q{Match unrelated negated <isControl>} );
ok("\x[4886]"  ~~ m/^<-isControl>$/, q{Match unrelated inverted <isControl>} );
ok(!( "\x[4DB6]" ~~ m/^<.isControl>$/ ), q{Don't match related <isControl>} );
ok("\x[4DB6]" ~~ m/^<!isControl>.$/, q{Match related negated <isControl>} );
ok("\x[4DB6]" ~~ m/^<-isControl>$/, q{Match related inverted <isControl>} );
ok("\x[4886]\x[4DB6]\c[NULL]" ~~ m/<.isControl>/, q{Match unanchored <isControl>} );

# Cf          Format


ok("\c[SOFT HYPHEN]" ~~ m/^<.isCf>$/, q{Match <.isCf> (Format)} );
ok(!( "\c[SOFT HYPHEN]" ~~ m/^<!isCf>.$/ ), q{Don't match negated <isCf> (Format)} );
ok(!( "\c[SOFT HYPHEN]" ~~ m/^<-isCf>$/ ), q{Don't match inverted <isCf> (Format)} );
ok(!( "\x[77B8]"  ~~ m/^<.isCf>$/ ), q{Don't match unrelated <isCf> (Format)} );
ok("\x[77B8]"  ~~ m/^<!isCf>.$/, q{Match unrelated negated <isCf> (Format)} );
ok("\x[77B8]"  ~~ m/^<-isCf>$/, q{Match unrelated inverted <isCf> (Format)} );
ok(!( "\x[9FC4]" ~~ m/^<.isCf>$/ ), q{Don't match related <isCf> (Format)} );
ok("\x[9FC4]" ~~ m/^<!isCf>.$/, q{Match related negated <isCf> (Format)} );
ok("\x[9FC4]" ~~ m/^<-isCf>$/, q{Match related inverted <isCf> (Format)} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[77B8]\x[9FC4]\c[SOFT HYPHEN]" ~~ m/<.isCf>/, q{Match unanchored <isCf> (Format)} );

ok("\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<.isFormat>$/, q{Match <.isFormat>} );
ok(!( "\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<!isFormat>.$/ ), q{Don't match negated <isFormat>} );
ok(!( "\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<-isFormat>$/ ), q{Don't match inverted <isFormat>} );
ok(!( "\c[DEVANAGARI VOWEL SIGN AU]"  ~~ m/^<.isFormat>$/ ), q{Don't match unrelated <isFormat>} );
ok("\c[DEVANAGARI VOWEL SIGN AU]"  ~~ m/^<!isFormat>.$/, q{Match unrelated negated <isFormat>} );
ok("\c[DEVANAGARI VOWEL SIGN AU]"  ~~ m/^<-isFormat>$/, q{Match unrelated inverted <isFormat>} );
ok("\c[DEVANAGARI VOWEL SIGN AU]\c[KHMER VOWEL INHERENT AQ]" ~~ m/<.isFormat>/, q{Match unanchored <isFormat>} );


# vim: ft=perl6
