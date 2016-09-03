use v6;

use Test;

plan 20;

# L<S06/Signatures>

# Nil is treated as definite value in return specifications
{
    my sub return-nil(--> Nil) {
        1
    }

    ok return-nil() =:= Nil, 'A function with a definite return value should ignore the result of its last statement';
}

{
    my sub return-two(--> 2) {
        3
    }

    is return-two(), 2, 'A function with a non-Nil definite return value should ignore the result of its last statement';
}

{
    throws-like '
        my sub return-nil(--> Nil) {
            return 1
        }
    ', Exception, 'A function with a definite return value may not use return with a value';
}

{
    throws-like '
        my sub return-failure(--> Nil) {
            return Failure.new(X::AdHoc.new(4))
        }
    ', X::AdHoc, 'A function with a definite return value may not use return with a value, even a Failure';
}

{
    my sub fail-five(--> 5) {
        fail "five"
    }

    my $failure = fail-five();
    isnt $failure, 5, 'Failures bypass the return value of function with a definite return value in the signature';
    ok $failure ~~ Failure, 'Failures bypass the return value of function with a definite return value in the signature';
}

{
    my sub return-six(--> 6) {
        return
    }

    is return-six(), 6, 'Value-less returns are allowed in functions with definite return value in their signatures';
}


#?rakudo skip 'variables as return specifications dont parse yet RT #124927'
{
    my sub return-seven(--> $result) {
        $result = 7;
        8
    }

    is return-seven(), 7, 'Functions using a mutable value as their return value use that value as their return value';
}


#?rakudo skip 'variables as return specifications dont parse yet RT #124927'
{
    my $result = 9;

    my sub return-eight(--> $result) {
        $result = 8;
        19
    }

    is eight(), 8, 'Variables used as return specifications *always* shadow existing variables with the same name';
}

{
    my sub return-nine(--> "nine") { 42 }

    is return-nine(), "nine", 'We can return strings';
}

{
    my sub return-ten(--> "ten") { }

    is return-ten(), "ten", 'We can return from statement-less blocks';
}

{
    my $got-here = False;
    my sub return-eleven(--> Empty) { 1, { ++$got-here; last } ... * }
    is return-eleven().elems, 0, 'We can return Empty';
    ok $got-here, "and the last statement of the function was sunk";
}

{
    my sub return-twelve(--> True) { False }
    is return-twelve(), Bool::True, 'can return True';
}

{
    my sub return-thirteen(--> False) { True }
    is return-thirteen(), Bool::False, 'can return False';
}

{
    my sub return-fourteen(--> pi) { True }
    is return-fourteen(), pi, 'can return pi';
}

constant indiana-pi = 3;

{
    my sub return-fifteen(--> indiana-pi) { True }
    is return-fifteen(), indiana-pi, 'can return indiana-pi';
}

{
    my $pointy = -> --> 42 { };
    is $pointy(), 42, 'pointy can have definite return type that is an integer';
}

{
    my $pointy = -> --> Nil { sin(1) };
    ok $pointy() === Nil, 'pointy can have definite return type of Nil';
}

# RT #128964
subtest 'type coercions work in returns' => {
    plan 8;

    subtest 'sub (Int --> Str())' => {
        plan 3;

        my sub     t (Int $x --> Str()) {$x}
        isa-ok     t(42),     Str,      'returns correct type';
        is         t(42),     "42",     'returns correct value';
        is-deeply &t.returns, Str(Any), '.returns() gives correct value';
    }

    subtest 'sub (Num $x --> Int(Str))' => {
        plan 3;

        my sub     t (Num $x --> Int(Str)) {"$x"}
        isa-ok     t(42e0),   Int,      'returns correct type';
        is         t(42e0),   42,       'returns correct value';
        is-deeply &t.returns, Int(Str), '.returns() gives correct value';
    }

    subtest 'sub (Int) returns Str()' => {
        plan 3;

        my sub     t (Int $x) returns Str() {$x}
        isa-ok     t(42),     Str,      'returns correct type';
        is         t(42),     "42",     'returns correct value';
        is-deeply &t.returns, Str(Any), '.returns() gives correct value';
    }

    subtest 'sub (Num) returns Int(Str)' => {
        plan 3;

        my sub     t (Num $x) returns Int(Str) {"$x"}
        isa-ok     t(42e0),   Int,      'returns correct type';
        is         t(42e0),   42,       'returns correct value';
        is-deeply &t.returns, Int(Str), '.returns() gives correct value';
    }

    subtest 'block Int --> Str()' => {
        plan 3;

        my        $block = -> Int $x --> Str() {$x};
        isa-ok    $block(42),     Str,      'returns correct type';
        is        $block(42),     "42",     'returns correct value';
        is-deeply $block.returns, Str(Any), '.returns() gives correct value';
    }

    subtest 'block --> Str()' => {
        plan 3;

        my        $block = -> --> Str() {42};
        isa-ok    $block(),       Str,      'returns correct type';
        is        $block(),       "42",     'returns correct value';
        is-deeply $block.returns, Str(Any), '.returns() gives correct value';
    }

    subtest 'method (Int --> Str())' => {
        plan 3;

        my        $o = class { method v (Int $x --> Str()) {$x} }.new;
        isa-ok    $o.v(42), Str,  'returns correct type';
        is        $o.v(42), "42", 'returns correct value';
        is-deeply $o.^find_method('v').returns, Str(Any),
            '.returns() gives correct value';
    }

    throws-like { sub (--> Str(Int)) { 42e0 }() }, X::TypeCheck::Return,
        'returning incorrect type throws';
}

# returns vs -->
# indefinite vs immutable vs mutable
# what are some wacky immutable values that we could return? (*)
# mutable: existing variable (can you put a type on this?)
# mutable: new variable (can you put a type on this?)
# mutable: default value (pre-existing vs new)
# mutable: non variable (think rw function or something)
# what other things can we do to variables/parameters that we could do to the return variable?
# anonymous subs, nested subs
# if !indefinite, final statement should be in sink (and not item/list) context
# S26 for return params...
# coerce Bool from Junction in return value?
# use of CALLER::/OUTER:: as return value (FROGGS' example)
# Should sub return-two(--> 2) { 3 } emit an error/warning?
# traits - how to distinguish a trait on the return value vs on the sub?
