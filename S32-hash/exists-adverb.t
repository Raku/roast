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
    is %h1<c >d e>:exists,  (True, True, True),  "Test for exists TTT";
    is %h1<c d X>:exists,  (True, True, False), "Test for exists TTF";
    is %h1{*}:exists,  (True  xx 26), "Test for non-exists T*";
    #?niezca 3 todo "adverbial pairs only used as True"
    is %h1<c d e>:!exists, (False,False,False), "Test for non-exists FFF";
    is %h1<c d X>:!exists, (False,False,True),  "Test for non-exists FFT";
    is %h1{*}:!exists, (False xx 26), "Test for non-exists F*";

    is +%h1, 26, "should not have changed hash";
} #20

#-------------------------------------------------------------------------------
# Array

{
    my @a = gen_array;
    is @a.elems, 10, "basic sanity";

    #?pugs   2 skip "no adverbials"
    #?niecza 2 skip "no adverbials"
    ok @a[3]:exists,     "Test for exists single element";
    ok !(@a[10]:exists), "Test for non-exists single element";

    #?pugs   10 skip "no adverbials"
    #?niecza 10 skip "no adverbials"
    ok @a[9]:!exists,           "Test non-exists with ! single elem 9";
    ok !(@a[10]:!exists),       "Test non-exists with ! single elem 10";
    ok @a[9]:exists(0),         "Test non-exists with (0) single elem 9";
    ok !(@a[10]:exists(0)),     "Test non-exists with (0) single elem 10";
    ok @a[9]:exists(False),     "Test non-exists with (False) single elem 9";
    ok !(@a[10]:exists(False)), "Test non-exists with (False) single elem 10";
    ok @a[9]:exists($dont),     "Test non-exists with (\$dont) single elem 9";
    ok !(@a[10]:exists($dont)), "Test non-exists with (\$dont) single elem 10";
    ok @a[9]:exists(1),         "Test exists with (1) single elem 9";
    ok !(@a[10]:exists(1)),     "Test exists with (1) single elem 10";

    #?pugs   6 skip "no adverbials"
    #?rakudo 6 skip "oh noes, it dies"
    is @a[1,2,4]:exists,   (True, True, True),  "Test for exists TTT";
    is @a[1,2,10]:exists,  (True, True, False), "Test for exists TTF";
    is @a[*]:exists,  (True  xx 26), "Test for non-exists T*";
    #?niezca 3 todo "adverbial pairs only used as True"
    is @a[1,2,4]:!exists,  (False,False,False), "Test for non-exists FFF";
    is @a[1,2,10]:!exists, (False,False,True),  "Test for non-exists FFT";
    is @a[*]:!exists, (False xx 26), "Test for non-exists F*";

    is +@a, 10,                    "* should be deleted now";
} #20

#-------------------------------------------------------------------------------
# Scalar

#TBD

done;

# vim: ft=perl6
