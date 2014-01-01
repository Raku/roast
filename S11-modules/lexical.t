use v6;
use Test;
plan 2;

# can't  use eval_lives_ok or eval_dies_ok here, because it runs
# the EVAL() in a different lexical scope, thus never finding lexical
# imports.

{
    use t::spec::packages::S11-modules::Foo;
    is foo(), 'Foo::foo', 'could import foo()';
}
dies_ok {EVAL('foo()') }, 'sub is only imported into the inner lexical scope';

# vim: ft=perl6
