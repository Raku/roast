use v6;
use Test;
plan 12;
# L<S32::IO/Functions/spurt>

my $path = "tempfile-spurt-test";

# Tests for:
#    multi spurt (Str $filename,
#                 Buf   $contents,
#                 Bool :append = False,
#                 Bool :$createonly = False)
#
# and
#
#    multi spurt (Str $filename,
#                 Str   $contents,
#                 Str  :$enc = $?ENC,
#                 Bool :append = False,
#                 Bool :$createonly = False,
#?niecza skip "does not like Buf.new"
{
    my $buf = Buf.new(0xBE, 0xEF, 0xC0, 0xDE);

    spurt($path, $buf); 
    is slurp($path, :bin), $buf, "spurting Buf ok";

    spurt $path, "24", :enc("ASCII");
    is slurp($path), "24", "spurt to IO with enc";

    spurt $path, $buf;
    spurt $path, $buf, :append;
    is slurp($path, :bin), ($buf ~ $buf), "spurting Buf with append";
    unlink $path;

    lives_ok { spurt $path, $buf, :createonly }, "createonly creates file";
    ok $path.IO.e, "file was created";
    dies_ok { spurt $path, :createonly }, "createonly fails if file exists";
    unlink $path;
}

# Tests for:
#    multi spurt (IO $fh,
#                 Str   $contents,
#                 Str  :$enc = $?ENC,
#                 Bool :append = False,
#                 Bool :$createonly = False)
# and
#
#    multi spurt (IO $fh,
#                 Buf   $contents,
#                 Bool :append = False,
#                 Bool :$createonly = False)
#?rakudo skip "No matching signature"
{
    spurt $path.IO, "42";
    is slurp($path), "42", "spurt to IO";

    #?niecza skip "Excess arguments to spurt, unused named enc"
    {
        spurt $path.IO, "24", :enc("ASCII");
        is slurp($path), "24", "spurt to IO with enc";
    }
    
    #?niecza skip "Excess arguments to spurt, unused named append"
    {
        spurt $path.IO, "42";
        spurt $path.IO, "24", :append;
        is slurp($path), "4224", "spurt to IO with append";
    }
    unlink $path;

    #?niecza 2 skip "Excess arguments to spurt, unused named createonly"
    lives_ok { spurt $path.IO, "", :createonly }
    ok $path.IO.e, "file was created";
    dies_ok { spurt $path.IO, "", :createonly }
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
