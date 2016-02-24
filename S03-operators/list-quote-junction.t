use v6.c;

use Test;

=begin kwid

= DESCRIPTION

Tests that the C<any()> and list quoting constructs
play well together and match well.

The following should match:

  "foo" ~~ any <foo bar baz>
  "foo" ~~ any(<foo bar baz>)
  "bar" ~~ any <foo bar baz>
  "bar" ~~ any(<foo bar baz>)

The following should not match:

  "fo"      ~~ any <foo bar baz>
  "oo"      ~~ any <foo bar baz>
  "bar b"   ~~ any <foo bar baz>
  "bar baz" ~~ any(<foo bar baz>)

Note: There is a small caveat regarding the convenient
C<< any <foo bar baz> >> syntax, if not used with parentheses:

  say( any <foo bar baz>,"Hello World")

is different from

  say( (any <foo bar baz>), "Hello World")

=end kwid

# L<S03/Changes to Perl 5 operators/"Note that Perl 6 is making a consistent">

my @matching_strings = <foo bar>;
my @nonmatching_strings = ('fo','foo ', 'foo bar baz', 'oo', 'bar b', 'bar baz');

plan 16;

for @matching_strings -> $str {
  ok( $str ~~ (any <foo bar baz>), "'$str' matches any <foo bar baz>" );
  ok( $str ~~ any(<foo bar baz>), "'$str' matches any(<foo bar baz>)" );
};

for @nonmatching_strings -> $str {
  ok( ($str !~~ any <foo bar baz>), "'$str' does not match any <foo bar baz>" );
  ok( $str !~~ any(<foo bar baz>), "'$str' does not match any(<foo bar baz>)" );
};

# vim: ft=perl6
