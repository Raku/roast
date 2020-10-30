use v6;
use Test;

plan 3;

#L<S06/Placeholder variables/>

sub one_placeholder is test-assertion {
    is $:bla,  2, "A single named placeholder works";
}

one_placeholder(:bla(2));

sub two_placeholders is test-assertion {
    is $:b, 1, "Named dispatch isn't broken for placeholders";
    is $:a, 2, "Named dispatch isn't broken for placeholders";
}

two_placeholders(:a(2), :b(1));

# vim: expandtab shiftwidth=4
