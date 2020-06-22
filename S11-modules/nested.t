use v6;
use Test;

use lib $?FILE.IO.parent(2).add("packages/AandB/lib");
use lib $?FILE.IO.parent(2).add("packages/S11-modules/lib");
use lib $?FILE.IO.parent(2).add("packages/RT117117/lib");

plan 11;

# test that classes and roles declared in modules get into the correct
# namespace

eval-lives-ok 'use A::A', 'Can load classes from nested modules';
eval-lives-ok 'use A::A; use A::B; A::B::D ~~ A::B::B or die()',
              '... and the composition worked';
eval-lives-ok 'use A::A; use A::B; A::B::D.new()',
              '... and instantiation works';

# https://github.com/Raku/old-issue-tracker/issues/600
eval-lives-ok 'use A; A.new()', 'RT #62162';

eval-dies-ok "use DependencyLoop::A;", 'dependency loop detected in use';

eval-lives-ok 'use RoleA',
              # https://github.com/Raku/old-issue-tracker/issues/1179
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

# https://github.com/Raku/old-issue-tracker/issues/3075
use RT117117::Backends;
use RT117117::Backend::AST;
use RT117117::Backend::GNUC;
#?rakudo.jvm todo 'got: $("GNUC",)'
is-deeply(RT117117::Backend::.keys.sort, ('AST', 'GNUC'), 'All nested modules available');

{
    use RoleA;
    use RoleB;
    role RoleB {...}

    class MyFu does RoleB {}
    ok MyFu ~~ RoleB, 'Composition worked';
}

# vim: expandtab shiftwidth=4
