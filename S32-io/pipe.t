use v6;
use Test;

plan 13;

shell_captures_out_ok '1',              '',    0, 'Child succeeds but does not print anything';
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
    my $sh = shell("$*EXECUTABLE -e \"say reverse lines\"", :in, :out);
    $sh.in.say: "foo\nbar\nbaz";
    $sh.in.close;
    is $sh.out.slurp-rest, "baz bar foo\n", 'Can talk to subprocess bidirectional';
}

{
    my $sh1 = run($*EXECUTABLE, '-e', 'say join "\n", reverse lines', :in, :out);
    $sh1.in.say: "foo\nbar\nbaz";
    $sh1.in.close;
    my $sh2 = run($*EXECUTABLE, '-e', 'my @l = lines; say @l; note @l.elems', :in($sh1.out), :out, :err);
    is $sh2.out.slurp-rest, "baz bar foo\n", 'Can capture stdout and stderr, and chain stdin';
    is $sh2.err.slurp-rest, "3\n",           'Can capture stdout and stderr, and chain stdin';
}
