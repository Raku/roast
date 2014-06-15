# http://perl6advent.wordpress.com/2011/12/14/meta-programming-what-why-and-how/
use v6;
use Test;
plan 2;

use lib 't/spec/packages';
use Advent::SingleInheritance;

lives_ok {EVAL q:to"--END--"}, 'single inhertance (lives)';
class A1 { }
class B1 is A1 { }
--END--

lives_ok {EVAL q:to"--END--"}, 'multiple inhertance (dies)';
class A { }
class B { }
class C is A is B { }
--END--

