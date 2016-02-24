use v6.c;
use Test;

plan 9;

#                      +---- UTF8 non-breaking space here!
#                      |
#                      V
# L<S03/Changes to Perl 5 operators/list assignment operator now parses on the right>


# very simple assignment

{
    my $foo = 'FOO';
    is  $foo, 'FOO', 'Can assign string to scalar 1';
    my $bar = 'BAR';
    is  $foo, 'FOO', 'Can assign string to scalar 2';

    $foo = $bar;
    is $foo, 'BAR', 'Can assign scalar to scalar';

    $foo = 'FOO';
    is $bar, 'BAR', "Assignment didn't create a binding";
}

# test that assignment from arrays to scalars doesn't create a binding:

{
    my @array = 23, 42;
    is @array[0], 23, 'Could assign first element';
    is @array[1], 42, 'Could assign second element';
    my $temp = @array[0];
    is $temp, 23, 'Could retrieve first element to a scalar';
    {
        @array[0] = @array[1];
        is $temp, 23, "Assignment to scalar didn't create a binding"
    }
}

{
    my $a = 42;
    my @list = ($a);
    $a = 24;
    is @list[0], 42, "Assignment to scalar didn't create a binding";
}

# vim: ft=perl6
