use v6;

use Test;

# L<S04/Other C<do>-like forms/lazy>

plan 12;

{
  my $was_in_lazy;

  my $var := lazy { $was_in_lazy++; 42 };

  ok !$was_in_lazy,     'our lazy block wasn\'t yet executed (1)';

  is $var,          42, 'our lazy var has the correct value';
  ok $was_in_lazy,      'our lazy block was executed';

  is $var,          42, 'our lazy var still has the correct value';
  is $was_in_lazy,   1, 'our lazy block was not executed again';
}

# dies_ok/lives_ok tests:
{
  my $was_in_lazy;
  my $lazy := lazy { $was_in_lazy++; 42 };
  lives_ok { $lazy = 23 }, "reassigning our var containing a lazy worked (1)";
  is $lazy, 23,            "reassigning our var containing a lazy worked (2)";
  ok !$was_in_lazy,        "reassigning our var containing a lazy worked (3)";
}

{
  my $was_in_lazy;
  my $lazy := lazy { $was_in_lazy++; 42 };
  lives_ok { $lazy := 23 }, "rebinding our var containing a lazy worked (1)";
  is $lazy, 23,             "rebinding our var containing a lazy worked (2)";
  ok !$was_in_lazy,         "rebinding our var containing a lazy worked (3)";
}

#?rakudo todo 'why ever not?'
{
  dies_ok { (lazy { 42 }) = 23 },
    "directly assigning to a lazy var does not work";
}

# Arguably, we should remove the $was_in_lazy tests, as it doesn't really
# matter when the lazy {...} block is actually executed.

# vim: ft=perl6
