use v6;
use Test;
plan 5;

# L<S32::IO/IO::File/open>
# old: L<S16/"Filehandles, files, and directories"/"open">

=begin pod

Some edge and error cases for open()

=end pod

# deal with non-existent files
{
    skip("open('nonexisting') => undefined is waiting on 'use fatal'", 1);

    if 0 {
        ok(!defined(open("file_which_does_not_exist")), 'open() on non-existent file returns undefined');
    }

    open("create_this_file", :w);
    ok('create_this_file'.IO ~~ :e, 'writing to a non-existent file creates it');
    unlink('create_this_file');

    open("create_this_file2", :w);
    ok('create_this_file2'.IO ~~ :e, 'appending to a non-existent file creates it');
    unlink('create_this_file2');
}

# opening directories
{
    lives_ok { open('t') }, 'opening a directory works';
    dies_ok { open('t', :w) }, 'opening a directory as writable fails';
}


=begin pod

I/O Redirection to scalar tests

=end pod

# vim: ft=perl6
