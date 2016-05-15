use v6;
use Test;

plan 35;

my @result = 1,2,3;

my @a = (1,2,3).map(*.Int);
is-deeply @a, @result, 'seq => array works 1';

my ($x, @b)  = ('xxx', (1,2,3).map(*.Int));
is(@b.elems, 1, "We didn't flatten the RHS because it's no single argument");
is(@b[0].WHAT, Seq, "Seq stayed intact");
is-deeply @b[0].Array, @result, 'seq => array works 2';


my @expected-searches = <beer masak vacation whisky>;
my ($y, @searches) = q:to/INPUT/, q:to/SEARCHES/.lines;
    xxxx
    INPUT
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

# Lazy assignment.  This behavior is experimental.
{
    my @n = 0,1;
    eager @n.map(-> $v is rw {$v})[0,1] = <a b>.sort;
    is @n, <a b>, 'Seq slice assignment works';

    @n = 0,1;
    my $b = 0;
    @n.map(-> $v is rw {$b++; $v})[0,1] = <a b>.sort;
    is $b, 0, 'Seq slice assignment is lazy';

    @n = 0,1;
    my @log;
    eager @n.map(-> $v is rw {@log.push("A " ~ $++); $v;})[0,1] = @n.map(-> $v is rw {@log.push("B " ~ $++); $v})[0,1] = <a b>.sort;
    is @n, <a b>, 'Chained Seq slice assignment works';
    is @log, ("A 0","B 0","A 1","B 1"), 'Chained Seq slice assignment is lazy';

    @n = 0,1;
    # (NYI need to cache in sub eagerize when reifying for elems)    
    { eager @n.map(-> $v is rw {$v})[*-2,*-1] = <a b>.sort, <a b>, 'WhateverCode in Seq slice assignment'; CATCH { default { $_.defined } } };
#?rakudo todo 'Cannot assign immutable'
    is @n, <a b>, 'WhateverCode in Seq slice assignment';

}

{
    # RT #127492;
    use MONKEY-SEE-NO-EVAL;
    my \s = ().Seq;
    # consume the seq
    my @dummy = s.list;
    my \roundtripped = EVAL s.perl;
    ok roundtripped.defined, '.perl on an iterated sequence works';

    throws-like { roundtripped.list }, X::Seq::Consumed,
        '.perl on an iterated sequence faithfully reproduces such a sequence';
}

{
    my $a = Seq.from-loop({ 1 });
    isa-ok $a, Seq, 'from-loop(&body) returns a Seq';
    is $a.is-lazy, True, 'the Seq object is lazy';

    $a = Seq.from-loop({ 1 }, { state $count = 0; $count++ < 10 });
    isa-ok $a, Seq, 'from-loop(&body, &condition) returns a Seq';
    is $a, (1) xx 10, 'from-loop(&body, &condition) terminates calling &body if &condition returns False';

    my $count = 0;
    $a = Seq.from-loop({ 1 }, { $count < 10 }, { $count++ });
    isa-ok $a, Seq, 'from-loop(&body, &condition, &afterward) returns a Seq';
    is $a, (1) xx 10, 'from-loop(&body, &condition, &afterward) terminates calling &body if &condition returns False';
    is $count, 10, '&afterward is called after each call to &body.';
}
