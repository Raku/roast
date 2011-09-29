use v6;

use Test;

plan 64;

# L<S02/Names and Variables/appropriate adverb to the subscript>

# Adverbs on array subscripts
# :p
{
    my @array = <A B>;

    isa_ok @array[0]:p, Pair,
        ":p on an array returned a Pair";
    is ~(@array[0]:p), "0\tA",
        ":p on an array returned the correct pair";

    lives_ok { (@array[0]:p).value = "a" }, 'can assign to (@array[0]:p).value';
    is @array[0], "a",
        ":p on an array returns lvalues (like normal subscripts do as well)";

    #?niecza skip 'Cannot use value like Pair as a number'
    is +(@array[0,1]:p), 2,
        ":p on an array returned a two-elem array";
    #?niecza skip 'TODO'
    is ~(@array[0,1]:p), "0\ta 1\tB",
        ":p on an array returned a two-elem array consisting of the correct pairs";

    #?niecza skip 'Cannot use value like Pair as a number'
    is +(@array[42,23]:p),  0, ":p on an array weeded out non-existing entries (1)";
    #?niecza skip 'TODO'
    is ~(@array[42,23]:p), "", ":p on an array weeded out non-existing entries (2)";
}

# :kv
{
    my @array = <A B>;

    is +(@array[0]:kv), 2,
        ":kv on an array returned a two-elem array";
    is ~(@array[0]:kv), "0 A",
        ":kv on an array returned the correct two-elem array";

    lives_ok {(@array[0]:kv)[1] = "a"}, 'can assign to :kv subscripts';
    is @array[0], "a",
        ":kv on an array returns lvalues (like normal subscripts do as well)";

    #?niecza skip 'TODO'
    is +(@array[0,1]:kv), 4,
        ":kv on an array returned a four-elem array";
    #?niecza skip 'TODO'
    is ~(@array[0,1]:kv), "0 a 1 B",
        ":kv on an array returned the correct four-elem array";

    #?niecza skip 'TODO'
    is +(@array[42,23]:kv),  0, ":kv on an array weeded out non-existing entries (1)";
    #?niecza skip 'TODO'
    is ~(@array[42,23]:kv), "", ":kv on an array weeded out non-existing entries (2)";
}

# :k
{
    my @array = <A B>;

    #?niecza skip 'TODO'
    is +(@array[0]:k), 1,
        ":k on an array returned an one-elem array";
    is ~(@array[0]:k), "0",
        ":k on an array returned the correct one-elem array";

    is +(@array[0,1]:k), 2,
        ":k on an array returned a tow-elem array";
    is ~(@array[0,1]:k), "0 1",
        ":k on an array returned the correct two-elem array";

    #?niecza skip 'TODO'
    is +(@array[42,23]:k),  0, ":k on an array weeded out non-existing entries (1)";
    #?niecza skip 'TODO'
    is ~(@array[42,23]:k), "", ":k on an array weeded out non-existing entries (2)";
}

# :v
{
    my @array = <A B>;

    #?niecza skip 'Excess arguments to KERNEL Array.postcircumfix:<[ ]>, unused named v'
    is +(@array[0]:v), 1,
        ":v on an array returned an one-elem array";
    #?niecza skip 'Excess arguments to KERNEL Array.postcircumfix:<[ ]>, unused named v'
    is ~(@array[0]:v), "A",
        ":v on an array returned the correct one-elem array";

    #?niecza skip 'TODO'
    lives_ok {@array[0]:v = "a"}, 'can assign to @array[0]:v';
    #?niecza skip 'TODO'
    is @array[0], "a",
        ":v on an array returns lvalues (like normal subscripts do as well)";

    #?niecza skip 'Excess arguments to KERNEL Array.postcircumfix:<[ ]>, unused named v'
    is +(@array[0,1]:v), 2,
        ":v on an array returned a tow-elem array";
    #?niecza skip 'Excess arguments to KERNEL Array.postcircumfix:<[ ]>, unused named v'
    is ~(@array[0,1]:v), "a B",
        ":v on an array returned the correct two-elem array";

    #?niecza skip 'Excess arguments to KERNEL Array.postcircumfix:<[ ]>, unused named v'
    is +(@array[42,23]:v),  0, ":v on an array weeded out non-existing entries (1)";
    #?niecza skip 'Excess arguments to KERNEL Array.postcircumfix:<[ ]>, unused named v'
    is ~(@array[42,23]:v), "", ":v on an array weeded out non-existing entries (2)";
}

