use v6;
use Test;
plan 13;

# L<S11/Importing without loading>

# TODO: add tagged import testing

{
    module A {
        sub Afoo() is export { 'sub A::Afoo' };
        sub Abar()           { 'sub A::Abar' };
        constant pub is export = 42;
        constant priv          = 23;
    }
    import A;

    is Afoo(), 'sub A::Afoo', 'import imports things marked as "is export"';
    dies_ok {eval(q{ Abar() })}, "doesn't import non-exported routines";
    is pub, 42, 'can import constants';
    dies_ok { eval 'priv' }, 'cannot access non-exported constants';
}

#?rakudo skip 'import plus inline module'
{
    import (module B {
        sub Bfoo() is export { 'sub B::Bfoo' };
        sub Bbar()           { 'sub B::Bbar' };
    });

    is Bfoo(), 'sub B::Bfoo', 'impporting from inline module';
    dies_ok {eval(q{ Bbar() })}, "not importing not-exported routines";
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

#?rakudo skip 'import plus inline module'
{
    import (module D {
        sub Dfoo() is export { 'sub D::Dfoo' };
        sub Dbar() is export { 'sub D::Dbar' };
    });

    is Dfoo(), 'sub D::Dfoo',
       'import imports things implicitly from inlined module';
    is Dbar(), 'sub D::Dbar',
       'import imports more things implicitly from inlined module';
}

{
    module E {
        sub e1 is export(:A) { 'E::e1' }
        sub e2 is export(:B) { 'E::e2' }
    }
    import E :B;
    dies_ok { eval 'e1' }, 'importing by tag is sufficiently selective';
    is e2(), 'E::e2',      'importing by tag';
    {
        import E :ALL;
        is e1() ~ e2(), 'E::e1E::e2', 'import :ALL';
    }
}

# vim: ft=perl6
