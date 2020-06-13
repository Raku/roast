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

is $mysub(), 1, "anon sub def parses when pod block is within it";

my $myhash = {

    'baz' => 3,

=begin pod

=end pod

};

is $myhash<baz>, 3, "anon hash def parses when pod block is within it";

my $myarray = [

    4,

=begin pod

=end pod

];

is $myarray[0], 4, "anon array def parses when pod block is within it";

# vim: expandtab shiftwidth=4
