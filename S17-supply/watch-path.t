use v6;

use Test;

plan 4;

my $forawhile = 1;
my $filename = "watch-path_checker";
END { unlink $filename if $filename }  # make sure we cleanup

unlink $filename; # in case we missed the cleanup
ok !$filename.IO.e, "make sure we don't have a file";

given $*DISTRO.name {
    when "macosx" {
#?rakudo.jvm 3 skip "file system events NYI? RT #124828"
        subtest &macosx, "does watch-path work on Mac OS X";

        unlink $filename; # in case we missed the cleanup
        ok !$filename.IO.e, "make sure we don't have a file (2)";

        subtest { macosx :io-path }, "does IO::Path.watch work on Mac OS X";
    }
    default {
        skip "Only OSX tests available", 3;
    }
}

#====  specific tests from here
sub macosx (:$io-path) {
    plan 64;
    # check watching directories
    {
        my $base-path = '.';
        my $s = (
            $io-path ?? $base-path.IO.watch !! IO::Notification.watch-path: $base-path
        ).grep({.path.IO.basename eq $filename}).unique;
        ok $s ~~ Supply, 'Did we get a Supply?';

        my @seen;
        my $check-event = -> \change { flunk 'not setup yet'; };
        my $tap = $s.tap: -> \change {
            @seen.push(change);
            isa-ok change, IO::Notification::Change, 'only Change objects';
            $check-event(change);
        }
        isa-ok $tap, Tap, 'did we get a tap?';

        $check-event = -> \change {
            is change.event, FileRenamed, 'created files appear as FileRenamed';
            ok change.path.IO ~~ :e & :f, 'file exists';
        };
        my $handle = open( $filename, :w );
        isa-ok $handle, IO::Handle, 'did we get a handle?';

        sleep $forawhile;
        is +@seen, 1, 'did we get an event for creating the file';

        ok $handle.say( "Hello world" ), 'did the write go ok';

        sleep $forawhile;
        is +@seen, 1, 'did we NOT get an event for writing to the file';

        $check-event = -> \change {
            is change.event, FileRenamed, 'created files appear as FileRenamed';
            ok change.path.IO ~~ :e & :f, 'file exists';
        };
        ok $handle.close, 'did the file close ok';

        sleep $forawhile;
        is +@seen, 2, 'did we NOT get an event for closing the file';

        $handle = open( $filename, :a );
        isa-ok $handle, IO::Handle, 'did we get a handle again?';

        sleep $forawhile;
        is +@seen, 2, 'did we NOT get an event for opening the file again';

        ok $handle.say( "Hello world again" ), 'did the second write work';

        sleep $forawhile;
        is +@seen, 2, 'did we NOT get an event for writing to the file again';

        $check-event = -> \change {
            is change.event, FileRenamed, 'created files appear as FileRenamed';
            ok change.path.IO ~~ :e & :f, 'file exists';
        };
        ok $handle.close, 'did closing the file again work';

        sleep $forawhile;
        is +@seen, 3, 'did we get an event for closing the file again';

        my $content = $filename.IO.slurp;
        is $content, "Hello world\nHello world again\n", "was the file written ok";

        sleep $forawhile;
        is +@seen, 3, 'a slurp should not cause any file events';

        $check-event = -> \change {
            is change.event, FileRenamed, 'unlink file appear as FileRenamed';
            nok change.path.IO ~~ :e & :f, 'file does not exist';
        };
        unlink $filename;
        ok !$filename.IO.e, "test file removed successfully";

        sleep $forawhile;
        is +@seen, 4, 'the unlink caused an event';

        ok $tap.close, 'could we close the tap';
    }

    # check watching on a file
    {
        # When watching a file, it must exist before we watch it
        my $handle = open( $filename, :w );
        isa-ok $handle, IO::Handle, 'did we get a handle?';

        my $s = (
            $io-path ?? $filename.IO.watch !! IO::Notification.watch-path: $filename
        ).grep({.path.IO.basename eq $filename}).unique;
        ok $s ~~ Supply, 'did we get a Supply?';

        my @seen;
        my $check-event = -> \change { die 'not setup yet' };
        my $tap = $s.tap: -> \change {
            @seen.push(change);
            isa-ok change, IO::Notification::Change, 'only Change objects';
            $check-event(change);
        }
        isa-ok $tap, Tap, 'did we get a tap?';

        $check-event = -> \change {
            is change.event, FileChanged, 'file save appear as FileChanged';
            ok change.path.IO ~~ :e & :f, 'file does exist';
            # TODO verify modified time if file system supported
        };
        ok $handle.say( "Hello world" ), 'did the write go ok';

        sleep $forawhile;
        is +@seen, 1, 'did we get an event for writing to the file';

        $check-event = -> \change {
            is change.event, FileChanged, 'file save appear as FileChanged';
            ok change.path.IO ~~ :e & :f, 'file does exist';
            # TODO verify modified time if file system supported
        };
        ok $handle.close, 'did the file close ok';

        sleep $forawhile;
        is +@seen, 1, 'did we get an event for closing the file';

        $handle = open( $filename, :a );
        isa-ok $handle, IO::Handle, 'did we get a handle again?';

        sleep $forawhile;
        is +@seen, 2, 'did we get an event for opening the file again';

        ok $handle.say( "Hello world again" ), 'did the second write work';

        sleep $forawhile;
        is +@seen, 3, 'did we get an event for writing to the file again';

        $check-event = -> \change {
            is change.event, FileChanged, 'file save appear as FileChanged';
            ok change.path.IO ~~ :e & :f, 'file does exist';
            # TODO verify modified time if file system supported
        };
        ok $handle.close, 'did closing the file again work';

        sleep $forawhile;
        is +@seen, 3, 'did we get an event for closing the file again';

        $check-event = -> \change {
            is change.event, FileChanged, 'slurp file appear as FileChanged';
            ok change.path.IO ~~ :e & :f, 'file does not exist';
            # TODO verify access time if file system supported
        };
        my $content = $filename.IO.slurp;
        is $content, "Hello world\nHello world again\n", "was the file written ok";

        sleep $forawhile;
        is +@seen, 4, 'a slurp should cause any file events';

        $check-event = -> \change {
            is change.event, FileRenamed, 'unlink file appear as FileRenamed';
            nok change.path.IO ~~ :e & :f, 'file does not exist';
        };
        unlink $filename;
        ok !$filename.IO.e, "test file removed successfully";

        sleep $forawhile;
        is +@seen, 5, 'the unlink caused an event';

        ok $tap.close, 'could we close the tap';
    }
}

# vim: ft=perl6 expandtab sw=4
