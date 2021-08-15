use Test;
plan 9;

#?rakudo.js.browser skip "reading and writing files doesn't work in the browser"
{
    my $test-folder = "S32-str".IO.d ??  "S32-str" !! "t/spec/S32-str";
    $test-folder ~= "/text-samples";
    my $fh = open "$test-folder/shiftjis_sample.txt", :r;
    $fh.encoding('windows-932');
    is-deeply $fh.slurp, "$test-folder/shiftjis_sample_in_utf8.txt".IO.slurp, "shiftjis decoder correctly decodes some sample text";
    $fh.close;
}

is-deeply "shiftjs電子商取引.txt".encode('windows-932').decode('windows-932'), "shiftjs電子商取引.txt", "shiftjis encode and decode are reversible";
is-deeply Buf.new(0xA0).decode('windows-932', :replacement('hello')), 'hello', "shiftjis replacement works with .decode";
is-deeply "電子商♥取引".encode('windows-932', :replacement('ABCD')).decode('windows-932'), "電子商ABCD取引", ".encode with replacement works with more than one char replacements";
is-deeply "電子商♥取引".encode('windows-932', :replacement('A')).decode('windows-932'), "電子商A取引", ".encode with replacement works with one char replacement";
is-deeply 0x3000.chr.encode('windows-932').decode('windows-932'), 0x3000.chr, "Can encode and decode 0x3000 which has ShiftJIS index 0";
dies-ok { Buf.new(0x93).decode('windows-932') }, "ShiftJIS .decode throws when a trailing byte should be there but isn't";

# TODO This test should probably be done for all our encodings and not just this bug
sub test-replacement(:$prepend, :$bad-buf, :$end, :$replacement) {
    my $buf = Buf.new();
    $buf.append($_) for $prepend.encode('windows-932'), $bad-buf, $end.encode('windows-932');
    my $dec = $buf.decode('windows-932', :replacement($replacement));
    is-deeply $dec, "$prepend$replacement$end", "shiftjis replacement {$prepend.raku} + ERROR + {$end.raku}; replacement={$replacement.raku} works with .decode";
}
# Test to make sure that a decode error immediately after a \r works properly
test-replacement(prepend => "\r", bad-buf => Buf.new(0xA0), end => "abc", replacement => "hello");
# Test to make sure that a decode error after a \r, with a \n in the replacement creates a combined grapheme properly
test-replacement(prepend => "\r", bad-buf => Buf.new(0xA0), end => "abc", replacement => "\nhello");
# vim: expandtab shiftwidth=4 ft=raku
