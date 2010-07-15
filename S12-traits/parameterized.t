use v6;

use Test;

plan 8;

=begin pod

Parameterized traits tests, see L<S14/Traits>.

=end pod

# L<S14/Traits>
# Basic definition
role cool {
    has $.cool;

    multi sub trait_auxiliary:<is>(cool $trait, Any $container; $val) {   #OK not used
        $.cool = $val;
        $container does cool($val);
    }
}

my $a = 42;
is           $a, 42, "basic sanity (1)";
lives_ok {$a does cool(23)},   "imperative does worked (1)";
is $a.cool,      23,   "attribute was set correctly (1)";

my $b = 23;
is           $b, 23, "basic sanity (2)";
ok $b does cool("hi"), "imperative does worked (2)";
is $b.cool,      "hi", "attribute was set correctly (2)";

# vim: ft=perl6
