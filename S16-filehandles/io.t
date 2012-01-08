use v6;

use Test;

# L<S32::IO/IO::File/open>
# old: L<S16/"Filehandles, files, and directories"/"open">
# old: L<S16/"Filehandles, files, and directories"/"close">
# old: L<S16/Unfiled/IO.get>

=begin pod

I/O tests

=end pod

plan 83;

#?pugs emit if $*OS eq "browser" {
#?pugs emit   skip_rest "Programs running in browsers don't have access to regular IO.";
#?pugs emit   exit;
#?pugs emit }


sub nonce () { return ".{$*PID}." ~ (1..1000).pick() }
my $filename = 'tempfile_filehandles_io' ~ nonce();

# create and write a file

my $out = open($filename, :w);
#?niecza todo 'open does not yet produce an IO object'
isa_ok($out, IO);
$out.say("Hello World");
$out.say("Foo Bar Baz");
$out.say("The End");
ok($out.close, 'file closed okay');

# read the file all possible ways

my $in1 = open($filename);
#?niecza todo 'open does not yet produce an IO object'
isa_ok($in1, IO);
my $line1a = get($in1);
is($line1a, "Hello World", 'get($in) worked (and autochomps)');
#?niecza skip 'IO.ins NYI'
is $in1.ins, 1, 'read one line (.ins)';
my $line1b = get($in1);
is($line1b, "Foo Bar Baz", 'get($in) worked (and autochomps)');
#?niecza skip 'IO.ins NYI'
is $in1.ins, 2, 'read two lines (.ins)';
my $line1c = get($in1);
is($line1c, "The End", 'get($in) worked');
#?niecza skip 'IO.ins NYI'
is $in1.ins, 3, 'read three lines (.ins)';
ok($in1.close, 'file closed okay (1)');

my $in2 = open($filename);
#?niecza todo 'open does not yet produce an IO object'
isa_ok($in2, IO);
my $line2a = $in2.get();
is($line2a, "Hello World", '$in.get() worked');
my $line2b = $in2.get();
is($line2b, "Foo Bar Baz", '$in.get() worked');
my $line2c = $in2.get();
is($line2c, "The End", '$in.get() worked');
ok($in2.close, 'file closed okay (2)');

# L<S02/Files/you now write>
my $in3 = open($filename);
#?niecza todo 'open does not yet produce an IO object'
isa_ok($in3, IO);
{
    my $line3a = $in3.get;
    is($line3a, "Hello World", '$in.get worked(1)');
    my $line3b = $in3.get;
    is($line3b, "Foo Bar Baz", '$in.get worked(2)');
    my $line3c = $in3.get;
    is($line3c, "The End", '$in.get worked(3)');
}
ok($in3.close, 'file closed okay (3)');

# append to the file

my $append = open($filename, :a);
#?niecza todo 'open does not yet produce an IO object'
isa_ok($append, IO);
$append.say("... Its not over yet!");
ok($append.close, 'file closed okay (append)');

# now read in in list context

my $in4 = open($filename);
#?niecza todo 'open does not yet produce an IO object'
isa_ok($in4, IO);
my @lines4 = lines($in4);
is(+@lines4, 4, 'we got four lines from the file');
#?niecza skip 'IO.ins NYI'
is $in4.ins, 4, 'same with .ins';
is(@lines4[0], "Hello World", 'lines($in) worked in list context');
is(@lines4[1], "Foo Bar Baz", 'lines($in) worked in list context');
is(@lines4[2], "The End", 'lines($in) worked in list context');
is(@lines4[3], "... Its not over yet!", 'lines($in) worked in list context');
ok($in4.close, 'file closed okay (4)');

#?rakudo skip "prototype of sub lines(...) doesn't have limit yet"
{
my $in5 = open($filename);
#?niecza todo 'open does not yet produce an IO object'
isa_ok($in5, IO);
my @lines5 = lines($in5, 3);
is(+@lines5, 3, 'we got two lines from the file');
#?niecza skip 'IO.ins NYI'
is $in5.ins, 3, 'same with .ins';
is(@lines5[0], "Hello World", 'lines($in) worked in list context');
is(@lines5[1], "Foo Bar Baz", 'lines($in) worked in list context');
is(@lines5[2], "The End", 'lines($in) worked in list context');
ok($in5.close, 'file closed okay (5)');
}

my $in6 = open($filename);
#?niecza todo 'open does not yet produce an IO object'
isa_ok($in6, IO);
my @lines6 = $in6.lines();
is(+@lines6, 4, 'we got four lines from the file');
is(@lines6[0], "Hello World", '$in.lines() worked in list context');
is(@lines6[1], "Foo Bar Baz", '$in.lines() worked in list context');
is(@lines6[2], "The End", '$in.lines() worked in list context');
is(@lines6[3], "... Its not over yet!", '$in.lines() worked in list context');
ok($in6.close, 'file closed okay (6)');

