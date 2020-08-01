use v6;
use Test;

plan 5;

# L<S14/Traits/>

my @var_names;
multi trait_mod:<is>(Variable:D $a, :$noted!) {
    push @var_names, $a.VAR.name;
}

role Doc[Str:D $doc] {
    has $.doc is rw = $doc;
}
multi trait_mod:<is>(Variable:D $a, Str:D :$doc!) {
    $a.var.VAR does Doc[$doc];
}


my $a is noted;
my %b is noted;
my @c is noted;

@var_names .= sort;
is +@var_names, 3, 'have correct number of names noted from trait applied by name';
is @var_names, ['$a','%b','@c'], 'trait recorded correct information';


my $dog   is doc('barks');
my @birds is doc('tweet');
my %cows  is doc('moooo');

is $dog.VAR.doc,   'barks', 'trait applied to scalar variable correctly';
is @birds.VAR.doc, 'tweet', 'trait applied to array variable correctly';
is %cows.VAR.doc,  'moooo', 'trait applied to hash variable correctly';

# vim: expandtab shiftwidth=4
