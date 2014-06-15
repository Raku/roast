# http://perl6advent.wordpress.com/2011/12/14/meta-programming-what-why-and-how/
use v6;
use Test;
plan 8;

use lib 't/spec/packages';
use Advent::SingleInheritance;

lives_ok {EVAL q:to"--END--"}, 'single inheritance (lives)';
class A1 { }
class B1 is A1 { }
--END--

lives_ok {EVAL q:to"--END--"}, 'multiple inheritance (dies)';
class A { }
class B { }
class C is A is B { }
--END--

use Advent::MetaBoundaryAspect;

class LoggingAspect is MethodBoundaryAspect {
    method entry($method, $obj, $args) {
        pass "Called $method with $args";
    }
    method exit($method, $obj, $args, $result) {
        pass "$method returned with $result.perl()";
    }
}
class Example is LoggingAspect {
    method double($x) { $x * 2 }
    method square($x) { $x ** 2 }
}
is Example.double(3), 6, 'aop';
is Example.square(3), 9, 'aop';

