use v6;
use lib 't/spec/packages';   # for some reason, this must be *AFTER* use Test
use Test;
plan 8;

# test that classes and roles declared in modules get into the correct
# namespace

# Used to be a Rakudo bug, RT #63956

eval-lives-ok 'use A::A', 'Can load classes from nested modules';
eval-lives-ok 'use A::A; A::B::D ~~ A::B::B or die()', 
              '... and the composition worked';
eval-lives-ok 'use A::A; A::B::D.new()',
              '... and instantiation works';

eval-lives-ok 'use A; A.new()', 'RT #62162';

eval-dies-ok "use DependencyLoop::A;", 'dependency loop detected in use';

eval-lives-ok 'use RoleA',
              'can use multiple "Role $name" statements (in multiple files) RT #67976';

use RT117117::Backends;
is-deeply(RT117117::Backend::.keys.sort, ('AST', 'GNUC'), 'All nested modules available');

{
    use RoleA;
    role RoleB {...}

    class MyFu does RoleB {}
    ok MyFu ~~ RoleB, 'Composition worked';
}

# vim: ft=perl6
