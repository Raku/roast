use v6;
use Test;
plan 14;

# L<S32::Numeric/Numeric/"=item approximately-equal">

=begin pod

Basic tests for the ≅/=~= builtin

=end pod

ok( 0 ≅ 0, '0 is approximately-equal to itself');

ok( 1 ≅ 1, '1 is approximately-equal to itself');

ok( 0 =~= 0, '0 is approximately-equal (Texas-style) to itself');

ok( 1 =~= 1, '1 is approximately-equal (Texas-style) to itself');

ok( 1.000000000000001 ≅ 1, 'test default tolerance');

nok( 1.000000000000002 ≅ 1, 'test default tolerance');

ok( 1.000000000000001 ≅ 1 ≅ .9999999999999999, 'test chaining');

skip '1 + $*TOLERANCE does not work';
#ok( (1 + $*TOLERANCE) ≅ 1, 'test boundaries of tolerance');

ok( (1 - $*TOLERANCE) ≅ 1, 'test boundaries of tolerance');

skip '0 + $*TOLERANCE does not work';
#ok( (0 + $*TOLERANCE) ≅ 0, 'test boundaries of tolerance');

skip '0 - $*TOLERANCE does not work';
#ok( (0 - $*TOLERANCE) ≅ 0, 'test boundaries of tolerance');

ok( (2**32 - $*TOLERANCE) ≅ 2**32, 'test large numbers');

skip 'changing the tolerance via adverb currently fails during compilation';
#ok( (2 - $*TOLERANCE) ≅ 2 :tolerance(0.1), 'test changing the tolerance via adverb');

skip 'changing the tolerance in a chain via adverb currently fails during compilation';
#ok( (2 - $*TOLERANCE) ≅ 2 ≅ (2 + $*TOLERANCE) :tolerance(0.1), 'test changing the tolerance in a chain via adverb');

# vim: ft=perl6
