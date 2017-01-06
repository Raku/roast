# Test generated from GraphemeBreakTest.txt Unicode version 9.0.0
use v6;
use Test;
plan 744;
## ÷ [0.2] SPACE (Other) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #24 Unicode Version 9.0.0
is Uni.new(0x20, 0x20).Str.chars, 2, "÷ [0.2] SPACE (Other) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #25 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0x20).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] SPACE (Other) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #26 Unicode Version 9.0.0
is Uni.new(0x20, 0xD).Str.chars, 2, "÷ [0.2] SPACE (Other) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #27 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0xD).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] SPACE (Other) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #28 Unicode Version 9.0.0
is Uni.new(0x20, 0xA).Str.chars, 2, "÷ [0.2] SPACE (Other) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #29 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0xA).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] SPACE (Other) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #30 Unicode Version 9.0.0
is Uni.new(0x20, 0x1).Str.chars, 2, "÷ [0.2] SPACE (Other) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #31 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0x1).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #32 Unicode Version 9.0.0
is Uni.new(0x20, 0x300).Str.chars, 1, "÷ [0.2] SPACE (Other) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #33 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0x300).Str.chars, 1, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] SPACE (Other) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #34 Unicode Version 9.0.0
is Uni.new(0x20, 0x600).Str.chars, 2, "÷ [0.2] SPACE (Other) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #35 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0x600).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] SPACE (Other) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #36 Unicode Version 9.0.0
is Uni.new(0x20, 0x903).Str.chars, 1, "÷ [0.2] SPACE (Other) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #37 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0x903).Str.chars, 1, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] SPACE (Other) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #38 Unicode Version 9.0.0
is Uni.new(0x20, 0x1100).Str.chars, 2, "÷ [0.2] SPACE (Other) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #39 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0x1100).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] SPACE (Other) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #40 Unicode Version 9.0.0
is Uni.new(0x20, 0x1160).Str.chars, 2, "÷ [0.2] SPACE (Other) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #41 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0x1160).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] SPACE (Other) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #42 Unicode Version 9.0.0
is Uni.new(0x20, 0x11A8).Str.chars, 2, "÷ [0.2] SPACE (Other) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #43 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0x11A8).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] SPACE (Other) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #44 Unicode Version 9.0.0
is Uni.new(0x20, 0xAC00).Str.chars, 2, "÷ [0.2] SPACE (Other) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #45 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0xAC00).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] SPACE (Other) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #46 Unicode Version 9.0.0
is Uni.new(0x20, 0xAC01).Str.chars, 2, "÷ [0.2] SPACE (Other) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #47 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0xAC01).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] SPACE (Other) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #48 Unicode Version 9.0.0
is Uni.new(0x20, 0x1F1E6).Str.chars, 2, "÷ [0.2] SPACE (Other) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #49 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0x1F1E6).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] SPACE (Other) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #50 Unicode Version 9.0.0
is Uni.new(0x20, 0x261D).Str.chars, 2, "÷ [0.2] SPACE (Other) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #51 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0x261D).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] SPACE (Other) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #52 Unicode Version 9.0.0
is Uni.new(0x20, 0x1F3FB).Str.chars, 2, "÷ [0.2] SPACE (Other) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #53 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0x1F3FB).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] SPACE (Other) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #54 Unicode Version 9.0.0
is Uni.new(0x20, 0x200D).Str.chars, 1, "÷ [0.2] SPACE (Other) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #55 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0x200D).Str.chars, 1, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] SPACE (Other) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #56 Unicode Version 9.0.0
is Uni.new(0x20, 0x2764).Str.chars, 2, "÷ [0.2] SPACE (Other) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #57 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0x2764).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] SPACE (Other) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #58 Unicode Version 9.0.0
is Uni.new(0x20, 0x1F466).Str.chars, 2, "÷ [0.2] SPACE (Other) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #59 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0x1F466).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] SPACE (Other) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #60 Unicode Version 9.0.0
is Uni.new(0x20, 0x378).Str.chars, 2, "÷ [0.2] SPACE (Other) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #61 Unicode Version 9.0.0
is Uni.new(0x20, 0x308, 0x378).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #64 Unicode Version 9.0.0
is Uni.new(0xD, 0x20).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #65 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0x20).Str.chars, 3, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #66 Unicode Version 9.0.0
is Uni.new(0xD, 0xD).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #67 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0xD).Str.chars, 3, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) × [3.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #68 Unicode Version 9.0.0
is Uni.new(0xD, 0xA).Str.chars, 1, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) × [3.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #69 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0xA).Str.chars, 3, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #70 Unicode Version 9.0.0
is Uni.new(0xD, 0x1).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #71 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0x1).Str.chars, 3, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #72 Unicode Version 9.0.0
is Uni.new(0xD, 0x300).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #73 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0x300).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #74 Unicode Version 9.0.0
is Uni.new(0xD, 0x600).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #75 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0x600).Str.chars, 3, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #76 Unicode Version 9.0.0
is Uni.new(0xD, 0x903).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #77 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0x903).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #78 Unicode Version 9.0.0
is Uni.new(0xD, 0x1100).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #79 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0x1100).Str.chars, 3, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #80 Unicode Version 9.0.0
is Uni.new(0xD, 0x1160).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #81 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0x1160).Str.chars, 3, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #82 Unicode Version 9.0.0
is Uni.new(0xD, 0x11A8).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #83 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0x11A8).Str.chars, 3, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #84 Unicode Version 9.0.0
is Uni.new(0xD, 0xAC00).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #85 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0xAC00).Str.chars, 3, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #86 Unicode Version 9.0.0
is Uni.new(0xD, 0xAC01).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #87 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0xAC01).Str.chars, 3, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #88 Unicode Version 9.0.0
is Uni.new(0xD, 0x1F1E6).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #89 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0x1F1E6).Str.chars, 3, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #90 Unicode Version 9.0.0
is Uni.new(0xD, 0x261D).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #91 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0x261D).Str.chars, 3, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #92 Unicode Version 9.0.0
is Uni.new(0xD, 0x1F3FB).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #93 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0x1F3FB).Str.chars, 3, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #94 Unicode Version 9.0.0
is Uni.new(0xD, 0x200D).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #95 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0x200D).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #96 Unicode Version 9.0.0
is Uni.new(0xD, 0x2764).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #97 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0x2764).Str.chars, 3, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #98 Unicode Version 9.0.0
is Uni.new(0xD, 0x1F466).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #99 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0x1F466).Str.chars, 3, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #100 Unicode Version 9.0.0
is Uni.new(0xD, 0x378).Str.chars, 2, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #101 Unicode Version 9.0.0
is Uni.new(0xD, 0x308, 0x378).Str.chars, 3, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #104 Unicode Version 9.0.0
is Uni.new(0xA, 0x20).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #105 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0x20).Str.chars, 3, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #106 Unicode Version 9.0.0
is Uni.new(0xA, 0xD).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #107 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0xD).Str.chars, 3, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #108 Unicode Version 9.0.0
is Uni.new(0xA, 0xA).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #109 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0xA).Str.chars, 3, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #110 Unicode Version 9.0.0
is Uni.new(0xA, 0x1).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #111 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0x1).Str.chars, 3, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #112 Unicode Version 9.0.0
is Uni.new(0xA, 0x300).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #113 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0x300).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #114 Unicode Version 9.0.0
is Uni.new(0xA, 0x600).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #115 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0x600).Str.chars, 3, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #116 Unicode Version 9.0.0
is Uni.new(0xA, 0x903).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #117 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0x903).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #118 Unicode Version 9.0.0
is Uni.new(0xA, 0x1100).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #119 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0x1100).Str.chars, 3, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #120 Unicode Version 9.0.0
is Uni.new(0xA, 0x1160).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #121 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0x1160).Str.chars, 3, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #122 Unicode Version 9.0.0
is Uni.new(0xA, 0x11A8).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #123 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0x11A8).Str.chars, 3, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #124 Unicode Version 9.0.0
is Uni.new(0xA, 0xAC00).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #125 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0xAC00).Str.chars, 3, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #126 Unicode Version 9.0.0
is Uni.new(0xA, 0xAC01).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #127 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0xAC01).Str.chars, 3, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #128 Unicode Version 9.0.0
is Uni.new(0xA, 0x1F1E6).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #129 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0x1F1E6).Str.chars, 3, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #130 Unicode Version 9.0.0
is Uni.new(0xA, 0x261D).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #131 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0x261D).Str.chars, 3, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #132 Unicode Version 9.0.0
is Uni.new(0xA, 0x1F3FB).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #133 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0x1F3FB).Str.chars, 3, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #134 Unicode Version 9.0.0
is Uni.new(0xA, 0x200D).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #135 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0x200D).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #136 Unicode Version 9.0.0
is Uni.new(0xA, 0x2764).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #137 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0x2764).Str.chars, 3, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #138 Unicode Version 9.0.0
is Uni.new(0xA, 0x1F466).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #139 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0x1F466).Str.chars, 3, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #140 Unicode Version 9.0.0
is Uni.new(0xA, 0x378).Str.chars, 2, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #141 Unicode Version 9.0.0
is Uni.new(0xA, 0x308, 0x378).Str.chars, 3, "÷ [0.2] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #144 Unicode Version 9.0.0
is Uni.new(0x1, 0x20).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #145 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0x20).Str.chars, 3, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #146 Unicode Version 9.0.0
is Uni.new(0x1, 0xD).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #147 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0xD).Str.chars, 3, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #148 Unicode Version 9.0.0
is Uni.new(0x1, 0xA).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #149 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0xA).Str.chars, 3, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #150 Unicode Version 9.0.0
is Uni.new(0x1, 0x1).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #151 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0x1).Str.chars, 3, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #152 Unicode Version 9.0.0
is Uni.new(0x1, 0x300).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #153 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0x300).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #154 Unicode Version 9.0.0
is Uni.new(0x1, 0x600).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #155 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0x600).Str.chars, 3, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #156 Unicode Version 9.0.0
is Uni.new(0x1, 0x903).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #157 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0x903).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #158 Unicode Version 9.0.0
is Uni.new(0x1, 0x1100).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #159 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0x1100).Str.chars, 3, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #160 Unicode Version 9.0.0
is Uni.new(0x1, 0x1160).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #161 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0x1160).Str.chars, 3, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #162 Unicode Version 9.0.0
is Uni.new(0x1, 0x11A8).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #163 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0x11A8).Str.chars, 3, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #164 Unicode Version 9.0.0
is Uni.new(0x1, 0xAC00).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #165 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0xAC00).Str.chars, 3, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #166 Unicode Version 9.0.0
is Uni.new(0x1, 0xAC01).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #167 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0xAC01).Str.chars, 3, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #168 Unicode Version 9.0.0
is Uni.new(0x1, 0x1F1E6).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #169 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0x1F1E6).Str.chars, 3, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #170 Unicode Version 9.0.0
is Uni.new(0x1, 0x261D).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #171 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0x261D).Str.chars, 3, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #172 Unicode Version 9.0.0
is Uni.new(0x1, 0x1F3FB).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #173 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0x1F3FB).Str.chars, 3, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #174 Unicode Version 9.0.0
is Uni.new(0x1, 0x200D).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #175 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0x200D).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #176 Unicode Version 9.0.0
is Uni.new(0x1, 0x2764).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #177 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0x2764).Str.chars, 3, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #178 Unicode Version 9.0.0
is Uni.new(0x1, 0x1F466).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #179 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0x1F466).Str.chars, 3, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #180 Unicode Version 9.0.0
is Uni.new(0x1, 0x378).Str.chars, 2, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #181 Unicode Version 9.0.0
is Uni.new(0x1, 0x308, 0x378).Str.chars, 3, "÷ [0.2] <START OF HEADING> (Control) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #184 Unicode Version 9.0.0
is Uni.new(0x300, 0x20).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #185 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0x20).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #186 Unicode Version 9.0.0
is Uni.new(0x300, 0xD).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #187 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0xD).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #188 Unicode Version 9.0.0
is Uni.new(0x300, 0xA).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #189 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0xA).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #190 Unicode Version 9.0.0
is Uni.new(0x300, 0x1).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #191 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0x1).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #192 Unicode Version 9.0.0
is Uni.new(0x300, 0x300).Str.chars, 1, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #193 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0x300).Str.chars, 1, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #194 Unicode Version 9.0.0
is Uni.new(0x300, 0x600).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #195 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0x600).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #196 Unicode Version 9.0.0
is Uni.new(0x300, 0x903).Str.chars, 1, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #197 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0x903).Str.chars, 1, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #198 Unicode Version 9.0.0
is Uni.new(0x300, 0x1100).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #199 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0x1100).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #200 Unicode Version 9.0.0
is Uni.new(0x300, 0x1160).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #201 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0x1160).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #202 Unicode Version 9.0.0
is Uni.new(0x300, 0x11A8).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #203 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0x11A8).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #204 Unicode Version 9.0.0
is Uni.new(0x300, 0xAC00).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #205 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0xAC00).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #206 Unicode Version 9.0.0
is Uni.new(0x300, 0xAC01).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #207 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0xAC01).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #208 Unicode Version 9.0.0
is Uni.new(0x300, 0x1F1E6).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #209 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0x1F1E6).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #210 Unicode Version 9.0.0
is Uni.new(0x300, 0x261D).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #211 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0x261D).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #212 Unicode Version 9.0.0
is Uni.new(0x300, 0x1F3FB).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #213 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0x1F3FB).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #214 Unicode Version 9.0.0
is Uni.new(0x300, 0x200D).Str.chars, 1, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #215 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0x200D).Str.chars, 1, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #216 Unicode Version 9.0.0
is Uni.new(0x300, 0x2764).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #217 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0x2764).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #218 Unicode Version 9.0.0
is Uni.new(0x300, 0x1F466).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #219 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0x1F466).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #220 Unicode Version 9.0.0
is Uni.new(0x300, 0x378).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #221 Unicode Version 9.0.0
is Uni.new(0x300, 0x308, 0x378).Str.chars, 2, "÷ [0.2] COMBINING GRAVE ACCENT (Extend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #224 Unicode Version 9.0.0
#?rakudo.moar todo 'Not all of Unicode 9.0 implemented in MoarVM'
is Uni.new(0x600, 0x20).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #225 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0x20).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #226 Unicode Version 9.0.0
is Uni.new(0x600, 0xD).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #227 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0xD).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #228 Unicode Version 9.0.0
is Uni.new(0x600, 0xA).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #229 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0xA).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #230 Unicode Version 9.0.0
is Uni.new(0x600, 0x1).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #231 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0x1).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #232 Unicode Version 9.0.0
is Uni.new(0x600, 0x300).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #233 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0x300).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #234 Unicode Version 9.0.0
is Uni.new(0x600, 0x600).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #235 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0x600).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #236 Unicode Version 9.0.0
is Uni.new(0x600, 0x903).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #237 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0x903).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #238 Unicode Version 9.0.0
is Uni.new(0x600, 0x1100).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #239 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0x1100).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #240 Unicode Version 9.0.0
is Uni.new(0x600, 0x1160).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #241 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0x1160).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #242 Unicode Version 9.0.0
is Uni.new(0x600, 0x11A8).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #243 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0x11A8).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #244 Unicode Version 9.0.0
is Uni.new(0x600, 0xAC00).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #245 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0xAC00).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #246 Unicode Version 9.0.0
is Uni.new(0x600, 0xAC01).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #247 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0xAC01).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #248 Unicode Version 9.0.0
is Uni.new(0x600, 0x1F1E6).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #249 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0x1F1E6).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #250 Unicode Version 9.0.0
is Uni.new(0x600, 0x261D).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #251 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0x261D).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #252 Unicode Version 9.0.0
is Uni.new(0x600, 0x1F3FB).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #253 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0x1F3FB).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #254 Unicode Version 9.0.0
is Uni.new(0x600, 0x200D).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #255 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0x200D).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #256 Unicode Version 9.0.0
is Uni.new(0x600, 0x2764).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #257 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0x2764).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #258 Unicode Version 9.0.0
is Uni.new(0x600, 0x1F466).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #259 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0x1F466).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #260 Unicode Version 9.0.0
is Uni.new(0x600, 0x378).Str.chars, 1, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.2] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #261 Unicode Version 9.0.0
is Uni.new(0x600, 0x308, 0x378).Str.chars, 2, "÷ [0.2] ARABIC NUMBER SIGN (Prepend) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #264 Unicode Version 9.0.0
is Uni.new(0x903, 0x20).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #265 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0x20).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #266 Unicode Version 9.0.0
is Uni.new(0x903, 0xD).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #267 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0xD).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #268 Unicode Version 9.0.0
is Uni.new(0x903, 0xA).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #269 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0xA).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #270 Unicode Version 9.0.0
is Uni.new(0x903, 0x1).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #271 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0x1).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #272 Unicode Version 9.0.0
is Uni.new(0x903, 0x300).Str.chars, 1, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #273 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0x300).Str.chars, 1, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #274 Unicode Version 9.0.0
is Uni.new(0x903, 0x600).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #275 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0x600).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #276 Unicode Version 9.0.0
is Uni.new(0x903, 0x903).Str.chars, 1, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #277 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0x903).Str.chars, 1, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #278 Unicode Version 9.0.0
is Uni.new(0x903, 0x1100).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #279 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0x1100).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #280 Unicode Version 9.0.0
is Uni.new(0x903, 0x1160).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #281 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0x1160).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #282 Unicode Version 9.0.0
is Uni.new(0x903, 0x11A8).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #283 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0x11A8).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #284 Unicode Version 9.0.0
is Uni.new(0x903, 0xAC00).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #285 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0xAC00).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #286 Unicode Version 9.0.0
is Uni.new(0x903, 0xAC01).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #287 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0xAC01).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #288 Unicode Version 9.0.0
is Uni.new(0x903, 0x1F1E6).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #289 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0x1F1E6).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #290 Unicode Version 9.0.0
is Uni.new(0x903, 0x261D).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #291 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0x261D).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #292 Unicode Version 9.0.0
is Uni.new(0x903, 0x1F3FB).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #293 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0x1F3FB).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #294 Unicode Version 9.0.0
is Uni.new(0x903, 0x200D).Str.chars, 1, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #295 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0x200D).Str.chars, 1, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #296 Unicode Version 9.0.0
is Uni.new(0x903, 0x2764).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #297 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0x2764).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #298 Unicode Version 9.0.0
is Uni.new(0x903, 0x1F466).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #299 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0x1F466).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #300 Unicode Version 9.0.0
is Uni.new(0x903, 0x378).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #301 Unicode Version 9.0.0
is Uni.new(0x903, 0x308, 0x378).Str.chars, 2, "÷ [0.2] DEVANAGARI SIGN VISARGA (SpacingMark) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #304 Unicode Version 9.0.0
is Uni.new(0x1100, 0x20).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #305 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0x20).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #306 Unicode Version 9.0.0
is Uni.new(0x1100, 0xD).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #307 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0xD).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #308 Unicode Version 9.0.0
is Uni.new(0x1100, 0xA).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #309 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0xA).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #310 Unicode Version 9.0.0
is Uni.new(0x1100, 0x1).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #311 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0x1).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #312 Unicode Version 9.0.0
is Uni.new(0x1100, 0x300).Str.chars, 1, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #313 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0x300).Str.chars, 1, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #314 Unicode Version 9.0.0
is Uni.new(0x1100, 0x600).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #315 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0x600).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #316 Unicode Version 9.0.0
is Uni.new(0x1100, 0x903).Str.chars, 1, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #317 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0x903).Str.chars, 1, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [6.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #318 Unicode Version 9.0.0
is Uni.new(0x1100, 0x1100).Str.chars, 1, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [6.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #319 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0x1100).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [6.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #320 Unicode Version 9.0.0
is Uni.new(0x1100, 0x1160).Str.chars, 1, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [6.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #321 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0x1160).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #322 Unicode Version 9.0.0
is Uni.new(0x1100, 0x11A8).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #323 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0x11A8).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [6.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #324 Unicode Version 9.0.0
is Uni.new(0x1100, 0xAC00).Str.chars, 1, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [6.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #325 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0xAC00).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [6.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #326 Unicode Version 9.0.0
is Uni.new(0x1100, 0xAC01).Str.chars, 1, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [6.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #327 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0xAC01).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #328 Unicode Version 9.0.0
is Uni.new(0x1100, 0x1F1E6).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #329 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0x1F1E6).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #330 Unicode Version 9.0.0
is Uni.new(0x1100, 0x261D).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #331 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0x261D).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #332 Unicode Version 9.0.0
is Uni.new(0x1100, 0x1F3FB).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #333 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0x1F3FB).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #334 Unicode Version 9.0.0
is Uni.new(0x1100, 0x200D).Str.chars, 1, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #335 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0x200D).Str.chars, 1, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #336 Unicode Version 9.0.0
is Uni.new(0x1100, 0x2764).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #337 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0x2764).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #338 Unicode Version 9.0.0
is Uni.new(0x1100, 0x1F466).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #339 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0x1F466).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #340 Unicode Version 9.0.0
is Uni.new(0x1100, 0x378).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #341 Unicode Version 9.0.0
is Uni.new(0x1100, 0x308, 0x378).Str.chars, 2, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #344 Unicode Version 9.0.0
is Uni.new(0x1160, 0x20).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #345 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0x20).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #346 Unicode Version 9.0.0
is Uni.new(0x1160, 0xD).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #347 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0xD).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #348 Unicode Version 9.0.0
is Uni.new(0x1160, 0xA).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #349 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0xA).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #350 Unicode Version 9.0.0
is Uni.new(0x1160, 0x1).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #351 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0x1).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #352 Unicode Version 9.0.0
is Uni.new(0x1160, 0x300).Str.chars, 1, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #353 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0x300).Str.chars, 1, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #354 Unicode Version 9.0.0
is Uni.new(0x1160, 0x600).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #355 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0x600).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #356 Unicode Version 9.0.0
is Uni.new(0x1160, 0x903).Str.chars, 1, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #357 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0x903).Str.chars, 1, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #358 Unicode Version 9.0.0
is Uni.new(0x1160, 0x1100).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #359 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0x1100).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [7.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #360 Unicode Version 9.0.0
is Uni.new(0x1160, 0x1160).Str.chars, 1, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [7.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #361 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0x1160).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [7.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #362 Unicode Version 9.0.0
is Uni.new(0x1160, 0x11A8).Str.chars, 1, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [7.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #363 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0x11A8).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #364 Unicode Version 9.0.0
is Uni.new(0x1160, 0xAC00).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #365 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0xAC00).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #366 Unicode Version 9.0.0
is Uni.new(0x1160, 0xAC01).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #367 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0xAC01).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #368 Unicode Version 9.0.0
is Uni.new(0x1160, 0x1F1E6).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #369 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0x1F1E6).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #370 Unicode Version 9.0.0
is Uni.new(0x1160, 0x261D).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #371 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0x261D).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #372 Unicode Version 9.0.0
is Uni.new(0x1160, 0x1F3FB).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #373 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0x1F3FB).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #374 Unicode Version 9.0.0
is Uni.new(0x1160, 0x200D).Str.chars, 1, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #375 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0x200D).Str.chars, 1, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #376 Unicode Version 9.0.0
is Uni.new(0x1160, 0x2764).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #377 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0x2764).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #378 Unicode Version 9.0.0
is Uni.new(0x1160, 0x1F466).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #379 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0x1F466).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #380 Unicode Version 9.0.0
is Uni.new(0x1160, 0x378).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #381 Unicode Version 9.0.0
is Uni.new(0x1160, 0x308, 0x378).Str.chars, 2, "÷ [0.2] HANGUL JUNGSEONG FILLER (V) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #384 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x20).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #385 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0x20).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #386 Unicode Version 9.0.0
is Uni.new(0x11A8, 0xD).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #387 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0xD).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #388 Unicode Version 9.0.0
is Uni.new(0x11A8, 0xA).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #389 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0xA).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #390 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x1).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #391 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0x1).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #392 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x300).Str.chars, 1, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #393 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0x300).Str.chars, 1, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #394 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x600).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #395 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0x600).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #396 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x903).Str.chars, 1, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #397 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0x903).Str.chars, 1, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #398 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x1100).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #399 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0x1100).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #400 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x1160).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #401 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0x1160).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [8.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #402 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x11A8).Str.chars, 1, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [8.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #403 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0x11A8).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #404 Unicode Version 9.0.0
is Uni.new(0x11A8, 0xAC00).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #405 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0xAC00).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #406 Unicode Version 9.0.0
is Uni.new(0x11A8, 0xAC01).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #407 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0xAC01).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #408 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x1F1E6).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #409 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0x1F1E6).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #410 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x261D).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #411 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0x261D).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #412 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x1F3FB).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #413 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0x1F3FB).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #414 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x200D).Str.chars, 1, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #415 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0x200D).Str.chars, 1, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #416 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x2764).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #417 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0x2764).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #418 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x1F466).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #419 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0x1F466).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #420 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x378).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #421 Unicode Version 9.0.0
is Uni.new(0x11A8, 0x308, 0x378).Str.chars, 2, "÷ [0.2] HANGUL JONGSEONG KIYEOK (T) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #424 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x20).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #425 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0x20).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #426 Unicode Version 9.0.0
is Uni.new(0xAC00, 0xD).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #427 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0xD).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #428 Unicode Version 9.0.0
is Uni.new(0xAC00, 0xA).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #429 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0xA).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #430 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x1).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #431 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0x1).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #432 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x300).Str.chars, 1, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #433 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0x300).Str.chars, 1, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #434 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x600).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #435 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0x600).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #436 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x903).Str.chars, 1, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #437 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0x903).Str.chars, 1, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #438 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x1100).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #439 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0x1100).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [7.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #440 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x1160).Str.chars, 1, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [7.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #441 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0x1160).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [7.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #442 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x11A8).Str.chars, 1, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [7.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #443 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0x11A8).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #444 Unicode Version 9.0.0
is Uni.new(0xAC00, 0xAC00).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #445 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0xAC00).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #446 Unicode Version 9.0.0
is Uni.new(0xAC00, 0xAC01).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #447 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0xAC01).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #448 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x1F1E6).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #449 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0x1F1E6).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #450 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x261D).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #451 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0x261D).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #452 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x1F3FB).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #453 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0x1F3FB).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #454 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x200D).Str.chars, 1, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #455 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0x200D).Str.chars, 1, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #456 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x2764).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #457 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0x2764).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #458 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x1F466).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #459 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0x1F466).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #460 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x378).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #461 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x308, 0x378).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #464 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x20).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #465 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0x20).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #466 Unicode Version 9.0.0
is Uni.new(0xAC01, 0xD).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #467 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0xD).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #468 Unicode Version 9.0.0
is Uni.new(0xAC01, 0xA).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #469 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0xA).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #470 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x1).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #471 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0x1).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #472 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x300).Str.chars, 1, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #473 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0x300).Str.chars, 1, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #474 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x600).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #475 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0x600).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #476 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x903).Str.chars, 1, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #477 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0x903).Str.chars, 1, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #478 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x1100).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #479 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0x1100).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #480 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x1160).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #481 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0x1160).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [8.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #482 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x11A8).Str.chars, 1, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [8.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #483 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0x11A8).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #484 Unicode Version 9.0.0
is Uni.new(0xAC01, 0xAC00).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #485 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0xAC00).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #486 Unicode Version 9.0.0
is Uni.new(0xAC01, 0xAC01).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #487 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0xAC01).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #488 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x1F1E6).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #489 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0x1F1E6).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #490 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x261D).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #491 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0x261D).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #492 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x1F3FB).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #493 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0x1F3FB).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #494 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x200D).Str.chars, 1, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #495 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0x200D).Str.chars, 1, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #496 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x2764).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #497 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0x2764).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #498 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x1F466).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #499 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0x1F466).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #500 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x378).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #501 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x308, 0x378).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #504 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x20).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #505 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0x20).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #506 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0xD).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #507 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0xD).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #508 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0xA).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #509 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0xA).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #510 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x1).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #511 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0x1).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #512 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x300).Str.chars, 1, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #513 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0x300).Str.chars, 1, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #514 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x600).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #515 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0x600).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #516 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x903).Str.chars, 1, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #517 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0x903).Str.chars, 1, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #518 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x1100).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #519 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0x1100).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #520 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x1160).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #521 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0x1160).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #522 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x11A8).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #523 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0x11A8).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #524 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0xAC00).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #525 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0xAC00).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #526 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0xAC01).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #527 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0xAC01).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [12.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #528 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x1F1E6).Str.chars, 1, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [12.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #529 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0x1F1E6).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #530 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x261D).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #531 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0x261D).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #532 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x1F3FB).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #533 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0x1F3FB).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #534 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x200D).Str.chars, 1, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #535 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0x200D).Str.chars, 1, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #536 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x2764).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #537 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0x2764).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #538 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x1F466).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #539 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0x1F466).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #540 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x378).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #541 Unicode Version 9.0.0
is Uni.new(0x1F1E6, 0x308, 0x378).Str.chars, 2, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #544 Unicode Version 9.0.0
is Uni.new(0x261D, 0x20).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #545 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0x20).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #546 Unicode Version 9.0.0
is Uni.new(0x261D, 0xD).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #547 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0xD).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #548 Unicode Version 9.0.0
is Uni.new(0x261D, 0xA).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #549 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0xA).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #550 Unicode Version 9.0.0
is Uni.new(0x261D, 0x1).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #551 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0x1).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #552 Unicode Version 9.0.0
is Uni.new(0x261D, 0x300).Str.chars, 1, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #553 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0x300).Str.chars, 1, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #554 Unicode Version 9.0.0
is Uni.new(0x261D, 0x600).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #555 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0x600).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #556 Unicode Version 9.0.0
is Uni.new(0x261D, 0x903).Str.chars, 1, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #557 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0x903).Str.chars, 1, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #558 Unicode Version 9.0.0
is Uni.new(0x261D, 0x1100).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #559 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0x1100).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #560 Unicode Version 9.0.0
is Uni.new(0x261D, 0x1160).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #561 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0x1160).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #562 Unicode Version 9.0.0
is Uni.new(0x261D, 0x11A8).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #563 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0x11A8).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #564 Unicode Version 9.0.0
is Uni.new(0x261D, 0xAC00).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #565 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0xAC00).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #566 Unicode Version 9.0.0
is Uni.new(0x261D, 0xAC01).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #567 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0xAC01).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #568 Unicode Version 9.0.0
is Uni.new(0x261D, 0x1F1E6).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #569 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0x1F1E6).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #570 Unicode Version 9.0.0
is Uni.new(0x261D, 0x261D).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #571 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0x261D).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [10.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #572 Unicode Version 9.0.0
is Uni.new(0x261D, 0x1F3FB).Str.chars, 1, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [10.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) × [10.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #573 Unicode Version 9.0.0
#?rakudo.moar todo 'Not all of Unicode 9.0 implemented in MoarVM'
is Uni.new(0x261D, 0x308, 0x1F3FB).Str.chars, 1, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) × [10.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #574 Unicode Version 9.0.0
is Uni.new(0x261D, 0x200D).Str.chars, 1, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #575 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0x200D).Str.chars, 1, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #576 Unicode Version 9.0.0
is Uni.new(0x261D, 0x2764).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #577 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0x2764).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #578 Unicode Version 9.0.0
is Uni.new(0x261D, 0x1F466).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #579 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0x1F466).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #580 Unicode Version 9.0.0
is Uni.new(0x261D, 0x378).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #581 Unicode Version 9.0.0
is Uni.new(0x261D, 0x308, 0x378).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #584 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x20).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #585 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0x20).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #586 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0xD).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #587 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0xD).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #588 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0xA).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #589 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0xA).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #590 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x1).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #591 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0x1).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #592 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x300).Str.chars, 1, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #593 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0x300).Str.chars, 1, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #594 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x600).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #595 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0x600).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #596 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x903).Str.chars, 1, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #597 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0x903).Str.chars, 1, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #598 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x1100).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #599 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0x1100).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #600 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x1160).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #601 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0x1160).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #602 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x11A8).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #603 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0x11A8).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #604 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0xAC00).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #605 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0xAC00).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #606 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0xAC01).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #607 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0xAC01).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #608 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x1F1E6).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #609 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0x1F1E6).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #610 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x261D).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #611 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0x261D).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #612 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x1F3FB).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #613 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0x1F3FB).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #614 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x200D).Str.chars, 1, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #615 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0x200D).Str.chars, 1, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #616 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x2764).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #617 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0x2764).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #618 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x1F466).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #619 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0x1F466).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #620 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x378).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #621 Unicode Version 9.0.0
is Uni.new(0x1F3FB, 0x308, 0x378).Str.chars, 2, "÷ [0.2] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #624 Unicode Version 9.0.0
is Uni.new(0x200D, 0x20).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #625 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0x20).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #626 Unicode Version 9.0.0
is Uni.new(0x200D, 0xD).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #627 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0xD).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #628 Unicode Version 9.0.0
is Uni.new(0x200D, 0xA).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #629 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0xA).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #630 Unicode Version 9.0.0
is Uni.new(0x200D, 0x1).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #631 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0x1).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #632 Unicode Version 9.0.0
is Uni.new(0x200D, 0x300).Str.chars, 1, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #633 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0x300).Str.chars, 1, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #634 Unicode Version 9.0.0
is Uni.new(0x200D, 0x600).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #635 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0x600).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #636 Unicode Version 9.0.0
is Uni.new(0x200D, 0x903).Str.chars, 1, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #637 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0x903).Str.chars, 1, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #638 Unicode Version 9.0.0
is Uni.new(0x200D, 0x1100).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #639 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0x1100).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #640 Unicode Version 9.0.0
is Uni.new(0x200D, 0x1160).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #641 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0x1160).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #642 Unicode Version 9.0.0
is Uni.new(0x200D, 0x11A8).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #643 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0x11A8).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #644 Unicode Version 9.0.0
is Uni.new(0x200D, 0xAC00).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #645 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0xAC00).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #646 Unicode Version 9.0.0
is Uni.new(0x200D, 0xAC01).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #647 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0xAC01).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #648 Unicode Version 9.0.0
is Uni.new(0x200D, 0x1F1E6).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #649 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0x1F1E6).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #650 Unicode Version 9.0.0
is Uni.new(0x200D, 0x261D).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #651 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0x261D).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #652 Unicode Version 9.0.0
is Uni.new(0x200D, 0x1F3FB).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #653 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0x1F3FB).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #654 Unicode Version 9.0.0
is Uni.new(0x200D, 0x200D).Str.chars, 1, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #655 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0x200D).Str.chars, 1, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [11.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #656 Unicode Version 9.0.0
is Uni.new(0x200D, 0x2764).Str.chars, 1, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [11.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #657 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0x2764).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [11.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #658 Unicode Version 9.0.0
is Uni.new(0x200D, 0x1F466).Str.chars, 1, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [11.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #659 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0x1F466).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #660 Unicode Version 9.0.0
is Uni.new(0x200D, 0x378).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #661 Unicode Version 9.0.0
is Uni.new(0x200D, 0x308, 0x378).Str.chars, 2, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #664 Unicode Version 9.0.0
is Uni.new(0x2764, 0x20).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #665 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0x20).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #666 Unicode Version 9.0.0
is Uni.new(0x2764, 0xD).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #667 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0xD).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #668 Unicode Version 9.0.0
is Uni.new(0x2764, 0xA).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #669 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0xA).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #670 Unicode Version 9.0.0
is Uni.new(0x2764, 0x1).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #671 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0x1).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #672 Unicode Version 9.0.0
is Uni.new(0x2764, 0x300).Str.chars, 1, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #673 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0x300).Str.chars, 1, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #674 Unicode Version 9.0.0
is Uni.new(0x2764, 0x600).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #675 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0x600).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #676 Unicode Version 9.0.0
is Uni.new(0x2764, 0x903).Str.chars, 1, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #677 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0x903).Str.chars, 1, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #678 Unicode Version 9.0.0
is Uni.new(0x2764, 0x1100).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #679 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0x1100).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #680 Unicode Version 9.0.0
is Uni.new(0x2764, 0x1160).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #681 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0x1160).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #682 Unicode Version 9.0.0
is Uni.new(0x2764, 0x11A8).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #683 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0x11A8).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #684 Unicode Version 9.0.0
is Uni.new(0x2764, 0xAC00).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #685 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0xAC00).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #686 Unicode Version 9.0.0
is Uni.new(0x2764, 0xAC01).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #687 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0xAC01).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #688 Unicode Version 9.0.0
is Uni.new(0x2764, 0x1F1E6).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #689 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0x1F1E6).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #690 Unicode Version 9.0.0
is Uni.new(0x2764, 0x261D).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #691 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0x261D).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #692 Unicode Version 9.0.0
is Uni.new(0x2764, 0x1F3FB).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #693 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0x1F3FB).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #694 Unicode Version 9.0.0
is Uni.new(0x2764, 0x200D).Str.chars, 1, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #695 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0x200D).Str.chars, 1, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #696 Unicode Version 9.0.0
is Uni.new(0x2764, 0x2764).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #697 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0x2764).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #698 Unicode Version 9.0.0
is Uni.new(0x2764, 0x1F466).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #699 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0x1F466).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #700 Unicode Version 9.0.0
is Uni.new(0x2764, 0x378).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #701 Unicode Version 9.0.0
is Uni.new(0x2764, 0x308, 0x378).Str.chars, 2, "÷ [0.2] HEAVY BLACK HEART (Glue_After_Zwj) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] BOY (EBG) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #704 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x20).Str.chars, 2, "÷ [0.2] BOY (EBG) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #705 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0x20).Str.chars, 2, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] BOY (EBG) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #706 Unicode Version 9.0.0
is Uni.new(0x1F466, 0xD).Str.chars, 2, "÷ [0.2] BOY (EBG) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #707 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0xD).Str.chars, 2, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] BOY (EBG) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #708 Unicode Version 9.0.0
is Uni.new(0x1F466, 0xA).Str.chars, 2, "÷ [0.2] BOY (EBG) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #709 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0xA).Str.chars, 2, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] BOY (EBG) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #710 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x1).Str.chars, 2, "÷ [0.2] BOY (EBG) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #711 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0x1).Str.chars, 2, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #712 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x300).Str.chars, 1, "÷ [0.2] BOY (EBG) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #713 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0x300).Str.chars, 1, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] BOY (EBG) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #714 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x600).Str.chars, 2, "÷ [0.2] BOY (EBG) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #715 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0x600).Str.chars, 2, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] BOY (EBG) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #716 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x903).Str.chars, 1, "÷ [0.2] BOY (EBG) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #717 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0x903).Str.chars, 1, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] BOY (EBG) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #718 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x1100).Str.chars, 2, "÷ [0.2] BOY (EBG) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #719 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0x1100).Str.chars, 2, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] BOY (EBG) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #720 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x1160).Str.chars, 2, "÷ [0.2] BOY (EBG) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #721 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0x1160).Str.chars, 2, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] BOY (EBG) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #722 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x11A8).Str.chars, 2, "÷ [0.2] BOY (EBG) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #723 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0x11A8).Str.chars, 2, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] BOY (EBG) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #724 Unicode Version 9.0.0
is Uni.new(0x1F466, 0xAC00).Str.chars, 2, "÷ [0.2] BOY (EBG) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #725 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0xAC00).Str.chars, 2, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] BOY (EBG) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #726 Unicode Version 9.0.0
is Uni.new(0x1F466, 0xAC01).Str.chars, 2, "÷ [0.2] BOY (EBG) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #727 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0xAC01).Str.chars, 2, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] BOY (EBG) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #728 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x1F1E6).Str.chars, 2, "÷ [0.2] BOY (EBG) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #729 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0x1F1E6).Str.chars, 2, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] BOY (EBG) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #730 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x261D).Str.chars, 2, "÷ [0.2] BOY (EBG) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #731 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0x261D).Str.chars, 2, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] BOY (EBG) × [10.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #732 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x1F3FB).Str.chars, 1, "÷ [0.2] BOY (EBG) × [10.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) × [10.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #733 Unicode Version 9.0.0
#?rakudo.moar todo 'Not all of Unicode 9.0 implemented in MoarVM'
is Uni.new(0x1F466, 0x308, 0x1F3FB).Str.chars, 1, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) × [10.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] BOY (EBG) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #734 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x200D).Str.chars, 1, "÷ [0.2] BOY (EBG) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #735 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0x200D).Str.chars, 1, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] BOY (EBG) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #736 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x2764).Str.chars, 2, "÷ [0.2] BOY (EBG) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #737 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0x2764).Str.chars, 2, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] BOY (EBG) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #738 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x1F466).Str.chars, 2, "÷ [0.2] BOY (EBG) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #739 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0x1F466).Str.chars, 2, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] BOY (EBG) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #740 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x378).Str.chars, 2, "÷ [0.2] BOY (EBG) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #741 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x308, 0x378).Str.chars, 2, "÷ [0.2] BOY (EBG) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #744 Unicode Version 9.0.0
is Uni.new(0x378, 0x20).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #745 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0x20).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #746 Unicode Version 9.0.0
is Uni.new(0x378, 0xD).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] # GraphemeBreakTest.txt line #747 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0xD).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <CARRIAGE RETURN (CR)> (CR) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #748 Unicode Version 9.0.0
is Uni.new(0x378, 0xA).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] # GraphemeBreakTest.txt line #749 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0xA).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #750 Unicode Version 9.0.0
is Uni.new(0x378, 0x1).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] # GraphemeBreakTest.txt line #751 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0x1).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [5.0] <START OF HEADING> (Control) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #752 Unicode Version 9.0.0
is Uni.new(0x378, 0x300).Str.chars, 1, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #753 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0x300).Str.chars, 1, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] COMBINING GRAVE ACCENT (Extend) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] <reserved-0378> (Other) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #754 Unicode Version 9.0.0
is Uni.new(0x378, 0x600).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] # GraphemeBreakTest.txt line #755 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0x600).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #756 Unicode Version 9.0.0
is Uni.new(0x378, 0x903).Str.chars, 1, "÷ [0.2] <reserved-0378> (Other) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] # GraphemeBreakTest.txt line #757 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0x903).Str.chars, 1, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #758 Unicode Version 9.0.0
is Uni.new(0x378, 0x1100).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #759 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0x1100).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #760 Unicode Version 9.0.0
is Uni.new(0x378, 0x1160).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] # GraphemeBreakTest.txt line #761 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0x1160).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JUNGSEONG FILLER (V) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #762 Unicode Version 9.0.0
is Uni.new(0x378, 0x11A8).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] # GraphemeBreakTest.txt line #763 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0x11A8).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL JONGSEONG KIYEOK (T) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #764 Unicode Version 9.0.0
is Uni.new(0x378, 0xAC00).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] # GraphemeBreakTest.txt line #765 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0xAC00).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GA (LV) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #766 Unicode Version 9.0.0
is Uni.new(0x378, 0xAC01).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] # GraphemeBreakTest.txt line #767 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0xAC01).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HANGUL SYLLABLE GAG (LVT) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #768 Unicode Version 9.0.0
is Uni.new(0x378, 0x1F1E6).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] # GraphemeBreakTest.txt line #769 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0x1F1E6).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #770 Unicode Version 9.0.0
is Uni.new(0x378, 0x261D).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #771 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0x261D).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #772 Unicode Version 9.0.0
is Uni.new(0x378, 0x1F3FB).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #773 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0x1F3FB).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #774 Unicode Version 9.0.0
is Uni.new(0x378, 0x200D).Str.chars, 1, "÷ [0.2] <reserved-0378> (Other) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #775 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0x200D).Str.chars, 1, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #776 Unicode Version 9.0.0
is Uni.new(0x378, 0x2764).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #777 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0x2764).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #778 Unicode Version 9.0.0
is Uni.new(0x378, 0x1F466).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #779 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0x1F466).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <reserved-0378> (Other) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #780 Unicode Version 9.0.0
is Uni.new(0x378, 0x378).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 2 Non-break: 0";
## ÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] # GraphemeBreakTest.txt line #781 Unicode Version 9.0.0
is Uni.new(0x378, 0x308, 0x378).Str.chars, 2, "÷ [0.2] <reserved-0378> (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] <reserved-0378> (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] <CARRIAGE RETURN (CR)> (CR) × [3.0] <LINE FEED (LF)> (LF) ÷ [4.0] LATIN SMALL LETTER A (Other) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #824 Unicode Version 9.0.0
is Uni.new(0xD, 0xA, 0x61, 0xA, 0x308).Str.chars, 4, "÷ [0.2] <CARRIAGE RETURN (CR)> (CR) × [3.0] <LINE FEED (LF)> (LF) ÷ [4.0] LATIN SMALL LETTER A (Other) ÷ [5.0] <LINE FEED (LF)> (LF) ÷ [4.0] COMBINING DIAERESIS (Extend) ÷ [0.3] | Codes: 5 Non-break: 1";
## ÷ [0.2] LATIN SMALL LETTER A (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [0.3] # GraphemeBreakTest.txt line #825 Unicode Version 9.0.0
is Uni.new(0x61, 0x308).Str.chars, 1, "÷ [0.2] LATIN SMALL LETTER A (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] SPACE (Other) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] ARABIC LETTER NOON (Other) ÷ [0.3] # GraphemeBreakTest.txt line #826 Unicode Version 9.0.0
is Uni.new(0x20, 0x200D, 0x646).Str.chars, 2, "÷ [0.2] SPACE (Other) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] ARABIC LETTER NOON (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] ARABIC LETTER NOON (Other) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] SPACE (Other) ÷ [0.3] # GraphemeBreakTest.txt line #827 Unicode Version 9.0.0
is Uni.new(0x646, 0x200D, 0x20).Str.chars, 2, "÷ [0.2] ARABIC LETTER NOON (Other) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] SPACE (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [6.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #828 Unicode Version 9.0.0
is Uni.new(0x1100, 0x1100).Str.chars, 1, "÷ [0.2] HANGUL CHOSEONG KIYEOK (L) × [6.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GA (LV) × [7.0] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #829 Unicode Version 9.0.0
is Uni.new(0xAC00, 0x11A8, 0x1100).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GA (LV) × [7.0] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [8.0] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] # GraphemeBreakTest.txt line #830 Unicode Version 9.0.0
is Uni.new(0xAC01, 0x11A8, 0x1100).Str.chars, 2, "÷ [0.2] HANGUL SYLLABLE GAG (LVT) × [8.0] HANGUL JONGSEONG KIYEOK (T) ÷ [999.0] HANGUL CHOSEONG KIYEOK (L) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [12.0] REGIONAL INDICATOR SYMBOL LETTER B (RI) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER C (RI) ÷ [999.0] LATIN SMALL LETTER B (Other) ÷ [0.3] # GraphemeBreakTest.txt line #831 Unicode Version 9.0.0
#?rakudo.moar todo 'Not all of Unicode 9.0 implemented in MoarVM'
is Uni.new(0x1F1E6, 0x1F1E7, 0x1F1E8, 0x62).Str.chars, 3, "÷ [0.2] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [12.0] REGIONAL INDICATOR SYMBOL LETTER B (RI) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER C (RI) ÷ [999.0] LATIN SMALL LETTER B (Other) ÷ [0.3] | Codes: 4 Non-break: 1";
## ÷ [0.2] LATIN SMALL LETTER A (Other) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [13.0] REGIONAL INDICATOR SYMBOL LETTER B (RI) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER C (RI) ÷ [999.0] LATIN SMALL LETTER B (Other) ÷ [0.3] # GraphemeBreakTest.txt line #832 Unicode Version 9.0.0
#?rakudo.moar todo 'Not all of Unicode 9.0 implemented in MoarVM'
is Uni.new(0x61, 0x1F1E6, 0x1F1E7, 0x1F1E8, 0x62).Str.chars, 4, "÷ [0.2] LATIN SMALL LETTER A (Other) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [13.0] REGIONAL INDICATOR SYMBOL LETTER B (RI) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER C (RI) ÷ [999.0] LATIN SMALL LETTER B (Other) ÷ [0.3] | Codes: 5 Non-break: 1";
## ÷ [0.2] LATIN SMALL LETTER A (Other) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [13.0] REGIONAL INDICATOR SYMBOL LETTER B (RI) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER C (RI) ÷ [999.0] LATIN SMALL LETTER B (Other) ÷ [0.3] # GraphemeBreakTest.txt line #833 Unicode Version 9.0.0
is Uni.new(0x61, 0x1F1E6, 0x1F1E7, 0x200D, 0x1F1E8, 0x62).Str.chars, 4, "÷ [0.2] LATIN SMALL LETTER A (Other) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [13.0] REGIONAL INDICATOR SYMBOL LETTER B (RI) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER C (RI) ÷ [999.0] LATIN SMALL LETTER B (Other) ÷ [0.3] | Codes: 6 Non-break: 2";
## ÷ [0.2] LATIN SMALL LETTER A (Other) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER B (RI) × [13.0] REGIONAL INDICATOR SYMBOL LETTER C (RI) ÷ [999.0] LATIN SMALL LETTER B (Other) ÷ [0.3] # GraphemeBreakTest.txt line #834 Unicode Version 9.0.0
is Uni.new(0x61, 0x1F1E6, 0x200D, 0x1F1E7, 0x1F1E8, 0x62).Str.chars, 4, "÷ [0.2] LATIN SMALL LETTER A (Other) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER B (RI) × [13.0] REGIONAL INDICATOR SYMBOL LETTER C (RI) ÷ [999.0] LATIN SMALL LETTER B (Other) ÷ [0.3] | Codes: 6 Non-break: 2";
## ÷ [0.2] LATIN SMALL LETTER A (Other) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [13.0] REGIONAL INDICATOR SYMBOL LETTER B (RI) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER C (RI) × [13.0] REGIONAL INDICATOR SYMBOL LETTER D (RI) ÷ [999.0] LATIN SMALL LETTER B (Other) ÷ [0.3] # GraphemeBreakTest.txt line #835 Unicode Version 9.0.0
#?rakudo.moar todo 'Not all of Unicode 9.0 implemented in MoarVM'
is Uni.new(0x61, 0x1F1E6, 0x1F1E7, 0x1F1E8, 0x1F1E9, 0x62).Str.chars, 4, "÷ [0.2] LATIN SMALL LETTER A (Other) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER A (RI) × [13.0] REGIONAL INDICATOR SYMBOL LETTER B (RI) ÷ [999.0] REGIONAL INDICATOR SYMBOL LETTER C (RI) × [13.0] REGIONAL INDICATOR SYMBOL LETTER D (RI) ÷ [999.0] LATIN SMALL LETTER B (Other) ÷ [0.3] | Codes: 6 Non-break: 2";
## ÷ [0.2] LATIN SMALL LETTER A (Other) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] # GraphemeBreakTest.txt line #836 Unicode Version 9.0.0
is Uni.new(0x61, 0x200D).Str.chars, 1, "÷ [0.2] LATIN SMALL LETTER A (Other) × [9.0] ZERO WIDTH JOINER (ZWJ) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] LATIN SMALL LETTER A (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] LATIN SMALL LETTER B (Other) ÷ [0.3] # GraphemeBreakTest.txt line #837 Unicode Version 9.0.0
is Uni.new(0x61, 0x308, 0x62).Str.chars, 2, "÷ [0.2] LATIN SMALL LETTER A (Other) × [9.0] COMBINING DIAERESIS (Extend) ÷ [999.0] LATIN SMALL LETTER B (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] LATIN SMALL LETTER A (Other) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] LATIN SMALL LETTER B (Other) ÷ [0.3] # GraphemeBreakTest.txt line #838 Unicode Version 9.0.0
is Uni.new(0x61, 0x903, 0x62).Str.chars, 2, "÷ [0.2] LATIN SMALL LETTER A (Other) × [9.1] DEVANAGARI SIGN VISARGA (SpacingMark) ÷ [999.0] LATIN SMALL LETTER B (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] LATIN SMALL LETTER A (Other) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) × [9.2] LATIN SMALL LETTER B (Other) ÷ [0.3] # GraphemeBreakTest.txt line #839 Unicode Version 9.0.0
#?rakudo.moar todo 'Not all of Unicode 9.0 implemented in MoarVM'
is Uni.new(0x61, 0x600, 0x62).Str.chars, 2, "÷ [0.2] LATIN SMALL LETTER A (Other) ÷ [999.0] ARABIC NUMBER SIGN (Prepend) × [9.2] LATIN SMALL LETTER B (Other) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [10.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] # GraphemeBreakTest.txt line #840 Unicode Version 9.0.0
is Uni.new(0x261D, 0x1F3FB, 0x261D).Str.chars, 2, "÷ [0.2] WHITE UP POINTING INDEX (E_Base) × [10.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [999.0] WHITE UP POINTING INDEX (E_Base) ÷ [0.3] | Codes: 3 Non-break: 1";
## ÷ [0.2] BOY (EBG) × [10.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #841 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x1F3FB).Str.chars, 1, "÷ [0.2] BOY (EBG) × [10.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [11.0] BOY (EBG) × [10.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] # GraphemeBreakTest.txt line #842 Unicode Version 9.0.0
is Uni.new(0x200D, 0x1F466, 0x1F3FB).Str.chars, 1, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [11.0] BOY (EBG) × [10.0] EMOJI MODIFIER FITZPATRICK TYPE-1-2 (E_Modifier) ÷ [0.3] | Codes: 3 Non-break: 2";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [11.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] # GraphemeBreakTest.txt line #843 Unicode Version 9.0.0
is Uni.new(0x200D, 0x2764).Str.chars, 1, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [11.0] HEAVY BLACK HEART (Glue_After_Zwj) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [11.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #844 Unicode Version 9.0.0
is Uni.new(0x200D, 0x1F466).Str.chars, 1, "÷ [0.2] ZERO WIDTH JOINER (ZWJ) × [11.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 1";
## ÷ [0.2] BOY (EBG) ÷ [999.0] BOY (EBG) ÷ [0.3] # GraphemeBreakTest.txt line #845 Unicode Version 9.0.0
is Uni.new(0x1F466, 0x1F466).Str.chars, 2, "÷ [0.2] BOY (EBG) ÷ [999.0] BOY (EBG) ÷ [0.3] | Codes: 2 Non-break: 0";
