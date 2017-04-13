use v6;
use lib <t/spec/packages/>;
use Test;
use Test::Util;

plan 60;

# L<S32::IO/Functions/spurt>

my $path = "tempfile-spurt-test";

# filename as str tests
all-basic({ $path });

# filename as IO tests
all-basic({ $path.IO });

sub all-basic(Callable $handle) {
    my Blob $buf = "hello world".encode("utf-8");
    my $txt = "42";

    spurt $handle(), $buf;
    is slurp($path, :bin), $buf, "spurting Buf ok";

    spurt $handle(), $txt;
    is slurp($path), $txt, "spurting txt ok";

    spurt $handle(), $txt, :enc("ASCII");
    is slurp($path), $txt, "spurt with enc";

    spurt $handle(), $buf;
    spurt $handle(), $buf, :append;
    is slurp($path, :bin), ($buf ~ $buf), "spurting Buf with append";

    spurt $handle(), $txt;
    spurt $handle(), $txt, :append;
    is slurp($path), ($txt ~ $txt), "spurting txt with append";

    unlink $path;

    lives-ok { spurt $handle(), $buf, :createonly }, "createonly creates file with Buf";
    ok $path.IO.e, "file was created";
    dies-ok { spurt $handle(), $buf, :createonly }, "createonly with Buf fails if file exists";
    unlink $path;

    lives-ok { spurt $handle(), $txt, :createonly }, "createonly with text creates file";
    ok $path.IO.e, "file was created";
    dies-ok { spurt $handle(), $txt, :createonly }, "createonly with text fails if file exists";
    unlink $path;
}

# Corner cases
{
    # Spurt on open file
    {
        spurt $path, "42";
        is slurp($path), "42", 'can spurt into an open file';
    }

    # Buf into an open non binary file
{
        my Buf $buf = Buf.new(0xC0, 0x01, 0xF0, 0x0D);
        spurt $path, $buf;
        is slurp($path, :bin), $buf, 'can spurt a Buf into an open handle';
}

    # Text into a open binary file
{
        my Str $txt = "Bli itj nå trønder-rock uten tennis-sokk";
        spurt $path, $txt;
        is slurp($path), $txt, 'can spurt text into a binary handle';
}

    # spurting to a directory
    {
        dies-ok { open('t').spurt("'Twas brillig, and the slithy toves") },
            '.spurt()ing to a directory fails';
        dies-ok { spurt('t', 'Did gyre and gimble in the wabe') },
            '&spurt()ing to a directory fails';
    }

    unlink $path;
}


# IO::Handle spurt
{
    $path.IO.spurt("42");
    is slurp($path), "42", "IO::Handle slurp";

    my Blob $buf = "meow".encode("ASCII");
    $path.IO.spurt($buf);
    is slurp($path, :bin), $buf, "IO::Handle binary slurp";

    dies-ok { $path.IO.spurt("nope", :createonly) }, "IO::Handle :createonly dies";
    unlink $path;
    lives-ok { $path.IO.spurt("yes", :createonly) }, "IO::Handle :createonly lives";
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

CATCH {
    unlink $path;
}

if $path.IO.e {
    say "Warn: '$path shouldn't exist";
    unlink $path;
}

# RT #126006
{
    given 'temp-file-RT-126006-test'.IO {
        LEAVE .unlink;
        when .e { flunk "ABORT: cannot run test while file `$_` exists"; }

        .spurt: 'something';
        is .e, True, 'for non-existent file after spurting, .e says it exists';
    }
}

{ # 2017 IO Grant
    sub test-spurt ($file, $data, $expected = $data, :$senc, :$meth, |args) {
        my &SPURT = $meth ?? IO::Path.^lookup('spurt') !! &spurt;
        subtest "spurt {$data.^name} {args.perl} {$senc if $senc}" => {
            plan 2;
            my $form = "[{&SPURT.^name.lc} form]";

            ok SPURT($file, $data, |args),  "spurt is successful $form";
            is-deeply |(
                $expected ~~ Blob
                    ?? ($file.slurp(:bin), (Buf[uint8].new: $expected))
                    !! ($file.slurp(:enc($senc || args<enc> || 'utf8')),
                        $expected)
            ), "wrote correct data $form";
        }
    }

    #?DOES 1
    sub test-spurt-fails ($file, $data, $expected = $data, :$meth, |args) {
        my &SPURT = $meth ?? IO::Path.^lookup('spurt') !! &spurt;

        subtest "spurt {$data.^name} {args.perl} fails" => {
            plan 1;
            my $form = "[{&SPURT.^name.lc} form]";

            my $res = SPURT($file, $data, |args);
            isa-ok $res, Failure, 'failed spurt returns a Failure';
            $res.so; # handle Failure
        }
    }

    constant $str = "I ♥ Perl 6";
    constant $bin = $str.encode;

    test-spurt make-temp-file(), $str;
    test-spurt make-temp-file(), $str, :meth;
    #?rakudo.jvm 2 todo '[io grant] expected: Buf[uint8].new(200); got: Buf[uint8].new(200); maybe caused by RT #128041'
    test-spurt make-temp-file(), $bin;
    test-spurt make-temp-file(), $bin, :meth;

    with make-temp-file() {
        with .open(:w) { .print: "Hi!"; .close }
        test-spurt-fails $_, $str, :createonly;
        test-spurt-fails $_, $str, :createonly, :meth;
        test-spurt-fails $_, $bin, :createonly;
        test-spurt-fails $_, $bin, :createonly, :meth;

        test-spurt $_, $str, "Hi!" ~ $str,     :append;
        test-spurt $_, $str, "Hi!" ~ $str x 2, :append, :meth;
        test-spurt $_, $bin, "Hi!" ~ $str x 3, :append;
        test-spurt $_, $bin, "Hi!" ~ $str x 4, :append, :meth;
    }

    constant $lstr = Buf.new(200).decode('Latin-1');
    constant $lbin = Buf.new(200);

    test-spurt make-temp-file(), $lstr, :enc<Latin-1>;
    test-spurt make-temp-file(), $lstr, :enc<Latin-1>, :meth;
    #?rakudo.jvm 2 todo '[io grant] expected: Buf[uint8].new(200); got: Buf[uint8].new(200); maybe caused by RT #128041'
    test-spurt make-temp-file(), $lbin;
    test-spurt make-temp-file(), $lbin, :meth;

    with make-temp-file() {
        with .open(:w) { .print: "Hi!"; .close }
        test-spurt-fails $_, $lstr, :enc<Latin-1>, :createonly;
        test-spurt-fails $_, $lstr, :enc<Latin-1>, :createonly, :meth;
        test-spurt-fails $_, $lbin, :createonly;
        test-spurt-fails $_, $lbin, :createonly, :meth;

        test-spurt $_, $lstr, "Hi!" ~ $lstr,     :append, :enc<Latin-1>;
        test-spurt $_, $lstr, "Hi!" ~ $lstr x 2, :append, :enc<Latin-1>, :meth;
        test-spurt $_, $lbin, "Hi!" ~ $lstr x 3, :append, :senc<Latin-1>;
        test-spurt $_, $lbin, "Hi!" ~ $lstr x 4, :append, :senc<Latin-1>, :meth;
    }
}
