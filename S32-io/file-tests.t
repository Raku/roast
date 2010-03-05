use v6;
use Test;

# Maybe someone can put in a better smartlink? --lue
# L<S32::IO/"A file test, where X is one of the letters listed below.">

plan 8;

my $existing-file = "tempfile-file-tests";
my $non-existent-file = "non-existent-file-tests";
my $zero-length-file = "tempfile-zero-length-file-tests";

{ # write the file first
    my $fh = open($existing-file, :w);
    $fh.print: "0123456789A";
    $fh.close();
}

{ # write the file first
    my $fh = open($zero-length-file, :w);
    $fh.close();
}

#Str methods
##existence
is $existing-file.e, 1, 'It exists';
is $non-existent-file.e, 0, "It doesn't";

##is empty
is $zero-length-file.z, 1, 'Is empty';
is $existing-file.z, 0, 'Is not';

##file size
is $zero-length-file.s, 0, 'No size';
is $existing-file.s, 11, 'size of file'; #if this test fails, check the size of pi.txt first, and change if necessary :)


# clean up
is unlink($existing-file), 1, 'file has been removed';
is unlink($zero-length-file), 1, 'file has been removed';

# vim: ft=perl6
