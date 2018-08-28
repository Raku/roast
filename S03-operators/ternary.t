use v6;

use Test;

#Ternary operator ?? !!

plan 28;
#L<S03/Changes to Perl 5 operators/"The ? : conditional operator becomes ?? !!">

my $str1 = "aaa";
my $str2 = "aaa";
my $str3 = "bbb";

{
    my $foo = "";
    $str1 eq $str2 ?? ($foo = 1) !! ($foo = 2);
    is($foo, 1, "?? !!");

    $str1 eq $str3 ?? ($foo = 3) !! ($foo = 4);
    is($foo, 4, "?? !!");
}

is(($str2 eq $str1 ?? 8 * 8 !! 9 * 9), 64, "?? !! in parenthesis");
is(($str2 eq $str3 ?? 8 + 8 !! 9 div 9), 1, "?? !! in parenthesis");

is(1 ?? 2 ?? 3 !! 4 !! 5 ?? 6 !! 7, 3, "nested ?? !!");
is(1 ?? 0 ?? 3 !! 4 !! 5 ?? 6 !! 7, 4, "nested ?? !!");
is(0 ?? 2 ?? 3 !! 4 !! 5 ?? 6 !! 7, 6, "nested ?? !!");
is(0 ?? 2 ?? 3 !! 4 !! 0 ?? 6 !! 7, 7, "nested ?? !!");

{
    my @a = (1 ?? 2 !! 3, 4 ?? 5 !! 6);
    is(@a, [2, 5], "?? !! in array");

}

is((0 and 1 ?? 2 !! 3), 0, "operator priority");
is((4 or 5 ?? 6 !! 7), 4, "operator priority");

{
    my $foo = 8;

    $foo = 9 ?? 10 !! 11;
    is($foo, 10, "operator priority");

    $foo = 0 ?? 12 !! 13;
    is($foo, 13, "operator priority");
}

{
    my $foo = 1 ?? Bool::True !! Bool::False;
    is($foo, Bool::True, "a statement with both ??!! and :: in it did compile") ;
}

{
    # Defining an N! postfix (for factorial) causes a misparse on ternary op
    proto postfix:<!>($n) {
        return 1 if $n < 2;
        return $n * ($n-1)!
    }

    my $foo = EVAL q[ 1 ?? 'yay' !! 'nay' ];
    is($foo, "yay", "defining a postfix<!> doesn't screw up ternary op");
}

# RT #66840
{
    throws-like { EVAL '1 ?? 2,3 !! 4,5' },
        X::Syntax::ConditionalOperator::PrecedenceTooLoose,
        'Ternary error (RT #66840)';
}

throws-like q[ 71704 !! 'bust' ], X::Syntax::Confused, 'Ternary error (RT #71704)';

throws-like { EVAL '1 ?? 3 :: 2' },
    X::Syntax::ConditionalOperator::SecondPartInvalid,
    second-part => "::",
    'conditional operator written as ?? :: throws typed exception';

throws-like { EVAL '1 ?? 3 :foo :: 2' },
    X::Syntax::ConditionalOperator::PrecedenceTooLoose,
    operator => ":foo",
    'adverbed literal in second part of ternary';

# RT #124323
{
    my @x = ^10;
    my @y = 2..3;
    throws-like { EVAL 'my @z = @y ?? @x[@y] :v !! @x' },
        X::Syntax::ConditionalOperator::PrecedenceTooLoose,
        operator => ':v',
        'precedence of adverb in second part of ternary is too loose';
    is @y ?? (@x[@y] :v) !! @x, "2 3",
        'adverb in second part of ternary used with parenthesis works';
}

throws-like { EVAL '1 ?? (3 :foo) !! 2' },
    X::Syntax::Adverb,
    'parenthesized adverbed literal in second part of ternary';

{
    my $three:foo = 3;
    my $thing:foo = 1 ?? $three:foo !! 2;
    is $three:foo, 3, 'variable and adverb in second part of ternary';
}

throws-like { EVAL '1 ?? 3 : 2' },
    X::Syntax::ConditionalOperator::SecondPartInvalid,
    second-part => ":",
    'conditional operator written as ?? : throws typed exception';

throws-like { EVAL '1 ?? b\n !! 2' },
    X::Syntax::Confused,
    'bogus code before !! of conditional operator is compile time error';

throws-like { EVAL '1 ?? 2' },
    X::Syntax::Confused,
    'missing !! of conditional operator is compile time error';

# RT #123115
{
    sub rt123115 { 2 };
    throws-like { EVAL '1 ?? rt123115 !! 3' },
        X::Syntax::ConditionalOperator::SecondPartGobbled,
        'typed exception when listop gobbles the !! of conditional operator';
}

# RT #129080
subtest 'fiddly meta error indicates what operator is used' => {
    my @ops = <Z R X S>;
    plan +@ops;

    for @ops -> $op {
        throws-like "1 $op?? 2 !! 3", X::Syntax::CannotMeta,
            :operator{.contains: '??'}, "$op operator";
    }
}

# vim: ft=perl6
