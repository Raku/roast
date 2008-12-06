use v6;

use Test;

plan 6;

=begin pod

These are misc. sub argument errors.

=end pod

sub foo (*$x) { 1 }
#?rakudo todo 'RT #61094'
dies_ok  { foo(reverse(1,2)) }, 'slurpy args are now bounded (1)';

sub bar (*@x) { 1 }
lives_ok { bar(reverse(1,2)) }, 'slurpy args are now bounded (2)';  

#?rakudo 2 todo 'RT #61094'
eval_dies_ok('sub baz ($.x) { ... }', 'parser rejects members as args (1)');

eval_dies_ok '
    class Moo {
        has $.y;
        sub quux ($.x) { 1 };
    }', 
    'parser rejects members as args (2)';

eval_dies_ok('sub quuux ($?VERSION) { ... }'),
    'parser rejects magicals as args (1)';
eval_dies_ok('sub quuuux ($!) { ... }',
    'parser rejects magicals as args (2)');

# vim: ft=perl6
