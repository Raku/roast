use v6;
use Test;

# L<S32::IO/IO::File/open>
# old: L<S16/"Filehandles, files, and directories"/"open">

plan 16;

my $filename = 'tempfile_io_in_while_loop';

{ # write the file first
    my $fh = open($filename, :w);
    for 1 .. 6 -> $num {
        $fh.print("$num\n");
    }
    $fh.close();
}

{ # now read it in and check
    my $fh = open($filename);
    my $num = 1;
    while $num <= 6 {
        my $line = get $fh;
        is($line, "$num", '... got the right line (array controlled loop)');
        $num++;
    }
    $fh.close();
}

{ # now read it in with the $fh controlling the loop
    my $fh = open($filename);
    my $num = 1;
    my $line;
    while $line = get $fh {
        is($line, "$num", '... got the right line (get $fh controlled loop)');
        $num++;
    }
    $fh.close();
}

ok(unlink($filename), 'file has been removed');

# RT #122971
#?rakudo.jvm todo 'Multi-line separators on JVM'
{
    spurt($filename, q:to/FASTAISH/.subst(/\r\n/, "\n"));
        >roa1_drome Rea guano receptor type III >> 0.1
        MVNSNQNQNGNSNGHDDDFPQDSITEPEHMRKLFIGGLDYRTTDENLKAHEKWGNIVDVV
        >roa2_drome Rea guano ligand
        MVNSNQNQNGNSNGHDDDFPQDSITEPEHMRKLFIGGLDYRTTDENLKAHEKWGNIVDVV
        FASTAISH

    my $fh = open($filename, nl => "\n>");
    my @lines;
    while my $line = get $fh {
        @lines.push($line);
    }
    is @lines.elems, 2, 'Read correct number of lines with multi-char separator';
    ok @lines[0] ~~ /^'>roa1'/, 'Correct first line';
    ok @lines[1] ~~ /^'roa2'/, 'Correct second line';
    $fh.close;
}

# vim: ft=perl6
