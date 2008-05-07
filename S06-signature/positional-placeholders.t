use v6;
use Test;

plan 3;

#L<S06/Placeholder variables/>

sub one_placeholder {
    is $^bla,  2, "A single placeholder works";
}

one_placeholder(2);

sub two_placeholders {
    is $^b, 2, "Second lexicographic placeholder gets second parameter";
    is $^a, 1, "Frist lexicographic placeholder gets first parameter";
}

two_placeholders(1, 2);


# vim: syn=perl6
