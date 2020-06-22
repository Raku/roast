use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 130;

# L<S02/The Whatever Object/"The * character as a standalone term captures the notion of">
# L<S02/Native types/"If any native type is explicitly initialized to">

{
    my $x = *;
    isa-ok $x, Whatever, 'can assign * to a variable and isa works';

    my Whatever $y;
    ok $y.WHAT === Whatever, 'can type variables with Whatever';

    ok *.WHAT === Whatever, '*.WHAT does not autocurry';
}

# L<S02/Currying of Unary and Binary Operators/"Most of the built-in numeric operators">

my $x = *-1;
lives-ok { $x.WHAT }, '(*-1).WHAT lives';
ok $x ~~ Code, '*-1 is some form of Code';
isa-ok $x, WhateverCode, '*-1 is a WhateverCode object';
is $x.(5), 4, 'and we can execute that Code';

ok *.abs ~~ Code, '*.abs is of type Code';
isa-ok *.abs, WhateverCode, '... WhateverCode, more specifically';

isa-ok 1..*, Range, '1..* is a Range, not a Code';
isa-ok 1..*-1, WhateverCode, '1..*-1 is a WhateverCode';
isa-ok (1..*-1)(10), Range, '(1..*-1)(10) is a Range';

{
    my @a = map *.abs, 1, -2, 3, -4;
    is @a, [1,2,3,4], '*.meth created closure works';
}

{
    # check that it also works with Enums - used to be a Rakudo bug
    # https://github.com/Raku/old-issue-tracker/issues/781
    enum A <b c>;
    isa-ok (b < *), Code, 'Enums and Whatever star interact OK';
}

# check that more complex expressions work:

{
    my $code = *.uc eq 'FOO';
    ok $code ~~ Callable, '"*.uc eq $str" produces a Callable object';
    ok $code("foo"), 'and it works (+)';
    ok !$code("bar"), 'and it works (-)';
}

# https://github.com/Raku/old-issue-tracker/issues/876
{
    my @a = 1 .. 4;
    is @a[1..*], 2..4, '@a[1..*] skips first element, stops at last';
    is @a, 1..4, 'array is unmodified after reference to [1..*]';
    # https://github.com/Raku/old-issue-tracker/issues/556
    is (0, 1)[*-1..*], 1, '*-1..* lives and clips to range of List';
}

# https://github.com/Raku/old-issue-tracker/issues/1262
{
    my @a = <a b>;
    my $t = join '', map { @a[$_ % *] }, ^5;
    is $t, 'ababa', '$_ % * works';
}

{
    my $x = +*;
    isa-ok $x, Code, '+* is of type Code';

    # following is what we expect +* to do
    my @list = <1 10 2 3>;
    is sort(-> $key {+$key}, @list), [1,2,3,10], '-> $key {+$key} generates closure to numify';

    # and here are two actual applications of +*
    is sort($x, @list), [1,2,3,10], '+* generates closure to numify';
    is @list.sort($x), [1,2,3,10], '+* generates closure to numify';

    # test that  +* works in a slice
    my @x1;
    for 1..4 {
        @x1[+*] = $_;
    }
    # https://github.com/Raku/old-issue-tracker/issues/1131
    is @x1.join('|'), '1|2|3|4', '+* in hash slice';
}

# L<S02/Currying of Unary and Binary Operators/are internally curried into closures of one or two
# arguments>
{
    my $c = * * *;
    ok $c ~~ Code, '* * * generated a closure';
    is $c(-3, -5), 15, '... that takes two arguments';
}

{
    my $c = * * * + *;
    ok $c ~~ Code, '* * * + * generated a closure';
    is $c(2, 2, 2), 6,  '... that works';
    is $c(-3, -3, -3), 6, '... that respects precedence';
    is $c(0, -10, 3), 3, 'that can work with three different arguments';
}

{
    my $c = * + * * *;
    ok $c ~~ Code, '* + * * * generated a closure';
    is $c(2, 2, 2), 6,  '... that works';
    is $c(-3, -3, -3), 6, '... that respects precedence';
    is $c(3, 0, -10), 3, 'that can work with three different arguments';
}

is (0,0,0,0,0,0) >>+>> (Slip(1,2) xx *), <1 2 1 2 1 2>, 'xx * works';

