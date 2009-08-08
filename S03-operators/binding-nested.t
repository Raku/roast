use v6;

use Test;

# L<S03/Item assignment precedence>

# Tests for binding multidimensional structures.

plan 43;

# Nested refs as RHS in a binding operation
{
    my $struct = [
        "ignored",
        {
            key => {
                ignored => 23,
                subkey  => [
                    "ignored",
                    42,
                ],
            },
            ignored => 19,
        },
    ];

    is $struct[1]<key><subkey>[1], 42, "basic sanity (1)";

    my $abbrev := $struct[1]<key><subkey>[1];
    is $abbrev, 42,
        "using a multidimensional structure as RHS in a binding op works (1)";

    $struct[1]<key><subkey>[1] = 43;
    is $abbrev, 43,
        "using a multidimensional structure as RHS in a binding op works (2)";

    $abbrev = 44;
    is $struct[1]<key><subkey>[1], 44,
        "using a multidimensional structure as RHS in a binding op works (3)";
}

# Nested refs as LHS in a binding operation
{
    my $struct = [
        "ignored",
        {
            key => {
                ignored => 23,
                subkey  => [
                    "ignored",
                    42,
                ],
            },
            ignored => 19,
        },
    ];

    is $struct[1]<key><subkey>[1], 42, "basic sanity (2)";

    my $abbrev = 30;
    try { $struct[1]<key><subkey>[1] := $abbrev };
    is $abbrev, 30,
        "using a multidimensional structure as LHS in a binding op works (1)";

    $struct[1]<key><subkey>[1] = 31;
    is $abbrev, 31,
        "using a multidimensional structure as LHS in a binding op works (2)";

    $abbrev = 32;
    is $struct[1]<key><subkey>[1], 32,
        "using a multidimensional structure as LHS in a binding op works (3)";
}

# Evil more evil structure: with an embedded "is rw" sub!
# As RHS...
{
    my $innerstruct = {
        ignored => 23,
        subkey  => [
            "ignored",
            42,
        ],
    };

    my sub get_innerstruct () is rw { $innerstruct }

    my $struct = [
        "ignored",
        {
            key     => &get_innerstruct,
            ignored => 19,
        },
    ];

    is $struct[1]<key>()<subkey>[1], 42, "basic sanity (3)";

    my $abbrev := $struct[1]<key>()<subkey>[1];
    is $abbrev, 42,
        "using a multidimensional structure with an embedded sub as RHS works (1)";

    $struct[1]<key>()<subkey>[1] = 43;
    is $abbrev, 43,
        "using a multidimensional structure with an embedded sub as RHS works (2)";

    $abbrev = 44;
    is $struct[1]<key>()<subkey>[1], 44,
        "using a multidimensional structure with an embedded sub as RHS works (3)";
}

# ...and as LHS
{
    my $innerstruct = {
        ignored => 23,
        subkey  => [
            "ignored",
            42,
        ],
    };

    my sub get_innerstruct () is rw { $innerstruct }

    my $struct = [
        "ignored",
        {
            key     => &get_innerstruct,
            ignored => 19,
        },
    ];

    is $struct[1]<key>()<subkey>[1], 42, "basic sanity (4)";

    my $abbrev = 30;
    try { $struct[1]<key>()<subkey>[1] := $abbrev };
    is $abbrev, 30,
        "using a multidimensional structure with an embedded sub as LHS works (1)";

    $struct[1]<key>()<subkey>[1] = 31;
    is $abbrev, 31,
        "using a multidimensional structure with an embedded sub as LHS works (2)";

    $abbrev = 32;
    is $struct[1]<key>()<subkey>[1], 32,
        "using a multidimensional structure with an embedded sub as LHS works (3)";
}

# Binding should cope with a subtree being redefined.
# As RHS...
{
    my $struct = [
        "ignored",
        {
            key => {
                ignored => 23,
                subkey  => [
                    "ignored",
                    42,
                ],
            },
            ignored => 19,
        },
    ];

    is $struct[1]<key><subkey>[1], 42, "basic sanity (5)";

    my $abbrev := $struct[1]<key><subkey>[1];
    is $abbrev, 42,
        "RHS binding should cope with a subtree being redefined (1)";

    $struct[1]<key><subkey>[1] = 43;
    is $abbrev, 43,
        "RHS binding should cope with a subtree being redefined (2)";

    $struct[1] = "foo";
    is $struct[1], "foo",
        "RHS binding should cope with a subtree being redefined (3)";
    is $abbrev, 43,
        "RHS binding should cope with a subtree being redefined (4)";

    $abbrev = 44;
    is $abbrev, 44,
        "RHS binding should cope with a subtree being redefined (5)";
    is $struct[1], "foo",
        "RHS binding should cope with a subtree being redefined (6)";
}

