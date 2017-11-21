use v6;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;

plan 3;

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

# vim: ft=perl6
