use v6;
use Test;
plan 2;

# L<S11/Importing without loading>

{
    module A {
        sub Afoo() { 'sub A::Afoo' };
    }
    A defines <Afoo>;

    is Afoo(), 'sub A::Afoo', 'infix:<defines> imports things';
}

{
    module B {
        sub Bfoo() { 'sub B::Bfoo' };
    } defines <Bfoo>;

    is Bfoo(), 'sub B::Bfoo',
       'infix:<defines> imports things (directly on module)';
}

# vim: ft=perl6
