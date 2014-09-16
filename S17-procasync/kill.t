use v6;

use Test;

my @signals = $*KERNEL.signals.grep(Signal);
plan @signals * 12;

my $program = 'async-kill-tester';

for @signals -> $signal {
    my $source = "
signal($signal).act: \{ .note; sleep 1; exit +\$_ \};

say 'Started';
sleep 5;
say 'Done';
";
    ok $program.IO.spurt($source),   'could we write the tester';
    is $program.IO.s, $source.chars, 'did the tester arrive ok';

    my $pc = Proc::Async.new( $*EXECUTABLE, $program, :w );
    isa_ok $pc, Proc::Async;

    my $so = $pc.stdout;
    cmp_ok $so, '~~', Supply;
    my $se = $pc.stderr;
    cmp_ok $se, '~~', Supply;

    my $stdout = "";;
    my $stderr = "";;
    $so.act: { $stdout ~= $_ };
    $se.act: { $stderr ~= $_ };

    is $stdout, "", "STDOUT for $signal should be empty";
    is $stderr, "", "STDERR for $signal should be empty";

    my $pm = $pc.start;
    isa_ok $pm, Promise;

    # give it a little time
    sleep 2;

    # stop what you're doing
    $pc.kill($signal);

    # done processing, either by sleep or exit from signal
    my $ps = await $pm;

    #?rakudo 2 todo "not getting a Proc::Status back, but Any"
    isa_ok $ps, Proc::Status;
    is $ps.?exit, +$signal, 'did it exit with the right value';

    is $stdout, "Started\n", 'did we get STDOUT';
    #?rakudo todo "signal tap not working inside process"
    is $stderr, "$signal\n", 'did we get STDERR';
}

END {
    unlink $program;
}
