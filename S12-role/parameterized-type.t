use v6;

use Test;

plan 8;

=begin pod

Tests for using parameterized roles as types, plus the of keyword.

=end pod

#?pugs emit skip_rest('parameterized roles'); exit;
#?pugs emit =begin SKIP

role R1[::T] { method x { ~T } }
class C1 does R1[Int] { }
class C2 does R1[Str] { }

lives_ok { my R1 of Int $x = C1.new },      'using of as type constraint on variable works (class does role)';
dies_ok  { my R1 of Int $x = C2.new },      'using of as type constraint on variable works (class does role)';
lives_ok { my R1 of Int $x = R1[Int].new }, 'using of as type constraint on variable works (role instantiation)';
dies_ok  { my R1 of Int $x = R1[Str].new }, 'using of as type constraint on variable works (role instantiation)';

sub param_test(R1 of Int $x) { $x.x }
is param_test(C1.new),      'Int',          'using of as type constraint on parameter works (class does role)';
dies_ok { param_test(C2.new) },             'using of as type constraint on parameter works (class does role)';
is param_test(R1[Int].new), 'Int',          'using of as type constraint on parameter works (role instantiation)';
dies_ok { param_test(R1[Str].new) },       'using of as type constraint on parameter works (role instantiation)';

#?pugs emit =end SKIP

# vim: ft=perl6
