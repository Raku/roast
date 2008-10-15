use v6;
use Test;

plan 25;

# L<S11/"Exportation"/>

sub exp_no_parens is export                      { 'exp_no_parens' }
sub exp_empty_parens is export()                 { 'exp_empty_parens' }
sub exp_ALL is export( :ALL )                    { 'exp_ALL' }
sub exp_DEFAULT is export( :DEFAULT )            { 'exp_DEFAULT' }
sub exp_ALL_DEFAULT is export( :ALL, :DEFAULT )  { 'exp_ALL_DEFAULT' }
sub exp_my_tag is export( :my_tag )              { 'exp_my_tag' }


##  exp_no_parens
is( exp_no_parens(), 'exp_no_parens',
    'exp_no_parens() is defined' );
is( EXPORT::ALL::exp_no_parens(), 'exp_no_parens',
    'EXPORT::ALL::exp_no_parens() is defined' );

ok( &exp_no_parens === &EXPORT::ALL::exp_no_parens,
    'exp_no_parens -- values agree' );
ok( &exp_no_parens =:= &EXPORT::ALL::exp_no_parens,
    'exp_no_parens -- containers agree' );


##  exp_empty_parens
ok( &exp_empty_parens === &EXPORT::ALL::exp_empty_parens,
    'exp_empty_parens -- values agree' );
ok( &exp_empty_parens =:= &EXPORT::ALL::exp_empty_parens,
    'exp_empty_parens -- containers agree' );


##  exp_ALL
ok( &exp_ALL === &EXPORT::ALL::exp_ALL,
    'exp_ALL -- values agree' );
ok( &exp_ALL =:= &EXPORT::ALL::exp_ALL,
    'exp_ALL -- containers agree' );


##  exp_DEFAULT
ok( &exp_DEFAULT === &EXPORT::ALL::exp_DEFAULT,
    'exp_DEFAULT -- values agree' );
ok( &exp_DEFAULT =:= &EXPORT::ALL::exp_DEFAULT,
    'exp_DEFAULT -- containers agree' );

ok( &exp_DEFAULT === &EXPORT::DEFAULT::exp_DEFAULT,
    'exp_DEFAULT -- values agree' );
ok( &exp_DEFAULT =:= &EXPORT::DEFAULT::exp_DEFAULT,
    'exp_DEFAULT -- containers agree' );


##  exp_ALL_DEFAULT
ok( &exp_ALL_DEFAULT === &EXPORT::ALL::exp_ALL_DEFAULT,
    'exp_ALL_DEFAULT -- values agree' );
ok( &exp_ALL_DEFAULT =:= &EXPORT::ALL::exp_ALL_DEFAULT,
    'exp_ALL_DEFAULT -- containers agree' );

ok( &exp_ALL_DEFAULT === &EXPORT::DEFAULT::exp_ALL_DEFAULT,
    'exp_ALL_DEFAULT -- values agree' );
ok( &exp_ALL_DEFAULT =:= &EXPORT::DEFAULT::exp_ALL_DEFAULT,
    'exp_ALL_DEFAULT -- containers agree' );


##  exp_my_tag
ok( &exp_my_tag === &EXPORT::ALL::exp_my_tag,
    'exp_my_tag -- values agree' );
ok( &exp_my_tag =:= &EXPORT::ALL::exp_my_tag,
    'exp_my_tag -- containers agree' );

ok( &exp_my_tag === &EXPORT::my_tag::exp_my_tag,
    'exp_my_tag -- values agree' );
ok( &exp_my_tag =:= &EXPORT::my_tag::exp_my_tag,
    'exp_my_tag -- containers agree' );

ok( ! &EXPORT::DEFAULT::exp_my_tag,
    'exp_my_tag -- EXPORT::DEFAULT::exp_my_tag does not exist' );


{
    package Foo {
        sub Foo_exp_parens is export()  { 'Foo_exp_parens' }
    }

    ##  make sure each side isn't undef
    is( Foo::Foo_exp_parens(), 'Foo_exp_parens',
        'Foo_exp_parens() is defined' );
    is( Foo::EXPORT::ALL::Foo_exp_parens(), 'Foo_exp_parens',
        'Foo_exp_parens() is defined' );

    ok( &Foo::Foo_exp_parens === &Foo::EXPORT::ALL::Foo_exp_parens,
        'Foo_exp_parens() -- values agree' );
    ok( &Foo::Foo_exp_parens =:= &Foo::EXPORT::ALL::Foo_exp_parens,
        'Foo_exp_parens() -- containers agree' );
}
