use v6;
use Test;

use lib $?FILE.IO.parent(2).add("packages/AandB/lib");
use lib $?FILE.IO.parent(2).add("packages/S11-modules/lib");

plan 18;

# L<S11/"Compile-time Importation"/>

{
    use Foo;

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
        use ExportsEnumDate;
    }
}

#?rakudo.js.browser skip "EVAL time use doesn't work in the browser"
# https://github.com/Raku/old-issue-tracker/issues/4483
throws-like 'use Foo :NoSucTag;', X::Import::NoSuchTag,
                :source-package<Foo>,
                :tag<NoSucTag>,
             'die while trying to import a non-existent export tag';

# GH rakudo/rakudo#3116
eval-lives-ok q<use NoPrecompilation;>, "`use` of module with `no precompilation` inside EVAL";

# vim: expandtab shiftwidth=4
