use v6;
use Test;

plan 1;

# L<S29/Context/"=item evalfile">

sub nonce () { return (".{$*PID}." ~ 1000.rand.Int) }

my $tmpfile = "temp-evalfile" ~ nonce();
{
    my $fh = open("$tmpfile", :w);
    say $fh: "32 + 10";
    close $fh;
}

is evalfile($tmpfile), 42, "evalfile() works";

END { unlink $tmpfile }

# vim: ft=perl6
