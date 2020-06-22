use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S32::IO/IO::FSNode::Unix/mode>

=begin pod

mode - retrieve the rights of a file

Proposed behaviour
MODE = "path/to/file".IO.mode

MODE is an IntStr, where the Int portion can be used in the chmod method and
the Str portion is four octal digits.

=end pod

plan 12;

{
    my $file = make-temp-file :content('');
    my @result = chmod 0o700, $file;
    is +@result, 1, "One file successfully changed";
    is-deeply @result[0], $file, "name of the file returned";

    is $file.IO.mode, '0700', "successfully set to 700 and read back as such";
    @result = chmod 0o600, $file;
    is +@result, 1, "One file successfully changed";
    is-deeply @result[0], $file, "name of the file returned";
    is $file.IO.mode, '0600',
        "successfully changed to 600 and read back as such";
}


{
    my $file1 = make-temp-file :content('');
    my @result = chmod 0o777, $file1;
    is +@result, 1, "One file successfully changed";
    is-deeply @result[0], $file1, "name of the file returned";

    my $file2 = make-temp-file :content('');
    isnt $file2.IO.mode, '0777', "permission is not 777 when created";
    @result = chmod $file1.IO.mode, $file2;
    is +@result, 1, "One file successfully changed";
    is-deeply @result[0], $file2, "name of the file returned";
    is $file2.IO.mode, '0777', 'changed mode of one file using mode of another';
}

# vim: expandtab shiftwidth=4
