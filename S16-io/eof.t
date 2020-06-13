use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 5;

{
    my $tmpfile := make-temp-file :content("EOF_TESTING\n\n");
    my $fh = open $tmpfile;
    $fh.lines;
    is-deeply $fh.eof, True, 'Regular file EOF was reached';
    close $fh;
}

# https://github.com/Raku/old-issue-tracker/issues/5087
{
  if $*KERNEL.name eq 'linux' {
    # https://github.com/Raku/old-issue-tracker/issues/5527
    my $files = gather {
        for '/proc/1'.IO.dir() -> $file {
            take $file if $file.f && $file.r;
        }
    }
    my $fh = $files[0].open;
    $fh.slurp;

    is-deeply $fh.eof, True, '/proc file EOF was reached';
    $fh.close;
  }
  else {
    skip "Don't test reading /proc file if not in Linux", 1;
  }
}

# https://github.com/Raku/old-issue-tracker/issues/2593
#?rakudo.jvm skip 'hangs'
#?DOES 1
{
  run-with-tty ｢with $*IN { .eof.say; .slurp.say; .eof.say }｣, :in<meow>,
    # Here we use .ends-width because (currently) there's some sort of
    # bug with Proc or something where sent STDIN ends up on our STDOUT.
    # Extra "\n" after `meow` is 'cause run-as-tty sends extra new line,
    # 'cause MacOS's `script` really wants it or something
    :out{ .ends-with: "False\nmeow\n\nTrue\n" or do {
        diag "Got STDOUT: {.raku}";
        False;
    }}, '.eof on TTY STDIN works right';
}

# https://github.com/rakudo/rakudo/issues/1322
subtest '.eof works right even when we seek past end and back' => {
    plan 6;

    my $fh will leave {.close} = open make-temp-file :content<meows>;
    is-deeply $fh.eof, False, 'freshly opened';

    $fh.seek: 1000, SeekFromBeginning;
    is-deeply $fh.eof, True, "seek'ed past end";

    $fh.seek: 1, SeekFromBeginning;
    is-deeply $fh.eof, False, "seek'ed back into the actual contents";

    $fh.slurp;
    is-deeply $fh.eof, True, "slurped contents";

    $fh.seek: 3, SeekFromBeginning;
    is-deeply $fh.eof, False, "seek'ed back";

    $fh.seek: 5, SeekFromEnd;
    is-deeply $fh.eof, True, "seek'ed past end again";
}

# https://github.com/rakudo/rakudo/issues/1533
subtest '.eof on empty files' => {
    plan 3;
    with make-temp-file(:content('')).open {
        is-deeply .eof, False, 'eof is False before any reads';
        .read: 42;
        is-deeply .eof, True,  'eof is True after a read';
    }
    with "/proc/$*PID/status".IO -> $p {
        subtest "reading from '$p'" => {
            plan 3;
            when not $p.e { skip "don't have '$p' available", 3 }
            with $p.open {
                is-deeply .eof, False, 'eof is False before any reads';
                cmp-ok .get, &[!~~], Nil, '.get reads something';
                .slurp;
                is-deeply .eof, True,  'eof is True after slurpage';
            }
            else -> $e {
                skip "failed to .open '$p': {$e.exception.message}", 3;
            }
        }
    }
}

# vim: expandtab shiftwidth=4
