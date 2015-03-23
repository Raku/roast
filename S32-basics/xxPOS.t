use v6;

use Test;

plan 60;

my     @a  = 42, 666;
my Int @ai = 42, 666;

for $@a, Any, $@ai, Int -> \a, \T {
    my $name = a.^name;

    is a.elems,             2, "$name.elems (original)";
    is a.AT-POS(0),        42, "$name.AT-POS";
    is (a.AT-POS(0) = 65), 65, "$name.AT-POS =";
    is a.AT-POS(0),        65, "$name.AT-POS (changed)";

    ok a.EXISTS-POS(0),  "$name.EXISTS-POS (existing)";
    ok !a.EXISTS-POS(2), "!$name.EXISTS-POS (non-existing)";

    is a.ASSIGN-POS(0,33), 33, "$name.ASSIGN-POS (existing)";
    is a.AT-POS(0),        33, "$name.AT-POS (existing ASSIGN-POS)";
    is a.ASSIGN-POS(2,65), 65, "$name.ASSIGN-POS (non-existing)";
    is a.AT-POS(2),        65, "$name.AT-POS (non-existing ASSIGN-POS)";
    is a.elems,             3, "$name.elens (one added)";

    my $a = 45;
    my $d = 67;
    is a.BIND-POS(0,$a), 45, "$name.BIND-POS (existing)";
    is a.AT-POS(0),      45, "$name.AT-POS (existing BIND-POS)";
    $a = 90;
    is a.AT-POS(0),      90, "$name.AT-POS (changed existing BIND-POS)";

    is a.BIND-POS(3,$d), 67, "$name.BIND-POS (non-existing)";
    is a.AT-POS(3),      67, "$name.AT-POS (non-existing BIND-POS)";
    $d = 56;
    is a.AT-POS(3),      56, "$name.AT-POS (changed non-existing BIND-POS)";

    is a.DELETE-POS(0),  90, "$name.DELETE-POS (existing)";
    ok !a.EXISTS-POS(0),     "!$name.EXISTS-POS (existing DELETE-POS)";
    is a.DELETE-POS(4),   T, "$name.DELETE-POS (non-existing)";
    ok !a.EXISTS-POS(4),     "!$name.EXISTS-POS (non-existing DELETE-POS)";
}

{
    my $a;
    ok !$a.EXISTS-POS(0),       "\$a.EXISTS-POS (undefined)";
    is $a.AT-POS(0),       Any, "\$a.AT-POS (undefined)";
    is ($a.AT-POS(0) = 42), 42, "\$a.AT-POS = (undefined)";
    is $a.AT-POS(0),        42, "\$a.AT-POS (defined)";
    ok $a.EXISTS-POS(0),        "\$a.EXISTS-POS (defined)";
    is $a.DELETE-POS(0),    42, "\$a.DELETE-POS (defined)";
    ok !$a.EXISTS-POS(0),       "\$a.EXISTS-POS (after delete)";
}

{
    my $a;
    is ($a.ASSIGN-POS(0,42)), 42, "\$a.ASSIGN-POS (undefined)";
    is $a.AT-POS(0),          42, "\$a.AT-POS (defined)";
    is $a.DELETE-POS(0),      42, "\$a.DELETE-POS (defined)";
    ok !$a.EXISTS-POS(0),         "\$a.EXISTS-POS (after delete)";
}

#?rakudo skip "No such method 'BIND-POS' for invocant of type 'Any'"
{
    my $a;
    my $b = 42;
    is ($a.BIND-POS(0,$b)), 42, "\$a.BIND-POS (undefined)";
    is $a.AT-POS(0),        42, "\$a.AT-POS (defined)";
    $b = 65;
    is $a.AT-POS(0),        65, "\$a.AT-POS (defined)";
    is $a.DELETE-POS(0),    65, "\$a.DELETE-POS (defined)";
    ok !$a.EXISTS-POS(0),       "\$a.EXISTS-POS (after delete)";
}

{
    my $a;
    is $a.DELETE-POS(0), Nil, "\$a.DELETE-POS (undefined)";  # not sure ok
    ok !$a.EXISTS-POS(0),     "\$a.EXISTS-POS (after delete)";
}