{
    is (1, Mu, 2, 3).grep(*.defined), <1 2 3>, '*.defined works in grep';

    my $rt68714 = *.defined;
    ok $rt68714 ~~ Code, '*.defined generates a closure';
    ok $rt68714(68714), '*.defined works (true)';
    ok not $rt68714(Any), '*.defined works (false)';
}

# L<S02/The Whatever Object/skip first two elements>
{
    # TODO: find out if this allowed for item assignment, or for list
    # assignment only
    #?rakudo todo '* as dummy'
    eval-lives-ok ' * = 5 ', 'can dummy-asign to *';

    my $x;
    (*, *, $x) = 1, 2, 3, 4, 5;
    is $x, 3, 'Can skip lvalues and replace them by Whatever';
}


# L<S02/Currying of Unary and Binary Operators/This rewrite happens after variables are looked up
# in their lexical scope>

{
    my $x = 3;
    {
        is (* + (my $x = 5)).(8), 13,
            'can use a declaration in Whatever-curried expression';
        is $x, 5, 'and it did not get promoted into its own scope';
    }
}

# L<S02/The C<.assuming> Method/This is only for operators that are not
# Whatever-aware.>
{
    multi sub infix:<quack>($x, $y) { "$x|$y" };
    isa-ok * quack 5, Code,
        '* works on LHS of user-defined operator (type)';
    isa-ok 5 quack *, Code,
        '* works on RHS of user-defined operator (type)';
    isa-ok * quack *, Code,
        '* works on both sides of user-defined operator (type)';
    is (* quack 5).(3), '3|5',
        '* works on LHS of user-defined operator (result)';
    is (7 quack *).(3), '7|3',
        '* works on RHS of user-defined operator (result)';
    is (* quack *).('a', 'b'), 'a|b',
        '* works on both sides of user-defined operator (result)';
    is ((* quack *) quack *).(1, 2, 3), '1|2|3',
        'also with three *';
    is ((* quack *) quack 'a').(2, 3), '2|3|a',
        'also if the last is not a *, but a normal value';
}

# https://github.com/Raku/old-issue-tracker/issues/3502
{
    isa-ok * + 2,      Code, "'* + 2' curries";
    isa-ok * min 2,    Code, "'* min 2' curries";
    isa-ok * max 2,    Code, "'* max 2' curries";
    isa-ok * max *,    Code, "'* max *' curries";
}

# Ensure that in *.foo(blah()), blah() is not called until we invoke the closure.
{
    my $called = 0;
    sub oh_noes() { $called = 1; 4 }
    my $x = *.substr(oh_noes());
    is $called, 0, 'in *.foo(oh_noes()), oh_noes() not called when making closure';
    ok $x ~~ Callable, 'and we get a Callable as expected';
    is $x('lovelorn'), 'lorn', 'does get called when invoked';
    is $called, 1, 'does get called when invoked';
}

# chains of methods
{
    my $x = *.uc.flip;
    ok $x ~~ Callable, 'we get a Callable from chained methods with *';
    is $x('dog'), 'GOD', 'we call both methods';
}

# chains of operators
# https://github.com/Raku/old-issue-tracker/issues/1469
{
    is (0, 1, 2, 3).grep(!(* % 2)).join('|'),
        '0|2', 'prefix:<!> Whatever-curries correctly';
}

# https://github.com/Raku/old-issue-tracker/issues/1317
{
    my $x = *.uc;
    my $y = * + 3;
    ok $x.signature, 'Whatever-curried method calls have a signature';
    ok $y.signature, 'Whatever-curried operators have a signature';

}

# https://github.com/Raku/old-issue-tracker/issues/1558
# WAS:  eval-lives-ok '{*.{}}()', '{*.{}}() lives';
# This is now supposed tobe a double-closure error:
throws-like '{*.{}}()', X::Syntax::Malformed, '{*.{}}() dies';

# https://github.com/Raku/old-issue-tracker/issues/2286
{
    my $f = * !< 3;
    isa-ok $f, Code, 'Whatever-currying !< (1)';
    nok $f(2), 'Whatever-currying !< (2)';
    ok $f(3), 'Whatever-currying !< (3)';
    ok $f(4), 'Whatever-currying !< (4)';
}

