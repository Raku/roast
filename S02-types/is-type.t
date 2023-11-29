use Test;

plan 18;

{
    my @a is Buf;
    ok @a ~~ Buf, 'is TypeName on @ sigil has effect (my)';

    my %h is BagHash;
    ok %h ~~ BagHash, 'is TypeName on % sigil has effect (my)';
}

{
    state @a is Buf;
    ok @a ~~ Buf, 'is TypeName on @ sigil has effect (state)';

    state %h is BagHash;
    ok %h ~~ BagHash, 'is TypeName on % sigil has effect (state)';
}

{
    my class C {
        has @.a is Buf;
        has %.h is BagHash;
    }
    ok C.new.a ~~ Buf, 'is TypeName on @ sigil has effect (has)';
    ok C.new.h ~~ BagHash, 'is TypeName on % sigil has effect (has)';

    for ^2 {
        my %h is BagHash;
        is %h.elems, 0, "Get fresh BagHash in my variable per iteration ($_)";
        %h<a>++; # Create state that should not leak to next iteration
    }

    sub test-state() {
        my $got;
        for ^2 {
            state %h is BagHash;
            %h<a>++;
            $got = %h<a>;
        }
        $got
    }
#?rakudo skip 'state variables with `is BagHash`'
    is test-state(), 2, 'state variable with `is BagHash` retains state...';
#?rakudo skip 'state variables with `is BagHash`'
    is test-state(), 2, '...and it is per closure clone';

    for ^2 {
        my %h := C.new.h;
        is %h.elems, 0, "Get fresh BagHash in new object per iteration ($_)";
        %h<a>++; # Create state that should not leak to next iteration
    }
}

{
    role Foo[*@t] { method STORE(|) { } }  # don't care whether it functions
    eval-lives-ok q/my @a is Foo[Int,Str,Instant]/,
      'can we have parameterized type';
    throws-like q/my @a is Int is Str/,
      X::Syntax::Variable::ConflictingTypes,
      outer => Int,
      inner => Str,
      'did we throw on multiple "is" types';
}

subtest "Positional with generic" => {
    # https://github.com/rakudo/rakudo/pull/5477
    plan 2;

    my role R[::T] {
        has @.a is T;
    }

    my class C does R[Array[Str:D]] {}

    my $obj = C.new;

    isa-ok $obj.a, Array[Str:D], "positional attribute is of the right type";
    ok $obj.a.defined, "the attribute is initialized with a concrete array";
}

subtest "Associative with generic" => {
    # https://github.com/rakudo/rakudo/pull/5477
    plan 2;

    my role R[::T] {
        has %.h is T;
    }

    my class C does R[Hash[Num:D, Str:D]] {}

    my $obj = C.new;

    isa-ok $obj.h, Hash[Num:D, Str:D], "associative attribute is of the right type";
    ok $obj.h.defined, "the attribute is initialized with a concrete hash";
}

subtest "Parameterized Array" => {
    my role R[::TV] {
        has @.a is Array[TV];
    }

    my class C does R[Rat:D] {}

    my $obj = C.new;

    isa-ok $obj.a, Array[Rat:D], "positional attribute is of the right type";
    ok $obj.a.defined, "the attribute is initialized with a concrete array";
}

subtest "Parameterized Hash" => {
    my role R[::TV, ::TK] {
        has %.h is Hash[TV, TK];
    }

    my class C does R[Num:D, Str:D] {}

    my $obj = C.new;

    isa-ok $obj.h, Hash[Num:D, Str:D], "associative attribute is of the right type";
    ok $obj.h.defined, "the attribute is initialized with a concrete hash";
}

done-testing;

# vim: expandtab shiftwidth=4
