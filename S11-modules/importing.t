use v6;

use lib $?FILE.IO.parent(2).add("packages");

use Test;

plan 17;

# L<S11/"Compile-time Importation"/>

{
    use S11-modules::Foo;

    ok( &foo, 'Foo::foo is defined (explicitly :DEFAULT)' );
    is( foo(), 'Foo::foo', 'Foo::foo is the sub we expect' );

    ok( &bar, 'Foo::bar is defined (explicitly :DEFAULT and :others)' );
    is( bar(), 'Foo::bar', 'Foo::bar is the sub we expect' );

    ok( &baz, 'Foo::baz is defined (:MANDATORY)' );
    is( baz(), 'Foo::baz', 'Foo::baz is the sub we expect' );

    ok( &bop, 'Foo::bop is defined (implicitly :DEFAULT)' );
    is( bop(), 'Foo::bop', 'Foo::bop is the sub we expect' );

    multi waz($x) { 'Foo::wazhere' }   #OK not used
    ok( &waz, 'Foo::waz multi is defined (implicitly :DEFAULT)' );
    is( waz(), 'Foo::waz', 'Foo::waz is the sub we expect' );
    is( waz(1), 'Foo::wazhere', 'Foo::waz imported does not wipe out our other waz multis' );

    dies-ok { EVAL 'qux()' }, 'qux() not imported';
    dies-ok { EVAL 'gaz()' }, 'gaz() not imported';
}

dies-ok( { EVAL '&foo' }, 'Foo::foo is undefined in outer scope' );

{
    class TestImportInClass {
        use A::B;
        method doit {
            A::B::D.new();
        }
    }
    lives-ok { TestImportInClass.doit() },
             "can instantiate class that's loaded from inside another class";

}

{
    lives-ok {
        use S11-modules::ExportsEnumDate;
    }
}

# RT #125846
throws-like 'use S11-modules::Foo :NoSucTag;', X::Import::NoSuchTag,
                :source-package<S11-modules::Foo>,
                :tag<NoSucTag>,
             'die while trying to import a non-existent export tag';

# vim: ft=perl6
