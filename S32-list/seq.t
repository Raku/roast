use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 49;

my @result = 1,2,3;

my @a = (1,2,3).map(*.Int);
is-deeply @a, @result, 'seq => array works 1';

my ($x, @b)  = ('xxx', (1,2,3).map(*.Int));
is(@b.elems, 1, "We didn't flatten the RHS because it's no single argument");
is(@b[0].WHAT, Seq, "Seq stayed intact");
is-deeply @b[0].Array, @result, 'seq => array works 2';


my @expected-searches = <beer masak vacation whisky>;
my ($y, @searches) = "xxxx\n", q:to/SEARCHES/.lines;
    beer
    masak
    vacation
    whisky
    SEARCHES
is(@searches.elems, 1, "We didn't flatten the RHS because it's no single argument");
is(@searches[0].WHAT, Seq, "Seq stayed intact");
is-deeply @searches[0].Array, @expected-searches, 'seq => array works 3';

{
    my @n;
    @n[0, 1] = <a b>.sort;
    # bug found by the IRC::Utils test suite
    is @n.join('|'), 'a|b', 'can assign a Seq to an array slice';

    @n = 1,2;
    @n[0,1] = @n Z~ <a b>;
    is @n, ("1a","2b"), 'assign slice from Seq that references same array';

    @n = 1,2;
    @n[0,1,2] = <a b>.sort;
    is @n, ["a","b", Any], 'slice assignment from seq Nils out unused indices';

    @n = 2,1;
    @n[@n.sort] = <a b>.sort;
    is @n, (2,"a","b"), 'assign slice indexed by self-referential Seq (1)';

    @n = 2,3;
    @n[@n.map(*+0)] = <a b>.sort;
    is @n, (2,3,"a","b"), 'assign slice indexed by self-referential Seq (2)';

    @n = 0,1;
    @n[@n.push(2,3)] = <a b>.sort;
    is @n, ("a","b",Any,Any), 'array slice assigned from Seq evals indices first';

    @n = 5,6;
    @n[@n.map({ ($++,).Slip })] = <a b>.sort;
    is @n, <a b>, 'array slice assigned from Seq evals index Seq first';

    @n = 0,1;
    @n[*-1,*-2] = <a b>.sort;
    is @n, <b a>, 'WhateverCode works on array slice assigned from Seq';

    @n = 0,1;
    @n[*] = <a b>.sort;
    is @n, <a b>, 'Whatever array slice assigned from Seq works';

    @n = 0,1,2;
    @n[*] = <a b>.sort;
    is @n, ("a", "b", Any), 'Whatever array slice assigned from Seq Nils unassigned indices';

    @n = 0,1;
    my $b = 0;
    @n[0,1] = (1,2).map({$b = $_});
    is $b, 2, 'Array slice assigned from Seq is eager';

    my @m = 0,1;
    @n = 0,1;
    @m[0,1] = @n[1,0,2] = <a b>.sort;
    is (@m,@n), (<a b>,("b","a",Any)), 'Chained array assignment from Seq';

    @n = 0,1;
    @n[0,] = <a b>.sort;
    is @n, ("a",1), 'single index array slice assignment from Seq';

    @n = 0,1;
    @n[0] = <a b>.sort;
    is @n, (<a b>,1), 'single index assignment from Seq';

}

# Lazy assignment.
{
    my @n = 0,1;
    eager @n.map(-> $v is rw {$v})[0,1] = <a b>.sort;
    is @n, <a b>, 'Seq slice assignment works';
}

# https://github.com/Raku/old-issue-tracker/issues/5124
{
    eager my \s = ().Seq.slice; # eager consumes the Seq
    cmp-ok s.raku.EVAL, '~~', Seq:D, '.raku.EVAL on consumed Seq gives Seq:D';
    throws-like { s.raku.EVAL.list }, X::Seq::Consumed,
        '.raku.EVAL-roundtripped Seq throws when attempting to consume again';
}

{
    my $a = Seq.from-loop({ 1 });
    isa-ok $a, Seq, 'from-loop(&body) returns a Seq';
    ok $a.is-lazy, 'the Seq object is lazy';

    my @values = 1..100;
    $a = Seq.from-loop({ @values.shift }, { state $count = 0; $count++ < 10 });
    isa-ok $a, Seq, 'from-loop(&body, &condition) returns a Seq';
    is-deeply $a, (1..10).Seq, 'from-loop(&body, &condition) terminates calling &body if &condition returns False';

    my $count = 0;
    $a = Seq.from-loop({ ++$ }, { $count < 10 }, { $count++ });
    isa-ok $a, Seq, 'from-loop(&body, &condition, &afterward) returns a Seq';
    is-deeply $a, (1..10).Seq,
        'from-loop(&body, &condition, &afterward) terminates calling &body if &condition returns False';
    is $count, 10, '&afterward is called after each call to &body.';
}

# https://github.com/Raku/old-issue-tracker/issues/6209
with (1, 2).Seq {
    .cache; # Cache the seq
    is .raku, (1, 2).Seq.raku,
        '.raku on cached Seq does not think it was consumed';
}

