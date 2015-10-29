# Tests generated from the Unicode Character Database's GraphemeBreakTest.txt
# by S15-nfg/grapheme-break-test-gen.p6.

use Test;

plan 402;

is Uni.new(0x0020, 0x0020).Str.chars, 2, '÷ [0.2] SPACE (Other) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x0020, 0x0308, 0x0020).Str.chars, 2, '÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x0020, 0x000D).Str.chars, 2, '÷ [0.2] SPACE (Other) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x0020, 0x0308, 0x000D).Str.chars, 2, '÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x0020, 0x000A).Str.chars, 2, '÷ [0.2] SPACE (Other) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x0020, 0x0308, 0x000A).Str.chars, 2, '÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x0020, 0x0001).Str.chars, 2, '÷ [0.2] SPACE (Other) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x0020, 0x0308, 0x0001).Str.chars, 2, '÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x0020, 0x0300).Str.chars, 1, '÷ [0.2] SPACE (Other) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x0020, 0x0308, 0x0300).Str.chars, 1, '÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x0020, 0x0903).Str.chars, 1, '÷ [0.2] SPACE (Other) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x0020, 0x0308, 0x0903).Str.chars, 1, '÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x0020, 0x1100).Str.chars, 2, '÷ [0.2] SPACE (Other) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x0020, 0x0308, 0x1100).Str.chars, 2, '÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x0020, 0x1160).Str.chars, 2, '÷ [0.2] SPACE (Other) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x0020, 0x0308, 0x1160).Str.chars, 2, '÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x0020, 0x11A8).Str.chars, 2, '÷ [0.2] SPACE (Other) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x0020, 0x0308, 0x11A8).Str.chars, 2, '÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x0020, 0xAC00).Str.chars, 2, '÷ [0.2] SPACE (Other) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x0020, 0x0308, 0xAC00).Str.chars, 2, '÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x0020, 0xAC01).Str.chars, 2, '÷ [0.2] SPACE (Other) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x0020, 0x0308, 0xAC01).Str.chars, 2, '÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x0020, 0x1F1E6).Str.chars, 2, '÷ [0.2] SPACE (Other) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x0020, 0x0308, 0x1F1E6).Str.chars, 2, '÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x0020, 0x0378).Str.chars, 2, '÷ [0.2] SPACE (Other) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x0020, 0x0308, 0x0378).Str.chars, 2, '÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x0020, 0xD800).Str.chars, 2, '÷ [0.2] SPACE (Other) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x0020, 0x0308, 0xD800).Str.chars, 2, '÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x000D, 0x0020).Str.chars, 2, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x000D, 0x0308, 0x0020).Str.chars, 3, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x000D, 0x000D).Str.chars, 2, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x000D, 0x0308, 0x000D).Str.chars, 3, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

