use v6;
use Test;
#plan 22;
plan *;

# L<S32::IO/Functions/spurt>

my $path = "tempfile-spurt-test";

# filename as str tests
all-tests({ $path });

# filename as IO tests
#?rakudo skip "does not support IO::Handle"
{
    all-tests({ $path.IO });
}

sub all-tests(Callable $handle) {
    my $buf = Buf.new(0xBE, 0xEF, 0xC0, 0xDE);
    my $txt = "42";

    #?niecza skip ":bin option for slurp fails"
    {
        spurt $handle(), $buf; 
        is slurp($path, :bin), $buf, "spurting Buf ok";
    }
    spurt $handle(), $txt;
    is slurp($path), $txt, "spurting txt ok";

    #?niecza skip "Excess arguments to spurt, unused named enc"
    {
        spurt $handle(), $txt, :enc("ASCII");
        is slurp($path), $txt, "spurt with enc";
    }

    #?niecza skip "Excess arguments to spurt, unused named append"
    {
        spurt $handle(), $buf;
        spurt $handle(), $buf, :append;
        is slurp($path, :bin), ($buf ~ $buf), "spurting Buf with append";
    }

    #?niecza skip "Excess arguments to spurt, unused named append"
    {
        spurt $handle(), $txt;
        spurt $handle(), $txt, :append;
        is slurp($path), ($txt ~ $txt), "spurting txt with append";
    }
    
    unlink $path;

    #?niecza skip "Excess arguments to spurt, unused named createonly" 
    lives_ok { spurt $handle(), $buf, :createonly }, "createonly creates file with Buf";
    #?niecza todo ""
    ok $path.IO.e, "file was created";
    dies_ok { spurt $handle(), $txt, :createonly }, "createonly with Buf fails if file exists";
    unlink $path;

    #?niecza skip "Excess arguments to spurt, unused named createonly" 
    lives_ok { spurt $handle(), $txt, :createonly }, "createonly with text creates file";
    #?niecza todo ""
    ok $path.IO.e, "file was created";
    dies_ok { spurt $handle(), $txt, :createonly }, "createonly with text fails if file exists";
    unlink $path;
}

done;

CATCH {
    unlink $path;
}

if $path.IO.e {
    say "Warn: '$path shouldn't exist";
    unlink $path;
}