# Adverbs on hash subscripts
# :p
{
    my %hash = (0 => "A", 1 => "B");

    isa_ok %hash<0>:p, Pair,
        ":p on a hash returned a Pair";
    is ~(%hash<0>:p), "0\tA",
        ":p on a hash returned the correct pair";

    lives_ok { (%hash<0>:p).value = "a"}, 'can assign to %hash<0>:p.value';
    is %hash<0>, "a",
        ":p on a hash returns lvalues (like normal subscripts do as well)";

    #?niecza skip 'Cannot use value like Pair as a number'
    is +(%hash<0 1>:p), 2,
        ":p on a hash returned a two-elem array";
    #?niecza skip 'TODO'
    is ~(%hash<0 1>:p), "0\ta 1\tB",
        ":p on a hash returned a two-elem array consisting of the correct pairs";

    #?niecza skip 'Cannot use value like Pair as a number'
    is +(%hash<42 23>:p),  0, ":p on a hash weeded out non-existing entries (1)";
    #?niecza skip 'TODO'
    is ~(%hash<42 23>:p), "", ":p on a hash weeded out non-existing entries (2)";
}

# :kv
{
    my %hash = (0 => "A", 1 => "B");

    is +(%hash<0>:kv), 2,
        ":kv on a hash returned a two-elem array";
    is ~(%hash<0>:kv), "0 A",
        ":kv on a hash returned the correct two-elem array";

    lives_ok {(%hash<0>:kv)[1] = "a"}, 'can assign to %hash<0>:kv.[1]';
    is %hash<0>, "a",
        ":kv on a hash returns lvalues (like normal subscripts do as well)";

    #?niecza skip 'TODO'
    is +(%hash<0 1>:kv), 4,
        ":kv on a hash returned a four-elem array";
    #?niecza skip 'TODO'
    is ~(%hash<0 1>:kv), "0 a 1 B",
        ":kv on a hash returned the correct four-elem array";

    #?niecza skip 'TODO'
    is +(%hash<42 23>:kv),  0, ":kv on a hash weeded out non-existing entries (1)";
    #?niecza skip 'TODO'
    is ~(%hash<42 23>:kv), "", ":kv on a hash weeded out non-existing entries (2)";
}

# :k
{
    my %hash = (0 => "A", 1 => "B");

    #?niecza skip 'TODO'   
    is +(%hash<0>:k), 1,
        ":k on a hash returned an one-elem array";
    is ~(%hash<0>:k), "0",
        ":k on a hash returned the correct one-elem array";

    is +(%hash<0 1>:k), 2,
        ":k on a hash returned a tow-elem array";
    is ~(%hash<0 1>:k), "0 1",
        ":k on a hash returned the correct two-elem array";

    #?niecza skip 'TODO'
    is +(%hash<42 23>:k),  0, ":k on a hash weeded out non-existing entries (1)";
    #?niecza skip 'TODO'
    is ~(%hash<42 23>:k), "", ":k on a hash weeded out non-existing entries (2)";
}

# :v
{
    my %hash = (0 => "A", 1 => "B");

    #?niecza skip 'Excess arguments to KERNEL Hash.postcircumfix:<{ }>, unused named v'
    is +(%hash<0>:v), 1,
        ":v on a hash returned an one-elem array";
    #?niecza skip 'Excess arguments to KERNEL Hash.postcircumfix:<{ }>, unused named v'
    is ~(%hash<0>:v), "A",
        ":v on a hash returned the correct one-elem array";

    #?niecza skip 'TODO'
    lives_ok {%hash<0>:v = "a"}, 'can assign to %hash<0>:v';
    #?niecza skip 'TODO'
    is %hash<0>, "a",
        ":v on a hash returns lvalues (like normal subscripts do as well)";

    #?niecza skip 'Excess arguments to KERNEL Hash.postcircumfix:<{ }>, unused named v'
    is +(%hash<0 1>:v), 2,
        ":v on a hash returned a tow-elem array";
    #?niecza skip 'Excess arguments to KERNEL Hash.postcircumfix:<{ }>, unused named v'
    is ~(%hash<0 1>:v), "a B",
        ":v on a hash returned the correct two-elem array";

    #?niecza skip 'Excess arguments to KERNEL Hash.postcircumfix:<{ }>, unused named v'
    is +(%hash<42 23>:v),  0, ":v on a hash weeded out non-existing entries (1)";
    #?niecza skip 'Excess arguments to KERNEL Hash.postcircumfix:<{ }>, unused named v'
    is ~(%hash<42 23>:v), "", ":v on a hash weeded out non-existing entries (2)";
}

# The adverbial forms weed out non-existing entries, but undefined (but
# existing) entries should be unaffected by this rule.
{
    my @array = (42, Mu, 23);

    #?niecza skip 'TODO'
    is +(@array[0,1,2]:kv), 6,
        "undefined but existing entries should not be weeded out (1)";
    #?niecza skip 'TODO'
    is ~(@array[0,1,2]:kv), "0 42 1  2 23",
        "undefined but existing entries should not be weeded out (2)";
}

{
    my %hash = (0 => 42, 1 => Mu, 2 => 23);

    #?niecza skip 'TODO'
    is +(%hash<0 1 2>:kv), 6,
        "undefined but existing entries should not be weeded out (3)";
    #?niecza skip 'TODO'
    is ~(%hash<0 1 2>:kv), "0 42 1  2 23",
        "undefined but existing entries should not be weeded out (4)";
}

# vim: ft=perl6
