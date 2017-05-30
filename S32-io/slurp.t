use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 18;

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
    is $fh.slurp, $test-contents, "method form .slurp works";
    $fh.close;
}

{
    is slurp($test-path), $test-contents, "function passed a path works";
}

{
    my $binary-slurp;
    ok ($binary-slurp = slurp $test-path, :bin), ":bin option runs";
    ok $binary-slurp ~~ Buf, ":bin returns a Buf";
    is $binary-slurp, $test-contents.encode, "binary slurp returns correct content";
}

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

subtest '&slurp(IO::Handle)' => {
    plan 9;

    sub f (\c) { make-temp-file content => c }
    is_run 'print slurp', {:0status, :err(''), :out('foobarber')}, :args[
        'foo'.&f.absolute, 'bar'.&f.absolute, 'ber'.&f.absolute,
    ], 'slurp() uses $*ARGFILES';

    is_run '$*ARGFILES.encoding: Nil; say slurp', {
        :0status, :err(''),
        :out('Buf[uint8]:0x<66 6f 6f 62 61 72 62 65 72>\qq[\n]')
    }, :args[
        'foo'.&f.absolute, 'bar'.&f.absolute, 'ber'.&f.absolute,
    ], 'slurp() uses $*ARGFILES (binary mode)';

    is-deeply slurp('foo'.&f.open), 'foo', 'slurp($fh)';
    #?rakudo.jvm todo 'problem with equivalence of Buf objects, RT #128041'
    is-deeply slurp('foo'.&f.open: :bin), Buf[uint8].new(102,111,111),
        'slurp($fh, :bin)';
    #?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
    is-deeply slurp(buf8.new(200).&f.open: :enc<utf8-c8>),
        buf8.new(200).decode('utf8-c8'), 'slurp($fh, :enc<utf8-c8>)';

    with 'foo'.&f.open {
        is-deeply .&slurp, 'foo', '$fh.&slurp';
        is-deeply .opened, True, 'without :close, handle stays open';
        .close;
    }

    with 'foo'.&f.open {
        is-deeply .&slurp(:close), 'foo', '$fh.&slurp(:close)';
        is-deeply .opened, False, 'with :close, handle is closed';
    }
}

# vim: ft=perl6
