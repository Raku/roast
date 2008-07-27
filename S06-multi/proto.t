use v6;
use Test;
plan 3;
# Test for proto definitions

# L<S03/"Reduction operators">

proto prefix:<[+]> (*@args) {
    my $accum = 0;
    $accum += $_ for @args;
    return $accum * 2; # * 2 is intentional here
}

is ([+] 1,2,3), 12, "[+] overloaded by proto definition";

# more similar tests

proto prefix:<moose> ($arg) { $arg + 1 }
is (moose 3), 4, "proto definition of prefix:<moose> works";

proto prefix:<elk> ($arg) {...}
multi prefix:<elk> ($arg) { $arg + 1 }
is (elk 3), 4, "multi definition of prefix:<elk> works";
