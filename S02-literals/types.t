use v6;
use Test;

# L<S02/Bare identifiers/"There are no barewords in Perl">

plan 7;

throws_like { EVAL 'class A { }; class A { }' },
  X::Redeclaration,
  "Can't redeclare a class";
lives_ok { EVAL 'class G { ... }; class G { }' },
  'can redeclare stub classes';
throws_like { EVAL 'class B is C { }' },
  X::Inheritance::UnknownParent,
  "Can't inherit from a non-existing class";
throws_like { EVAL 'class D does E { }' },
  X::Comp::AdHoc,
  "Can't do a non-existing role";
throws_like { EVAL 'my F $x;' },
  X::Comp::Group,
  'Unknown types in type constraints are an error';

# integration tests - in Rakudo some class names from Parrot leaked through,
# so you couldn't name a class 'Task' - RT #61128

lives_ok { EVAL 'class Task { has $.a }; Task.new(a => 3 );' },
  'can call a class "Task" - RT 61128';

# L<S02/Bare identifiers/If a postdeclaration is not seen, the compile fails at CHECK
# time>

throws_like { EVAL q[caffeine(EVAL('sub caffeine($a){~$a}'))] },
  X::AdHoc,
  'Post declaration necessary';

# vim: ft=perl6

