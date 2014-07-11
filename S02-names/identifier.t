use v6;
use Test;

plan 22;

# L<S02/Names/An identifier is composed of an alphabetic character>

{
    sub don't($x) { !$x }

    ok don't(0),    "don't() is a valid sub name (1)";
    ok !don't(1),   "don't() is a valid sub name (2)";

    my $a'b'c = 'foo';
    is $a'b'c, 'foo', "\$a'b'c is a valid variable name";

    eval_dies_ok  q[sub foo-($x) { ... }],
                 'foo- (trailing hyphen) is not an identifier';
    eval_dies_ok  q[sub foo'($x) { ... }],
                 "foo' (trailing apostrophe) is not an identifier";
    eval_dies_ok  q[sub foob'4($x) { ... }],
                 "foob'4 is not a valid identifier (not alphabetic after apostrophe)";
    eval_dies_ok  q[sub foob-4($x) { ... }],
                 "foob-4 is not a valid identifier (not alphabetic after hyphen)";
    eval_lives_ok q[sub foo4'b($x) { ... }],
                 "foo4'b is a valid identifier";
}

{
    # This confirms that '-' in a sub name is legal.
    my sub foo-bar { 'foo-bar' }
    is foo-bar(), 'foo-bar', 'can call foo-bar()';
}

# RT #64656
{
    my sub do-check { 'do-check' }
    is do-check(), 'do-check', 'can call do-check()';
}

{
    # check with a different keyword
    sub if'a($x) {$x}
    is if'a(5), 5, "if'a is a valid sub name";
}

{
    my sub sub-check { 'sub-check' }
    is sub-check(), 'sub-check', 'can call sub-check';
}

{
    my sub method-check { 'method-check' }
    is method-check(), 'method-check', 'can call method-check';
}

{
    my sub last-check { 'last-check' }
    is last-check(), 'last-check', 'can call last-check';
}

{
    my sub next-check { 'next-check' }
    is next-check(), 'next-check', 'can call next-check';
}

{
    my sub redo-check { 'redo-check' }
    is redo-check(), 'redo-check', 'can call redo-check';
}

# RT #65804
{
    sub sub($foo) { $foo }
    is sub('RT #65804'), 'RT #65804', 'sub named "sub" works';
}

# RT #68358
{
    my ($x);
    sub my($a) { $a + 17 }
    $x = 5;
    is my($x), 22, 'call to sub named "my" works';
}

# RT #72898
{
    sub loop($a) { $a + 1 }
    is loop(5), 6, 'sub named "loop" works';
}

# RT #77218
# Rakudo had troubles with identifiers whos prefix is an alphanumeric infix
# operator; for example 'sub order' would fail because 'order' begins with
# 'or'
{
    my $res;
    sub order-beer($what) { $res = "a $what please!" };
    order-beer('Pils');
    is $res, 'a Pils please!',
        'can call subroutines whos name begin with an alphabetic infix (or)';

    my $tempo;
    sub andante() { $tempo = 'walking pace' }
    andante;

    is $tempo, 'walking pace',
        'can call subroutines whos name begin with an alphabetic infix (and)';

    # RT #75710
    eval_lives_ok q{our sub xyz($abc) { $abc }; xyz(1);},
        'can call subroutine which starts with infix x';
}

done;

# vim: ft=perl6
