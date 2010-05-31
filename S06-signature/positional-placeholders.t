use v6;
use Test;

plan 8;

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

#?rakudo todo 'non-twigil variable before twigil variable'
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
    is $tracker, '11|22|', 'two occurences of $^a count as one param';
}

# vim: syn=perl6
