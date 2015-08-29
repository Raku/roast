use v6;
use Test;

plan 7;

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
