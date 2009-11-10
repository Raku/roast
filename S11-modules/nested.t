use v6;
use Test;
plan 6;

# test that classes and roles declared in modules get into the correct
# namespace

# Used to be a Rakudo bug, RT #63956

BEGIN { @*INC.push('t/spec/packages/') };

eval_lives_ok 'use A::A', 'Can load classes from nested modules';
eval_lives_ok 'use A::A; A::B::D ~~ A::B::B or die()', 
              '... and the composition worked';
eval_lives_ok 'use A::A; A::B::D.new()',
              '... and instantiation works';

eval_lives_ok 'use A; A.new()', 'RT 62162';

eval_lives_ok 'use RoleA',
              'can use multiple "Role $name" statements (in multiple files) RT 67976';

#?rakudo skip 'stubbed roles'
{
    use RoleA;
    role RoleB {...}

    class MyFu does RoleB {}
    ok MyFu ~~ RoleB, 'Composition worked';
}

# vim: ft=perl6
