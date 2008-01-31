use v6-alpha;
use Test;

# L<S16/"Filehandles, files, and directories"/"open">

plan 13; 

if $*OS eq "browser" {
  skip_rest "Programs running in browsers don't have access to regular IO.";
  exit;
}


my $filename = 'tempfile';

{ # write the file first
    my $fh = open($filename, :w);
    for (1 .. 6) -> $num {
        $fh.print("$num\n");
    }
    $fh.close();
}

{ # now read it in and check
    my $fh = open($filename);
    my $num = 1;
    while ($num <= 6) {
        my $line = =$fh;
        is($line, "$num", '... got the right line (array controlled loop)');
        $num++;
    }
    $fh.close();
}

{ # now read it in with the $fh controling the loop
    my $fh = open($filename);
    my $num = 1;
    my $line;
    while ($line = =$fh) {
        is($line, "$num", '... got the right line (=$fh controlled loop)');
        $num++;
    }
    $fh.close();
}

is(unlink($filename), 1, 'file has been removed');
