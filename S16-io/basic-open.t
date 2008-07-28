use v6;
use Test;

plan 8;

#?DOES 3
sub test_lines(@lines) {
    is @lines.elems, 3, 'Three lines read';
    is @lines[0], 
       'Please do not remove this file, used by S16-io/basic-open.t',
       'Retrieved first line';
    is @lines[2], 
       'This is a test line.',
       'Retrieved last line';
}

# test that we can interate over =$fh
{
    my $fh =  open('t/spec/S16-io/test-data');

    ok defined($fh), 'Could open test file';
    my @lines;
    for =$fh -> $x {
        push @lines, $x;
    }
    test_lines(@lines);
}


# test that we can get all items in list context:
{
    my $fh =  open('t/spec/S16-io/test-data');
    ok defined($fh), 'Could open test file (again)';
    my @lines = =$fh;
    test_lines(@lines);
}

# vim: ft=perl6
