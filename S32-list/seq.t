use v6;
use Test;

plan 3;

my @result = 1,2,3;

my @a = (1,2,3).map(*.Int);
is @a, @result, 'seq => array works 1';

my ($x, @b)  = ('xxx', (1,2,3).map(*.Int));
is @b, @result, 'seq => array works 2';


my @expected-searches = <beer masak vacation whisky>;
my ($y, @searches) = q:to/INPUT/, q:to/SEARCHES/.lines;
    xxxx
    INPUT
    beer
    masak
    vacation
    whisky
    SEARCHES
is-deeply @searches, @expected-searches, 'seq => array works 3';
