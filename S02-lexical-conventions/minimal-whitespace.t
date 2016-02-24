use v6.c;

use Test;

plan 18;

# L<S03/Minimal whitespace DWIMmery/Whitespace is no longer allowed before>

my @arr = <1 2 3 4 5>;
throws-like { EVAL '@arr [0]' },
  X::Syntax::Missing,
  'array with space before opening brackets does not work';

my %hash = a => 1, b => 2;
throws-like { EVAL '%hash <a>' },
  X::Comp::AdHoc,  # no exception type yet
  'hash with space before opening brackets does not work (1)';
throws-like { EVAL '%hash {"a"}' },
  X::Comp::AdHoc,  # no exception type yet
  'hash with space before opening braces does not work (2)';

class Thing {method whatever (Int $a) {3 * $a}}
lives-ok { EVAL 'Thing .new' },
  'whitespace *is* allowed before . after class name';
lives-ok { EVAL 'Thing. new' },
  'whitespace *is* allowed after . after class name';

my $o = Thing.new;
lives-ok { EVAL '$o .whatever(5)' },
  'whitespace *is* allowed before . before method';
lives-ok { EVAL '$o. whatever(5)' },
  'whitespace *is* allowed after . before method';

throws-like { EVAL '42 i' },
  X::Comp,
  'whitespace is not allowed before i postfix';
throws-like { EVAL '42. i' },
  X::Comp,
  'whitespace is not allowed between . and i postfix';

my $o = 42;
throws-like { EVAL '$o ++' },
  X::Comp,
  'whitespace is not allowed before ++ postfix';
throws-like { EVAL '$o. ++' },
  X::Obsolete,
  'whitespace is not allowed between . and postfix';

lives-ok { EVAL 'my @rt80330; [+] @rt80330' },
  'a [+] with whitespace works';
throws-like  { EVAL 'my @rt80330; [+]@rt80330' },
  X::Syntax::Confused,
  'a [+] without whitespace dies';

#RT #126959
{
    throws-like { EVAL '42.,' },
      X::Comp::Group, message => /"Decimal point must be followed by digit"/,
      'comma is not allowed after dot after digit';
    throws-like { EVAL '42.=' },
      X::Comp::Group, message => /"Decimal point must be followed by digit"/,
      'equal sign is not allowed after dot after digit';
    throws-like { EVAL '42.:' },
      X::Comp::Group, message => /"Decimal point must be followed by digit"/,
      'colon is not allowed after dot after digit';
    throws-like { EVAL '42.:all' },
      X::Syntax::Number::IllegalDecimal,
      'colonpair is not allowed after dot after digit';
    throws-like { EVAL 'say 42.:all' },
      X::Syntax::Number::IllegalDecimal,
      'colonpair is not allowed after dot after digit in arglist';
}

# vim: ft=perl6
