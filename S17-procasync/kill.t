use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

# ignore SIGPIPE from writing to a child process
try {
    signal(::('SIGPIPE')).act: {};
}

my @signals = SIGINT;
plan 2 + @signals * 10;

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

    cmp-ok $pc.ready.status, '~~', Kept, "ready Promise should be Kept by now";

    # give it a little time
    $pc.print("1\n");

    # stop what you're doing
    $pc.kill($signal);
    $pc.print("2\n");

    # done processing, from sleep
    await $pm;

    can-ok $pm.result, 'exitcode';
    is $pm.result.?exitcode, 0, 'did it exit with the right value';

    #?rakudo skip 'RT #126425 - order of operations for Proc::Async is nondeterminstic'
    is $stdout, "Started\n$signal\n", 'did we get STDOUT';
}

# RT #131479
doesn't-hang ｢
        await ^4 .map: -> $n {
            start {
                with Proc::Async.new: $*EXECUTABLE, "-e", "sleep" -> $p {
                    start {
                        await $p.ready;
                        $n == 3 ?? $p.kill !! $p.kill: (SIGTERM, 'TERM', SIGTERM.value)[$n]
                    }
                    await $p.start
                }
            }
        }
        print 'All done!'
    ｣,   :out('All done!'), :err(''), :10wait,
'.kill kills when multi-procs kill in multi-promises';

# RT #125653
subtest 'can rapid-kill our Proc::Async without hanging' => {
    plan 1;
    my $proc = Proc::Async.new: $*EXECUTABLE, "-e", "sleep 1";
    my $prom = $proc.start;
    $proc.kill;
    await $prom;       
    pass 'did not hang';
}

END {
    unlink $program;
}
