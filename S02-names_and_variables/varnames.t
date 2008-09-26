use v6;

use Test;

plan 4;

# L<S02/Names and Variables/special variables of Perl 5 are going away>

# things that should be valid
# these tests are probably going to fail if declaring a magical var ever becomes unallowed
ok((eval 'my $!; 1'), '$! parses ok');
ok((eval 'my $/; 1'), 'as does $/');

# things that should be invalid
#?rakudo skip 'Null PMC access in type()'
ok(!(eval 'my $f!ao = "beh"; 1'), "but normal varnames can't have ! in their name");
#?rakudo skip 'Null PMC access in type()'
ok(!(eval 'my $fo:o::b:ar = "bla"; 1'), "var names can't have colons in their names either");

