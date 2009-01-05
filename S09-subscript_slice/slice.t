use v6;
use Test;

# L<S09/Subscript and slice notation>
# (Could use an additional smart link)

=begin pod

Testing array slices.

=end pod

plan 25;

{   my @array = (3,7,9,11);

    is(@array[0,1,2], (3,7,9),   "basic slice");
    is(@array[(0,1,2)], (3,7,9), "basic slice, explicit list");

    is(@array[0,0,2,1,1,2], "3 3 9 7 7 9", "basic slice, duplicate indices");

    my @slice = (1,2);

    is(@array[@slice], "7 9",      "slice from array, part 1");
    is(@array[@slice], (7,9),      "slice from array, part 2");
    is(@array[@slice[1]], (9),     "slice from array slice, part 1");
    is(@array[@slice[0,1]], (7,9), "slice from array slice, part 2");
    is(@array[0..1], (3,7),	   "range from array");
    is(@array[0,1..2], (3,7,9),	   "slice plus range from array");
    is(@array[0..1,2,3], (3,7,9,11), "range plus slice from array");    
}

# Behaviour assumed to be the same as Perl 5
{   my @array  = <a b c d>;
    my @slice := @array[1,2];
    is ~(@slice = <A B C D>), "A B",
        "assigning a slice too many items yields a correct return value";
}

# Binding on array slices
#?rakudo skip 'Error Msg: "rtype not set" when binding to an array slices'
{   my @array = <a b c d>;

    try { @array[1, 2] := <B C> };
    #?pugs todo 'feature'
    is ~@array, "a B C d", "binding array slices works (1)";
}

#?rakudo skip 'Error Msg: "rtype not set" when binding to an array slices'
{   my @array = <a b c d>;

    try { @array[1, 2] := <B> };
    #?pugs 2 todo 'feature'
    is ~@array, "a B d",    "binding array slices works (2-1)";
    ok !defined(@array[2]), "binding array slices works (2-2)";
}


#?rakudo skip 'Error Msg: "rtype not set" when binding to an array slices'
{   my @array = <a b c d>;
    my $foo   = "B";
    my $bar   = "C";

    @array[1, 2] := ($foo, $bar);
    #?pugs todo 'feature'
    is ~@array, "a B C d", "binding array slices works (3-1)";

    $foo = "BB";
    $bar = "CC";
    #?pugs todo 'feature'
    is ~@array, "a BB CC d", "binding array slices works (3-2)";

    try {
        @array[1] = "BBB";
        @array[2] = "CCC";
    };
    is ~@array, "a BBB CCC d", "binding array slices works (3-3)";
    #?pugs 2 todo 'feature'
    is $foo,    "BBB",         "binding array slices works (3-4)";
    is $bar,    "CCC",         "binding array slices works (3-5)";
}

# Slices on array literals
{   is ~(<a b c d>[1,2]),   "b c", "slice on array literal";
    is ~([<a b c d>][1,2]), "b c", "slice on arrayref literal";
}

# Calculated slices
{   my @array = (3,7,9);
    my %slice = (0=>3, 1=>7, 2=>9);
    is((3,7,9), [@array[%slice.keys].sort],    "values from hash keys, part 1");
    is((3,7,9), [@array[%slice.keys.sort]],    "values from hash keys, part 2");
    is((3,7,9), [@array[(0,1,1)>>+<<(0,0,1)]], "calculated slice: hyperop");
}


# slices with empty ranges
{
    my @array = 1, 2, 3;
    my @other = @array[2..1];
    is +@other, 0, '@array[2..1] is an empty slice';
}
