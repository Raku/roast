use v6;
use Test;

# L<S32::IO/IO::File/open>
# old: L<S16/"Filehandles, files, and directories"/"open">
# old: L<S16/"Filehandles, files, and directories"/"close">

plan 29;

my $filename = 'tempfile_io_in_for_loop';

{ # write the file first
    my $fh = open($filename, :w);
    for (1 .. 6) -> $num {
        $fh.print("$num\n");
    }
    $fh.close();
}

{ # now read it in and check
    my $fh = open($filename);
    for (1 .. 6) -> $num {
        my $line = get $fh;
        is($line, "$num", '... got the right line (array controlled loop)');
    }
    $fh.close();
}

#?DOES 6
{ # now read it in with the $fh controlling the loop
    my $fh = open($filename);
    my $num = 1;
    for ($fh.lines) -> $line {
        is($line, "$num", '... got the right line (($fh.lines) controlled loop)');
        $num++;
    }
    $fh.close();
}

#?DOES 6
{ # now read it in with the $fh controlling the loop w/out parens
    my $fh = open($filename);
    my $num = 1;
    for $fh.lines -> $line {
        is($line, "$num", '... got the right line ($fh.lines controlled loop)');
        $num++;
    }
    $fh.close();
}

## more complex loops

#?DOES 6
{ # now read it in and check
    my $fh = open($filename);
    my $num = 1;
    for (1 .. 3) -> $_num {
        my $line = get $fh;
        is($line, "$num", '... got the right line (array controlled loop)');
        $num++;
        my $line2 = get $fh;
        is($line2, "$num", '... got the right line2 (array controlled loop)');        
        $num++;        
    }
    $fh.close();
}

{ # now read it in with the $fh controlling the loop but call 
  # the $fh.get inside the loop inside parens (is this list context??)
    my $fh = open($filename);
    my $num = 1;
    for $fh.get -> $line {
        is($line, "$num", '... got the right line ((=$fh) controlled loop)');
        $num++;
        my $line2 = get $fh;
        is($line2, "$num", '... got the right line2 ((=$fh) controlled loop)');
        $num++;
    }
    $fh.close();
}

{ # now read it in with the $fh controlling the loop but call 
  # the get $fh inside the loop w/out parens (is this scalar context??)
    my $fh = open($filename);
    my $num = 1;
    for get $fh -> $line {
        is($line, "$num", '... got the right line (=$fh controlled loop)');
        $num++;
        my $line2 = get $fh;
        is($line2, "$num", '... got the right line2 (=$fh controlled loop)');
        $num++;
    }
    $fh.close();
}

# old: L<S16/"Filehandles, files, and directories"/"unlink">
# L<S29/IO/unlink>

ok(unlink($filename), 'file has been removed');

# vim: ft=perl6
