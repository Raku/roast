use v6.d;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

# ignore SIGPIPE from writing to a child process
try {
    signal(::('SIGPIPE')).act: {};
}

my @signals = SIGINT;
plan 2 + @signals * 6;

for @signals -> $signal {
    my $program = (make-temp-file content => q:to/END/).absolute;
        signal(\qq[$signal]).act: { .say; exit };

        say 'Started';
        my $ = get();
        exit 1; # should actually not get here
        END

    with Proc::Async.new($*EXECUTABLE, $program, :w) -> $proc {
        isa-ok $proc, Proc::Async;

        my $so = $proc.stdout;
        cmp-ok $so, '~~', Supply;

        react {
            whenever $proc.stdout.lines {
                when 'Started' {
                    $proc.kill($signal);
                }
                default {
                    is $_, $signal, 'Output correct for Supply.merge on signals';
                }
            }
            whenever $proc.start {
                can-ok $_, 'exitcode';
                is .?exitcode, 0, 'did it exit with the right value';
                is .?signal, 0, "signal $signal got handled";
            }
        }
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6304
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

# https://github.com/Raku/old-issue-tracker/issues/4418
subtest 'can rapid-kill our Proc::Async without hanging' => {
    plan 1;
    my $proc = Proc::Async.new: $*EXECUTABLE, "-e", "sleep";
    my $prom = $proc.start;
    $proc.kill;
    $ = await $prom;
    pass 'did not hang';
}

# vim: expandtab shiftwidth=4
