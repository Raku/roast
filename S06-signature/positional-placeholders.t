use v6;
use Test;

plan 12;

#L<S06/Placeholder variables/>

sub one_placeholder is test-assertion {
    is $^bla,  2, "A single placeholder works";
}

one_placeholder(2);

sub two_placeholders is test-assertion {
    is $^b, 2, "Second lexicographic placeholder gets second parameter";
    is $^a, 1, "First lexicographic placeholder gets first parameter";
}

two_placeholders(1, 2);

sub non_twigil is test-assertion {
    is $^foo, 5, "A single placeholder (still) works";
    is $foo, 5, "It also has a corresponding non-twigil variable";
}

non_twigil(5);

throws-like ' {$foo; $^foo;}(1) ', X::Undeclared,
    'A non-twigil variable should not precede a corresponding twigil variable';

# https://github.com/Raku/old-issue-tracker/issues/847
throws-like ' {my $foo; $^foo;}(1) ', X::Redeclaration,
    'my $foo; $^foo; is an illegal redeclaration';

# https://github.com/Raku/old-issue-tracker/issues/1733
{
    my $tracker = '';
    for 1, 2 {
        $tracker ~= $^a ~ $^a ~ '|';
    }
    is $tracker, '11|22|', 'two occurrences of $^a count as one param';
}

# https://github.com/Raku/old-issue-tracker/issues/2478
{
    sub rt99734 { "$^c is $^a and $^b" };
    is rt99734("cake", "tasty", "so on"), 'so on is cake and tasty',
       'RT #99734';
}

# https://github.com/Raku/old-issue-tracker/issues/1614
{
    sub inner(*@a) { @a.join(', ') };
    sub outer { &^c($^a, $^b)  };
    is outer('x', 'y', &inner), 'x, y',
        'can have invocable placeholder with arguments';
}

# https://github.com/Raku/old-issue-tracker/issues/3616
throws-like 'my $a; sub weird{ $a = 42; $^a * 2 }', X::Placeholder::NonPlaceholder,
    :variable_name<$a>,
    :placeholder<$^a>,
    :decl<sub>,
    ;

# https://github.com/Raku/old-issue-tracker/issues/3616
throws-like 'my $a; my $block = { $a = 42; $^a * 2 }', X::Placeholder::NonPlaceholder,
    :variable_name<$a>,
    :placeholder<$^a>,
    ;

# vim: expandtab shiftwidth=4
