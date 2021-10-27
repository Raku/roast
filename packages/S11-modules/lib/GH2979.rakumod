use v6;
use GH2979-Foo;

our @b;
our %b;
our $b;
sub b { }

multi EXPORT {
    Map.new(
        GH2979-Foo::EXPORT::ALL::,
        '@bar' => @b,
        '%bar' => %b,
        '$bar' => $b,
        '&bar' => &b,
    )
}

# vim: expandtab shiftwidth=4
