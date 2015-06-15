use v6;
use Test;

my $existing-file1 = "tempfile-rename1";
my $existing-file2 = "tempfile-rename2";
my $non-existent-file = "non-existent-rename";

{ # write the file first
    my $fh = open($existing-file1, :w);
    $fh.print: "0123456789AB";
    $fh.close();
}

{ # write the file first
    my $fh = open($existing-file2, :w);
    $fh.print: "0123456789ABC";
    $fh.close();
}

# sanity check
ok $existing-file1.IO.e, 'sanity check 1';
ok $existing-file2.IO.e, 'sanity check 2';
nok $non-existent-file.IO.e, "sanity check 2";

# method .IO.rename
#?niecza skip 'Unable to resolve method s in class IO'
{
    my $dest1a = "tempfile-rename-dest1a";
    my $dest1b = "tempfile-rename-dest1b";
    
    my $existing-size1 = $existing-file1.IO.s;
    ok $existing-file1.IO.rename( $dest1a ), '.IO.rename normal file';
    nok $existing-file1.IO.e, 'source file no longer exists';
    ok $dest1a.IO.e, 'dest file exists';
    is $dest1a.IO.s, $existing-size1, 'dest file has same size as source file';
    
    throws-like { $non-existent-file.IO.rename( $dest1b ) }, X::IO::Rename, '.IO.rename non-existent file';
    nok $dest1b.IO.e, "dest file doesn't exist";

    throws-like { $dest1b.IO.rename( $dest1a, :createonly ) },
      X::IO::Rename, '.IO.rename createonly fail';
    nok $dest1b.IO.e, "dest file doesn't exist";

    ok $dest1a.IO.rename( $dest1b, :createonly ), '.IO.rename createonly';
    ok $dest1b.IO.e, "dest file does exist";

    ok unlink($dest1a), 'clean-up 1a';
    ok unlink($dest1b), 'clean-up 1b';
}

# sub rename()
#?niecza skip 'Unable to resolve method s in class IO'
{
    my $dest2a = "tempfile-rename-dest2a";
    my $dest2b = "tempfile-rename-dest2b";
    
    my $existing-size3 = $existing-file2.IO.s;
    ok rename( $existing-file2, $dest2a ), 'rename() normal file';
    nok $existing-file1.IO.e, 'source file no longer exists';
    ok $dest2a.IO.e, 'dest file exists';
    is $dest2a.IO.s, $existing-size3, 'dest file has same size as source file';

    throws-like { rename( $non-existent-file, $dest2b ) }, X::IO::Rename; '.IO.rename missing file';
    nok $dest2b.IO.e, "It doesn't";

    throws-like { rename( $dest2b, $dest2a, :createonly ) },
      X::IO::Rename, 'rename createonly fail';
    nok $dest2b.IO.e, "dest file doesn't exist";

    ok rename( $dest2a, $dest2b, :createonly ), 'rename createonly';
    ok $dest2b.IO.e, "dest file does exist";

    ok unlink($dest2a), 'clean-up 2a';
    ok unlink($dest2b), 'clean-up 2b';
}

# clean up
ok unlink($existing-file1), 'clean-up 3';
ok unlink($existing-file2), 'clean-up 4';

done;

# vim: ft=perl6
