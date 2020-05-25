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
    my $ready = Promise.new;
    my $start-writing = Promise.new;
    my @proceed = Promise.new xx RUNS;
    @proceed[0].keep;
    start {
        $ready.keep;
        await $start-writing;
        for ^RUNS {
            await @proceed[$_];
            $fh.say: $_;
            $fh.flush;
        }
    }

    # Know for sure that the writer thread is ready awaiting for the main thread.
    await $ready;

    my $count = 0;
    my $timeout = Promise.in(30);
    react {
        whenever $watch-file.IO.watch -> $e {
            $count++;
            @proceed[$count].?keep;
            done if $count == RUNS;
        }
        whenever $timeout {
            done;
        }
        # Allow everything to settle down and be ready for processing. Having $start-writing.keep outside of the react
        # block makes it sometimes to happen so that the writer thread updates the file before react taps IO.watch.
        # But if we signal the start from inside a whenever then it means react is equipped and working.
        whenever Promise.kept {
            $start-writing.keep;
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
