use v6;

use Test;

# L<S02/Names and Variables/:exists>

#-------------------------------------------------------------------------------
# initialisations

my $default = Any;
my $dont    = False;
sub gen_array { (1..10).list }

sub gen_hash {

    # alas not supported by pugs
    #return ("a".."z" Z 1..26).hash;

    my %h;
    my $i = 0;
    for 'a'..'z' { %h{$_} = ++$i; }
    return %h;
}

#-------------------------------------------------------------------------------
# Hash

{
    my %h1 = gen_hash;
    is +%h1, 26, "basic sanity";

    #?pugs 2 skip "no adverbials"
    ok %h1<b>:exists,    "Test for exists single key";
    ok !(%h1<X>:exists), "Test for non-exists single key";

    #?pugs   10 skip "no adverbials"
    #?niecza  8 todo "adverbial pairs only used as True"
    ok !(%h1<c>:!exists),       "Test non-exists with ! single key c";
    ok %h1<X>:!exists,          "Test non-exists with ! single key X";
    ok !(%h1<c>:exists(0)),     "Test non-exists with (0) single key c";
    ok %h1<X>:exists(0),        "Test non-exists with (0) single key X";
    ok !(%h1<c>:exists(False)), "Test non-exists with (False) single key c";
    ok %h1<X>:exists(False),    "Test non-exists with (False) single key X";
    ok !(%h1<c>:exists($dont)), "Test non-exists with (\$dont) single key c";
    ok %h1<X>:exists($dont),    "Test non-exists with (\$dont) single key X";
    ok %h1<c>:exists(1),        "Test exists with (1) single key c";
    ok !(%h1<X>:exists(1)),     "Test exists with (1) single key X";

    #?pugs   6 skip "no adverbials"
    #?rakudo 6 skip "oh noes, it dies"
    is %h1<c d e>:exists,  (True, True, True),  "Test for exists TTT";
    is %h1<c d X>:exists,  (True, True, False), "Test for exists TTF";
    is %h1{*}>:exists,  (True  xx 26), "Test for non-exists T*";
    #?niezca 3 todo "adverbial pairs only used as True"
    is %h1<c d e>:!exists, (False,False,False), "Test for non-exists FFF";
    is %h1<c d X>:!exists, (False,False,True),  "Test for non-exists FFT";
    is %h1{*}>:!exists, (False xx 26), "Test for non-exists F*";

    is +%h1, 26, "should not have changed hash";
} #20

#-------------------------------------------------------------------------------
# Array

{
    my @a = gen_array;
    is @a.elems, 10, "basic sanity";
} #1

{ # single element
    my @a = gen_array;
    my $b = @a[3];

    #?pugs   3 skip "no adverbials"
    #?niecza 3 skip "no adverbials"
    is @a[3]:delete, $b, "Test for delete single element";
    #?rakudo todo "not being destructively read yet"
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
    #?rakudo 2 todo "not being destructively read yet"
    is @a[9], $default,         "9 should be deleted now";
    is +@a, 9,                  "array should be shortened now";
} #14

{ # multiple elements
    my @a = gen_array;
    my @b = @a[1,3];

    #?pugs   3 skip "no adverbials"
    #?niecza 3 skip "no adverbials"
    is @a[1,3]:delete, @b, "Test for delete multiple elements";
    #?rakudo todo "not being destructively read yet"
    is @a[1,3], $default, "1 3 should be deleted now";
    is +@a, 10,           "1 3 should be deleted now";

    #?pugs   11 skip "no adverbials"
    #?niecza 11 skip "no adverbials"
    my @c = @a[2,4,9];
    is @a[2,4,9]:!delete, @c,       "Test non-deletion with ! multiple";
    is @a[2,4,9], @c,               "2 4 9 should not have been deleted";
    is @a[2,4,9]:delete(0), @c,     "Test non-deletion with (0) multiple";
    is @a[2,4,9], @c,               "2 4 9 should not have been deleted";
    is @a[2,4,9]:delete(False), @c, "Test non-deletion with (False) multiple";
    is @a[2,4,9], @c,               "2 4 9 should not have been deleted";
    is @a[2,4,9]:delete($dont), @c, "Test non-deletion with (\$dont) multiple";
    is @a[2,4,9], @c,               "2 4 9 should not have been deleted";
    is @a[2,4,9]:delete(1), @c,     "Test deletion with (1) multiple";
    #?rakudo 2 todo "not being destructively read yet"
    ok !any(@a[2,4,9]),             "2 4 9 should be deleted now";
    is +@a, 9,                      "array should be shortened now";
} #14

{ # whatever
    my @a   = gen_array;
    my @all = @a[^10];

    #?pugs   2 skip "no adverbials"
    #?niecza 2 skip "no adverbials"
    is @a[*]:delete, @all, "Test deletion with whatever";
    #?rakudo todo "not being destructively read yet"
    is +@a, 0,             "* should be deleted now";
} #2

{
    my @a   = gen_array;
    my @all = @a[^10];

    #?pugs   10 skip "no adverbials"
    #?niecza 10 skip "no adverbials"
    is @a[*]:!delete, @all,       "Test non-deletion with ! whatever";
    is +@a, 10,                   "* should not be deleted now";
    is @a[*]:delete(0), @all,     "Test non-deletion with (0) whatever";
    is +@a, 10,                   "* should not be deleted now";
    is @a[*]:delete(False), @all, "Test non-deletion with (False) whatever";
    is +@a, 10,                   "* should not be deleted now";
    is @a[*]:delete($dont), @all, "Test non-deletion with (\$dont) whatever";
    is +@a, 10,                   "* should not be deleted now";
    is @a[*]:delete(1), @all,     "Test deletion with (1) whatever";
    #?rakudo todo "not being destructively read yet"
    is +@a, 0,                    "* should be deleted now";
} #10

#-------------------------------------------------------------------------------
# Scalar

#TBD

done;

# vim: ft=perl6
