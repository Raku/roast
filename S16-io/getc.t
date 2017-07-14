use v6;
use Test;
plan 3;

# L<S32::IO/IO/"getc">

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
  push @chars, $_ while defined($_ = getc $fh);
  close $fh or die "Couldn't close \"$tmpfile\": $!\n";

  is ~@chars, "T e s t Ä Ö Ü \n \n 0", "getc() works even for utf-8 input";
}

{
    dies-ok { open('t').getc }, 'getc on a directory fails';
}

# RT #131365
with $tmpfile.IO {
    .spurt: "a♥c";
    with .open {
        is-deeply (.getc xx 4).list, ("a", "♥", "c", Nil),
            'Correct behavior near end of file';
        .close;
    }
}

END { unlink $tmpfile }

# vim: ft=perl6
