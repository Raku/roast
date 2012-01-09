use v6;

use Test;

plan 47;

=begin pod

Tests for the parents meta-method for introspecting class parents.

=end pod

# L<S12/Introspection/"The .^parents method">
class A { }
class B is A { }
class C is A { }
class D is B is C { }
my @parents;

@parents = A.^parents(:all);
is +@parents, 2, 'right number of parents in list of all, from type-object';
ok @parents[0].WHAT =:= Any, 'first parent is Any';
ok @parents[1].WHAT =:= Mu, 'second parent is Mu';

@parents = A.new.^parents(:all);
is +@parents, 2, 'right number of parents in list of all, from instance';
ok @parents[0].WHAT =:= Any, 'first parent is Any';
ok @parents[1].WHAT =:= Mu, 'second parent is Mu';

@parents = D.^parents(:all);
is +@parents, 5, 'right number of parents in list of all, from type-object, multiple inheritance';
ok @parents[0].WHAT =:= B, 'first parent is B';
ok @parents[1].WHAT =:= C, 'second parent is C';
ok @parents[2].WHAT =:= A, 'third parent is A';
ok @parents[3].WHAT =:= Any, 'forth parent is Any';
ok @parents[4].WHAT =:= Mu, 'fifth parent is Mu';

@parents = D.new.^parents(:all);
is +@parents, 5, 'right number of parents in list of all, from instance, multiple inheritance';
ok @parents[0].WHAT =:= B, 'first parent is B';
ok @parents[1].WHAT =:= C, 'second parent is C';
ok @parents[2].WHAT =:= A, 'third parent is A';
ok @parents[3].WHAT =:= Any, 'forth parent is Any';
ok @parents[4].WHAT =:= Mu, 'fifth parent is Mu';

@parents = B.^parents(:local);
is +@parents, 1, 'right number of parents in list, from type-object, :local';
ok @parents[0].WHAT =:= A, 'parent is A'; 

@parents = B.new.^parents(:local);
is +@parents, 1, 'right number of parents in list, from instance, :local';
ok @parents[0].WHAT =:= A, 'parent is A'; 

@parents = D.^parents(:local);
is +@parents, 2, 'right number of parents in list, from type-object, :local, multiple inheritance';
ok @parents[0].WHAT =:= B, 'first parent is B';
ok @parents[1].WHAT =:= C, 'second parent is C';

@parents = D.new.^parents(:local);
is +@parents, 2, 'right number of parents in list, from instance, :local, multiple inheritance';
ok @parents[0].WHAT =:= B, 'first parent is B';
ok @parents[1].WHAT =:= C, 'second parent is C';

@parents = D.^parents(:tree);
is +@parents, 2,         'with :tree, D has two immediate parents (on proto)';
ok @parents[0] ~~ Array, ':tree gives back nested arrays for each parent (on proto)';
ok @parents[1] ~~ Array, ':tree gives back nested arrays for each parent (on proto)';
ok @parents eqv [[B, [A, [Any, [Mu]]]], [C, [A, [Any, [Mu]]]]],
                         ':tree gives back the expected data structure (on proto)';

@parents = D.new.^parents(:tree);
is +@parents, 2,         'with :tree, D has two immediate parents (on instance)';
ok @parents[0] ~~ Array, ':tree gives back nested arrays for each parent (on instance)';
ok @parents[1] ~~ Array, ':tree gives back nested arrays for each parent (on instance)';
ok @parents eqv [[B, [A, [Any, [Mu]]]], [C, [A, [Any, [Mu]]]]],
                         ':tree gives back the expected data structure (on instance)';


@parents = Str.^parents(:all);
is +@parents, 3, 'right number of parents for Str built-in, from type-object';
ok @parents[0].WHAT =:= Cool, 'first parent is Cool';
ok @parents[1].WHAT =:= Any, 'second parent is Any';
ok @parents[2].WHAT =:= Mu, 'third parent is Mu';

@parents = "omg introspection!".^parents(:all);
is +@parents, 3, 'right number of parents for Str built-in, from instance';
ok @parents[0].WHAT =:= Cool, 'first parent is Cool';
ok @parents[1].WHAT =:= Any, 'second parent is Any';
ok @parents[2].WHAT =:= Mu, 'third parent is Mu';

@parents = Mu.^parents();
is +@parents, 0, 'Mu has no parents (no params)';
@parents = Mu.^parents(:local);
is +@parents, 0, 'Mu has no parents (:local)';
@parents = Mu.^parents(:tree);
is +@parents, 0, 'Mu has no parents (:tree)';

# vim: ft=perl6
