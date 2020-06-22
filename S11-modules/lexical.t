use v6;
use Test;

use lib $?FILE.IO.parent(2).child("packages/S11-modules/lib");

plan 3;

{
    use Foo;
    is foo(), 'Foo::foo', 'could import foo()';
}
dies-ok {EVAL('foo()') }, 'sub is only imported into the inner lexical scope';

{
    use EmptyClass;
    my EmptyClass $foo;
}
dies-ok {EVAL('my EmptyClass $bar')}, 'Package is only imported into the inner lexical scope';

# vim: expandtab shiftwidth=4