#?rakudo todo '\r\n is not yet a single grapheme'
is Uni.new(0x000D, 0x000A).Str.chars, 1, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) × [3.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x000D, 0x0308, 0x000A).Str.chars, 3, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x000D, 0x0001).Str.chars, 2, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x000D, 0x0308, 0x0001).Str.chars, 3, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x000D, 0x0300).Str.chars, 2, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x000D, 0x0308, 0x0300).Str.chars, 2, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x000D, 0x0903).Str.chars, 2, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x000D, 0x0308, 0x0903).Str.chars, 2, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x000D, 0x1100).Str.chars, 2, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x000D, 0x0308, 0x1100).Str.chars, 3, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x000D, 0x1160).Str.chars, 2, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x000D, 0x0308, 0x1160).Str.chars, 3, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x000D, 0x11A8).Str.chars, 2, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x000D, 0x0308, 0x11A8).Str.chars, 3, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x000D, 0xAC00).Str.chars, 2, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x000D, 0x0308, 0xAC00).Str.chars, 3, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x000D, 0xAC01).Str.chars, 2, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x000D, 0x0308, 0xAC01).Str.chars, 3, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x000D, 0x1F1E6).Str.chars, 2, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x000D, 0x0308, 0x1F1E6).Str.chars, 3, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x000D, 0x0378).Str.chars, 2, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x000D, 0x0308, 0x0378).Str.chars, 3, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x000D, 0xD800).Str.chars, 2, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x000D, 0x0308, 0xD800).Str.chars, 3, '÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x000A, 0x0020).Str.chars, 2, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x000A, 0x0308, 0x0020).Str.chars, 3, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x000A, 0x000D).Str.chars, 2, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x000A, 0x0308, 0x000D).Str.chars, 3, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x000A, 0x000A).Str.chars, 2, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x000A, 0x0308, 0x000A).Str.chars, 3, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x000A, 0x0001).Str.chars, 2, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x000A, 0x0308, 0x0001).Str.chars, 3, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x000A, 0x0300).Str.chars, 2, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x000A, 0x0308, 0x0300).Str.chars, 2, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x000A, 0x0903).Str.chars, 2, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x000A, 0x0308, 0x0903).Str.chars, 2, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x000A, 0x1100).Str.chars, 2, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x000A, 0x0308, 0x1100).Str.chars, 3, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x000A, 0x1160).Str.chars, 2, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x000A, 0x0308, 0x1160).Str.chars, 3, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x000A, 0x11A8).Str.chars, 2, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x000A, 0x0308, 0x11A8).Str.chars, 3, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x000A, 0xAC00).Str.chars, 2, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x000A, 0x0308, 0xAC00).Str.chars, 3, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x000A, 0xAC01).Str.chars, 2, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x000A, 0x0308, 0xAC01).Str.chars, 3, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x000A, 0x1F1E6).Str.chars, 2, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x000A, 0x0308, 0x1F1E6).Str.chars, 3, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x000A, 0x0378).Str.chars, 2, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x000A, 0x0308, 0x0378).Str.chars, 3, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x000A, 0xD800).Str.chars, 2, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x000A, 0x0308, 0xD800).Str.chars, 3, '÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x0001, 0x0020).Str.chars, 2, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x0001, 0x0308, 0x0020).Str.chars, 3, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x0001, 0x000D).Str.chars, 2, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x0001, 0x0308, 0x000D).Str.chars, 3, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x0001, 0x000A).Str.chars, 2, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x0001, 0x0308, 0x000A).Str.chars, 3, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x0001, 0x0001).Str.chars, 2, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x0001, 0x0308, 0x0001).Str.chars, 3, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x0001, 0x0300).Str.chars, 2, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x0001, 0x0308, 0x0300).Str.chars, 2, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x0001, 0x0903).Str.chars, 2, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x0001, 0x0308, 0x0903).Str.chars, 2, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x0001, 0x1100).Str.chars, 2, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x0001, 0x0308, 0x1100).Str.chars, 3, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x0001, 0x1160).Str.chars, 2, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x0001, 0x0308, 0x1160).Str.chars, 3, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x0001, 0x11A8).Str.chars, 2, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x0001, 0x0308, 0x11A8).Str.chars, 3, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x0001, 0xAC00).Str.chars, 2, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x0001, 0x0308, 0xAC00).Str.chars, 3, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x0001, 0xAC01).Str.chars, 2, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x0001, 0x0308, 0xAC01).Str.chars, 3, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x0001, 0x1F1E6).Str.chars, 2, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x0001, 0x0308, 0x1F1E6).Str.chars, 3, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x0001, 0x0378).Str.chars, 2, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x0001, 0x0308, 0x0378).Str.chars, 3, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x0001, 0xD800).Str.chars, 2, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x0001, 0x0308, 0xD800).Str.chars, 3, '÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x0300, 0x0020).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x0300, 0x0308, 0x0020).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x0300, 0x000D).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x0300, 0x0308, 0x000D).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x0300, 0x000A).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x0300, 0x0308, 0x000A).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x0300, 0x0001).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x0300, 0x0308, 0x0001).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x0300, 0x0300).Str.chars, 1, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x0300, 0x0308, 0x0300).Str.chars, 1, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x0300, 0x0903).Str.chars, 1, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x0300, 0x0308, 0x0903).Str.chars, 1, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x0300, 0x1100).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x0300, 0x0308, 0x1100).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x0300, 0x1160).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x0300, 0x0308, 0x1160).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x0300, 0x11A8).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x0300, 0x0308, 0x11A8).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x0300, 0xAC00).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x0300, 0x0308, 0xAC00).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x0300, 0xAC01).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x0300, 0x0308, 0xAC01).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x0300, 0x1F1E6).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x0300, 0x0308, 0x1F1E6).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x0300, 0x0378).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x0300, 0x0308, 0x0378).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x0300, 0xD800).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x0300, 0x0308, 0xD800).Str.chars, 2, '÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x0903, 0x0020).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x0903, 0x0308, 0x0020).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x0903, 0x000D).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x0903, 0x0308, 0x000D).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x0903, 0x000A).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x0903, 0x0308, 0x000A).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x0903, 0x0001).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x0903, 0x0308, 0x0001).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x0903, 0x0300).Str.chars, 1, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x0903, 0x0308, 0x0300).Str.chars, 1, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x0903, 0x0903).Str.chars, 1, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x0903, 0x0308, 0x0903).Str.chars, 1, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x0903, 0x1100).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x0903, 0x0308, 0x1100).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x0903, 0x1160).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x0903, 0x0308, 0x1160).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x0903, 0x11A8).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x0903, 0x0308, 0x11A8).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x0903, 0xAC00).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x0903, 0x0308, 0xAC00).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x0903, 0xAC01).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x0903, 0x0308, 0xAC01).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x0903, 0x1F1E6).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x0903, 0x0308, 0x1F1E6).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x0903, 0x0378).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x0903, 0x0308, 0x0378).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x0903, 0xD800).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x0903, 0x0308, 0xD800).Str.chars, 2, '÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x1100, 0x0020).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x1100, 0x0308, 0x0020).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x1100, 0x000D).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x1100, 0x0308, 0x000D).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x1100, 0x000A).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x1100, 0x0308, 0x000A).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x1100, 0x0001).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x1100, 0x0308, 0x0001).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x1100, 0x0300).Str.chars, 1, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x1100, 0x0308, 0x0300).Str.chars, 1, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x1100, 0x0903).Str.chars, 1, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x1100, 0x0308, 0x0903).Str.chars, 1, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x1100, 0x1100).Str.chars, 1, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [6.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x1100, 0x0308, 0x1100).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x1100, 0x1160).Str.chars, 1, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [6.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x1100, 0x0308, 0x1160).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x1100, 0x11A8).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x1100, 0x0308, 0x11A8).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x1100, 0xAC00).Str.chars, 1, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [6.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x1100, 0x0308, 0xAC00).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x1100, 0xAC01).Str.chars, 1, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [6.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x1100, 0x0308, 0xAC01).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x1100, 0x1F1E6).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x1100, 0x0308, 0x1F1E6).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x1100, 0x0378).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x1100, 0x0308, 0x0378).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x1100, 0xD800).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x1100, 0x0308, 0xD800).Str.chars, 2, '÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x1160, 0x0020).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x1160, 0x0308, 0x0020).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x1160, 0x000D).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x1160, 0x0308, 0x000D).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x1160, 0x000A).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x1160, 0x0308, 0x000A).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x1160, 0x0001).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x1160, 0x0308, 0x0001).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x1160, 0x0300).Str.chars, 1, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x1160, 0x0308, 0x0300).Str.chars, 1, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x1160, 0x0903).Str.chars, 1, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x1160, 0x0308, 0x0903).Str.chars, 1, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x1160, 0x1100).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x1160, 0x0308, 0x1100).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x1160, 0x1160).Str.chars, 1, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [7.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x1160, 0x0308, 0x1160).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x1160, 0x11A8).Str.chars, 1, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [7.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x1160, 0x0308, 0x11A8).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x1160, 0xAC00).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x1160, 0x0308, 0xAC00).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x1160, 0xAC01).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x1160, 0x0308, 0xAC01).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x1160, 0x1F1E6).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x1160, 0x0308, 0x1F1E6).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x1160, 0x0378).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x1160, 0x0308, 0x0378).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x1160, 0xD800).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x1160, 0x0308, 0xD800).Str.chars, 2, '÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x11A8, 0x0020).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x11A8, 0x0308, 0x0020).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x11A8, 0x000D).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x11A8, 0x0308, 0x000D).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x11A8, 0x000A).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x11A8, 0x0308, 0x000A).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x11A8, 0x0001).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x11A8, 0x0308, 0x0001).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x11A8, 0x0300).Str.chars, 1, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x11A8, 0x0308, 0x0300).Str.chars, 1, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x11A8, 0x0903).Str.chars, 1, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x11A8, 0x0308, 0x0903).Str.chars, 1, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x11A8, 0x1100).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x11A8, 0x0308, 0x1100).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x11A8, 0x1160).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x11A8, 0x0308, 0x1160).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x11A8, 0x11A8).Str.chars, 1, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [8.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x11A8, 0x0308, 0x11A8).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x11A8, 0xAC00).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x11A8, 0x0308, 0xAC00).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x11A8, 0xAC01).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x11A8, 0x0308, 0xAC01).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x11A8, 0x1F1E6).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x11A8, 0x0308, 0x1F1E6).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x11A8, 0x0378).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x11A8, 0x0308, 0x0378).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x11A8, 0xD800).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x11A8, 0x0308, 0xD800).Str.chars, 2, '÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0xAC00, 0x0020).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0xAC00, 0x0308, 0x0020).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0xAC00, 0x000D).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0xAC00, 0x0308, 0x000D).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0xAC00, 0x000A).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0xAC00, 0x0308, 0x000A).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0xAC00, 0x0001).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0xAC00, 0x0308, 0x0001).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0xAC00, 0x0300).Str.chars, 1, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0xAC00, 0x0308, 0x0300).Str.chars, 1, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0xAC00, 0x0903).Str.chars, 1, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0xAC00, 0x0308, 0x0903).Str.chars, 1, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0xAC00, 0x1100).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0xAC00, 0x0308, 0x1100).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0xAC00, 0x1160).Str.chars, 1, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [7.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0xAC00, 0x0308, 0x1160).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0xAC00, 0x11A8).Str.chars, 1, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [7.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0xAC00, 0x0308, 0x11A8).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0xAC00, 0xAC00).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0xAC00, 0x0308, 0xAC00).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0xAC00, 0xAC01).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0xAC00, 0x0308, 0xAC01).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0xAC00, 0x1F1E6).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0xAC00, 0x0308, 0x1F1E6).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0xAC00, 0x0378).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0xAC00, 0x0308, 0x0378).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0xAC00, 0xD800).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0xAC00, 0x0308, 0xD800).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0xAC01, 0x0020).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0xAC01, 0x0308, 0x0020).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0xAC01, 0x000D).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0xAC01, 0x0308, 0x000D).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0xAC01, 0x000A).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0xAC01, 0x0308, 0x000A).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0xAC01, 0x0001).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0xAC01, 0x0308, 0x0001).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0xAC01, 0x0300).Str.chars, 1, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0xAC01, 0x0308, 0x0300).Str.chars, 1, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0xAC01, 0x0903).Str.chars, 1, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0xAC01, 0x0308, 0x0903).Str.chars, 1, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0xAC01, 0x1100).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0xAC01, 0x0308, 0x1100).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0xAC01, 0x1160).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0xAC01, 0x0308, 0x1160).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0xAC01, 0x11A8).Str.chars, 1, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [8.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0xAC01, 0x0308, 0x11A8).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0xAC01, 0xAC00).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0xAC01, 0x0308, 0xAC00).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0xAC01, 0xAC01).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0xAC01, 0x0308, 0xAC01).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0xAC01, 0x1F1E6).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0xAC01, 0x0308, 0x1F1E6).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0xAC01, 0x0378).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0xAC01, 0x0308, 0x0378).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0xAC01, 0xD800).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0xAC01, 0x0308, 0xD800).Str.chars, 2, '÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0020).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0308, 0x0020).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x000D).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0308, 0x000D).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x000A).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0308, 0x000A).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0001).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0308, 0x0001).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0300).Str.chars, 1, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0308, 0x0300).Str.chars, 1, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0903).Str.chars, 1, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0308, 0x0903).Str.chars, 1, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x1100).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0308, 0x1100).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x1160).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0308, 0x1160).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x11A8).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0308, 0x11A8).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x1F1E6, 0xAC00).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0308, 0xAC00).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x1F1E6, 0xAC01).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0308, 0xAC01).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x1F1E6).Str.chars, 1, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [8.1] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0308, 0x1F1E6).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0378).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0308, 0x0378).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x1F1E6, 0xD800).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x0308, 0xD800).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x0378, 0x0020).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x0378, 0x0308, 0x0020).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0x0378, 0x000D).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x0378, 0x0308, 0x000D).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0x0378, 0x000A).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x0378, 0x0308, 0x000A).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0x0378, 0x0001).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x0378, 0x0308, 0x0001).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0x0378, 0x0300).Str.chars, 1, '÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x0378, 0x0308, 0x0300).Str.chars, 1, '÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0x0378, 0x0903).Str.chars, 1, '÷ [0.2] <reserved-0378> (Other) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x0378, 0x0308, 0x0903).Str.chars, 1, '÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0x0378, 0x1100).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x0378, 0x0308, 0x1100).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0x0378, 0x1160).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x0378, 0x0308, 0x1160).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0x0378, 0x11A8).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x0378, 0x0308, 0x11A8).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0x0378, 0xAC00).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x0378, 0x0308, 0xAC00).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0x0378, 0xAC01).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x0378, 0x0308, 0xAC01).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0x0378, 0x1F1E6).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x0378, 0x0308, 0x1F1E6).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x0378, 0x0378).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x0378, 0x0308, 0x0378).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0x0378, 0xD800).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x0378, 0x0308, 0xD800).Str.chars, 2, '÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0xD800, 0x0020).Str.chars, 2, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0xD800, 0x0308, 0x0020).Str.chars, 3, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3]';

