use v6;
use Test;

plan 1;

# L<S29/Context/"=item evalfile">

sub nonce () { return (".$*PID." ~ int rand 1000) }

if $*OS eq "browser" {
    skip_rest "Programs running in browsers don't have access to regular IO.";
    exit;
}

my $tmpfile = "temp-evalfile" ~ nonce();
{
    my $fh = open("$tmpfile", :w);
    say $fh: "32 + 10";
    close $fh;
}

is evalfile($tmpfile), 42, "evalfile() works";

END { unlink $tmpfile }
