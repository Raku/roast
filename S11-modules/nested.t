use v6;
use lib 't/spec/packages';
use lib 't/spec/packages/S11-modules';
use Test;
plan 11;

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

eval-lives-ok
    'use MainLoadsNestedFirst;',
    'Nested package not shadowed by later declaration of containing package';

eval-lives-ok
    'use MainLoadsNestedInside;',
    'Main package not shadowed by later loading of nested package';

eval-lives-ok
    'use Main::Nested; my Main::Nested $foo;',
    'Nested package not cought by lexically imported main package';

use RT117117::Backends;
#?rakudo.jvm todo 'got: $("GNUC",)'
is-deeply(RT117117::Backend::.keys.sort, ('AST', 'GNUC'), 'All nested modules available');

{
    use RoleA;
    role RoleB {...}

    class MyFu does RoleB {}
    ok MyFu ~~ RoleB, 'Composition worked';
}

# vim: ft=perl6
