use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 4;

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
    my $tmpfile = "temp-evalfile" ~ nonce();
    {
        my $fh = open("$tmpfile", :w);
        say $fh: "32 + 10";
        close $fh;
    }
    is EVALFILE($tmpfile.IO), 42, "EVALFILE() works with IO::Path";
    END { unlink $tmpfile }
}

{
    my $tmpfile = "temp-evalfile" ~ nonce();
    {
        my $fh = open("$tmpfile", :w);
        say $fh: "Backtrace.new";
        close $fh;
    }
    ok EVALFILE($tmpfile).list.grep(*.file eq $tmpfile).Bool, 'the filename is there in the stacktrace from EVALFILE';
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

# vim: expandtab shiftwidth=4
