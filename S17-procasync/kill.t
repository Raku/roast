use v6;

use Test;

# ignore SIGPIPE from writing to a child process
try {
    signal(::('SIGPIPE')).act: {};
}

my @signals = SIGINT;
plan @signals * 9;

my $program = 'async-kill-tester';

for @signals -> $signal {
    my $source = "
signal($signal).act: \{ .say; exit \};

say 'Started';
my \$ = get();
my \$ = get();
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

    sleep 1;

    # give it a little time
    $pc.print("1\n");

    # stop what you're doing
    $pc.kill($signal);
    $pc.print("2\n");

    # done processing, from sleep
    await $pm;

    can-ok $pm.result, 'exitcode';
    is $pm.result.?exitcode, 0, 'did it exit with the right value';

    is $stdout, "Started\n$signal\n", 'did we get STDOUT';
}

END {
    unlink $program;
}
