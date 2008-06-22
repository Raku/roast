use v6;

use Test;

plan 33;

# L<S02/Lists/There is a "list" operator>
# L<S03/List prefix precedence/The list contextualizer>

# Some of these tests may seem redundant, especially (@ 1,2) versus @(1,2)
# The difference is that @ 1,2 is a listop while @(1,2) is a function call
{
    my $a = 3;
    my $b = 2;
    my $c = 1;

    # I'm not sure that smart matching is the best operation for comparison here
    # There might be a more specific way to check that prevents false matching
    is(list($a).WHAT,  'List', 'list(values) returns nothing more than a List');
    is(@($a).WHAT,     'List', '@(values) returns nothing more than a List');
    is((list $a).WHAT, 'List', '(list values) returns nothing more than a List');
    #?rakudo 1 skip "'(@ $a)' parsefail"
    is((@ $a).WHAT,    'List', '(@ values) returns nothing more than a List');
    
    # These are all no-ops but still need to work correctly
    is(list($a, $b, $c).WHAT,   'List', 'list() returns nothing more than a List');
    is(@($a, $b, $c).WHAT,      'List', '@() returns nothing more than a List');
    is((list $a, $b, $c).WHAT,  'List', 'list() returns nothing more than a List');
    #?rakudo 1 skip "'(@ $a)' parsefail"
    is((@ $a, $b, $c).WHAT,     'List', '@() returns nothing more than a List');
    is((list $a, $b, $c), ($a, $b, $c), 'list($a, $b, $c) is ($a, $b, $c)');
    is(@($a, $b, $c),     ($a, $b, $c), 'list($a, $b, $c) is ($a, $b, $c)');

    # Test the only difference between @() and list()
    is(list(), (), 'list() should return an empty list');
    'foo' ~~ /oo/; # run a regex so we have $/ below
    #?rakudo 1 skip '@() is not the same as @($/)'
    is(@(),  @($/), '@() should be the same as @($/)')

#    #?rakudo 1 skip 'zip does not work'
#    is((@ 1,2 Z 3,4), <1 3 2 4>, '@ operator has proper precedence to change context of zip infix');
}

# L<S03/List prefix precedence/The item contextualizer>
# L<S02/Lists/To force a non-flattening item context>

#?rakudo 12 skip 'item() not implemented'
{
    my $a = 3;
    my $b = 2;

    is((item $a).WHAT, $a.WHAT, '(item $a).WHAT matches $a.WHAT');
    is(($ $a).WHAT,    $a.WHAT, '($ $a).WHAT matches $a.WHAT');
    is((item $a), $a, 'item $a is just $a');
    is(($ $a),    $a, '$ $a is just $a');
    is(item($a),  $a, 'item($a) is just $a');
    is($($a),     $a, '$($a) is just $a');

    is((item $a, $b).WHAT, 'Array', '(item $a, $b) makes an array');
    is(item($a, $b).WHAT,  'Array', 'item $a, $b makes an array');
    is(($ $a, $b).WHAT,    'Array', '($ $a, $b) makes an array');
    is($($a, $b).WHAT,     'Array', '$ $a, $b makes an array');
    my @array = <<$a $b>>;
    is((item $a, $b), @array, 'item($a, $b) is the same as <<$a $b>> in an array');

    is(($ 1,2 Z 3,4), [[1,3], [2,4]], '$ operator has proper precendence to change context of zip infix');
}

#?rakudo 1 skip 'zip and @@ are broken'
{
    is((@@ 1,2 Z 3,4), ([1,3], [2,4]), '@@ has correct precedence to change context of zip infix');
}

#?rakudo 6 skip 'eqv not implemented'
{
    # Most of these tests pass in Rakudo, but we must compare with
    # eqv instead of eq, since the order of hashes is not guaranteed
    # with eq. eqv does guarantee the order.
    # also, we assign to a hash since rakudo does not recognize
    # {} as a hash constructor and () does not make a hash
    my %hash = ('a' => 1, 'b' => 3);
    ok(%('a', 1, 'b', 2)     eqv %hash, '%(values) builds a hash');
    #?rakudo 1 skip '"% a,1" parsefail'
    ok((% 'a', 1, 'b', 2)    eqv  %hash, '% values builds a hash');
    ok(hash('a', 1, 'b', 2)  eqv %hash, 'hash(values) builds a hash');
    ok((hash 'a', 1, 'b', 2) eqv %hash, 'hash values builds a hash');
    eval_dies_ok('hash("a")', 'building a hash of one item fails');

    my %zipped = (1 => 3, 2 => 4);
    #?rakudo 1 skip 'zip is broken'
    ok((% 1,2 Z 3,4) eqv %zipped, '% has correct precedence to change context of zip infix');
}