subtest 'Seq.Capture' => {
    plan 2;
    is-deeply (1, 2, <a b c>).Seq.Capture, (1, 2, <a b c>).Capture,
        '.Capture returns a Capture of the List of the Seq';

    -> ($k, $v) {
        is-deeply ($k, $v), (1, 2), 'can unpack a Seq';
    }( (1, 2).Seq );
}

# https://irclog.perlgeek.de/perl6-dev/2017-05-03#i_14524925
subtest 'methods on cached Seqs' => {
    plan 2;

    subtest 'methods work fine when Seq *is* cached' => {
        plan 11;

        my $s = (1, 2, 3).Seq;
        $s.cache;
        cmp-ok $s, 'eqv', $s, 'infix:<eqv>';
        does-ok $s.iterator,   Iterator,      '.iterator';
        is-deeply $s.Slip,    (1, 2, 3).Slip, '.Slip';
        is-deeply $s.join,    '123',          '.join';
        is-deeply $s.List,    (1, 2, 3),      '.List';
        is-deeply $s.list,    (1, 2, 3),      '.list';
        is-deeply $s.eager,   (1, 2, 3),      '.eager';
        is-deeply $s.Array,   [1, 2, 3],      '.Array';
        is-deeply $s.is-lazy, False,          '.is-lazy (when not lazy)';

        my $s-lazy = lazy gather { .take for 1, 2, 3 };
        $s-lazy.cache;
        is-deeply $s-lazy.is-lazy, True, '.is-lazy';

        my $pulled = False;
        my $s-sink = Seq.new: class :: does Iterator {
            method pull-one { $pulled = True; IterationEnd }
        }.new;
        $s-sink.cache;
        $s-sink.sink; # sink the Seq
        ok not $pulled, '.sinking a cached Seq does not pull from iterator';
    }

    subtest 'methods still throw when Seq is NOT cached' => {
        plan 12;

        (my $s1 = (1, 2, 3).Seq.slice(0,1,2)).sink; # consume the Seq
        (my $s2 = (3, 4, 5).Seq.slice(0,1,2)).sink; # consume the Seq
        throws-like { cmp-ok $s1, 'eqv', $s2 }, X::Seq::Consumed, 'infix:<eqv>';
        throws-like { $s1."$_"() }, X::Seq::Consumed, ".$_"
            for <iterator  Slip  join  List  list  eager  Array  is-lazy>;

        my $s-lazy = lazy gather { .take for 1, 2, 3 };
        $s-lazy.sink; # consume the Seq;
        throws-like { $s-lazy.is-lazy }, X::Seq::Consumed,
          '.is-lazy (when lazy)';

        my $pulled = False;
        my $s-sink = Seq.new: class :: does Iterator {
            method pull-one { $pulled = True; IterationEnd }
        }.new;
        $s-sink.sink; # sink the Seq
        ok $pulled, '.sinking uncached Seq pulls from iterator';
        lives-ok { $s-sink.sink }, '.sinking again does not throw';
    }
}

{
    # GH #1349
    is-deeply (1..5).map({$_}).skip(*-3), (3, 4, 5), 'skip works with a WhateverCode';
}

is-deeply .raku.EVAL.flat, .flat,
    'Seq.raku roundtrips containerized Seqs correctly'
with (1, $((2, 3).Seq));

Seq.new(
    class :: does PredictiveIterator {
        my $mess = 'Seq.Numeric uses .count-only method, when available';
        method pull-one   { flunk $mess; IterationEnd }
        method count-only { pass  $mess }
    }.new
).Numeric;

group-of 2 => 'ZEN slices do not cache Seqs' => {
    (my $z-hash := ().Seq.slice)<>.iterator;
    throws-like { $z-hash.iterator }, X::Seq::Consumed, '<> ZEN slice';
    (my $z-list := ().Seq.slice)[].iterator;
    throws-like { $z-list.iterator }, X::Seq::Consumed, '[] ZEN slice';
}


# https://github.com/Raku/old-issue-tracker/issues/3014
{
    my $s = (1, 2, 3).Seq.slice(0,1,2);
    is $s.iterator.pull-one, 1, 'did we get 1 as the first value';
    dies-ok { $s[0] }, 'did accessing first element die';
}

# https://github.com/Raku/old-issue-tracker/issues/6007
{
    my $sum1 = 0;
    is (lazy for ^4 { $sum1 += $_; $_ }).WHAT, Seq,
        'lazy for loop does not execute prematurely (1)';
    ok $sum1 == 0, 'lazy for loop does not execute prematurely (2)';

    my $sum2 = 0;
    is (for ^4 { $sum2 += $_; $_ }).WHAT, List,
        'parenthesis do not imply laziness (1)';
    ok $sum2 == 6, 'parenthesis do not imply laziness (2)';
}

# https://github.com/rakudo/rakudo/issues/2976
{
    lives-ok {
        given Seq.new((1,2,3).iterator) {
            is-deeply .elems, 3, 'Elems on Seq calculates size';
            ok 1|2|3 ~~ .all, 'First pass on cached Seq';
            ok 1|2|3 ~~ .all, 'Second pass on cached Seq';
        }
    }, 'elems call caches Seq';
}

# https://github.com/rakudo/rakudo/issues/4039
{
    is-deeply ({ 1 | -1 } ... *)[^3], (any(1, -1),any(1, -1),any(1, -1)),
      'check that we do not create 1 element lists';
}

# vim: expandtab shiftwidth=4
