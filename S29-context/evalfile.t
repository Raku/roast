use v6;
use Test;

plan 2;

# L<S29/Context/"=item EVALFILE">

sub nonce () { return (".{$*PID}." ~ 1000.rand.Int) }

{
    my $tmpfile = "temp-evalfile" ~ nonce();
    {
        my $fh = open("$tmpfile", :w);
        say $fh: "32 + 10";
        close $fh;
    }
    is EVALFILE($tmpfile), 42, "EVALFILE() works";
    END { unlink $tmpfile }
}

{
    my $tmpfile = "temp-evalfile-lexical" ~ nonce();
    {
        my $fh = open("$tmpfile", :w);
        say $fh: '$some_var';
        close $fh;
    }
    my $some_var = 'samovar';
    is EVALFILE($tmpfile), 'samovar', "EVALFILE() evaluated code can see lexicals";
    END { unlink $tmpfile }
}

# vim: ft=perl6
