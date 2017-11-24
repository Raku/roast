use v6;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;

plan 30;

my $existing-file1 = "tempfile-move1";
my $existing-file2 = "tempfile-move2";
my $non-existent-file = "non-existent-move";

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

# method .IO.move
{
    my $dest1a = "tempfile-move-dest1a";
    my $dest1b = "tempfile-move-dest1b";
    
    my $existing-size1 = $existing-file1.IO.s;
    ok $existing-file1.IO.move( $dest1a ), '.IO.move normal file';
    nok $existing-file1.IO.e, 'source file no longer exists';
    ok $dest1a.IO.e, 'dest file exists';
    is $dest1a.IO.s, $existing-size1, 'dest file has same size as source file';
    
    throws-like { $non-existent-file.IO.move( $dest1b ) }, X::IO::Move, '.IO.move non-existent file';
    nok $dest1b.IO.e, "dest file doesn't exist";

    throws-like { $dest1b.IO.move( $dest1a, :createonly ) },
      X::IO::Move, '.IO.move createonly fail';
    nok $dest1b.IO.e, "dest file doesn't exist";

    ok $dest1a.IO.move( $dest1b, :createonly ), '.IO.move createonly';
    ok $dest1b.IO.e, "dest file does exist";

    ok unlink($dest1a), 'clean-up 1a';
    ok unlink($dest1b), 'clean-up 1b';
}

# sub move()
{
    my $dest2a = "tempfile-move-dest2a";
    my $dest2b = "tempfile-move-dest2b";
    
    my $existing-size3 = $existing-file2.IO.s;
    ok move( $existing-file2, $dest2a ), 'move() normal file';
    nok $existing-file2.IO.e, 'source file no longer exists';
    ok $dest2a.IO.e, 'dest file exists';
    is $dest2a.IO.s, $existing-size3, 'dest file has same size as source file';

    throws-like { move( $non-existent-file, $dest2b ) }, X::IO::Move; 'move() missing file';
    nok $dest2b.IO.e, "It doesn't";

    throws-like { move( $dest2b, $dest2a, :createonly ) },
      X::IO::Move, 'move createonly fail';
    nok $dest2b.IO.e, "dest file doesn't exist";

    ok move( $dest2a, $dest2b, :createonly ), 'move() createonly';
    ok $dest2b.IO.e, "dest file does exist";

    ok unlink($dest2a), 'clean-up 2a';
    ok unlink($dest2b), 'clean-up 2b';
}

# clean up
ok unlink($existing-file1), 'clean-up 3';
ok unlink($existing-file2), 'clean-up 4';

# RT#131242
subtest 'moving when target and source are same file' => {
    plan 2;
    my $file = make-temp-file :content<foo>;
    fails-like { $file.move: $file }, X::IO::Move, 'moving fails';
    is-deeply $file.slurp, 'foo', 'file contents are untouched';
}

# vim: ft=perl6
