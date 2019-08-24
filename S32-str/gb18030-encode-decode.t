use Test;
plan 5;

{
    my $test-folder = "S32-str".IO.d ??  "S32-str" !! "t/spec/S32-str";
    $test-folder ~= "/text-samples";
    my $fh = open "$test-folder/gb18030_sample_in_gb18030.txt", :r;
    $fh.encoding('gb18030');
    is-deeply $fh.slurp, "$test-folder/gb18030_sample_in_utf8.txt".IO.slurp, "Testing decodestream";
    $fh.close;
}

my @values_gb18030 = 27988, 38451, 27743, 22836, 22812, 10, 175, 426, 51981, 36684, 55172, 54, 100, 55107;
my @keys_gb18030 = 228, 177, 209, 244, 189, 173, 205, 183, 210, 185, 10, 129, 48, 133, 52, 129, 48, 156, 48, 131, 51, 246, 52, 222, 71, 131, 54, 187, 53, 54, 100, 131, 54, 181, 48;

run_test @values_gb18030, @keys_gb18030, 'gb18030';

is-deeply "盼望着,盼望着,东风来了,春天的脚步近了。".encode('gb18030', :replacement('ABCD')).decode('gb18030'), "ABCD盼望着,盼望着,东风来了,ABCD春天的脚步近了。", "Encode with replacement works with more than one char replacements";

is-deeply "∢盼望着,盼望着,东风来了,㌳春天的脚步近了。".encode('gb18030', :replacement("(未知字符!∢)")).decode('gb18030'), "(未知字符!∢)∢盼望着,盼望着,东风来了,(未知字符!∢)㌳春天的脚步近了。", "Encode with replacement works with gb18030 character replacements";

sub test_encode (@values, @keys, $encoding) {
    my $chrs = @values.chrs;
    my $buf = $chrs.encode($encoding);
    is $buf.list, @keys.list, "Test encoding from Unicode to $encoding";
}
sub run_test (@values, @keys, $encoding) {
    test_encode @values, @keys, $encoding;
    is-deeply Buf.new(@keys).decode($encoding), @values.chrs, "Test decoding from $encoding to Unicode";
}
