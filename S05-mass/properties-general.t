use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/properties_slow_to_compile.t.

XXX needs more clarification on the case of the rules, 
ie letter vs. Letter vs isLetter

U+FFFE and U+FFFF are guaranteed noncharacters.  A previous version of
this test file used nonguaranteed noncharacters, which were assigned in
Unicode 5.2.

=end pod

plan 594;

# L           Letter

#?pugs todo
ok("\x[846D]" ~~ m/^<:L>$/, q{Match <:L> (Letter)} );
ok(!( "\x[846D]" ~~ m/^<:!L>$/ ), q{Don't match negated <L> (Letter)} );
ok(!( "\x[846D]" ~~ m/^<-:L>$/ ), q{Don't match inverted <L> (Letter)} );
#?rakudo 4 skip 'ICU version dependent :('
ok(!( "\x[FFFE]"  ~~ m/^<:L>$/ ), q{Don't match unrelated <L> (Letter)} );
#?pugs todo
ok("\x[FFFE]"  ~~ m/^<:!L>$/, q{Match unrelated negated <L> (Letter)} );
#?pugs todo
ok("\x[FFFE]"  ~~ m/^<-:L>$/, q{Match unrelated inverted <L> (Letter)} );
#?pugs todo
ok("\x[FFFE]\x[846D]" ~~ m/<:L>/, q{Match unanchored <:L> (Letter)} );

#?pugs todo
ok("\x[6DF7]" ~~ m/^<:Letter>$/, q{Match <:Letter>} );
ok(!( "\x[6DF7]" ~~ m/^<:!Letter>$/ ), q{Don't match negated <Letter>} );
ok(!( "\x[6DF7]" ~~ m/^<-:Letter>$/ ), q{Don't match inverted <Letter>} );
#?rakudo 4 skip 'ICU version dependent :('
ok(!( "\x[FFFE]"  ~~ m/^<:Letter>$/ ), q{Don't match unrelated <Letter>} );
#?pugs todo
ok("\x[FFFE]"  ~~ m/^<:!Letter>$/, q{Match unrelated negated <Letter>} );
#?pugs todo
ok("\x[FFFE]"  ~~ m/^<-:Letter>$/, q{Match unrelated inverted <Letter>} );
#?pugs todo
ok("\x[FFFE]\x[6DF7]" ~~ m/<:Letter>/, q{Match unanchored <Letter>} );

# Lu          UppercaseLetter


#?pugs todo
ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<:Lu>$/, q{Match <:Lu> (UppercaseLetter)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<:!Lu>$/ ), q{Don't match negated <Lu> (UppercaseLetter)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-:Lu>$/ ), q{Don't match inverted <Lu> (UppercaseLetter)} );
ok(!( "\x[C767]"  ~~ m/^<:Lu>$/ ), q{Don't match unrelated <Lu> (UppercaseLetter)} );
#?pugs todo
ok("\x[C767]"  ~~ m/^<:!Lu>$/, q{Match unrelated negated <Lu> (UppercaseLetter)} );
#?pugs todo
ok("\x[C767]"  ~~ m/^<-:Lu>$/, q{Match unrelated inverted <Lu> (UppercaseLetter)} );
ok(!( "\x[C767]" ~~ m/^<:Lu>$/ ), q{Don't match related <Lu> (UppercaseLetter)} );
#?pugs todo
ok("\x[C767]" ~~ m/^<:!Lu>$/, q{Match related negated <Lu> (UppercaseLetter)} );
#?pugs todo
ok("\x[C767]" ~~ m/^<-:Lu>$/, q{Match related inverted <Lu> (UppercaseLetter)} );
#?pugs todo
ok("\x[C767]\x[C767]\c[LATIN CAPITAL LETTER A]" ~~ m/<:Lu>/, q{Match unanchored <Lu> (UppercaseLetter)} );

#?pugs todo
ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<:UppercaseLetter>$/, q{Match <:UppercaseLetter>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<:!UppercaseLetter>$/ ), q{Don't match negated <UppercaseLetter>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-:UppercaseLetter>$/ ), q{Don't match inverted <UppercaseLetter>} );
ok(!( "\c[YI SYLLABLE NBA]"  ~~ m/^<:UppercaseLetter>$/ ), q{Don't match unrelated <UppercaseLetter>} );
#?pugs todo
ok("\c[YI SYLLABLE NBA]"  ~~ m/^<:!UppercaseLetter>$/, q{Match unrelated negated <UppercaseLetter>} );
#?pugs todo
ok("\c[YI SYLLABLE NBA]"  ~~ m/^<-:UppercaseLetter>$/, q{Match unrelated inverted <UppercaseLetter>} );
#?pugs todo
ok("\c[YI SYLLABLE NBA]\c[LATIN CAPITAL LETTER A]" ~~ m/<:UppercaseLetter>/, q{Match unanchored <UppercaseLetter>} );

# Ll          LowercaseLetter


#?pugs todo
ok("\c[LATIN SMALL LETTER A]" ~~ m/^<:Ll>$/, q{Match <:Ll> (LowercaseLetter)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<:!Ll>$/ ), q{Don't match negated <Ll> (LowercaseLetter)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<-:Ll>$/ ), q{Don't match inverted <Ll> (LowercaseLetter)} );
ok(!( "\c[BOPOMOFO FINAL LETTER H]"  ~~ m/^<:Ll>$/ ), q{Don't match unrelated <Ll> (LowercaseLetter)} );
#?pugs todo
ok("\c[BOPOMOFO FINAL LETTER H]"  ~~ m/^<:!Ll>$/, q{Match unrelated negated <Ll> (LowercaseLetter)} );
#?pugs todo
ok("\c[BOPOMOFO FINAL LETTER H]"  ~~ m/^<-:Ll>$/, q{Match unrelated inverted <Ll> (LowercaseLetter)} );
ok(!( "\c[BOPOMOFO FINAL LETTER H]" ~~ m/^<:Ll>$/ ), q{Don't match related <Ll> (LowercaseLetter)} );
#?pugs todo
ok("\c[BOPOMOFO FINAL LETTER H]" ~~ m/^<:!Ll>$/, q{Match related negated <Ll> (LowercaseLetter)} );
#?pugs todo
ok("\c[BOPOMOFO FINAL LETTER H]" ~~ m/^<-:Ll>$/, q{Match related inverted <Ll> (LowercaseLetter)} );
#?pugs todo
ok("\c[BOPOMOFO FINAL LETTER H]\c[BOPOMOFO FINAL LETTER H]\c[LATIN SMALL LETTER A]" ~~ m/<:Ll>/, q{Match unanchored <Ll> (LowercaseLetter)} );

#?pugs todo
ok("\c[LATIN SMALL LETTER A]" ~~ m/^<:LowercaseLetter>$/, q{Match <:LowercaseLetter>} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<:!LowercaseLetter>$/ ), q{Don't match negated <LowercaseLetter>} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<-:LowercaseLetter>$/ ), q{Don't match inverted <LowercaseLetter>} );
ok(!( "\x[86CA]"  ~~ m/^<:LowercaseLetter>$/ ), q{Don't match unrelated <LowercaseLetter>} );
#?pugs todo
ok("\x[86CA]"  ~~ m/^<:!LowercaseLetter>$/, q{Match unrelated negated <LowercaseLetter>} );
#?pugs todo
ok("\x[86CA]"  ~~ m/^<-:LowercaseLetter>$/, q{Match unrelated inverted <LowercaseLetter>} );
ok(!( "\x[86CA]" ~~ m/^<:LowercaseLetter>$/ ), q{Don't match related <LowercaseLetter>} );
#?pugs todo
ok("\x[86CA]" ~~ m/^<:!LowercaseLetter>$/, q{Match related negated <LowercaseLetter>} );
#?pugs todo
ok("\x[86CA]" ~~ m/^<-:LowercaseLetter>$/, q{Match related inverted <LowercaseLetter>} );
#?pugs todo
ok("\x[86CA]\x[86CA]\c[LATIN SMALL LETTER A]" ~~ m/<:LowercaseLetter>/, q{Match unanchored <LowercaseLetter>} );

# Lt          TitlecaseLetter


#?pugs todo
ok("\c[LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON]" ~~ m/^<:Lt>$/, q{Match <:Lt> (TitlecaseLetter)} );
ok(!( "\c[LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON]" ~~ m/^<:!Lt>$/ ), q{Don't match negated <Lt> (TitlecaseLetter)} );
ok(!( "\c[LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON]" ~~ m/^<-:Lt>$/ ), q{Don't match inverted <Lt> (TitlecaseLetter)} );
ok(!( "\x[6DC8]"  ~~ m/^<:Lt>$/ ), q{Don't match unrelated <Lt> (TitlecaseLetter)} );
#?pugs todo
ok("\x[6DC8]"  ~~ m/^<:!Lt>$/, q{Match unrelated negated <Lt> (TitlecaseLetter)} );
#?pugs todo
ok("\x[6DC8]"  ~~ m/^<-:Lt>$/, q{Match unrelated inverted <Lt> (TitlecaseLetter)} );
ok(!( "\x[6DC8]" ~~ m/^<:Lt>$/ ), q{Don't match related <Lt> (TitlecaseLetter)} );
#?pugs todo
ok("\x[6DC8]" ~~ m/^<:!Lt>$/, q{Match related negated <Lt> (TitlecaseLetter)} );
#?pugs todo
ok("\x[6DC8]" ~~ m/^<-:Lt>$/, q{Match related inverted <Lt> (TitlecaseLetter)} );
#?pugs todo
ok("\x[6DC8]\x[6DC8]\c[LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON]" ~~ m/<:Lt>/, q{Match unanchored <Lt> (TitlecaseLetter)} );

#?pugs todo
ok("\c[GREEK CAPITAL LETTER ALPHA WITH PSILI AND PROSGEGRAMMENI]" ~~ m/^<:TitlecaseLetter>$/, q{Match <:TitlecaseLetter>} );
ok(!( "\c[GREEK CAPITAL LETTER ALPHA WITH PSILI AND PROSGEGRAMMENI]" ~~ m/^<:!TitlecaseLetter>$/ ), q{Don't match negated <TitlecaseLetter>} );
ok(!( "\c[GREEK CAPITAL LETTER ALPHA WITH PSILI AND PROSGEGRAMMENI]" ~~ m/^<-:TitlecaseLetter>$/ ), q{Don't match inverted <TitlecaseLetter>} );
ok(!( "\x[0C4E]"  ~~ m/^<:TitlecaseLetter>$/ ), q{Don't match unrelated <TitlecaseLetter>} );
#?pugs todo
ok("\x[0C4E]"  ~~ m/^<:!TitlecaseLetter>$/, q{Match unrelated negated <TitlecaseLetter>} );
#?pugs todo
ok("\x[0C4E]"  ~~ m/^<-:TitlecaseLetter>$/, q{Match unrelated inverted <TitlecaseLetter>} );
#?pugs todo
ok("\x[0C4E]\c[GREEK CAPITAL LETTER ALPHA WITH PSILI AND PROSGEGRAMMENI]" ~~ m/<:TitlecaseLetter>/, q{Match unanchored <TitlecaseLetter>} );

# Lm          ModifierLetter


#?pugs todo
ok("\c[IDEOGRAPHIC ITERATION MARK]" ~~ m/^<:Lm>$/, q{Match <:Lm> (ModifierLetter)} );
ok(!( "\c[IDEOGRAPHIC ITERATION MARK]" ~~ m/^<:!Lm>$/ ), q{Don't match negated <Lm> (ModifierLetter)} );
ok(!( "\c[IDEOGRAPHIC ITERATION MARK]" ~~ m/^<-:Lm>$/ ), q{Don't match inverted <Lm> (ModifierLetter)} );
ok(!( "\x[2B61]"  ~~ m/^<:Lm>$/ ), q{Don't match unrelated <Lm> (ModifierLetter)} );
#?pugs todo
ok("\x[2B61]"  ~~ m/^<:!Lm>$/, q{Match unrelated negated <Lm> (ModifierLetter)} );
#?pugs todo
ok("\x[2B61]"  ~~ m/^<-:Lm>$/, q{Match unrelated inverted <Lm> (ModifierLetter)} );
ok(!( "\c[IDEOGRAPHIC CLOSING MARK]" ~~ m/^<:Lm>$/ ), q{Don't match related <Lm> (ModifierLetter)} );
#?pugs todo
ok("\c[IDEOGRAPHIC CLOSING MARK]" ~~ m/^<:!Lm>$/, q{Match related negated <Lm> (ModifierLetter)} );
#?pugs todo
ok("\c[IDEOGRAPHIC CLOSING MARK]" ~~ m/^<-:Lm>$/, q{Match related inverted <Lm> (ModifierLetter)} );
#?pugs todo
ok("\x[2B61]\c[IDEOGRAPHIC CLOSING MARK]\c[IDEOGRAPHIC ITERATION MARK]" ~~ m/<:Lm>/, q{Match unanchored <Lm> (ModifierLetter)} );

#?pugs todo
ok("\c[MODIFIER LETTER SMALL H]" ~~ m/^<:ModifierLetter>$/, q{Match <:ModifierLetter>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<:!ModifierLetter>$/ ), q{Don't match negated <ModifierLetter>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<-:ModifierLetter>$/ ), q{Don't match inverted <ModifierLetter>} );
ok(!( "\c[YI SYLLABLE HA]"  ~~ m/^<:ModifierLetter>$/ ), q{Don't match unrelated <ModifierLetter>} );
#?pugs todo
ok("\c[YI SYLLABLE HA]"  ~~ m/^<:!ModifierLetter>$/, q{Match unrelated negated <ModifierLetter>} );
#?pugs todo
ok("\c[YI SYLLABLE HA]"  ~~ m/^<-:ModifierLetter>$/, q{Match unrelated inverted <ModifierLetter>} );
#?pugs todo
ok("\c[YI SYLLABLE HA]\c[MODIFIER LETTER SMALL H]" ~~ m/<:ModifierLetter>/, q{Match unanchored <ModifierLetter>} );

# Lo          OtherLetter


#?pugs todo
ok("\c[LATIN LETTER TWO WITH STROKE]" ~~ m/^<:Lo>$/, q{Match <:Lo> (OtherLetter)} );
ok(!( "\c[LATIN LETTER TWO WITH STROKE]" ~~ m/^<:!Lo>$/ ), q{Don't match negated <Lo> (OtherLetter)} );
ok(!( "\c[LATIN LETTER TWO WITH STROKE]" ~~ m/^<-:Lo>$/ ), q{Don't match inverted <Lo> (OtherLetter)} );
ok(!( "\c[LATIN SMALL LETTER TURNED DELTA]"  ~~ m/^<:Lo>$/ ), q{Don't match unrelated <Lo> (OtherLetter)} );
#?pugs todo
ok("\c[LATIN SMALL LETTER TURNED DELTA]"  ~~ m/^<:!Lo>$/, q{Match unrelated negated <Lo> (OtherLetter)} );
#?pugs todo
ok("\c[LATIN SMALL LETTER TURNED DELTA]"  ~~ m/^<-:Lo>$/, q{Match unrelated inverted <Lo> (OtherLetter)} );
ok(!( "\c[LATIN SMALL LETTER TURNED DELTA]" ~~ m/^<:Lo>$/ ), q{Don't match related <Lo> (OtherLetter)} );
#?pugs todo
ok("\c[LATIN SMALL LETTER TURNED DELTA]" ~~ m/^<:!Lo>$/, q{Match related negated <Lo> (OtherLetter)} );
#?pugs todo
ok("\c[LATIN SMALL LETTER TURNED DELTA]" ~~ m/^<-:Lo>$/, q{Match related inverted <Lo> (OtherLetter)} );
#?pugs todo
ok("\c[LATIN SMALL LETTER TURNED DELTA]\c[LATIN SMALL LETTER TURNED DELTA]\c[LATIN LETTER TWO WITH STROKE]" ~~ m/<:Lo>/, q{Match unanchored <Lo> (OtherLetter)} );

#?pugs todo
ok("\c[ETHIOPIC SYLLABLE GLOTTAL A]" ~~ m/^<:OtherLetter>$/, q{Match <:OtherLetter>} );
ok(!( "\c[ETHIOPIC SYLLABLE GLOTTAL A]" ~~ m/^<:!OtherLetter>$/ ), q{Don't match negated <OtherLetter>} );
ok(!( "\c[ETHIOPIC SYLLABLE GLOTTAL A]" ~~ m/^<-:OtherLetter>$/ ), q{Don't match inverted <OtherLetter>} );
#?rakudo 4 skip '\x[FFFF]'
ok(!( "\x[FFFF]"  ~~ m/^<:OtherLetter>$/ ), q{Don't match unrelated <OtherLetter>} );
#?pugs todo
ok("\x[FFFF]"  ~~ m/^<:!OtherLetter>$/, q{Match unrelated negated <OtherLetter>} );
#?pugs todo
ok("\x[FFFF]"  ~~ m/^<-:OtherLetter>$/, q{Match unrelated inverted <OtherLetter>} );
#?pugs todo
ok("\x[FFFF]\c[ETHIOPIC SYLLABLE GLOTTAL A]" ~~ m/<:OtherLetter>/, q{Match unanchored <OtherLetter>} );

# Lr             # Alias for "Ll", "Lu", and "Lt".


#?rakudo 10 skip "No [Lr] property defined"
#?niecza 10 skip "No [Lr] property defined"
#?pugs todo
ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<:Lr>$/, q{Match (Alias for "Ll", "Lu", and "Lt".)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<:!Lr>$/ ), q{Don't match negated (Alias for "Ll", "Lu", and "Lt".)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-:Lr>$/ ), q{Don't match inverted (Alias for "Ll", "Lu", and "Lt".)} );
ok(!( "\x[87B5]"  ~~ m/^<:Lr>$/ ), q{Don't match unrelated (Alias for "Ll", "Lu", and "Lt".)} );
#?pugs todo
ok("\x[87B5]"  ~~ m/^<:!Lr>$/, q{Match unrelated negated (Alias for "Ll", "Lu", and "Lt".)} );
#?pugs todo
ok("\x[87B5]"  ~~ m/^<-:Lr>$/, q{Match unrelated inverted (Alias for "Ll", "Lu", and "Lt".)} );
ok(!( "\x[87B5]" ~~ m/^<:Lr>$/ ), q{Don't match related (Alias for "Ll", "Lu", and "Lt".)} );
#?pugs todo
ok("\x[87B5]" ~~ m/^<:!Lr>$/, q{Match related negated (Alias for "Ll", "Lu", and "Lt".)} );
#?pugs todo
ok("\x[87B5]" ~~ m/^<-:Lr>$/, q{Match related inverted (Alias for "Ll", "Lu", and "Lt".)} );
#?pugs todo
ok("\x[87B5]\x[87B5]\c[LATIN CAPITAL LETTER A]" ~~ m/<:Lr>/, q{Match unanchored (Alias for "Ll", "Lu", and "Lt".)} );


# M           Mark


#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:M>$/, q{Match <M> (Mark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!M>$/ ), q{Don't match negated <M> (Mark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:M>$/ ), q{Don't match inverted <M> (Mark)} );
ok(!( "\x[D0AA]"  ~~ m/^<:M>$/ ), q{Don't match unrelated <M> (Mark)} );
#?pugs todo
ok("\x[D0AA]"  ~~ m/^<:!M>$/, q{Match unrelated negated <M> (Mark)} );
#?pugs todo
ok("\x[D0AA]"  ~~ m/^<-:M>$/, q{Match unrelated inverted <M> (Mark)} );
#?pugs todo
ok("\x[D0AA]\c[COMBINING GRAVE ACCENT]" ~~ m/<:M>/, q{Match unanchored <M> (Mark)} );

#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Mark>$/, q{Match <:Mark>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!Mark>$/ ), q{Don't match negated <Mark>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Mark>$/ ), q{Don't match inverted <Mark>} );
ok(!( "\x[BE64]"  ~~ m/^<:Mark>$/ ), q{Don't match unrelated <Mark>} );
#?pugs todo
ok("\x[BE64]"  ~~ m/^<:!Mark>$/, q{Match unrelated negated <Mark>} );
#?pugs todo
ok("\x[BE64]"  ~~ m/^<-:Mark>$/, q{Match unrelated inverted <Mark>} );
#?pugs todo
ok("\x[BE64]\c[COMBINING GRAVE ACCENT]" ~~ m/<:Mark>/, q{Match unanchored <Mark>} );

# Mn          NonspacingMark


#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Mn>$/, q{Match <:Mn> (NonspacingMark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!Mn>$/ ), q{Don't match negated <Mn> (NonspacingMark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Mn>$/ ), q{Don't match inverted <Mn> (NonspacingMark)} );
ok(!( "\x[47A5]"  ~~ m/^<:Mn>$/ ), q{Don't match unrelated <Mn> (NonspacingMark)} );
#?pugs todo
ok("\x[47A5]"  ~~ m/^<:!Mn>$/, q{Match unrelated negated <Mn> (NonspacingMark)} );
#?pugs todo
ok("\x[47A5]"  ~~ m/^<-:Mn>$/, q{Match unrelated inverted <Mn> (NonspacingMark)} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<:Mn>$/ ), q{Don't match related <Mn> (NonspacingMark)} );
#?pugs todo
ok("\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<:!Mn>$/, q{Match related negated <Mn> (NonspacingMark)} );
#?pugs todo
ok("\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<-:Mn>$/, q{Match related inverted <Mn> (NonspacingMark)} );
#?pugs todo
ok("\x[47A5]\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]\c[COMBINING GRAVE ACCENT]" ~~ m/<:Mn>/, q{Match unanchored <Mn> (NonspacingMark)} );

#?pugs todo
ok("\c[TAGALOG VOWEL SIGN I]" ~~ m/^<:NonspacingMark>$/, q{Match <:NonspacingMark>} );
ok(!( "\c[TAGALOG VOWEL SIGN I]" ~~ m/^<:!NonspacingMark>$/ ), q{Don't match negated <NonspacingMark>} );
ok(!( "\c[TAGALOG VOWEL SIGN I]" ~~ m/^<-:NonspacingMark>$/ ), q{Don't match inverted <NonspacingMark>} );
ok(!( "\c[CANADIAN SYLLABICS TYA]"  ~~ m/^<:NonspacingMark>$/ ), q{Don't match unrelated <NonspacingMark>} );
#?pugs todo
ok("\c[CANADIAN SYLLABICS TYA]"  ~~ m/^<:!NonspacingMark>$/, q{Match unrelated negated <NonspacingMark>} );
#?pugs todo
ok("\c[CANADIAN SYLLABICS TYA]"  ~~ m/^<-:NonspacingMark>$/, q{Match unrelated inverted <NonspacingMark>} );
#?pugs todo
ok("\c[CANADIAN SYLLABICS TYA]\c[TAGALOG VOWEL SIGN I]" ~~ m/<:NonspacingMark>/, q{Match unanchored <NonspacingMark>} );

# Mc          SpacingMark


#?pugs todo
ok("\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<:Mc>$/, q{Match <:Mc> (SpacingMark)} );
ok(!( "\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<:!Mc>$/ ), q{Don't match negated <Mc> (SpacingMark)} );
ok(!( "\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<-:Mc>$/ ), q{Don't match inverted <Mc> (SpacingMark)} );
ok(!( "\x[9981]"  ~~ m/^<:Mc>$/ ), q{Don't match unrelated <Mc> (SpacingMark)} );
#?pugs todo
ok("\x[9981]"  ~~ m/^<:!Mc>$/, q{Match unrelated negated <Mc> (SpacingMark)} );
#?pugs todo
ok("\x[9981]"  ~~ m/^<-:Mc>$/, q{Match unrelated inverted <Mc> (SpacingMark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Mc>$/ ), q{Don't match related <Mc> (SpacingMark)} );
#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!Mc>$/, q{Match related negated <Mc> (SpacingMark)} );
#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Mc>$/, q{Match related inverted <Mc> (SpacingMark)} );
#?pugs todo
ok("\x[9981]\c[COMBINING GRAVE ACCENT]\c[DEVANAGARI SIGN VISARGA]" ~~ m/<:Mc>/, q{Match unanchored <Mc> (SpacingMark)} );

#?pugs todo
ok("\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<:SpacingMark>$/, q{Match <:SpacingMark>} );
ok(!( "\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<:!SpacingMark>$/ ), q{Don't match negated <SpacingMark>} );
ok(!( "\c[DEVANAGARI SIGN VISARGA]" ~~ m/^<-:SpacingMark>$/ ), q{Don't match inverted <SpacingMark>} );
ok(!( "\x[35E3]"  ~~ m/^<:SpacingMark>$/ ), q{Don't match unrelated <SpacingMark>} );
#?pugs todo
ok("\x[35E3]"  ~~ m/^<:!SpacingMark>$/, q{Match unrelated negated <SpacingMark>} );
#?pugs todo
ok("\x[35E3]"  ~~ m/^<-:SpacingMark>$/, q{Match unrelated inverted <SpacingMark>} );
#?pugs todo
ok("\x[35E3]\c[DEVANAGARI SIGN VISARGA]" ~~ m/<:SpacingMark>/, q{Match unanchored <SpacingMark>} );

# Me          EnclosingMark


#?pugs todo
ok("\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<:Me>$/, q{Match <:Me> (EnclosingMark)} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<:!Me>$/ ), q{Don't match negated <Me> (EnclosingMark)} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<-:Me>$/ ), q{Don't match inverted <Me> (EnclosingMark)} );
ok(!( "\x[9400]"  ~~ m/^<:Me>$/ ), q{Don't match unrelated <Me> (EnclosingMark)} );
#?pugs todo
ok("\x[9400]"  ~~ m/^<:!Me>$/, q{Match unrelated negated <Me> (EnclosingMark)} );
#?pugs todo
ok("\x[9400]"  ~~ m/^<-:Me>$/, q{Match unrelated inverted <Me> (EnclosingMark)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Me>$/ ), q{Don't match related <Me> (EnclosingMark)} );
#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!Me>$/, q{Match related negated <Me> (EnclosingMark)} );
#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Me>$/, q{Match related inverted <Me> (EnclosingMark)} );
#?pugs todo
ok("\x[9400]\c[COMBINING GRAVE ACCENT]\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/<:Me>/, q{Match unanchored <Me> (EnclosingMark)} );

#?pugs todo
ok("\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<:EnclosingMark>$/, q{Match <:EnclosingMark>} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<:!EnclosingMark>$/ ), q{Don't match negated <EnclosingMark>} );
ok(!( "\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/^<-:EnclosingMark>$/ ), q{Don't match inverted <EnclosingMark>} );
ok(!( "\x[7C68]"  ~~ m/^<:EnclosingMark>$/ ), q{Don't match unrelated <EnclosingMark>} );
#?pugs todo
ok("\x[7C68]"  ~~ m/^<:!EnclosingMark>$/, q{Match unrelated negated <EnclosingMark>} );
#?pugs todo
ok("\x[7C68]"  ~~ m/^<-:EnclosingMark>$/, q{Match unrelated inverted <EnclosingMark>} );
#?pugs todo
ok("\x[7C68]\c[COMBINING CYRILLIC HUNDRED THOUSANDS SIGN]" ~~ m/<:EnclosingMark>/, q{Match unanchored <EnclosingMark>} );


# N           Number


#?pugs todo
ok("\c[SUPERSCRIPT ZERO]" ~~ m/^<:N>$/, q{Match <N> (Number)} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<:!N>$/ ), q{Don't match negated <N> (Number)} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<-:N>$/ ), q{Don't match inverted <N> (Number)} );
ok(!( "\c[LATIN LETTER SMALL CAPITAL E]"  ~~ m/^<:N>$/ ), q{Don't match unrelated <N> (Number)} );
#?pugs todo
ok("\c[LATIN LETTER SMALL CAPITAL E]"  ~~ m/^<:!N>$/, q{Match unrelated negated <N> (Number)} );
#?pugs todo
ok("\c[LATIN LETTER SMALL CAPITAL E]"  ~~ m/^<-:N>$/, q{Match unrelated inverted <N> (Number)} );
#?pugs todo
ok("\c[LATIN LETTER SMALL CAPITAL E]\c[SUPERSCRIPT ZERO]" ~~ m/<:N>/, q{Match unanchored <N> (Number)} );

#?pugs todo
ok("\c[DIGIT ZERO]" ~~ m/^<:Number>$/, q{Match <:Number>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:!Number>$/ ), q{Don't match negated <Number>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-:Number>$/ ), q{Don't match inverted <Number>} );
ok(!( "\x[A994]"  ~~ m/^<:Number>$/ ), q{Don't match unrelated <Number>} );
#?pugs todo
ok("\x[A994]"  ~~ m/^<:!Number>$/, q{Match unrelated negated <Number>} );
#?pugs todo
ok("\x[A994]"  ~~ m/^<-:Number>$/, q{Match unrelated inverted <Number>} );
#?pugs todo
ok("\x[A994]\c[DIGIT ZERO]" ~~ m/<:Number>/, q{Match unanchored <Number>} );

# Nd          DecimalNumber


#?pugs todo
ok("\c[DIGIT ZERO]" ~~ m/^<:Nd>$/, q{Match <:Nd> (DecimalNumber)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:!Nd>$/ ), q{Don't match negated <Nd> (DecimalNumber)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-:Nd>$/ ), q{Don't match inverted <Nd> (DecimalNumber)} );
ok(!( "\x[4E2C]"  ~~ m/^<:Nd>$/ ), q{Don't match unrelated <Nd> (DecimalNumber)} );
#?pugs todo
ok("\x[4E2C]"  ~~ m/^<:!Nd>$/, q{Match unrelated negated <Nd> (DecimalNumber)} );
#?pugs todo
ok("\x[4E2C]"  ~~ m/^<-:Nd>$/, q{Match unrelated inverted <Nd> (DecimalNumber)} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<:Nd>$/ ), q{Don't match related <Nd> (DecimalNumber)} );
#?pugs todo
ok("\c[SUPERSCRIPT TWO]" ~~ m/^<:!Nd>$/, q{Match related negated <Nd> (DecimalNumber)} );
#?pugs todo
ok("\c[SUPERSCRIPT TWO]" ~~ m/^<-:Nd>$/, q{Match related inverted <Nd> (DecimalNumber)} );
#?rakudo skip "Malformed UTF-8 string"
#?pugs todo
ok("\x[4E2C]\c[SUPERSCRIPT TWO]\c[DIGIT ZERO]" ~~ m/<:Nd>/, q{Match unanchored <Nd> (DecimalNumber)} );
#?pugs todo
ok("\c[DIGIT ZERO]" ~~ m/^<:DecimalNumber>$/, q{Match <:DecimalNumber>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:!DecimalNumber>$/ ), q{Don't match negated <DecimalNumber>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-:DecimalNumber>$/ ), q{Don't match inverted <DecimalNumber>} );
ok(!( "\x[A652]"  ~~ m/^<:DecimalNumber>$/ ), q{Don't match unrelated <DecimalNumber>} );
#?pugs todo
ok("\x[A652]"  ~~ m/^<:!DecimalNumber>$/, q{Match unrelated negated <DecimalNumber>} );
#?pugs todo
ok("\x[A652]"  ~~ m/^<-:DecimalNumber>$/, q{Match unrelated inverted <DecimalNumber>} );
#?pugs todo
ok("\x[A652]\c[DIGIT ZERO]" ~~ m/<:DecimalNumber>/, q{Match unanchored <DecimalNumber>} );


# Nl          LetterNumber


#?pugs todo
ok("\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<:Nl>$/, q{Match <:Nl> (LetterNumber)} );
ok(!( "\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<:!Nl>$/ ), q{Don't match negated <Nl> (LetterNumber)} );
ok(!( "\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<-:Nl>$/ ), q{Don't match inverted <Nl> (LetterNumber)} );
ok(!( "\x[6C2F]"  ~~ m/^<:Nl>$/ ), q{Don't match unrelated <Nl> (LetterNumber)} );
#?pugs todo
ok("\x[6C2F]"  ~~ m/^<:!Nl>$/, q{Match unrelated negated <Nl> (LetterNumber)} );
#?pugs todo
ok("\x[6C2F]"  ~~ m/^<-:Nl>$/, q{Match unrelated inverted <Nl> (LetterNumber)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:Nl>$/ ), q{Don't match related <Nl> (LetterNumber)} );
#?pugs todo
ok("\c[DIGIT ZERO]" ~~ m/^<:!Nl>$/, q{Match related negated <Nl> (LetterNumber)} );
#?pugs todo
ok("\c[DIGIT ZERO]" ~~ m/^<-:Nl>$/, q{Match related inverted <Nl> (LetterNumber)} );
#?pugs todo
ok("\x[6C2F]\c[DIGIT ZERO]\c[RUNIC ARLAUG SYMBOL]" ~~ m/<:Nl>/, q{Match unanchored <Nl> (LetterNumber)} );

#?pugs todo
ok("\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<:LetterNumber>$/, q{Match <:LetterNumber>} );
ok(!( "\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<:!LetterNumber>$/ ), q{Don't match negated <LetterNumber>} );
ok(!( "\c[RUNIC ARLAUG SYMBOL]" ~~ m/^<-:LetterNumber>$/ ), q{Don't match inverted <LetterNumber>} );
ok(!( "\x[80A5]"  ~~ m/^<:LetterNumber>$/ ), q{Don't match unrelated <LetterNumber>} );
#?pugs todo
ok("\x[80A5]"  ~~ m/^<:!LetterNumber>$/, q{Match unrelated negated <LetterNumber>} );
#?pugs todo
ok("\x[80A5]"  ~~ m/^<-:LetterNumber>$/, q{Match unrelated inverted <LetterNumber>} );
ok(!( "\x[80A5]" ~~ m/^<:LetterNumber>$/ ), q{Don't match related <LetterNumber>} );
#?pugs todo
ok("\x[80A5]" ~~ m/^<:!LetterNumber>$/, q{Match related negated <LetterNumber>} );
#?pugs todo
ok("\x[80A5]" ~~ m/^<-:LetterNumber>$/, q{Match related inverted <LetterNumber>} );
#?pugs todo
ok("\x[80A5]\x[80A5]\c[RUNIC ARLAUG SYMBOL]" ~~ m/<:LetterNumber>/, q{Match unanchored <LetterNumber>} );

# No          OtherNumber


#?pugs todo
ok("\c[SUPERSCRIPT TWO]" ~~ m/^<:No>$/, q{Match <:No> (OtherNumber)} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<:!No>$/ ), q{Don't match negated <No> (OtherNumber)} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<-:No>$/ ), q{Don't match inverted <No> (OtherNumber)} );
ok(!( "\x[92F3]"  ~~ m/^<:No>$/ ), q{Don't match unrelated <No> (OtherNumber)} );
#?pugs todo
ok("\x[92F3]"  ~~ m/^<:!No>$/, q{Match unrelated negated <No> (OtherNumber)} );
#?pugs todo
ok("\x[92F3]"  ~~ m/^<-:No>$/, q{Match unrelated inverted <No> (OtherNumber)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:No>$/ ), q{Don't match related <No> (OtherNumber)} );
#?pugs todo
ok("\c[DIGIT ZERO]" ~~ m/^<:!No>$/, q{Match related negated <No> (OtherNumber)} );
#?pugs todo
ok("\c[DIGIT ZERO]" ~~ m/^<-:No>$/, q{Match related inverted <No> (OtherNumber)} );
#?rakudo skip "Malformed UTF-8 string"
#?pugs todo
ok("\x[92F3]\c[DIGIT ZERO]\c[SUPERSCRIPT TWO]" ~~ m/<:No>/, q{Match unanchored <No> (OtherNumber)} );

#?pugs todo
ok("\c[SUPERSCRIPT TWO]" ~~ m/^<:OtherNumber>$/, q{Match <:OtherNumber>} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<:!OtherNumber>$/ ), q{Don't match negated <OtherNumber>} );
ok(!( "\c[SUPERSCRIPT TWO]" ~~ m/^<-:OtherNumber>$/ ), q{Don't match inverted <OtherNumber>} );
ok(!( "\x[5363]"  ~~ m/^<:OtherNumber>$/ ), q{Don't match unrelated <OtherNumber>} );
#?pugs todo
ok("\x[5363]"  ~~ m/^<:!OtherNumber>$/, q{Match unrelated negated <OtherNumber>} );
#?pugs todo
ok("\x[5363]"  ~~ m/^<-:OtherNumber>$/, q{Match unrelated inverted <OtherNumber>} );
#?rakudo skip "Malformed UTF-8 string"
#?pugs todo
ok("\x[5363]\c[SUPERSCRIPT TWO]" ~~ m/<:OtherNumber>/, q{Match unanchored <OtherNumber>} );

# P           Punctuation


#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<:P>$/, q{Match <P> (Punctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:!P>$/ ), q{Don't match negated <P> (Punctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-:P>$/ ), q{Don't match inverted <P> (Punctuation)} );
ok(!( "\x[A918]"  ~~ m/^<:P>$/ ), q{Don't match unrelated <P> (Punctuation)} );
#?pugs todo
ok("\x[A918]"  ~~ m/^<:!P>$/, q{Match unrelated negated <P> (Punctuation)} );
#?pugs todo
ok("\x[A918]"  ~~ m/^<-:P>$/, q{Match unrelated inverted <P> (Punctuation)} );
#?pugs todo
ok("\x[A918]\c[EXCLAMATION MARK]" ~~ m/<:P>/, q{Match unanchored <P> (Punctuation)} );

#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<:Punctuation>$/, q{Match <:Punctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:!Punctuation>$/ ), q{Don't match negated <Punctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-:Punctuation>$/ ), q{Don't match inverted <Punctuation>} );
ok(!( "\x[CE60]"  ~~ m/^<:Punctuation>$/ ), q{Don't match unrelated <Punctuation>} );
#?pugs todo
ok("\x[CE60]"  ~~ m/^<:!Punctuation>$/, q{Match unrelated negated <Punctuation>} );
#?pugs todo
ok("\x[CE60]"  ~~ m/^<-:Punctuation>$/, q{Match unrelated inverted <Punctuation>} );
#?pugs todo
ok("\x[CE60]\c[EXCLAMATION MARK]" ~~ m/<:Punctuation>/, q{Match unanchored <Punctuation>} );

# Pc          ConnectorPunctuation


#?pugs todo
ok("\c[LOW LINE]" ~~ m/^<:Pc>$/, q{Match <:Pc> (ConnectorPunctuation)} );
ok(!( "\c[LOW LINE]" ~~ m/^<:!Pc>$/ ), q{Don't match negated <Pc> (ConnectorPunctuation)} );
ok(!( "\c[LOW LINE]" ~~ m/^<-:Pc>$/ ), q{Don't match inverted <Pc> (ConnectorPunctuation)} );
ok(!( "\x[5F19]"  ~~ m/^<:Pc>$/ ), q{Don't match unrelated <Pc> (ConnectorPunctuation)} );
#?pugs todo
ok("\x[5F19]"  ~~ m/^<:!Pc>$/, q{Match unrelated negated <Pc> (ConnectorPunctuation)} );
#?pugs todo
ok("\x[5F19]"  ~~ m/^<-:Pc>$/, q{Match unrelated inverted <Pc> (ConnectorPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:Pc>$/ ), q{Don't match related <Pc> (ConnectorPunctuation)} );
#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<:!Pc>$/, q{Match related negated <Pc> (ConnectorPunctuation)} );
#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<-:Pc>$/, q{Match related inverted <Pc> (ConnectorPunctuation)} );
#?pugs todo
ok("\x[5F19]\c[EXCLAMATION MARK]\c[LOW LINE]" ~~ m/<:Pc>/, q{Match unanchored <Pc> (ConnectorPunctuation)} );

#?pugs todo
ok("\c[LOW LINE]" ~~ m/^<:ConnectorPunctuation>$/, q{Match <:ConnectorPunctuation>} );
ok(!( "\c[LOW LINE]" ~~ m/^<:!ConnectorPunctuation>$/ ), q{Don't match negated <ConnectorPunctuation>} );
ok(!( "\c[LOW LINE]" ~~ m/^<-:ConnectorPunctuation>$/ ), q{Don't match inverted <ConnectorPunctuation>} );
ok(!( "\c[YI SYLLABLE MGOX]"  ~~ m/^<:ConnectorPunctuation>$/ ), q{Don't match unrelated <ConnectorPunctuation>} );
#?pugs todo
ok("\c[YI SYLLABLE MGOX]"  ~~ m/^<:!ConnectorPunctuation>$/, q{Match unrelated negated <ConnectorPunctuation>} );
#?pugs todo
ok("\c[YI SYLLABLE MGOX]"  ~~ m/^<-:ConnectorPunctuation>$/, q{Match unrelated inverted <ConnectorPunctuation>} );
#?pugs todo
ok("\c[YI SYLLABLE MGOX]\c[LOW LINE]" ~~ m/<:ConnectorPunctuation>/, q{Match unanchored <ConnectorPunctuation>} );

# Pd          DashPunctuation


#?pugs todo
ok("\c[HYPHEN-MINUS]" ~~ m/^<:Pd>$/, q{Match <:Pd> (DashPunctuation)} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<:!Pd>$/ ), q{Don't match negated <Pd> (DashPunctuation)} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<-:Pd>$/ ), q{Don't match inverted <Pd> (DashPunctuation)} );
ok(!( "\x[49A1]"  ~~ m/^<:Pd>$/ ), q{Don't match unrelated <Pd> (DashPunctuation)} );
#?pugs todo
ok("\x[49A1]"  ~~ m/^<:!Pd>$/, q{Match unrelated negated <Pd> (DashPunctuation)} );
#?pugs todo
ok("\x[49A1]"  ~~ m/^<-:Pd>$/, q{Match unrelated inverted <Pd> (DashPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:Pd>$/ ), q{Don't match related <Pd> (DashPunctuation)} );
#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<:!Pd>$/, q{Match related negated <Pd> (DashPunctuation)} );
#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<-:Pd>$/, q{Match related inverted <Pd> (DashPunctuation)} );
#?pugs todo
ok("\x[49A1]\c[EXCLAMATION MARK]\c[HYPHEN-MINUS]" ~~ m/<:Pd>/, q{Match unanchored <Pd> (DashPunctuation)} );

#?pugs todo
ok("\c[HYPHEN-MINUS]" ~~ m/^<:DashPunctuation>$/, q{Match <:DashPunctuation>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<:!DashPunctuation>$/ ), q{Don't match negated <DashPunctuation>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<-:DashPunctuation>$/ ), q{Don't match inverted <DashPunctuation>} );
ok(!( "\x[3C6E]"  ~~ m/^<:DashPunctuation>$/ ), q{Don't match unrelated <DashPunctuation>} );
#?pugs todo
ok("\x[3C6E]"  ~~ m/^<:!DashPunctuation>$/, q{Match unrelated negated <DashPunctuation>} );
#?pugs todo
ok("\x[3C6E]"  ~~ m/^<-:DashPunctuation>$/, q{Match unrelated inverted <DashPunctuation>} );
#?pugs todo
ok("\x[3C6E]\c[HYPHEN-MINUS]" ~~ m/<:DashPunctuation>/, q{Match unanchored <DashPunctuation>} );

# Ps          OpenPunctuation


#?pugs todo
ok("\c[LEFT PARENTHESIS]" ~~ m/^<:Ps>$/, q{Match <:Ps> (OpenPunctuation)} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<:!Ps>$/ ), q{Don't match negated <Ps> (OpenPunctuation)} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<-:Ps>$/ ), q{Don't match inverted <Ps> (OpenPunctuation)} );
ok(!( "\x[C8A5]"  ~~ m/^<:Ps>$/ ), q{Don't match unrelated <Ps> (OpenPunctuation)} );
#?pugs todo
ok("\x[C8A5]"  ~~ m/^<:!Ps>$/, q{Match unrelated negated <Ps> (OpenPunctuation)} );
#?pugs todo
ok("\x[C8A5]"  ~~ m/^<-:Ps>$/, q{Match unrelated inverted <Ps> (OpenPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:Ps>$/ ), q{Don't match related <Ps> (OpenPunctuation)} );
#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<:!Ps>$/, q{Match related negated <Ps> (OpenPunctuation)} );
#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<-:Ps>$/, q{Match related inverted <Ps> (OpenPunctuation)} );
#?pugs todo
ok("\x[C8A5]\c[EXCLAMATION MARK]\c[LEFT PARENTHESIS]" ~~ m/<:Ps>/, q{Match unanchored <Ps> (OpenPunctuation)} );

#?pugs todo
ok("\c[LEFT PARENTHESIS]" ~~ m/^<:OpenPunctuation>$/, q{Match <:OpenPunctuation>} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<:!OpenPunctuation>$/ ), q{Don't match negated <OpenPunctuation>} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<-:OpenPunctuation>$/ ), q{Don't match inverted <OpenPunctuation>} );
ok(!( "\x[84B8]"  ~~ m/^<:OpenPunctuation>$/ ), q{Don't match unrelated <OpenPunctuation>} );
#?pugs todo
ok("\x[84B8]"  ~~ m/^<:!OpenPunctuation>$/, q{Match unrelated negated <OpenPunctuation>} );
#?pugs todo
ok("\x[84B8]"  ~~ m/^<-:OpenPunctuation>$/, q{Match unrelated inverted <OpenPunctuation>} );
#?pugs todo
ok("\x[84B8]\c[LEFT PARENTHESIS]" ~~ m/<:OpenPunctuation>/, q{Match unanchored <OpenPunctuation>} );

# Pe          ClosePunctuation


#?pugs todo
ok("\c[RIGHT PARENTHESIS]" ~~ m/^<:Pe>$/, q{Match <:Pe> (ClosePunctuation)} );
ok(!( "\c[RIGHT PARENTHESIS]" ~~ m/^<:!Pe>$/ ), q{Don't match negated <Pe> (ClosePunctuation)} );
ok(!( "\c[RIGHT PARENTHESIS]" ~~ m/^<-:Pe>$/ ), q{Don't match inverted <Pe> (ClosePunctuation)} );
ok(!( "\x[BB92]"  ~~ m/^<:Pe>$/ ), q{Don't match unrelated <Pe> (ClosePunctuation)} );
#?pugs todo
ok("\x[BB92]"  ~~ m/^<:!Pe>$/, q{Match unrelated negated <Pe> (ClosePunctuation)} );
#?pugs todo
ok("\x[BB92]"  ~~ m/^<-:Pe>$/, q{Match unrelated inverted <Pe> (ClosePunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:Pe>$/ ), q{Don't match related <Pe> (ClosePunctuation)} );
#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<:!Pe>$/, q{Match related negated <Pe> (ClosePunctuation)} );
#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<-:Pe>$/, q{Match related inverted <Pe> (ClosePunctuation)} );
#?pugs todo
ok("\x[BB92]\c[EXCLAMATION MARK]\c[RIGHT PARENTHESIS]" ~~ m/<:Pe>/, q{Match unanchored <Pe> (ClosePunctuation)} );

#?pugs todo
ok("\c[RIGHT PARENTHESIS]" ~~ m/^<:ClosePunctuation>$/, q{Match <:ClosePunctuation>} );
ok(!( "\c[RIGHT PARENTHESIS]" ~~ m/^<:!ClosePunctuation>$/ ), q{Don't match negated <ClosePunctuation>} );
ok(!( "\c[RIGHT PARENTHESIS]" ~~ m/^<-:ClosePunctuation>$/ ), q{Don't match inverted <ClosePunctuation>} );
ok(!( "\x[D55D]"  ~~ m/^<:ClosePunctuation>$/ ), q{Don't match unrelated <ClosePunctuation>} );
#?pugs todo
ok("\x[D55D]"  ~~ m/^<:!ClosePunctuation>$/, q{Match unrelated negated <ClosePunctuation>} );
#?pugs todo
ok("\x[D55D]"  ~~ m/^<-:ClosePunctuation>$/, q{Match unrelated inverted <ClosePunctuation>} );
#?pugs todo
ok("\x[D55D]\c[RIGHT PARENTHESIS]" ~~ m/<:ClosePunctuation>/, q{Match unanchored <ClosePunctuation>} );

# Pi          InitialPunctuation


#?pugs todo
ok("\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<:Pi>$/, q{Match <:Pi> (InitialPunctuation)} );
ok(!( "\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<:!Pi>$/ ), q{Don't match negated <Pi> (InitialPunctuation)} );
ok(!( "\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<-:Pi>$/ ), q{Don't match inverted <Pi> (InitialPunctuation)} );
ok(!( "\x[3A35]"  ~~ m/^<:Pi>$/ ), q{Don't match unrelated <Pi> (InitialPunctuation)} );
#?pugs todo
ok("\x[3A35]"  ~~ m/^<:!Pi>$/, q{Match unrelated negated <Pi> (InitialPunctuation)} );
#?pugs todo
ok("\x[3A35]"  ~~ m/^<-:Pi>$/, q{Match unrelated inverted <Pi> (InitialPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:Pi>$/ ), q{Don't match related <Pi> (InitialPunctuation)} );
#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<:!Pi>$/, q{Match related negated <Pi> (InitialPunctuation)} );
#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<-:Pi>$/, q{Match related inverted <Pi> (InitialPunctuation)} );
#?rakudo skip "Malformed UTF-8 string"
#?pugs todo
ok("\x[3A35]\c[EXCLAMATION MARK]\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/<:Pi>/, q{Match unanchored <Pi> (InitialPunctuation)} );

#?pugs todo
ok("\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<:InitialPunctuation>$/, q{Match <:InitialPunctuation>} );
ok(!( "\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<:!InitialPunctuation>$/ ), q{Don't match negated <InitialPunctuation>} );
ok(!( "\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<-:InitialPunctuation>$/ ), q{Don't match inverted <InitialPunctuation>} );
ok(!( "\x[B84F]"  ~~ m/^<:InitialPunctuation>$/ ), q{Don't match unrelated <InitialPunctuation>} );
#?pugs todo
ok("\x[B84F]"  ~~ m/^<:!InitialPunctuation>$/, q{Match unrelated negated <InitialPunctuation>} );
#?pugs todo
ok("\x[B84F]"  ~~ m/^<-:InitialPunctuation>$/, q{Match unrelated inverted <InitialPunctuation>} );
#?rakudo skip "Malformed UTF-8 string"
#?pugs todo
ok("\x[B84F]\c[LEFT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/<:InitialPunctuation>/, q{Match unanchored <InitialPunctuation>} );

# Pf          FinalPunctuation


#?pugs todo
ok("\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<:Pf>$/, q{Match <:Pf> (FinalPunctuation)} );
ok(!( "\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<:!Pf>$/ ), q{Don't match negated <Pf> (FinalPunctuation)} );
ok(!( "\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<-:Pf>$/ ), q{Don't match inverted <Pf> (FinalPunctuation)} );
ok(!( "\x[27CF]"  ~~ m/^<:Pf>$/ ), q{Don't match unrelated <Pf> (FinalPunctuation)} );
#?pugs todo
ok("\x[27CF]"  ~~ m/^<:!Pf>$/, q{Match unrelated negated <Pf> (FinalPunctuation)} );
#?pugs todo
ok("\x[27CF]"  ~~ m/^<-:Pf>$/, q{Match unrelated inverted <Pf> (FinalPunctuation)} );
ok(!( "\c[MATHEMATICAL LEFT WHITE SQUARE BRACKET]" ~~ m/^<:Pf>$/ ), q{Don't match related <Pf> (FinalPunctuation)} );
#?pugs todo
ok("\c[MATHEMATICAL LEFT WHITE SQUARE BRACKET]" ~~ m/^<:!Pf>$/, q{Match related negated <Pf> (FinalPunctuation)} );
#?pugs todo
ok("\c[MATHEMATICAL LEFT WHITE SQUARE BRACKET]" ~~ m/^<-:Pf>$/, q{Match related inverted <Pf> (FinalPunctuation)} );
#?rakudo skip "Malformed UTF-8 string"
#?pugs todo
ok("\x[27CF]\c[MATHEMATICAL LEFT WHITE SQUARE BRACKET]\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/<:Pf>/, q{Match unanchored <Pf> (FinalPunctuation)} );

#?pugs todo
ok("\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<:FinalPunctuation>$/, q{Match <:FinalPunctuation>} );
ok(!( "\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<:!FinalPunctuation>$/ ), q{Don't match negated <FinalPunctuation>} );
ok(!( "\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/^<-:FinalPunctuation>$/ ), q{Don't match inverted <FinalPunctuation>} );
ok(!( "\x[4F65]"  ~~ m/^<:FinalPunctuation>$/ ), q{Don't match unrelated <FinalPunctuation>} );
#?pugs todo
ok("\x[4F65]"  ~~ m/^<:!FinalPunctuation>$/, q{Match unrelated negated <FinalPunctuation>} );
#?pugs todo
ok("\x[4F65]"  ~~ m/^<-:FinalPunctuation>$/, q{Match unrelated inverted <FinalPunctuation>} );
#?rakudo skip "Malformed UTF-8 string"
#?pugs todo
ok("\x[4F65]\c[RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK]" ~~ m/<:FinalPunctuation>/, q{Match unanchored <FinalPunctuation>} );

# Po          OtherPunctuation


#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<:Po>$/, q{Match <:Po> (OtherPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:!Po>$/ ), q{Don't match negated <Po> (OtherPunctuation)} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-:Po>$/ ), q{Don't match inverted <Po> (OtherPunctuation)} );
ok(!( "\x[AA74]"  ~~ m/^<:Po>$/ ), q{Don't match unrelated <Po> (OtherPunctuation)} );
#?pugs todo
ok("\x[AA74]"  ~~ m/^<:!Po>$/, q{Match unrelated negated <Po> (OtherPunctuation)} );
#?pugs todo
ok("\x[AA74]"  ~~ m/^<-:Po>$/, q{Match unrelated inverted <Po> (OtherPunctuation)} );
ok(!( "\c[LEFT PARENTHESIS]" ~~ m/^<:Po>$/ ), q{Don't match related <Po> (OtherPunctuation)} );
#?pugs todo
ok("\c[LEFT PARENTHESIS]" ~~ m/^<:!Po>$/, q{Match related negated <Po> (OtherPunctuation)} );
#?pugs todo
ok("\c[LEFT PARENTHESIS]" ~~ m/^<-:Po>$/, q{Match related inverted <Po> (OtherPunctuation)} );
#?pugs todo
ok("\x[AA74]\c[LEFT PARENTHESIS]\c[EXCLAMATION MARK]" ~~ m/<:Po>/, q{Match unanchored <Po> (OtherPunctuation)} );

#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<:OtherPunctuation>$/, q{Match <:OtherPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:!OtherPunctuation>$/ ), q{Don't match negated <OtherPunctuation>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-:OtherPunctuation>$/ ), q{Don't match inverted <OtherPunctuation>} );
ok(!( "\x[7DD2]"  ~~ m/^<:OtherPunctuation>$/ ), q{Don't match unrelated <OtherPunctuation>} );
#?pugs todo
ok("\x[7DD2]"  ~~ m/^<:!OtherPunctuation>$/, q{Match unrelated negated <OtherPunctuation>} );
#?pugs todo
ok("\x[7DD2]"  ~~ m/^<-:OtherPunctuation>$/, q{Match unrelated inverted <OtherPunctuation>} );
#?pugs todo
ok("\x[7DD2]\c[EXCLAMATION MARK]" ~~ m/<:OtherPunctuation>/, q{Match unanchored <OtherPunctuation>} );

# S           Symbol


#?pugs todo
ok("\c[YI RADICAL QOT]" ~~ m/^<:S>$/, q{Match <S> (Symbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:!S>$/ ), q{Don't match negated <S> (Symbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-:S>$/ ), q{Don't match inverted <S> (Symbol)} );
ok(!( "\x[8839]"  ~~ m/^<:S>$/ ), q{Don't match unrelated <S> (Symbol)} );
#?pugs todo
ok("\x[8839]"  ~~ m/^<:!S>$/, q{Match unrelated negated <S> (Symbol)} );
#?pugs todo
ok("\x[8839]"  ~~ m/^<-:S>$/, q{Match unrelated inverted <S> (Symbol)} );
#?pugs todo
ok("\x[8839]\c[YI RADICAL QOT]" ~~ m/<:S>/, q{Match unanchored <S> (Symbol)} );

#?pugs todo
ok("\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<:Symbol>$/, q{Match <:Symbol>} );
ok(!( "\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<:!Symbol>$/ ), q{Don't match negated <Symbol>} );
ok(!( "\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<-:Symbol>$/ ), q{Don't match inverted <Symbol>} );
ok(!( "\x[4A1C]"  ~~ m/^<:Symbol>$/ ), q{Don't match unrelated <Symbol>} );
#?pugs todo
ok("\x[4A1C]"  ~~ m/^<:!Symbol>$/, q{Match unrelated negated <Symbol>} );
#?pugs todo
ok("\x[4A1C]"  ~~ m/^<-:Symbol>$/, q{Match unrelated inverted <Symbol>} );
#?pugs todo
ok("\x[4A1C]\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/<:Symbol>/, q{Match unanchored <Symbol>} );

# Sm          MathSymbol


#?pugs todo
ok("\c[PLUS SIGN]" ~~ m/^<:Sm>$/, q{Match <:Sm> (MathSymbol)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<:!Sm>$/ ), q{Don't match negated <Sm> (MathSymbol)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<-:Sm>$/ ), q{Don't match inverted <Sm> (MathSymbol)} );
ok(!( "\x[B258]"  ~~ m/^<:Sm>$/ ), q{Don't match unrelated <Sm> (MathSymbol)} );
#?pugs todo
ok("\x[B258]"  ~~ m/^<:!Sm>$/, q{Match unrelated negated <Sm> (MathSymbol)} );
#?pugs todo
ok("\x[B258]"  ~~ m/^<-:Sm>$/, q{Match unrelated inverted <Sm> (MathSymbol)} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<:Sm>$/ ), q{Don't match related <Sm> (MathSymbol)} );
#?pugs todo
ok("\c[DOLLAR SIGN]" ~~ m/^<:!Sm>$/, q{Match related negated <Sm> (MathSymbol)} );
#?pugs todo
ok("\c[DOLLAR SIGN]" ~~ m/^<-:Sm>$/, q{Match related inverted <Sm> (MathSymbol)} );
#?pugs todo
ok("\x[B258]\c[DOLLAR SIGN]\c[PLUS SIGN]" ~~ m/<:Sm>/, q{Match unanchored <Sm> (MathSymbol)} );

#?pugs todo
ok("\c[PLUS SIGN]" ~~ m/^<:MathSymbol>$/, q{Match <:MathSymbol>} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<:!MathSymbol>$/ ), q{Don't match negated <MathSymbol>} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<-:MathSymbol>$/ ), q{Don't match inverted <MathSymbol>} );
ok(!( "\x[98FF]"  ~~ m/^<:MathSymbol>$/ ), q{Don't match unrelated <MathSymbol>} );
#?pugs todo
ok("\x[98FF]"  ~~ m/^<:!MathSymbol>$/, q{Match unrelated negated <MathSymbol>} );
#?pugs todo
ok("\x[98FF]"  ~~ m/^<-:MathSymbol>$/, q{Match unrelated inverted <MathSymbol>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:MathSymbol>$/ ), q{Don't match related <MathSymbol>} );
#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!MathSymbol>$/, q{Match related negated <MathSymbol>} );
#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:MathSymbol>$/, q{Match related inverted <MathSymbol>} );
#?pugs todo
ok("\x[98FF]\c[COMBINING GRAVE ACCENT]\c[PLUS SIGN]" ~~ m/<:MathSymbol>/, q{Match unanchored <MathSymbol>} );

# Sc          CurrencySymbol

#?pugs todo
ok("\c[DOLLAR SIGN]" ~~ m/^<:Sc>$/, q{Match <:Sc> (CurrencySymbol)} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<:!Sc>$/ ), q{Don't match negated <Sc> (CurrencySymbol)} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<-:Sc>$/ ), q{Don't match inverted <Sc> (CurrencySymbol)} );
ok(!( "\x[994C]"  ~~ m/^<:Sc>$/ ), q{Don't match unrelated <Sc> (CurrencySymbol)} );
#?pugs todo
ok("\x[994C]"  ~~ m/^<:!Sc>$/, q{Match unrelated negated <Sc> (CurrencySymbol)} );
#?pugs todo
ok("\x[994C]"  ~~ m/^<-:Sc>$/, q{Match unrelated inverted <Sc> (CurrencySymbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:Sc>$/ ), q{Don't match related <Sc> (CurrencySymbol)} );
#?pugs todo
ok("\c[YI RADICAL QOT]" ~~ m/^<:!Sc>$/, q{Match related negated <Sc> (CurrencySymbol)} );
#?pugs todo
ok("\c[YI RADICAL QOT]" ~~ m/^<-:Sc>$/, q{Match related inverted <Sc> (CurrencySymbol)} );
#?pugs todo
ok("\x[994C]\c[YI RADICAL QOT]\c[DOLLAR SIGN]" ~~ m/<:Sc>/, q{Match unanchored <Sc> (CurrencySymbol)} );

#?pugs todo
ok("\c[DOLLAR SIGN]" ~~ m/^<:CurrencySymbol>$/, q{Match <:CurrencySymbol>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<:!CurrencySymbol>$/ ), q{Don't match negated <CurrencySymbol>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<-:CurrencySymbol>$/ ), q{Don't match inverted <CurrencySymbol>} );
ok(!( "\x[37C0]"  ~~ m/^<:CurrencySymbol>$/ ), q{Don't match unrelated <CurrencySymbol>} );
#?pugs todo
ok("\x[37C0]"  ~~ m/^<:!CurrencySymbol>$/, q{Match unrelated negated <CurrencySymbol>} );
#?pugs todo
ok("\x[37C0]"  ~~ m/^<-:CurrencySymbol>$/, q{Match unrelated inverted <CurrencySymbol>} );
#?pugs todo
ok("\x[37C0]\c[DOLLAR SIGN]" ~~ m/<:CurrencySymbol>/, q{Match unanchored <CurrencySymbol>} );

# Sk          ModifierSymbol


#?pugs todo
ok("\c[CIRCUMFLEX ACCENT]" ~~ m/^<:Sk>$/, q{Match <:Sk> (ModifierSymbol)} );
ok(!( "\c[CIRCUMFLEX ACCENT]" ~~ m/^<:!Sk>$/ ), q{Don't match negated <Sk> (ModifierSymbol)} );
ok(!( "\c[CIRCUMFLEX ACCENT]" ~~ m/^<-:Sk>$/ ), q{Don't match inverted <Sk> (ModifierSymbol)} );
ok(!( "\x[4578]"  ~~ m/^<:Sk>$/ ), q{Don't match unrelated <Sk> (ModifierSymbol)} );
#?pugs todo
ok("\x[4578]"  ~~ m/^<:!Sk>$/, q{Match unrelated negated <Sk> (ModifierSymbol)} );
#?pugs todo
ok("\x[4578]"  ~~ m/^<-:Sk>$/, q{Match unrelated inverted <Sk> (ModifierSymbol)} );
ok(!( "\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<:Sk>$/ ), q{Don't match related <Sk> (ModifierSymbol)} );
#?pugs todo
ok("\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<:!Sk>$/, q{Match related negated <Sk> (ModifierSymbol)} );
#?pugs todo
ok("\c[HEXAGRAM FOR THE CREATIVE HEAVEN]" ~~ m/^<-:Sk>$/, q{Match related inverted <Sk> (ModifierSymbol)} );
#?pugs todo
ok("\x[4578]\c[HEXAGRAM FOR THE CREATIVE HEAVEN]\c[CIRCUMFLEX ACCENT]" ~~ m/<:Sk>/, q{Match unanchored <Sk> (ModifierSymbol)} );

#?pugs todo
ok("\c[CIRCUMFLEX ACCENT]" ~~ m/^<:ModifierSymbol>$/, q{Match <:ModifierSymbol>} );
ok(!( "\c[CIRCUMFLEX ACCENT]" ~~ m/^<:!ModifierSymbol>$/ ), q{Don't match negated <ModifierSymbol>} );
ok(!( "\c[CIRCUMFLEX ACCENT]" ~~ m/^<-:ModifierSymbol>$/ ), q{Don't match inverted <ModifierSymbol>} );
ok(!( "\x[42F1]"  ~~ m/^<:ModifierSymbol>$/ ), q{Don't match unrelated <ModifierSymbol>} );
#?pugs todo
ok("\x[42F1]"  ~~ m/^<:!ModifierSymbol>$/, q{Match unrelated negated <ModifierSymbol>} );
#?pugs todo
ok("\x[42F1]"  ~~ m/^<-:ModifierSymbol>$/, q{Match unrelated inverted <ModifierSymbol>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:ModifierSymbol>$/ ), q{Don't match related <ModifierSymbol>} );
#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!ModifierSymbol>$/, q{Match related negated <ModifierSymbol>} );
#?pugs todo
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:ModifierSymbol>$/, q{Match related inverted <ModifierSymbol>} );
#?pugs todo
ok("\x[42F1]\c[COMBINING GRAVE ACCENT]\c[CIRCUMFLEX ACCENT]" ~~ m/<:ModifierSymbol>/, q{Match unanchored <ModifierSymbol>} );

# So          OtherSymbol


#?pugs todo
ok("\c[YI RADICAL QOT]" ~~ m/^<:So>$/, q{Match <:So> (OtherSymbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:!So>$/ ), q{Don't match negated <So> (OtherSymbol)} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-:So>$/ ), q{Don't match inverted <So> (OtherSymbol)} );
ok(!( "\x[83DE]"  ~~ m/^<:So>$/ ), q{Don't match unrelated <So> (OtherSymbol)} );
#?pugs todo
ok("\x[83DE]"  ~~ m/^<:!So>$/, q{Match unrelated negated <So> (OtherSymbol)} );
#?pugs todo
ok("\x[83DE]"  ~~ m/^<-:So>$/, q{Match unrelated inverted <So> (OtherSymbol)} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<:So>$/ ), q{Don't match related <So> (OtherSymbol)} );
#?pugs todo
ok("\c[DOLLAR SIGN]" ~~ m/^<:!So>$/, q{Match related negated <So> (OtherSymbol)} );
#?pugs todo
ok("\c[DOLLAR SIGN]" ~~ m/^<-:So>$/, q{Match related inverted <So> (OtherSymbol)} );
#?pugs todo
ok("\x[83DE]\c[DOLLAR SIGN]\c[YI RADICAL QOT]" ~~ m/<:So>/, q{Match unanchored <So> (OtherSymbol)} );

#?pugs todo
ok("\c[YI RADICAL QOT]" ~~ m/^<:OtherSymbol>$/, q{Match <:OtherSymbol>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:!OtherSymbol>$/ ), q{Don't match negated <OtherSymbol>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-:OtherSymbol>$/ ), q{Don't match inverted <OtherSymbol>} );
ok(!( "\x[9B2C]"  ~~ m/^<:OtherSymbol>$/ ), q{Don't match unrelated <OtherSymbol>} );
#?pugs todo
ok("\x[9B2C]"  ~~ m/^<:!OtherSymbol>$/, q{Match unrelated negated <OtherSymbol>} );
#?pugs todo
ok("\x[9B2C]"  ~~ m/^<-:OtherSymbol>$/, q{Match unrelated inverted <OtherSymbol>} );
#?pugs todo
ok("\x[9B2C]\c[YI RADICAL QOT]" ~~ m/<:OtherSymbol>/, q{Match unanchored <OtherSymbol>} );

# Z           Separator


#?pugs todo
ok("\c[IDEOGRAPHIC SPACE]" ~~ m/^<:Z>$/, q{Match <Z> (Separator)} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<:!Z>$/ ), q{Don't match negated <Z> (Separator)} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<-:Z>$/ ), q{Don't match inverted <Z> (Separator)} );
ok(!( "\x[2C08]"  ~~ m/^<:Z>$/ ), q{Don't match unrelated <Z> (Separator)} );
#?pugs todo
ok("\x[2C08]"  ~~ m/^<:!Z>$/, q{Match unrelated negated <Z> (Separator)} );
#?pugs todo
ok("\x[2C08]"  ~~ m/^<-:Z>$/, q{Match unrelated inverted <Z> (Separator)} );
#?pugs todo
ok("\x[2C08]\c[IDEOGRAPHIC SPACE]" ~~ m/<:Z>/, q{Match unanchored <Z> (Separator)} );

#?pugs todo
ok("\c[SPACE]" ~~ m/^<:Separator>$/, q{Match <:Separator>} );
ok(!( "\c[SPACE]" ~~ m/^<:!Separator>$/ ), q{Don't match negated <Separator>} );
ok(!( "\c[SPACE]" ~~ m/^<-:Separator>$/ ), q{Don't match inverted <Separator>} );
ok(!( "\c[YI SYLLABLE SOX]"  ~~ m/^<:Separator>$/ ), q{Don't match unrelated <Separator>} );
#?pugs todo
ok("\c[YI SYLLABLE SOX]"  ~~ m/^<:!Separator>$/, q{Match unrelated negated <Separator>} );
#?pugs todo
ok("\c[YI SYLLABLE SOX]"  ~~ m/^<-:Separator>$/, q{Match unrelated inverted <Separator>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:Separator>$/ ), q{Don't match related <Separator>} );
#?pugs todo
ok("\c[YI RADICAL QOT]" ~~ m/^<:!Separator>$/, q{Match related negated <Separator>} );
#?pugs todo
ok("\c[YI RADICAL QOT]" ~~ m/^<-:Separator>$/, q{Match related inverted <Separator>} );
#?pugs todo
ok("\c[YI SYLLABLE SOX]\c[YI RADICAL QOT]\c[SPACE]" ~~ m/<:Separator>/, q{Match unanchored <Separator>} );

# Zs          SpaceSeparator


#?pugs todo
ok("\c[SPACE]" ~~ m/^<:Zs>$/, q{Match <:Zs> (SpaceSeparator)} );
ok(!( "\c[SPACE]" ~~ m/^<:!Zs>$/ ), q{Don't match negated <Zs> (SpaceSeparator)} );
ok(!( "\c[SPACE]" ~~ m/^<-:Zs>$/ ), q{Don't match inverted <Zs> (SpaceSeparator)} );
ok(!( "\x[88DD]"  ~~ m/^<:Zs>$/ ), q{Don't match unrelated <Zs> (SpaceSeparator)} );
#?pugs todo
ok("\x[88DD]"  ~~ m/^<:!Zs>$/, q{Match unrelated negated <Zs> (SpaceSeparator)} );
#?pugs todo
ok("\x[88DD]"  ~~ m/^<-:Zs>$/, q{Match unrelated inverted <Zs> (SpaceSeparator)} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<:Zs>$/ ), q{Don't match related <Zs> (SpaceSeparator)} );
#?pugs todo
ok("\c[LINE SEPARATOR]" ~~ m/^<:!Zs>$/, q{Match related negated <Zs> (SpaceSeparator)} );
#?pugs todo
ok("\c[LINE SEPARATOR]" ~~ m/^<-:Zs>$/, q{Match related inverted <Zs> (SpaceSeparator)} );
#?pugs todo
ok("\x[88DD]\c[LINE SEPARATOR]\c[SPACE]" ~~ m/<:Zs>/, q{Match unanchored <Zs> (SpaceSeparator)} );

#?pugs todo
ok("\c[SPACE]" ~~ m/^<:SpaceSeparator>$/, q{Match <:SpaceSeparator>} );
ok(!( "\c[SPACE]" ~~ m/^<:!SpaceSeparator>$/ ), q{Don't match negated <SpaceSeparator>} );
ok(!( "\c[SPACE]" ~~ m/^<-:SpaceSeparator>$/ ), q{Don't match inverted <SpaceSeparator>} );
ok(!( "\x[C808]"  ~~ m/^<:SpaceSeparator>$/ ), q{Don't match unrelated <SpaceSeparator>} );
#?pugs todo
ok("\x[C808]"  ~~ m/^<:!SpaceSeparator>$/, q{Match unrelated negated <SpaceSeparator>} );
#?pugs todo
ok("\x[C808]"  ~~ m/^<-:SpaceSeparator>$/, q{Match unrelated inverted <SpaceSeparator>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<:SpaceSeparator>$/ ), q{Don't match related <SpaceSeparator>} );
#?pugs todo
ok("\c[DOLLAR SIGN]" ~~ m/^<:!SpaceSeparator>$/, q{Match related negated <SpaceSeparator>} );
#?pugs todo
ok("\c[DOLLAR SIGN]" ~~ m/^<-:SpaceSeparator>$/, q{Match related inverted <SpaceSeparator>} );
#?pugs todo
ok("\x[C808]\c[DOLLAR SIGN]\c[SPACE]" ~~ m/<:SpaceSeparator>/, q{Match unanchored <SpaceSeparator>} );

# Zl          LineSeparator


#?pugs todo
ok("\c[LINE SEPARATOR]" ~~ m/^<:Zl>$/, q{Match <:Zl> (LineSeparator)} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<:!Zl>$/ ), q{Don't match negated <Zl> (LineSeparator)} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<-:Zl>$/ ), q{Don't match inverted <Zl> (LineSeparator)} );
ok(!( "\x[B822]"  ~~ m/^<:Zl>$/ ), q{Don't match unrelated <Zl> (LineSeparator)} );
#?pugs todo
ok("\x[B822]"  ~~ m/^<:!Zl>$/, q{Match unrelated negated <Zl> (LineSeparator)} );
#?pugs todo
ok("\x[B822]"  ~~ m/^<-:Zl>$/, q{Match unrelated inverted <Zl> (LineSeparator)} );
ok(!( "\c[SPACE]" ~~ m/^<:Zl>$/ ), q{Don't match related <Zl> (LineSeparator)} );
#?pugs todo
ok("\c[SPACE]" ~~ m/^<:!Zl>$/, q{Match related negated <Zl> (LineSeparator)} );
#?pugs todo
ok("\c[SPACE]" ~~ m/^<-:Zl>$/, q{Match related inverted <Zl> (LineSeparator)} );
#?pugs todo
ok("\x[B822]\c[SPACE]\c[LINE SEPARATOR]" ~~ m/<:Zl>/, q{Match unanchored <Zl> (LineSeparator)} );

#?pugs todo
ok("\c[LINE SEPARATOR]" ~~ m/^<:LineSeparator>$/, q{Match <:LineSeparator>} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<:!LineSeparator>$/ ), q{Don't match negated <LineSeparator>} );
ok(!( "\c[LINE SEPARATOR]" ~~ m/^<-:LineSeparator>$/ ), q{Don't match inverted <LineSeparator>} );
ok(!( "\x[1390]"  ~~ m/^<:LineSeparator>$/ ), q{Don't match unrelated <LineSeparator>} );
#?pugs todo
ok("\x[1390]"  ~~ m/^<:!LineSeparator>$/, q{Match unrelated negated <LineSeparator>} );
#?pugs todo
ok("\x[1390]"  ~~ m/^<-:LineSeparator>$/, q{Match unrelated inverted <LineSeparator>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<:LineSeparator>$/ ), q{Don't match related <LineSeparator>} );
#?pugs todo
ok("\c[CHEROKEE LETTER A]" ~~ m/^<:!LineSeparator>$/, q{Match related negated <LineSeparator>} );
#?pugs todo
ok("\c[CHEROKEE LETTER A]" ~~ m/^<-:LineSeparator>$/, q{Match related inverted <LineSeparator>} );
#?pugs todo
ok("\x[1390]\c[CHEROKEE LETTER A]\c[LINE SEPARATOR]" ~~ m/<:LineSeparator>/, q{Match unanchored <LineSeparator>} );

# Zp          ParagraphSeparator


#?pugs todo
ok("\c[PARAGRAPH SEPARATOR]" ~~ m/^<:Zp>$/, q{Match <:Zp> (ParagraphSeparator)} );
ok(!( "\c[PARAGRAPH SEPARATOR]" ~~ m/^<:!Zp>$/ ), q{Don't match negated <Zp> (ParagraphSeparator)} );
ok(!( "\c[PARAGRAPH SEPARATOR]" ~~ m/^<-:Zp>$/ ), q{Don't match inverted <Zp> (ParagraphSeparator)} );
ok(!( "\x[5FDE]"  ~~ m/^<:Zp>$/ ), q{Don't match unrelated <Zp> (ParagraphSeparator)} );
#?pugs todo
ok("\x[5FDE]"  ~~ m/^<:!Zp>$/, q{Match unrelated negated <Zp> (ParagraphSeparator)} );
#?pugs todo
ok("\x[5FDE]"  ~~ m/^<-:Zp>$/, q{Match unrelated inverted <Zp> (ParagraphSeparator)} );
ok(!( "\c[SPACE]" ~~ m/^<:Zp>$/ ), q{Don't match related <Zp> (ParagraphSeparator)} );
#?pugs todo
ok("\c[SPACE]" ~~ m/^<:!Zp>$/, q{Match related negated <Zp> (ParagraphSeparator)} );
#?pugs todo
ok("\c[SPACE]" ~~ m/^<-:Zp>$/, q{Match related inverted <Zp> (ParagraphSeparator)} );
#?pugs todo
ok("\x[5FDE]\c[SPACE]\c[PARAGRAPH SEPARATOR]" ~~ m/<:Zp>/, q{Match unanchored <Zp> (ParagraphSeparator)} );

#?pugs todo
ok("\c[PARAGRAPH SEPARATOR]" ~~ m/^<:ParagraphSeparator>$/, q{Match <:ParagraphSeparator>} );
ok(!( "\c[PARAGRAPH SEPARATOR]" ~~ m/^<:!ParagraphSeparator>$/ ), q{Don't match negated <ParagraphSeparator>} );
ok(!( "\c[PARAGRAPH SEPARATOR]" ~~ m/^<-:ParagraphSeparator>$/ ), q{Don't match inverted <ParagraphSeparator>} );
ok(!( "\x[345B]"  ~~ m/^<:ParagraphSeparator>$/ ), q{Don't match unrelated <ParagraphSeparator>} );
#?pugs todo
ok("\x[345B]"  ~~ m/^<:!ParagraphSeparator>$/, q{Match unrelated negated <ParagraphSeparator>} );
#?pugs todo
ok("\x[345B]"  ~~ m/^<-:ParagraphSeparator>$/, q{Match unrelated inverted <ParagraphSeparator>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:ParagraphSeparator>$/ ), q{Don't match related <ParagraphSeparator>} );
#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<:!ParagraphSeparator>$/, q{Match related negated <ParagraphSeparator>} );
#?pugs todo
ok("\c[EXCLAMATION MARK]" ~~ m/^<-:ParagraphSeparator>$/, q{Match related inverted <ParagraphSeparator>} );
#?pugs todo
ok("\x[345B]\c[EXCLAMATION MARK]\c[PARAGRAPH SEPARATOR]" ~~ m/<:ParagraphSeparator>/, q{Match unanchored <ParagraphSeparator>} );

# C           Other


#?rakudo 3 skip "Uninvestigated nqp-rx regression"
#?pugs todo
ok("\x[FFFE]" ~~ m/^<:C>$/, q{Match <C> (Other)} );
ok(!( "\x[FFFE]" ~~ m/^<:!C>$/ ), q{Don't match negated <C> (Other)} );
ok(!( "\x[FFFE]" ~~ m/^<-:C>$/ ), q{Don't match inverted <C> (Other)} );
ok(!( "\x[6A3F]"  ~~ m/^<:C>$/ ), q{Don't match unrelated <C> (Other)} );
#?pugs todo
ok("\x[6A3F]"  ~~ m/^<:!C>$/, q{Match unrelated negated <C> (Other)} );
#?pugs todo
ok("\x[6A3F]"  ~~ m/^<-:C>$/, q{Match unrelated inverted <C> (Other)} );
#?rakudo skip "Uninvestigated nqp-rx regression"
#?pugs todo
ok("\x[6A3F]\x[FFFE]" ~~ m/<:C>/, q{Match unanchored <C> (Other)} );

#?pugs todo
ok("\x[A679]" ~~ m/^<:Other>$/, q{Match <:Other>} );
ok(!( "\x[A679]" ~~ m/^<:!Other>$/ ), q{Don't match negated <Other>} );
ok(!( "\x[A679]" ~~ m/^<-:Other>$/ ), q{Don't match inverted <Other>} );
ok(!( "\x[AC00]"  ~~ m/^<:Other>$/ ), q{Don't match unrelated <Other>} );
#?pugs todo
ok("\x[AC00]"  ~~ m/^<:!Other>$/, q{Match unrelated negated <Other>} );
#?pugs todo
ok("\x[AC00]"  ~~ m/^<-:Other>$/, q{Match unrelated inverted <Other>} );
#?pugs todo
ok("\x[AC00]\x[A679]" ~~ m/<:Other>/, q{Match unanchored <Other>} );

# Cc          Control


#?pugs todo
ok("\c[NULL]" ~~ m/^<:Cc>$/, q{Match <:Cc> (Control)} );
ok(!( "\c[NULL]" ~~ m/^<:!Cc>$/ ), q{Don't match negated <Cc> (Control)} );
ok(!( "\c[NULL]" ~~ m/^<-:Cc>$/ ), q{Don't match inverted <Cc> (Control)} );
ok(!( "\x[0A7A]"  ~~ m/^<:Cc>$/ ), q{Don't match unrelated <Cc> (Control)} );
#?pugs todo
ok("\x[0A7A]"  ~~ m/^<:!Cc>$/, q{Match unrelated negated <Cc> (Control)} );
#?pugs todo
ok("\x[0A7A]"  ~~ m/^<-:Cc>$/, q{Match unrelated inverted <Cc> (Control)} );
ok(!( "\x[0A7A]" ~~ m/^<:Cc>$/ ), q{Don't match related <Cc> (Control)} );
#?pugs todo
ok("\x[0A7A]" ~~ m/^<:!Cc>$/, q{Match related negated <Cc> (Control)} );
#?pugs todo
ok("\x[0A7A]" ~~ m/^<-:Cc>$/, q{Match related inverted <Cc> (Control)} );
#?pugs todo
ok("\x[0A7A]\x[0A7A]\c[NULL]" ~~ m/<:Cc>/, q{Match unanchored <Cc> (Control)} );

#?pugs todo
ok("\c[NULL]" ~~ m/^<:Control>$/, q{Match <:Control>} );
ok(!( "\c[NULL]" ~~ m/^<:!Control>$/ ), q{Don't match negated <Control>} );
ok(!( "\c[NULL]" ~~ m/^<-:Control>$/ ), q{Don't match inverted <Control>} );
ok(!( "\x[4886]"  ~~ m/^<:Control>$/ ), q{Don't match unrelated <Control>} );
#?pugs todo
ok("\x[4886]"  ~~ m/^<:!Control>$/, q{Match unrelated negated <Control>} );
#?pugs todo
ok("\x[4886]"  ~~ m/^<-:Control>$/, q{Match unrelated inverted <Control>} );
ok(!( "\x[4DB6]" ~~ m/^<:Control>$/ ), q{Don't match related <Control>} );
#?pugs todo
ok("\x[4DB6]" ~~ m/^<:!Control>$/, q{Match related negated <Control>} );
#?pugs todo
ok("\x[4DB6]" ~~ m/^<-:Control>$/, q{Match related inverted <Control>} );
#?pugs todo
ok("\x[4886]\x[4DB6]\c[NULL]" ~~ m/<:Control>/, q{Match unanchored <Control>} );

# Cf          Format


#?pugs todo
ok("\c[SOFT HYPHEN]" ~~ m/^<:Cf>$/, q{Match <:Cf> (Format)} );
ok(!( "\c[SOFT HYPHEN]" ~~ m/^<:!Cf>$/ ), q{Don't match negated <Cf> (Format)} );
ok(!( "\c[SOFT HYPHEN]" ~~ m/^<-:Cf>$/ ), q{Don't match inverted <Cf> (Format)} );
ok(!( "\x[77B8]"  ~~ m/^<:Cf>$/ ), q{Don't match unrelated <Cf> (Format)} );
#?pugs todo
ok("\x[77B8]"  ~~ m/^<:!Cf>$/, q{Match unrelated negated <Cf> (Format)} );
#?pugs todo
ok("\x[77B8]"  ~~ m/^<-:Cf>$/, q{Match unrelated inverted <Cf> (Format)} );
#?rakudo 3 skip '\x[FFFE]'
ok(!( "\x[FFFE]" ~~ m/^<:Cf>$/ ), q{Don't match related <Cf> (Format)} );
#?pugs todo
ok("\x[FFFE]" ~~ m/^<:!Cf>$/, q{Match related negated <Cf> (Format)} );
#?pugs todo
ok("\x[FFFE]" ~~ m/^<-:Cf>$/, q{Match related inverted <Cf> (Format)} );
#?rakudo skip "Malformed UTF-8 string"
#?pugs todo
ok("\x[77B8]\x[FFFE]\c[SOFT HYPHEN]" ~~ m/<:Cf>/, q{Match unanchored <Cf> (Format)} );

#?pugs todo
ok("\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<:Format>$/, q{Match <:Format>} );
ok(!( "\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<:!Format>$/ ), q{Don't match negated <Format>} );
ok(!( "\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<-:Format>$/ ), q{Don't match inverted <Format>} );
ok(!( "\c[DEVANAGARI VOWEL SIGN AU]"  ~~ m/^<:Format>$/ ), q{Don't match unrelated <Format>} );
#?pugs todo
ok("\c[DEVANAGARI VOWEL SIGN AU]"  ~~ m/^<:!Format>$/, q{Match unrelated negated <Format>} );
#?pugs todo
ok("\c[DEVANAGARI VOWEL SIGN AU]"  ~~ m/^<-:Format>$/, q{Match unrelated inverted <Format>} );
#?pugs todo
ok("\c[DEVANAGARI VOWEL SIGN AU]\c[KHMER VOWEL INHERENT AQ]" ~~ m/<:Format>/, q{Match unanchored <Format>} );


# vim: ft=perl6