# ...and as LHS
{
    my $struct = [
        "ignored",
        {
            key => {
                ignored => 23,
                subkey  => [
                    "ignored",
                    42,
                ],
            },
            ignored => 19,
        },
    ];

    is $struct[1]<key><subkey>[1], 42, "basic sanity (6)";

    my $abbrev = 42;
    try { $struct[1]<key><subkey>[1] := $abbrev };
    is $abbrev, 42,
        "LHS binding should cope with a subtree being redefined (1)";

    $struct[1]<key><subkey>[1] = 43;
    is $abbrev, 43,
        "LHS binding should cope with a subtree being redefined (2)";

    $struct[1] = "foo";
    is $struct[1], "foo",
        "LHS binding should cope with a subtree being redefined (3)";
    is $abbrev, 43,
        "LHS binding should cope with a subtree being redefined (4)";

    $abbrev = 44;
    is $abbrev, 44,
        "LHS binding should cope with a subtree being redefined (5)";
    is $struct[1], "foo",
        "LHS binding should cope with a subtree being redefined (6)";
}

# Tests for binding an element of a structure to an element of another
# structure.
{
    my $foo = [
        "ignored",
        {
            key => {
                ignored => 1,
                subkey  => [
                    "ignored",
                    2,
                ],
            },
            ignored => 3,
        },
    ];

    my $bar = [
        "ignored",
        {
            key => {
                ignored => 4,
                subkey  => [
                    "ignored",
                    5,
                ],
            },
            ignored => 6,
        },
    ];

    try { $bar[1]<key><subkey> := $foo[1]<key> };
    is (try { $bar[1]<key><subkey><subkey>[1] }), 2,
        "binding an element of a structure to an element of another structure works (1)";

    try { $foo[1]<key><subkey>[1] = 7 };
    is (try { $bar[1]<key><subkey><subkey>[1] }), 7,
        "binding an element of a structure to an element of another structure works (2)";

    try { $bar[1]<key><subkey><subkey>[1] = 8 };
    is (try { $foo[1]<key><subkey>[1] }), 8,
        "binding an element of a structure to an element of another structure works (3)";
}

# Tests for binding an element of a structure to an element of *the same*
# structure, effectively creating an infinite structure.
{
    my $struct = [
        "ignored",
        {
            key => {
                foo    => "bar",
                subkey => [
                    "ignored",
                    100,
                ],
            },
            ignored => 200,
        },
    ];

    try { $struct[1]<key><subkey>[1] := $struct[1]<key> };
    is (try { $struct[1]<key><subkey>[1]<foo> }), "bar",
        "binding an element of a structure to an element of the same structure works (1)";

    try { $struct[1]<key><subkey>[1]<foo> = "new_value" };
    is $struct[1]<key><foo>, "new_value",
        "binding an element of a structure to an element of the same structure works (2)";

    $struct[1]<key><foo> = "very_new_value";
    is (try { $struct[1]<key><subkey>[1]<foo> }), "very_new_value",
        "binding an element of a structure to an element of the same structure works (3)";

    $struct[1]<key><subkey>[1] = 23;
    is $struct[1]<key>, 23,
        "binding an element of a structure to an element of the same structure works (4)";
}

# Test that rebinding to some other value really breaks up the binding.
{
    my $struct = [
        "ignored",
        {
            key => {
                ignored => 23,
                subkey  => [
                    "ignored",
                    42,
                ],
            },
            ignored => 19,
        },
    ];

    is $struct[1]<key><subkey>[1], 42, "basic sanity (7)";

    my $abbrev := $struct[1]<key><subkey>[1];
    is $abbrev, 42,
        "rebinding to some other value destroys the previous binding (1)";

    $struct[1]<key><subkey>[1] = 43;
    is $abbrev, 43,
        "rebinding to some other value destroys the previous binding (2)";

    $abbrev = 44;
    is $struct[1]<key><subkey>[1], 44,
        "rebinding to some other value destroys the previous binding (3)";

    $abbrev := 45;
    is $abbrev, 45,
        "rebinding to some other value destroys the previous binding (4)";
    is $struct[1]<key><subkey>[1], 44,
        "rebinding to some other value destroys the previous binding (5)";
}


# vim: ft=perl6
