use Test;

plan 17;

# TODO: move to S02?
# L<S02/Generic types/>

# Check it captures built-in types.
sub basic_capture(::T $x) { T }   #OK not used
isa-ok(basic_capture(42),  Int, 'captured built-in type');
isa-ok(basic_capture(4.2), Rat, 'captured built-in type');

# User defined ones too.
class Foo { }
isa-ok(basic_capture(Foo.new), Foo, 'captured user defined type');

# Check you can use captured type later in the signature.
sub two_the_same(::T $x, T $y) { 1 }   #OK not used
ok(two_the_same(42, 42), 'used captured type later in the sig');
my $ok = 1;
try {
    two_the_same(42, 4.2);
    $ok = 0;
}
ok($ok, 'used captured type later in the sig');

# Check you can use them to declare variables.
sub declare_cap_type(::T $x) {   #OK not used
    my T $y = 4.2;   #OK not used
    1
}
ok(declare_cap_type(3.3), 'can use captured type in declaration');
$ok = 1;
try {
    declare_cap_type(42);
    $ok = 0;
}
ok($ok, 'can use captured type in declaration');

# https://github.com/Raku/old-issue-tracker/issues/2833
eval-lives-ok q':(::T $x)', "No error on type capture";

# https://github.com/Raku/old-issue-tracker/issues/4375
{
    my sub foo(::T) {
        {
            my T $b;
            is $b, Int, 'Type capture works on variable in nested scope';
        }
    }
    foo(1)
}

# https://github.com/Raku/old-issue-tracker/issues/2886
{
    my sub f (::T $g) {
        for ($g) -> T $h {
            return $h ~ ":" ~ T.raku
        }
    };
    is f("blah"), "blah:Str", 'Type variable matches in signature to "for" loop';
}

# https://github.com/Raku/old-issue-tracker/issues/4657
{
    my sub accum( ::T \a, T(Cool) \b ) { a += b };

    my $t = 3;
    accum( $t, 2/3 );
    is $t, 3, 'coerce to Int via type capture';

    $t = 3.0;
    accum( $t, 2/3 );
    is-approx $t, 3.666667, 'coerce to Rat via type capture';
}

# https://github.com/rakudo/rakudo/issues/2169
{
    my sub f1_2169 (::T $type) {
        my T $t;
        $t.VAR.default;
    }

    isa-ok f1_2169( Int ), Int, "default is instantiated from a type object";
    isa-ok f1_2169( "The Answer" ), Str, "default is instantiated from a concrete object type";

    my sub f2_2169(::T \type) {
        my T $t;
        $t = Nil;
        $t;
    }
    my $type;
    lives-ok { $type = f2_2169(Rat) }, "it's ok to assign Nil to a variable of a captured type";
    isa-ok $type, Rat, "reset to default sets varible to captured type";

}

# Make sure typecapture can be used as return type
subtest "Return typecheck" => {
    plan 15;

    my sub ret_T(::T \t, $v --> T) {
        $v
    }

    my $rv;

    lives-ok { ret_T(Int, 42) }, "basic return type check works";
    lives-ok { ret_T(Int:D, 42) }, "basic return type check works with definite";
    lives-ok { ret_T(Int:U, Int) }, "basic return type check works with undefinite";
    lives-ok { $rv = ret_T(Rat(), "42.12") }, "type capture can be a coercion";
    is $rv, 42.12, "coercive type capture actually coerces";

    throws-like 
        { ret_T(Str, 42) }, 
        X::TypeCheck::Return,
        "basic type mismatch throws";

    throws-like 
        { ret_T(Rat:D, Rat) }, 
        X::TypeCheck::Return,
        "a definite type capture throws on undefined";

    throws-like 
        { ret_T(Rat:U, 1.3) }, 
        X::TypeCheck::Return,
        "an undefinite type capture throws with a concrete return value";

    my subset Bar of Str:D where *.contains("Bar");

    lives-ok { ret_T(Bar, "A Barrish") }, "type check against a subset";
    throws-like
        { ret_T(Bar, "something different") },
        X::TypeCheck::Return,
        "type mismatch against a subset";

    my sub ret_TDC(::T \t, $v --> T:D()) {
        $v
    }

    lives-ok { $rv = ret_TDC(Int, "12") }, "coercion over a type capture";
    is $rv, 12, "coercion over a type capture does its job";

    my $Bar-expected = "Give the 'Bar', as it expects!";
    my class Foo {
        method Str { $Bar-expected }
    }

    lives-ok { $rv = ret_TDC(Bar, Foo.new) }, "coercion into a subset works";
    is $rv, $Bar-expected, "coercion into a subset does its job";

    #?rakudo.jvm todo "code doesn't die"
    throws-like 
            { ret_TDC(Bar, 13) },
            X::Coerce::Impossible,
            "coercion into a subset throws when constraint is not fulfilled";
}

# vim: expandtab shiftwidth=4