my $in7 = open($filename);
#?niecza todo 'open does not yet produce an IO object'
isa_ok($in7, IO);
my @lines7 = $in7.lines;
is(+@lines7, 4, 'we got four lines from the file');
is(@lines7[0], "Hello World", '$in.lines worked in list context');
is(@lines7[1], "Foo Bar Baz", '$in.lines worked in list context');
is(@lines7[2], "The End", '$in.lines worked in list context');
is(@lines7[3], "... Its not over yet!", '$in.lines worked in list context');
ok($in7.close, 'file closed okay (7)');

{
# test reading a file into an array and then closing before 
# doing anything with the array (in other words, is pugs too lazy)
my $in8 = open($filename);
#?niecza todo 'open does not yet produce an IO object'
isa_ok($in8, IO);
my @lines8 = $in8.lines(3);
push @lines8, "and finally" ~ $in8.get;
ok($in8.close, 'file closed okay (8)');
is(+@lines8, 4, 'we got four lines from the file (lazily)');
is(@lines8[0], "Hello World", 'lines($in,3) worked in list context');
is(@lines8[1], "Foo Bar Baz", 'lines($in,3) worked in list context');
is(@lines8[2], "The End", 'lines($in,3) worked in list context');
#?rakudo todo 'nom regression'
is(@lines8[3], "and finally... Its not over yet!", 'get($in) worked after lines($in,$n)');
}

#now be sure to delete the file as well
ok(unlink($filename), 'file has been removed');

# new file for testing other types of open() calls


my $out8 = open($filename, :w);
#?niecza todo 'open does not yet produce an IO object'
isa_ok($out8, IO);
$out8.say("Hello World");
ok($out8.close, 'file closed okay (out8)');

my $in8 = open($filename);
#?niecza todo 'open does not yet produce an IO object'
isa_ok($in8, IO);
my $line8_1 = get($in8);
is($line8_1, "Hello World", 'get($in) worked');
ok($in8.close, 'file closed okay (in8)');

#?niecza skip 'Not yet able to open both :r and :w'
{
    my $fh9 = open($filename, :r, :w);  # was "<+" ? 
    isa_ok($fh9, IO);
    #my $line9_1 = get($fh9);
    #is($line9_1, "Hello World");
    #$fh9.say("Second line");
    ok($fh9.close, 'file closed okay (9)');
}

#my $in9 = open($filename);
#isa_ok($in9, IO);
#my $line9_1 = get($in9);
#my $line9_2 = get($in9);
#is($line9_1, "Hello World", 'get($in) worked');
#is($line9_2, "Second line", 'get($in) worked');

#?rakudo skip ':rw on open() unimplemented'
#?niecza skip 'Not yet able to open both :r and :w'
{
    my $fh10 = open($filename, :rw);  # was "<+" ? 
    isa_ok($fh10, IO);
    #ok($fh10.close, 'file closed okay (10)');
}

# RT #65348
{
    my $rt65348_out = open($filename, :w);
    #?niecza todo 'open does not yet produce an IO object'
    isa_ok $rt65348_out, IO;
    $rt65348_out.say( 'RT #65348' );
    $rt65348_out.say( '13.37' );
    $rt65348_out.say( '42.17' );
    ok $rt65348_out.close, 'close worked (rt65348 out)';

    my $rt65348_in = open( $filename );
    #?niecza todo 'open does not yet produce an IO object'
    isa_ok $rt65348_in, IO;
    my @list_context = ($rt65348_in.get);
    is +@list_context, 1, '.get in list context reads only one line';
    ok $rt65348_in.get.Int ~~ Int, '.get.Int gets int';
    is $rt65348_in.get.Int, 42, '.get.Int gets the right int';
    ok $rt65348_in.close, 'close worked (rt65348 in)';
}

#?pugs todo 'buggy on Win32'
ok(unlink($filename), 'file has been removed');
nok $filename.IO ~~ :e, '... and the tempfile is gone, really';

#?niecza skip ':bin NYI'
{
    my $binary_out_fh = open($filename, :w, :bin);
    #?niecza todo 'open does not yet produce an IO object'
    isa_ok($binary_out_fh, IO);
    $binary_out_fh.write("föö".encode("ISO-8859-1"));
    ok($binary_out_fh.close(), "file closed OK");
}

#?niecza skip ':bin NYI'
{
    my $binary_in_fh = open($filename, :r, :bin);
    #?niecza todo 'open does not yet produce an IO object'
    isa_ok($binary_in_fh, IO);
    my $buf = $binary_in_fh.read(4);
    is $buf.elems, 3, "three bytes were read";
    is $buf.decode("ISO-8859-1"), "föö", "the bytes decode into the right Str";
}

unlink($filename);

$out = open($filename, :w);
$out.say("Hello World");
$out.say("Foo Bar Baz");
$out.say("The End");
$out.close;

#?niecza todo 'Cannot open file straight from $filename.IO.get'
{
    my $line;
    lives_ok { $line = $filename.IO.get; }, "can read lines without explicitly opening IO";
    is $line, 'Hello World', 'got the right line from .IO.get';
}
unlink($filename);

done;

# vim: ft=perl6
