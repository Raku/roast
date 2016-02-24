use v6.c;
use Test;
plan 6;

# test that classes and roles declared in modules get into the correct
# namespace

# Used to be a Rakudo bug, RT #63956

use lib 't/spec/packages';

eval-lives-ok 'use A::A', 'Can load classes from nested modules';
eval-lives-ok 'use A::A; A::B::D ~~ A::B::B or die()', 
              '... and the composition worked';
eval-lives-ok 'use A::A; A::B::D.new()',
              '... and instantiation works';

eval-lives-ok 'use A; A.new()', 'RT #62162';

eval-lives-ok 'use RoleA',
              'can use multiple "Role $name" statements (in multiple files) RT #67976';

{
    use RoleA;
    role RoleB {...}

    class MyFu does RoleB {}
    ok MyFu ~~ RoleB, 'Composition worked';
}

# vim: ft=perl6
