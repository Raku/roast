use v6;
use Test;

# test odd things we've seen with modules, packages and namespaces


# the module declaration is executed at compile time,
# so we need to plan early
BEGIN { plan 3 };

module A {
    if 1 {
        ok 1, '"if" inside a module works';
    } else {
        ok 0, '"if" inside a module works';
    }

    my $x = 0;
    for <a b c> {
        $x++;
    }
    is $x, 3, 'for loop inside a module works';

    sub b { 42 };
    is EVAL('b'), 42,
       'EVAL inside a module looks up subs in the right namespace';
}

# vim: ft=perl6
