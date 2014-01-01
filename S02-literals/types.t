use v6;
use Test;

# L<S02/Bare identifiers/"There are no barewords in Perl">

plan 7;

eval_dies_ok 'class A { }; class A { }', "Can't redeclare a class";
eval_lives_ok 'class G { ... }; class G { }', 'can redeclare stub classes';
eval_dies_ok 'class B is C { }', "Can't inherit from a non-existing class";
eval_dies_ok 'class D does E { }', "Can't do a non-existing role";
eval_dies_ok 'my F $x;', 'Unknown types in type constraints are an error';

# integration tests - in Rakudo some class names from Parrot leaked through,
# so you couldn't name a class 'Task' - RT #61128

eval_lives_ok 'class Task { has $.a }; Task.new(a => 3 );',
              'can call a class "Task" - RT 61128';

# L<S02/Bare identifiers/If a postdeclaration is not seen, the compile fails at CHECK
# time>

eval_dies_ok q[caffeine(EVAL('sub caffeine($a){~$a}'))],
        'Post declaration necessary';

# vim: ft=perl6

