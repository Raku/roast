use v6-alpha;
use Test;
plan 5;

# L<S16/"Filehandles, files, and directories"/"open">

=begin pod

Some edge and error cases for open()

=end pod


if $*OS eq "browser" {
  skip_rest "Programs running in browsers don't have access to regular IO.";
  exit;
}

# deal with non-existent files
{
    skip(1, "open('nonexisting') => undef is waiting on 'use fatal'");

    if 0 {
        ok(!defined(open("file_which_does_not_exist")), 'open() on non-existent file returns undef');
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

skip_rest("needs speccing"); exit;

my $scalar;

# XXX: gaal: dunno how this should be, but this isn't it.
#?pugs 2 todo ''
ok(try { open $*OUT,">",\$scalar },'Direct STDOUT to a scalar');
ok(try { open $*ERR,">",\$scalar },'Direct STDERR to a scalar');
