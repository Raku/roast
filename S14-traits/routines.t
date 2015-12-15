use v6;
use Test;

plan 16;

# L<S14/Traits/>
{
    role description {
        has $.description is rw;
    }

    multi trait_mod:<is>(Routine $code, description,  $arg) {
        $code does description($arg)
    }
    multi trait_mod:<is>(Routine $code, description) {
        $code does description('missing description!')
    }
    multi trait_mod:<is>(Routine $code, Str :$described!) {
        $code does description($described);
    }
    multi trait_mod:<is>(Routine $code, Bool :$described!) {
        $code does description("missing description!");
    }


    sub answer() is description('computes the answer') { 42 }
    sub faildoc() is description { "fail" }
    is answer(), 42, 'can call sub that has had a trait applied to it by role name with arg';
    is &answer.description, 'computes the answer',  'description role applied and set with argument';
    is faildoc(), "fail", 'can call sub that has had a trait applied to it by role name without arg';
    is &faildoc.description, 'missing description!', 'description role applied without argument';

    sub cheezburger is described("tasty") { "nom" }
    sub lolcat is described { "undescribable" }

    is cheezburger(), "nom", 'can call sub that has had a trait applied to it by named param with arg';
    is &cheezburger.description, 'tasty',  'named trait handler applied other role set with argument';
    is lolcat(), "undescribable", 'can call sub that has had a trait applied to it by named param without arg';
    is &lolcat.description, 'missing description!', 'named trait handler applied other role without argument';
}

{
    my $recorder = '';
    multi trait_mod:<is>(Routine $c, :$woowoo!) {
        $c.wrap: sub {
            $recorder ~= 'wrap';
        }
    }
    sub foo is woowoo { };
    lives-ok &foo, 'Can call subroutine that was wrapped by a trait';
    #?rakudo todo 'trait mod / .wrap interaction'
    is $recorder, 'wrap', 'and the wrapper has been called once';
}

# RT #112664
{
    multi trait_mod:<is>(Routine $m, :$a!) {
	multi y(|) { my $x = $m }   #OK not used
	$m.wrap(&y)
    }
    sub rt112664 is a {}

    lives-ok { rt112664 },
    '[BUG] multi without proto gets wrong lexical lookup chain (RT #112664)';
}

# RT #74092
{
    try { EVAL 'sub yulia is krassivaya { }' };
    diag $!
      if !ok "$!" ~~ /'unknown trait'/,
        'declaration of a sub with an unknown trait mentions trait_mod:<is> in dispatch error';
}

{
    multi trait_mod:<is>(Routine $r, :$trait_that_wraps!) {
        $r.wrap(-> |c { 2 * callsame; })
    }
    sub wrappee($a, $b) is trait_that_wraps { 42 };
    is wrappee(1, 2), 84, 'wrapping a routine at compile time makes it soft';
}

{
    multi trait_mod:<is>(Routine $r, :$test_trait!) {
        $r does role { #`( I only came for the type change ) }
    }
    my class A {
        submethod m() is test_trait { 42 }
    }
    my class B is A { }
    is A.m, 42, 'Applying traits to submethods works';
    throws-like { B.m }, X::Method::NotFound,
        'Applying traits to submethods retains submethod semantics';
}

# RT #112666
# Note: it's important this test stays in its nested block, not in the test
# mainline, as there was a bug that was hidden in the case it was in the
# mainline.
{
    my role R {
        has @.s is rw
    }
    multi trait_mod:<is>(Routine $r, :$x!) {
        $r does R;
        sub h(|){ for $r.s { &^m() } }
        $r.wrap(&h)
    };
    sub b is x {};
    my $called = False;
    push &b.s, { $called = True };
    b;
    ok $called, 'interaction of mixin to routine with array attribute and wrap is correct';
}

# vim: ft=perl6
