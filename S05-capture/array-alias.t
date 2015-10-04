use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/array_cap.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

# L<S05/Array aliasing/An alias can also be specified using an array>

=end pod

plan 45;

ok("  a b\tc" ~~ m/@<chars>=( \s+ \S+ )+/, 'Named simple array capture');
is(join("|", @<chars>), "  a| b|\tc", 'Captured strings');

ok("  a b\tc" ~~ m/@<first>=( \s+ \S+ )+ @<last>=( \s+ \S+)+/, 'Sequential simple array capture');
is(join("|", @<first>), "  a| b", 'First captured strings');
is(join("|", @<last>), "\tc", 'Last captured strings');

ok("abcxyd" ~~ m/a  @<foo>=(.(.))+ d/, 'Repeated hypothetical array capture');
is(~@<foo>, "bc xy", 'Hypothetical variable captured');
ok(%$/.keys == 1, 'No extra captures');

ok("abcd" ~~ m/a  @<foo>=(.(.))  d/, 'Hypothetical array capture');
is(~@<foo>, "bc", 'Hypothetical variable captured');

our @GA;
#?rakudo 3 skip 'capturing to lexical variable NYI RT #126243'
ok("abcxyd" ~~ m/a  @GA=(.(.))+  d/, 'Global array capture');
is("@GA[]", "c y", 'Global array captured');
ok(%$/.keys == 0, 'No vestigal captures');

my @foo;
#?rakudo 2 skip 'capturing to lexical variable NYI RT #126243'
ok("abcxyd" ~~ m/a  @foo=(.(.))+  d/, 'Package array capture');
is("@foo[]", "c y", 'Package array captured');

my regex two {..}

ok("abcd" ~~ m/a  @<foo>=(<two>)  d/, 'Compound hypothetical capture');
{
  my $ret;
  lives-ok { $ret = @<foo>[0]<two> }, 'Implicit hypothetical variable captured -- lives-ok';
  is $ret, "bc", 'Implicit hypothetical variable captured -- retval is correct';
}
ok(@<foo>, 'Explicit hypothetical variable captured');

ok("  a b\tc" ~~ m/@<chars>=( @<spaces>=[\s+] (\S+))+/, 'Nested array capture');
is(~@<chars>, "  a  b \tc", 'Outer array capture');
is(join("|", @<chars>».<spaces>), "  | |\t", 'Inner array capture');

my regex spaces { @<spaces>=[(\s+)] }

ok("  a  b \tc" ~~ m/@<chars>=( <spaces> (\S+))+/, 'Subrule array capture');

is(~@<chars>, "  a   b  \tc", 'Outer rule array capture');
is(~@<chars>[*-1]<spaces>, " \t", 'Final subrule array capture');

ok("  a b\tc" ~~ m/@<chars>=( @<spaces>=(<.&spaces>) (\S+))+/, 'Nested subrule array capture');
is(~@<chars>, "  a  b \tc", 'Outer rule nested array capture');
is(join("|", @<chars>».<spaces>), "  | |\t", 'Subrule array capture');


ok("  a b\tc" ~~ m/@<chars>=((<spaces>) (\S+))+/, 'Nested multiple array capture');
ok($<chars> ~~ Positional, 'Multiple capture to nested array');
is(@<chars>.elems, 3, 'Multiple capture count');
is(@<chars>[0].WHAT, Match, 'Multiple capture to nested AoA[0]');
is(@<chars>[1].WHAT, Match, 'Multiple capture to nested AoA[2]');
is(@<chars>[2].WHAT, Match, 'Multiple capture to nested AoA[3]');
is(~@<chars>[0][0], "  ", 'Multiple capture value of nested AoA[0][0]');
is(~@<chars>[0][1], "a", 'Multiple capture value of nested AoA[0][1]');
is(~@<chars>[1][0], " ", 'Multiple capture value of nested AoA[1][0]');
is(~@<chars>[1][1], "b", 'Multiple capture value of nested AoA[1][1]');
is(~@<chars>[2][0], "\t", 'Multiple capture value of nested AoA[2][0]');
is(~@<chars>[2][1], "c", 'Multiple capture value of nested AoA[2][1]');


my @bases = ();
#?rakudo 2 skip 'capturing to lexical variable NYI RT #126243'
ok("GATTACA" ~~ m/ @bases=(A|C|G|T)+ /, 'All your bases...');
is("@bases[]", "G A T T A C A", '...are belong to us');

@bases = ();
#?rakudo 3 skip 'capturing to lexical variable NYI RT #126243'
ok("GATTACA" ~~ m/ @bases=(A|C|G|T)**{4} (@bases+) /, 'Array reinterpolation');
is("@bases[]", "G A T T", '...are belong to...');
is("$0", "A", '...A');


# vim: ft=perl6