{
    my $f = 5 R- *;
    isa-ok $f, Code, 'Whatever-currying with R- (1)';
    is $f(7), 2, 'Whatever-currying with R- (2)';
    is $f(0), -5, 'Whatever-currying with R- (3)';

    dies-ok { &infix:<+>(*, 42) }, '&infix:<+>(*, 42) doesn\'t make a closure';
    dies-ok { &infix:<R+>(*, 42) }, '&infix:<+>(*, 42) doesn\'t make a closure';
}

{
    my $f = (1 X+ * X+ 3);
    isa-ok $f, Code, 'Whatever-currying single * with X+ (1)';
    is $f(2), 6, 'Whatever-currying single * with X+ (2)';
    is $f(-4), 0, 'Whatever-currying single * with X+ (3)';
}

{
    my $f = (* X+ *);
    isa-ok $f, Code, 'Whatever-currying multi * with X+ (1)';
    is $f(-1,1), 0, 'Whatever-currying multi * with X+ (2)';
    is $f(41,43), 2*42, 'Whatever-currying multi * with X+ (3)';
}

{
    my $f = (1,2 X~ * X~ 3,4);
    isa-ok $f, Code, 'Whatever-currying with X+ lists (1)';
    is $f(<a b>), '1a3 1a4 1b3 1b4 2a3 2a4 2b3 2b4', 'Whatever-currying with X+ lists (2)';
}

{
    my $f = (1 Z+ * Z+ 3);
    isa-ok $f, Code, 'Whatever-currying single * with Z+ (1)';
    is $f(2), 6, 'Whatever-currying single * with Z+ (2)';
    is $f(-4), 0, 'Whatever-currying single * with Z+ (3)';
}

{
    my $f = (* Z+ *);
    isa-ok $f, Code, 'Whatever-currying multi * with Z+ (1)';
    is $f(-1,1), 0, 'Whatever-currying multi * with Z+ (2)';
    is $f(41,43), 2*42, 'Whatever-currying multi * with Z+ (3)';
}

