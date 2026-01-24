# Generated from GraphemeBreakTest.txt, Unicode version 17.0.0
# Test lines 200..^400
use Test;
plan 200;

subtest "Codepoint sequence \"\\x[200C,200C]\"", {
    plan 2;

    my @chars = "\x[200C,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200C,0308,200C]\"", {
    plan 2;

    my @chars = "\x[200C,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200C,200D]\"", {
    plan 2;

    my @chars = "\x[200C,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200C,0308,200D]\"", {
    plan 2;

    my @chars = "\x[200C,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200C,1F1E6]\"", {
    plan 3;

    my @chars = "\x[200C,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[200C,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,06DD]\"", {
    plan 3;

    my @chars = "\x[200C,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[200C,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0903]\"", {
    plan 2;

    my @chars = "\x[200C,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200C,0308,0903]\"", {
    plan 2;

    my @chars = "\x[200C,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200C,1100]\"", {
    plan 3;

    my @chars = "\x[200C,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0308,1100]\"", {
    plan 3;

    my @chars = "\x[200C,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,1160]\"", {
    plan 3;

    my @chars = "\x[200C,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0308,1160]\"", {
    plan 3;

    my @chars = "\x[200C,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,11A8]\"", {
    plan 3;

    my @chars = "\x[200C,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[200C,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,AC00]\"", {
    plan 3;

    my @chars = "\x[200C,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[200C,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,AC01]\"", {
    plan 3;

    my @chars = "\x[200C,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[200C,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0915]\"", {
    plan 3;

    my @chars = "\x[200C,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0308,0915]\"", {
    plan 3;

    my @chars = "\x[200C,0308,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,00A9]\"", {
    plan 3;

    my @chars = "\x[200C,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[200C,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0020]\"", {
    plan 3;

    my @chars = "\x[200C,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0308,0020]\"", {
    plan 3;

    my @chars = "\x[200C,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0378]\"", {
    plan 3;

    my @chars = "\x[200C,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200C,0308,0378]\"", {
    plan 3;

    my @chars = "\x[200C,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,000D]\"", {
    plan 3;

    my @chars = "\x[200D,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0308,000D]\"", {
    plan 3;

    my @chars = "\x[200D,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,000A]\"", {
    plan 3;

    my @chars = "\x[200D,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0308,000A]\"", {
    plan 3;

    my @chars = "\x[200D,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0000]\"", {
    plan 3;

    my @chars = "\x[200D,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0308,0000]\"", {
    plan 3;

    my @chars = "\x[200D,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,094D]\"", {
    plan 2;

    my @chars = "\x[200D,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200D,0308,094D]\"", {
    plan 2;

    my @chars = "\x[200D,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200D,0300]\"", {
    plan 2;

    my @chars = "\x[200D,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200D,0308,0300]\"", {
    plan 2;

    my @chars = "\x[200D,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200D,200C]\"", {
    plan 2;

    my @chars = "\x[200D,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200D,0308,200C]\"", {
    plan 2;

    my @chars = "\x[200D,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200D,200D]\"", {
    plan 2;

    my @chars = "\x[200D,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200D,0308,200D]\"", {
    plan 2;

    my @chars = "\x[200D,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200D,1F1E6]\"", {
    plan 3;

    my @chars = "\x[200D,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[200D,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,06DD]\"", {
    plan 3;

    my @chars = "\x[200D,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[200D,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0903]\"", {
    plan 2;

    my @chars = "\x[200D,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200D,0308,0903]\"", {
    plan 2;

    my @chars = "\x[200D,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[200D,1100]\"", {
    plan 3;

    my @chars = "\x[200D,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0308,1100]\"", {
    plan 3;

    my @chars = "\x[200D,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,1160]\"", {
    plan 3;

    my @chars = "\x[200D,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0308,1160]\"", {
    plan 3;

    my @chars = "\x[200D,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,11A8]\"", {
    plan 3;

    my @chars = "\x[200D,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[200D,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,AC00]\"", {
    plan 3;

    my @chars = "\x[200D,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[200D,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,AC01]\"", {
    plan 3;

    my @chars = "\x[200D,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[200D,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0915]\"", {
    plan 3;

    my @chars = "\x[200D,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0308,0915]\"", {
    plan 3;

    my @chars = "\x[200D,0308,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,00A9]\"", {
    plan 3;

    my @chars = "\x[200D,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[200D,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0020]\"", {
    plan 3;

    my @chars = "\x[200D,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0308,0020]\"", {
    plan 3;

    my @chars = "\x[200D,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0378]\"", {
    plan 3;

    my @chars = "\x[200D,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[200D,0308,0378]\"", {
    plan 3;

    my @chars = "\x[200D,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,000D]\"", {
    plan 3;

    my @chars = "\x[1F1E6,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,000D]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,000A]\"", {
    plan 3;

    my @chars = "\x[1F1E6,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,000A]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0000]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,0000]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,094D]\"", {
    plan 2;

    my @chars = "\x[1F1E6,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,094D]\"", {
    plan 2;

    my @chars = "\x[1F1E6,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1F1E6,0300]\"", {
    plan 2;

    my @chars = "\x[1F1E6,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,0300]\"", {
    plan 2;

    my @chars = "\x[1F1E6,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1F1E6,200C]\"", {
    plan 2;

    my @chars = "\x[1F1E6,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,200C]\"", {
    plan 2;

    my @chars = "\x[1F1E6,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1F1E6,200D]\"", {
    plan 2;

    my @chars = "\x[1F1E6,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,200D]\"", {
    plan 2;

    my @chars = "\x[1F1E6,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1F1E6,1F1E6]\"", {
    plan 2;

    my @chars = "\x[1F1E6,1F1E6]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x1f1e6).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,06DD]\"", {
    plan 3;

    my @chars = "\x[1F1E6,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0903]\"", {
    plan 2;

    my @chars = "\x[1F1E6,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,0903]\"", {
    plan 2;

    my @chars = "\x[1F1E6,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1F1E6,1100]\"", {
    plan 3;

    my @chars = "\x[1F1E6,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,1100]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,1160]\"", {
    plan 3;

    my @chars = "\x[1F1E6,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,1160]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,11A8]\"", {
    plan 3;

    my @chars = "\x[1F1E6,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,AC00]\"", {
    plan 3;

    my @chars = "\x[1F1E6,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,AC01]\"", {
    plan 3;

    my @chars = "\x[1F1E6,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0915]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,0915]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,00A9]\"", {
    plan 3;

    my @chars = "\x[1F1E6,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0020]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,0020]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0378]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1F1E6,0308,0378]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,000D]\"", {
    plan 3;

    my @chars = "\x[06DD,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,0308,000D]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,000A]\"", {
    plan 3;

    my @chars = "\x[06DD,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,0308,000A]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,0000]\"", {
    plan 3;

    my @chars = "\x[06DD,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,0308,0000]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,094D]\"", {
    plan 2;

    my @chars = "\x[06DD,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0308,094D]\"", {
    plan 2;

    my @chars = "\x[06DD,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0300]\"", {
    plan 2;

    my @chars = "\x[06DD,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0308,0300]\"", {
    plan 2;

    my @chars = "\x[06DD,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,200C]\"", {
    plan 2;

    my @chars = "\x[06DD,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0308,200C]\"", {
    plan 2;

    my @chars = "\x[06DD,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,200D]\"", {
    plan 2;

    my @chars = "\x[06DD,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0308,200D]\"", {
    plan 2;

    my @chars = "\x[06DD,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,1F1E6]\"", {
    plan 2;

    my @chars = "\x[06DD,1F1E6]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x1f1e6).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,06DD]\"", {
    plan 2;

    my @chars = "\x[06DD,06DD]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x06dd).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,0903]\"", {
    plan 2;

    my @chars = "\x[06DD,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0308,0903]\"", {
    plan 2;

    my @chars = "\x[06DD,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,1100]\"", {
    plan 2;

    my @chars = "\x[06DD,1100]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x1100).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0308,1100]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,1160]\"", {
    plan 2;

    my @chars = "\x[06DD,1160]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x1160).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0308,1160]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,11A8]\"", {
    plan 2;

    my @chars = "\x[06DD,11A8]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x11a8).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,AC00]\"", {
    plan 2;

    my @chars = "\x[06DD,AC00]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0xac00).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,AC01]\"", {
    plan 2;

    my @chars = "\x[06DD,AC01]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0xac01).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,0915]\"", {
    plan 2;

    my @chars = "\x[06DD,0915]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0915).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0308,0915]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,00A9]\"", {
    plan 2;

    my @chars = "\x[06DD,00A9]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x00a9).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,0020]\"", {
    plan 2;

    my @chars = "\x[06DD,0020]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0020).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0308,0020]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[06DD,0378]\"", {
    plan 2;

    my @chars = "\x[06DD,0378]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0378).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[06DD,0308,0378]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,000D]\"", {
    plan 3;

    my @chars = "\x[0903,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0308,000D]\"", {
    plan 3;

    my @chars = "\x[0903,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,000A]\"", {
    plan 3;

    my @chars = "\x[0903,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0308,000A]\"", {
    plan 3;

    my @chars = "\x[0903,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0000]\"", {
    plan 3;

    my @chars = "\x[0903,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0308,0000]\"", {
    plan 3;

    my @chars = "\x[0903,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,094D]\"", {
    plan 2;

    my @chars = "\x[0903,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0903,0308,094D]\"", {
    plan 2;

    my @chars = "\x[0903,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0903,0300]\"", {
    plan 2;

    my @chars = "\x[0903,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0903,0308,0300]\"", {
    plan 2;

    my @chars = "\x[0903,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0903,200C]\"", {
    plan 2;

    my @chars = "\x[0903,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0903,0308,200C]\"", {
    plan 2;

    my @chars = "\x[0903,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0903,200D]\"", {
    plan 2;

    my @chars = "\x[0903,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0903,0308,200D]\"", {
    plan 2;

    my @chars = "\x[0903,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0903,1F1E6]\"", {
    plan 3;

    my @chars = "\x[0903,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[0903,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,06DD]\"", {
    plan 3;

    my @chars = "\x[0903,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[0903,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0903]\"", {
    plan 2;

    my @chars = "\x[0903,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0903,0308,0903]\"", {
    plan 2;

    my @chars = "\x[0903,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0903,1100]\"", {
    plan 3;

    my @chars = "\x[0903,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0308,1100]\"", {
    plan 3;

    my @chars = "\x[0903,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,1160]\"", {
    plan 3;

    my @chars = "\x[0903,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0308,1160]\"", {
    plan 3;

    my @chars = "\x[0903,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,11A8]\"", {
    plan 3;

    my @chars = "\x[0903,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[0903,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,AC00]\"", {
    plan 3;

    my @chars = "\x[0903,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[0903,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,AC01]\"", {
    plan 3;

    my @chars = "\x[0903,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[0903,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0915]\"", {
    plan 3;

    my @chars = "\x[0903,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0308,0915]\"", {
    plan 3;

    my @chars = "\x[0903,0308,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,00A9]\"", {
    plan 3;

    my @chars = "\x[0903,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[0903,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0020]\"", {
    plan 3;

    my @chars = "\x[0903,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0308,0020]\"", {
    plan 3;

    my @chars = "\x[0903,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0378]\"", {
    plan 3;

    my @chars = "\x[0903,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0903,0308,0378]\"", {
    plan 3;

    my @chars = "\x[0903,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,000D]\"", {
    plan 3;

    my @chars = "\x[1100,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,0308,000D]\"", {
    plan 3;

    my @chars = "\x[1100,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,000A]\"", {
    plan 3;

    my @chars = "\x[1100,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,0308,000A]\"", {
    plan 3;

    my @chars = "\x[1100,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,0000]\"", {
    plan 3;

    my @chars = "\x[1100,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,0308,0000]\"", {
    plan 3;

    my @chars = "\x[1100,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,094D]\"", {
    plan 2;

    my @chars = "\x[1100,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1100,0308,094D]\"", {
    plan 2;

    my @chars = "\x[1100,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1100,0300]\"", {
    plan 2;

    my @chars = "\x[1100,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1100,0308,0300]\"", {
    plan 2;

    my @chars = "\x[1100,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1100,200C]\"", {
    plan 2;

    my @chars = "\x[1100,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1100,0308,200C]\"", {
    plan 2;

    my @chars = "\x[1100,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1100,200D]\"", {
    plan 2;

    my @chars = "\x[1100,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1100,0308,200D]\"", {
    plan 2;

    my @chars = "\x[1100,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1100,1F1E6]\"", {
    plan 3;

    my @chars = "\x[1100,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[1100,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,06DD]\"", {
    plan 3;

    my @chars = "\x[1100,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[1100,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1100,0903]\"", {
    plan 2;

    my @chars = "\x[1100,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1100,0308,0903]\"", {
    plan 2;

    my @chars = "\x[1100,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

