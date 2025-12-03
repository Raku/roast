# Generated from GraphemeBreakTest.txt, Unicode version 17.0.0
# Test lines 400..^600
use Test;
plan 200;

subtest "Codepoint sequence \"\\x[1100,1100]\"", {
    plan 2;

    my @chars = "\x[1100,1100]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x1100).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1100,0308,1100]\"", {
    plan 3;

    my @chars = "\x[1100,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,1160]\"", {
    plan 2;

    my @chars = "\x[1100,1160]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x1160).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1100,0308,1160]\"", {
    plan 3;

    my @chars = "\x[1100,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,11A8]\"", {
    plan 3;

    my @chars = "\x[1100,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[1100,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,AC00]\"", {
    plan 2;

    my @chars = "\x[1100,AC00]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0xac00).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1100,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[1100,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,AC01]\"", {
    plan 2;

    my @chars = "\x[1100,AC01]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0xac01).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1100,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[1100,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,0915]\"", {
    plan 3;

    my @chars = "\x[1100,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,0308,0915]\"", {
    plan 3;

    my @chars = "\x[1100,0308,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,00A9]\"", {
    plan 3;

    my @chars = "\x[1100,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[1100,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,0020]\"", {
    plan 3;

    my @chars = "\x[1100,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,0308,0020]\"", {
    plan 3;

    my @chars = "\x[1100,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,0378]\"", {
    plan 3;

    my @chars = "\x[1100,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,0308,0378]\"", {
    plan 3;

    my @chars = "\x[1100,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,000D]\"", {
    plan 3;

    my @chars = "\x[1160,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0308,000D]\"", {
    plan 3;

    my @chars = "\x[1160,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,000A]\"", {
    plan 3;

    my @chars = "\x[1160,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0308,000A]\"", {
    plan 3;

    my @chars = "\x[1160,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0000]\"", {
    plan 3;

    my @chars = "\x[1160,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0308,0000]\"", {
    plan 3;

    my @chars = "\x[1160,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,094D]\"", {
    plan 2;

    my @chars = "\x[1160,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1160,0308,094D]\"", {
    plan 2;

    my @chars = "\x[1160,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1160,0300]\"", {
    plan 2;

    my @chars = "\x[1160,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1160,0308,0300]\"", {
    plan 2;

    my @chars = "\x[1160,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1160,200C]\"", {
    plan 2;

    my @chars = "\x[1160,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1160,0308,200C]\"", {
    plan 2;

    my @chars = "\x[1160,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1160,200D]\"", {
    plan 2;

    my @chars = "\x[1160,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1160,0308,200D]\"", {
    plan 2;

    my @chars = "\x[1160,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1160,1F1E6]\"", {
    plan 3;

    my @chars = "\x[1160,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[1160,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,06DD]\"", {
    plan 3;

    my @chars = "\x[1160,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[1160,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0903]\"", {
    plan 2;

    my @chars = "\x[1160,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1160,0308,0903]\"", {
    plan 2;

    my @chars = "\x[1160,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1160,1100]\"", {
    plan 3;

    my @chars = "\x[1160,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0308,1100]\"", {
    plan 3;

    my @chars = "\x[1160,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,1160]\"", {
    plan 2;

    my @chars = "\x[1160,1160]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x1160).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1160,0308,1160]\"", {
    plan 3;

    my @chars = "\x[1160,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,11A8]\"", {
    plan 2;

    my @chars = "\x[1160,11A8]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x11a8).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1160,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[1160,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,AC00]\"", {
    plan 3;

    my @chars = "\x[1160,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[1160,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,AC01]\"", {
    plan 3;

    my @chars = "\x[1160,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[1160,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0915]\"", {
    plan 3;

    my @chars = "\x[1160,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0308,0915]\"", {
    plan 3;

    my @chars = "\x[1160,0308,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,00A9]\"", {
    plan 3;

    my @chars = "\x[1160,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[1160,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0020]\"", {
    plan 3;

    my @chars = "\x[1160,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0308,0020]\"", {
    plan 3;

    my @chars = "\x[1160,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0378]\"", {
    plan 3;

    my @chars = "\x[1160,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1160,0308,0378]\"", {
    plan 3;

    my @chars = "\x[1160,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,000D]\"", {
    plan 3;

    my @chars = "\x[11A8,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0308,000D]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,000A]\"", {
    plan 3;

    my @chars = "\x[11A8,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0308,000A]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0000]\"", {
    plan 3;

    my @chars = "\x[11A8,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0308,0000]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,094D]\"", {
    plan 2;

    my @chars = "\x[11A8,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[11A8,0308,094D]\"", {
    plan 2;

    my @chars = "\x[11A8,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[11A8,0300]\"", {
    plan 2;

    my @chars = "\x[11A8,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[11A8,0308,0300]\"", {
    plan 2;

    my @chars = "\x[11A8,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[11A8,200C]\"", {
    plan 2;

    my @chars = "\x[11A8,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[11A8,0308,200C]\"", {
    plan 2;

    my @chars = "\x[11A8,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[11A8,200D]\"", {
    plan 2;

    my @chars = "\x[11A8,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[11A8,0308,200D]\"", {
    plan 2;

    my @chars = "\x[11A8,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[11A8,1F1E6]\"", {
    plan 3;

    my @chars = "\x[11A8,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,06DD]\"", {
    plan 3;

    my @chars = "\x[11A8,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0903]\"", {
    plan 2;

    my @chars = "\x[11A8,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[11A8,0308,0903]\"", {
    plan 2;

    my @chars = "\x[11A8,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[11A8,1100]\"", {
    plan 3;

    my @chars = "\x[11A8,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0308,1100]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,1160]\"", {
    plan 3;

    my @chars = "\x[11A8,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0308,1160]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,11A8]\"", {
    plan 2;

    my @chars = "\x[11A8,11A8]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x11a8).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[11A8,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,AC00]\"", {
    plan 3;

    my @chars = "\x[11A8,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,AC01]\"", {
    plan 3;

    my @chars = "\x[11A8,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0915]\"", {
    plan 3;

    my @chars = "\x[11A8,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0308,0915]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,00A9]\"", {
    plan 3;

    my @chars = "\x[11A8,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0020]\"", {
    plan 3;

    my @chars = "\x[11A8,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0308,0020]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0378]\"", {
    plan 3;

    my @chars = "\x[11A8,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[11A8,0308,0378]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,000D]\"", {
    plan 3;

    my @chars = "\x[AC00,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0308,000D]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,000A]\"", {
    plan 3;

    my @chars = "\x[AC00,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0308,000A]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0000]\"", {
    plan 3;

    my @chars = "\x[AC00,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0308,0000]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,094D]\"", {
    plan 2;

    my @chars = "\x[AC00,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC00,0308,094D]\"", {
    plan 2;

    my @chars = "\x[AC00,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC00,0300]\"", {
    plan 2;

    my @chars = "\x[AC00,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC00,0308,0300]\"", {
    plan 2;

    my @chars = "\x[AC00,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC00,200C]\"", {
    plan 2;

    my @chars = "\x[AC00,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC00,0308,200C]\"", {
    plan 2;

    my @chars = "\x[AC00,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC00,200D]\"", {
    plan 2;

    my @chars = "\x[AC00,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC00,0308,200D]\"", {
    plan 2;

    my @chars = "\x[AC00,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC00,1F1E6]\"", {
    plan 3;

    my @chars = "\x[AC00,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,06DD]\"", {
    plan 3;

    my @chars = "\x[AC00,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0903]\"", {
    plan 2;

    my @chars = "\x[AC00,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC00,0308,0903]\"", {
    plan 2;

    my @chars = "\x[AC00,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC00,1100]\"", {
    plan 3;

    my @chars = "\x[AC00,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0308,1100]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,1160]\"", {
    plan 2;

    my @chars = "\x[AC00,1160]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x1160).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC00,0308,1160]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,11A8]\"", {
    plan 2;

    my @chars = "\x[AC00,11A8]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x11a8).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC00,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,AC00]\"", {
    plan 3;

    my @chars = "\x[AC00,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,AC01]\"", {
    plan 3;

    my @chars = "\x[AC00,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0915]\"", {
    plan 3;

    my @chars = "\x[AC00,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0308,0915]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,00A9]\"", {
    plan 3;

    my @chars = "\x[AC00,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0020]\"", {
    plan 3;

    my @chars = "\x[AC00,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0308,0020]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0378]\"", {
    plan 3;

    my @chars = "\x[AC00,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC00,0308,0378]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,000D]\"", {
    plan 3;

    my @chars = "\x[AC01,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0308,000D]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,000A]\"", {
    plan 3;

    my @chars = "\x[AC01,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0308,000A]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0000]\"", {
    plan 3;

    my @chars = "\x[AC01,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0308,0000]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,094D]\"", {
    plan 2;

    my @chars = "\x[AC01,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC01,0308,094D]\"", {
    plan 2;

    my @chars = "\x[AC01,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC01,0300]\"", {
    plan 2;

    my @chars = "\x[AC01,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC01,0308,0300]\"", {
    plan 2;

    my @chars = "\x[AC01,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC01,200C]\"", {
    plan 2;

    my @chars = "\x[AC01,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC01,0308,200C]\"", {
    plan 2;

    my @chars = "\x[AC01,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC01,200D]\"", {
    plan 2;

    my @chars = "\x[AC01,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC01,0308,200D]\"", {
    plan 2;

    my @chars = "\x[AC01,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC01,1F1E6]\"", {
    plan 3;

    my @chars = "\x[AC01,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,06DD]\"", {
    plan 3;

    my @chars = "\x[AC01,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0903]\"", {
    plan 2;

    my @chars = "\x[AC01,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC01,0308,0903]\"", {
    plan 2;

    my @chars = "\x[AC01,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC01,1100]\"", {
    plan 3;

    my @chars = "\x[AC01,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0308,1100]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,1160]\"", {
    plan 3;

    my @chars = "\x[AC01,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0308,1160]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,11A8]\"", {
    plan 2;

    my @chars = "\x[AC01,11A8]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x11a8).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[AC01,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,AC00]\"", {
    plan 3;

    my @chars = "\x[AC01,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,AC01]\"", {
    plan 3;

    my @chars = "\x[AC01,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0915]\"", {
    plan 3;

    my @chars = "\x[AC01,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0308,0915]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,00A9]\"", {
    plan 3;

    my @chars = "\x[AC01,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0020]\"", {
    plan 3;

    my @chars = "\x[AC01,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0308,0020]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0378]\"", {
    plan 3;

    my @chars = "\x[AC01,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[AC01,0308,0378]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,000D]\"", {
    plan 3;

    my @chars = "\x[0915,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0308,000D]\"", {
    plan 3;

    my @chars = "\x[0915,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,000A]\"", {
    plan 3;

    my @chars = "\x[0915,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0308,000A]\"", {
    plan 3;

    my @chars = "\x[0915,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0000]\"", {
    plan 3;

    my @chars = "\x[0915,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0308,0000]\"", {
    plan 3;

    my @chars = "\x[0915,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,094D]\"", {
    plan 2;

    my @chars = "\x[0915,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,0308,094D]\"", {
    plan 2;

    my @chars = "\x[0915,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,0300]\"", {
    plan 2;

    my @chars = "\x[0915,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,0308,0300]\"", {
    plan 2;

    my @chars = "\x[0915,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,200C]\"", {
    plan 2;

    my @chars = "\x[0915,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,0308,200C]\"", {
    plan 2;

    my @chars = "\x[0915,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,200D]\"", {
    plan 2;

    my @chars = "\x[0915,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,0308,200D]\"", {
    plan 2;

    my @chars = "\x[0915,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,1F1E6]\"", {
    plan 3;

    my @chars = "\x[0915,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[0915,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,06DD]\"", {
    plan 3;

    my @chars = "\x[0915,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[0915,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0903]\"", {
    plan 2;

    my @chars = "\x[0915,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,0308,0903]\"", {
    plan 2;

    my @chars = "\x[0915,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0915,1100]\"", {
    plan 3;

    my @chars = "\x[0915,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0308,1100]\"", {
    plan 3;

    my @chars = "\x[0915,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,1160]\"", {
    plan 3;

    my @chars = "\x[0915,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0308,1160]\"", {
    plan 3;

    my @chars = "\x[0915,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,11A8]\"", {
    plan 3;

    my @chars = "\x[0915,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[0915,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,AC00]\"", {
    plan 3;

    my @chars = "\x[0915,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[0915,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,AC01]\"", {
    plan 3;

    my @chars = "\x[0915,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[0915,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

