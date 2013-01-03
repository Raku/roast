use v6;
use Test;
BEGIN { @*INC.push('t/spec/packages/') };
use Test::Util;

plan 17;

# L<S11/Importing without loading>

# without protos
{
    module A {
        multi sub Afoo( Int $a ) is export { 'sub A::Afoo Int' };
        multi sub Abar( Int $a )           { 'sub A::Abar Int' };
    }
    import A;

    is Afoo( 7 ), 'sub A::Afoo Int', 'A) merge multis without protos';
    dies_ok { eval 'Abar( 7 )' },    "A) doesn't import non-exported multis";
    dies_ok { eval 'Afoo( "a" )' },  "A) doesn't dispatch to wrong signature";
}

# with proto in module
{
    module B {
        proto sub Bfoo( Mu )     is export { * };
        multi sub Bfoo( Int $a ) is export { 'sub B::Bfoo Int' };
    }
    import B;

    is Bfoo( 7 ), 'sub B::Bfoo Int', 'B) merge multis with proto in module';
}

# with proto before import
{
    proto sub Cfoo( Mu ) { * };
    multi sub Cfoo( Str $a ) { 'sub C::Cfoo Str' };
    module C {
        multi sub Cfoo( Int $a ) is export { 'sub C::Cfoo Int' };
    }
    import C;

    is Cfoo( 7 ),   'sub C::Cfoo Int', 'C) merge multis with proto before import';
    is Cfoo( 'a' ), 'sub C::Cfoo Str', 'C) our multi is still there';
}

# with proto after import
{
    module D {
        multi sub Dfoo( Int $a ) is export { 'sub D::Dfoo Int' };
    }
    import D;
    #?rakudo skip "it just dies, can't check using throws_like"
    throws_like 'proto sub Dfoo( Mu ) { * }', X::Redeclaration, symbol => 'Dfoo';

    multi sub Dfoo( Str $a ) { 'sub D::Dfoo Str' };

    is Dfoo( 7 ),   'sub D::Dfoo Int', 'D) merge multis with proto after import';
    is Dfoo( 'a' ), 'sub D::Dfoo Str', 'D) our multi is still there';
}

# with proto before import and in module
{
    proto sub Efoo( Mu ) { * };
    multi sub Efoo( Str $a ) { 'sub E::Efoo Str' };
    module E {
        proto sub Efoo( Mu )     is export { * };
        multi sub Efoo( Int $a ) is export { 'sub E::Efoo Int' };
    }
    import E;

    is Efoo( 7 ),   'sub E::Efoo Int', 'E) merge multis with proto before import and in module';
    is Efoo( 'a' ), 'sub E::Efoo Str', 'E) our multi is still there';
}

# with proto after import and in module
{
    module F {
        proto sub Ffoo( Mu )     is export { * };
        multi sub Ffoo( Int $a ) is export { 'sub F::Ffoo Int' };
    }
    import F;
    #?rakudo skip "it just dies, can't check using throws_like"
    throws_like 'proto sub Ffoo( Mu ) { * }', X::Redeclaration, symbol => 'Ffoo';
    multi sub Ffoo( Str $a ) { 'sub F::Ffoo Str' };

    is Ffoo( 7 ),   'sub F::Ffoo Int', 'F) merge multis with proto after import and in module';
    is Ffoo( 'a' ), 'sub F::Ffoo Str', 'F) our multi is still there';
}

#?rakudo skip 'A symbol "&Gfoo" has already been exported'
{
    module G1 {
        multi sub Gfoo( Int $a ) is export { 'sub G1::Gfoo Int' };
    }
    import G1;

    module G2 {
        multi sub Gfoo( Str $a ) is export { 'sub G2::Gfoo Str' };
    }
    import G2;

    is Gfoo( 7 ), 'sub G::Gfoo', 'G) merge multis';
}

# trait_mod:<is>
{
    role Awesome-Things { };
    multi trait_mod:<is> ( Routine $r, :$awesome! ) { $r does Awesome-Things };

    module H {
        sub Hfoo is awesome is export {
            'sub H::Hfoo'
        };
    }
    import H;

    ok &Hfoo ~~ Awesome-Things, 'H) trait "is awesome" applied';
    is Hfoo(), 'sub H::Hfoo',   'H) standard traits like "is export" still work';
}

# vim: ft=perl6
