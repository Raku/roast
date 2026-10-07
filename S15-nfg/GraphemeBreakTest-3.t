# Generated from GraphemeBreakTest.txt, Unicode version 18.0.0
# Test lines 600..^800
use Test;
plan 200;

subtest "Codepoint sequence \"\\x[1CF5,000D]\"", {
    plan 3;

    my @chars = "\x[1CF5,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,000D]\"", {
    plan 3;

    my @chars = "\x[1CF5,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,000A]\"", {
    plan 3;

    my @chars = "\x[1CF5,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,000A]\"", {
    plan 3;

    my @chars = "\x[1CF5,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0000]\"", {
    plan 3;

    my @chars = "\x[1CF5,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,0000]\"", {
    plan 3;

    my @chars = "\x[1CF5,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,094D]\"", {
    plan 2;

    my @chars = "\x[1CF5,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,094D]\"", {
    plan 2;

    my @chars = "\x[1CF5,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1CF5,0300]\"", {
    plan 2;

    my @chars = "\x[1CF5,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,0300]\"", {
    plan 2;

    my @chars = "\x[1CF5,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1CF5,200C]\"", {
    plan 2;

    my @chars = "\x[1CF5,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,200C]\"", {
    plan 2;

    my @chars = "\x[1CF5,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1CF5,200D]\"", {
    plan 2;

    my @chars = "\x[1CF5,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,200D]\"", {
    plan 2;

    my @chars = "\x[1CF5,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1CF5,1F1E6]\"", {
    plan 3;

    my @chars = "\x[1CF5,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[1CF5,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,06DD]\"", {
    plan 3;

    my @chars = "\x[1CF5,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[1CF5,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0903]\"", {
    plan 2;

    my @chars = "\x[1CF5,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,0903]\"", {
    plan 2;

    my @chars = "\x[1CF5,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1CF5,1100]\"", {
    plan 3;

    my @chars = "\x[1CF5,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,1100]\"", {
    plan 3;

    my @chars = "\x[1CF5,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,1160]\"", {
    plan 3;

    my @chars = "\x[1CF5,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,1160]\"", {
    plan 3;

    my @chars = "\x[1CF5,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,11A8]\"", {
    plan 3;

    my @chars = "\x[1CF5,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[1CF5,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,AC00]\"", {
    plan 3;

    my @chars = "\x[1CF5,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[1CF5,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,AC01]\"", {
    plan 3;

    my @chars = "\x[1CF5,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[1CF5,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,1CF5]\"", {
    plan 3;

    my @chars = "\x[1CF5,1CF5]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,1CF5]\"", {
    plan 3;

    my @chars = "\x[1CF5,0308,1CF5]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0915]\"", {
    plan 2;

    my @chars = "\x[1CF5,0915]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0915).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,0915]\"", {
    plan 2;

    my @chars = "\x[1CF5,0308,0915]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308, 0x0915).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[1CF5,00A9]\"", {
    plan 3;

    my @chars = "\x[1CF5,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[1CF5,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0020]\"", {
    plan 3;

    my @chars = "\x[1CF5,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,0020]\"", {
    plan 3;

    my @chars = "\x[1CF5,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0378]\"", {
    plan 3;

    my @chars = "\x[1CF5,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[1CF5,0308,0378]\"", {
    plan 3;

    my @chars = "\x[1CF5,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1cf5, 0x0308).NFC, "Grapheme 1/2";
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

subtest "Codepoint sequence \"\\x[0915,1CF5]\"", {
    plan 3;

    my @chars = "\x[0915,1CF5]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0308,1CF5]\"", {
    plan 3;

    my @chars = "\x[0915,0308,1CF5]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0915]\"", {
    plan 3;

    my @chars = "\x[0915,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0308,0915]\"", {
    plan 3;

    my @chars = "\x[0915,0308,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,00A9]\"", {
    plan 3;

    my @chars = "\x[0915,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[0915,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0020]\"", {
    plan 3;

    my @chars = "\x[0915,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0308,0020]\"", {
    plan 3;

    my @chars = "\x[0915,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0378]\"", {
    plan 3;

    my @chars = "\x[0915,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0915,0308,0378]\"", {
    plan 3;

    my @chars = "\x[0915,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0915, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,000D]\"", {
    plan 3;

    my @chars = "\x[00A9,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0308,000D]\"", {
    plan 3;

    my @chars = "\x[00A9,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,000A]\"", {
    plan 3;

    my @chars = "\x[00A9,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0308,000A]\"", {
    plan 3;

    my @chars = "\x[00A9,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0000]\"", {
    plan 3;

    my @chars = "\x[00A9,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0308,0000]\"", {
    plan 3;

    my @chars = "\x[00A9,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,094D]\"", {
    plan 2;

    my @chars = "\x[00A9,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[00A9,0308,094D]\"", {
    plan 2;

    my @chars = "\x[00A9,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[00A9,0300]\"", {
    plan 2;

    my @chars = "\x[00A9,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[00A9,0308,0300]\"", {
    plan 2;

    my @chars = "\x[00A9,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[00A9,200C]\"", {
    plan 2;

    my @chars = "\x[00A9,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[00A9,0308,200C]\"", {
    plan 2;

    my @chars = "\x[00A9,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[00A9,200D]\"", {
    plan 2;

    my @chars = "\x[00A9,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[00A9,0308,200D]\"", {
    plan 2;

    my @chars = "\x[00A9,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[00A9,1F1E6]\"", {
    plan 3;

    my @chars = "\x[00A9,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[00A9,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,06DD]\"", {
    plan 3;

    my @chars = "\x[00A9,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[00A9,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0903]\"", {
    plan 2;

    my @chars = "\x[00A9,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[00A9,0308,0903]\"", {
    plan 2;

    my @chars = "\x[00A9,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[00A9,1100]\"", {
    plan 3;

    my @chars = "\x[00A9,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0308,1100]\"", {
    plan 3;

    my @chars = "\x[00A9,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,1160]\"", {
    plan 3;

    my @chars = "\x[00A9,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0308,1160]\"", {
    plan 3;

    my @chars = "\x[00A9,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,11A8]\"", {
    plan 3;

    my @chars = "\x[00A9,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[00A9,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,AC00]\"", {
    plan 3;

    my @chars = "\x[00A9,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[00A9,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,AC01]\"", {
    plan 3;

    my @chars = "\x[00A9,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[00A9,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,1CF5]\"", {
    plan 3;

    my @chars = "\x[00A9,1CF5]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0308,1CF5]\"", {
    plan 3;

    my @chars = "\x[00A9,0308,1CF5]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0915]\"", {
    plan 3;

    my @chars = "\x[00A9,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0308,0915]\"", {
    plan 3;

    my @chars = "\x[00A9,0308,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,00A9]\"", {
    plan 3;

    my @chars = "\x[00A9,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[00A9,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0020]\"", {
    plan 3;

    my @chars = "\x[00A9,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0308,0020]\"", {
    plan 3;

    my @chars = "\x[00A9,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0378]\"", {
    plan 3;

    my @chars = "\x[00A9,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[00A9,0308,0378]\"", {
    plan 3;

    my @chars = "\x[00A9,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x00a9, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,000D]\"", {
    plan 3;

    my @chars = "\x[0020,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0308,000D]\"", {
    plan 3;

    my @chars = "\x[0020,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,000A]\"", {
    plan 3;

    my @chars = "\x[0020,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0308,000A]\"", {
    plan 3;

    my @chars = "\x[0020,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0000]\"", {
    plan 3;

    my @chars = "\x[0020,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0308,0000]\"", {
    plan 3;

    my @chars = "\x[0020,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,094D]\"", {
    plan 2;

    my @chars = "\x[0020,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0020,0308,094D]\"", {
    plan 2;

    my @chars = "\x[0020,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0020,0300]\"", {
    plan 2;

    my @chars = "\x[0020,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0020,0308,0300]\"", {
    plan 2;

    my @chars = "\x[0020,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0020,200C]\"", {
    plan 2;

    my @chars = "\x[0020,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0020,0308,200C]\"", {
    plan 2;

    my @chars = "\x[0020,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0020,200D]\"", {
    plan 2;

    my @chars = "\x[0020,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0020,0308,200D]\"", {
    plan 2;

    my @chars = "\x[0020,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0020,1F1E6]\"", {
    plan 3;

    my @chars = "\x[0020,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[0020,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,06DD]\"", {
    plan 3;

    my @chars = "\x[0020,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[0020,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0903]\"", {
    plan 2;

    my @chars = "\x[0020,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0020,0308,0903]\"", {
    plan 2;

    my @chars = "\x[0020,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0020,1100]\"", {
    plan 3;

    my @chars = "\x[0020,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0308,1100]\"", {
    plan 3;

    my @chars = "\x[0020,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,1160]\"", {
    plan 3;

    my @chars = "\x[0020,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0308,1160]\"", {
    plan 3;

    my @chars = "\x[0020,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,11A8]\"", {
    plan 3;

    my @chars = "\x[0020,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[0020,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,AC00]\"", {
    plan 3;

    my @chars = "\x[0020,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[0020,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,AC01]\"", {
    plan 3;

    my @chars = "\x[0020,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[0020,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,1CF5]\"", {
    plan 3;

    my @chars = "\x[0020,1CF5]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0308,1CF5]\"", {
    plan 3;

    my @chars = "\x[0020,0308,1CF5]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0915]\"", {
    plan 3;

    my @chars = "\x[0020,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0308,0915]\"", {
    plan 3;

    my @chars = "\x[0020,0308,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,00A9]\"", {
    plan 3;

    my @chars = "\x[0020,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[0020,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0020]\"", {
    plan 3;

    my @chars = "\x[0020,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0308,0020]\"", {
    plan 3;

    my @chars = "\x[0020,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0378]\"", {
    plan 3;

    my @chars = "\x[0020,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0020,0308,0378]\"", {
    plan 3;

    my @chars = "\x[0020,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0020, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,000D]\"", {
    plan 3;

    my @chars = "\x[0378,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0308,000D]\"", {
    plan 3;

    my @chars = "\x[0378,0308,000D]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,000A]\"", {
    plan 3;

    my @chars = "\x[0378,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0308,000A]\"", {
    plan 3;

    my @chars = "\x[0378,0308,000A]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0000]\"", {
    plan 3;

    my @chars = "\x[0378,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0308,0000]\"", {
    plan 3;

    my @chars = "\x[0378,0308,0000]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,094D]\"", {
    plan 2;

    my @chars = "\x[0378,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0378,0308,094D]\"", {
    plan 2;

    my @chars = "\x[0378,0308,094D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308, 0x094d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0378,0300]\"", {
    plan 2;

    my @chars = "\x[0378,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0378,0308,0300]\"", {
    plan 2;

    my @chars = "\x[0378,0308,0300]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308, 0x0300).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0378,200C]\"", {
    plan 2;

    my @chars = "\x[0378,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0378,0308,200C]\"", {
    plan 2;

    my @chars = "\x[0378,0308,200C]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308, 0x200c).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0378,200D]\"", {
    plan 2;

    my @chars = "\x[0378,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0378,0308,200D]\"", {
    plan 2;

    my @chars = "\x[0378,0308,200D]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308, 0x200d).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0378,1F1E6]\"", {
    plan 3;

    my @chars = "\x[0378,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0308,1F1E6]\"", {
    plan 3;

    my @chars = "\x[0378,0308,1F1E6]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,06DD]\"", {
    plan 3;

    my @chars = "\x[0378,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0308,06DD]\"", {
    plan 3;

    my @chars = "\x[0378,0308,06DD]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0903]\"", {
    plan 2;

    my @chars = "\x[0378,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0378,0308,0903]\"", {
    plan 2;

    my @chars = "\x[0378,0308,0903]".comb;

    is +@chars, 1, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308, 0x0903).NFC, "Grapheme 1/1";
}

subtest "Codepoint sequence \"\\x[0378,1100]\"", {
    plan 3;

    my @chars = "\x[0378,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0308,1100]\"", {
    plan 3;

    my @chars = "\x[0378,0308,1100]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,1160]\"", {
    plan 3;

    my @chars = "\x[0378,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0308,1160]\"", {
    plan 3;

    my @chars = "\x[0378,0308,1160]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,11A8]\"", {
    plan 3;

    my @chars = "\x[0378,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0308,11A8]\"", {
    plan 3;

    my @chars = "\x[0378,0308,11A8]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,AC00]\"", {
    plan 3;

    my @chars = "\x[0378,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0308,AC00]\"", {
    plan 3;

    my @chars = "\x[0378,0308,AC00]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,AC01]\"", {
    plan 3;

    my @chars = "\x[0378,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0308,AC01]\"", {
    plan 3;

    my @chars = "\x[0378,0308,AC01]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,1CF5]\"", {
    plan 3;

    my @chars = "\x[0378,1CF5]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0308,1CF5]\"", {
    plan 3;

    my @chars = "\x[0378,0308,1CF5]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0915]\"", {
    plan 3;

    my @chars = "\x[0378,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0308,0915]\"", {
    plan 3;

    my @chars = "\x[0378,0308,0915]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,00A9]\"", {
    plan 3;

    my @chars = "\x[0378,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0308,00A9]\"", {
    plan 3;

    my @chars = "\x[0378,0308,00A9]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0020]\"", {
    plan 3;

    my @chars = "\x[0378,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0308,0020]\"", {
    plan 3;

    my @chars = "\x[0378,0308,0020]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0378]\"", {
    plan 3;

    my @chars = "\x[0378,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

subtest "Codepoint sequence \"\\x[0378,0308,0378]\"", {
    plan 3;

    my @chars = "\x[0378,0308,0378]".comb;

    is +@chars, 2, "Correct number of graphemes";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0378, 0x0308).NFC, "Grapheme 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Grapheme 2/2";
}

