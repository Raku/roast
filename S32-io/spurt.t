use v6;
use Test;
#plan 22;
plan *;

# L<S32::IO/Functions/spurt>

my $path = "tempfile-spurt-test";

# filename as str tests
all-basic({ $path });

# filename as IO tests
#?rakudo skip "spurt on handle not implemented"
{
    all-basic({ $path.IO });
}

sub all-basic(Callable $handle) {
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
    dies_ok { spurt $handle(), $buf, :createonly }, "createonly with Buf fails if file exists";
    unlink $path;

    #?niecza skip "Excess arguments to spurt, unused named createonly" 
    lives_ok { spurt $handle(), $txt, :createonly }, "createonly with text creates file";
    #?niecza todo ""
    ok $path.IO.e, "file was created";
    dies_ok { spurt $handle(), $txt, :createonly }, "createonly with text fails if file exists";
    unlink $path;
}

# Corner cases
#?rakudo skip "spurt on handle not implemented"
{
    # Spurt on open handle
    {
        my $io = $path.IO.open(:w);
        spurt $io, "42";
        is slurp($path), "42"; # Can spurt into an open handle.
    }

    # Buf into an open non binary handle
    {
        my $io = $path.IO.open(:w);
        my Buf $buf = Buf.new(0xC0, 0x01, 0xF0, 0x0D);
        spurt $io, $buf;
        is slurp($path, :bin), $buf;
    }

    # Text into a open binary handle
    {
        my $io = $path.IO.open(:bin, :w);
        my Str $txt = "Bli itj nå trønder-rock uten tennis-sokk";
        spurt $io, $txt;
        is slurp($path), $txt;
    }
        
    unlink $path;
}


# IO::Handle spurt
#?rakudo skip "not implemented"
#?niecza skip ""
{
    $path.IO.spurt("42");
    is slurp($path), "42", "IO::Handle slurp";

    my Buf $buf = Buf.new(0xF0, 0x01);
    $path.IO.spurt($buf);
    is slurp($path, :bin), $buf, "IO::Handle binary slurp";
    
    dies_ok { $path.IO.spurt("nope", :createonly) }, "IO::Handle :createonly dies";
    unlink $path;
    lives_ok { $path.IO.spurt("yes", :createonly) }, "IO::Handle :createonly lives";
    ok $path.IO.e, "IO::Handle :createonly created a file";
    
    # Append
    {
        my $io = $path.IO;
        $io.spurt("hello ");
        $io.spurt("world", :append);
        is slurp($path), "hello world", "IO::Handle spurt :append";
    }

    # Not append!
    {
        my $io = $path.IO;
        $io.spurt("hello ");
        $io.spurt("world");
        is slurp($path), "world", "IO::Handle not :append";
    }

    # encoding
    {
        my $t = "Bli itj nå fin uten mokkasin";
        $path.IO.spurt($t, :enc("utf8"));
        is slurp($path), $t, "IO::Handle :enc";
    }
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
