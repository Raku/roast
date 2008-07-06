use v6;

use Test;

#L<S06/Placeholder variables/>

plan 12;

sub t {
    is $^tene, 3, "Placeholder vars work";
    is $:DietCoke, 6, "Placeholder vars work";
    is $^chromatic, 1, "Placeholder vars work";
    is $:moritz, 4, "Placeholder vars work";
    is $^mncharity, 2, "Placeholder vars work";
    is $:TimToady, 5, "Placeholder vars work";
    is @_[1], 8, "Placeholder vars work";
    is %_<bar>, 11, "Placeholder vars work";
    is @_[0], 7, "Placeholder vars work";
    is %_<foo>, 10, "Placeholder vars work";
    is @_[2], 9, "Placeholder vars work";
    is %_<baz>, 12, "Placeholder vars work";
}

t(1, 2, 3, :moritz(4), :TimToady(5), :DietCoke(6), 7, 8, 9, :foo(10), :bar(11), :baz(12));
