use v6;

use Test;

=begin description

Tests assigning default values to variables of type code in sub definitions.

=end description

# L<S06/Optional parameters/Default values can be calculated at run-time>

plan 8;

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


{
    sub default_with_list($x = (1, 2)) {
        $x[0];
    }
    is default_with_list(), 1, 'can have a parcel literal as default value';
}

# RT #69200
{
    sub rt69200(Bool :$x) { $x };
    is rt69200(:x), True, '":x" is the same as "x => True" in sub call';
}

# RT #118063
{
    sub a ( $a=1 --> Hash ) {  my %h = ($a => "foo") };
    ok a(2)<2> :exists,
        'no comma required between parameter with default value and returns-arrow ("-->")';
    sub b ( $b=1, --> Hash ) {  my %h = ($b => "foo") };
    ok b(2)<2> :exists,
        'comma allowed between parameter with default value and returns-arrow ("-->")';
}

# RT #123176
{
    is -> $a = 0 { $a }(42), 42, "default lambda parameters don't choke on block";
}

# vim: ft=perl6
