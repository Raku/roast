use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 12;

sub test_lines(@lines) {
    #!rakudo todo 'line counts'
    is @lines.elems, 3, 'Three lines read';
    is @lines[0],
       "Please do not remove this file, used by S16-io/basic-open.t",
       'Retrieved first line';
    is @lines[2],
       "This is a test line.",
       'Retrieved last line';
}

{
    my $fh = open('t/spec/S16-io/test-data');
    my $count = 0;
    while !$fh.eof {
        my $x = $fh.get;
        $count++ if $x.defined;
    }
    is $count, 3, 'Read three lines with while !$hanlde.eof';
}

# test that we can interate over $fh.lines
{
    my $fh =  open('t/spec/S16-io/test-data');

    ok defined($fh), 'Could open test file';
    my @lines;
    for $fh.lines -> $x {
        push @lines, $x;
    }
    test_lines(@lines);
}

# test that we can get all items in list context:
{
    my $fh =  open('t/spec/S16-io/test-data');
    ok defined($fh), 'Could open test file (again)';
    my @lines = $fh.lines;
    test_lines(@lines);
}

# RT #124391
throws-like { open("this-surely-won't-exist", :r) }, Exception,
    message => { m/"this-surely-won't-exist"/ };

# RT #124394
{
    my $fh = open('basic-open-tests', :w);
    $fh.print('+');
    $fh.close;

    $fh = open('basic-open-tests', :r);
    is $fh.get, '+', 'Reading a line form a one-byte file works';
    $fh.close;
    unlink 'basic-open-tests';
}

# RT #126598
is-deeply make-temp-file(content => "\n").open.get, "",
    '.get returns last empty line';

# vim: ft=perl6
