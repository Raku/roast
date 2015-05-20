use v6;
use Test;
plan 2;

# can't  use eval-lives-ok or eval-dies-ok here, because it runs
# the EVAL() in a different lexical scope, thus never finding lexical
# imports.

{
    use lib '.';
    use t::spec::packages::S11-modules::Foo;
    is foo(), 'Foo::foo', 'could import foo()';
}
dies-ok {EVAL('foo()') }, 'sub is only imported into the inner lexical scope';

# vim: ft=perl6
