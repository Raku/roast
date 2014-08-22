use v6;
use Test;

plan 9;

=begin pod

Tests for lexical roles delcared with 'my role'

=end pod

# L<S12/Classes>

# A few basic tests.
#?rakudo.jvm todo "?"
eval_lives_ok 'my role R1 {}', 'my role parses OK';
#?rakudo.jvm todo "?"
eval_lives_ok '{ my role R2 {} }; { my role R2 {} }',
              'declare roles with the same name in two scopes.';
eval_dies_ok  '{ my class R3 {}; R3; }; R3',
              'scope is correctly restricted';

{
    my role Model {
        method catwalk() { 'ooh pretty!' }
    }

    is Model.gist, '(Model)',            'lexical role type object stringifies OK';
    is Model.catwalk, 'ooh pretty!', 'can pun lexical role';

    my class SuperModel does Model {
    }
    ok SuperModel ~~ Model,        'lexical role can be composed and smart-matches';
    my $sm = SuperModel.new();
    ok $sm ~~ Model,               'instance smart-matches against lexical role too';
    is $sm.catwalk, 'ooh pretty!', 'can call composed method';
}

{
    # This one was a former Rakudo bug.
    my role Drinking { method go-to-bar() { "glug" } }
    my role Gymnastics { method go-to-bar() { "ouch" } }
    my class DrunkGymnast does Gymnastics does Drinking {
        method go-to-bar() { self.Gymnastics::go-to-bar() }
    }
    is DrunkGymnast.new.go-to-bar, "ouch", 'the $obj.RoleName::meth() syntax works on lexical roles';
}

# vim: ft=perl6
