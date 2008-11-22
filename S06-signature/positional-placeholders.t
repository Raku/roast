use v6;
use Test;

plan 5;

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
#?rakudo 2 skip 'Not yet implemented'
    is $^foo, 5, "A single placeholder (still) works";
    is $foo, 5, "It also has a corresponding non-twigil variable";
}

non_twigil(5);

# vim: syn=perl6
