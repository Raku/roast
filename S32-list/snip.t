use v6.e.PREVIEW;

use Test;

plan 6;

my @a = 2, 2, 2, 5, 5, 7, 13, 9, 6, 2, 20, 4;

is-deeply snip(* < 10, 2, 2, 2, 5, 5, 7, 13, 9, 6, 2, 20, 4),
  ((2,2,2,5,5,7), (13,9,6,2,20,4)),
  'sub snip with a single Callable and a slurpy list';

is-deeply snip(* < 10, @a),
  ((2,2,2,5,5,7), (13,9,6,2,20,4)),
  'sub snip with a single Callable and an array';

is-deeply @a.snip(* < 10),
  ((2,2,2,5,5,7), (13,9,6,2,20,4)),
  'snip method with a single Callable and an array';

is-deeply snip( (* < 10, * < 20), 2, 2, 2, 5, 5, 7, 13, 9, 6, 2, 20, 4),
  ((2,2,2,5,5,7),(13,9,6,2),(20,4)),
  'sub snip with two Callables with a slurpy list';

is-deeply snip( (* < 10, * < 20), @a),
  ((2,2,2,5,5,7),(13,9,6,2),(20,4)),
  'sub snip with two Callables and an array';

is-deeply snip( Int, 2, 2, 2, 5, 5, "a", "b", "c"),
  ((2,2,2,5,5),<a b c>),
  'snip with a type object';


# vim: expandtab shiftwidth=4
