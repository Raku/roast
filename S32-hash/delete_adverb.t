use v6;

use Test;

# L<S02/Names and Variables/:delete>

#-------------------------------------------------------------------------------
# Hash

sub gen_hash {

    # alas not supported by pugs
    #return ("a".."z" Z 1..26).hash;

    my %h;
    my $i = 0;
    for 'a'..'z' { %h{$_} = ++$i; }
    return %h;
}

{ # basic sanity
    my %h1 = gen_hash;
    is +%h1, 26, "basic sanity";
}

{ # single key
    my %h1 = gen_hash;
    my $b  = %h1<b>;

    is %h1<b>:delete, $b, "Test for delete single key";
    ok !defined(%h1<b>),  "b hould be deleted now";
    is +%h1, 25,          "b should be deleted now";

    #?pugs   9 todo "adverbial pairs only used as boolean True"
    #?niecza 9 todo "adverbial pairs only used as boolean True"
    my $c = %h1<c>;
    is %h1<c>:!delete, $c,       "Test non-deletion with ! single key";
    is %h1<c>, $c,               "c should not have been deleted";
    is %h1<c>:delete(0), $c,     "Test non-deletion with (0) single key";
    is %h1<c>, $c,               "c should not have been deleted";
    is %h1<c>:delete(False), $c, "Test non-deletion with (False) single key";
    is %h1<c>, $c,               "c should not have been deleted";
    is %h1<c>:delete(1), $c,     "Test deletion with (1) single key";
    ok !defined(%h1<c>),         "c should be deleted now";
    is +%h1, 24,                 "c should be deleted now";
}

{ # multiple key
    my %h1  = gen_hash;
    my @cde = %h1<c d e>;

    is %h1<c d e>:delete, @cde, "Test for delete multiple keys";
    ok !any(%h1<c d e>),        "c d e should be deleted now";
    is +%h1, 23,                "c d e should be deleted now";

    #?pugs   9 todo "adverbial pairs only used as boolean True"
    #?niecza 9 todo "adverbial pairs only used as boolean True"
    my @fg = %h1<f g>;
    is %h1<f g>:!delete, @fg,       "Test non-deletion with ! multiple";
    is %h1<f g>, @fg,               "f g should not have been deleted";
    is %h1<f g>:delete(0), @fg,     "Test non-deletion with (0) multiple";
    is %h1<f g>, @fg,               "f g should not have been deleted";
    is %h1<f g>:delete(False), @fg, "Test non-deletion with (False) multiple";
    is %h1<f g>, @fg,               "f g should not have been deleted";
    is %h1<f g>:delete(1), @fg,     "Test deletion with (1) multiple";
    ok !any(%h1<f g>),              "f g should be deleted now";
    is +%h1, 21,                    "f g should be deleted now";
}

{ # whatever
    my %h1  = gen_hash;
    my @all = %h1{ "a".."z" };

    is %h1{*}:delete, @all, "Test deletion with whatever";
    is +%h1, 0,             "* should be deleted now";
}

{
    my %h1  = gen_hash;
    my @all = %h1{ "a".."z" };

    #?pugs   9 todo "adverbial pairs only used as boolean True"
    #?niecza 9 todo "adverbial pairs only used as boolean True"
    is %h1{*}:!delete, @all,       "Test non-deletion with ! whatever";
    is +%h1, 26,                   "* should not be deleted now";
    is %h1{*}:delete(0), @all,     "Test non-deletion with (0) whatever";
    is +%h1, 26,                   "* should not be deleted now";
    is %h1{*}:delete(False), @all, "Test non-deletion with (False) whatever";
    is +%h1, 26,                   "* should not be deleted now";
    is %h1{*}:delete(1), @all,     "Test deletion with (1) whatever";
    is +%h1, 0,                    "* should be deleted now";
}

#-------------------------------------------------------------------------------
# Array

#TBD

#-------------------------------------------------------------------------------
# Scalar

#TBD

done;

# vim: ft=perl6
