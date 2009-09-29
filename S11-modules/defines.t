use v6;
use Test;
plan 8;

# L<S11/Importing without loading>

# TODO: add tagged import testing

{
    module A {
        sub Afoo() is export { 'sub A::Afoo' };
        sub Abar() is export { 'sub A::Abar' };
    }
    import A <Afoo>;

    is Afoo(), 'sub A::Afoo', 'import imports things explicitly from named module';
    eval_dies_ok q{ Abar() }, "doesn't import non-requested exports";
}

{
    import (module B {
        sub Bfoo() is export { 'sub B::Bfoo' };
        sub Bbar() is export { 'sub B::Bbar' };
    }) <Bfoo>;

    is Bfoo(), 'sub B::Bfoo',
       'import imports things explicitly from inlined module';
    eval_dies_ok q{ Bbar() }, "doesn't import non-requested exports";
}

{
    module C {
        sub Cfoo() is export { 'sub C::Cfoo' };
        sub Cbar() is export { 'sub C::Cbar' };
    }
    import C;

    is Cfoo(), 'sub C::Cfoo',
       'import imports things implicitly from named module';
    is Cbar(), 'sub C::Cbar',
       'import imports more things implicitly from named module';
}

{
    import module D {
        sub Dfoo() is export { 'sub D::Dfoo' };
        sub Dbar() is export { 'sub D::Dbar' };
    }

    is Dfoo(), 'sub D::Dfoo',
       'import imports things implicitly from inlined module';
    is Dbar(), 'sub D::Dbar',
       'import imports more things implicitly from inlined module';
}

# vim: ft=perl6
