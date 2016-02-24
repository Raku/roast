use v6.c;
# Normal Form Grapheme roundtrip tests, generated from NormalizationTests.txt in
# the Unicode database by S15-nfg/test-gen.p6. Check we can take a Uni, turn it
# into an NFG string, and then get codepoints back out of it in NFKD.

use Test;

plan 100;

ok Uni.new(0x1E0A, 0x0323).Str.NFKD.list ~~ (0x0044, 0x0323, 0x0307,), '1E0A 0323 -> Str -> 0044 0323 0307';
ok Uni.new(0x1E0C, 0x0307).Str.NFKD.list ~~ (0x0044, 0x0323, 0x0307,), '1E0C 0307 -> Str -> 0044 0323 0307';
ok Uni.new(0x0044, 0x0307, 0x0323).Str.NFKD.list ~~ (0x0044, 0x0323, 0x0307,), '0044 0307 0323 -> Str -> 0044 0323 0307';
ok Uni.new(0x1E0A, 0x031B).Str.NFKD.list ~~ (0x0044, 0x031B, 0x0307,), '1E0A 031B -> Str -> 0044 031B 0307';
ok Uni.new(0x1E0C, 0x031B).Str.NFKD.list ~~ (0x0044, 0x031B, 0x0323,), '1E0C 031B -> Str -> 0044 031B 0323';
ok Uni.new(0x1E0A, 0x031B, 0x0323).Str.NFKD.list ~~ (0x0044, 0x031B, 0x0323, 0x0307,), '1E0A 031B 0323 -> Str -> 0044 031B 0323 0307';
ok Uni.new(0x1E0C, 0x031B, 0x0307).Str.NFKD.list ~~ (0x0044, 0x031B, 0x0323, 0x0307,), '1E0C 031B 0307 -> Str -> 0044 031B 0323 0307';
ok Uni.new(0x0044, 0x031B, 0x0307, 0x0323).Str.NFKD.list ~~ (0x0044, 0x031B, 0x0323, 0x0307,), '0044 031B 0307 0323 -> Str -> 0044 031B 0323 0307';
ok Uni.new(0x1E14, 0x0304).Str.NFKD.list ~~ (0x0045, 0x0304, 0x0300, 0x0304,), '1E14 0304 -> Str -> 0045 0304 0300 0304';
ok Uni.new(0x05B8, 0x05B9, 0x05B1, 0x0591, 0x05C3, 0x05B0, 0x05AC, 0x059F).Str.NFKD.list ~~ (0x05B1, 0x05B8, 0x05B9, 0x0591, 0x05C3, 0x05B0, 0x05AC, 0x059F,), '05B8 05B9 05B1 0591 05C3 05B0 05AC 059F -> Str -> 05B1 05B8 05B9 0591 05C3 05B0 05AC 059F';
ok Uni.new(0x0592, 0x05B7, 0x05BC, 0x05A5, 0x05B0, 0x05C0, 0x05C4, 0x05AD).Str.NFKD.list ~~ (0x05B0, 0x05B7, 0x05BC, 0x05A5, 0x0592, 0x05C0, 0x05AD, 0x05C4,), '0592 05B7 05BC 05A5 05B0 05C0 05C4 05AD -> Str -> 05B0 05B7 05BC 05A5 0592 05C0 05AD 05C4';
ok Uni.new(0x0344).Str.NFKD.list ~~ (0x0308, 0x0301,), '0344 -> Str -> 0308 0301';
ok Uni.new(0x0958).Str.NFKD.list ~~ (0x0915, 0x093C,), '0958 -> Str -> 0915 093C';
ok Uni.new(0x0959).Str.NFKD.list ~~ (0x0916, 0x093C,), '0959 -> Str -> 0916 093C';
ok Uni.new(0x095A).Str.NFKD.list ~~ (0x0917, 0x093C,), '095A -> Str -> 0917 093C';
ok Uni.new(0x095B).Str.NFKD.list ~~ (0x091C, 0x093C,), '095B -> Str -> 091C 093C';
ok Uni.new(0x095C).Str.NFKD.list ~~ (0x0921, 0x093C,), '095C -> Str -> 0921 093C';
ok Uni.new(0x095D).Str.NFKD.list ~~ (0x0922, 0x093C,), '095D -> Str -> 0922 093C';
ok Uni.new(0x095E).Str.NFKD.list ~~ (0x092B, 0x093C,), '095E -> Str -> 092B 093C';
ok Uni.new(0x095F).Str.NFKD.list ~~ (0x092F, 0x093C,), '095F -> Str -> 092F 093C';
ok Uni.new(0x09DC).Str.NFKD.list ~~ (0x09A1, 0x09BC,), '09DC -> Str -> 09A1 09BC';
ok Uni.new(0x09DD).Str.NFKD.list ~~ (0x09A2, 0x09BC,), '09DD -> Str -> 09A2 09BC';
ok Uni.new(0x09DF).Str.NFKD.list ~~ (0x09AF, 0x09BC,), '09DF -> Str -> 09AF 09BC';
ok Uni.new(0x0A33).Str.NFKD.list ~~ (0x0A32, 0x0A3C,), '0A33 -> Str -> 0A32 0A3C';
ok Uni.new(0x0A36).Str.NFKD.list ~~ (0x0A38, 0x0A3C,), '0A36 -> Str -> 0A38 0A3C';
ok Uni.new(0x0A59).Str.NFKD.list ~~ (0x0A16, 0x0A3C,), '0A59 -> Str -> 0A16 0A3C';
ok Uni.new(0x0A5A).Str.NFKD.list ~~ (0x0A17, 0x0A3C,), '0A5A -> Str -> 0A17 0A3C';
ok Uni.new(0x0A5B).Str.NFKD.list ~~ (0x0A1C, 0x0A3C,), '0A5B -> Str -> 0A1C 0A3C';
ok Uni.new(0x0A5E).Str.NFKD.list ~~ (0x0A2B, 0x0A3C,), '0A5E -> Str -> 0A2B 0A3C';
ok Uni.new(0x0B5C).Str.NFKD.list ~~ (0x0B21, 0x0B3C,), '0B5C -> Str -> 0B21 0B3C';
ok Uni.new(0x0B5D).Str.NFKD.list ~~ (0x0B22, 0x0B3C,), '0B5D -> Str -> 0B22 0B3C';
ok Uni.new(0x0F73).Str.NFKD.list ~~ (0x0F71, 0x0F72,), '0F73 -> Str -> 0F71 0F72';
ok Uni.new(0x0F75).Str.NFKD.list ~~ (0x0F71, 0x0F74,), '0F75 -> Str -> 0F71 0F74';
ok Uni.new(0x0F76).Str.NFKD.list ~~ (0x0FB2, 0x0F80,), '0F76 -> Str -> 0FB2 0F80';
ok Uni.new(0x0F78).Str.NFKD.list ~~ (0x0FB3, 0x0F80,), '0F78 -> Str -> 0FB3 0F80';
ok Uni.new(0x0F81).Str.NFKD.list ~~ (0x0F71, 0x0F80,), '0F81 -> Str -> 0F71 0F80';
ok Uni.new(0x2ADC).Str.NFKD.list ~~ (0x2ADD, 0x0338,), '2ADC -> Str -> 2ADD 0338';
ok Uni.new(0xFB1D).Str.NFKD.list ~~ (0x05D9, 0x05B4,), 'FB1D -> Str -> 05D9 05B4';
ok Uni.new(0xFB1F).Str.NFKD.list ~~ (0x05F2, 0x05B7,), 'FB1F -> Str -> 05F2 05B7';
ok Uni.new(0xFB2A).Str.NFKD.list ~~ (0x05E9, 0x05C1,), 'FB2A -> Str -> 05E9 05C1';
ok Uni.new(0xFB2B).Str.NFKD.list ~~ (0x05E9, 0x05C2,), 'FB2B -> Str -> 05E9 05C2';
ok Uni.new(0xFB2C).Str.NFKD.list ~~ (0x05E9, 0x05BC, 0x05C1,), 'FB2C -> Str -> 05E9 05BC 05C1';
ok Uni.new(0xFB2D).Str.NFKD.list ~~ (0x05E9, 0x05BC, 0x05C2,), 'FB2D -> Str -> 05E9 05BC 05C2';
ok Uni.new(0xFB2E).Str.NFKD.list ~~ (0x05D0, 0x05B7,), 'FB2E -> Str -> 05D0 05B7';
ok Uni.new(0xFB2F).Str.NFKD.list ~~ (0x05D0, 0x05B8,), 'FB2F -> Str -> 05D0 05B8';
ok Uni.new(0xFB30).Str.NFKD.list ~~ (0x05D0, 0x05BC,), 'FB30 -> Str -> 05D0 05BC';
ok Uni.new(0xFB31).Str.NFKD.list ~~ (0x05D1, 0x05BC,), 'FB31 -> Str -> 05D1 05BC';
ok Uni.new(0xFB32).Str.NFKD.list ~~ (0x05D2, 0x05BC,), 'FB32 -> Str -> 05D2 05BC';
ok Uni.new(0xFB33).Str.NFKD.list ~~ (0x05D3, 0x05BC,), 'FB33 -> Str -> 05D3 05BC';
ok Uni.new(0xFB34).Str.NFKD.list ~~ (0x05D4, 0x05BC,), 'FB34 -> Str -> 05D4 05BC';
ok Uni.new(0xFB35).Str.NFKD.list ~~ (0x05D5, 0x05BC,), 'FB35 -> Str -> 05D5 05BC';
ok Uni.new(0xFB36).Str.NFKD.list ~~ (0x05D6, 0x05BC,), 'FB36 -> Str -> 05D6 05BC';
ok Uni.new(0xFB38).Str.NFKD.list ~~ (0x05D8, 0x05BC,), 'FB38 -> Str -> 05D8 05BC';
ok Uni.new(0xFB39).Str.NFKD.list ~~ (0x05D9, 0x05BC,), 'FB39 -> Str -> 05D9 05BC';
ok Uni.new(0xFB3A).Str.NFKD.list ~~ (0x05DA, 0x05BC,), 'FB3A -> Str -> 05DA 05BC';
ok Uni.new(0xFB3B).Str.NFKD.list ~~ (0x05DB, 0x05BC,), 'FB3B -> Str -> 05DB 05BC';
ok Uni.new(0xFB3C).Str.NFKD.list ~~ (0x05DC, 0x05BC,), 'FB3C -> Str -> 05DC 05BC';
ok Uni.new(0xFB3E).Str.NFKD.list ~~ (0x05DE, 0x05BC,), 'FB3E -> Str -> 05DE 05BC';
ok Uni.new(0xFB40).Str.NFKD.list ~~ (0x05E0, 0x05BC,), 'FB40 -> Str -> 05E0 05BC';
ok Uni.new(0xFB41).Str.NFKD.list ~~ (0x05E1, 0x05BC,), 'FB41 -> Str -> 05E1 05BC';
ok Uni.new(0xFB43).Str.NFKD.list ~~ (0x05E3, 0x05BC,), 'FB43 -> Str -> 05E3 05BC';
ok Uni.new(0xFB44).Str.NFKD.list ~~ (0x05E4, 0x05BC,), 'FB44 -> Str -> 05E4 05BC';
ok Uni.new(0xFB46).Str.NFKD.list ~~ (0x05E6, 0x05BC,), 'FB46 -> Str -> 05E6 05BC';
ok Uni.new(0xFB47).Str.NFKD.list ~~ (0x05E7, 0x05BC,), 'FB47 -> Str -> 05E7 05BC';
ok Uni.new(0xFB48).Str.NFKD.list ~~ (0x05E8, 0x05BC,), 'FB48 -> Str -> 05E8 05BC';
ok Uni.new(0xFB49).Str.NFKD.list ~~ (0x05E9, 0x05BC,), 'FB49 -> Str -> 05E9 05BC';
ok Uni.new(0xFB4A).Str.NFKD.list ~~ (0x05EA, 0x05BC,), 'FB4A -> Str -> 05EA 05BC';
ok Uni.new(0xFB4B).Str.NFKD.list ~~ (0x05D5, 0x05B9,), 'FB4B -> Str -> 05D5 05B9';
ok Uni.new(0xFB4C).Str.NFKD.list ~~ (0x05D1, 0x05BF,), 'FB4C -> Str -> 05D1 05BF';
ok Uni.new(0xFB4D).Str.NFKD.list ~~ (0x05DB, 0x05BF,), 'FB4D -> Str -> 05DB 05BF';
ok Uni.new(0xFB4E).Str.NFKD.list ~~ (0x05E4, 0x05BF,), 'FB4E -> Str -> 05E4 05BF';
ok Uni.new(0x1D15E).Str.NFKD.list ~~ (0x1D157, 0x1D165,), '1D15E -> Str -> 1D157 1D165';
ok Uni.new(0x1D15F).Str.NFKD.list ~~ (0x1D158, 0x1D165,), '1D15F -> Str -> 1D158 1D165';
ok Uni.new(0x1D160).Str.NFKD.list ~~ (0x1D158, 0x1D165, 0x1D16E,), '1D160 -> Str -> 1D158 1D165 1D16E';
ok Uni.new(0x1D161).Str.NFKD.list ~~ (0x1D158, 0x1D165, 0x1D16F,), '1D161 -> Str -> 1D158 1D165 1D16F';
ok Uni.new(0x1D162).Str.NFKD.list ~~ (0x1D158, 0x1D165, 0x1D170,), '1D162 -> Str -> 1D158 1D165 1D170';
ok Uni.new(0x1D163).Str.NFKD.list ~~ (0x1D158, 0x1D165, 0x1D171,), '1D163 -> Str -> 1D158 1D165 1D171';
ok Uni.new(0x1D164).Str.NFKD.list ~~ (0x1D158, 0x1D165, 0x1D172,), '1D164 -> Str -> 1D158 1D165 1D172';
ok Uni.new(0x1D1BB).Str.NFKD.list ~~ (0x1D1B9, 0x1D165,), '1D1BB -> Str -> 1D1B9 1D165';
ok Uni.new(0x1D1BC).Str.NFKD.list ~~ (0x1D1BA, 0x1D165,), '1D1BC -> Str -> 1D1BA 1D165';
ok Uni.new(0x1D1BD).Str.NFKD.list ~~ (0x1D1B9, 0x1D165, 0x1D16E,), '1D1BD -> Str -> 1D1B9 1D165 1D16E';
ok Uni.new(0x1D1BE).Str.NFKD.list ~~ (0x1D1BA, 0x1D165, 0x1D16E,), '1D1BE -> Str -> 1D1BA 1D165 1D16E';
ok Uni.new(0x1D1BF).Str.NFKD.list ~~ (0x1D1B9, 0x1D165, 0x1D16F,), '1D1BF -> Str -> 1D1B9 1D165 1D16F';
ok Uni.new(0x1D1C0).Str.NFKD.list ~~ (0x1D1BA, 0x1D165, 0x1D16F,), '1D1C0 -> Str -> 1D1BA 1D165 1D16F';
ok Uni.new(0x0061, 0x0315, 0x0300, 0x05AE, 0x0300, 0x0062).Str.NFKD.list ~~ (0x0061, 0x05AE, 0x0300, 0x0300, 0x0315, 0x0062,), '0061 0315 0300 05AE 0300 0062 -> Str -> 0061 05AE 0300 0300 0315 0062';
ok Uni.new(0x0061, 0x0300, 0x0315, 0x0300, 0x05AE, 0x0062).Str.NFKD.list ~~ (0x0061, 0x05AE, 0x0300, 0x0300, 0x0315, 0x0062,), '0061 0300 0315 0300 05AE 0062 -> Str -> 0061 05AE 0300 0300 0315 0062';
ok Uni.new(0x0061, 0x0315, 0x0300, 0x05AE, 0x0301, 0x0062).Str.NFKD.list ~~ (0x0061, 0x05AE, 0x0300, 0x0301, 0x0315, 0x0062,), '0061 0315 0300 05AE 0301 0062 -> Str -> 0061 05AE 0300 0301 0315 0062';
ok Uni.new(0x0061, 0x0301, 0x0315, 0x0300, 0x05AE, 0x0062).Str.NFKD.list ~~ (0x0061, 0x05AE, 0x0301, 0x0300, 0x0315, 0x0062,), '0061 0301 0315 0300 05AE 0062 -> Str -> 0061 05AE 0301 0300 0315 0062';
ok Uni.new(0x0061, 0x0315, 0x0300, 0x05AE, 0x0302, 0x0062).Str.NFKD.list ~~ (0x0061, 0x05AE, 0x0300, 0x0302, 0x0315, 0x0062,), '0061 0315 0300 05AE 0302 0062 -> Str -> 0061 05AE 0300 0302 0315 0062';
ok Uni.new(0x0061, 0x0302, 0x0315, 0x0300, 0x05AE, 0x0062).Str.NFKD.list ~~ (0x0061, 0x05AE, 0x0302, 0x0300, 0x0315, 0x0062,), '0061 0302 0315 0300 05AE 0062 -> Str -> 0061 05AE 0302 0300 0315 0062';
ok Uni.new(0x0061, 0x0315, 0x0300, 0x05AE, 0x0303, 0x0062).Str.NFKD.list ~~ (0x0061, 0x05AE, 0x0300, 0x0303, 0x0315, 0x0062,), '0061 0315 0300 05AE 0303 0062 -> Str -> 0061 05AE 0300 0303 0315 0062';
ok Uni.new(0x0061, 0x0303, 0x0315, 0x0300, 0x05AE, 0x0062).Str.NFKD.list ~~ (0x0061, 0x05AE, 0x0303, 0x0300, 0x0315, 0x0062,), '0061 0303 0315 0300 05AE 0062 -> Str -> 0061 05AE 0303 0300 0315 0062';
ok Uni.new(0x0061, 0x0315, 0x0300, 0x05AE, 0x0304, 0x0062).Str.NFKD.list ~~ (0x0061, 0x05AE, 0x0300, 0x0304, 0x0315, 0x0062,), '0061 0315 0300 05AE 0304 0062 -> Str -> 0061 05AE 0300 0304 0315 0062';
ok Uni.new(0x0061, 0x0304, 0x0315, 0x0300, 0x05AE, 0x0062).Str.NFKD.list ~~ (0x0061, 0x05AE, 0x0304, 0x0300, 0x0315, 0x0062,), '0061 0304 0315 0300 05AE 0062 -> Str -> 0061 05AE 0304 0300 0315 0062';
ok Uni.new(0x0061, 0x0315, 0x0300, 0x05AE, 0x0305, 0x0062).Str.NFKD.list ~~ (0x0061, 0x05AE, 0x0300, 0x0305, 0x0315, 0x0062,), '0061 0315 0300 05AE 0305 0062 -> Str -> 0061 05AE 0300 0305 0315 0062';
ok Uni.new(0x0061, 0x0305, 0x0315, 0x0300, 0x05AE, 0x0062).Str.NFKD.list ~~ (0x0061, 0x05AE, 0x0305, 0x0300, 0x0315, 0x0062,), '0061 0305 0315 0300 05AE 0062 -> Str -> 0061 05AE 0305 0300 0315 0062';
ok Uni.new(0x0061, 0x0315, 0x0300, 0x05AE, 0x0306, 0x0062).Str.NFKD.list ~~ (0x0061, 0x05AE, 0x0300, 0x0306, 0x0315, 0x0062,), '0061 0315 0300 05AE 0306 0062 -> Str -> 0061 05AE 0300 0306 0315 0062';
ok Uni.new(0x0061, 0x0306, 0x0315, 0x0300, 0x05AE, 0x0062).Str.NFKD.list ~~ (0x0061, 0x05AE, 0x0306, 0x0300, 0x0315, 0x0062,), '0061 0306 0315 0300 05AE 0062 -> Str -> 0061 05AE 0306 0300 0315 0062';
ok Uni.new(0x0061, 0x0315, 0x0300, 0x05AE, 0x0307, 0x0062).Str.NFKD.list ~~ (0x0061, 0x05AE, 0x0300, 0x0307, 0x0315, 0x0062,), '0061 0315 0300 05AE 0307 0062 -> Str -> 0061 05AE 0300 0307 0315 0062';
ok Uni.new(0x0061, 0x0307, 0x0315, 0x0300, 0x05AE, 0x0062).Str.NFKD.list ~~ (0x0061, 0x05AE, 0x0307, 0x0300, 0x0315, 0x0062,), '0061 0307 0315 0300 05AE 0062 -> Str -> 0061 05AE 0307 0300 0315 0062';
