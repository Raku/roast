use v6;

use Test;

plan 4;

# L<S02/Names and Variables/special variables of Perl 5 are going away>

# things that should be valid
# these tests are probably going to fail if declaring a magical var ever becomes unallowed
eval_lives_ok 'my $!', '$! parses ok';
eval_lives_ok 'my $/', 'as does $/';

# things that should be invalid
#?rakudo skip 'Null PMC access in type()'
eval_dies_ok 'my $f!ao = "beh";', "but normal varnames can't have ! in their name";
#?rakudo skip 'Null PMC access in type()'
eval_dies_ok 'my $fo:o::b:ar = "bla"', "var names can't have colons in their names either";

