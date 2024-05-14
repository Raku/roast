use Test;

plan 15;

is-deeply ().are,                 Nil,  'Empty list';
is-deeply (1,2,3).are,            Int,  'list of Ints';
is-deeply (1,2,3.5).are,          Real, 'list of Ints and Rat';
is-deeply (1,2,3e0).are,          Real, 'list of Ints and Num';
is-deeply (1,2,3,"foo").are,      Cool, 'list of Ints and Str';
is-deeply (1,2,3,<42>).are,       Int,  'list of Ints and IntStr';
is-deeply (1,2,3,<42.0>).are,     Real, 'list of Ints and RatStr';
is-deeply (1,2,3,<42e0>).are,     Real, 'list of Ints and NumStr';
is-deeply (<a b c 42>).are,       Str,  'list of Str and IntStr';
is-deeply (1,2,3,Date.today).are, Any,  'list of Ints and Date';
is-deeply (1,2,3,Mu.new).are,     Mu,   'list of Ints and Mu';
is-deeply (1,2,3,(1,2,3)).are,    Cool, 'list of Ints and List';
is-deeply (Int,Cool,Rat,Num).are, Cool, 'list of Cool type objects';

class Ztr is Str { }
is-deeply ("foo",Ztr.new(value => "bar")).are, Str,
  'list of str and custom class';

# https://github.com/rakudo/rakudo/issues/5568
is-deeply (Numeric,42).are, Numeric, 'bare roles also supported';

# vim: expandtab shiftwidth=4
