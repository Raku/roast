use v6;

use Test;

my @signals = $*KERNEL.signals.grep(Signal);
plan @signals * 12;

my $program = 'async-kill-tester';

for @signals -> $signal {
    my $source = "
signal($signal).act: \{ .note; exit +\$_ \};

say 'Started';
sleep 5;
say 'Done';
";
    ok $program.IO.spurt($source),   'could we write the tester';
    is $program.IO.s, $source.chars, 'did the tester arrive ok';

    my $pc = Proc::Async.new( :path($*EXECUTABLE), :args($program), :w );
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

    # done processing, either by sleep or exit from signal
    my $ps = await $pm;

    #?rakudo 2 todo "not getting a Proc::Status back, but Any"
    isa_ok $ps, Proc::Status;
    is $ps.?signal, +$signal, 'was it killed with the right signal';

    #?rakudo 2 todo "signal tap not working inside process"
    is $stdout, "Started\n", 'did we get STDOUT';
    is $stderr, "$signal\n", 'did we get STDERR';
}

END {
    unlink $program;
}
