use v6;

use lib '.';

use Test;
plan 3;

{
    use t::spec::packages::S11-modules::Foo;
    is foo(), 'Foo::foo', 'could import foo()';
}
dies-ok {EVAL('foo()') }, 'sub is only imported into the inner lexical scope';

{
    use t::spec::packages::S11-modules::EmptyClass;
    my EmptyClass $foo;
}
dies-ok {EVAL('my EmptyClass $bar')}, 'Package is only imported into the inner lexical scope';

# vim: ft=perl6
