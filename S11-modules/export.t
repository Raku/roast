use v6;
use Test;

plan 8;

# L<S11/"Exportation"/>

sub exp_no_parens is export             { 'exp_no_parens' }


##  make sure each side isn't undef
is( exp_no_parens(), 'exp_no_parens',
    'exp_no_parens() is defined' );
is( EXPORT::ALL::exp_no_parens(), 'exp_no_parens',
    'EXPORT::ALL::exp_no_parens() is defined' );
##  two out of two values agree
ok( &exp_no_parens === &EXPORT::ALL::exp_no_parens,
    'sub bound to ::EXPORT::ALL inner module -- values match' );
##  two out of two containers agree
#?rakudo skip 'infix:<=:=> not implemented'
ok( &exp_no_parens =:= &EXPORT::ALL::exp_no_parens,
    'sub bound to ::EXPORT::ALL inner module -- containers match' );

{
    package Foo {
        sub Foo_exp_parens is export()  { 'Foo_exp_parens' }
    }

    ##  make sure each side isn't undef
    is( Foo::Foo_exp_parens(), 'Foo_exp_parens',
        'Foo_exp_parens() is defined' );
    is( Foo::EXPORT::ALL::Foo_exp_parens(), 'Foo_exp_parens',
        'Foo_exp_parens() is defined' );
    ##  two out of two values agree
    ok( &Foo::Foo_exp_parens === &Foo::EXPORT::ALL::Foo_exp_parens,
        'Foo_exp_parens() matches Foo::EXPORT::ALL::Foo_exp_parens -- values match' );
    ##  two out of two containers agree
#?rakudo skip 'infix:<=:=> not implemented'
    ok( &Foo::Foo_exp_parens =:= &Foo::EXPORT::ALL::Foo_exp_parens,
        'Foo_exp_parens() container matches Foo::EXPORT::ALL::Foo_exp_parens -- containers match' );
}
