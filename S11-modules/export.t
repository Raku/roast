use v6;

use lib $?FILE.IO.parent(2).add("packages");

use Test;

plan 56;

# L<S11/"Exportation"/>

sub exp_no_parens    is export                   { 'r_exp_no_parens' }
sub exp_empty_parens is export()                 { 'r_exp_empty_parens' }
sub exp_ALL          is export( :ALL )           { 'r_exp_ALL' }
sub exp_DEFAULT      is export( :DEFAULT )       { 'r_exp_DEFAULT' }
sub exp_ALL_DEFAULT  is export( :ALL, :DEFAULT ) { 'r_exp_ALL_DEFAULT' }
sub exp_MANDATORY    is export( :MANDATORY )     { 'r_exp_MANDATORY' }
sub exp_my_tag       is export( :my_tag )        { 'r_exp_my_tag' }


##  exp_no_parens
is( exp_no_parens(), 'r_exp_no_parens',
    'exp_no_parens() is defined' );
is( EXPORT::ALL::exp_no_parens(), 'r_exp_no_parens',
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


##  exp_MANDATORY
ok( &exp_MANDATORY === &EXPORT::ALL::exp_MANDATORY,
    'exp_MANDATORY -- values agree' );
ok( &exp_MANDATORY =:= &EXPORT::ALL::exp_MANDATORY,
    'exp_MANDATORY -- containers agree' );

ok( &exp_MANDATORY === &EXPORT::MANDATORY::exp_MANDATORY,
    'exp_MANDATORY -- values agree' );
ok( &exp_MANDATORY =:= &EXPORT::MANDATORY::exp_MANDATORY,
    'exp_MANDATORY -- containers agree' );

ok( ! &EXPORT::DEFAULT::exp_MANDATORY,
    'exp_MANDATORY -- EXPORT::DEFAULT::exp_MANDATORY does not exist' );


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
        sub Foo_exp_parens is export()  { 'r_Foo_exp_parens' }
    }

    ##  make sure each side isn't undefined
    #?rakudo 3 skip "export issue RT #125086"
    is( Foo::Foo_exp_parens(), 'r_Foo_exp_parens',
        'Foo_exp_parens() is defined' );
    is( Foo::Foo_exp_parens, 'r_Foo_exp_parens',
        'Can call Foo_exp_parens (without parens)' );
    is( Foo::Foo_exp_parens.(), 'r_Foo_exp_parens',
        'Can call Foo_exp_parens.()' );
    is( Foo::EXPORT::ALL::Foo_exp_parens(), 'r_Foo_exp_parens',
        'Foo_exp_parens() is defined' );

    #?rakudo 2 todo "export issue RT #125086"
    ok( &Foo::Foo_exp_parens === &Foo::EXPORT::ALL::Foo_exp_parens,
        'Foo_exp_parens() -- values agree' );
    ok( &Foo::Foo_exp_parens =:= &Foo::EXPORT::ALL::Foo_exp_parens,
        'Foo_exp_parens() -- containers agree' );
}

{
    class Bar {
        multi method bar ($baz = 'default') is export {
            return $baz;
        };
    }

    my $a = Bar.new;
    is($a.bar, "default", '$a.bar gets default value');
    is($a.bar("sixties"), "sixties", '$a.bar() gets passed value');
    #?rakudo skip "export issue"
    is(Bar::bar($a), "default", 'Bar::bar($a) gets default value');
    #?rakudo skip "export issue"
    is(Bar::bar($a, "moonlight"), "moonlight", 'Bar::bar($a, ) gets default value');
}

# RT #118501
{
    ok EXPORT::ALL ~~ EXPORT::<ALL>, 'EXPORT::ALL is identical to EXPORT::<ALL>';
    ok EXPORT::ALL:: ~~ Stash,       'EXPORT::ALL:: is a Stash that keeps exported symbols';
}

# RT #83354
{
    use RT83354_B;
    use RT83354_A;
    my $a = RT83354_B.new( :b( 5 ) ) + RT83354_B.new( :b( 2 ) );
    ok( $a ~~ RT83354_B && $a.b == 7, "multi imports don't conflict" );
}

# RT #84280
{
    use RT84280;
    throws-like { bar { 1 } }, X::Multi::NoMatch,
        message => /'none of these signatures match'/,
        'adequate error message when multi sub exported out of a module fails to bind to an argument that happens to be a block';
}

# RT #125715
{
    use RT125715;

    my class Baz {
        has Bar $.bar;
    }

    lives-ok { Baz.new(bar => Bar.new) },
        'Using EXPORT-d type as attribute type works';
}

# vim: ft=perl6

# RT #129215
{
    use RT129215;
    ok str_d("foo"), 'Str:D istype across module seam';
    ok str_u(Str), 'Str:D istype across module seam';
    ok str_u(Str:U), 'Str:D istype across module seam';
    #?rakudo.jvm 3 todo 'RT#129215'
    ok array_str(Array[Str].new("A","B")), 'Array[Str] istype across module seam';
    ok hash_str(Hash[Str].new({ak => "ak"})), 'Hash[Str] istype across module seam';
    ok hash_hash_str(Hash[Hash[Str]].new({akk => { ak => "ak" }})), 'Hash[Hash[Str]] istype across module seam';

    #?rakudo 3 todo 'Containers parameterized with define type fail istype RT#129215'
    ok array_str_d(Array[Str:D].new("A","B")), 'Array[Str:D] istype across module seam';
    ok hash_str_d(Hash[Str:D].new({ak => "ak"})), 'Hash[Str:D] istype across module seam';
    ok hash_hash_str_d(Hash[Hash[Str:D]].new({akk => { ak => "ak" }})), 'Hash[Hash[Str:D]] istype across module seam';
    #?rakudo.jvm 6 todo 'RT#129215'
    ok array_str_u(Array[Str:U].new(Str,Str)), 'Array[Str:U] istype across module seam (Str)';
    ok hash_str_u(Hash[Str:U].new({ak => Str})), 'Hash[Str:U] istype across module seam (Str)';
    ok hash_hash_str_u(Hash[Hash[Str:U]].new({akk => { ak => Str }})), 'Hash[Hash[Str:U]] istype across module seam (Str)';
    ok array_str_u(Array[Str:U].new(Str:U,Str:U)), 'Array[Str:U] istype across module seam';
    ok hash_str_u(Hash[Str:U].new({ak => Str:U})), 'Hash[Str:U] istype across module seam';
    ok hash_hash_str_u(Hash[Hash[Str:U]].new({akk => { ak => Str:U }})), 'Hash[Hash[Str:U]] istype across module seam';
}
