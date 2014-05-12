use v6;
use Test;

# L<S32::IO/IO::FSNode::Unix/chmod>
# old: L<S16/"Filehandles, files, and directories"/"chmod">

=begin pod

chmod - the unix chmod command, changing the rights on a file

Proposed behaviour
LIST = chmod MODE, LIST
Given a list of files and directories change the rights on them.
MODE should be an octet representing or a string like similar to what can be used in
     the same UNIX program:
     one or more of the letters ugoa, one of the symbols +-= and one or more of the letters rwxXstugo.
     
return list should be the list of files that were successfully changed
in scalar context it should be the number of files successfully changed

While some of the modes are UNIX specific, it would be nice to find similar
  modes in other operating system and do the right thing there too.


We really need the stat() function in order to test this.

=end pod

plan 19;

if $*DISTRO.is-win {
    skip_rest "file tests not fully available on win32";
    exit;
};


{
    my $file = create_temporary_file;
    my @result = chmod 0o000, $file;
    is +@result, 1, "One file successfully changed";
    #?pugs todo ''
    is @result[0], $file, "name of the file returned";
    if ($*EUID) {
        ok $file.IO ~~ :!r, "not readable after 0";
        ok $file.IO ~~ :!w, "not writeable after 0";
        ok $file.IO ~~ :!x, "not executable after 0";
    }
    else {
        skip ":r :w :x can accidentally work with root permission", 3;
    }
    remove_file($file);
}


{
    my $file = create_temporary_file;
    my @result = chmod 0o700, $file;
    is +@result, 1, "One file successfully changed";
    #?pugs todo ''
    is @result[0], $file, "name of the file returned";

    ok $file.IO ~~ :r, "readable after 700";
    ok $file.IO ~~ :w, "writabel after 700";
    ok $file.IO ~~ :x, "executable after 700";
    remove_file($file);
}


{
    my $file = create_temporary_file;
    my @result = chmod 0o777, $file;
    is +@result, 1, "One file successfully changed";
    #?pugs todo ''
    is @result[0], $file, "name of the file returned";

    ok $file.IO ~~ :r, "readable after 777";
    ok $file.IO ~~ :w, "writable after 777";
    ok $file.IO ~~ :x, "executable after 777";
    remove_file($file);
}

sub create_temporary_file {
    my $time = time;
    my $file = "temp_$time";
    my $fh = open $file, :w orelse die "Could not create $file";   #OK not used
    diag "Using file $file";
    return $file;
}
sub remove_file ($file) {
    unlink $file;
    ok($file.IO ~~ :!e, "Test file was successfully removed");
}

ok(try { "nonesuch".IO ~~ :!e }, "~~:!e syntax works");


# vim: ft=perl6