{
    my $f = (1,2 Z~ * Z~ 3,4);
    isa-ok $f, Code, 'Whatever-currying with Z+ lists (1)';
    is $f(<a b>), '1a3 2b4', 'Whatever-currying with Z+ lists (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/2256
{
    my $rt79166 = *;
    isa-ok $rt79166, Whatever, 'assignment of whatever still works';
    $rt79166 = 'RT #79166';
    is $rt79166, 'RT #79166', 'assignment to variable with whatever in it';
}

# https://github.com/Raku/old-issue-tracker/issues/2310
{
    sub f($x) { $x x 2 };
    is *.&f.('a'), 'aa', '*.&sub curries';
}

# https://github.com/Raku/old-issue-tracker/issues/2015
{
    isa-ok *[0], WhateverCode, '*[0] curries';
    is *[0]([1, 2, 3]), 1, '... it works';
}

# https://github.com/Raku/old-issue-tracker/issues/2542

{
    my $chained = 1 < * < 3;
     ok $chained(2), 'Chained comparison (1)';
    nok $chained(1), 'Chained comparison (2)';
    nok $chained(3), 'Chained comparison (3)';
}

# https://github.com/Raku/old-issue-tracker/issues/3258
{
    isa-ok (*.[1]), Code, '*.[1] is some kind of code';
    isa-ok (*.<a>), Code, '*.<a> is some kind of code';
    isa-ok (*.{1}), Code, '*.{1} is some kind of code';
}

{
    isa-ok Whatever eqv 42, Bool, "Whatever type object does not autoprime";
    isa-ok WhateverCode eqv 42, Bool, "WhateverCode type object does not autoprime";
}

{
    my $*f = 1;
    my $*g = 2;
    my sub f ($i) { $i($*f); };
    my sub g ($i) { $i($*g); };
    my sub fg ($i) { $i($*f, $*g); };

    isa-ok (*++), Code, '*++ is some kind of code';
    isa-ok (++*), Code, '++* is some kind of code';
    lives-ok { f(*++); g(*--); fg(*++ + *--) }, "Can call *++ WhateverCode";
    is ($*f, $*g), (3, 0), 'WhateverCode parameters are rw';

}

# https://github.com/Raku/old-issue-tracker/issues/5098
throws-like '*(42)', X::Method::NotFound, typename => 'Whatever';

# https://github.com/Raku/old-issue-tracker/issues/6177
{
    my $foo = "foo";
    ok $foo ~~ (* =:= $foo), 'Code.ACCEPTS preserves container';
}

# https://github.com/Raku/old-issue-tracker/issues/4719
{
    is-deeply (* !~~ Int)(1),   False, 'Whatever-currying !~~ (1)';
    is-deeply (* !~~ Int)("x"), True,  'Whatever-currying !~~ (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/6068
#?rakudo todo 'useless use corner case'
is_run "my &f = EVAL '*+*'", { err => '' }, '*+* does not warn from inside EVAL';

is_run '-> +@foo { @foo.head.(41) }(* == 42)', { err => '' }, 'no warning when WhateverCode passed as arg and invoked';

# https://github.com/Raku/old-issue-tracker/issues/6428
is-eqv (1,2,3).combinations(2..*), ((1, 2), (1, 3), (2, 3), (1, 2, 3)).Seq,
    'combinations(2..*)';

# https://github.com/Raku/old-issue-tracker/issues/6296
#?rakudo todo 'closure/scoping of outer parameter with rx'
{
    my @match-rx = <foo fie>.map( -> $r { * ~~ /<$r>/ } );
    my @matches = (for <fee foo fie fum> -> $f { @match-rx.grep({$_($f)}).map({~$/}).list } );
    is-deeply @matches, [(), ("foo",), ("fie",), ()], 'outer parameter in rx in WhateverCode in closure';
}

# https://github.com/Raku/old-issue-tracker/issues/4901
{
    my sub foo($x) { (* ~ $x)($_) given $x };
    is foo(1) ~ foo(2), '1122', 'topic refreshed in immediate invocation of WhateverCode';
}

# https://github.com/Raku/old-issue-tracker/issues/4664
{
    my @isprime = False, False;
    is-deeply (
        for 1 .. 10 -> $i {
            $i if @isprime[$i] //= so $i %% none 2 ...^ * > $i.sqrt.floor;
        }
    ), (2, 3, 5, 7), 'no issues with //= and WhateverCode';
}

throws-like { use fatal; "a".map: *.Int }, X::Str::Numeric,
    'WhateverCode curry correctly propagates `use fatal` pragma';

is-deeply Mu ~~ (*), True, 'Mu:U smartmatches as True with Whatever';

# https://github.com/rakudo/rakudo/issues/1465
subtest 'compile time WhateverCode evaluation' => {
    plan 5;
    is my class { has $.z is default(42) where * == 42 }.new.z, 42,
        '`where` clause + is default trait on attribute';

    is (my $a is default(42) where * == 42), 42,
        '`where` clause + is default on variable';

    is (BEGIN (* == 42)(42)), True,
        'non-block BEGIN with WhateverCode execution';

    is (BEGIN (15, 16)[*-1]), 16,
        'non-block BEGIN with WhateverCode in subscript';

    my subset Foo where * == 42;
    is (my Foo $b is default(42)), 42, 'subset + default on variable';
}

# https://github.com/rakudo/rakudo/issues/1465
subtest 'compile time Junction in `where` thunk evaluation' => {
    plan 3;
    is my class { has $.z is default(42) where 42|3 }.new.z, 42,
        '`where` clause + is default trait on attribute';

    is (my $a is default(42) where 42|3), 42,
        '`where` clause + is default on variable';

    my subset Foo where 1|42;
    is (my Foo $b is default(42)), 42, 'subset + default on variable';
}

# https://github.com/Raku/old-issue-tracker/issues/6296
subtest 'regex whatever curry' => {
    plan 11;
    my @a = <foo bar>.map: { * ~~ /<$_>/ }
    is @a.head.('foo').so, True, '/<$_>/ curry';

    my @b = <foo bar>.map: { * ~~ /<$_> { pass 'in-regex block' }/ }
    is @b.head.('foo').so, True, '/<$_>/ curry';

    my @c = <foo bar>.map: { * ~~ /<$_> {
        pass 'in-regex block';
        my &z := { pass 'in block inside in-regex block' }
        z
    }/ }
    is @c.head.('foo').so, True, '/<$_>/ curry';

    my @d = <foo bar>.map: { * ~~ /<$_>
        <?{ pass 'in <?{...}> block'; True}>
        <!{ pass 'in <!{...}> block'; False}>
        {
            pass 'in-regex block';
            my &z := { pass 'in block inside in-regex block' }
            z
        }
    /}
    is @d.head.('foo').so, True, '/<$_>/ curry';
}

# https://github.com/Raku/old-issue-tracker/issues/5539
subtest 'chained ops with whatever curry in them' => {
    plan 6;
    is-deeply (1 < *+1 < 5)(3), True,  'op curry inside (1)';
    is-deeply (1 < *+1 < 5)(5), False, 'op curry inside (2)';
    is-deeply (1 < *+1 < 5)(0), False, 'op curry inside (3)';

    is-deeply (11 < *.flip < 50)(52),   True, 'method curry inside (2)';
    is-deeply (11 < *.flip < 50)(25),   False, 'method curry inside (1)';
    is-deeply (11 < *.flip < 50)("01"), False, 'method curry inside (3)';
}

subtest 'various wild cases' => {
    plan 10;
    is-deeply (22 + *.flip + *² + *.flip²)(23, 45, 67), 7855,       '1';

    is-deeply (22 + *.flip < *² + *.flip² < *)(23, 45, 67, 100000), True, '2';
    is-deeply (22 + *.flip < *² + *.flip² < *)(23, 45, 67, 10),     False, '3';
    is-deeply (22 + *.flip < *² + *.flip² < *)(233333, 45, 67, 100000),
      False, '4';

    my $a = 42;
    my $b = sub (Whatever) { 100 };
    is-deeply (* + $a + $b(*) + *.flip + *.flip²)(5,17,13), 1179, '5';
    is-deeply (* + $a + $b(*) < *.flip + *.flip² < 2000)(5,17,13), True,  '6';

    is-deeply (* + $a > $b(*) + *.flip + *.flip² > 2000)(50,17,13), False, '7';
    $a = 100000;
    is-deeply (* + $a > $b(*) + *.flip + *.flip² < 2000)(50,17,13), True, '8';
    $b = sub (|) { 4200 };
    is-deeply (* + $a > $b(*) + *.flip + *.flip² < 2000)(50,17,13), False, '9';
    is-deeply (* + $a > $b(*) + *.flip + *.flip² > 2000)(50,17,13), True,  '9';
}

# https://github.com/Raku/old-issue-tracker/issues/6098
{
    sub f { my $x = ++$; (*.[* - $x])(<a b c>) }
    is-deeply [f, f, f], [<c b a>], 'postfix curry with another curry inside';
}

# https://github.com/rakudo/rakudo/issues/1487
is-deeply (*.match(/.+/).flip)(42), "24",
    'curry + regex + method call does not crash';

subtest 'can curry chains with .& calls on them' => {
    plan 6;
    is (*.&{ $_ ~ 'one' })('foo'), 'fooone', '.&{}';
    is (*.uc.&{ $_ ~ 'one' })('foo'), 'FOOone', 'method, .&{}';
    is (*.uc.&{ $_ ~ 'one' }.flip)('foo'), 'enoOOF', 'method, .&{}, method';
    is (*.uc.&{ $_ ~ 'one' }.flip.&(*.tc))('foo'), 'EnoOOF',
        'method, .&, method, .& with whatever curry in it';
    is (*.uc.&{ $^a ~ $^b }('one').flip.&(*.tc).&flip)('foo'),
      'FOOonE', 'method, .&(1arg), method, .& with whatever curry in it, .&sub';
    is (*.uc.&{ $^a ~ $^b ~ $^c }('one', 'two').flip.&(*.tc).&flip)('foo'),
      'FOOonetwO', 'method, .&(2args), method, .& with whatever curry, .&sub';
}

subtest 'can .assuming with WhateverCode' => {
    plan 4;
    is-deeply ((*.flip)).assuming(42)(), '24', '1-param, 1 assumed';
    is-deeply ((* + *)).assuming(42)(3), 45, '2-param, 1 assumed';
    is-deeply ((* + *)).assuming(42, 5)(), 47, '2-param, 2 assumed';
    is-deeply ((* + * + *.flip + *.abs)).assuming(42, 5)(123, -50), 418,
        '5-params with nested calls, 2 assumed';
}

# vim: expandtab shiftwidth=4
