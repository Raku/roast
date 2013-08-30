use v6;
use Test;

plan 29;

my $existing-file     = "tempfile-copy";
my $non-existent-file = "non-existent-copy";
my $zero-length-file  = "tempfile-zero-length-copy";

{ # write the file first
    my $fh = open($existing-file, :w);
    $fh.print: "0123456789A";
    $fh.close();
}

{ # write the file first
    my $fh = open($zero-length-file, :w);
    $fh.close();
}

# sanity check
ok $existing-file.IO.e, 'It exists';
ok $zero-length-file.IO.e, 'It exists';
nok $non-existent-file.IO.e, "It doesn't";

# method .IO.copy
#?niecza skip 'Unable to resolve method s in class IO'
{
    my $existing-file-mtgt     = "tempfile-copy-mtgt";
    my $non-existent-file-mtgt = "non-existent-copy-mtgt";
    my $zero-length-file-mtgt  = "tempfile-zero-length-copy-mtgt";
    
    ok $existing-file.IO.copy( $existing-file-mtgt ), '.IO.copy normal file';
    ok $existing-file-mtgt.IO.e, 'It exists';
    ok $existing-file-mtgt.IO.s, 'It has a size';
    is $existing-file-mtgt.IO.s, $existing-file.IO.s, 'The size is equal to source file';

    dies_ok { $non-existent-file.IO.copy( $non-existent-file-mtgt ) }, '.IO.copy missing file';
    nok $non-existent-file-mtgt.IO.e, "It doesn't";

    ok $zero-length-file.IO.copy( $zero-length-file-mtgt ), '.IO.copy empty file';
    ok $zero-length-file-mtgt.IO.e, 'It exists';
    nok $zero-length-file-mtgt.IO.s, 'It has no size';
    is $zero-length-file-mtgt.IO.s, $zero-length-file.IO.s, 'The size is equal to source file';

    ok unlink($existing-file-mtgt), 'file has been removed';
    ok unlink($zero-length-file-mtgt), 'file has been removed';
}

# sub copy()
#?niecza skip 'Unable to resolve method s in class IO'
{
    my $existing-file-stgt     = "tempfile-copy-stgt";
    my $non-existent-file-stgt = "non-existent-copy-stgt";
    my $zero-length-file-stgt  = "tempfile-zero-length-copy-stgt";
    
    ok copy( $existing-file, $existing-file-stgt ), 'copy() normal file';
    ok $existing-file-stgt.IO.e, 'It exists';
    ok $existing-file-stgt.IO.s, 'It has a size';
    is $existing-file-stgt.IO.s, $existing-file.IO.s, 'The size is equal to source file';

    dies_ok { copy( $non-existent-file, $non-existent-file-stgt ) }, 'copy() missing file';
    nok $non-existent-file-stgt.IO.e, "It doesn't";

    ok copy( $zero-length-file, $zero-length-file-stgt ), 'copy() empty file';
    ok $zero-length-file-stgt.IO.e, 'It exists';
    nok $zero-length-file-stgt.IO.s, 'It has no size';
    is $zero-length-file-stgt.IO.s, $zero-length-file.IO.s, 'The size is equal to source file';

    ok unlink($existing-file-stgt), 'file has been removed';
    ok unlink($zero-length-file-stgt), 'file has been removed';
}

# clean up
ok unlink($existing-file), 'file has been removed';
ok unlink($zero-length-file), 'file has been removed';

# vim: ft=perl6
