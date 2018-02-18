use v6;
use lib <t/spec/packages/>;
use Test;
use Test::Util;

plan 5;

sub nonce () { return (".{$*PID}." ~ 1000.rand.Int) }

my $tmpfile = "eof-test-" ~ nonce();
END unlink $tmpfile;

{
  my $fh = open($tmpfile, :w) or die qq/Failed to open "$tmpfile": $!/;
  $fh.print: "EOF_TESTING\n\n";
  close $fh or die qq/Failed to close "$tmpfile": $!/;
}

{
  my $fh = open $tmpfile or die qq/Failed to open "$tmpfile": $!/;
  $fh.lines;

  ok $fh.eof, 'Regular file EOF was reached';
  close $fh or die qq/Failed to close "$tmpfile": $!/;
}

# RT #127370
{
  if $*KERNEL.name eq 'linux' {
    # RT #128831
    my $files = gather {
        for '/proc/1'.IO.dir() -> $file {
            take $file if $file.f && $file.r;
        }
    }
    my $fh = $files[0].open;
    $fh.slurp;

    ok $fh.eof, '/proc file EOF was reached';
    $fh.close;
  }
  else {
    skip "Don't test reading /proc file if not in Linux", 1;
  }
}

# RT # 132349
#?rakudo.jvm skip 'hangs'
#?DOES 1
{
  run-with-tty ｢with $*IN { .eof.say; .slurp.say; .eof.say }｣, :in<meow>,
    # Here we use .ends-width because (currently) there's some sort of
    # bug with Proc or something where sent STDIN ends up on our STDOUT.
    # Extra "\n" after `meow` is 'cause run-as-tty sends extra new line,
    # 'cause MacOS's `script` really wants it or something
    :out{ .ends-with: "False\nmeow\n\nTrue\n" or do {
        diag "Got STDOUT: {.perl}";
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
    #?rakudo.jvm todo 'Rakudo GH #1322 not yet fixed for JVM'
    is-deeply $fh.eof, False, "seek'ed back into the actual contents";

    $fh.slurp;
    is-deeply $fh.eof, True, "slurped contents";

    $fh.seek: 3, SeekFromBeginning;
    #?rakudo.jvm todo 'Rakudo GH #1322 not yet fixed for JVM'
    is-deeply $fh.eof, False, "seek'ed back";

    $fh.seek: 5, SeekFromEnd;
    is-deeply $fh.eof, True, "seek'ed past end again";
}

# https://github.com/rakudo/rakudo/issues/1533
subtest '.eof on empty files' => {
    plan 3;
    with make-temp-file(:content('')).open {
        #?rakudo.jvm todo 'https://github.com/rakudo/rakudo/issues/1541'
        is-deeply .eof, False, 'eof is False before any reads';
        .read: 42;
        is-deeply .eof, True,  'eof is True after a read';
    }
    with "/proc/$*PID/status".IO -> $p {
        subtest "reading from '$p'" => {
            plan 3;
            when not $p.e { skip "don't have '$p' available", 3 }
            with $p.open {
                #?rakudo.jvm 2 todo 'https://github.com/rakudo/rakudo/issues/1541'
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

# vim: ft=perl6