is Uni.new(0xD800, 0x000D).Str.chars, 2, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0xD800, 0x0308, 0x000D).Str.chars, 3, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3]';

is Uni.new(0xD800, 0x000A).Str.chars, 2, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0xD800, 0x0308, 0x000A).Str.chars, 3, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3]';

is Uni.new(0xD800, 0x0001).Str.chars, 2, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0xD800, 0x0308, 0x0001).Str.chars, 3, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3]';

is Uni.new(0xD800, 0x0300).Str.chars, 2, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0xD800, 0x0308, 0x0300).Str.chars, 2, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3]';

is Uni.new(0xD800, 0x0903).Str.chars, 2, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0xD800, 0x0308, 0x0903).Str.chars, 2, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3]';

is Uni.new(0xD800, 0x1100).Str.chars, 2, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0xD800, 0x0308, 0x1100).Str.chars, 3, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3]';

is Uni.new(0xD800, 0x1160).Str.chars, 2, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0xD800, 0x0308, 0x1160).Str.chars, 3, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3]';

is Uni.new(0xD800, 0x11A8).Str.chars, 2, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0xD800, 0x0308, 0x11A8).Str.chars, 3, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3]';

is Uni.new(0xD800, 0xAC00).Str.chars, 2, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0xD800, 0x0308, 0xAC00).Str.chars, 3, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3]';

