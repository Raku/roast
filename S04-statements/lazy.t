use v6;

use Test;

# L<S04/Other C<do>-like forms/lazy>

plan 10;

# https://github.com/Raku/old-issue-tracker/issues/3885
#?rakudo eval "lazy in not there yet"
{
  my $was_in_lazy;
  my $var;

  $var := lazy { $was_in_lazy++; 42 };

  #?rakudo todo 'lazy NYI, currently works like "do"; RT #124571'
  ok !$was_in_lazy,     'lazy block wasn\'t yet executed (1)';

  is $var,          42, 'lazy var has the correct value';
  ok $was_in_lazy,      'lazy block was executed';

  is $var,          42, 'lazy var still has the correct value';
  is $was_in_lazy,   1, 'lazy block was not executed again';
}

# https://github.com/Raku/old-issue-tracker/issues/3885
# dies-ok/lives-ok tests:
#?rakudo eval "lazy in not there yet"
{
  my $was_in_lazy;
  my $lazy := lazy { $was_in_lazy++; 42 };
  dies-ok { $lazy = 23 }, "reassigning var bound to a lazy dies";
  #?rakudo todo 'lazy NYI, currently works like "do"; RT #124571'
  ok !$was_in_lazy,       "trying to reassign var bound to a lazy does not evaluate lazy block";
}

# https://github.com/Raku/old-issue-tracker/issues/3885
#?rakudo eval "lazy in not there yet"
{
  my $was_in_lazy;
  my $lazy := lazy { $was_in_lazy++; 42 };
  $lazy := 23;
  is $lazy, 23,     "rebinding var bound to a lazy worked (2)";
  #?rakudo todo 'lazy NYI, currently works like "do"; RT #124571'
  ok !$was_in_lazy, "rebinding var bound to a lazy does not evaluate lazy block";
}

#?rakudo todo "lazy in not there yet"
{
  throws-like '(lazy { 43 }) = 23 ', X::Assignment::RO,
    "assigning to a lazily computed value does not work";
}

# vim: expandtab shiftwidth=4
