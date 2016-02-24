use v6.c;
use Test;
plan 2;

{
    use lib '.';
    use t::spec::packages::S11-modules::Foo;
    is foo(), 'Foo::foo', 'could import foo()';
}
dies-ok {EVAL('foo()') }, 'sub is only imported into the inner lexical scope';

# vim: ft=perl6
