use v6;
use Test;

# L<S02/Literals/"There are no barewords in Perl 6. An undeclared bare
# identifier will always be taken to mean a subroutine name. ">

plan 5;

eval_dies_ok 'class A { }; class A { }', "Can't redeclare a class";
#?rakudo todo 'redeclaration of stubbed classes'
eval_lives_ok 'class G { ... }; class G { }', 'can redeclare stub classes';
eval_dies_ok 'class B is C { }', "Can't inherit from a non-existing class";
eval_dies_ok 'class D does E { }', "Can't do a non-existing role";
eval_dies_ok 'my F $x;', 'Unknown types in type constraints are an error';


# vim: ft=perl6
