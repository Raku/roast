use v6;
use Test;

=begin description

Basic tests about variables having built-in types assigned

=end description

# L<S02/"Types as Constraints"/"A variable's type is a constraint indicating what sorts">

plan 51;

{
    ok(try {my Int $foo; 1}, 'compile my Int $foo');
    ok(try {my Str $bar; 1}, 'compile my Str $bar');
}

ok(do {my Int $foo; $foo ~~ Int}, 'Int $foo isa Int');
ok(do {my Str $bar; $bar ~~ Str}, 'Str $bar isa Str');

my Int $foo;
my Str $bar;

{
    dies-ok({$foo = 'xyz'},      'Int restricts to integers');
    dies-ok { $foo = Mu },       'Int does not accept Mu';
    is(($foo = 42),       42,    'Int is an integer');

    dies-ok({$bar = 42},         'Str restricts to strings');
    dies-ok { $bar = Mu },       'Str does not accept Mu';
    is(($bar = 'xyz'),    'xyz', 'Str is a strings');
}

#?niecza skip 'Trait of not available on variables'
{
    my $baz of Int;
    dies-ok({$baz = 'xyz'},      'of Int restricts to integers');
    is(($baz = 42),       42,    'of Int is an integer');
}

# L<S02/Variables Containing Undefined Values/Variables with native types do not support undefinedness>
#?niecza skip 'native types (noauto)'
{
    eval-lives-ok('my int $alpha = 1',    'Has native type int');
    throws-like 'my int $alpha = Nil', X::AdHoc, 'native int type cannot be undefined';
    lives-ok({my Int $beta = Nil},      'object Int type can be undefined');
    eval-lives-ok('my num $alpha = 1e0',    'Has native type num');
    #?rakudo.jvm todo "nigh"
    #?rakudo.moar todo "nigh"
    # RT #121518
    eval-lives-ok('my num $alpha = Nil', 'native num type can be undefined');
    lives-ok({my Num $beta = Nil},      'object Num type can be undefined');
    # RT #93982
    lives-ok({my Str ($a) = ()}, 'object Str type can be undefined, list context');
}

# L<S02/Parameter types/Parameters may be given types, just like any other variable>
{
    sub paramtype (Int $i) {return $i+1}
    is(paramtype(5), 6, 'sub parameters with matching type');
    throws-like 'paramtype("foo")', X::TypeCheck::Argument,
        'sub parameters with non-matching type dies';
}

{
    # test contributed by Ovid++
    sub fact (Int $n) {
        if 0 == $n {
            1;
        }
        else {
            $n * fact($n - 1);
        }
    }
    is fact(5), 120, 'recursive factorial with type contstraints work';
}

# Num does not accept Int (used to, then spec changed)
dies-ok { my Num $n; $n = 42; }, 'Num does not accept Int';

# L<S02/Return types/a return type can be specified before or after the name>
{
    # Check with explicit return.
    my sub returntype1 (Bool $pass) returns Str { return $pass ?? 'ok' !! -1}
    my sub returntype2 (Bool $pass) of Int { return $pass ?? 42 !! 'no'}
    my Bool sub returntype3 (Bool $pass)   { return $pass ?? Bool::True !! ':('}
    my sub returntype4 (Bool $pass --> Str) { return $pass ?? 'ok' !! -1}

    is(returntype1(Bool::True), 'ok', 'good return value works (returns)');
    #?niecza todo 'retrun value type checking NYI'
    dies-ok({ returntype1(Bool::False) }, 'bad return value dies (returns)');
    is(returntype2(Bool::True), 42, 'good return value works (of)');
    #?niecza todo 'retrun value type checking NYI'
    dies-ok({ returntype2(Bool::False) }, 'bad return value dies (of)');

    is(returntype3(Bool::True), True, 'good return value works (my Type sub)');
    #?niecza todo 'retrun value type checking NYI'
    dies-ok({ returntype3(Bool::False) }, 'bad return value dies (my Type sub)');

    is(returntype4(Bool::True), 'ok', 'good return value works (-->)');
    #?niecza todo 'retrun value type checking NYI'
    dies-ok({ returntype4(Bool::False) }, 'bad return value dies (-->)');
}

{
    # Check with implicit return.
    my sub returntype1 (Bool $pass) returns Str { $pass ?? 'ok' !! -1}
    my sub returntype2 (Bool $pass) of Int { $pass ?? 42 !! 'no'}
    my Bool sub returntype3 (Bool $pass)   { $pass ?? Bool::True !! ':('}
    my sub returntype4 (Bool $pass --> Str) { $pass ?? 'ok' !! -1}

    is(returntype1(Bool::True), 'ok', 'good implicit return value works (returns)');
    #?niecza todo 'retrun value type checking NYI'
    dies-ok({ returntype1(Bool::False) }, 'bad implicit return value dies (returns)');
    is(returntype2(Bool::True), 42, 'good implicit return value works (of)');
    #?niecza todo 'retrun value type checking NYI'
    dies-ok({ returntype2(Bool::False) }, 'bad implicit return value dies (of)');

    is(returntype3(Bool::True), True, 'good implicit return value works (my Type sub)');
    #?niecza todo 'retrun value type checking NYI'
    dies-ok({ returntype3(Bool::False) }, 'bad implicit return value dies (my Type sub)');

    is(returntype4(Bool::True), 'ok', 'good implicit return value works (-->)');
    #?niecza todo 'retrun value type checking NYI'
    dies-ok({ returntype4(Bool::False) }, 'bad implicit return value dies (-->)');
}

{
    throws-like 'my Int Str $x', X::Comp::NYI, 'multiple prefix constraints not allowed';
    throws-like 'sub foo(Int Str $x) { }', X::Parameter::MultipleTypeConstraints,
        'multiple prefix constraints not allowed';
    throws-like 'sub foo(--> Int Str) { }', Exception, 'multiple prefix constraints not allowed';
    throws-like 'our Int Str sub foo() { }', X::Comp::NYI, 'multiple prefix constraints not allowed';
}

{
    # TODO: many more of these are possible
    ok Any ~~ Mu, 'Any ~~ Mu';
    ok Mu !~~ Any, 'Mu !~~ Any';
    ok Mu !~~ Int, 'Mu !~~ Int';

    ok Int ~~ Numeric, 'Int ~~ Numeric';
    ok Numeric !~~ Int, 'Numeric !~~ Int';

    ok Array ~~ List, 'Array is a kind of List';
    ok List !~~ Array, 'A List is not an Array';
    ok Array ~~ Positional, 'Array does Positional too';
}

# vim: ft=perl6
