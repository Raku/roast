use v6;

use Test;

my @signals = $*KERNEL.signals.grep(Signal);
plan @signals * 9;

my $program = 'async-kill-tester';

for @signals -> $signal {
    my $source = "
signal($signal).act: \{ .say \};

say 'Started';
sleep 5;
say 'Done';
";
    ok $program.IO.spurt($source),   'could we write the tester';
    is $program.IO.s, $source.chars, 'did the tester arrive ok';

    my $pc = Proc::Async.new( $*EXECUTABLE, $program, :w );
    isa-ok $pc, Proc::Async;

    my $so = $pc.stdout;
    cmp-ok $so, '~~', Supply;

    my $stdout = "";;
    $so.act: { $stdout ~= $_ };

    is $stdout, "", "STDOUT for $signal should be empty";

    my $pm = $pc.start;
    isa-ok $pm, Promise;

    # give it a little time
#    sleep 2;

    # stop what you're doing
#    $pc.kill($signal);    # XXX cannot call this yet, it will cause hanging

    # done processing, from sleep
    await $pm;

    isa-ok $pm.result, Proc::Status;
    is $pm.result.?exitcode, 0, 'did it exit with the right value';

    #?rakudo todo 'we cannot actually send signals yet'
    is $stdout, "Started\n$signal\n", 'did we get STDOUT';
}

END {
    unlink $program;
}
