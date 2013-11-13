use v6;
use Test;

# L<S32::IO/IO::File/open>
# old: L<S16/"Filehandles, files, and directories"/"open">

plan 13; 

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

{ # now read it in with the $fh controling the loop
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

# vim: ft=perl6
