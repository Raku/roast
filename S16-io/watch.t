use v6;

use Test;

plan 1;

# GH rakudo/rakudo#3100
#?rakudo.jvm skip 'nqp::watchfile only implemented as stub for JVM backend'
#?DOES 1
{
    # Test if file change events are not lost.
    my constant RUNS = 10;
    my $watch-file = $*SPEC.catfile( $*TMPDIR, "watchme" );
    my $fh = $watch-file.IO.open: :w, :0out-buffer;
    my $start-writing = Promise.new;
    my $start-vow = $start-writing.vow;
    my @proceed = Promise.new xx RUNS;
    @proceed[0].keep;
    start {
        await $start-writing;
        for ^RUNS {
            await @proceed[$_];
            $fh.say: $_;
            $fh.flush;
        }
    }

    my $count = 0;
    my $timeout = Promise.in(5);
    react {
        whenever $watch-file.IO.watch -> $e {
            $count++;
            @proceed[$count].?keep;
            done if $count == RUNS;
        }
        whenever $timeout {
            done;
        }
        # Allow time for the file watcher to get set up
        whenever Promise.in(0.5) {
            $start-vow.keep(True);
        }
    }

    if $timeout.status ~~ Planned {
        is $count, RUNS, "all watch events received";
    }
    else {
        flunk "timed out waiting for file change events";
    }

    LEAVE {
        $fh.close;
        $watch-file.IO.unlink;
    }
}

# vim: expandtab shiftwidth=4
