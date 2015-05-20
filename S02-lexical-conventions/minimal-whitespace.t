use v6;

use Test;

plan 9;

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
throws-like { EVAL 'Thing .new' },
  X::Syntax::Confused,
  'whitespace is not allowed before . after class name';
throws-like { EVAL 'Thing. new' },
  X::Obsolete,
  'whitespace is not allowed after . after class name';

my $o = Thing.new;
throws-like { EVAL '$o .whatever(5)' },
  X::Syntax::Confused,
  'whitespace is not allowed before . before method';
throws-like { EVAL '$o. whatever(5)' },
  X::Obsolete,
  'whitespace is not allowed after . before method';

lives-ok { EVAL 'my @rt80330; [+] @rt80330' },
  'a [+] with whitespace works';
throws-like  { EVAL 'my @rt80330; [+]@rt80330' },
  X::Syntax::Confused,
  'a [+] without whitespace dies';

# vim: ft=perl6
