use v6;

use Test;

=begin kwid

Parse problem when pod inside a multi-line hash-def expression.

=end kwid

plan 3;

my $mysub = {

    1;

=begin pod

=end pod

};

ok "anon sub def parses when pod block is within it"; # TODO: complete this test

my $myhash = {

    'baz' => 3,

=begin pod

=end pod

};

ok "anon hash def parses when pod block is within it"; # TODO: complete this test

my $myary = [

    4,

=begin pod

=end pod

];

ok "anon array def parses when pod block is within it"; # TODO: complete this test

# vim: ft=perl6
