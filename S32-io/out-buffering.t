use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 4;

sub test-out-buffer(
    Str:D $desc, &test, UInt:D :$buffer = 1000, UInt :$exp-bytes, Capture :$open-args = \(:w)
) is test-assertion {
    state $path = make-temp-file;
    # print an empty string after open. It's allowed for implementation to pass the first print
    # unbuffed, to test if the handle is writable
    subtest "out-buffer for $desc" => {
        plan 1;
        $path.open(:w).close; # clear out the file
        (my $fh := $path.open: :out-buffer($buffer), |$open-args).print: '';
        test $fh;
        cmp-ok $path.slurp(:bin).elems, '==', $exp-bytes,
            'file contains expected number of bytes';
        # note: it's expected for .close to be AFTER the file size check; the assumption is
        # the user of the routine is checking file content before all buffers are flushed
        $fh.close;
    }
}

for \(:w), \(:rw), \(:a) -> $open-args {
    subtest ".open: $open-args.raku()" => {
        plan 10;
        test-out-buffer :10buffer, :15exp-bytes, :$open-args, '1 x over', { .print: 'x' x 15 };
        test-out-buffer :10buffer, :15exp-bytes, :$open-args, '1 x over + 1 x under', {
            .print: 'x' x 15; .print: 'x' x 4;
        };

        test-out-buffer :10buffer, :19exp-bytes, :$open-args, '1 x over + 1 x under + .flush', {
            .print: 'x' x 15; .print: 'x' x 4; .flush;
        };

        test-out-buffer :10buffer, :19exp-bytes, :$open-args, '1 x over + 1 x under + .close', {
            .print: 'x' x 15; .print: 'x' x 4; .close;
        };

        test-out-buffer :10buffer, :38exp-bytes, :$open-args, '[1 x over + 1 x under + .flush]x2', {
            .print: 'x' x 15; .print: 'x' x 4; .flush; .print: 'x' x 15; .print: 'x' x 4; .flush;
        };

        test-out-buffer :10buffer, :38exp-bytes, :$open-args,
            '[1 x over + 1 x under + *] X [.flush, .close]', {
            .print: 'x' x 15; .print: 'x' x 4; .flush; .print: 'x' x 15; .print: 'x' x 4; .close;
        };

        test-out-buffer :10buffer, :8exp-bytes, :$open-args,
            '1 x under + buffer resize too small to hold original print', {
            .print: 'x' x 8;
            .out-buffer = 5; # expecting buffer resize to flush
        };

        test-out-buffer :10buffer, :8exp-bytes, :$open-args,
            '1 x under + large buffer', {
            .print: 'x' x 8;
            .out-buffer = 1000; # expecting buffer resize to flush
            .print: 'x' x 100;
            .print: 'x' x 100;
            .print: 'x' x 100;
        };

        test-out-buffer :10buffer, :508exp-bytes, :$open-args,
            '1 x under + large buffer + over', {
            .print: 'x' x 8;
            .out-buffer = 1000; # expecting buffer resize to flush
            .print: 'x' x 500;
            .print: 'x' x 600;
        };

        test-out-buffer :10buffer, :1108exp-bytes, :$open-args,
            '1 x under + large buffer + over + close', {
            .print: 'x' x 8;
            .out-buffer = 1000; # expecting buffer resize to flush
            .print: 'x' x 500;
            .print: 'x' x 600;
            .flush;
        };
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6374
run-with-tty ｢say prompt "FOO"｣, :in<bar>,
    # Here we use .contains because (currently) there's some sort of
    # bug with Proc or something where sent STDIN ends up on our STDOUT.
    :out{ .contains: "FOO" & "bar" or do {
        diag "Got STDOUT: {.raku}";
        False;
    }}, 'prompt does not hang';

# vim: expandtab shiftwidth=4
