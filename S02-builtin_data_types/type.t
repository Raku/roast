use v6;
use Test;

=begin description

Basic tests about variables having built-in types assigned

=end description

# L<S02/"Built-In Data Types"/"A variable's type is a constraint indicating what sorts">

plan 28;

{
    ok(try {my Int $foo; 1}, 'compile my Int $foo');
    ok(try {my Str $bar; 1}, 'compile my Str $bar');
}

ok(do {my Int $foo; $foo ~~ Int}, 'Int $foo isa Int');
ok(do {my Str $bar; $bar ~~ Str}, 'Str $bar isa Str');

my Int $foo;
my Str $bar;

{
    #?pugs 1 todo 
    dies_ok({$foo = 'xyz'},      'Int restricts to integers');
    is(($foo = 42),       42,    'Int is an integer');

    #?pugs 1 todo 
    dies_ok({$bar = 42},         'Str restricts to strings');
    is(($bar = 'xyz'),    'xyz', 'Str is a strings');
}

# L<S02/Built-In Data Types/Variables with native types do not support undefinedness>
#?rakudo skip 'native types (causes false positives if marked with todo)'
{
    eval_lives_ok('my int $alpha = 1',    'Has native type int');
    eval_dies_ok('my int $alpha = undef', 'native int type cannot be undef');
    lives_ok({my Int $beta = undef},      'object Int type can be undef');
    eval_lives_ok('my num $alpha = 1',    'Has native type num');
    eval_dies_ok('my num $alpha = undef', 'native num type cannot be undef');
    lives_ok({my Num $beta = undef},      'object Num type can be undef');
}

# L<S02/Parameter types/Parameters may be given types, just like any other variable>
{
    sub paramtype (Int $i) {return $i+1}
    is(paramtype(5), 6, 'sub parameters with matching type');
    eval_dies_ok('paramtype("foo")', 'sub parameters with non-matching type dies');
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

# Num accepts Int too.
{
    my Num $n;
    $n = 42;
    is $n, 42, 'Num accepts Int too';
}

# L<S02/Return types/a return type can be specified before or after the name>
#?rakudo skip 'only the return type "of" parses correctly'
# TODO: I'm not 100% sure about the living/dieing for all the cases below
{
    my sub returntype1 (Bool $pass) as Str {$pass ?? 'ok' !! -1}
    my sub returntype2 (Bool $pass) of Int {$pass ?? 42 !! 'no'}
    my Bool sub returntype3 (Bool $pass)   {$pass ?? True !! ':('}

    is(returntype1(True), 'ok good', 'good return value works (as)');
    eval_dies_ok('returntype1(False)', 'bad return value dies (as)');
    is(returntype2(True), 42, 'good return value works (of)');
    eval_dies_ok('returntype2(False)', 'bad return value dies (of)');
    is(returntype3(True), True, 'good return value works (my Type sub)');
    eval_dies_ok('returntype3(False)', 'bad return value dies (my Type sub)');

    # the following two are the same type of behavior
    # S02: "It is possible for the of type to disagree with the as type"
    my Rat sub returntype4 ($pass)     as Num {$pass ?? 1.1 !! 1}
    my sub returntype5 ($pass --> Rat) as Num {$pass ?? 2.2 !! 2}

    is(returntype4(True), 1.1, 'good return value works (my Type sub as OtherType)');
    eval_dies_ok('returntype4(False)', 'bad return value dies (my Type sub as OtherType)');
    is(returntype5(True), 2.2, 'good return value works (--> Type as OtherType)');
    eval_dies_ok('returntype5(False)', 'bad return value dies (--> Type as OtherType)');
    
}

