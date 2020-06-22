use v6;
use Test;


plan 41;

# OtherAlphabetic

ok("\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<:OtherAlphabetic>$/, q{Match <:OtherAlphabetic>} );
ok(!( "\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<:!OtherAlphabetic>$/ ), q{Don't match negated <OtherAlphabetic>} );
ok(!( "\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<-:OtherAlphabetic>$/ ), q{Don't match inverted <OtherAlphabetic>} );
ok(!( "\x[413C]"  ~~ m/^<:OtherAlphabetic>$/ ), q{Don't match unrelated <OtherAlphabetic>} );
ok("\x[413C]"  ~~ m/^<:!OtherAlphabetic>$/, q{Match unrelated negated <OtherAlphabetic>} );
ok("\x[413C]"  ~~ m/^<-:OtherAlphabetic>$/, q{Match unrelated inverted <OtherAlphabetic>} );

# OtherDefaultIgnorableCodePoint


ok("\c[HANGUL FILLER]" ~~ m/^<:OtherDefaultIgnorableCodePoint>$/, q{Match <:OtherDefaultIgnorableCodePoint>} );
ok(!( "\c[HANGUL FILLER]" ~~ m/^<:!OtherDefaultIgnorableCodePoint>$/ ), q{Don't match negated <OtherDefaultIgnorableCodePoint>} );
ok(!( "\c[HANGUL FILLER]" ~~ m/^<-:OtherDefaultIgnorableCodePoint>$/ ), q{Don't match inverted <OtherDefaultIgnorableCodePoint>} );
ok(!( "\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<:OtherDefaultIgnorableCodePoint>$/ ), q{Don't match unrelated <OtherDefaultIgnorableCodePoint>} );
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<:!OtherDefaultIgnorableCodePoint>$/, q{Match unrelated negated <OtherDefaultIgnorableCodePoint>} );
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<-:OtherDefaultIgnorableCodePoint>$/, q{Match unrelated inverted <OtherDefaultIgnorableCodePoint>} );
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]\c[HANGUL FILLER]" ~~ m/<:OtherDefaultIgnorableCodePoint>/, q{Match unanchored <OtherDefaultIgnorableCodePoint>} );

# OtherGraphemeExtend


ok("\c[BENGALI VOWEL SIGN AA]" ~~ m/^<:OtherGraphemeExtend>$/, q{Match <:OtherGraphemeExtend>} );
ok(!( "\c[BENGALI VOWEL SIGN AA]" ~~ m/^<:!OtherGraphemeExtend>$/ ), q{Don't match negated <OtherGraphemeExtend>} );
ok(!( "\c[BENGALI VOWEL SIGN AA]" ~~ m/^<-:OtherGraphemeExtend>$/ ), q{Don't match inverted <OtherGraphemeExtend>} );
ok(!( "\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<:OtherGraphemeExtend>$/ ), q{Don't match unrelated <OtherGraphemeExtend>} );
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<:!OtherGraphemeExtend>$/, q{Match unrelated negated <OtherGraphemeExtend>} );
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<-:OtherGraphemeExtend>$/, q{Match unrelated inverted <OtherGraphemeExtend>} );
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]\n\c[BENGALI VOWEL SIGN AA]" ~~ m/<:OtherGraphemeExtend>/, q{Match unanchored <OtherGraphemeExtend>} );

# OtherLowercase


ok("\c[MODIFIER LETTER SMALL H]" ~~ m/^<:OtherLowercase>$/, q{Match <:OtherLowercase>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<:!OtherLowercase>$/ ), q{Don't match negated <OtherLowercase>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<-:OtherLowercase>$/ ), q{Don't match inverted <OtherLowercase>} );
ok(!( "\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<:OtherLowercase>$/ ), q{Don't match unrelated <OtherLowercase>} );
ok("\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<:!OtherLowercase>$/, q{Match unrelated negated <OtherLowercase>} );
ok("\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<-:OtherLowercase>$/, q{Match unrelated inverted <OtherLowercase>} );
ok("\c[HANGUL LETTER NIEUN-CIEUC]\c[MODIFIER LETTER SMALL H]" ~~ m/<:OtherLowercase>/, q{Match unanchored <OtherLowercase>} );

# OtherMath


ok("\c[SUPERSCRIPT LEFT PARENTHESIS]" ~~ m/^<:OtherMath>$/, q{Match <:OtherMath>} );
ok(!( "\c[SUPERSCRIPT LEFT PARENTHESIS]" ~~ m/^<:!OtherMath>$/ ), q{Don't match negated <OtherMath>} );
ok(!( "\c[SUPERSCRIPT LEFT PARENTHESIS]" ~~ m/^<-:OtherMath>$/ ), q{Don't match inverted <OtherMath>} );
ok(!( "\x[B43A]"  ~~ m/^<:OtherMath>$/ ), q{Don't match unrelated <OtherMath>} );
ok("\x[B43A]"  ~~ m/^<:!OtherMath>$/, q{Match unrelated negated <OtherMath>} );
ok("\x[B43A]"  ~~ m/^<-:OtherMath>$/, q{Match unrelated inverted <OtherMath>} );
ok("\x[B43A]\c[SUPERSCRIPT LEFT PARENTHESIS]" ~~ m/<:OtherMath>/, q{Match unanchored <OtherMath>} );

# OtherUppercase


ok("\c[ROMAN NUMERAL ONE]" ~~ m/^<:OtherUppercase>$/, q{Match <:OtherUppercase>} );
ok(!( "\c[ROMAN NUMERAL ONE]" ~~ m/^<:!OtherUppercase>$/ ), q{Don't match negated <OtherUppercase>} );
ok(!( "\c[ROMAN NUMERAL ONE]" ~~ m/^<-:OtherUppercase>$/ ), q{Don't match inverted <OtherUppercase>} );
ok(!( "\x[D246]"  ~~ m/^<:OtherUppercase>$/ ), q{Don't match unrelated <OtherUppercase>} );
ok("\x[D246]"  ~~ m/^<:!OtherUppercase>$/, q{Match unrelated negated <OtherUppercase>} );
ok("\x[D246]"  ~~ m/^<-:OtherUppercase>$/, q{Match unrelated inverted <OtherUppercase>} );
ok("\x[D246]\c[ROMAN NUMERAL ONE]" ~~ m/<:OtherUppercase>/, q{Match unanchored <OtherUppercase>} );

# vim: expandtab shiftwidth=4
