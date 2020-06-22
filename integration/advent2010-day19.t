# http://perl6advent.wordpress.com/2010/12/19/day-19-false-truth/
use v6;
use Test;
plan 6;

{
    my $value = 42 but role { method Bool  { False } };
    is $value, 42, 'but role {...}';
    is ?$value, False, 'but role {...}';
}

{
    my $value = 42 but False;
    is $value, 42, '42 but False';
    is ?$value, False, '42 but False';
}

# https://github.com/Raku/old-issue-tracker/issues/3390
{
    my $value = True but False;
    is ~$value, 'False', 'True but False';
    is ?$value, False, 'True but False';
}

# vim: expandtab shiftwidth=4
