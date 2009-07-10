use v6;
use Test;

plan 2;

=begin pod

Tests for lexical classes delcared with 'my class'

=end pod

# L<S12/Classes>

#?rakudo todo 'RT #61108'
eval_lives_ok 'my class A {}', 'my class parses OK';
#?rakudo todo 'RT #61108'
eval_lives_ok '{ my class B {} } { my class B {} }',
              'declare classes with the same name in two scopes.';
