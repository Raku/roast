use v6;
use Test;

plan 5;

=begin pod

Tests for lexical roles delcared with 'my role'

=end pod

# L<S12/Classes>

# A few basic tests.
eval_lives_ok 'my role R1 {}', 'my role parses OK';
eval_lives_ok '{ my role R2 {} }; { my role R2 {} }',
              'declare roles with the same name in two scopes.';
eval_dies_ok  '{ my class R3 {}; R3; }; R3',
              'scope is correctly restricted';

{
    my role Model {
        method catwalk() { 'ooh pretty!' }
    }
    is ~Model, 'Model()',            'lexical role type object stringifies OK';
    is Model.catwalk, 'ooh pretty!', 'can pun lexical role';
}

# vim: ft=perl6
