use v6;

use Test;

plan 38;

# L<S02/Names and Variables/:delete>

#-------------------------------------------------------------------------------
# initialisations

my $default = Any;
my $dont    = False;
sub gen_array { (1..10).list }

#-------------------------------------------------------------------------------
# Array

{ # basic sanity
    my @a = gen_array;
    is @a.elems, 10, "do we have a valid array";
} #1

{ # single element
    my @a = gen_array;
    my $b = @a[3];

    #?pugs   3 skip "no adverbials"
    #?niecza 3 skip "no adverbials"
    is @a[3]:delete, $b, "Test for delete single element";
    is @a[3], $default,  "3 should be deleted now";
    is +@a, 10,          "array still has same length";

    #?pugs   11 skip "no adverbials"
    #?niecza 11 skip "no adverbials"
    my $c = @a[9];
    is @a[9]:!delete, $c,       "Test non-deletion with ! single elem";
    is @a[9], $c,               "9 should not have been deleted";
    is @a[9]:delete(0), $c,     "Test non-deletion with (0) single elem";
    is @a[9], $c,               "9 should not have been deleted";
    is @a[9]:delete(False), $c, "Test non-deletion with (False) single elem";
    is @a[9], $c,               "9 should not have been deleted";
    is @a[9]:delete($dont), $c, "Test non-deletion with (\$dont) single elem";
    is @a[9], $c,               "9 should not have been deleted";
    is @a[9]:delete(1), $c,     "Test deletion with (1) single elem";
    is @a[9], $default,         "9 should be deleted now";
    is +@a, 9,                  "array should be shortened now";
} #14

{ # multiple elements
    my Int @a = gen_array;
    my $b = @a[1,3];

    #?pugs   3 skip "no adverbials"
    #?niecza 3 skip "no adverbials"
    is_deeply @a[1,3]:delete, $b, "Test for delete multiple elements";
    is_deeply @a[1,3], (Int,Int), "1 3 should be deleted now";
    is +@a, 10,                   "1 3 should be deleted now";

    #?pugs   11 skip "no adverbials"
    #?niecza 11 skip "no adverbials"
    my $c = @a[2,4,9];
    is_deeply @a[2,4,9]:!delete,       $c, "Test non-deletion with ! N";
    is_deeply @a[2,4,9],               $c, "2 4 9 should not have been deleted";
    is_deeply @a[2,4,9]:delete(0),     $c, "Test non-deletion with (0) N";
    is_deeply @a[2,4,9],               $c, "2 4 9 should not have been deleted";
    is_deeply @a[2,4,9]:delete(False), $c, "Test non-deletion with (False) N";
    is_deeply @a[2,4,9],               $c, "2 4 9 should not have been deleted";
    is_deeply @a[2,4,9]:delete($dont), $c, "Test non-deletion with (\$dont) N";
    is_deeply @a[2,4,9],               $c, "2 4 9 should not have been deleted";
    is_deeply @a[2,4,9]:delete(1),     $c, "Test deletion with (1) N";
    is_deeply @a[2,4,9], (Int,Int,Int), "2 4 9 should be deleted now";
    is +@a, 9,                          "array should be shortened now";
} #14

{ # whatever
    my @a   = gen_array;
    my $all = @a[^@a.elems];

    #?pugs   2 skip "no adverbials"
    #?niecza 2 skip "no adverbials"
    is_deeply @a[*]:delete, $all, "Test deletion with whatever";
    is +@a, 0,                    "* should be deleted now";
} #2

{
    my @a   = gen_array;
    my $all = @a[^@a.elems];

    #?pugs   10 skip "no adverbials"
    #?niecza 10 skip "no adverbials"
    is_deeply @a[*]:!delete,       $all, "Test non-deletion with ! *";
    is_deeply @a[*]:delete(0),     $all, "Test non-deletion with (0) *";
    is_deeply @a[*]:delete(False), $all, "Test non-deletion with (False) *";
    is_deeply @a[*]:delete($dont), $all, "Test non-deletion with (\$dont) *";

    is +@a, 10,                      "* should not be deleted now";
    is_deeply @a[*]:delete(1), $all, "Test deletion with (1) whatever";
    is +@a, 0,                       "* should be deleted now";
} #7

# vim: ft=perl6
