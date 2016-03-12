use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;

# L<S32::IO/IO::Handle/open>
# old: L<S16/"Filehandles, files, and directories"/"open">
# old: L<S16/"Filehandles, files, and directories"/"close">
# old: L<S16/Unfiled/IO.get>

=begin pod

I/O tests

=end pod

plan 112;

sub nonce () { return ".{$*PID}." ~ (1..1000).pick() }
my $filename = 'tempfile_filehandles_io' ~ nonce();

# create and write a file

my $out = open($filename, :w);
#?niecza skip 'open does not yet produce an IO object'
isa-ok($out, IO::Handle);
$out.say("Hello World");
$out.say("Foo Bar Baz");
$out.say("The End");
ok($out.close, 'file closed okay');

# read the file all possible ways

my $in1 = open($filename);
#?niecza skip 'open does not yet produce an IO object'
isa-ok($in1, IO::Handle);
my $line1a = get($in1);
is($line1a, "Hello World", 'get($in) worked (and autochomps)');
my $line1b = get($in1);
is($line1b, "Foo Bar Baz", 'get($in) worked (and autochomps)');
my $line1c = get($in1);
is($line1c, "The End", 'get($in) worked');
ok($in1.close, 'file closed okay (1)');

my $in2 = open($filename);
#?niecza skip 'open does not yet produce an IO object'
isa-ok($in2, IO::Handle);
my $line2a = $in2.get();
is($line2a, "Hello World", '$in.get() worked');
my $line2b = $in2.get();
is($line2b, "Foo Bar Baz", '$in.get() worked');
my $line2c = $in2.get();
is($line2c, "The End", '$in.get() worked');
ok($in2.close, 'file closed okay (2)');

# L<S02/Files/you now write>
my $in3 = open($filename);
#?niecza skip 'open does not yet produce an IO object'
isa-ok($in3, IO::Handle);
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
#?niecza skip 'open does not yet produce an IO object'
isa-ok($append, IO::Handle);
$append.say("... Its not over yet!");
ok($append.close, 'file closed okay (append)');

# now read in in list context

my $in4 = open($filename);
#?niecza skip 'open does not yet produce an IO object'
isa-ok($in4, IO::Handle);
my @lines4 = lines($in4);
is(+@lines4, 4, 'we got four lines from the file');
is(@lines4[0], "Hello World", 'lines($in) worked in list context');
is(@lines4[1], "Foo Bar Baz", 'lines($in) worked in list context');
is(@lines4[2], "The End", 'lines($in) worked in list context');
is(@lines4[3], "... Its not over yet!", 'lines($in) worked in list context');
ok($in4.close, 'file closed okay (4)');


{
my $in5 = open($filename);
#?niecza skip 'open does not yet produce an IO object'
isa-ok($in5, IO::Handle);
my @lines5 = lines($in5, 3);
is(+@lines5, 3, 'we got two lines from the file');
is(@lines5[0], "Hello World", 'lines($in) worked in list context');
is(@lines5[1], "Foo Bar Baz", 'lines($in) worked in list context');
is(@lines5[2], "The End", 'lines($in) worked in list context');
ok($in5.close, 'file closed okay (5)');
}

my $in6 = open($filename);
#?niecza skip 'open does not yet produce an IO object'
isa-ok($in6, IO::Handle);
my @lines6 = $in6.lines();
is(+@lines6, 4, 'we got four lines from the file');
is(@lines6[0], "Hello World", '$in.lines() worked in list context');
is(@lines6[1], "Foo Bar Baz", '$in.lines() worked in list context');
is(@lines6[2], "The End", '$in.lines() worked in list context');
is(@lines6[3], "... Its not over yet!", '$in.lines() worked in list context');
ok($in6.close, 'file closed okay (6)');

my $in7 = open($filename);
#?niecza skip 'open does not yet produce an IO object'
isa-ok($in7, IO::Handle);
my @lines7 = $in7.lines;
is(+@lines7, 4, 'we got four lines from the file');
is(@lines7[0], "Hello World", '$in.lines worked in list context');
is(@lines7[1], "Foo Bar Baz", '$in.lines worked in list context');
is(@lines7[2], "The End", '$in.lines worked in list context');
is(@lines7[3], "... Its not over yet!", '$in.lines worked in list context');
ok($in7.close, 'file closed okay (7)');

