use v6-alpha;

use Test;

# L<S16/"Filehandles, files, and directories"/"open">
# L<S16/"Filehandles, files, and directories"/"close">
# L<S16/Unfiled/IO.readline>

=begin pod

I/O tests

=end pod

plan 57;

if $*OS eq "browser" {
  skip_rest "Programs running in browsers don't have access to regular IO.";
  exit;
}


sub nonce () { return (".$*PID." ~ int rand 1000) }
my $filename = 'tempfile' ~ nonce();

# create and write a file

my $out = open($filename, :w);
isa_ok($out, 'IO');
$out.say("Hello World");
say($out: "Foo Bar Baz");
$out.say("The End");
ok($out.close, 'file closed okay');

# read the file all possible ways

my $in1 = open($filename);
isa_ok($in1, 'IO');
my $line1a = readline($in1);
is($line1a, "Hello World", 'readline($in) worked (and autochomps)');
my $line1b = readline($in1);
is($line1b, "Foo Bar Baz", 'readline($in) worked (and autochomps)');
my $line1c = readline($in1);
is($line1c, "The End", 'readline($in) worked');
ok($in1.close, 'file closed okay (1)');

my $in2 = open($filename);
isa_ok($in2, 'IO');
my $line2a = $in2.readline();
is($line2a, "Hello World", '$in.readline() worked');
my $line2b = $in2.readline();
is($line2b, "Foo Bar Baz", '$in.readline() worked');
my $line2c = $in2.readline();
is($line2c, "The End", '$in.readline() worked');
ok($in2.close, 'file closed okay (2)');

# L<S02/Files/you now write>
my $in3 = open($filename);
isa_ok($in3, 'IO');
my $line3a = =$in3;
is($line3a, "Hello World", 'unary =$in worked');
my $line3b = =$in3;
is($line3b, "Foo Bar Baz", 'unary =$in worked');
my $line3c = =$in3;
is($line3c, "The End", 'unary =$in worked');
ok($in3.close, 'file closed okay (3)');

# append to the file

my $append = open($filename, :a);
isa_ok($append, 'IO');
$append.say("... Its not over yet!");
ok($append.close, 'file closed okay (append)');

# now read in in list context

my $in4 = open($filename);
isa_ok($in4, 'IO');
my @lines4 = readline($in4);
is(+@lines4, 4, 'we got four lines from the file');
is(@lines4[0], "Hello World", 'readline($in) worked in list context');
is(@lines4[1], "Foo Bar Baz", 'readline($in) worked in list context');
is(@lines4[2], "The End", 'readline($in) worked in list context');
is(@lines4[3], "... Its not over yet!", 'readline($in) worked in list context');
ok($in4.close, 'file closed okay (4)');

my $in5 = open($filename);
isa_ok($in5, 'IO');
my @lines5 = $in5.readline();
is(+@lines5, 4, 'we got four lines from the file');
is(@lines5[0], "Hello World", '$in.readline() worked in list context');
is(@lines5[1], "Foo Bar Baz", '$in.readline() worked in list context');
is(@lines5[2], "The End", '$in.readline() worked in list context');
is(@lines5[3], "... Its not over yet!", '$in.readline() worked in list context');
ok($in5.close, 'file closed okay (5)');

my $in6 = open($filename);
isa_ok($in6, 'IO');
my @lines6 = =$in6;
is(+@lines6, 4, 'we got four lines from the file');
is(@lines6[0], "Hello World", 'unary =$in worked in list context');
is(@lines6[1], "Foo Bar Baz", 'unary =$in worked in list context');
is(@lines6[2], "The End", 'unary =$in worked in list context');
is(@lines6[3], "... Its not over yet!", 'unary =$in worked in list context');
ok($in6.close, 'file closed okay (6)');

# test reading a file into an array and then closing before 
# doing anything with the array (in other words, is pugs too lazy)
my $in7 = open($filename);
isa_ok($in7, 'IO');
my @lines7 = readline($in7);
ok($in7.close, 'file closed okay (7)');
is(+@lines7, 4, 'we got four lines from the file (lazily)');
is(@lines7[0], "Hello World", 'readline($in) worked in list context');
is(@lines7[1], "Foo Bar Baz", 'readline($in) worked in list context');
is(@lines7[2], "The End", 'readline($in) worked in list context');
is(@lines7[3], "... Its not over yet!", 'readline($in) worked in list context');

#now be sure to delete the file as well

is(unlink($filename), 1, 'file has been removed');

# new file for testing other types of open() calls

my $out8 = open($filename, :w);
isa_ok($out8, 'IO');
$out8.say("Hello World");
ok($out8.close, 'file closed okay (out8)');

my $in8 = open($filename);
isa_ok($in8, 'IO');
my $line8_1 = readline($in8);
is($line8_1, "Hello World", 'readline($in) worked');
ok($in8.close, 'file closed okay (in8)');

my $fh9 = open($filename, :r, :w);  # was "<+" ? 
isa_ok($fh9, 'IO');
#my $line9_1 = readline($fh9);
#is($line9_1, "Hello World");
#$fh9.say("Second line");
ok($fh9.close, 'file closed okay (9)');

#my $in9 = open($filename);
#isa_ok($in9, 'IO');
#my $line9_1 = readline($in9);
#my $line9_2 = readline($in9);
#is($line9_1, "Hello World", 'readline($in) worked');
#is($line9_2, "Second line", 'readline($in) worked');

my $fh10 = open($filename, :rw);  # was "<+" ? 
isa_ok($fh10, 'IO');
#ok($fh10.close, 'file closed okay (10)');

# This test fails on win32; skip it for now.
if $*OS eq any <MSWin32 mingw msys cygwin> {
    unlink($filename);
    #?pugs todo 'bug'
    flunk('skip unlink() test - erratic behaviour on win32');
}
else {
    ok(unlink($filename), 'file has been removed');
}
