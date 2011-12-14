use v6;
use Test;

plan 5;

# L<S14/Traits/>

my @var_names;
multi trait_mod:<is>($a, :$noted!) {
    push @var_names, $a.VAR.name;
}

role doc { has $.doc is rw }
multi trait_mod:<is>($a, $arg, :$doc!) {
    $a.container.VAR does doc.new(doc => $arg);
}


my $a is noted;
my %b is noted;
my @c is noted;

@var_names .= sort;
is +@var_names, 3, 'have correct number of names noted from trait applied by name';
is @var_names, ['$a','%b','@c'], 'trait recorded correct information';


my $dog is doc('barks');
my @birds is doc('tweet');
my %cows is doc('moooo');

is $dog.VAR.doc, 'barks', 'trait applied to scalar variable correctly';
is @birds.doc,   'tweet', 'trait applied to array variable correctly';
is %cows.doc,    'moooo', 'trait applied to hash variable correctly';

# vim: ft=perl6
