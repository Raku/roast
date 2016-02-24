use v6.c;
use Test;

plan 17;

# older: L<S16/"Unfiled"/"=item IO.slurp">
# old: L<S32::IO/IO::FileNode/slurp>
# L<S32::IO/Functions/slurp>

{
  dies-ok { slurp "does-not-exist" }, "slurp() on non-existent files fails";
}

{
  dies-ok { slurp "t/" }, "slurp() on directories fails";
  dies-ok { open('t').slurp }, 'slurp on open directory fails';
}

my $test-path = "tempfile-slurp-test";
my $test-contents = "0123456789ABCDEFG風, 薔薇, バズ";
my $empty-path = "tempfile-slurp-empty";

{ # write the temp files
    my $fh = open($test-path, :w);
    $fh.print: $test-contents;
    $fh.close();
    $fh = open($empty-path, :w);
    $fh.print: "";
    $fh.close();
}

ok (my $contents = slurp($test-path)), "test file slurp with path call ok";
isa-ok $contents, Str, "slurp returns a string";
is $contents, $test-contents, "slurp with path loads entire file";
is slurp($empty-path), '', "empty files yield empty string";

{
    my $fh = open $test-path, :r;
    is $fh.slurp-rest, $test-contents, "method form .slurp-rest works";
    $fh.close;
}

{
    is slurp($test-path), $test-contents, "function passed a path works";
}

#?niecza skip ":bin option for slurp fails"
{
    my $binary-slurp;
    ok ($binary-slurp = slurp $test-path, :bin), ":bin option runs";
    ok $binary-slurp ~~ Buf, ":bin returns a Buf";
    is $binary-slurp, $test-contents.encode, "binary slurp returns correct content";
}

#?niecza skip ":enc option for slurp fails"
{
    lives-ok { slurp($test-path, :enc('utf8')) }, "slurp :enc - encoding functions";
    is slurp($test-path, :enc('utf8')), $test-contents, "utf8 looks normal";
    #mojibake time
    is slurp($test-path, enc=>'iso-8859-1'),
     "0123456789ABCDEFGé¢¨, èè, ããº", "iso-8859-1 makes mojibake correctly";
    
}


# slurp in list context

my @slurped_lines = lines(open($test-path));
is +@slurped_lines, 1, "lines() - exactly 1 line in this file";

# slurp in list context on a directory
{
    dies-ok { open('t').lines }, '.lines on a directory fails';
}

unlink $test-path;
unlink $empty-path;
CATCH {
    unlink $test-path;
    unlink $empty-path;
}

# vim: ft=perl6
