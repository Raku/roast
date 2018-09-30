use v6;
use lib $?FILE.IO.parent(2).add: 'packages';
use Test;
use Test::Util;

plan 20;

shell_captures_out_ok '',               '',    0, 'Child succeeds but does not print anything';
shell_captures_out_ok 'say 42',         '42',  0, 'Child succeeds and prints something';
shell_captures_out_ok 'exit 1',         '',    1, 'Child fails and prints nothing';
shell_captures_out_ok 'exit 42',        '',   42, 'Child fails and prints nothing';
shell_captures_out_ok 'say 42; exit 7', '42',  7, 'Child fails and prints something';

sub shell_captures_out_ok($code, $out, $exitcode, $desc) {
    for shell("$*EXECUTABLE -e \"$code\"", :out),
        run($*EXECUTABLE, '-e', $code, :out) -> $proc {
        subtest {
            ok $proc ~~ Proc, 'shell/run(:out).out is a Proc';
            ok $proc.out ~~ IO::Pipe, 'shell/run(:out).out is an IO::Pipe';
            my $lines = $proc.out.lines.join('');
            my $ps    = $proc.out.close;
            cmp-ok $ps, '===', $proc, ".close on pipe returns pipe's Proc";
            if $exitcode {
                nok $ps,                    'shell/run(:out) returns something falsish on failure';
                is $ps.exitcode, $exitcode, "Proc::Status.exitcode is $exitcode";
                is $lines,       $out,      'got correct output';
            }
            else {
                ok $ps,                'shell/run(:out) returns something trueish on success';
                is $ps.exitcode, 0,    'Proc::Status.exitcode is zero for a successful run';
                is $ps.status,   0,    'Proc::Status.status is zero for a successful run';
                is $lines,       $out, 'got correct output';
            }
        }, $desc
    }
}

{
    my $sh = shell("$*EXECUTABLE -e \".say for reverse lines\"", :in, :out);
    $sh.in.say: "foo\nbar\nbaz";
    $sh.in.close;
    is $sh.out.slurp, "baz\nbar\nfoo\n", 'Can talk to subprocess bidirectional';
}

#?rakudo.jvm skip 'hangs, RT #131393'
{
    my $sh1 = run($*EXECUTABLE, '-e', 'say join "\n", reverse lines', :in, :out);
    my $sh2 = run($*EXECUTABLE, '-e', 'my @l = lines; .say for @l; note @l.elems', :in($sh1.out), :out, :err);
    $sh1.in.say: "foo\nbar\nbaz";
    $sh1.in.close;
    is $sh2.out.slurp, "baz\nbar\nfoo\n", 'Can capture stdout and stderr, and chain stdin';
    is $sh2.err.slurp, "3\n",           'Can capture stdout and stderr, and chain stdin';
}

# RT #125796
{
    my $p     = shell "$*EXECUTABLE -e \"say 42 for ^10\"", :out;
    my @lines = $p.out.lines;
    ok all(@lines) eq '42', 'There is no empty line due to no EOF for pipes';
}

with run(:out, $*EXECUTABLE, '-e', '') -> $proc {
    with $proc.out {
        is-deeply .IO,   IO::Path,  '.IO   returns an IO::Path type object';
        is-deeply .path, IO::Path,  '.path returns an IO::Path type object';
        cmp-ok .proc, '===', $proc, ".proc returns pipe's Proc object";
        quietly is-deeply .Str, '', '.Str is empty string';
        .close;
    }
}

group-of 3 => 'bin pipes in Proc do not crash on open' => {
    my ($stdout, $stderr);
    lives-ok {
        my $p = run :bin, :out, :err, :in, $*EXECUTABLE, '-e',
            'my $v = $*IN.get; note $v.flip; say $v';
        $p.in.write: "42\n".encode;
        $p.in.flush;
        $p.in.close;
        $stdout = $p.out.slurp(:close).decode;
        $stderr = $p.err.slurp(:close).decode;
    }, 'no crashes';
    is $stdout, "42\n", 'STDOUT is right';
    is $stderr, "24\n", 'STDERR is right';
}

# RT #129882
{
    my $proc = run $*EXECUTABLE, '-e', 'print slurp', :in, :out, :bin;
    my $input = ('a' x 1_000_000).encode;
    my $promise = start {
        $proc.in.write: $input;
        $proc.in.close;
    }
    is $proc.out.slurp(:close, :bin).bytes, 1_000_000, 'large blob can be piped';
    await $promise;
}
