use v6;
use Test;
plan 3;

# L<S32::IO/IO::File/open>
# old: L<S16/"Filehandles, files, and directories"/"open">

=begin pod

Some edge and error cases for open()

=end pod


if $*OS eq "browser" {
  skip_rest "Programs running in browsers don't have access to regular IO.";
  exit;
}

# deal with non-existent files
{
    skip(1, "open('nonexisting') => undefined is waiting on 'use fatal'");

    if 0 {
        ok(!defined(open("file_which_does_not_exist")), 'open() on non-existent file returns undefined');
    }

    open("create_this_file", :w);
    ok('create_this_file' ~~ :e, 'writing to a non-existent file creates it');
    unlink('create_this_file');

    open("create_this_file2", :w);
    ok('create_this_file2' ~~ :e, 'appending to a non-existent file creates it');
    unlink('create_this_file2');
}


=begin pod

I/O Redirection to scalar tests

=end pod

# vim: ft=perl6
