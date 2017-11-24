use v6;

use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Util;

plan 16;

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

#?rakudo.jvm skip 'hangs, RT #131393'
{
    $output = Test::Util::run('.say for lines()', "foo\nbar\nbaz\n");
    @lines  = lines($output);

    is-deeply @lines, [<foo bar baz>], 'lines($*ARGFILES) reads from $*IN if no files are in @*ARGS';

    $output = Test::Util::run('.say for lines()', "foo\nbar\nbaz\n", :args(['-']));
    @lines  = lines($output);

    is-deeply @lines, [<foo bar baz>], 'lines($*ARGFILES) reads from $*IN if - is in @*ARGS';
}

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

# RT #130430
#?rakudo.jvm todo 'appends newlines after expected output'
is_run ｢.put for $*ARGFILES.lines: 1000｣, "a\nb\nc", {
    :out("a\nb\nc\n"),
    :err(''),
    :0status,
}, '.lines stops when data ends, even if limit has not been reached yet';

# https://github.com/rakudo/rakudo/commit/4b8fd4a4f9
is_run ｢run(:in, $*EXECUTABLE, '-e', 'get').in.close｣,
    {:out(''), :err(''), :0status}, 'no crash when ^D with get(ARGFILES)';

$tmp-file-name.IO.unlink;
