use v6;

use Test;

# L<S02/Names and Variables/:delete>

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

{ # basic sanity
    my %h1 = gen_hash;
    is +%h1, 26, "basic sanity";
} #1

{ # single key
    my %h1 = gen_hash;
    my $b  = %h1<b>;

    #?pugs 3 skip "no adverbials"
    is %h1<b>:delete, $b, "Test for delete single key";
    ok !defined(%h1<b>),  "b hould be deleted now";
    is +%h1, 25,          "b should be deleted now";

    #?pugs   11 skip "no adverbials"
    #?niecza 11 todo "adverbial pairs only used as boolean True"
    my $c = %h1<c>;
    is %h1<c>:!delete, $c,       "Test non-deletion with ! single key";
    #?rakudo 8 todo "adverbial pairs only used as boolean True"
    is %h1<c>, $c,               "c should not have been deleted";
    is %h1<c>:delete(0), $c,     "Test non-deletion with (0) single key";
    is %h1<c>, $c,               "c should not have been deleted";
    is %h1<c>:delete(False), $c, "Test non-deletion with (False) single key";
    is %h1<c>, $c,               "c should not have been deleted";
    is %h1<c>:delete($dont), $c, "Test non-deletion with (\$dont) single key";
    is %h1<c>, $c,               "c should not have been deleted";
    is %h1<c>:delete(1), $c,     "Test deletion with (1) single key";
    ok !defined(%h1<c>),         "c should be deleted now";
    is +%h1, 24,                 "c should be deleted now";
} #14

{ # multiple key
    my %h1  = gen_hash;
    my @cde = %h1<c d e>;

    #?pugs 3 skip "no adverbials"
    is %h1<c d e>:delete, @cde, "Test for delete multiple keys";
    ok !any(%h1<c d e>),        "c d e should be deleted now";
    is +%h1, 23,                "c d e should be deleted now";

    #?pugs   11 skip "no adverbials"
    #?niecza 11 todo "adverbial pairs only used as boolean True"
    my $fg = %h1<f g>;
    is_deeply %h1<f g>:!delete, $fg,       "non-deletion with ! mult";
    #?rakudo 8 todo "adverbial pairs only used as boolean True"
    is_deeply %h1<f g>, $fg,               "f g should not have been deleted";
    is_deeply %h1<f g>:delete(0), $fg,     "non-deletion with (0) mult";
    is_deeply %h1<f g>, $fg,               "f g should not have been deleted";
    is_deeply %h1<f g>:delete(False), $fg, "non-deletion with (False) mult";
    is_deeply %h1<f g>, $fg,               "f g should not have been deleted";
    is_deeply %h1<f g>:delete($dont), $fg, "non-deletion with (\$dont) mult";
    is_deeply %h1<f g>, $fg,               "f g should not have been deleted";
    is_deeply %h1<f g>:delete(1), $fg,     "deletion with (1) mult";
    is_deeply %h1<f g>, (Any,Any),         "f g should be deleted now";
    is +%h1, 21,                           "f g should be deleted now";
} #14

{ # whatever
    my %h1  = gen_hash;
    my @all = %h1{ "a".."z" };

    #?pugs 2 skip "no adverbials"
    is %h1{*}:delete, @all, "Test deletion with whatever";
    is +%h1, 0,             "* should be deleted now";
} #2

{
    my %h1  = gen_hash;
    my $all = %h1{ "a".."z" };

    #?pugs   10 skip "no adverbials"
    #?niecza 10 todo "adverbial pairs only used as boolean True"
    is_deeply %h1{*}:!delete, $all,       "Test non-deletion with ! *";
    #?rakudo 5 todo "adverbial pairs only used as boolean True"
    is_deeply %h1{*}:delete(0), $all,     "Test non-deletion with (0) *";
    is_deeply %h1{*}:delete(False), $all, "Test non-deletion with (False) *";
    is_deeply %h1{*}:delete($dont), $all, "Test non-deletion with (\$dont) *";
    is_deeply +%h1, 26,               "* should not be deleted now";
    is_deeply %h1{*}:delete(1), $all, "Test deletion with (1) *";
    is_deeply +%h1, 0,                "* should be deleted now";
} #10

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
    my $b = @a[1,3];

    #?pugs   3 skip "no adverbials"
    #?niecza 3 skip "no adverbials"
    is_deeply @a[1,3]:delete, $b, "Test for delete multiple elements";
    #?rakudo todo "not being destructively read yet"
    is_deeply @a[1,3], (Any xx 2), "1 3 should be deleted now";
    is +@a, 10,                    "1 3 should be deleted now";

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
    #?rakudo 2 todo "not being destructively read yet"
    is_deeply @a[2,4,9], (Any xx 3), "2 4 9 should be deleted now";
    is +@a, 9,                       "array should be shortened now";
} #14

{ # whatever
    my @a   = gen_array;
    my $all = @a[^10];

    #?pugs   2 skip "no adverbials"
    #?niecza 2 skip "no adverbials"
    is_deeply @a[*]:delete, $all, "Test deletion with whatever";
    #?rakudo todo "not being destructively read yet"
    is +@a, 0,                    "* should be deleted now";
} #2

{
    my @a   = gen_array;
    my $all = @a[^10];

    #?pugs   10 skip "no adverbials"
    #?niecza 10 skip "no adverbials"
    is_deeply @a[*]:!delete,       $all, "Test non-deletion with ! *";
    is_deeply @a[*]:delete(0),     $all, "Test non-deletion with (0) *";
    is_deeply @a[*]:delete(False), $all, "Test non-deletion with (False) *";
    is_deeply @a[*]:delete($dont), $all, "Test non-deletion with (\$dont) *";

    is +@a, 10,                      "* should not be deleted now";
    is_deeply @a[*]:delete(1), $all, "Test deletion with (1) whatever";
    #?rakudo todo "not being destructively read yet"
    is +@a, 0,                       "* should be deleted now";
} #10

#-------------------------------------------------------------------------------
# Scalar

#TBD

done;

# vim: ft=perl6
