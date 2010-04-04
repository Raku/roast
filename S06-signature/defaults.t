use v6;

use Test;

=begin description

Tests assigning default values to variables of type code in sub definitions.

=end description

# L<S06/Optional parameters/Default values can be calculated at run-time>

plan 3;

sub doubler($x) { return 2 * $x }

sub value_v(Code $func = &doubler) {
    return $func(5);
}

is(value_v, 10, "default sub called");
is value_v({3 * $_ }), 15, "default sub can be overridden";

package MyPack {

    sub double($x) { return 2 * $x }

    our sub val_v(Code :$func = &double) is export {
        return $func(5);
    }

}


ok((MyPack::val_v), "default sub called in package namespace");

# vim: ft=perl6
