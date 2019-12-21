use v6;

use Test;

plan 38;

# L<S03/List prefix precedence/The list contextualizer>

{
    my $a = 3;
    my $b = 2;
    my $c = 1;

    # I'm not sure that smart matching is the best operation for comparison here
    # There might be a more specific way to check that prevents false matching
    isa-ok(list($a).WHAT,  List, 'list(values) returns nothing more than a List');
    isa-ok(@($a).WHAT,     List, '@(values) returns nothing more than a List');
    isa-ok((list $a).WHAT, List, '(list values) returns nothing more than a List');

    # These are all no-ops but still need to work correctly
    isa-ok(list($a, $b, $c).WHAT,   List, 'list(values) returns nothing more than a List');
    isa-ok(@($a, $b, $c).WHAT,      List, '@(values) returns nothing more than a List');
    isa-ok((list $a, $b, $c).WHAT,  List, '(list values) returns nothing more than a List');
    is((list $a, $b, $c), ($a, $b, $c), 'list($a, $b, $c) is ($a, $b, $c)');
    is(@($a, $b, $c),     ($a, $b, $c), '@($a, $b, $c) is ($a, $b, $c)');

    # Test the only difference between @() and list()
    is(list(), (), 'list() should return an empty list');
}


# L<S03/List prefix precedence/The item contextualizer>
# L<S02/Lists/To force a non-flattening item context>
{
    my $a = 3;
    my $b = 2;

    is((item $a).WHAT.gist, $a.WHAT.gist, '(item $a).WHAT matches $a.WHAT');
    is((item $a), $a, 'item $a is just $a');
    is(item($a),  $a, 'item($a) is just $a');
    is($($a),     $a, '$($a) is just $a');

    isa-ok((item $a, $b).WHAT, List, '(item $a, $b) makes a List');
    isa-ok(item($a, $b).WHAT,  List, 'item $a, $b makes a List');
    isa-ok($($a, $b).WHAT,     List, '$ $a, $b makes a List');
    my @array = ($a, $b);
    is((item $a, $b), @array, 'item($a, $b) is the same as <<$a $b>> in an array');
}

{
    my @a = 1, 2;
    my %b = 'x' => 42;

    is-deeply [@a], [1, 2], '@array flattening';
    is-deeply [item @a], [$[1, 2]], 'item @array non-flattening';
    is-deeply [%b], ['x' => 42], '%hash flattening';
    is-deeply [item %b], [${'x' => 42}], 'item %hash non-flattening';
}

{
    # Most of these tests pass in Rakudo, but we must compare with
    # eqv instead of eq, since the order of hashes is not guaranteed
    # with eq. eqv does guarantee the order.
    # also, we assign to a hash since rakudo does not recognize
    # {} as a hash constructor and () does not make a hash
    ok(%('a', 1, 'b', 2)     eqv {a => 1, b => 2}, '%(values) builds a hash');
    ok(hash('a', 1, 'b', 2)  eqv {a => 1, b => 2}, 'hash(values) builds a hash');
    ok((hash 'a', 1, 'b', 2) eqv {a => 1, b => 2}, 'hash values builds a hash');
    throws-like 'hash("a")', X::Hash::Store::OddNumber,
        'building a hash of one item fails';
}

# L<S03/"Changes to Perl operators"/Perl's ${...}, @{...}, %{...}, etc>
#                       ^ non-breaking space
# Deprecated P5 dereferencing operators:
{
    my $scalar = 'abcd';
    throws-like '${$scalar}', X::Obsolete, 'Perl form of ${$scalar} dies';
    throws-like '"${$scalar}"', X::Obsolete, 'Perl form of "${$scalar}" dies';

    my $array  = [1, 2, 3];
    throws-like '@{$array}', X::Obsolete, 'Perl form of @{$array} dies';
    throws-like '"@{$array}"', X::Obsolete, 'Perl form of "@{$array}" dies';

    my $hash  = {a => 1, b => 2, c => 3};
    throws-like '%{$hash}', X::Hash::Store::OddNumber, 'Let rare Perl form of %{$hash} fail for other reasons';
}

is(($).WHAT.gist, '(Any)', 'Anonymous $ variable can be declared');
is((@).WHAT.gist, '(Array)', 'Anonymous @ variable can be declared');
is((%).WHAT.gist, '(Hash)', 'Anonymous % variable can be declared');

is((++$), 1, 'Anonymous $ variable can be incremented');
is((@).push(42,43), '42 43', 'Anonymous @ variable can be pushed');

{
    my @seq = map { $_ ~ ++$ }, <a b c>;
    is @seq, <a1 b2 c3>, 'Anonymous $ is really a state variable';
}

# RT #76320
{
    my $h = <a b c d>;
    is ~%$h.keys.sort, 'a c', '%$var coercion';

    my $c = 0;
    $c++ for @$h;
    is $c, 4, '@$var coercion';
}

# vim: ft=perl6
