use v6;
use Test;
plan 4;

sub nonce () { return (".{$*PID}." ~ 1000.rand.Int) }

my $tmpfile = "temp-test" ~ nonce();
{
  my $fh = open($tmpfile, :w) or die "Couldn't open \"$tmpfile\" for writing: $!\n";
  $fh.print: "TestÄÖÜ\n\n0";
  close $fh or die "Couldn't close \"$tmpfile\": $!\n";
}

{
  my $fh = open $tmpfile or die "Couldn't open \"$tmpfile\" for reading: $!\n";
  my @chars;
  push @chars, $_ while $_ = $fh.readchars(2);
  close $fh or die "Couldn't close \"$tmpfile\": $!\n";

  is ~@chars, "Te st ÄÖ Ü\n \n0", "readchars(2) works even for utf-8 input";
}

{
    dies-ok { open('t').readchars }, 'readchars on a directory fails';
}

# RT #131383
with $tmpfile.IO {
    .spurt: "a♥c";
    with .open {
        is-deeply (.readchars(1) xx 4).list, ("a", "♥", "c", ""),
            'readchars works near the end of the file (1)';
        .close;
    }
}
with $tmpfile.IO {
    .spurt: "fo♥";
    with .open {
        is .readchars(2), "fo", 'readchars works near the end of the file (2)';
        .close;
    }
}

END { unlink $tmpfile }

# vim: ft=perl6
