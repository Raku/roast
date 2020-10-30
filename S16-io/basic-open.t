use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 12;

sub test_lines(@lines) is test-assertion {
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
    my $fh = open($?FILE.IO.parent.child('test-data'));
    my $count = 0;
    while !$fh.eof {
        my $x = $fh.get;
        $count++ if $x.defined;
    }
    is $count, 3, 'Read three lines with while !$hanlde.eof';
}

# test that we can interate over $fh.lines
{
    my $fh =  open($?FILE.IO.parent.child('test-data'));

    ok defined($fh), 'Could open test file';
    my @lines;
    for $fh.lines -> $x {
        push @lines, $x;
    }
    test_lines(@lines);
}

# test that we can get all items in list context:
{
    my $fh =  open($?FILE.IO.parent.child('test-data'));
    ok defined($fh), 'Could open test file (again)';
    my @lines = $fh.lines;
    test_lines(@lines);
}

# https://github.com/Raku/old-issue-tracker/issues/3794
throws-like { open("this-surely-won't-exist", :r) }, Exception,
    message => { m/"this-surely-won't-exist"/ };

# https://github.com/Raku/old-issue-tracker/issues/3796
{
    my $fh = open('basic-open-tests', :w);
    $fh.print('+');
    $fh.close;

    $fh = open('basic-open-tests', :r);
    is $fh.get, '+', 'Reading a line form a one-byte file works';
    $fh.close;
    unlink 'basic-open-tests';
}

# https://github.com/Raku/old-issue-tracker/issues/4740
is-deeply make-temp-file(content => "\n").open.get, "",
    '.get returns last empty line';

# vim: expandtab shiftwidth=4
