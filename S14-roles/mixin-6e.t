use v6.e.PREVIEW;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 37;

# L<S14/Run-time Mixins/>

role R1 { method test { 42 } }
class C1 { }

my $x = C1.new();
$x does R1;
is $x.test,     42,         'method from a role can be mixed in';
is $x.?test,    42,         '.? form of call works on a mixed-in role';
is $x.+test,    42,         '.+ form of call works on a mixed-in role';
is $x.*test,    42,         '.* form of call works on a mixed-in role';


role R2 { method test { 42 } }
class C2 { has $.x }
my $y = C2.new(x => 100);
is $y.x,        100,        'initialization sanity check';
$y does R2;
is $y.test,     42,         'method from role was mixed in';
is $y.x,        100,        'mixing in did not destroy old value';


role R3 { has $.answer is rw }
class C3 { has $.x }
$y = C3.new(x => 100);
$y does R3;
$y.answer = 42;
is $y.x,        100,        'mixing in with attributes did not destroy existing ones';
is $y.answer,   42,         'mixed in new attributes';


$y = C3.new(x => 100);
$y does (R2, R3);
$y.answer = 13;
is $y.x,        100,        'multi-role mixin preserved existing values';
is $y.answer,   13,         'attribute from multi-role mixing OK';
is $y.test,     42,         'method from other role was OK too';

{
    my $x = C1.new();
    role A { has $.a is rw }
    role B { has $.b is rw }
    $x does A(1);
    $x does B(2);
    is $x.a,        1,          'mixining in two roles one after the other';
    is $x.b,        2,          'mixining in two roles one after the other';
}

# https://github.com/Raku/old-issue-tracker/issues/1350
{
    role ProvidesFoo { method foo { } }
    class NoFoo { };
    is (NoFoo.new does ProvidesFoo).^methods(:local)>>.name, 'foo',
        'mixin with "does" lists method during introspection';
}

# https://github.com/Raku/old-issue-tracker/issues/2064
{
    throws-like { EVAL q[{ role A { my $!foo; }; role B { my $!foo; }; class C does A does B {} }] },
       X::Syntax::Variable::Twigil, twigil => '!', scope => 'my',
       'RT #77184'
}

# https://github.com/Raku/old-issue-tracker/issues/2494
{
    my $a = 0 but True;
    is +$a, 0, 'RT #100782 1/2';
    is ?$a, Bool::True, 'RT #100782 2/2';
}

# https://github.com/Raku/old-issue-tracker/issues/2943
{
    my $rt115390 = 0;
    for 1..1000 -> $i {
        $rt115390 += $i.raku;
        my $error = (my $val = (^10).pick(3).min but !$rt115390);
        1
    }
    is $rt115390, 500500,
        'no crash with mixin in loop when it is not the last statement in loop';
}

# https://github.com/Raku/old-issue-tracker/issues/2279
is (class { } but role { method answer() { 42 } }).answer, 42,
    'can mix a role into a type object';

# https://github.com/Raku/old-issue-tracker/issues/3216
{
    use experimental :macros;
    throws-like q[role popo { macro marco { $^a but popo }; marco popo; }],
        X::Role::Parametric::NoSuchCandidate,
        role    => { .^name eq 'popo' }
        ;
}

# https://github.com/Raku/old-issue-tracker/issues/3745
{
    my $x;
    lives-ok { $x = True but [1, 2] }, 'but with array literal on RHS works';
    is $x.Array, [1, 2], 'but with array literal provides a .Array method';
}
{
    my $x;
    lives-ok { $x = True but (1, 2).list }, 'but with (1, 2).list on RHS works';
    is $x.List, (1, 2).list, 'but with (1, 2).list provides a .List method';
}
{
    my $x;
    lives-ok { $x = True but (1, "x") }, 'but with (1, "2") on RHS works';
    is $x.Int, 1, 'but with (1, "x") provides a .Int method returning 1';
    is $x.Str, "x", 'but with (1, "x") provides a .Str method returning "x"';
}
throws-like 'True but (1, 1)', Exception, gist => { $^g ~~ /'Int'/ && $g ~~ /resolved/ },
    'True but (1, 1) gets Int conflict to resolve due to generating two Int methods';

# https://irclog.perlgeek.de/perl6/2017-02-25#i_14165034
{
    my role R { multi method foo( :$a!, ) {$a};
             multi method foo( :$b!, ) {$b + 10}
           };
    my class C does R {}

    is C.foo( :a(2) ), 2, 'multi-dispatch mixin sanity';
    is C.foo( :b(3) ), 13, 'multi-dispatch mixin sanity';
}

# https://github.com/Raku/old-issue-tracker/issues/4547
{
    group-of 3 => 'can mixin Block with True' => {
        my $b = Block but True;
        lives-ok { $b.WHICH };
        ok $b ~~ Block;
        is so $b, True;
    }
    group-of 3 => 'can mixin Code with True' => {
        my $b = Code but True;
        lives-ok { $b.WHICH };
        ok $b ~~ Code;
        is so $b, True;
    }
}

{
    my $tweak-invoked = False;
    my role R {
        has $.foo;
        submethod TWEAK {
            $tweak-invoked = True;
            $!foo = 42;
        }
    }

    my class C { };
    my $obj = C.new but R;

    ok $tweak-invoked, "mixin role TWEAK submethod was invoked";
    is $obj.foo, 42, "mixin role attribute has been initialed";
}

cmp-ok sub () is nodal { }, &[~~], Callable,
  'can typecheck mixins of routines against Callable';

lives-ok {
    class { } but role { has $!foo is built(:bind) }
}, 'can mix in roles that use the "is built" trait at runtime';

# vim: expandtab shiftwidth=4
