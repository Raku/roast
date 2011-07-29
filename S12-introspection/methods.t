use v6;

use Test;

plan 49;

=begin pod

Tests for .^methods from L<S12/Introspection>.

=end pod

# L<S12/Introspection/"get the method list of MyClass">

class A {
    method foo($param --> Any) { }   #OK not used
    multi method bar($thingy) { }   #OK not used
    multi method bar($thingy, $other_thingy) { }   #OK not used
}
class B is A {
    method foo($param) of Num { }   #OK not used
}
class C is A {
}
class D is B is C {
    multi method bar($a, $b, $c) { }   #OK not used
    method foo($param) returns Int { }   #OK not used
}

my (@methods, $meth1, $meth2);

@methods = C.^methods(:local);
is +@methods, 0, 'class C has no local methods (proto)';

@methods = C.new().^methods(:local);
is +@methods, 0, 'class C has no local methods (instance)';

@methods = B.^methods(:local);
is +@methods, 1, 'class B has one local methods (proto)';
is @methods[0].name(), 'foo', 'method name can be found';
ok @methods[0].signature.perl ~~ /'$param'/, 'method signature contains $param';
is @methods[0].returns, Num, 'method returns a Num (from .returns)';
is @methods[0].of, Num, 'method returns a Num (from .of)';
ok !@methods[0].multi, 'method is not a multimethod';

@methods = B.new().^methods(:local);
is +@methods, 1, 'class B has one local methods (instance)';
is @methods[0].name(), 'foo', 'method name can be found';
ok @methods[0].signature.perl ~~ /'$param'/, 'method signature contains $param';
is @methods[0].returns, Num, 'method returns a Num (from .returns)';
is @methods[0].of, Num, 'method returns a Num (from .of)';
ok !@methods[0].multi, 'method is not a multimethod';

@methods = A.^methods(:local);
is +@methods, 2, 'class A has two local methods (one only + one multi with two variants)';
my ($num_multis, $num_onlys);
for @methods -> $meth {
    if $meth.name eq 'foo' {
        $num_onlys++;
        ok !$meth.multi, 'method foo is not a multimethod';
    } elsif $meth.name eq 'bar' {
        $num_multis++;
        ok $meth.multi, 'method bar is a multimethod';
    }
}
is $num_onlys, 1, 'class A has one only method';
is $num_multis, 1, 'class A has one multi methods';

@methods = D.^methods();
ok +@methods > 5, 'got all methods in hierarchy plus more from Any/Mu';
ok @methods[0].name eq 'foo' && @methods[1].name eq 'bar' ||
   @methods[0].name eq 'bar' && @methods[1].name eq 'foo',
   'first two methods from class D itself';
is @methods[2].name, 'foo', 'method from B has correct name';
is @methods[2].of, Num, 'method from B has correct return type';
ok @methods[3].name eq 'foo' && @methods[4].name eq 'bar' ||
   @methods[3].name eq 'bar' && @methods[4].name eq 'foo',
   'two methods from class A itself';

@methods = D.^methods(:tree);
is +@methods, 4, ':tree gives us right number of elements';
ok @methods[0].name eq 'foo' && @methods[1].name eq 'bar' ||
   @methods[0].name eq 'bar' && @methods[1].name eq 'foo',
   'first two methods from class D itself';
is @methods[2].WHAT.gist, Array.gist, 'third item is an array';
is +@methods[2], 2, 'nested array for B had right number of elements';
is @methods[3].WHAT.gist, Array.gist, 'forth item is an array';
is +@methods[3], 1, 'nested array for C had right number of elements';
is @methods[2], B.^methods(:tree), 'nested tree for B is correct';
is @methods[3], C.^methods(:tree), 'nested tree for C is correct';

@methods = List.^methods();
ok +@methods > 0, 'can get methods for List (proto)';
@methods = (1, 2, 3).^methods();
ok +@methods > 0, 'can get methods for List (instance)';

@methods = Str.^methods();
ok +@methods > 0, 'can get methods for Str (proto)';
@methods = "i can haz test pass?".^methods();
ok +@methods > 0, 'can get methods for Str (instance)';

ok +List.^methods() > +Any.^methods(), 'List has more methods than Any';
ok +Any.^methods() > +Mu.^methods(), 'Any has more methods than Mu';

ok +(D.^methods>>.name) > 0, 'can get names of methods in and out of our own classes';
ok D.^methods.perl, 'can get .perl of output of .^methods';

class PT1 {
    method !pm1() { }
    method foo() { }
}
class PT2 is PT1 {
    method !pm2() { }
    method bar() { }
}

@methods = PT2.^methods();
is @methods[0].name, 'bar',    'methods call found public method in subclass';
is @methods[1].name, 'foo',    'methods call found public method in superclass (so no privates)';
ok @methods[2].name ne '!pm1', 'methods call did not find private method in superclass';

@methods = PT2.^methods(:private);
ok @methods[0].name eq '!pm2' || @methods[1].name eq '!pm2', 
                            'methods call with :private found private method in subclass';
ok @methods[2].name eq '!pm1' || @methods[3].name eq '!pm1', 
                            'methods call with :private found private method in superclass';

@methods = PT2.^methods(:local);
is +@methods, 1,            'methods call without :private omits private methods (with :local)';
is @methods[0].name, 'bar', 'methods call found public method in subclass (with :local)';

@methods = PT2.^methods(:local, :private);
is +@methods, 2,            'methods call with :private includes private methods (with :local)';
ok @methods[0].name eq '!pm2' || @methods[1].name eq '!pm2', 
                            'methods call with :private found private method in subclass (with :local)';

# vim: ft=perl6
