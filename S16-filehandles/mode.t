use v6;
use Test;

# L<S32::IO/IO::FSNode::Unix/mode>

=begin pod

mode - retrieve the rights of a file

Proposed behaviour
MODE = "path/to/file".IO.mode

MODE is an IntStr, where the Int portion can be used in the chmod method and
the Str portion is four octal digits.

=end pod

plan 15;

if $*DISTRO.is-win {
    skip-rest "file tests not fully available on win32";
    exit;
};


{
    my $file = create_temporary_file;
    my @result = chmod 0o700, $file;
    is +@result, 1, "One file successfully changed";
    is @result[0], $file, "name of the file returned";

    ok $file.IO.mode eq '0700', "successfully set to 700 and read back as such";
    @result = chmod 0o600, $file;
    is +@result, 1, "One file successfully changed";
    is @result[0], $file, "name of the file returned";
    ok $file.IO.mode eq '0600', "successfully changed to 600 and read back as such";
    remove_file($file);
}


{
    my $file1 = create_temporary_file;
    my @result = chmod 0o777, $file1;
    is +@result, 1, "One file successfully changed";
    is @result[0], $file1, "name of the file returned";

    my $file2 = create_temporary_file;
    ok $file2.IO.mode ne '0777', "permission not 777 when created";
    @result = chmod $file1.IO.mode, $file2;
    is +@result, 1, "One file successfully changed";
    is @result[0], $file2, "name of the file returned";
    ok $file2.IO.mode eq '0777', "successfully changed '$file2' to have the same
	  permissions as '$file1' by chmodding '$file2' with the output of '$file1'.IO.mode";
    remove_file($file1);
    remove_file($file2);
}

sub create_temporary_file {
    my $time = now.narrow;
    my $file = "temp_$time";
    my $fh = open $file, :w orelse die "Could not create $file";   #OK not used
    diag "Using file $file";
    return $file;
}
sub remove_file ($file) {
    unlink $file;
    ok($file.IO ~~ :!e, "Test file was successfully removed");
}


# vim: ft=perl6
