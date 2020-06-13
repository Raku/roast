use v6;

use Test;

plan 13;

# The :() form constructs signatures similar to how \() constructs Captures.
# A subroutine's .signature is a Signature object.

#L<S02/Names and Variables/"A signature object">

{
    isa-ok :($a), Signature, ':($a) create a Signature object';
    my ($a) := \(3);
    is-deeply $a, 3, 'can bind to one-element signature';
    throws-like { $a++ }, X::Multi::NoMatch, 'cannot increment an Int';

    my $b = :();
    cmp-ok $b.WHAT, '===', Signature, '.WHAT on :() is Signature';
}

{
    my ($x,$y,$z) := (1,2,3);
    is-deeply [$x, $y, $z], [1, 2, 3], "signature binding works";
}

# Same, but more complex
{
    my ($x,@y,*@rest) := (42,[13,17],5,6,7);
    is-deeply [$x, @y, @rest], [42, [13, 17], [5, 6, 7]],
      "complex signature bindings works (1)";
}

{
    my ($x?) := ();
    ok(!$x.defined, "complex signature bindings works (2)");
}

# &sub.signature should return a Signature object
{
    my $foo = -> $a, $b {}    #OK not used
    my $signature = :($a, $b);

    ok ~$signature, "a signature stringifies";
    is-deeply $signature, $foo.signature,
        "a subroutine's signature can be accessed via .signature (1)";
}

# Same as above, but more complex
{
    my $foo = -> Num $a, $b?, *@rest {}    #OK not used
    my $signature = :(Num $a, $b?, *@rest);

    is-deeply $signature, $foo.signature,
        "a subroutine's signature can be accessed via .signature (2)";
}

{
    my sub foo ($a, $b) {}   #OK not used
    my $signature = :($a);

    cmp-ok $signature, &[!eqv], &foo.signature,
        "a subroutine's signature can be accessed via .signature (3)";
}

{
    my @a = 1,2,3;
    my (@c) = @a;
    my $i = 0;
    $i++ for @c;
    # XXX this test appears to be bogus to me, as there is no signature involved
    is-deeply $i, 3, 'asigning to an array in a signature is sane';
}

# https://github.com/Raku/old-issue-tracker/issues/2354
{
    my @list = 1..4;
    my (:@even, :@odd) := classify { $_ %% 2 ?? 'even' !! 'odd' }, @list;
    is-deeply @even, [2, 4], 'signature binding with a hash works';
}

# vim: expandtab shiftwidth=4
