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
    my %h = gen_hash;
    is +%h, 26, "basic sanity";
} #1

{ # single key
    my %h = gen_hash;
    my $b = %h<b>;

    #?pugs 3 skip "no adverbials"
    is %h<b>:delete, $b, "Test for delete single key";
    ok !defined(%h<b>),  "b hould be deleted now";
    is +%h, 25,          "b should be deleted now";

    #?pugs   11 skip "no adverbials"
    #?niecza 11 todo "adverbial pairs only used as boolean True"
    my $c = %h<c>;
    is %h<c>:!delete, $c,       "Test non-deletion with ! single key";
    is %h<c>, $c,               "c should not have been deleted";
    is %h<c>:delete(0), $c,     "Test non-deletion with (0) single key";
    is %h<c>, $c,               "c should not have been deleted";
    is %h<c>:delete(False), $c, "Test non-deletion with (False) single key";
    is %h<c>, $c,               "c should not have been deleted";
    is %h<c>:delete($dont), $c, "Test non-deletion with (\$dont) single key";
    is %h<c>, $c,               "c should not have been deleted";
    is %h<c>:delete(1), $c,     "Test deletion with (1) single key";
    ok !defined(%h<c>),         "c should be deleted now";
    is +%h, 24,                 "c should be deleted now";

    my $d = %h<d>:p;
    #?pugs   4 skip "no adverbials"
    #?niecza 3 todo "cannot combine adverbial pairs"
    is_deeply %h<d>:p:!delete, $d, "return a single key/value out";
    #?rakudo 2 todo "cannot combine adverbial pairs"
    is %h<d>, $d,                  "d should not have been deleted";
    is_deeply %h<d>:p:delete,  $d, "slice a single key/value out";
    ok !defined(%h<d>),            "d should be deleted now";
} #18

{ # multiple key
    my %h   = gen_hash;
    my @cde = %h<c d e>;

    #?pugs 3 skip "no adverbials"
    is %h<c d e>:delete, @cde, "Test for delete multiple keys";
    ok !any(%h<c d e>),        "c d e should be deleted now";
    is +%h, 23,                "c d e should be deleted now";

    #?pugs   11 skip "no adverbials"
    #?niecza 11 todo "adverbial pairs only used as boolean True"
    my $fg = %h<f g>;
    is_deeply %h<f g>:!delete, $fg,       "non-deletion with ! mult";
    is_deeply %h<f g>, $fg,               "f g should not have been deleted";
    is_deeply %h<f g>:delete(0), $fg,     "non-deletion with (0) mult";
    is_deeply %h<f g>, $fg,               "f g should not have been deleted";
    is_deeply %h<f g>:delete(False), $fg, "non-deletion with (False) mult";
    is_deeply %h<f g>, $fg,               "f g should not have been deleted";
    is_deeply %h<f g>:delete($dont), $fg, "non-deletion with (\$dont) mult";
    is_deeply %h<f g>, $fg,               "f g should not have been deleted";
    is_deeply %h<f g>:delete(1), $fg,     "deletion with (1) mult";
    is_deeply %h<f g>, (Any,Any),         "f g should be deleted now";
    is +%h, 21,                           "f g should be deleted now";

    my $hi = %h<h i>:p;
    #?pugs   4 skip "no adverbials"
    #?niecza 3 todo "cannot combine adverbial pairs"
    #?rakudo 3 todo "cannot combine adverbial pairs"
    is_deeply %h<h i>:p:!delete, $hi, "return pairs";
    is %h<h i>, $hi,                  "h i should not have been deleted";
    is_deeply %h<h i>:p:delete,  $hi, "slice pairs out";
    is +%h, 19,                       "h i should be deleted now";
} #18

{ # whatever
    my %h   = gen_hash;
    my @all = %h{ "a".."z" };

    #?pugs 2 skip "no adverbials"
    is %h{*}:delete, @all, "Test deletion with whatever";
    is +%h, 0,             "* should be deleted now";
} #2

{
    my %h   = gen_hash;
    my $all = %h{ "a".."z" };

    #?pugs   10 skip "no adverbials"
    #?niecza 10 todo "adverbial pairs only used as boolean True"
    is_deeply %h{*}:!delete, $all,       "Test non-deletion with ! *";
    is_deeply %h{*}:delete(0), $all,     "Test non-deletion with (0) *";
    is_deeply %h{*}:delete(False), $all, "Test non-deletion with (False) *";
    is_deeply %h{*}:delete($dont), $all, "Test non-deletion with (\$dont) *";
    is_deeply +%h, 26,               "* should not be deleted now";
    is_deeply %h{*}:delete(1), $all, "Test deletion with (1) *";
    is_deeply +%h, 0,                "* should be deleted now";
} #7

{
    my %h   = gen_hash;
    my %i   = %h.clone;

    #?pugs   2 skip "no adverbials"
    #?rakudo 3 todo "cannot combine adverbial pairs"
    #?niecza 3 todo "cannot combine adverbial pairs"
    is %h{*}:p:!delete, %i, "return all pairs";
    is +%h, 26,             "* should not be deleted";
    is %h{*}:p:delete,  %i, "slice out all pairs";
    is +%h, 0,             "* should be deleted now";
} #4

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
