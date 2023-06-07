use Test;

plan 28;

# L<S06/Closure parameters>

{
    my sub testit (&testcode) {testcode()}

    ok(testit({1}), 'code executes as testsub({...})');

    my $code = {1};
    ok(testit($code), 'code executes as testsub($closure)');

    my sub returntrue {return 1}
    ok(testit(&returntrue), 'code executes as testsub(&subroutine)');
}

# with a signature for the closure
{
    my sub testit (&testcode:(Int)) {testcode(12)}
    my sub testint(Int $foo) {return 1}   #OK not used
    my sub teststr(Str $foo) {return 'foo'}   #OK not used

    my sub test-but-dont-call(&testcode:(Int)) { True }

    ok(testit(&testint), 'code runs with proper signature (1)');
    throws-like 'testit(&teststr)', Exception, 'code dies with invalid signature (1)';

    ok(test-but-dont-call(&testint), 'code runs with proper signature (1)');
    #?rakudo.jvm todo 'Code does not die'
    throws-like 'test-but-dont-call(&teststr)', Exception, 'code dies with invalid signature (1)';
}

{
    my sub testit (&testcode:(Int --> Bool)) {testcode(3)}
    my Bool sub testintbool(Int $foo) {return Bool::True}   #OK not used
    my Bool sub teststrbool(Str $foo) {return Bool::False}   #OK not used
    my Int  sub testintint (Int $foo) {return 1}   #OK not used
    my Int  sub teststrint (Str $foo) {return 0}   #OK not used

    ok(testit(&testintbool), 'code runs with proper signature (2)');
    #?rakudo.jvm todo 'Code does not die'
    throws-like 'testit(&testintint)', Exception, 'code dies with invalid signature (2)';
    throws-like 'testit(&teststrbool)', Exception, 'code dies with invalid signature (3)';
    throws-like 'testit(&teststrint)', Exception,  'code dies with invalid signature (4)';
}

{
    multi sub t1 (&code:(Int)) { 'Int' };   #OK not used
    multi sub t1 (&code:(Str)) { 'Str' };   #OK not used
    multi sub t1 (&code:(Str --> Bool)) { 'Str --> Bool' };   #OK not used
    multi sub t1 (&code:(Mu, Mu)) { 'Two' };   #OK not used

    # Note that using &code:($,$) instead of &code:(Any, Any) makes this next test work
    #?rakudo.jvm todo "expected: 'Two', got: 'Int'"
    is t1(-> $a, $b { }), 'Two',   #OK not used
       'Multi dispatch based on closure parameter syntax (1)';
    is t1(-> Int $a { }), 'Int',   #OK not used
       'Multi dispatch based on closure parameter syntax (2)';
    #?rakudo.jvm todo "expected: 'Str', got: 'Int'"
    is t1(-> Str $a { }), 'Str',   #OK not used
       'Multi dispatch based on closure parameter syntax (3)';

    sub takes-str-returns-bool(Str $x --> Bool) { True }   #OK not used
    #?rakudo.jvm todo "expected: 'Str --> Bool', got: 'Int'"
    is t1(&takes-str-returns-bool), 'Str --> Bool',
       'Multi dispatch based on closure parameter syntax (4)';

    #?rakudo.jvm todo 'Code does not die'
    dies-ok { t1( -> { 3 }) },
       'Multi dispatch based on closure parameter syntax (5)';
}

{
    sub foo(:&a) { bar(:&a) }
    sub bar(*%_) { "OH HAI" }
    is foo(), 'OH HAI', 'can use &a as a named parameter';
}

# https://github.com/Raku/old-issue-tracker/issues/4511
{
    throws-like 'sub f (Int &b:(--> Bool)) { }', X::Redeclaration, 'only one way of specifying sub-signature return type allowed';
}

# https://github.com/Raku/old-issue-tracker/issues/3575
lives-ok {
    my class Dog {};
    sub foo(&block:(Dog --> Bool)) {
        pass 'called sub in unpacking Callable signature with colon';
    }
    foo(sub (Dog $x --> Bool) { $x })
}, 'unpacking Callable signature with colon';

# https://github.com/rakudo/rakudo/issues/1326
subtest 'can use signature unpacking with anonymous parameters' => {
    plan 2;
    is -> &:(Str), 42 {100}(-> Str $v { $v.uc }, 42), 100,
        'can call with right signature';
    #?rakudo.jvm todo 'Code does not die'
    throws-like '-> &:(Int) {}({;})', X::TypeCheck::Binding::Parameter,
        'typcheck correctly fails with wrong arg';
}

# https://github.com/rakudo/rakudo/issues/4537
{
    my sub testit(Int $v, :&fn:(Int)) { fn($v) }
    my sub fn(Int $v) { $v * 2 };
    my sub fn-str(Str $v) { $v ~~ " * 2" };

    is testit(42, :&fn), 84, "signature constraint works with a named callable parameter";
    dies-ok { testit(13, fn => &fn-str) }, "wrong signature is not accepted by named constrained parameter";
}

# Signature constraints must also work with type captures (generics)
{
    my sub testit(::T $v, &fn:(T)) { fn($v) }
    my sub fn-int(Int $v) { $v * 2 }
    my sub fn-str(Str $v) { $v ~ " is OK" }

    is testit(12, &fn-int), 24, "signature constraint with type capture (Int)";
    is testit("string", &fn-str), "string is OK", "signature constraint with type capture (Str)";
    dies-ok { testit(13, &fn-str) }, "mismatch on captured and signature types predictably throws";

    my role R[::T] {
        method testit(T $v, &fn:(T)) { fn($v) }
    }

    is R[Int].testit(42, &fn-int), 84, "signature-constrained method on a parameterized role works";
    dies-ok { R[Str].testit("foo", &fn-int) }, "mismatch on role parameterization and signature types predictable throws";
}

done-testing;
# vim: expandtab shiftwidth=4
