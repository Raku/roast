# Generated from GraphemeBreakTest.txt, Unicode version 18.0.0
# Test lines 800..^853
use Test;
plan 53;

subtest "Codepoint sequence \"\\x[000D,000A,0061,000A,0308]\"", {
    plan 5;

    my @chars = "\x[000D,000A,0061,000A,0308]".comb;

    is +@chars, 4, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d, 0x000a).NFC, "Grapheme 1/4";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0061).NFC, "Grapheme 2/4";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 3/4";
    is-deeply (@chars[3]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 4/4";
}

subtest "Codepoint sequence \"\\x[0061,0308]\"", {
    plan 2;

    my @chars = "\x[0061,0308]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0061, 0x0308).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0020,200D,0646]\"", {
    plan 3;

    my @chars = "\x[0020,200D,0646]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0646).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0646,200D,0020]\"", {
    plan 3;

    my @chars = "\x[0646,200D,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0646, 0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,1100]\"", {
    plan 2;

    my @chars = "\x[1100,1100]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x1100).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC00,11A8,1100]\"", {
    plan 3;

    my @chars = "\x[AC00,11A8,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x11a8).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,11A8,1100]\"", {
    plan 3;

    my @chars = "\x[AC01,11A8,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x11a8).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,1F1E7,1F1E8,0062]\"", {
    plan 4;

    my @chars = "\x[1F1E6,1F1E7,1F1E8,0062]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x1f1e7).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e8).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0062).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[0061,1F1E6,1F1E7,1F1E8,0062]\"", {
    plan 5;

    my @chars = "\x[0061,1F1E6,1F1E7,1F1E8,0062]".comb;

    is +@chars, 4, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0061).NFC, "Grapheme 1/4";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6, 0x1f1e7).NFC, "Grapheme 2/4";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1f1e8).NFC, "Grapheme 3/4";
    is-deeply (@chars[3]//"").NFC, Uni.new(0x0062).NFC, "Grapheme 4/4";
}

subtest "Codepoint sequence \"\\x[0061,1F1E6,1F1E7,200D,1F1E8,0062]\"", {
    plan 5;

    my @chars = "\x[0061,1F1E6,1F1E7,200D,1F1E8,0062]".comb;

    is +@chars, 4, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0061).NFC, "Grapheme 1/4";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6, 0x1f1e7, 0x200d).NFC, "Grapheme 2/4";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1f1e8).NFC, "Grapheme 3/4";
    is-deeply (@chars[3]//"").NFC, Uni.new(0x0062).NFC, "Grapheme 4/4";
}

subtest "Codepoint sequence \"\\x[0061,1F1E6,200D,1F1E7,1F1E8,0062]\"", {
    plan 5;

    my @chars = "\x[0061,1F1E6,200D,1F1E7,1F1E8,0062]".comb;

    is +@chars, 4, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0061).NFC, "Grapheme 1/4";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6, 0x200d).NFC, "Grapheme 2/4";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1f1e7, 0x1f1e8).NFC, "Grapheme 3/4";
    is-deeply (@chars[3]//"").NFC, Uni.new(0x0062).NFC, "Grapheme 4/4";
}

subtest "Codepoint sequence \"\\x[0061,1F1E6,1F1E7,1F1E8,1F1E9,0062]\"", {
    plan 5;

    my @chars = "\x[0061,1F1E6,1F1E7,1F1E8,1F1E9,0062]".comb;

    is +@chars, 4, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0061).NFC, "Grapheme 1/4";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6, 0x1f1e7).NFC, "Grapheme 2/4";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1f1e8, 0x1f1e9).NFC, "Grapheme 3/4";
    is-deeply (@chars[3]//"").NFC, Uni.new(0x0062).NFC, "Grapheme 4/4";
}

