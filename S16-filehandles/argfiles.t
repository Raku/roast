use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;

plan 17;

sub create-temporary-file ($name = '') {
    my $filename = $*TMPDIR ~ '/tmp.' ~ $*PID ~ '-' ~ $name ~ '-' ~ time;
    return $filename, open($filename, :w);
}

my ( $tmp-file-name, $tmp-file-handle ) = create-temporary-file;
my $output;
my @lines;

$tmp-file-handle.say: 'one';
$tmp-file-handle.say: 'two';
$tmp-file-handle.say: 'three';

$tmp-file-handle.close;

my @args = $tmp-file-name;

$output = Test::Util::run('say get()', :@args);

is $output, "one\n", 'get() should read from $*ARGFILES, which reads from files in @*ARGS';

$output = Test::Util::run('say get()', "foo\nbar\nbaz\n");

is $output, "foo\n", 'get($*ARGFILES) reads from $*IN if no files are in @*ARGS';

$output = Test::Util::run('while get() -> $line { say $line }', :@args);
@lines  = lines($output);

is-deeply @lines, [<one two three>], 'calling get() several times should work';

$output = Test::Util::run('while get() -> $line { say $line }', "foo\nbar\nbaz\n", :@args);
@lines  = lines($output);

is-deeply @lines, [<one two three>], '$*ARGFILES should not use $*IN if files are in @*ARGS';

$output = Test::Util::run('.say for lines()', :@args);
@lines  = lines($output);

is-deeply @lines, [<one two three>], 'lines() should read from $*ARGFILES, which reads from files in @*ARGS';

$output = Test::Util::run('.say for lines()', :args($tmp-file-name xx 3));
@lines  = lines($output);

# RT #126494
is-deeply @lines, [|<one two three> xx 3], 'lines() using $*ARGFILES, works for more than one file';

$output = Test::Util::run('.say for lines()', "foo\nbar\nbaz\n");
@lines  = lines($output);

is-deeply @lines, [<foo bar baz>], 'lines($*ARGFILES) reads from $*IN if no files are in @*ARGS';

$output = Test::Util::run('.say for lines()', "foo\nbar\nbaz\n", :args(['-']));
@lines  = lines($output);

is-deeply @lines, [<foo bar baz>], 'lines($*ARGFILES) reads from $*IN if - is in @*ARGS';

$output = Test::Util::run('.say for lines()', "foo\nbar\nbaz\n", :@args);
@lines  = lines($output);

is-deeply @lines, [<one two three>], '$*ARGFILES should not use $*IN if files are in @*ARGS';

$output = Test::Util::run('.say for lines(); .say for lines()', "foo\nbar\nbaz\n", :@args);
@lines  = lines($output);

# RT #125380
is-deeply @lines, [<one two three>], 'Calling lines() twice should not read from $*IN';

$output = Test::Util::run("@*ARGS = '$tmp-file-name'; .say for lines()", "foo\nbar\nbaz\n");
@lines  = lines($output);

is-deeply @lines, [<one two three>], 'Changing @*ARGS before calling things on $*ARGFILES should open the new file';

# RT #123888
$output = Test::Util::run('$*IN.nl-in = "+"; say get() eq "A";', "A+B+C+");
#?rakudo.jvm todo 'RT #123888'
is $output, "True\n", 'Can change $*IN.nl-in and it has effect';

{ # https://github.com/rakudo/rakudo/commit/bd4236359c9150e4490d86275b3c2629b6466566
    my @lines = lines Test::Util::run(
        ｢@*ARGS = '｣ ~ $tmp-file-name ~ ｢' xx 2; .say for $*ARGFILES.lines(5)｣
    );
    is-deeply @lines, [<one two three one two>], '.lines with limit works across files';
}

subtest '.lines accepts all Numerics as limit' => {
    my @stuff = 5, 5/1, 5e0, 5+0i, <5>, < 5/1>, <5e0>, < 5+0i>;
    plan +@stuff;
    for @stuff -> $limit {
        my @lines = lines Test::Util::run(
            ｢@*ARGS = '｣ ~ $tmp-file-name
                ~ ｢' xx 2; .say for $*ARGFILES.lines: ｣ ~ $limit.perl
        );
        is-deeply @lines, [<one two three one two>], "{$limit.^name} limit";
    }
}

subtest ':bin and :enc get passed through in slurp' => {
    my ($file-bin, $fh-bin) = create-temporary-file 'bin';
    $fh-bin.print: "\x[10]\x[20]\x[30]";
    $fh-bin.close;

    my ($file-enc, $fh-enc) = create-temporary-file 'enc';
    $fh-enc.write: Buf[uint8].new: 174; # char ® in Latin-1
    $fh-enc.close;

    is_run ｢say slurp :bin｣, :args[$file-bin], {
        :out("Buf[uint8]:0x<10 20 30>\n"),
        :err(''),
        :0status,
    }, 'slurp(:bin), 1 file';

    is_run ｢say slurp :bin｣, :args[$file-bin, $file-bin], {
        :out("Buf[uint8]:0x<10 20 30 10 20 30>\n"),
        :err(''),
        :0status,
    }, 'slurp(:bin), 2 files';

    is_run ｢$*ARGFILES.lines(0); say slurp :bin｣, :args[$file-bin], {
        :out("Buf[uint8]:0x<10 20 30>\n"),
        :err(''),
        :0status,
    }, 'slurp(:bin), $*ARGFILES filehandle already opened';

    is_run ｢say slurp :bin｣, "\x[10]\x[20]\x[30]", {
        :out("Buf[uint8]:0x<10 20 30>\n"),
        :err(''),
        :0status,
    }, 'slurp(:bin), STDIN';

    is_run ｢say slurp :enc<Latin-1>｣, :args[$file-enc], {
        :out("®\n"),
        :err(''),
        :0status,
    }, 'slurp(:enc<Latin-1>), 1 file';

    is_run ｢say slurp :enc<Latin-1>｣, :args[$file-enc, $file-enc], {
        :out("®®\n"),
        :err(''),
        :0status,
    }, 'slurp(:enc<Latin-1>), 2 files';

    is_run ｢$*ARGFILES.lines(0); say slurp :enc<Latin-1>｣, :args[$file-enc], {
        :out("®\n"),
        :err(''),
        :0status,
    }, 'slurp(:enc<Latin-1>), $*ARGFILES filehandle already opened';

    is_run ｢say slurp :enc<Latin-1>｣, "\x[AE]", {
        :out("\x[c2]\x[ae]\n"), # is_run sends input in UTF-8
        :err(''),
        :0status,
    }, 'slurp(:enc<Latin-1>), STDIN';
}

# RT #130430
is_run ｢.put for $*ARGFILES.lines: 1000｣, "a\nb\nc", {
    :out("a\nb\nc\n"),
    :err(''),
    :0status,
}, '.lines stops when data ends, even if limit has not been reached yet';

# https://github.com/rakudo/rakudo/commit/4b8fd4a4f9
is_run ｢run(:in, $*EXECUTABLE, '-e', 'get').in.close｣,
    {:out(''), :err(''), :0status}, 'no crash when ^D with get(ARGFILES)';

$tmp-file-name.IO.unlink;
