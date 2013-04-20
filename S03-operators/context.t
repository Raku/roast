use v6;

use Test;

plan 32;

# L<S03/List prefix precedence/The list contextualizer>

{
    my $a = 3;
    my $b = 2;
    my $c = 1;

    # I'm not sure that smart matching is the best operation for comparison here
    # There might be a more specific way to check that prevents false matching
    #?pugs todo
    isa_ok(list($a).WHAT,  List, 'list(values) returns nothing more than a List');
    isa_ok(@($a).WHAT,     List, '@(values) returns nothing more than a List');
    #?pugs todo
    isa_ok((list $a).WHAT, List, '(list values) returns nothing more than a List');

    # These are all no-ops but still need to work correctly
    isa_ok(list($a, $b, $c).WHAT,   List, 'list(values) returns nothing more than a List');
    isa_ok(@($a, $b, $c).WHAT,      List, '@(values) returns nothing more than a List');
    isa_ok((list $a, $b, $c).WHAT,  List, '(list values) returns nothing more than a List');
    is((list $a, $b, $c), ($a, $b, $c), 'list($a, $b, $c) is ($a, $b, $c)');
    is(@($a, $b, $c),     ($a, $b, $c), '@($a, $b, $c) is ($a, $b, $c)');

    # Test the only difference between @() and list()
    is(list(), (), 'list() should return an empty list');
    'foo' ~~ /(o)o/; # run a regex so we have $/ below
    #?rakudo skip '@() not implemented'
    is(@(),  @($/), '@() should be the same as @($/)');
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

    #?niecza 4 skip 'Excess arguments to item, used 1 of 2 positionals'
    isa_ok((item $a, $b).WHAT, Array, '(item $a, $b) makes an Array');
    isa_ok(item($a, $b).WHAT,  Array, 'item $a, $b makes an Array');
    isa_ok($($a, $b).WHAT,     Parcel, '$ $a, $b makes a Parcel');
    my @array = ($a, $b);
    is((item $a, $b), @array, 'item($a, $b) is the same as <<$a $b>> in an array');
}

{
    # Most of these tests pass in Rakudo, but we must compare with
    # eqv instead of eq, since the order of hashes is not guaranteed
    # with eq. eqv does guarantee the order.
    # also, we assign to a hash since rakudo does not recognize
    # {} as a hash constructor and () does not make a hash
    #?pugs 3 todo
    ok(%('a', 1, 'b', 2)     eqv {a => 1, b => 2}, '%(values) builds a hash');
    ok(hash('a', 1, 'b', 2)  eqv {a => 1, b => 2}, 'hash(values) builds a hash');
    ok((hash 'a', 1, 'b', 2) eqv {a => 1, b => 2}, 'hash values builds a hash');
    eval_dies_ok('hash("a")', 'building a hash of one item fails');
}

# L<S03/"Changes to Perl 5 operators"/Perl 5's ${...}, @{...}, %{...}, etc>
#                       ^ non-breaking space
# Deprecated P5 dereferencing operators:
{
    my $scalar = 'abcd';
    eval_dies_ok('${$scalar}', 'Perl 5 form of ${$scalar} dies');

    my $array  = [1, 2, 3];
    eval_dies_ok('@{$array}', 'Perl 5 form of @{$array} dies');

    my $hash  = {a => 1, b => 2, c => 3};
    eval_dies_ok('%{$hash}', 'Perl 5 form of %{$hash} dies');
}

eval_dies_ok('$', 'Anonymous $ variable outside of declaration');
eval_dies_ok('@', 'Anonymous @ variable outside of declaration');
eval_dies_ok('%', 'Anonymous % variable outside of declaration');
eval_dies_ok('&', 'Anonymous & variable outside of declaration');

# RT #76320
#?pugs skip 'Cannot cast into Hash: VRef'
{
    my $h = <a b c d>;
    is ~%$h.keys.sort, 'a c', '%$var coercion';
    
    my $c = 0;
    $c++ for @$h;
    is $c, 4, '@$var coercion';
}

#?rakudo skip '$@var syntax'
#?pugs todo
#?niecza skip "Invalid hard reference syntax"
{
    my @a = <a b c d>;
    my $c = 0;
    $c++ for $@a;
    is $c, 1, '$@var itemization'
}

# vim: ft=perl6
