use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/codevars.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 10;

if !eval('("a" ~~ /a/)') {
  skip_rest "skipped tests - rules support appears to be missing";
  exit;
}

ok("abc" ~~ m/a(bc){$<caught> = $0}/, 'Inner match');
is(~$/<caught>, "bc", 'Inner caught');

my $caught = "oops!";
ok("abc" ~~ m/a(bc){$caught = $0}/, 'Outer match');
is($caught, "bc", 'Outer caught');

ok("abc" ~~ m/a(bc){$0 = uc $0}/, 'Numeric match');
is($/, "abc", 'Numeric matched');
is($0, "BC", 'Numeric caught');

ok("abc" ~~ m/a(bc){make uc $0}/ , 'Zero match');
is($($/), "BC", 'Zero matched');
is(~$0, "bc", 'One matched');

# vim: ft=perl6
