use v6;
use Test;

plan 14;

# older: L<S16/"Unfiled"/"=item IO.slurp">
# old: L<S32::IO/IO::FileNode/slurp>
# L<S32::IO/Functions/slurp>

{
  dies_ok { slurp "does-not-exist" }, "slurp() on non-existent files fails";
}

{
  dies_ok { slurp "t/" }, "slurp() on directories fails";
}

my $test-path = "tempfile-slurp-test";
my $test-contents = "0123456789A\nBCDEFG\n";
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
isa_ok $contents, Str, "slurp returns a string";
is $contents, $test-contents, "slurp with path loads entire file";
is slurp($empty-path), '', "empty files yield empty string";

{
    my $fh = open $test-path, :r;
    is $fh.slurp, $test-contents, "method form .slurp works";
    $fh.close;
}
#?niecza skip "slurp(filehandle) doesn't work"
{
    my $fh = open $test-path, :r;
    is slurp($fh), $test-contents, "function passed a filehandle works";
    $fh.close;
}

# RT #112276
# 0-argument slurp set to $*ARGFILES
{
    my $*ARGFILES = open $test-path, :r;
    is slurp(), $test-contents, "slurp with no parameters loads \$*ARGFILES";
    $*ARGFILES.close;
}

#?niecza skip ":bin option for slurp fails"
{
    my $binary-slurp;
    ok ($binary-slurp = slurp $test-path, :bin), ":bin option runs";
    isa_ok $binary-slurp, Buf, ":bin returns a Buf";
    is $binary-slurp, $test-contents.encode, "binary slurp returns correct content";
}

#?rakudo todo ":enc option for slurp fails"
#?niecza todo ":enc option for slurp fails"
#?pugs todo ":enc option for slurp fails"

{
    lives_ok { slurp($test-path, :enc('utf8')) }, "slurp :enc - encoding functions"   
}


# slurp in list context

my @slurped_lines = lines(open($test-path));
is +@slurped_lines, 2, "lines() - exactly 2 lines in this file";

unlink $test-path;
unlink $empty-path;
CATCH {
    unlink $test-path;
    unlink $empty-path;
}

# vim: ft=perl6
