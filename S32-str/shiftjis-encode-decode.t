use Test;
plan 7;

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

# vim: expandtab shiftwidth=4
