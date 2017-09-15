use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;

plan 117;

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
    # RT #63880
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

# RT #64566
{
    my @a = 1 .. 4;
    is @a[1..*], 2..4, '@a[1..*] skips first element, stops at last';
    is @a, 1..4, 'array is unmodified after reference to [1..*]';
    # RT #61844
    is (0, 1)[*-1..*], 1, '*-1..* lives and clips to range of List';
}

# RT #68894
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
    is @x1.join('|'), '1|2|3|4', '+* in hash slice (RT #67450)';
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
    is $c(-3, -3, -3), 6, '... that respects precdence';
    is $c(0, -10, 3), 3, 'that can work with three different arguments';
}

{
    my $c = * + * * *;
    ok $c ~~ Code, '* + * * * generated a closure';
    is $c(2, 2, 2), 6,  '... that works';
    is $c(-3, -3, -3), 6, '... that respects precdence';
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

# RT #122708
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

# chains of operators, RT #71846
{
    is (0, 1, 2, 3).grep(!(* % 2)).join('|'),
        '0|2', 'prefix:<!> Whatever-curries correctly';
}

# RT #69362
{
    my $x = *.uc;
    my $y = * + 3;
    ok $x.signature, 'Whatever-curried method calls have a signature';
    ok $y.signature, 'Whatever-curried operators have a signature';

}

# RT #73162
# WAS:  eval-lives-ok '{*.{}}()', '{*.{}}() lives';
# This is now supposed tobe a double-closure error:
throws-like '{*.{}}()', X::Syntax::Malformed, '{*.{}}() dies';

# RT #80256
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

# RT #79166
{
    my $rt79166 = *;
    isa-ok $rt79166, Whatever, 'assignment of whatever still works';
    $rt79166 = 'RT #79166';
    is $rt79166, 'RT #79166', 'assignment to variable with whatever in it';
}

# RT #81448
{
    sub f($x) { $x x 2 };
    is *.&f.('a'), 'aa', '*.&sub curries';
}

# RT #77000
{
    isa-ok *[0], WhateverCode, '*[0] curries';
    is *[0]([1, 2, 3]), 1, '... it works';
}

# RT #102466

{
    my $chained = 1 < * < 3;
     ok $chained(2), 'Chained comparison (1)';
    nok $chained(1), 'Chained comparison (2)';
    nok $chained(3), 'Chained comparison (3)';
}

# RT #120385
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

# RT #127408
throws-like '*(42)', X::Method::NotFound, typename => 'Whatever';

# RT #131106
{
    my $foo = "foo";
    ok $foo ~~ (* =:= $foo), 'Code.ACCEPTS preserves container';
}

# RT #126540
{
    nok (* !~~ Int)(1), 'Whatever-currying !~~';
}

#?rakudo todo 'useless use corner case RT #130773'
is_run "my &f = EVAL '*+*'", { err => '' }, '*+* does not warn from inside EVAL';

#?rakudo todo 'useless use corner case RT #130502'
is_run '-> +@foo { @foo.head.(41) }(* == 42)', { err => '' }, 'no warning when WhateverCode passed as arg and invoked';

#?rakudo todo '&combinations whatever handling RT #131846'
is-deeply try { (1,2,3).combinations(2..*) }, ((1, 2), (1, 3), (2, 3), (1, 2, 3)), "combinations(2..*)";

#?rakudo todo 'closure/scoping of outer parameter with rx RT #131409'
{
    my @match-rx = <foo fie>.map( -> $r { * ~~ /<$r>/ } );
    my @matches = (for <fee foo fie fum> -> $f { @match-rx.grep({$_($f)}).map({~$/}).list } );
    is-deeply @matches, [(), ("foo",), ("fie",), ()], 'outer parameter in rx in WhateverCode in closure';
}

#?rakudo todo 'closure/scoping of topic when calling Whatevercode RT #126984'
{
    my sub foo($x) { (* ~ $x)($_) given $x };
    is foo(1) ~ foo(2), '1122', 'topic refreshed in immediate invocation of WhateverCode';
}

# vim: ft=perl6
