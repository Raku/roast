use v6;
use Test;
plan 13;

# L<S02/Closures/"A bare closure also interpolates in double-quotish context.">

{
    # The code of the closure takes a reference to the number 1, discards it
    # and finally returns 42.
    is "{\01;42}", "42", '{\\01 parses correctly (1)';    #OK not indicate octal
    is "{;\01;42}", "42", '{\\01 parses correctly (2)';    #OK not indicate octal
    is "{;;;;;;\01;42}", "42", '{\\01 parses correctly (3)';    #OK not indicate octal
}

{
    is "{\1;42}", "42", '{\\1 parses correctly (1)';
    is "{;\1;42}", "42", '{\\1 parses correctly (2)';
    is "{;;;;;;\1;42}", "42", '{\\1 parses correctly (3)';
}


{
    # interpolating into double quotes results in a Str
    my $a = 3;
    ok "$a" ~~ Str, '"$a" results in a Str';
    ok "{3}" ~~ Str, '"{3}" results in a Str';

    # RT #76234
    is "{}", '', 'Interpolating an empty block is cool';
}

{
    my $rt65538_in = qq[line { (1,2,3).min }
line 2
line { (1,2,3).max } etc
line 4
];
    my $rt65538_out = qq[line 1
line 2
line 3 etc
line 4
];
    is $rt65538_in, $rt65538_out, 'interpolation does not trim newlines';
}

{
    #?pugs todo
    is 'something'.new, '', '"string literal".new just creates an empty string';
    #?pugs skip 'Cannot cast from VObject'
    is +''.new, 0, '... and that strinig works normally';
}

# RT #79568
{
    my $w = 'work';
    is "this should $w\</a>", 'this should work</a>', 'backslash after scalar';
}

# vim: ft=perl6