{
# test reading a file into an array and then closing before 
# doing anything with the array (in other words, is perl too lazy)
my $in8 = open($filename);
#?niecza skip 'open does not yet produce an IO object'
isa-ok($in8, IO::Handle);
my @lines8 = $in8.lines(3);
push @lines8, "and finally" ~ $in8.get;
ok($in8.close, 'file closed okay (8)');
is(+@lines8, 4, 'we got four lines from the file (lazily)');
is(@lines8[0], "Hello World", 'lines($in,3) worked in list context');
is(@lines8[1], "Foo Bar Baz", 'lines($in,3) worked in list context');
is(@lines8[2], "The End", 'lines($in,3) worked in list context');
is(@lines8[3], "and finally... Its not over yet!", 'get($in) worked after lines($in,$n)');
}

{
    # Test $fh.lines(*)  RT #125626
    my $in = open($filename);
    my @lines = try $in.lines(*);
    is(+@lines, 4, 'we got all lines from the file');
    $in.close;
}

{
    # Test $fh.lines(Inf)  RT #125626
    my $in = open($filename);
    my @lines = try $in.lines(Inf);
    is(+@lines, 4, 'we got all lines from the file');
    $in.close;
}

{
    # Test lines($fh,*)  RT #125626
    my $in = open($filename);
    my @lines = try lines($in,*);
    is(+@lines, 4, 'we got all lines from the file');
    $in.close;
}
{
    # Test lines($fh,Inf)  RT #125626
    my $in = open($filename);
    my @lines = try lines($in,Inf);
    is(+@lines, 4, 'we got all lines from the file');
    $in.close;
}


#now be sure to delete the file as well
ok(unlink($filename), 'file has been removed');

# new file for testing other types of open() calls


my $out8 = open($filename, :w);
#?niecza skip 'open does not yet produce an IO object'
isa-ok($out8, IO::Handle);
$out8.say("Hello World");
ok($out8.close, 'file closed okay (out8)');

my $in8 = open($filename);
#?niecza skip 'open does not yet produce an IO object'
isa-ok($in8, IO::Handle);
my $line8_1 = get($in8);
is($line8_1, "Hello World", 'get($in) worked');
ok($in8.close, 'file closed okay (in8)');

#?niecza skip 'Not yet able to open both :r and :w'
{
    my $fh9 = open($filename, :r, :w);  # was "<+" ? 
    isa-ok($fh9, IO::Handle);
    #my $line9_1 = get($fh9);
    #is($line9_1, "Hello World");
    #$fh9.say("Second line");
    ok($fh9.close, 'file closed okay (9)');
}

#my $in9 = open($filename);
#isa-ok($in9, IO::Handle);
#my $line9_1 = get($in9);
#my $line9_2 = get($in9);
#is($line9_1, "Hello World", 'get($in) worked');
#is($line9_2, "Second line", 'get($in) worked');

#?niecza skip 'Not yet able to open both :r and :w'
{
    my $fh10 = open($filename, :rw);  # was "<+" ? 
    isa-ok($fh10, IO::Handle);
    $fh10.close;
    #ok($fh10.close, 'file closed okay (10)');
}

# RT #65348
{
    my $rt65348_out = open($filename, :w);
    #?niecza skip 'open does not yet produce an IO object'
    isa-ok $rt65348_out, IO::Handle;
    $rt65348_out.say( 'RT #65348' );
    $rt65348_out.say( '13.37' );
    $rt65348_out.say( '42.17' );
    ok $rt65348_out.close, 'close worked (rt65348 out)';

    my $rt65348_in = open( $filename );
    #?niecza skip 'open does not yet produce an IO object'
    isa-ok $rt65348_in, IO::Handle;
    my @list_context = ($rt65348_in.get);
    is +@list_context, 1, '.get in list context reads only one line';
    ok $rt65348_in.get.Int ~~ Int, '.get.Int gets int';
    is $rt65348_in.get.Int, 42, '.get.Int gets the right int';
    ok $rt65348_in.close, 'close worked (rt65348 in)';
}

ok(unlink($filename), 'file has been removed');
nok $filename.IO ~~ :e, '... and the tempfile is gone, really';

#?niecza skip ':bin NYI'
{
    my $binary_out_fh = open($filename, :w, :bin);
    #?niecza skip 'open does not yet produce an IO object'
    isa-ok($binary_out_fh, IO::Handle);
    $binary_out_fh.write("föö".encode("ISO-8859-1"));
    ok($binary_out_fh.close(), "file closed OK");
}

#?niecza skip ':bin NYI'
{
    my $binary_in_fh = open($filename, :r, :bin);
    #?niecza skip 'open does not yet produce an IO object'
    isa-ok($binary_in_fh, IO::Handle);
    my $buf = $binary_in_fh.read(4);
    is $buf.elems, 3, "three bytes were read";
    is $buf.decode("ISO-8859-1"), "föö", "the bytes decode into the right Str";
    $binary_in_fh.close;
}

