use v6;
use Test;

plan 12;

#L<S06/Placeholder variables/>

sub one_placeholder {
    is $^bla,  2, "A single placeholder works";
}

one_placeholder(2);

sub two_placeholders {
    is $^b, 2, "Second lexicographic placeholder gets second parameter";
    is $^a, 1, "First lexicographic placeholder gets first parameter";
}

two_placeholders(1, 2);

sub non_twigil {
    is $^foo, 5, "A single placeholder (still) works";
    is $foo, 5, "It also has a corresponding non-twigil variable";
}

non_twigil(5);

eval_dies_ok( ' {$foo; $^foo;}(1) ',
'A non-twigil variable should not precede a corresponding twigil variable' );

# RT #64310
eval_dies_ok ' {my $foo; $^foo;}(1) ', 'my $foo; $^foo; is an illegal redeclaration';

# RT #74778
{
    my $tracker = '';
    for 1, 2 {
        $tracker ~= $^a ~ $^a ~ '|';
    }
    is $tracker, '11|22|', 'two occurrences of $^a count as one param';
}

# RT #99734
{
    sub rt99734 { "$^c is $^a and $^b" };
    is rt99734("cake", "tasty", "so on"), 'so on is cake and tasty',
       'RT 99734';
}

# RT #73688
{
    sub inner(*@a) { @a.join(', ') };
    sub outer { &^c($^a, $^b)  };
    is outer('x', 'y', &inner), 'x, y',
        'can have invocable placeholder with arguments';
}

# RT #123470
throws_like 'my $a; sub weird{ $a = 42; $^a * 2 }', X::Placeholder::NonPlaceholder,
    :variable_name<$a>,
    :placeholder<$^a>,
    :decl<sub>,
    ;

# RT #123470
#?rakudo.parrot todo 'throws Adhoc'
throws_like 'my $a; my $block = { $a = 42; $^a * 2 }', X::Placeholder::NonPlaceholder,
    :variable_name<$a>,
    :placeholder<$^a>,
    ;

# vim: syn=perl6