subtest "Codepoint sequence \"\\x[0061,200D]\"", {
    plan 2;

    my @chars = "\x[0061,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0061, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0061,0308,0062]\"", {
    plan 3;

    my @chars = "\x[0061,0308,0062]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0061, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0062).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0061,0903,0062]\"", {
    plan 3;

    my @chars = "\x[0061,0903,0062]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0061, 0x0903).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0062).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0061,0600,0062]\"", {
    plan 3;

    my @chars = "\x[0061,0600,0062]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0061).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0600, 0x0062).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F476,1F3FF,1F476]\"", {
    plan 3;

    my @chars = "\x[1F476,1F3FF,1F476]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f476, 0x1f3ff).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f476).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0061,1F3FF,1F476]\"", {
    plan 3;

    my @chars = "\x[0061,1F3FF,1F476]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0061, 0x1f3ff).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f476).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0061,1F3FF,1F476,200D,1F6D1]\"", {
    plan 3;

    my @chars = "\x[0061,1F3FF,1F476,200D,1F6D1]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0061, 0x1f3ff).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f476, 0x200d, 0x1f6d1).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F476,1F3FF,0308,200D,1F476,1F3FF]\"", {
    plan 2;

    my @chars = "\x[1F476,1F3FF,0308,200D,1F476,1F3FF]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f476, 0x1f3ff, 0x0308, 0x200d, 0x1f476, 0x1f3ff).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1F6D1,200D,1F6D1]\"", {
    plan 2;

    my @chars = "\x[1F6D1,200D,1F6D1]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f6d1, 0x200d, 0x1f6d1).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0061,200D,1F6D1]\"", {
    plan 3;

    my @chars = "\x[0061,200D,1F6D1]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0061, 0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f6d1).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[2701,200D,2701]\"", {
    plan 3;

    my @chars = "\x[2701,200D,2701]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x2701, 0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x2701).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0061,200D,2701]\"", {
    plan 3;

    my @chars = "\x[0061,200D,2701]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0061, 0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x2701).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0924]\"", {
    plan 3;

    my @chars = "\x[0915,0924]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0924).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,094D,0924]\"", {
    plan 2;

    my @chars = "\x[0915,094D,0924]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x094d, 0x0924).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,094D,094D,0924]\"", {
    plan 2;

    my @chars = "\x[0915,094D,094D,0924]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x094d, 0x094d, 0x0924).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,094D,200D,0924]\"", {
    plan 2;

    my @chars = "\x[0915,094D,200D,0924]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x094d, 0x200d, 0x0924).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,093C,200D,094D,0924]\"", {
    plan 2;

    my @chars = "\x[0915,093C,200D,094D,0924]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x093c, 0x200d, 0x094d, 0x0924).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,093C,094D,200D,0924]\"", {
    plan 2;

    my @chars = "\x[0915,093C,094D,200D,0924]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x093c, 0x094d, 0x200d, 0x0924).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,094D,0924,094D,092F]\"", {
    plan 2;

    my @chars = "\x[0915,094D,0924,094D,092F]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x094d, 0x0924, 0x094d, 0x092f).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,094D,0061]\"", {
    plan 3;

    my @chars = "\x[0915,094D,0061]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x094d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0061).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0061,094D,0924]\"", {
    plan 2;

    my @chars = "\x[0061,094D,0924]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0061, 0x094d, 0x0924).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[003F,094D,0924]\"", {
    plan 2;

    my @chars = "\x[003F,094D,0924]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x003f, 0x094d, 0x0924).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,094D,094D,0924]\"", {
    plan 2;

    my @chars = "\x[0915,094D,094D,0924]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x094d, 0x094d, 0x0924).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0AB8,0AFB,0ACD,0AB8,0AFB]\"", {
    plan 2;

    my @chars = "\x[0AB8,0AFB,0ACD,0AB8,0AFB]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0ab8, 0x0afb, 0x0acd, 0x0ab8, 0x0afb).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1019,1039,1018,102C,1037]\"", {
    plan 3;

    my @chars = "\x[1019,1039,1018,102C,1037]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1019, 0x1039, 0x1018).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x102c, 0x1037).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1004,103A,1039,1011,1039,1011]\"", {
    plan 2;

    my @chars = "\x[1004,103A,1039,1011,1039,1011]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1004, 0x103a, 0x1039, 0x1011, 0x1039, 0x1011).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1B12,1B01,1B32,1B44,1B2F,1B32,1B44,1B22,1B44,1B2C,1B32,1B44,1B22,1B38]\"", {
    plan 5;

    my @chars = "\x[1B12,1B01,1B32,1B44,1B2F,1B32,1B44,1B22,1B44,1B2C,1B32,1B44,1B22,1B38]".comb;

    is +@chars, 4, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1b12, 0x1b01).NFC, "Grapheme 1/4";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1b32, 0x1b44, 0x1b2f).NFC, "Grapheme 2/4";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1b32, 0x1b44, 0x1b22, 0x1b44, 0x1b2c).NFC, "Grapheme 3/4";
    is-deeply (@chars[3]//"").NFC, Uni.new(0x1b32, 0x1b44, 0x1b22, 0x1b38).NFC, "Grapheme 4/4";
}

subtest "Codepoint sequence \"\\x[179F,17D2,178F,17D2,179A,17B8]\"", {
    plan 2;

    my @chars = "\x[179F,17D2,178F,17D2,179A,17B8]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x179f, 0x17d2, 0x178f, 0x17d2, 0x179a, 0x17b8).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1B26,1B17,1B44,1B13]\"", {
    plan 3;

    my @chars = "\x[1B26,1B17,1B44,1B13]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1b26).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1b17, 0x1b44, 0x1b13).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1B27,1B13,1B44,1B0B,1B0B,1B04]\"", {
    plan 4;

    my @chars = "\x[1B27,1B13,1B44,1B0B,1B0B,1B04]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1b27).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1b13, 0x1b44, 0x1b0b).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1b0b, 0x1b04).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[1795,17D2,17AF,1798]\"", {
    plan 3;

    my @chars = "\x[1795,17D2,17AF,1798]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1795, 0x17d2, 0x17af).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1798).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[17A0,17D2,17AB,1791,17D0,1799]\"", {
    plan 4;

    my @chars = "\x[17A0,17D2,17AB,1791,17D0,1799]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x17a0, 0x17d2, 0x17ab).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1791, 0x17d0).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1799).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[1B05,1B44,1B33,1B03]\"", {
    plan 2;

    my @chars = "\x[1B05,1B44,1B33,1B03]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1b05, 0x1b44, 0x1b33, 0x1b03).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0CF1,0C95]\"", {
    plan 3;

    my @chars = "\x[0CF1,0C95]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0cf1).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0c95).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0CF2,0CAB]\"", {
    plan 3;

    my @chars = "\x[0CF2,0CAB]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0cf2).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0cab).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0CF1,0C95,0CBF]\"", {
    plan 3;

    my @chars = "\x[0CF1,0C95,0CBF]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0cf1).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0c95, 0x0cbf).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0995]\"", {
    plan 2;

    my @chars = "\x[1CF5,0995]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0995).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1CF6,09AA]\"", {
    plan 2;

    my @chars = "\x[1CF6,09AA]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf6, 0x09aa).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1CF5,200C,0995]\"", {
    plan 3;

    my @chars = "\x[1CF5,200C,0995]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x200c).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0995).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF6,200C,09AA]\"", {
    plan 3;

    my @chars = "\x[1CF6,200C,09AA]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf6, 0x200c).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x09aa).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A3A,11A0B]\"", {
    plan 2;

    my @chars = "\x[11A3A,11A0B]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a3a, 0x11a0b).NFC, "Grapheme 1/1";
}