#?niecza skip 'encoding probably NYI'
{

    # Tests for ISO-8859-1
    my $fh = open($filename, :w);
    lives-ok { $fh.encoding('iso-8859-1') }, "Set iso-8859-1 out encoding";
    lives-ok { $fh.print("a¢ÿ") }, "iso-8859-1 chars to fh";
    lives-ok { $fh.print("") }, "iso-8859-1 unmapped chars to fh";
    $fh.close;
    my $s = '';
    $fh = open($filename);
    lives-ok { $fh.encoding('iso-8859-1') }, "Set iso-8859-1 in encoding";
    lives-ok { $s ~= $fh.getc for 1..3; }, "iso-8859-1 chars from fh";
    is $s, 'a¢ÿ', "correct iso-8859-1 chars from fh";
    lives-ok { $s = $fh.getc }, "iso-8859-1 unmapped char from fh";
    is $s, '', "correct iso-8859-1 unmapped char from fh";
    $fh.close;

    # Test windows-1252; piggyback tests for mixed encoding.
    $fh = open($filename, :w);
    lives-ok { $fh.encoding('windows-1252') }, "Set windows-1252 out encoding";
    lives-ok { $fh.print("a¢€‚ƒ„…†‡ˆ‰Š‹ŒŽ") }, "windows-1252 chars to fh";
#?rakudo.jvm todo 'java.nio.charset.UnmappableCharacterException RT #125075'
    lives-ok { $fh.print("") },"windows-1252 unmapped chars to fh";
    lives-ok { $fh.encoding('ISO-8859-1') }, "reset output fh encoding";
    lives-ok { $fh.print("a¢ÿ") }, "iso-8859-1 chars to fh";
    lives-ok { $fh.print("") }, "iso-8859-1 unmapped char to fh";
    $fh.close;
    $fh = open($filename, :bin);
    my $b = $fh.read(32);
    $fh.close;
#?rakudo.jvm todo 'will fail due to above failures RT #125077'
    is $b.values,
       (0x61,0xa2,0x80,0x82..0x8c,0x8e,0x81,0x8d,0x8f,0x61,0xa2,0xff,0x80),
       "file with encoding wrote correct content";
    $fh = open($filename);
    lives-ok { $fh.encoding('windows-1252') }, "Set windows-1252 in encoding";
    $s = '';
    lives-ok { $s ~= $fh.getc for 1..15; }, "windows-1252 chars from fh";
    is $s, 'a¢€‚ƒ„…†‡ˆ‰Š‹ŒŽ', "correct windows-1252 chars from fh";
    $s = '';
    lives-ok { $s ~= $fh.getc for 1..3; },
      "windows-1252 unmapped chars from fh";
#?rakudo.jvm todo 'builtin JVM charset folds these RT #124686'
    is $s, '', "correct windows-1252 unmapped chars from fh";
# Switching encoding on read may or may not ever be supported
#?rakudo.moar todo 'Too late to change filehandle encoding RT #125079'
    lives-ok { $fh.encoding('ISO-8859-1') }, "reset input fh encoding";
    $s = '';
    lives-ok { $s ~= $fh.getc for 1..3; }, "iso-8859-1 chars from fh";
#?rakudo.jvm todo 'will fail due to above failures RT #125081'
    is $s, 'a¢ÿ', "correct iso-8859-1 chars from fh";
    lives-ok { $s = $fh.getc }, "iso-8859-1 unmapped char from fh";
# Switching encoding on read may or may not ever be supported
#?rakudo todo 'Will fail due to above failure RT #125082'
    is $s, '', "correct iso-8859-1 unmapped char from fh";
    $fh.close;
}

unlink($filename);

$out = open($filename, :w);
$out.say("Hello World");
$out.say("Foo Bar Baz");
$out.say("The End");
$out.close;

# RT #123347

{
    my $fh = open($filename, :r);
    ok(!$fh.t, 'checking if a file handle is a TTY - negative case');
    $fh.close;
}

#?niecza skip 'IO.close'
{
    my $line;
    my $handle = $filename.IO.open;
    lives-ok { $line = $handle.get; }, "can read lines";
    is $line, 'Hello World', 'got the right line';
    ok $handle.close, 'close was successful';
}
unlink($filename);

# RT #112130
{
    $out = open($filename, :w);
    $out.print('blarg');
    $out.close;
    my $in = open($filename);
    is $in.lines.join, 'blarg', 'can use .lines on a file without trailing newline';
    $in.close;
    unlink $filename;
}

{
    dies-ok { open('t').read(42) }, '.read on a directory fails';
    dies-ok { open('t').get(1) }, '.get on a directory fails';
}

# vim: ft=perl6
