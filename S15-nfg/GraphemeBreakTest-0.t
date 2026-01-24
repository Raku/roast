# Generated from GraphemeBreakTest.txt, Unicode version 17.0.0
# Test lines 0..^200
use Test;
plan 200;

subtest "Codepoint sequence \"\\x[000D,000D]\"", {
    plan 3;

    my @chars = "\x[000D,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,000D]\"", {
    plan 4;

    my @chars = "\x[000D,0308,000D]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000D,000A]\"", {
    plan 2;

    my @chars = "\x[000D,000A]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d, 0x000a).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[000D,0308,000A]\"", {
    plan 4;

    my @chars = "\x[000D,0308,000A]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000D,0000]\"", {
    plan 3;

    my @chars = "\x[000D,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,0000]\"", {
    plan 4;

    my @chars = "\x[000D,0308,0000]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000D,094D]\"", {
    plan 3;

    my @chars = "\x[000D,094D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,094D]\"", {
    plan 3;

    my @chars = "\x[000D,0308,094D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x094d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0300]\"", {
    plan 3;

    my @chars = "\x[000D,0300]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,0300]\"", {
    plan 3;

    my @chars = "\x[000D,0308,0300]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x0300).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,200C]\"", {
    plan 3;

    my @chars = "\x[000D,200C]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,200C]\"", {
    plan 3;

    my @chars = "\x[000D,0308,200C]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x200c).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,200D]\"", {
    plan 3;

    my @chars = "\x[000D,200D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,200D]\"", {
    plan 3;

    my @chars = "\x[000D,0308,200D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x200d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,1F1E6]\"", {
    plan 3;

    my @chars = "\x[000D,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,1F1E6]\"", {
    plan 4;

    my @chars = "\x[000D,0308,1F1E6]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000D,06DD]\"", {
    plan 3;

    my @chars = "\x[000D,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,06DD]\"", {
    plan 4;

    my @chars = "\x[000D,0308,06DD]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000D,0903]\"", {
    plan 3;

    my @chars = "\x[000D,0903]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,0903]\"", {
    plan 3;

    my @chars = "\x[000D,0308,0903]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x0903).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,1100]\"", {
    plan 3;

    my @chars = "\x[000D,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,1100]\"", {
    plan 4;

    my @chars = "\x[000D,0308,1100]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000D,1160]\"", {
    plan 3;

    my @chars = "\x[000D,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,1160]\"", {
    plan 4;

    my @chars = "\x[000D,0308,1160]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000D,11A8]\"", {
    plan 3;

    my @chars = "\x[000D,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,11A8]\"", {
    plan 4;

    my @chars = "\x[000D,0308,11A8]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000D,AC00]\"", {
    plan 3;

    my @chars = "\x[000D,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,AC00]\"", {
    plan 4;

    my @chars = "\x[000D,0308,AC00]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000D,AC01]\"", {
    plan 3;

    my @chars = "\x[000D,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,AC01]\"", {
    plan 4;

    my @chars = "\x[000D,0308,AC01]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000D,0915]\"", {
    plan 3;

    my @chars = "\x[000D,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,0915]\"", {
    plan 4;

    my @chars = "\x[000D,0308,0915]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000D,00A9]\"", {
    plan 3;

    my @chars = "\x[000D,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,00A9]\"", {
    plan 4;

    my @chars = "\x[000D,0308,00A9]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000D,0020]\"", {
    plan 3;

    my @chars = "\x[000D,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,0020]\"", {
    plan 4;

    my @chars = "\x[000D,0308,0020]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000D,0378]\"", {
    plan 3;

    my @chars = "\x[000D,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000D,0308,0378]\"", {
    plan 4;

    my @chars = "\x[000D,0308,0378]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000A,000D]\"", {
    plan 3;

    my @chars = "\x[000A,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,000D]\"", {
    plan 4;

    my @chars = "\x[000A,0308,000D]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000A,000A]\"", {
    plan 3;

    my @chars = "\x[000A,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,000A]\"", {
    plan 4;

    my @chars = "\x[000A,0308,000A]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000A,0000]\"", {
    plan 3;

    my @chars = "\x[000A,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,0000]\"", {
    plan 4;

    my @chars = "\x[000A,0308,0000]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000A,094D]\"", {
    plan 3;

    my @chars = "\x[000A,094D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,094D]\"", {
    plan 3;

    my @chars = "\x[000A,0308,094D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x094d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0300]\"", {
    plan 3;

    my @chars = "\x[000A,0300]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,0300]\"", {
    plan 3;

    my @chars = "\x[000A,0308,0300]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x0300).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,200C]\"", {
    plan 3;

    my @chars = "\x[000A,200C]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,200C]\"", {
    plan 3;

    my @chars = "\x[000A,0308,200C]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x200c).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,200D]\"", {
    plan 3;

    my @chars = "\x[000A,200D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,200D]\"", {
    plan 3;

    my @chars = "\x[000A,0308,200D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x200d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,1F1E6]\"", {
    plan 3;

    my @chars = "\x[000A,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,1F1E6]\"", {
    plan 4;

    my @chars = "\x[000A,0308,1F1E6]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000A,06DD]\"", {
    plan 3;

    my @chars = "\x[000A,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,06DD]\"", {
    plan 4;

    my @chars = "\x[000A,0308,06DD]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000A,0903]\"", {
    plan 3;

    my @chars = "\x[000A,0903]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,0903]\"", {
    plan 3;

    my @chars = "\x[000A,0308,0903]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x0903).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,1100]\"", {
    plan 3;

    my @chars = "\x[000A,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,1100]\"", {
    plan 4;

    my @chars = "\x[000A,0308,1100]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000A,1160]\"", {
    plan 3;

    my @chars = "\x[000A,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,1160]\"", {
    plan 4;

    my @chars = "\x[000A,0308,1160]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000A,11A8]\"", {
    plan 3;

    my @chars = "\x[000A,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,11A8]\"", {
    plan 4;

    my @chars = "\x[000A,0308,11A8]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000A,AC00]\"", {
    plan 3;

    my @chars = "\x[000A,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,AC00]\"", {
    plan 4;

    my @chars = "\x[000A,0308,AC00]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000A,AC01]\"", {
    plan 3;

    my @chars = "\x[000A,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,AC01]\"", {
    plan 4;

    my @chars = "\x[000A,0308,AC01]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000A,0915]\"", {
    plan 3;

    my @chars = "\x[000A,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,0915]\"", {
    plan 4;

    my @chars = "\x[000A,0308,0915]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000A,00A9]\"", {
    plan 3;

    my @chars = "\x[000A,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,00A9]\"", {
    plan 4;

    my @chars = "\x[000A,0308,00A9]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000A,0020]\"", {
    plan 3;

    my @chars = "\x[000A,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,0020]\"", {
    plan 4;

    my @chars = "\x[000A,0308,0020]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[000A,0378]\"", {
    plan 3;

    my @chars = "\x[000A,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[000A,0308,0378]\"", {
    plan 4;

    my @chars = "\x[000A,0308,0378]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[0000,000D]\"", {
    plan 3;

    my @chars = "\x[0000,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,000D]\"", {
    plan 4;

    my @chars = "\x[0000,0308,000D]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[0000,000A]\"", {
    plan 3;

    my @chars = "\x[0000,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,000A]\"", {
    plan 4;

    my @chars = "\x[0000,0308,000A]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[0000,0000]\"", {
    plan 3;

    my @chars = "\x[0000,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,0000]\"", {
    plan 4;

    my @chars = "\x[0000,0308,0000]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[0000,094D]\"", {
    plan 3;

    my @chars = "\x[0000,094D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,094D]\"", {
    plan 3;

    my @chars = "\x[0000,0308,094D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x094d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0300]\"", {
    plan 3;

    my @chars = "\x[0000,0300]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,0300]\"", {
    plan 3;

    my @chars = "\x[0000,0308,0300]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x0300).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,200C]\"", {
    plan 3;

    my @chars = "\x[0000,200C]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,200C]\"", {
    plan 3;

    my @chars = "\x[0000,0308,200C]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x200c).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,200D]\"", {
    plan 3;

    my @chars = "\x[0000,200D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,200D]\"", {
    plan 3;

    my @chars = "\x[0000,0308,200D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x200d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,1F1E6]\"", {
    plan 3;

    my @chars = "\x[0000,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,1F1E6]\"", {
    plan 4;

    my @chars = "\x[0000,0308,1F1E6]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[0000,06DD]\"", {
    plan 3;

    my @chars = "\x[0000,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,06DD]\"", {
    plan 4;

    my @chars = "\x[0000,0308,06DD]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[0000,0903]\"", {
    plan 3;

    my @chars = "\x[0000,0903]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,0903]\"", {
    plan 3;

    my @chars = "\x[0000,0308,0903]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x0903).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,1100]\"", {
    plan 3;

    my @chars = "\x[0000,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,1100]\"", {
    plan 4;

    my @chars = "\x[0000,0308,1100]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[0000,1160]\"", {
    plan 3;

    my @chars = "\x[0000,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,1160]\"", {
    plan 4;

    my @chars = "\x[0000,0308,1160]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[0000,11A8]\"", {
    plan 3;

    my @chars = "\x[0000,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,11A8]\"", {
    plan 4;

    my @chars = "\x[0000,0308,11A8]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[0000,AC00]\"", {
    plan 3;

    my @chars = "\x[0000,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,AC00]\"", {
    plan 4;

    my @chars = "\x[0000,0308,AC00]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[0000,AC01]\"", {
    plan 3;

    my @chars = "\x[0000,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,AC01]\"", {
    plan 4;

    my @chars = "\x[0000,0308,AC01]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[0000,0915]\"", {
    plan 3;

    my @chars = "\x[0000,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,0915]\"", {
    plan 4;

    my @chars = "\x[0000,0308,0915]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[0000,00A9]\"", {
    plan 3;

    my @chars = "\x[0000,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,00A9]\"", {
    plan 4;

    my @chars = "\x[0000,0308,00A9]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[0000,0020]\"", {
    plan 3;

    my @chars = "\x[0000,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,0020]\"", {
    plan 4;

    my @chars = "\x[0000,0308,0020]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[0000,0378]\"", {
    plan 3;

    my @chars = "\x[0000,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0000,0308,0378]\"", {
    plan 4;

    my @chars = "\x[0000,0308,0378]".comb;

    is +@chars, 3, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Grapheme 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 3/3";
}

subtest "Codepoint sequence \"\\x[094D,000D]\"", {
    plan 3;

    my @chars = "\x[094D,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0308,000D]\"", {
    plan 3;

    my @chars = "\x[094D,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,000A]\"", {
    plan 3;

    my @chars = "\x[094D,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0308,000A]\"", {
    plan 3;

    my @chars = "\x[094D,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0000]\"", {
    plan 3;

    my @chars = "\x[094D,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0308,0000]\"", {
    plan 3;

    my @chars = "\x[094D,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,094D]\"", {
    plan 2;

    my @chars = "\x[094D,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[094D,0308,094D]\"", {
    plan 2;

    my @chars = "\x[094D,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[094D,0300]\"", {
    plan 2;

    my @chars = "\x[094D,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[094D,0308,0300]\"", {
    plan 2;

    my @chars = "\x[094D,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[094D,200C]\"", {
    plan 2;

    my @chars = "\x[094D,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[094D,0308,200C]\"", {
    plan 2;

    my @chars = "\x[094D,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[094D,200D]\"", {
    plan 2;

    my @chars = "\x[094D,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[094D,0308,200D]\"", {
    plan 2;

    my @chars = "\x[094D,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[094D,1F1E6]\"", {
    plan 3;

    my @chars = "\x[094D,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[094D,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,06DD]\"", {
    plan 3;

    my @chars = "\x[094D,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[094D,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0903]\"", {
    plan 2;

    my @chars = "\x[094D,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[094D,0308,0903]\"", {
    plan 2;

    my @chars = "\x[094D,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[094D,1100]\"", {
    plan 3;

    my @chars = "\x[094D,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0308,1100]\"", {
    plan 3;

    my @chars = "\x[094D,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,1160]\"", {
    plan 3;

    my @chars = "\x[094D,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0308,1160]\"", {
    plan 3;

    my @chars = "\x[094D,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,11A8]\"", {
    plan 3;

    my @chars = "\x[094D,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[094D,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,AC00]\"", {
    plan 3;

    my @chars = "\x[094D,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[094D,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,AC01]\"", {
    plan 3;

    my @chars = "\x[094D,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[094D,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0915]\"", {
    plan 3;

    my @chars = "\x[094D,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0308,0915]\"", {
    plan 3;

    my @chars = "\x[094D,0308,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,00A9]\"", {
    plan 3;

    my @chars = "\x[094D,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[094D,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0020]\"", {
    plan 3;

    my @chars = "\x[094D,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0308,0020]\"", {
    plan 3;

    my @chars = "\x[094D,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0378]\"", {
    plan 3;

    my @chars = "\x[094D,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[094D,0308,0378]\"", {
    plan 3;

    my @chars = "\x[094D,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,000D]\"", {
    plan 3;

    my @chars = "\x[0300,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0308,000D]\"", {
    plan 3;

    my @chars = "\x[0300,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,000A]\"", {
    plan 3;

    my @chars = "\x[0300,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0308,000A]\"", {
    plan 3;

    my @chars = "\x[0300,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0000]\"", {
    plan 3;

    my @chars = "\x[0300,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0308,0000]\"", {
    plan 3;

    my @chars = "\x[0300,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,094D]\"", {
    plan 2;

    my @chars = "\x[0300,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0300,0308,094D]\"", {
    plan 2;

    my @chars = "\x[0300,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0300,0300]\"", {
    plan 2;

    my @chars = "\x[0300,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0300,0308,0300]\"", {
    plan 2;

    my @chars = "\x[0300,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0300,200C]\"", {
    plan 2;

    my @chars = "\x[0300,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0300,0308,200C]\"", {
    plan 2;

    my @chars = "\x[0300,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0300,200D]\"", {
    plan 2;

    my @chars = "\x[0300,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0300,0308,200D]\"", {
    plan 2;

    my @chars = "\x[0300,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0300,1F1E6]\"", {
    plan 3;

    my @chars = "\x[0300,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[0300,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,06DD]\"", {
    plan 3;

    my @chars = "\x[0300,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[0300,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0903]\"", {
    plan 2;

    my @chars = "\x[0300,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0300,0308,0903]\"", {
    plan 2;

    my @chars = "\x[0300,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0300,1100]\"", {
    plan 3;

    my @chars = "\x[0300,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0308,1100]\"", {
    plan 3;

    my @chars = "\x[0300,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,1160]\"", {
    plan 3;

    my @chars = "\x[0300,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0308,1160]\"", {
    plan 3;

    my @chars = "\x[0300,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,11A8]\"", {
    plan 3;

    my @chars = "\x[0300,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[0300,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,AC00]\"", {
    plan 3;

    my @chars = "\x[0300,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[0300,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,AC01]\"", {
    plan 3;

    my @chars = "\x[0300,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[0300,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0915]\"", {
    plan 3;

    my @chars = "\x[0300,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0308,0915]\"", {
    plan 3;

    my @chars = "\x[0300,0308,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,00A9]\"", {
    plan 3;

    my @chars = "\x[0300,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[0300,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0020]\"", {
    plan 3;

    my @chars = "\x[0300,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0308,0020]\"", {
    plan 3;

    my @chars = "\x[0300,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0378]\"", {
    plan 3;

    my @chars = "\x[0300,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0300,0308,0378]\"", {
    plan 3;

    my @chars = "\x[0300,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,000D]\"", {
    plan 3;

    my @chars = "\x[200C,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0308,000D]\"", {
    plan 3;

    my @chars = "\x[200C,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,000A]\"", {
    plan 3;

    my @chars = "\x[200C,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0308,000A]\"", {
    plan 3;

    my @chars = "\x[200C,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0000]\"", {
    plan 3;

    my @chars = "\x[200C,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0308,0000]\"", {
    plan 3;

    my @chars = "\x[200C,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,094D]\"", {
    plan 2;

    my @chars = "\x[200C,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200C,0308,094D]\"", {
    plan 2;

    my @chars = "\x[200C,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200C,0300]\"", {
    plan 2;

    my @chars = "\x[200C,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200C,0308,0300]\"", {
    plan 2;

    my @chars = "\x[200C,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

