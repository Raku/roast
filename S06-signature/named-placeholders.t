use v6;
use Test;

plan 1;

#L<S06/Placeholder variables/>

sub one_placeholder {
    is $:bla,  2, "A single named placeholder works";
}

one_placeholder(:bla(2));

# vim: syn=perl6
