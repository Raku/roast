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
ok(!( "\x[846D]" ~~ m/^<:!L>.$/ ), q{Don't match negated <isL> (Letter)} );
ok(!( "\x[846D]" ~~ m/^<-:L>$/ ), q{Don't match inverted <isL> (Letter)} );
#?rakudo 3 skip "Uninvestigated nqp-rx regression"
ok(!( "\x[9FC4]"  ~~ m/^<isL>$/ ), q{Don't match unrelated <isL> (Letter)} );
ok("\x[9FC4]"  ~~ m/^<:!L>.$/, q{Match unrelated negated <isL> (Letter)} );
ok("\x[9FC4]"  ~~ m/^<-:L>$/, q{Match unrelated inverted <isL> (Letter)} );
ok("\x[9FC4]\x[846D]" ~~ m/<isL>/, q{Match unanchored <isL> (Letter)} );

ok("\x[6DF7]" ~~ m/^<:Letter>$/, q{Match <:Letter>} );
ok(!( "\x[6DF7]" ~~ m/^<:!Letter>.$/ ), q{Don't match negated <isLetter>} );
ok(!( "\x[6DF7]" ~~ m/^<-:Letter>$/ ), q{Don't match inverted <isLetter>} );
#?rakudo 3 skip "Uninvestigated nqp-rx regression"
ok(!( "\x[9FC4]"  ~~ m/^<:Letter>$/ ), q{Don't match unrelated <isLetter>} );
ok("\x[9FC4]"  ~~ m/^<:!Letter>.$/, q{Match unrelated negated <isLetter>} );
ok("\x[9FC4]"  ~~ m/^<-:Letter>$/, q{Match unrelated inverted <isLetter>} );
ok("\x[9FC4]\x[6DF7]" ~~ m/<:Letter>/, q{Match unanchored <isLetter>} );

# Lu          UppercaseLetter


ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<:Lu>$/, q{Match <:Lu> (UppercaseLetter)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<:!Lu>.$/ ), q{Don't match negated <isLu> (UppercaseLetter)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-:Lu>$/ ), q{Don't match inverted <isLu> (UppercaseLetter)} );
ok(!( "\x[C767]"  ~~ m/^<:Lu>$/ ), q{Don't match unrelated <isLu> (UppercaseLetter)} );
ok("\x[C767]"  ~~ m/^<:!Lu>.$/, q{Match unrelated negated <isLu> (UppercaseLetter)} );
ok("\x[C767]"  ~~ m/^<-:Lu>$/, q{Match unrelated inverted <isLu> (UppercaseLetter)} );
ok(!( "\x[C767]" ~~ m/^<:Lu>$/ ), q{Don't match related <isLu> (UppercaseLetter)} );
ok("\x[C767]" ~~ m/^<:!Lu>.$/, q{Match related negated <isLu> (UppercaseLetter)} );
ok("\x[C767]" ~~ m/^<-:Lu>$/, q{Match related inverted <isLu> (UppercaseLetter)} );
ok("\x[C767]\x[C767]\c[LATIN CAPITAL LETTER A]" ~~ m/<:Lu>/, q{Match unanchored <isLu> (UppercaseLetter)} );

ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<:UppercaseLetter>$/, q{Match <:UppercaseLetter>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<:!UppercaseLetter>.$/ ), q{Don't match negated <isUppercaseLetter>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-:UppercaseLetter>$/ ), q{Don't match inverted <isUppercaseLetter>} );
ok(!( "\c[YI SYLLABLE NBA]"  ~~ m/^<:UppercaseLetter>$/ ), q{Don't match unrelated <isUppercaseLetter>} );
ok("\c[YI SYLLABLE NBA]"  ~~ m/^<:!UppercaseLetter>.$/, q{Match unrelated negated <isUppercaseLetter>} );
ok("\c[YI SYLLABLE NBA]"  ~~ m/^<-:UppercaseLetter>$/, q{Match unrelated inverted <isUppercaseLetter>} );
ok("\c[YI SYLLABLE NBA]\c[LATIN CAPITAL LETTER A]" ~~ m/<:UppercaseLetter>/, q{Match unanchored <isUppercaseLetter>} );

# Ll          LowercaseLetter


ok("\c[LATIN SMALL LETTER A]" ~~ m/^<:Ll>$/, q{Match <:Ll> (LowercaseLetter)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<:!Ll>.$/ ), q{Don't match negated <isLl> (LowercaseLetter)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<-:Ll>$/ ), q{Don't match inverted <isLl> (LowercaseLetter)} );
ok(!( "\c[BOPOMOFO FINAL LETTER H]"  ~~ m/^<:Ll>$/ ), q{Don't match unrelated <isLl> (LowercaseLetter)} );
ok("\c[BOPOMOFO FINAL LETTER H]"  ~~ m/^<:!Ll>.$/, q{Match unrelated negated <isLl> (LowercaseLetter)} );
ok("\c[BOPOMOFO FINAL LETTER H]"  ~~ m/^<-:Ll>$/, q{Match unrelated inverted <isLl> (LowercaseLetter)} );
ok(!( "\c[BOPOMOFO FINAL LETTER H]" ~~ m/^<:Ll>$/ ), q{Don't match related <isLl> (LowercaseLetter)} );
ok("\c[BOPOMOFO FINAL LETTER H]" ~~ m/^<:!Ll>.$/, q{Match related negated <isLl> (LowercaseLetter)} );
ok("\c[BOPOMOFO FINAL LETTER H]" ~~ m/^<-:Ll>$/, q{Match related inverted <isLl> (LowercaseLetter)} );
ok("\c[BOPOMOFO FINAL LETTER H]\c[BOPOMOFO FINAL LETTER H]\c[LATIN SMALL LETTER A]" ~~ m/<:Ll>/, q{Match unanchored <isLl> (LowercaseLetter)} );

ok("\c[LATIN SMALL LETTER A]" ~~ m/^<:LowercaseLetter>$/, q{Match <:LowercaseLetter>} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<:!LowercaseLetter>.$/ ), q{Don't match negated <isLowercaseLetter>} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<-:LowercaseLetter>$/ ), q{Don't match inverted <isLowercaseLetter>} );
ok(!( "\x[86CA]"  ~~ m/^<:LowercaseLetter>$/ ), q{Don't match unrelated <isLowercaseLetter>} );
ok("\x[86CA]"  ~~ m/^<:!LowercaseLetter>.$/, q{Match unrelated negated <isLowercaseLetter>} );
ok("\x[86CA]"  ~~ m/^<-:LowercaseLetter>$/, q{Match unrelated inverted <isLowercaseLetter>} );
ok(!( "\x[86CA]" ~~ m/^<:LowercaseLetter>$/ ), q{Don't match related <isLowercaseLetter>} );
ok("\x[86CA]" ~~ m/^<:!LowercaseLetter>.$/, q{Match related negated <isLowercaseLetter>} );
ok("\x[86CA]" ~~ m/^<-:LowercaseLetter>$/, q{Match related inverted <isLowercaseLetter>} );
ok("\x[86CA]\x[86CA]\c[LATIN SMALL LETTER A]" ~~ m/<:LowercaseLetter>/, q{Match unanchored <isLowercaseLetter>} );

# Lt          TitlecaseLetter


ok("\c[LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON]" ~~ m/^<:Lt>$/, q{Match <:Lt> (TitlecaseLetter)} );
ok(!( "\c[LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON]" ~~ m/^<:!Lt>.$/ ), q{Don't match negated <isLt> (TitlecaseLetter)} );
ok(!( "\c[LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON]" ~~ m/^<-:Lt>$/ ), q{Don't match inverted <isLt> (TitlecaseLetter)} );
ok(!( "\x[6DC8]"  ~~ m/^<:Lt>$/ ), q{Don't match unrelated <isLt> (TitlecaseLetter)} );
ok("\x[6DC8]"  ~~ m/^<:!Lt>.$/, q{Match unrelated negated <isLt> (TitlecaseLetter)} );
ok("\x[6DC8]"  ~~ m/^<-:Lt>$/, q{Match unrelated inverted <isLt> (TitlecaseLetter)} );
ok(!( "\x[6DC8]" ~~ m/^<:Lt>$/ ), q{Don't match related <isLt> (TitlecaseLetter)} );
ok("\x[6DC8]" ~~ m/^<:!Lt>.$/, q{Match related negated <isLt> (TitlecaseLetter)} );
ok("\x[6DC8]" ~~ m/^<-:Lt>$/, q{Match related inverted <isLt> (TitlecaseLetter)} );
ok("\x[6DC8]\x[6DC8]\c[LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON]" ~~ m/<:Lt>/, q{Match unanchored <isLt> (TitlecaseLetter)} );

ok("\c[GREEK CAPITAL LETTER ALPHA WITH PSILI AND PROSGEGRAMMENI]" ~~ m/^<:TitlecaseLetter>$/, q{Match <:TitlecaseLetter>} );
ok(!( "\c[GREEK CAPITAL LETTER ALPHA WITH PSILI AND PROSGEGRAMMENI]" ~~ m/^<:!TitlecaseLetter>.$/ ), q{Don't match negated <isTitlecaseLetter>} );
ok(!( "\c[GREEK CAPITAL LETTER ALPHA WITH PSILI AND PROSGEGRAMMENI]" ~~ m/^<-:TitlecaseLetter>$/ ), q{Don't match inverted <isTitlecaseLetter>} );
ok(!( "\x[0C4E]"  ~~ m/^<:TitlecaseLetter>$/ ), q{Don't match unrelated <isTitlecaseLetter>} );
ok("\x[0C4E]"  ~~ m/^<:!TitlecaseLetter>.$/, q{Match unrelated negated <isTitlecaseLetter>} );
ok("\x[0C4E]"  ~~ m/^<-:TitlecaseLetter>$/, q{Match unrelated inverted <isTitlecaseLetter>} );
ok("\x[0C4E]\c[GREEK CAPITAL LETTER ALPHA WITH PSILI AND PROSGEGRAMMENI]" ~~ m/<:TitlecaseLetter>/, q{Match unanchored <isTitlecaseLetter>} );

# Lm          ModifierLetter


ok("\c[IDEOGRAPHIC ITERATION MARK]" ~~ m/^<:Lm>$/, q{Match <:Lm> (ModifierLetter)} );
ok(!( "\c[IDEOGRAPHIC ITERATION MARK]" ~~ m/^<:!Lm>.$/ ), q{Don't match negated <isLm> (ModifierLetter)} );
ok(!( "\c[IDEOGRAPHIC ITERATION MARK]" ~~ m/^<-:Lm>$/ ), q{Don't match inverted <isLm> (ModifierLetter)} );
ok(!( "\x[2B61]"  ~~ m/^<:Lm>$/ ), q{Don't match unrelated <isLm> (ModifierLetter)} );
ok("\x[2B61]"  ~~ m/^<:!Lm>.$/, q{Match unrelated negated <isLm> (ModifierLetter)} );
ok("\x[2B61]"  ~~ m/^<-:Lm>$/, q{Match unrelated inverted <isLm> (ModifierLetter)} );
ok(!( "\c[IDEOGRAPHIC CLOSING MARK]" ~~ m/^<:Lm>$/ ), q{Don't match related <isLm> (ModifierLetter)} );
ok("\c[IDEOGRAPHIC CLOSING MARK]" ~~ m/^<:!Lm>.$/, q{Match related negated <isLm> (ModifierLetter)} );
ok("\c[IDEOGRAPHIC CLOSING MARK]" ~~ m/^<-:Lm>$/, q{Match related inverted <isLm> (ModifierLetter)} );
ok("\x[2B61]\c[IDEOGRAPHIC CLOSING MARK]\c[IDEOGRAPHIC ITERATION MARK]" ~~ m/<:Lm>/, q{Match unanchored <isLm> (ModifierLetter)} );

ok("\c[MODIFIER LETTER SMALL H]" ~~ m/^<:ModifierLetter>$/, q{Match <:ModifierLetter>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<:!ModifierLetter>.$/ ), q{Don't match negated <isModifierLetter>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<-:ModifierLetter>$/ ), q{Don't match inverted <isModifierLetter>} );
ok(!( "\c[YI SYLLABLE HA]"  ~~ m/^<:ModifierLetter>$/ ), q{Don't match unrelated <isModifierLetter>} );
ok("\c[YI SYLLABLE HA]"  ~~ m/^<:!ModifierLetter>.$/, q{Match unrelated negated <isModifierLetter>} );
ok("\c[YI SYLLABLE HA]"  ~~ m/^<-:ModifierLetter>$/, q{Match unrelated inverted <isModifierLetter>} );
ok("\c[YI SYLLABLE HA]\c[MODIFIER LETTER SMALL H]" ~~ m/<:ModifierLetter>/, q{Match unanchored <isModifierLetter>} );

# Lo          OtherLetter


ok("\c[LATIN LETTER TWO WITH STROKE]" ~~ m/^<:Lo>$/, q{Match <:Lo> (OtherLetter)} );
ok(!( "\c[LATIN LETTER TWO WITH STROKE]" ~~ m/^<:!Lo>.$/ ), q{Don't match negated <isLo> (OtherLetter)} );
ok(!( "\c[LATIN LETTER TWO WITH STROKE]" ~~ m/^<-:Lo>$/ ), q{Don't match inverted <isLo> (OtherLetter)} );
ok(!( "\c[LATIN SMALL LETTER TURNED DELTA]"  ~~ m/^<:Lo>$/ ), q{Don't match unrelated <isLo> (OtherLetter)} );
ok("\c[LATIN SMALL LETTER TURNED DELTA]"  ~~ m/^<:!Lo>.$/, q{Match unrelated negated <isLo> (OtherLetter)} );
ok("\c[LATIN SMALL LETTER TURNED DELTA]"  ~~ m/^<-:Lo>$/, q{Match unrelated inverted <isLo> (OtherLetter)} );
ok(!( "\c[LATIN SMALL LETTER TURNED DELTA]" ~~ m/^<:Lo>$/ ), q{Don't match related <isLo> (OtherLetter)} );
ok("\c[LATIN SMALL LETTER TURNED DELTA]" ~~ m/^<:!Lo>.$/, q{Match related negated <isLo> (OtherLetter)} );
ok("\c[LATIN SMALL LETTER TURNED DELTA]" ~~ m/^<-:Lo>$/, q{Match related inverted <isLo> (OtherLetter)} );
ok("\c[LATIN SMALL LETTER TURNED DELTA]\c[LATIN SMALL LETTER TURNED DELTA]\c[LATIN LETTER TWO WITH STROKE]" ~~ m/<:Lo>/, q{Match unanchored <isLo> (OtherLetter)} );

ok("\c[ETHIOPIC SYLLABLE GLOTTAL A]" ~~ m/^<:OtherLetter>$/, q{Match <:OtherLetter>} );
ok(!( "\c[ETHIOPIC SYLLABLE GLOTTAL A]" ~~ m/^<:!OtherLetter>.$/ ), q{Don't match negated <isOtherLetter>} );
ok(!( "\c[ETHIOPIC SYLLABLE GLOTTAL A]" ~~ m/^<-:OtherLetter>$/ ), q{Don't match inverted <isOtherLetter>} );
ok(!( "\x[137D]"  ~~ m/^<:OtherLetter>$/ ), q{Don't match unrelated <isOtherLetter>} );
ok("\x[137D]"  ~~ m/^<:!OtherLetter>.$/, q{Match unrelated negated <isOtherLetter>} );
ok("\x[137D]"  ~~ m/^<-:OtherLetter>$/, q{Match unrelated inverted <isOtherLetter>} );
ok("\x[137D]\c[ETHIOPIC SYLLABLE GLOTTAL A]" ~~ m/<:OtherLetter>/, q{Match unanchored <isOtherLetter>} );

# Lr             # Alias for "Ll", "Lu", and "Lt".


#?rakudo 10 skip "No [Lr] property defined"
ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<:Lr>$/, q{Match (Alias for "Ll", "Lu", and "Lt".)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<:!Lr>.$/ ), q{Don't match negated (Alias for "Ll", "Lu", and "Lt".)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-:Lr>$/ ), q{Don't match inverted (Alias for "Ll", "Lu", and "Lt".)} );
ok(!( "\x[87B5]"  ~~ m/^<:Lr>$/ ), q{Don't match unrelated (Alias for "Ll", "Lu", and "Lt".)} );
ok("\x[87B5]"  ~~ m/^<:!Lr>.$/, q{Match unrelated negated (Alias for "Ll", "Lu", and "Lt".)} );
ok("\x[87B5]"  ~~ m/^<-:Lr>$/, q{Match unrelated inverted (Alias for "Ll", "Lu", and "Lt".)} );
ok(!( "\x[87B5]" ~~ m/^<:Lr>$/ ), q{Don't match related (Alias for "Ll", "Lu", and "Lt".)} );
ok("\x[87B5]" ~~ m/^<:!Lr>.$/, q{Match related negated (Alias for "Ll", "Lu", and "Lt".)} );
ok("\x[87B5]" ~~ m/^<-:Lr>$/, q{Match related inverted (Alias for "Ll", "Lu", and "Lt".)} );
ok("\x[87B5]\x[87B5]\c[LATIN CAPITAL LETTER A]" ~~ m/<:Lr>/, q{Match unanchored (Alias for "Ll", "Lu", and "Lt".)} );


# M           Mark


ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<isM>$/, q{Match <isM> (Mark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!M>.$/ ), q{Don't match negated <isM> (Mark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:M>$/ ), q{Don't match inverted <isM> (Mark)} );
ok(!( "\x[D0AA]"  ~~ m/^<isM>$/ ), q{Don't match unrelated <isM> (Mark)} );
ok("\x[D0AA]"  ~~ m/^<:!M>.$/, q{Match unrelated negated <isM> (Mark)} );
ok("\x[D0AA]"  ~~ m/^<-:M>$/, q{Match unrelated inverted <isM> (Mark)} );
ok("\x[D0AA]\c[COMBINING GRAVE ACCENT]" ~~ m/<isM>/, q{Match unanchored <isM> (Mark)} );

ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Mark>$/, q{Match <:Mark>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!Mark>.$/ ), q{Don't match negated <isMark>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Mark>$/ ), q{Don't match inverted <isMark>} );
ok(!( "\x[BE64]"  ~~ m/^<:Mark>$/ ), q{Don't match unrelated <isMark>} );
ok("\x[BE64]"  ~~ m/^<:!Mark>.$/, q{Match unrelated negated <isMark>} );
ok("\x[BE64]"  ~~ m/^<-:Mark>$/, q{Match unrelated inverted <isMark>} );
ok("\x[BE64]\c[COMBINING GRAVE ACCENT]" ~~ m/<:Mark>/, q{Match unanchored <isMark>} );

# Mn          NonspacingMark


ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Mn>$/, q{Match <:Mn> (NonspacingMark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!Mn>.$/ ), q{Don't match negated <isMn> (NonspacingMark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Mn>$/ ), q{Don't match inverted <isMn> (NonspacingMark)} );
ok(!( "\x[47A5]"  ~~ m/^<:Mn>$/ ), q{Don't match unrelated <isMn> (NonspacingMark)} );
ok("\x[47A5]"  ~~ m/^<:!Mn>.$/, q{Match unrelated negated <isMn> (NonspacingMark)} );
ok("\x[47A5]"  ~~ m/^<-:Mn>$/, q{Match unrelated inverted <isMn> (NonspacingMark)} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<:Mn>$/ ), q{Don't match related <isMn> (NonspacingMark)} );
ok("\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<:!Mn>.$/, q{Match related negated <isMn> (NonspacingMark)} );
ok("\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<-:Mn>$/, q{Match related inverted <isMn> (NonspacingMark)} );
ok("\x[47A5]\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]\c[COMBINING GRAVE ACCENT]" ~~ m/<:Mn>/, q{Match unanchored <isMn> (NonspacingMark)} );

ok("\c[TAGALOG VOWEL SIGN I]" ~~ m/^<:NonspacingMark>$/, q{Match <:NonspacingMark>} );
ok(!( "\c[TAGALOG VOWEL SIGN I]" ~~ m/^<:!NonspacingMark>.$/ ), q{Don't match negated <isNonspacingMark>} );
ok(!( "\c[TAGALOG VOWEL SIGN I]" ~~ m/^<-:NonspacingMark>$/ ), q{Don't match inverted <isNonspacingMark>} );
ok(!( "\c[CANADIAN SYLLABICS TYA]"  ~~ m/^<:NonspacingMark>$/ ), q{Don't match unrelated <isNonspacingMark>} );
ok("\c[CANADIAN SYLLABICS TYA]"  ~~ m/^<:!NonspacingMark>.$/, q{Match unrelated negated <isNonspacingMark>} );
ok("\c[CANADIAN SYLLABICS TYA]"  ~~ m/^<-:NonspacingMark>$/, q{Match unrelated inverted <isNonspacingMark>} );
ok("\c[CANADIAN SYLLABICS TYA]\c[TAGALOG VOWEL SIGN I]" ~~ m/<:NonspacingMark>/, q{Match unanchored <isNonspacingMark>} );

# Mc          SpacingMark


ok("\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<:Mc>$/, q{Match <:Mc> (SpacingMark)} );
ok(!( "\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<:!Mc>.$/ ), q{Don't match negated <isMc> (SpacingMark)} );
ok(!( "\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<-:Mc>$/ ), q{Don't match inverted <isMc> (SpacingMark)} );
ok(!( "\x[9981]"  ~~ m/^<:Mc>$/ ), q{Don't match unrelated <isMc> (SpacingMark)} );
ok("\x[9981]"  ~~ m/^<:!Mc>.$/, q{Match unrelated negated <isMc> (SpacingMark)} );
ok("\x[9981]"  ~~ m/^<-:Mc>$/, q{Match unrelated inverted <isMc> (SpacingMark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Mc>$/ ), q{Don't match related <isMc> (SpacingMark)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!Mc>.$/, q{Match related negated <isMc> (SpacingMark)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Mc>$/, q{Match related inverted <isMc> (SpacingMark)} );
ok("\x[9981]\c[COMBINING GRAVE ACCENT]\c[DEVANAGARI SIGN VISARGA]" ~~ m/<:Mc>/, q{Match unanchored <isMc> (SpacingMark)} );

ok("\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<:SpacingMark>$/, q{Match <:SpacingMark>} );
ok(!( "\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<:!SpacingMark>.$/ ), q{Don't match negated <isSpacingMark>} );
ok(!( "\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<-:SpacingMark>$/ ), q{Don't match inverted <isSpacingMark>} );
ok(!( "\x[35E3]"  ~~ m/^<:SpacingMark>$/ ), q{Don't match unrelated <isSpacingMark>} );
ok("\x[35E3]"  ~~ m/^<:!SpacingMark>.$/, q{Match unrelated negated <isSpacingMark>} );
ok("\x[35E3]"  ~~ m/^<-:SpacingMark>$/, q{Match unrelated inverted <isSpacingMark>} );
ok("\x[35E3]\c[DEVANAGARI SIGN VISARGA]" ~~ m/<:SpacingMark>/, q{Match unanchored <isSpacingMark>} );

# Me          EnclosingMark


ok("\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<:Me>$/, q{Match <:Me> (EnclosingMark)} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<:!Me>.$/ ), q{Don't match negated <isMe> (EnclosingMark)} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<-:Me>$/ ), q{Don't match inverted <isMe> (EnclosingMark)} );
ok(!( "\x[9400]"  ~~ m/^<:Me>$/ ), q{Don't match unrelated <isMe> (EnclosingMark)} );
ok("\x[9400]"  ~~ m/^<:!Me>.$/, q{Match unrelated negated <isMe> (EnclosingMark)} );
ok("\x[9400]"  ~~ m/^<-:Me>$/, q{Match unrelated inverted <isMe> (EnclosingMark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Me>$/ ), q{Don't match related <isMe> (EnclosingMark)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!Me>.$/, q{Match related negated <isMe> (EnclosingMark)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Me>$/, q{Match related inverted <isMe> (EnclosingMark)} );
ok("\x[9400]\c[COMBINING GRAVE ACCENT]\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/<:Me>/, q{Match unanchored <isMe> (EnclosingMark)} );

ok("\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<:EnclosingMark>$/, q{Match <:EnclosingMark>} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<:!EnclosingMark>.$/ ), q{Don't match negated <isEnclosingMark>} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<-:EnclosingMark>$/ ), q{Don't match inverted <isEnclosingMark>} );
ok(!( "\x[7C68]"  ~~ m/^<:EnclosingMark>$/ ), q{Don't match unrelated <isEnclosingMark>} );
ok("\x[7C68]"  ~~ m/^<:!EnclosingMark>.$/, q{Match unrelated negated <isEnclosingMark>} );
ok("\x[7C68]"  ~~ m/^<-:EnclosingMark>$/, q{Match unrelated inverted <isEnclosingMark>} );
ok("\x[7C68]\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/<:EnclosingMark>/, q{Match unanchored <isEnclosingMark>} );


# N           Number


ok("\c[SUPERSCRIPT ZERO]" ~~ m/^<isN>$/, q{Match <isN> (Number)} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<:!N>.$/ ), q{Don't match negated <isN> (Number)} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<-:N>$/ ), q{Don't match inverted <isN> (Number)} );
ok(!( "\c[LATIN LETTER SMALL CAPITAL E]"  ~~ m/^<isN>$/ ), q{Don't match unrelated <isN> (Number)} );
ok("\c[LATIN LETTER SMALL CAPITAL E]"  ~~ m/^<:!N>.$/, q{Match unrelated negated <isN> (Number)} );
ok("\c[LATIN LETTER SMALL CAPITAL E]"  ~~ m/^<-:N>$/, q{Match unrelated inverted <isN> (Number)} );
ok("\c[LATIN LETTER SMALL CAPITAL E]\c[SUPERSCRIPT ZERO]" ~~ m/<isN>/, q{Match unanchored <isN> (Number)} );

ok("\c[DIGIT ZERO]" ~~ m/^<:Number>$/, q{Match <:Number>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:!Number>.$/ ), q{Don't match negated <isNumber>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-:Number>$/ ), q{Don't match inverted <isNumber>} );
ok(!( "\x[A994]"  ~~ m/^<:Number>$/ ), q{Don't match unrelated <isNumber>} );
ok("\x[A994]"  ~~ m/^<:!Number>.$/, q{Match unrelated negated <isNumber>} );
ok("\x[A994]"  ~~ m/^<-:Number>$/, q{Match unrelated inverted <isNumber>} );
ok("\x[A994]\c[DIGIT ZERO]" ~~ m/<:Number>/, q{Match unanchored <isNumber>} );

# Nd          DecimalNumber


ok("\c[DIGIT ZERO]" ~~ m/^<:Nd>$/, q{Match <:Nd> (DecimalNumber)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:!Nd>.$/ ), q{Don't match negated <isNd> (DecimalNumber)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-:Nd>$/ ), q{Don't match inverted <isNd> (DecimalNumber)} );
ok(!( "\x[4E2C]"  ~~ m/^<:Nd>$/ ), q{Don't match unrelated <isNd> (DecimalNumber)} );
ok("\x[4E2C]"  ~~ m/^<:!Nd>.$/, q{Match unrelated negated <isNd> (DecimalNumber)} );
ok("\x[4E2C]"  ~~ m/^<-:Nd>$/, q{Match unrelated inverted <isNd> (DecimalNumber)} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<:Nd>$/ ), q{Don't match related <isNd> (DecimalNumber)} );
ok("\c[SUPERSCRIPT TWO]" ~~ m/^<:!Nd>.$/, q{Match related negated <isNd> (DecimalNumber)} );
ok("\c[SUPERSCRIPT TWO]" ~~ m/^<-:Nd>$/, q{Match related inverted <isNd> (DecimalNumber)} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[4E2C]\c[SUPERSCRIPT TWO]\c[DIGIT ZERO]" ~~ m/<:Nd>/, q{Match unanchored <isNd> (DecimalNumber)} );
ok("\c[DIGIT ZERO]" ~~ m/^<:DecimalNumber>$/, q{Match <:DecimalNumber>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:!DecimalNumber>.$/ ), q{Don't match negated <isDecimalNumber>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-:DecimalNumber>$/ ), q{Don't match inverted <isDecimalNumber>} );
ok(!( "\x[A652]"  ~~ m/^<:DecimalNumber>$/ ), q{Don't match unrelated <isDecimalNumber>} );
ok("\x[A652]"  ~~ m/^<:!DecimalNumber>.$/, q{Match unrelated negated <isDecimalNumber>} );
ok("\x[A652]"  ~~ m/^<-:DecimalNumber>$/, q{Match unrelated inverted <isDecimalNumber>} );
ok("\x[A652]\c[DIGIT ZERO]" ~~ m/<:DecimalNumber>/, q{Match unanchored <isDecimalNumber>} );


# Nl          LetterNumber


ok("\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<:Nl>$/, q{Match <:Nl> (LetterNumber)} );
ok(!( "\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<:!Nl>.$/ ), q{Don't match negated <isNl> (LetterNumber)} );
ok(!( "\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<-:Nl>$/ ), q{Don't match inverted <isNl> (LetterNumber)} );
ok(!( "\x[6C2F]"  ~~ m/^<:Nl>$/ ), q{Don't match unrelated <isNl> (LetterNumber)} );
ok("\x[6C2F]"  ~~ m/^<:!Nl>.$/, q{Match unrelated negated <isNl> (LetterNumber)} );
ok("\x[6C2F]"  ~~ m/^<-:Nl>$/, q{Match unrelated inverted <isNl> (LetterNumber)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:Nl>$/ ), q{Don't match related <isNl> (LetterNumber)} );
ok("\c[DIGIT ZERO]" ~~ m/^<:!Nl>.$/, q{Match related negated <isNl> (LetterNumber)} );
ok("\c[DIGIT ZERO]" ~~ m/^<-:Nl>$/, q{Match related inverted <isNl> (LetterNumber)} );
ok("\x[6C2F]\c[DIGIT ZERO]\c[RUNIC ARLAUG SYMBOL]" ~~ m/<:Nl>/, q{Match unanchored <isNl> (LetterNumber)} );

ok("\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<:LetterNumber>$/, q{Match <:LetterNumber>} );
ok(!( "\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<:!LetterNumber>.$/ ), q{Don't match negated <isLetterNumber>} );
ok(!( "\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<-:LetterNumber>$/ ), q{Don't match inverted <isLetterNumber>} );
ok(!( "\x[80A5]"  ~~ m/^<:LetterNumber>$/ ), q{Don't match unrelated <isLetterNumber>} );
ok("\x[80A5]"  ~~ m/^<:!LetterNumber>.$/, q{Match unrelated negated <isLetterNumber>} );
ok("\x[80A5]"  ~~ m/^<-:LetterNumber>$/, q{Match unrelated inverted <isLetterNumber>} );
ok(!( "\x[80A5]" ~~ m/^<:LetterNumber>$/ ), q{Don't match related <isLetterNumber>} );
ok("\x[80A5]" ~~ m/^<:!LetterNumber>.$/, q{Match related negated <isLetterNumber>} );
ok("\x[80A5]" ~~ m/^<-:LetterNumber>$/, q{Match related inverted <isLetterNumber>} );
ok("\x[80A5]\x[80A5]\c[RUNIC ARLAUG SYMBOL]" ~~ m/<:LetterNumber>/, q{Match unanchored <isLetterNumber>} );

# No          OtherNumber


ok("\c[SUPERSCRIPT TWO]" ~~ m/^<:No>$/, q{Match <:No> (OtherNumber)} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<:!No>.$/ ), q{Don't match negated <isNo> (OtherNumber)} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<-:No>$/ ), q{Don't match inverted <isNo> (OtherNumber)} );
ok(!( "\x[92F3]"  ~~ m/^<:No>$/ ), q{Don't match unrelated <isNo> (OtherNumber)} );
ok("\x[92F3]"  ~~ m/^<:!No>.$/, q{Match unrelated negated <isNo> (OtherNumber)} );
ok("\x[92F3]"  ~~ m/^<-:No>$/, q{Match unrelated inverted <isNo> (OtherNumber)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:No>$/ ), q{Don't match related <isNo> (OtherNumber)} );
ok("\c[DIGIT ZERO]" ~~ m/^<:!No>.$/, q{Match related negated <isNo> (OtherNumber)} );
ok("\c[DIGIT ZERO]" ~~ m/^<-:No>$/, q{Match related inverted <isNo> (OtherNumber)} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[92F3]\c[DIGIT ZERO]\c[SUPERSCRIPT TWO]" ~~ m/<:No>/, q{Match unanchored <isNo> (OtherNumber)} );

ok("\c[SUPERSCRIPT TWO]" ~~ m/^<:OtherNumber>$/, q{Match <:OtherNumber>} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<:!OtherNumber>.$/ ), q{Don't match negated <isOtherNumber>} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<-:OtherNumber>$/ ), q{Don't match inverted <isOtherNumber>} );
ok(!( "\x[5363]"  ~~ m/^<:OtherNumber>$/ ), q{Don't match unrelated <isOtherNumber>} );
ok("\x[5363]"  ~~ m/^<:!OtherNumber>.$/, q{Match unrelated negated <isOtherNumber>} );
ok("\x[5363]"  ~~ m/^<-:OtherNumber>$/, q{Match unrelated inverted <isOtherNumber>} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[5363]\c[SUPERSCRIPT TWO]" ~~ m/<:OtherNumber>/, q{Match unanchored <isOtherNumber>} );

# P           Punctuation


ok("\c[EXCLAMATION MARK]" ~~ m/^<isP>$/, q{Match <isP> (Punctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:!P>.$/ ), q{Don't match negated <isP> (Punctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-:P>$/ ), q{Don't match inverted <isP> (Punctuation)} );
ok(!( "\x[A918]"  ~~ m/^<isP>$/ ), q{Don't match unrelated <isP> (Punctuation)} );
ok("\x[A918]"  ~~ m/^<:!P>.$/, q{Match unrelated negated <isP> (Punctuation)} );
ok("\x[A918]"  ~~ m/^<-:P>$/, q{Match unrelated inverted <isP> (Punctuation)} );
ok("\x[A918]\c[EXCLAMATION MARK]" ~~ m/<isP>/, q{Match unanchored <isP> (Punctuation)} );

ok("\c[EXCLAMATION MARK]" ~~ m/^<:Punctuation>$/, q{Match <:Punctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:!Punctuation>.$/ ), q{Don't match negated <isPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-:Punctuation>$/ ), q{Don't match inverted <isPunctuation>} );
ok(!( "\x[CE60]"  ~~ m/^<:Punctuation>$/ ), q{Don't match unrelated <isPunctuation>} );
ok("\x[CE60]"  ~~ m/^<:!Punctuation>.$/, q{Match unrelated negated <isPunctuation>} );
ok("\x[CE60]"  ~~ m/^<-:Punctuation>$/, q{Match unrelated inverted <isPunctuation>} );
ok("\x[CE60]\c[EXCLAMATION MARK]" ~~ m/<:Punctuation>/, q{Match unanchored <isPunctuation>} );

# Pc          ConnectorPunctuation


ok("\c[LOW LINE]" ~~ m/^<:Pc>$/, q{Match <:Pc> (ConnectorPunctuation)} );
ok(!( "\c[LOW LINE]" ~~ m/^<:!Pc>.$/ ), q{Don't match negated <isPc> (ConnectorPunctuation)} );
ok(!( "\c[LOW LINE]" ~~ m/^<-:Pc>$/ ), q{Don't match inverted <isPc> (ConnectorPunctuation)} );
ok(!( "\x[5F19]"  ~~ m/^<:Pc>$/ ), q{Don't match unrelated <isPc> (ConnectorPunctuation)} );
ok("\x[5F19]"  ~~ m/^<:!Pc>.$/, q{Match unrelated negated <isPc> (ConnectorPunctuation)} );
ok("\x[5F19]"  ~~ m/^<-:Pc>$/, q{Match unrelated inverted <isPc> (ConnectorPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:Pc>$/ ), q{Don't match related <isPc> (ConnectorPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<:!Pc>.$/, q{Match related negated <isPc> (ConnectorPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-:Pc>$/, q{Match related inverted <isPc> (ConnectorPunctuation)} );
ok("\x[5F19]\c[EXCLAMATION MARK]\c[LOW LINE]" ~~ m/<:Pc>/, q{Match unanchored <isPc> (ConnectorPunctuation)} );

ok("\c[LOW LINE]" ~~ m/^<:ConnectorPunctuation>$/, q{Match <:ConnectorPunctuation>} );
ok(!( "\c[LOW LINE]" ~~ m/^<:!ConnectorPunctuation>.$/ ), q{Don't match negated <isConnectorPunctuation>} );
ok(!( "\c[LOW LINE]" ~~ m/^<-:ConnectorPunctuation>$/ ), q{Don't match inverted <isConnectorPunctuation>} );
ok(!( "\c[YI SYLLABLE MGOX]"  ~~ m/^<:ConnectorPunctuation>$/ ), q{Don't match unrelated <isConnectorPunctuation>} );
ok("\c[YI SYLLABLE MGOX]"  ~~ m/^<:!ConnectorPunctuation>.$/, q{Match unrelated negated <isConnectorPunctuation>} );
ok("\c[YI SYLLABLE MGOX]"  ~~ m/^<-:ConnectorPunctuation>$/, q{Match unrelated inverted <isConnectorPunctuation>} );
ok("\c[YI SYLLABLE MGOX]\c[LOW LINE]" ~~ m/<:ConnectorPunctuation>/, q{Match unanchored <isConnectorPunctuation>} );

# Pd          DashPunctuation


ok("\c[HYPHEN-MINUS]" ~~ m/^<:Pd>$/, q{Match <:Pd> (DashPunctuation)} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<:!Pd>.$/ ), q{Don't match negated <isPd> (DashPunctuation)} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<-:Pd>$/ ), q{Don't match inverted <isPd> (DashPunctuation)} );
ok(!( "\x[49A1]"  ~~ m/^<:Pd>$/ ), q{Don't match unrelated <isPd> (DashPunctuation)} );
ok("\x[49A1]"  ~~ m/^<:!Pd>.$/, q{Match unrelated negated <isPd> (DashPunctuation)} );
ok("\x[49A1]"  ~~ m/^<-:Pd>$/, q{Match unrelated inverted <isPd> (DashPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:Pd>$/ ), q{Don't match related <isPd> (DashPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<:!Pd>.$/, q{Match related negated <isPd> (DashPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-:Pd>$/, q{Match related inverted <isPd> (DashPunctuation)} );
ok("\x[49A1]\c[EXCLAMATION MARK]\c[HYPHEN-MINUS]" ~~ m/<:Pd>/, q{Match unanchored <isPd> (DashPunctuation)} );

ok("\c[HYPHEN-MINUS]" ~~ m/^<:DashPunctuation>$/, q{Match <:DashPunctuation>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<:!DashPunctuation>.$/ ), q{Don't match negated <isDashPunctuation>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<-:DashPunctuation>$/ ), q{Don't match inverted <isDashPunctuation>} );
ok(!( "\x[3C6E]"  ~~ m/^<:DashPunctuation>$/ ), q{Don't match unrelated <isDashPunctuation>} );
ok("\x[3C6E]"  ~~ m/^<:!DashPunctuation>.$/, q{Match unrelated negated <isDashPunctuation>} );
ok("\x[3C6E]"  ~~ m/^<-:DashPunctuation>$/, q{Match unrelated inverted <isDashPunctuation>} );
ok("\x[3C6E]\c[HYPHEN-MINUS]" ~~ m/<:DashPunctuation>/, q{Match unanchored <isDashPunctuation>} );

# Ps          OpenPunctuation


ok("\c[LEFT PARENTHESIS]" ~~ m/^<:Ps>$/, q{Match <:Ps> (OpenPunctuation)} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<:!Ps>.$/ ), q{Don't match negated <isPs> (OpenPunctuation)} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<-:Ps>$/ ), q{Don't match inverted <isPs> (OpenPunctuation)} );
ok(!( "\x[C8A5]"  ~~ m/^<:Ps>$/ ), q{Don't match unrelated <isPs> (OpenPunctuation)} );
ok("\x[C8A5]"  ~~ m/^<:!Ps>.$/, q{Match unrelated negated <isPs> (OpenPunctuation)} );
ok("\x[C8A5]"  ~~ m/^<-:Ps>$/, q{Match unrelated inverted <isPs> (OpenPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:Ps>$/ ), q{Don't match related <isPs> (OpenPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<:!Ps>.$/, q{Match related negated <isPs> (OpenPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-:Ps>$/, q{Match related inverted <isPs> (OpenPunctuation)} );
ok("\x[C8A5]\c[EXCLAMATION MARK]\c[LEFT PARENTHESIS]" ~~ m/<:Ps>/, q{Match unanchored <isPs> (OpenPunctuation)} );

ok("\c[LEFT PARENTHESIS]" ~~ m/^<:OpenPunctuation>$/, q{Match <:OpenPunctuation>} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<:!OpenPunctuation>.$/ ), q{Don't match negated <isOpenPunctuation>} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<-:OpenPunctuation>$/ ), q{Don't match inverted <isOpenPunctuation>} );
ok(!( "\x[84B8]"  ~~ m/^<:OpenPunctuation>$/ ), q{Don't match unrelated <isOpenPunctuation>} );
ok("\x[84B8]"  ~~ m/^<:!OpenPunctuation>.$/, q{Match unrelated negated <isOpenPunctuation>} );
ok("\x[84B8]"  ~~ m/^<-:OpenPunctuation>$/, q{Match unrelated inverted <isOpenPunctuation>} );
ok("\x[84B8]\c[LEFT PARENTHESIS]" ~~ m/<:OpenPunctuation>/, q{Match unanchored <isOpenPunctuation>} );

# Pe          ClosePunctuation


ok("\c[RIGHT PARENTHESIS]" ~~ m/^<:Pe>$/, q{Match <:Pe> (ClosePunctuation)} );
ok(!( "\c[RIGHT PARENTHESIS]" ~~ m/^<:!Pe>.$/ ), q{Don't match negated <isPe> (ClosePunctuation)} );
ok(!( "\c[RIGHT PARENTHESIS]" ~~ m/^<-:Pe>$/ ), q{Don't match inverted <isPe> (ClosePunctuation)} );
ok(!( "\x[BB92]"  ~~ m/^<:Pe>$/ ), q{Don't match unrelated <isPe> (ClosePunctuation)} );
ok("\x[BB92]"  ~~ m/^<:!Pe>.$/, q{Match unrelated negated <isPe> (ClosePunctuation)} );
ok("\x[BB92]"  ~~ m/^<-:Pe>$/, q{Match unrelated inverted <isPe> (ClosePunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:Pe>$/ ), q{Don't match related <isPe> (ClosePunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<:!Pe>.$/, q{Match related negated <isPe> (ClosePunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-:Pe>$/, q{Match related inverted <isPe> (ClosePunctuation)} );
ok("\x[BB92]\c[EXCLAMATION MARK]\c[RIGHT PARENTHESIS]" ~~ m/<:Pe>/, q{Match unanchored <isPe> (ClosePunctuation)} );

ok("\c[RIGHT PARENTHESIS]" ~~ m/^<:ClosePunctuation>$/, q{Match <:ClosePunctuation>} );
ok(!( "\c[RIGHT PARENTHESIS]" ~~ m/^<:!ClosePunctuation>.$/ ), q{Don't match negated <isClosePunctuation>} );
ok(!( "\c[RIGHT PARENTHESIS]" ~~ m/^<-:ClosePunctuation>$/ ), q{Don't match inverted <isClosePunctuation>} );
ok(!( "\x[D55D]"  ~~ m/^<:ClosePunctuation>$/ ), q{Don't match unrelated <isClosePunctuation>} );
ok("\x[D55D]"  ~~ m/^<:!ClosePunctuation>.$/, q{Match unrelated negated <isClosePunctuation>} );
ok("\x[D55D]"  ~~ m/^<-:ClosePunctuation>$/, q{Match unrelated inverted <isClosePunctuation>} );
ok("\x[D55D]\c[RIGHT PARENTHESIS]" ~~ m/<:ClosePunctuation>/, q{Match unanchored <isClosePunctuation>} );

# Pi          InitialPunctuation


ok("\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<:Pi>$/, q{Match <:Pi> (InitialPunctuation)} );
ok(!( "\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<:!Pi>.$/ ), q{Don't match negated <isPi> (InitialPunctuation)} );
ok(!( "\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<-:Pi>$/ ), q{Don't match inverted <isPi> (InitialPunctuation)} );
ok(!( "\x[3A35]"  ~~ m/^<:Pi>$/ ), q{Don't match unrelated <isPi> (InitialPunctuation)} );
ok("\x[3A35]"  ~~ m/^<:!Pi>.$/, q{Match unrelated negated <isPi> (InitialPunctuation)} );
ok("\x[3A35]"  ~~ m/^<-:Pi>$/, q{Match unrelated inverted <isPi> (InitialPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:Pi>$/ ), q{Don't match related <isPi> (InitialPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<:!Pi>.$/, q{Match related negated <isPi> (InitialPunctuation)} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-:Pi>$/, q{Match related inverted <isPi> (InitialPunctuation)} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[3A35]\c[EXCLAMATION MARK]\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/<:Pi>/, q{Match unanchored <isPi> (InitialPunctuation)} );

ok("\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<:InitialPunctuation>$/, q{Match <:InitialPunctuation>} );
ok(!( "\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<:!InitialPunctuation>.$/ ), q{Don't match negated <isInitialPunctuation>} );
ok(!( "\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<-:InitialPunctuation>$/ ), q{Don't match inverted <isInitialPunctuation>} );
ok(!( "\x[B84F]"  ~~ m/^<:InitialPunctuation>$/ ), q{Don't match unrelated <isInitialPunctuation>} );
ok("\x[B84F]"  ~~ m/^<:!InitialPunctuation>.$/, q{Match unrelated negated <isInitialPunctuation>} );
ok("\x[B84F]"  ~~ m/^<-:InitialPunctuation>$/, q{Match unrelated inverted <isInitialPunctuation>} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[B84F]\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/<:InitialPunctuation>/, q{Match unanchored <isInitialPunctuation>} );

# Pf          FinalPunctuation


ok("\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<:Pf>$/, q{Match <:Pf> (FinalPunctuation)} );
ok(!( "\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<:!Pf>.$/ ), q{Don't match negated <isPf> (FinalPunctuation)} );
ok(!( "\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<-:Pf>$/ ), q{Don't match inverted <isPf> (FinalPunctuation)} );
ok(!( "\x[27CF]"  ~~ m/^<:Pf>$/ ), q{Don't match unrelated <isPf> (FinalPunctuation)} );
ok("\x[27CF]"  ~~ m/^<:!Pf>.$/, q{Match unrelated negated <isPf> (FinalPunctuation)} );
ok("\x[27CF]"  ~~ m/^<-:Pf>$/, q{Match unrelated inverted <isPf> (FinalPunctuation)} );
ok(!( "\c[MATHEMATICAL LEFT WHITE SQUARE BRACKET]" ~~ m/^<:Pf>$/ ), q{Don't match related <isPf> (FinalPunctuation)} );
ok("\c[MATHEMATICAL LEFT WHITE SQUARE BRACKET]" ~~ m/^<:!Pf>.$/, q{Match related negated <isPf> (FinalPunctuation)} );
ok("\c[MATHEMATICAL LEFT WHITE SQUARE BRACKET]" ~~ m/^<-:Pf>$/, q{Match related inverted <isPf> (FinalPunctuation)} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[27CF]\c[MATHEMATICAL LEFT WHITE SQUARE BRACKET]\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/<:Pf>/, q{Match unanchored <isPf> (FinalPunctuation)} );

ok("\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<:FinalPunctuation>$/, q{Match <:FinalPunctuation>} );
ok(!( "\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<:!FinalPunctuation>.$/ ), q{Don't match negated <isFinalPunctuation>} );
ok(!( "\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<-:FinalPunctuation>$/ ), q{Don't match inverted <isFinalPunctuation>} );
ok(!( "\x[4F65]"  ~~ m/^<:FinalPunctuation>$/ ), q{Don't match unrelated <isFinalPunctuation>} );
ok("\x[4F65]"  ~~ m/^<:!FinalPunctuation>.$/, q{Match unrelated negated <isFinalPunctuation>} );
ok("\x[4F65]"  ~~ m/^<-:FinalPunctuation>$/, q{Match unrelated inverted <isFinalPunctuation>} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[4F65]\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/<:FinalPunctuation>/, q{Match unanchored <isFinalPunctuation>} );

# Po          OtherPunctuation


ok("\c[EXCLAMATION MARK]" ~~ m/^<:Po>$/, q{Match <:Po> (OtherPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:!Po>.$/ ), q{Don't match negated <isPo> (OtherPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-:Po>$/ ), q{Don't match inverted <isPo> (OtherPunctuation)} );
ok(!( "\x[AA74]"  ~~ m/^<:Po>$/ ), q{Don't match unrelated <isPo> (OtherPunctuation)} );
ok("\x[AA74]"  ~~ m/^<:!Po>.$/, q{Match unrelated negated <isPo> (OtherPunctuation)} );
ok("\x[AA74]"  ~~ m/^<-:Po>$/, q{Match unrelated inverted <isPo> (OtherPunctuation)} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<:Po>$/ ), q{Don't match related <isPo> (OtherPunctuation)} );
ok("\c[LEFT PARENTHESIS]" ~~ m/^<:!Po>.$/, q{Match related negated <isPo> (OtherPunctuation)} );
ok("\c[LEFT PARENTHESIS]" ~~ m/^<-:Po>$/, q{Match related inverted <isPo> (OtherPunctuation)} );
ok("\x[AA74]\c[LEFT PARENTHESIS]\c[EXCLAMATION MARK]" ~~ m/<:Po>/, q{Match unanchored <isPo> (OtherPunctuation)} );

ok("\c[EXCLAMATION MARK]" ~~ m/^<:OtherPunctuation>$/, q{Match <:OtherPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:!OtherPunctuation>.$/ ), q{Don't match negated <isOtherPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-:OtherPunctuation>$/ ), q{Don't match inverted <isOtherPunctuation>} );
ok(!( "\x[7DD2]"  ~~ m/^<:OtherPunctuation>$/ ), q{Don't match unrelated <isOtherPunctuation>} );
ok("\x[7DD2]"  ~~ m/^<:!OtherPunctuation>.$/, q{Match unrelated negated <isOtherPunctuation>} );
ok("\x[7DD2]"  ~~ m/^<-:OtherPunctuation>$/, q{Match unrelated inverted <isOtherPunctuation>} );
ok("\x[7DD2]\c[EXCLAMATION MARK]" ~~ m/<:OtherPunctuation>/, q{Match unanchored <isOtherPunctuation>} );

# S           Symbol


ok("\c[YI RADICAL QOT]" ~~ m/^<isS>$/, q{Match <isS> (Symbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:!S>.$/ ), q{Don't match negated <isS> (Symbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-:S>$/ ), q{Don't match inverted <isS> (Symbol)} );
ok(!( "\x[8839]"  ~~ m/^<isS>$/ ), q{Don't match unrelated <isS> (Symbol)} );
ok("\x[8839]"  ~~ m/^<:!S>.$/, q{Match unrelated negated <isS> (Symbol)} );
ok("\x[8839]"  ~~ m/^<-:S>$/, q{Match unrelated inverted <isS> (Symbol)} );
ok("\x[8839]\c[YI RADICAL QOT]" ~~ m/<isS>/, q{Match unanchored <isS> (Symbol)} );

ok("\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<:Symbol>$/, q{Match <:Symbol>} );
ok(!( "\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<:!Symbol>.$/ ), q{Don't match negated <isSymbol>} );
ok(!( "\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<-:Symbol>$/ ), q{Don't match inverted <isSymbol>} );
ok(!( "\x[4A1C]"  ~~ m/^<:Symbol>$/ ), q{Don't match unrelated <isSymbol>} );
ok("\x[4A1C]"  ~~ m/^<:!Symbol>.$/, q{Match unrelated negated <isSymbol>} );
ok("\x[4A1C]"  ~~ m/^<-:Symbol>$/, q{Match unrelated inverted <isSymbol>} );
ok("\x[4A1C]\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/<:Symbol>/, q{Match unanchored <isSymbol>} );

# Sm          MathSymbol


ok("\c[PLUS SIGN]" ~~ m/^<:Sm>$/, q{Match <:Sm> (MathSymbol)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<:!Sm>.$/ ), q{Don't match negated <isSm> (MathSymbol)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<-:Sm>$/ ), q{Don't match inverted <isSm> (MathSymbol)} );
ok(!( "\x[B258]"  ~~ m/^<:Sm>$/ ), q{Don't match unrelated <isSm> (MathSymbol)} );
ok("\x[B258]"  ~~ m/^<:!Sm>.$/, q{Match unrelated negated <isSm> (MathSymbol)} );
ok("\x[B258]"  ~~ m/^<-:Sm>$/, q{Match unrelated inverted <isSm> (MathSymbol)} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<:Sm>$/ ), q{Don't match related <isSm> (MathSymbol)} );
ok("\c[DOLLAR SIGN]" ~~ m/^<:!Sm>.$/, q{Match related negated <isSm> (MathSymbol)} );
ok("\c[DOLLAR SIGN]" ~~ m/^<-:Sm>$/, q{Match related inverted <isSm> (MathSymbol)} );
ok("\x[B258]\c[DOLLAR SIGN]\c[PLUS SIGN]" ~~ m/<:Sm>/, q{Match unanchored <isSm> (MathSymbol)} );

ok("\c[PLUS SIGN]" ~~ m/^<:MathSymbol>$/, q{Match <:MathSymbol>} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<:!MathSymbol>.$/ ), q{Don't match negated <isMathSymbol>} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<-:MathSymbol>$/ ), q{Don't match inverted <isMathSymbol>} );
ok(!( "\x[98FF]"  ~~ m/^<:MathSymbol>$/ ), q{Don't match unrelated <isMathSymbol>} );
ok("\x[98FF]"  ~~ m/^<:!MathSymbol>.$/, q{Match unrelated negated <isMathSymbol>} );
ok("\x[98FF]"  ~~ m/^<-:MathSymbol>$/, q{Match unrelated inverted <isMathSymbol>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:MathSymbol>$/ ), q{Don't match related <isMathSymbol>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!MathSymbol>.$/, q{Match related negated <isMathSymbol>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:MathSymbol>$/, q{Match related inverted <isMathSymbol>} );
ok("\x[98FF]\c[COMBINING GRAVE ACCENT]\c[PLUS SIGN]" ~~ m/<:MathSymbol>/, q{Match unanchored <isMathSymbol>} );

# Sc          CurrencySymbol


ok("\c[DOLLAR SIGN]" ~~ m/^<:Sc>$/, q{Match <:Sc> (CurrencySymbol)} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<:!Sc>.$/ ), q{Don't match negated <isSc> (CurrencySymbol)} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<-:Sc>$/ ), q{Don't match inverted <isSc> (CurrencySymbol)} );
ok(!( "\x[994C]"  ~~ m/^<:Sc>$/ ), q{Don't match unrelated <isSc> (CurrencySymbol)} );
ok("\x[994C]"  ~~ m/^<:!Sc>.$/, q{Match unrelated negated <isSc> (CurrencySymbol)} );
ok("\x[994C]"  ~~ m/^<-:Sc>$/, q{Match unrelated inverted <isSc> (CurrencySymbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:Sc>$/ ), q{Don't match related <isSc> (CurrencySymbol)} );
ok("\c[YI RADICAL QOT]" ~~ m/^<:!Sc>.$/, q{Match related negated <isSc> (CurrencySymbol)} );
ok("\c[YI RADICAL QOT]" ~~ m/^<-:Sc>$/, q{Match related inverted <isSc> (CurrencySymbol)} );
ok("\x[994C]\c[YI RADICAL QOT]\c[DOLLAR SIGN]" ~~ m/<:Sc>/, q{Match unanchored <isSc> (CurrencySymbol)} );

ok("\c[DOLLAR SIGN]" ~~ m/^<:CurrencySymbol>$/, q{Match <:CurrencySymbol>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<:!CurrencySymbol>.$/ ), q{Don't match negated <isCurrencySymbol>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<-:CurrencySymbol>$/ ), q{Don't match inverted <isCurrencySymbol>} );
ok(!( "\x[37C0]"  ~~ m/^<:CurrencySymbol>$/ ), q{Don't match unrelated <isCurrencySymbol>} );
ok("\x[37C0]"  ~~ m/^<:!CurrencySymbol>.$/, q{Match unrelated negated <isCurrencySymbol>} );
ok("\x[37C0]"  ~~ m/^<-:CurrencySymbol>$/, q{Match unrelated inverted <isCurrencySymbol>} );
ok("\x[37C0]\c[DOLLAR SIGN]" ~~ m/<:CurrencySymbol>/, q{Match unanchored <isCurrencySymbol>} );

# Sk          ModifierSymbol


ok("\c[CIRCUMFLEX ACCENT]" ~~ m/^<:Sk>$/, q{Match <:Sk> (ModifierSymbol)} );
ok(!( "\c[CIRCUMFLEX ACCENT]" ~~ m/^<:!Sk>.$/ ), q{Don't match negated <isSk> (ModifierSymbol)} );
ok(!( "\c[CIRCUMFLEX ACCENT]" ~~ m/^<-:Sk>$/ ), q{Don't match inverted <isSk> (ModifierSymbol)} );
ok(!( "\x[4578]"  ~~ m/^<:Sk>$/ ), q{Don't match unrelated <isSk> (ModifierSymbol)} );
ok("\x[4578]"  ~~ m/^<:!Sk>.$/, q{Match unrelated negated <isSk> (ModifierSymbol)} );
ok("\x[4578]"  ~~ m/^<-:Sk>$/, q{Match unrelated inverted <isSk> (ModifierSymbol)} );
ok(!( "\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<:Sk>$/ ), q{Don't match related <isSk> (ModifierSymbol)} );
ok("\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<:!Sk>.$/, q{Match related negated <isSk> (ModifierSymbol)} );
ok("\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<-:Sk>$/, q{Match related inverted <isSk> (ModifierSymbol)} );
ok("\x[4578]\c[HEXAGRAM FOR THE CREATIVE HEAVEN]\c[CIRCUMFLEX ACCENT]" ~~ m/<:Sk>/, q{Match unanchored <isSk> (ModifierSymbol)} );

ok("\c[CIRCUMFLEX ACCENT]" ~~ m/^<:ModifierSymbol>$/, q{Match <:ModifierSymbol>} );
ok(!( "\c[CIRCUMFLEX ACCENT]" ~~ m/^<:!ModifierSymbol>.$/ ), q{Don't match negated <isModifierSymbol>} );
ok(!( "\c[CIRCUMFLEX ACCENT]" ~~ m/^<-:ModifierSymbol>$/ ), q{Don't match inverted <isModifierSymbol>} );
ok(!( "\x[42F1]"  ~~ m/^<:ModifierSymbol>$/ ), q{Don't match unrelated <isModifierSymbol>} );
ok("\x[42F1]"  ~~ m/^<:!ModifierSymbol>.$/, q{Match unrelated negated <isModifierSymbol>} );
ok("\x[42F1]"  ~~ m/^<-:ModifierSymbol>$/, q{Match unrelated inverted <isModifierSymbol>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:ModifierSymbol>$/ ), q{Don't match related <isModifierSymbol>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!ModifierSymbol>.$/, q{Match related negated <isModifierSymbol>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:ModifierSymbol>$/, q{Match related inverted <isModifierSymbol>} );
ok("\x[42F1]\c[COMBINING GRAVE ACCENT]\c[CIRCUMFLEX ACCENT]" ~~ m/<:ModifierSymbol>/, q{Match unanchored <isModifierSymbol>} );

# So          OtherSymbol


ok("\c[YI RADICAL QOT]" ~~ m/^<:So>$/, q{Match <:So> (OtherSymbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:!So>.$/ ), q{Don't match negated <isSo> (OtherSymbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-:So>$/ ), q{Don't match inverted <isSo> (OtherSymbol)} );
ok(!( "\x[83DE]"  ~~ m/^<:So>$/ ), q{Don't match unrelated <isSo> (OtherSymbol)} );
ok("\x[83DE]"  ~~ m/^<:!So>.$/, q{Match unrelated negated <isSo> (OtherSymbol)} );
ok("\x[83DE]"  ~~ m/^<-:So>$/, q{Match unrelated inverted <isSo> (OtherSymbol)} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<:So>$/ ), q{Don't match related <isSo> (OtherSymbol)} );
ok("\c[DOLLAR SIGN]" ~~ m/^<:!So>.$/, q{Match related negated <isSo> (OtherSymbol)} );
ok("\c[DOLLAR SIGN]" ~~ m/^<-:So>$/, q{Match related inverted <isSo> (OtherSymbol)} );
ok("\x[83DE]\c[DOLLAR SIGN]\c[YI RADICAL QOT]" ~~ m/<:So>/, q{Match unanchored <isSo> (OtherSymbol)} );

ok("\c[YI RADICAL QOT]" ~~ m/^<:OtherSymbol>$/, q{Match <:OtherSymbol>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:!OtherSymbol>.$/ ), q{Don't match negated <isOtherSymbol>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-:OtherSymbol>$/ ), q{Don't match inverted <isOtherSymbol>} );
ok(!( "\x[9B2C]"  ~~ m/^<:OtherSymbol>$/ ), q{Don't match unrelated <isOtherSymbol>} );
ok("\x[9B2C]"  ~~ m/^<:!OtherSymbol>.$/, q{Match unrelated negated <isOtherSymbol>} );
ok("\x[9B2C]"  ~~ m/^<-:OtherSymbol>$/, q{Match unrelated inverted <isOtherSymbol>} );
ok("\x[9B2C]\c[YI RADICAL QOT]" ~~ m/<:OtherSymbol>/, q{Match unanchored <isOtherSymbol>} );

# Z           Separator


ok("\c[IDEOGRAPHIC SPACE]" ~~ m/^<isZ>$/, q{Match <isZ> (Separator)} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<:!Z>.$/ ), q{Don't match negated <isZ> (Separator)} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<-:Z>$/ ), q{Don't match inverted <isZ> (Separator)} );
ok(!( "\x[2C08]"  ~~ m/^<isZ>$/ ), q{Don't match unrelated <isZ> (Separator)} );
ok("\x[2C08]"  ~~ m/^<:!Z>.$/, q{Match unrelated negated <isZ> (Separator)} );
ok("\x[2C08]"  ~~ m/^<-:Z>$/, q{Match unrelated inverted <isZ> (Separator)} );
ok("\x[2C08]\c[IDEOGRAPHIC SPACE]" ~~ m/<isZ>/, q{Match unanchored <isZ> (Separator)} );

ok("\c[SPACE]" ~~ m/^<:Separator>$/, q{Match <:Separator>} );
ok(!( "\c[SPACE]" ~~ m/^<:!Separator>.$/ ), q{Don't match negated <isSeparator>} );
ok(!( "\c[SPACE]" ~~ m/^<-:Separator>$/ ), q{Don't match inverted <isSeparator>} );
ok(!( "\c[YI SYLLABLE SOX]"  ~~ m/^<:Separator>$/ ), q{Don't match unrelated <isSeparator>} );
ok("\c[YI SYLLABLE SOX]"  ~~ m/^<:!Separator>.$/, q{Match unrelated negated <isSeparator>} );
ok("\c[YI SYLLABLE SOX]"  ~~ m/^<-:Separator>$/, q{Match unrelated inverted <isSeparator>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:Separator>$/ ), q{Don't match related <isSeparator>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<:!Separator>.$/, q{Match related negated <isSeparator>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<-:Separator>$/, q{Match related inverted <isSeparator>} );
ok("\c[YI SYLLABLE SOX]\c[YI RADICAL QOT]\c[SPACE]" ~~ m/<:Separator>/, q{Match unanchored <isSeparator>} );

# Zs          SpaceSeparator


ok("\c[SPACE]" ~~ m/^<:Zs>$/, q{Match <:Zs> (SpaceSeparator)} );
ok(!( "\c[SPACE]" ~~ m/^<:!Zs>.$/ ), q{Don't match negated <isZs> (SpaceSeparator)} );
ok(!( "\c[SPACE]" ~~ m/^<-:Zs>$/ ), q{Don't match inverted <isZs> (SpaceSeparator)} );
ok(!( "\x[88DD]"  ~~ m/^<:Zs>$/ ), q{Don't match unrelated <isZs> (SpaceSeparator)} );
ok("\x[88DD]"  ~~ m/^<:!Zs>.$/, q{Match unrelated negated <isZs> (SpaceSeparator)} );
ok("\x[88DD]"  ~~ m/^<-:Zs>$/, q{Match unrelated inverted <isZs> (SpaceSeparator)} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<:Zs>$/ ), q{Don't match related <isZs> (SpaceSeparator)} );
ok("\c[LINE SEPARATOR]" ~~ m/^<:!Zs>.$/, q{Match related negated <isZs> (SpaceSeparator)} );
ok("\c[LINE SEPARATOR]" ~~ m/^<-:Zs>$/, q{Match related inverted <isZs> (SpaceSeparator)} );
ok("\x[88DD]\c[LINE SEPARATOR]\c[SPACE]" ~~ m/<:Zs>/, q{Match unanchored <isZs> (SpaceSeparator)} );

ok("\c[SPACE]" ~~ m/^<:SpaceSeparator>$/, q{Match <:SpaceSeparator>} );
ok(!( "\c[SPACE]" ~~ m/^<:!SpaceSeparator>.$/ ), q{Don't match negated <isSpaceSeparator>} );
ok(!( "\c[SPACE]" ~~ m/^<-:SpaceSeparator>$/ ), q{Don't match inverted <isSpaceSeparator>} );
ok(!( "\x[C808]"  ~~ m/^<:SpaceSeparator>$/ ), q{Don't match unrelated <isSpaceSeparator>} );
ok("\x[C808]"  ~~ m/^<:!SpaceSeparator>.$/, q{Match unrelated negated <isSpaceSeparator>} );
ok("\x[C808]"  ~~ m/^<-:SpaceSeparator>$/, q{Match unrelated inverted <isSpaceSeparator>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<:SpaceSeparator>$/ ), q{Don't match related <isSpaceSeparator>} );
ok("\c[DOLLAR SIGN]" ~~ m/^<:!SpaceSeparator>.$/, q{Match related negated <isSpaceSeparator>} );
ok("\c[DOLLAR SIGN]" ~~ m/^<-:SpaceSeparator>$/, q{Match related inverted <isSpaceSeparator>} );
ok("\x[C808]\c[DOLLAR SIGN]\c[SPACE]" ~~ m/<:SpaceSeparator>/, q{Match unanchored <isSpaceSeparator>} );

# Zl          LineSeparator


ok("\c[LINE SEPARATOR]" ~~ m/^<:Zl>$/, q{Match <:Zl> (LineSeparator)} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<:!Zl>.$/ ), q{Don't match negated <isZl> (LineSeparator)} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<-:Zl>$/ ), q{Don't match inverted <isZl> (LineSeparator)} );
ok(!( "\x[B822]"  ~~ m/^<:Zl>$/ ), q{Don't match unrelated <isZl> (LineSeparator)} );
ok("\x[B822]"  ~~ m/^<:!Zl>.$/, q{Match unrelated negated <isZl> (LineSeparator)} );
ok("\x[B822]"  ~~ m/^<-:Zl>$/, q{Match unrelated inverted <isZl> (LineSeparator)} );
ok(!( "\c[SPACE]" ~~ m/^<:Zl>$/ ), q{Don't match related <isZl> (LineSeparator)} );
ok("\c[SPACE]" ~~ m/^<:!Zl>.$/, q{Match related negated <isZl> (LineSeparator)} );
ok("\c[SPACE]" ~~ m/^<-:Zl>$/, q{Match related inverted <isZl> (LineSeparator)} );
ok("\x[B822]\c[SPACE]\c[LINE SEPARATOR]" ~~ m/<:Zl>/, q{Match unanchored <isZl> (LineSeparator)} );

ok("\c[LINE SEPARATOR]" ~~ m/^<:LineSeparator>$/, q{Match <:LineSeparator>} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<:!LineSeparator>.$/ ), q{Don't match negated <isLineSeparator>} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<-:LineSeparator>$/ ), q{Don't match inverted <isLineSeparator>} );
ok(!( "\x[1390]"  ~~ m/^<:LineSeparator>$/ ), q{Don't match unrelated <isLineSeparator>} );
ok("\x[1390]"  ~~ m/^<:!LineSeparator>.$/, q{Match unrelated negated <isLineSeparator>} );
ok("\x[1390]"  ~~ m/^<-:LineSeparator>$/, q{Match unrelated inverted <isLineSeparator>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<:LineSeparator>$/ ), q{Don't match related <isLineSeparator>} );
ok("\c[CHEROKEE LETTER A]" ~~ m/^<:!LineSeparator>.$/, q{Match related negated <isLineSeparator>} );
ok("\c[CHEROKEE LETTER A]" ~~ m/^<-:LineSeparator>$/, q{Match related inverted <isLineSeparator>} );
ok("\x[1390]\c[CHEROKEE LETTER A]\c[LINE SEPARATOR]" ~~ m/<:LineSeparator>/, q{Match unanchored <isLineSeparator>} );

# Zp          ParagraphSeparator


ok("\c[PARAGRAPH SEPARATOR]" ~~ m/^<:Zp>$/, q{Match <:Zp> (ParagraphSeparator)} );
ok(!( "\c[PARAGRAPH SEPARATOR]" ~~ m/^<:!Zp>.$/ ), q{Don't match negated <isZp> (ParagraphSeparator)} );
ok(!( "\c[PARAGRAPH SEPARATOR]" ~~ m/^<-:Zp>$/ ), q{Don't match inverted <isZp> (ParagraphSeparator)} );
ok(!( "\x[5FDE]"  ~~ m/^<:Zp>$/ ), q{Don't match unrelated <isZp> (ParagraphSeparator)} );
ok("\x[5FDE]"  ~~ m/^<:!Zp>.$/, q{Match unrelated negated <isZp> (ParagraphSeparator)} );
ok("\x[5FDE]"  ~~ m/^<-:Zp>$/, q{Match unrelated inverted <isZp> (ParagraphSeparator)} );
ok(!( "\c[SPACE]" ~~ m/^<:Zp>$/ ), q{Don't match related <isZp> (ParagraphSeparator)} );
ok("\c[SPACE]" ~~ m/^<:!Zp>.$/, q{Match related negated <isZp> (ParagraphSeparator)} );
ok("\c[SPACE]" ~~ m/^<-:Zp>$/, q{Match related inverted <isZp> (ParagraphSeparator)} );
ok("\x[5FDE]\c[SPACE]\c[PARAGRAPH SEPARATOR]" ~~ m/<:Zp>/, q{Match unanchored <isZp> (ParagraphSeparator)} );

ok("\c[PARAGRAPH SEPARATOR]" ~~ m/^<:ParagraphSeparator>$/, q{Match <:ParagraphSeparator>} );
ok(!( "\c[PARAGRAPH SEPARATOR]" ~~ m/^<:!ParagraphSeparator>.$/ ), q{Don't match negated <isParagraphSeparator>} );
ok(!( "\c[PARAGRAPH SEPARATOR]" ~~ m/^<-:ParagraphSeparator>$/ ), q{Don't match inverted <isParagraphSeparator>} );
ok(!( "\x[345B]"  ~~ m/^<:ParagraphSeparator>$/ ), q{Don't match unrelated <isParagraphSeparator>} );
ok("\x[345B]"  ~~ m/^<:!ParagraphSeparator>.$/, q{Match unrelated negated <isParagraphSeparator>} );
ok("\x[345B]"  ~~ m/^<-:ParagraphSeparator>$/, q{Match unrelated inverted <isParagraphSeparator>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:ParagraphSeparator>$/ ), q{Don't match related <isParagraphSeparator>} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<:!ParagraphSeparator>.$/, q{Match related negated <isParagraphSeparator>} );
ok("\c[EXCLAMATION MARK]" ~~ m/^<-:ParagraphSeparator>$/, q{Match related inverted <isParagraphSeparator>} );
ok("\x[345B]\c[EXCLAMATION MARK]\c[PARAGRAPH SEPARATOR]" ~~ m/<:ParagraphSeparator>/, q{Match unanchored <isParagraphSeparator>} );

# C           Other


#?rakudo 3 skip "Uninvestigated nqp-rx regression"
ok("\x[9FC4]" ~~ m/^<isC>$/, q{Match <isC> (Other)} );
ok(!( "\x[9FC4]" ~~ m/^<:!C>.$/ ), q{Don't match negated <isC> (Other)} );
ok(!( "\x[9FC4]" ~~ m/^<-:C>$/ ), q{Don't match inverted <isC> (Other)} );
ok(!( "\x[6A3F]"  ~~ m/^<isC>$/ ), q{Don't match unrelated <isC> (Other)} );
ok("\x[6A3F]"  ~~ m/^<:!C>.$/, q{Match unrelated negated <isC> (Other)} );
ok("\x[6A3F]"  ~~ m/^<-:C>$/, q{Match unrelated inverted <isC> (Other)} );
#?rakudo skip "Uninvestigated nqp-rx regression"
ok("\x[6A3F]\x[9FC4]" ~~ m/<isC>/, q{Match unanchored <isC> (Other)} );

ok("\x[A679]" ~~ m/^<:Other>$/, q{Match <:Other>} );
ok(!( "\x[A679]" ~~ m/^<:!Other>.$/ ), q{Don't match negated <isOther>} );
ok(!( "\x[A679]" ~~ m/^<-:Other>$/ ), q{Don't match inverted <isOther>} );
ok(!( "\x[AC00]"  ~~ m/^<:Other>$/ ), q{Don't match unrelated <isOther>} );
ok("\x[AC00]"  ~~ m/^<:!Other>.$/, q{Match unrelated negated <isOther>} );
ok("\x[AC00]"  ~~ m/^<-:Other>$/, q{Match unrelated inverted <isOther>} );
ok("\x[AC00]\x[A679]" ~~ m/<:Other>/, q{Match unanchored <isOther>} );

# Cc          Control


ok("\c[NULL]" ~~ m/^<:Cc>$/, q{Match <:Cc> (Control)} );
ok(!( "\c[NULL]" ~~ m/^<:!Cc>.$/ ), q{Don't match negated <isCc> (Control)} );
ok(!( "\c[NULL]" ~~ m/^<-:Cc>$/ ), q{Don't match inverted <isCc> (Control)} );
ok(!( "\x[0A7A]"  ~~ m/^<:Cc>$/ ), q{Don't match unrelated <isCc> (Control)} );
ok("\x[0A7A]"  ~~ m/^<:!Cc>.$/, q{Match unrelated negated <isCc> (Control)} );
ok("\x[0A7A]"  ~~ m/^<-:Cc>$/, q{Match unrelated inverted <isCc> (Control)} );
ok(!( "\x[0A7A]" ~~ m/^<:Cc>$/ ), q{Don't match related <isCc> (Control)} );
ok("\x[0A7A]" ~~ m/^<:!Cc>.$/, q{Match related negated <isCc> (Control)} );
ok("\x[0A7A]" ~~ m/^<-:Cc>$/, q{Match related inverted <isCc> (Control)} );
ok("\x[0A7A]\x[0A7A]\c[NULL]" ~~ m/<:Cc>/, q{Match unanchored <isCc> (Control)} );

ok("\c[NULL]" ~~ m/^<:Control>$/, q{Match <:Control>} );
ok(!( "\c[NULL]" ~~ m/^<:!Control>.$/ ), q{Don't match negated <isControl>} );
ok(!( "\c[NULL]" ~~ m/^<-:Control>$/ ), q{Don't match inverted <isControl>} );
ok(!( "\x[4886]"  ~~ m/^<:Control>$/ ), q{Don't match unrelated <isControl>} );
ok("\x[4886]"  ~~ m/^<:!Control>.$/, q{Match unrelated negated <isControl>} );
ok("\x[4886]"  ~~ m/^<-:Control>$/, q{Match unrelated inverted <isControl>} );
ok(!( "\x[4DB6]" ~~ m/^<:Control>$/ ), q{Don't match related <isControl>} );
ok("\x[4DB6]" ~~ m/^<:!Control>.$/, q{Match related negated <isControl>} );
ok("\x[4DB6]" ~~ m/^<-:Control>$/, q{Match related inverted <isControl>} );
ok("\x[4886]\x[4DB6]\c[NULL]" ~~ m/<:Control>/, q{Match unanchored <isControl>} );

# Cf          Format


ok("\c[SOFT HYPHEN]" ~~ m/^<:Cf>$/, q{Match <:Cf> (Format)} );
ok(!( "\c[SOFT HYPHEN]" ~~ m/^<:!Cf>.$/ ), q{Don't match negated <isCf> (Format)} );
ok(!( "\c[SOFT HYPHEN]" ~~ m/^<-:Cf>$/ ), q{Don't match inverted <isCf> (Format)} );
ok(!( "\x[77B8]"  ~~ m/^<:Cf>$/ ), q{Don't match unrelated <isCf> (Format)} );
ok("\x[77B8]"  ~~ m/^<:!Cf>.$/, q{Match unrelated negated <isCf> (Format)} );
ok("\x[77B8]"  ~~ m/^<-:Cf>$/, q{Match unrelated inverted <isCf> (Format)} );
ok(!( "\x[9FC4]" ~~ m/^<:Cf>$/ ), q{Don't match related <isCf> (Format)} );
ok("\x[9FC4]" ~~ m/^<:!Cf>.$/, q{Match related negated <isCf> (Format)} );
ok("\x[9FC4]" ~~ m/^<-:Cf>$/, q{Match related inverted <isCf> (Format)} );
#?rakudo skip "Malformed UTF-8 string"
ok("\x[77B8]\x[9FC4]\c[SOFT HYPHEN]" ~~ m/<:Cf>/, q{Match unanchored <isCf> (Format)} );

ok("\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<:Format>$/, q{Match <:Format>} );
ok(!( "\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<:!Format>.$/ ), q{Don't match negated <isFormat>} );
ok(!( "\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<-:Format>$/ ), q{Don't match inverted <isFormat>} );
ok(!( "\c[DEVANAGARI VOWEL SIGN AU]"  ~~ m/^<:Format>$/ ), q{Don't match unrelated <isFormat>} );
ok("\c[DEVANAGARI VOWEL SIGN AU]"  ~~ m/^<:!Format>.$/, q{Match unrelated negated <isFormat>} );
ok("\c[DEVANAGARI VOWEL SIGN AU]"  ~~ m/^<-:Format>$/, q{Match unrelated inverted <isFormat>} );
ok("\c[DEVANAGARI VOWEL SIGN AU]\c[KHMER VOWEL INHERENT AQ]" ~~ m/<:Format>/, q{Match unanchored <isFormat>} );


# vim: ft=perl6
