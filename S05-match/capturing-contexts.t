use v6;

use Test;

plan 9;

if !eval('("a" ~~ /a/)') {
  skip_rest "skipped tests - rules support appears to be missing";
  exit;
}

# L<< S05/Return values from matches/"A match always returns a Match object" >>
{
  my $match = 'abd' ~~ m/ (a) (b) c || (\w) b d /;
  isa_ok( $match, 'Match', 'Match object returned');
  isa_ok( $/, 'Match', 'Match object assigned to $/');
  ok( $/ === $match, 'Same match objects');
}

# L<< S05/Return values from matches/"The array elements of a C<Match> object are referred to" >>
{
  'abd' ~~ m/ (a) (b) c || (\w) b d /;
  ok( $/[0] eq 'a', 'positional capture accessible');
  ok( @($/).[0] eq 'a', 'array context - correct number of positional captures');
  ok( @($/).elems == 1, 'array context - correct number of positional captures');
}

# L<< S05/Return values from matches/"When used as a hash, a C<Match> object" >>
{
  'abd' ~~ m/ <alpha> <alpha> c || <alpha> b d /;
  ok( $/<alpha> eq 'a', 'named capture accessible');
  ok( %($/).keys == 1, 'hash context - correct number of named captures');
  ok( %($/).<alpha> eq 'a', 'hash context - named capture accessible');
}
