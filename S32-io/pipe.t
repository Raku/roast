use v6;
use Test;

plan 5;

pipes_ok '1',              '',    0, 'Child succeeds but does not print anything';
pipes_ok 'say 42',         '42',  0, 'Child succeeds and prints something';
pipes_ok 'exit 1',         '',    1, 'Child fails and prints nothing';
pipes_ok 'exit 42',        '',   42, 'Child fails and prints nothing';
pipes_ok 'say 42; exit 7', '42',  7, 'Child fails and prints something';

sub pipes_ok($code, $out, $exitcode, $desc) {
    subtest {
        my $fh = pipe("$*EXECUTABLE -e \"$code\"", :r);
        ok $fh ~~ IO::Handle, 'pipe() returns an IO::Handle';
        my $lines = $fh.lines.join('');
        my $ps = $fh.close;
        if $exitcode {
            nok $ps,            'pipe() returns something falsish on failure';
            is $ps.exitcode, $exitcode, "Proc::Status.exitcode is $exitcode";
            is $lines,   $out,  'got correct output';
        }
        else {
            ok $ps,              'pipe() returns something trueish on success';
            is $ps.exitcode, 0,    'Proc::Status.exitcode is zero for a successful run';
            is $ps.status, 0,    'Proc::Status.status is zero for a successful run';
            is $lines,     $out, 'got correct output';
        }
    }, $desc
}