is Uni.new(0xD800, 0xAC01).Str.chars, 2, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0xD800, 0x0308, 0xAC01).Str.chars, 3, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3]';

is Uni.new(0xD800, 0x1F1E6).Str.chars, 2, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0xD800, 0x0308, 0x1F1E6).Str.chars, 3, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [0.3]';

is Uni.new(0xD800, 0x0378).Str.chars, 2, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0xD800, 0x0308, 0x0378).Str.chars, 3, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3]';

is Uni.new(0xD800, 0xD800).Str.chars, 2, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0xD800, 0x0308, 0xD800).Str.chars, 3, '÷ [0.2] <surrogate-D800> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <surrogate-D800> (Control) ÷ [0.3]';

is Uni.new(0x0061, 0x1F1E6, 0x0062).Str.chars, 3, '÷ [0.2] LATIN SMALL LETTER A (Other) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) ÷ [999.0] LATIN SMALL LETTER B (Other) ÷ [0.3]';

is Uni.new(0x1F1F7, 0x1F1FA).Str.chars, 1, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER R (Regional_Indicator) × [8.1] REGIONAL INDICATOR SYMBOL LETTER U (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x1F1F7, 0x1F1FA, 0x1F1F8).Str.chars, 1, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER R (Regional_Indicator) × [8.1] REGIONAL INDICATOR SYMBOL LETTER U (Regional_Indicator) × [8.1] REGIONAL INDICATOR SYMBOL LETTER S (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x1F1F7, 0x1F1FA, 0x1F1F8, 0x1F1EA).Str.chars, 1, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER R (Regional_Indicator) × [8.1] REGIONAL INDICATOR SYMBOL LETTER U (Regional_Indicator) × [8.1] REGIONAL INDICATOR SYMBOL LETTER S (Regional_Indicator) × [8.1] REGIONAL INDICATOR SYMBOL LETTER E (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x1F1F7, 0x1F1FA, 0x200B, 0x1F1F8, 0x1F1EA).Str.chars, 3, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER R (Regional_Indicator) × [8.1] REGIONAL INDICATOR SYMBOL LETTER U (Regional_Indicator) ÷ [5.0] ZERO WIDTH SPACE (Control) ÷ [4.0] REGIONAL INDICATOR SYMBOL LETTER S (Regional_Indicator) × [8.1] REGIONAL INDICATOR SYMBOL LETTER E (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x1F1E7, 0x1F1E8).Str.chars, 1, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [8.1] REGIONAL INDICATOR SYMBOL LETTER B (Regional_Indicator) × [8.1] REGIONAL INDICATOR SYMBOL LETTER C (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x200D, 0x1F1E7, 0x1F1E8).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [9.0] ZERO WIDTH JOINER (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER B (Regional_Indicator) × [8.1] REGIONAL INDICATOR SYMBOL LETTER C (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x1F1E6, 0x1F1E7, 0x200D, 0x1F1E8).Str.chars, 2, '÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (Regional_Indicator) × [8.1] REGIONAL INDICATOR SYMBOL LETTER B (Regional_Indicator) × [9.0] ZERO WIDTH JOINER (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER C (Regional_Indicator) ÷ [0.3]';

is Uni.new(0x0020, 0x200D, 0x0646).Str.chars, 2, '÷ [0.2] SPACE (Other) × [9.0] ZERO WIDTH JOINER (Extend) ÷ [999.0] ARABIC LETTER NOON (Other) ÷ [0.3]';

is Uni.new(0x0646, 0x200D, 0x0020).Str.chars, 2, '÷ [0.2] ARABIC LETTER NOON (Other) × [9.0] ZERO WIDTH JOINER (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3]';

