use v6;

use Test;

plan 51;

=begin pod

Tests for the parents meta-method for introspecting class parents.

=end pod

# L<S12/Introspection/"The .^parents method">
class A { }
class B is A { }
class C is A { }
class D is B is C { }
my @parents;

@parents = A.^parents();
is +@parents, 2, 'right number of parents in list of all, from proto-object';
is @parents[0].WHAT, 'Any()', 'first parent is Any';
is @parents[1].WHAT, 'Object()', 'second parent is Object';

@parents = A.new.^parents();
is +@parents, 2, 'right number of parents in list of all, from instance';
is @parents[0].WHAT, 'Any()', 'first parent is Any';
is @parents[1].WHAT, 'Object()', 'second parent is Object';

@parents = D.^parents();
is +@parents, 5, 'right number of parents in list of all, from proto-object, multiple inheritance';
is @parents[0].WHAT, 'B()', 'first parent is B';
is @parents[1].WHAT, 'C()', 'second parent is C';
is @parents[2].WHAT, 'A()', 'third parent is A';
is @parents[3].WHAT, 'Any()', 'forth parent is Any';
is @parents[4].WHAT, 'Object()', 'fifth parent is Object';

@parents = D.new.^parents();
is +@parents, 5, 'right number of parents in list of all, from instance, multiple inheritance';
is @parents[0].WHAT, 'B()', 'first parent is B';
is @parents[1].WHAT, 'C()', 'second parent is C';
is @parents[2].WHAT, 'A()', 'third parent is A';
is @parents[3].WHAT, 'Any()', 'forth parent is Any';
is @parents[4].WHAT, 'Object()', 'fifth parent is Object';

@parents = B.^parents(:local);
is +@parents, 1, 'right number of parents in list, from proto-object, :local';
is @parents[0].WHAT, 'A()', 'parent is A'; 

@parents = B.new.^parents(:local);
is +@parents, 1, 'right number of parents in list, from instance, :local';
is @parents[0].WHAT, 'A()', 'parent is A'; 

@parents = D.^parents(:local);
is +@parents, 2, 'right number of parents in list, from proto-object, :local, multiple inheritance';
is @parents[0].WHAT, 'B()', 'first parent is B';
is @parents[1].WHAT, 'C()', 'second parent is C';

@parents = D.new.^parents(:local);
is +@parents, 2, 'right number of parents in list, from instance, :local, multiple inheritance';
is @parents[0].WHAT, 'B()', 'first parent is B';
is @parents[1].WHAT, 'C()', 'second parent is C';

@parents = D.^parents(:tree);
is +@parents, 2,         'with :tree, D has two immediate parents (on proto)';
ok @parents[0] ~~ Array, ':tree gives back nested arrays for each parent (on proto)';
ok @parents[1] ~~ Array, ':tree gives back nested arrays for each parent (on proto)';
is @parents.perl, ([B, [A, [Any, [Object]]]], [C, [A, [Any, [Object]]]]).perl,
                         ':tree gives back the expected data structure (on proto)';

@parents = D.new.^parents(:tree);
is +@parents, 2,         'with :tree, D has two immediate parents (on instance)';
ok @parents[0] ~~ Array, ':tree gives back nested arrays for each parent (on instance)';
ok @parents[1] ~~ Array, ':tree gives back nested arrays for each parent (on instance)';
is @parents.perl, ([B, [A, [Any, [Object]]]], [C, [A, [Any, [Object]]]]).perl,
                         ':tree gives back the expected data structure (on instance)';

@parents = List.^parents();
is +@parents, 2, 'right number of parents for List built-in, from proto-object';
is @parents[0].WHAT, 'Any()', 'first parent is Any';
is @parents[1].WHAT, 'Object()', 'second parent is Object';

@parents = list(1,2,3).^parents();
is +@parents, 2, 'right number of parents for List built-in, from instance';
is @parents[0].WHAT, 'Any()', 'first parent is Any';
is @parents[1].WHAT, 'Object()', 'second parent is Object';

@parents = Str.^parents();
is +@parents, 2, 'right number of parents for Str built-in, from proto-object';
is @parents[0].WHAT, 'Any()', 'first parent is Any';
is @parents[1].WHAT, 'Object()', 'second parent is Object';

@parents = "omg introspection!".^parents();
is +@parents, 2, 'right number of parents for Str built-in, from instance';
is @parents[0].WHAT, 'Any()', 'first parent is Any';
is @parents[1].WHAT, 'Object()', 'second parent is Object';

@parents = Object.^parents();
is +@parents, 0, 'Object has no parents (no params)';
@parents = Object.^parents(:local);
is +@parents, 0, 'Object has no parents (:local)';
@parents = Object.^parents(:tree);
is +@parents, 0, 'Object has no parents (:tree)';
