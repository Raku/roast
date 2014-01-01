use v6;

use Test;

plan 29;

=begin pod

Tests for using parameterized roles as types, plus the of keyword.

=end pod

#?pugs emit skip_rest('parameterized roles'); exit;
#?pugs emit =begin SKIP

# L<S14/Parametric Roles>
# L<S14/Relationship Between of And Types>

role R1[::T] { method x { T } }
class C1 does R1[Int] { }
class C2 does R1[Str] { }
lives_ok { my R1 of Int $x = C1.new },      'using of as type constraint on variable works (class does role)';
dies_ok  { my R1 of Int $x = C2.new },      'using of as type constraint on variable works (class does role)';
lives_ok { my R1 of Int $x = R1[Int].new }, 'using of as type constraint on variable works (role instantiation)';
dies_ok  { my R1 of Int $x = R1[Str].new }, 'using of as type constraint on variable works (role instantiation)';

sub param_test(R1 of Int $x) { $x.x }
isa_ok param_test(C1.new),      Int,          'using of as type constraint on parameter works (class does role)';
dies_ok { param_test(C2.new) },             'using of as type constraint on parameter works (class does role)';
isa_ok param_test(R1[Int].new), Int,          'using of as type constraint on parameter works (role instantiation)';
dies_ok { param_test(R1[Str].new) },        'using of as type constraint on parameter works (role instantiation)';

role R2[::T] {
    method x { "ok" }
    method call_test { self.call_test_helper(T.new) }
    method call_test_helper(T $x) { "ok" }   #OK not used
    method call_fail { self.call_test_helper(4.5) }
}
class C3 does R2[R2[Int]] { }
class C4 does R2[R2[Str]] { }

lives_ok { my R2 of R2 of Int $x = C3.new },          'roles parameterized with themselves as type constraints';
dies_ok { my R2 of R2 of Int $x = C4.new },           'roles parameterized with themselves as type constraints';
lives_ok { my R2 of R2 of Int $x = R2[R2[Int]].new }, 'roles parameterized with themselves as type constraints';
dies_ok { my R2 of R2 of Int $x = R2[R2[Str]].new },  'roles parameterized with themselves as type constraints';

sub param_test_r(R2 of R2 of Int $x) { $x.x }
is param_test_r(C3.new),          'ok',    'roles parameterized with themselves as type constraints';
dies_ok { param_test_r(C4.new) },          'roles parameterized with themselves as type constraints';
is param_test_r(R2[R2[Int]].new), 'ok',    'roles parameterized with themselves as type constraints';
dies_ok { param_test_r(R2[R2[Str]].new) }, 'roles parameterized with themselves as type constraints';

is R2[Int].new.call_test,    'ok', 'types being used as type constraints inside roles work';
dies_ok { R2[Int].new.call_fail }, 'types being used as type constraints inside roles work';
is C3.new.call_test,         'ok', 'roles being used as type constraints inside roles work';
dies_ok { C3.new.call_fail },      'roles being used as type constraints inside roles work';
is C4.new.call_test,         'ok', 'roles being used as type constraints inside roles work';
dies_ok { C4.new.call_fail },      'roles being used as type constraints inside roles work';
is R2[C3].new.call_test,     'ok', 'classes being used as type constraints inside roles work';
dies_ok { R2[C3].new.call_fail },  'classes being used as type constraints inside roles work';

# RT #72694
eval_dies_ok 'role ABCD[EFGH] { }', 'role with undefined type as parameter dies';

# RT #68136
#?rakudo skip 'cannot easily override [] at the moment'
{
    role TreeNode[::T] does Positional {
        has TreeNode[T] @!children handles 'postcircumfix:<[ ]>'; # METHOD TO SUB CASUALTY
        has T $.data is rw;
    };
    my $tree = TreeNode[Int].new;
    $tree.data = 3;
    $tree[0] = TreeNode[Int].new;
    $tree[1] = TreeNode[Int].new;
    $tree[0].data = 1;
    $tree[1].data = 4;
    is ($tree.data, $tree[0,1]>>.data).join(','), '3,1,4',
        'parameterized role doing non-parameterized role';
}

# RT #68134
{
    role P[$x] { }
    # ::T only makes sense in a signature here, not in
    # an argument list.
    dies_ok { EVAL 'class MyClass does P[::T] { }' },
        'can not use ::T in role application';
}

# RT #101426
{
    my role R[::T = my role Q[::S = role { method baz { "OH HAI" } }] { method bar { S.baz } }] { method foo { T.bar } };
    is R.new.foo, 'OH HAI', 'can use a parameterized role as a default value of a parameterized role';

}

# RT #114954
{
    my module A {
        role B[$x] is export {
            method payload { $x }
        }
    }
    import A;
    is B['blubb'].payload, 'blubb', 'can export and import parameterized roles';
}

#?pugs emit =end SKIP

# vim: ft=perl6
