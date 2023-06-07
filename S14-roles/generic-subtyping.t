use Test;

plan 5;

lives-ok({ EVAL(Q:to/ROLES/) }, 'can do subtyped generic roles');
role R1[Any ::T] { }
role R2[Cool ::T] does R1[T] { }
ROLES

EVAL(Q:to/TESTS/);
ok(R2[Cool] ~~ R1[Any],  'subtyped generic roles');
ok(R2[Cool] ~~ R2[Cool], 'subtyped generic roles');
ok(R2[Int] ~~ R2[Cool],  'subtyped generic roles');
TESTS

lives-ok({ EVAL(Q:to/ROLE/) }, 'can lookup roles of subtyped generic roles done by roles before they get composed');
multi sub trait_mod:<is>(Mu:U \T, :ok($)!) { T.^roles[0].^roles }

role R2[Int ::T] does R1[T] is ok { }
ROLE

# vim: expandtab shiftwidth=4
