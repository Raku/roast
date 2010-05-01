use v6;
use Test;

plan 8;

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

    my class SuperModel does Model {
    }
    ok SuperModel ~~ Model,        'lexical role can be composed and smart-matches';
    my $sm = SuperModel.new();
    ok $sm ~~ Model,               'instance smart-matches against lexical role too';
    is $sm.catwalk, 'ooh pretty!', 'can call composed method';
}

# vim: ft=perl6
