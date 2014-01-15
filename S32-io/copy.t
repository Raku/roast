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
ok $existing-file.path.e, 'It exists';
ok $zero-length-file.path.e, 'It exists';
nok $non-existent-file.path.e, "It doesn't";

# method .path.copy
#?niecza skip 'Unable to resolve method s in class IO'
{
    my $existing-file-mtgt     = "tempfile-copy-mtgt";
    my $non-existent-file-mtgt = "non-existent-copy-mtgt";
    my $zero-length-file-mtgt  = "tempfile-zero-length-copy-mtgt";
    
    ok $existing-file.path.copy( $existing-file-mtgt ), '.path.copy normal file';
    ok $existing-file-mtgt.path.e, 'It exists';
    ok $existing-file-mtgt.path.s, 'It has a size';
    is $existing-file-mtgt.path.s, $existing-file.path.s, 'The size is equal to source file';

    dies_ok { $non-existent-file.path.copy( $non-existent-file-mtgt ) }, '.path.copy missing file';
    nok $non-existent-file-mtgt.path.e, "It doesn't"; 
    ok $zero-length-file.path.copy( $zero-length-file-mtgt ), '.path.copy empty file';
    ok $zero-length-file-mtgt.path.e, 'It exists';
    nok $zero-length-file-mtgt.path.s, 'It has no size';
    is $zero-length-file-mtgt.path.s, $zero-length-file.path.s, 'The size is equal to source file';

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
    ok $existing-file-stgt.path.e, 'It exists';
    ok $existing-file-stgt.path.s, 'It has a size';
    is $existing-file-stgt.path.s, $existing-file.path.s, 'The size is equal to source file';

    dies_ok { copy( $non-existent-file, $non-existent-file-stgt ) }, 'copy() missing file';
    nok $non-existent-file-stgt.path.e, "It doesn't";

    ok copy( $zero-length-file, $zero-length-file-stgt ), 'copy() empty file';
    ok $zero-length-file-stgt.path.e, 'It exists';
    nok $zero-length-file-stgt.path.s, 'It has no size';
    is $zero-length-file-stgt.path.s, $zero-length-file.path.s, 'The size is equal to source file';

    ok unlink($existing-file-stgt), 'file has been removed';
    ok unlink($zero-length-file-stgt), 'file has been removed';
}

# clean up
ok unlink($existing-file), 'file has been removed';
ok unlink($zero-length-file), 'file has been removed';

# vim: ft=perl6
