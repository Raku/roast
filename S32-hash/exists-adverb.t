use v6;

use Test;

plan 34;

# L<S02/Names and Variables/:exists>

#-------------------------------------------------------------------------------
# initialisations

my $default = Any;
my $dont    = False;

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

#?pugs skip "no adverbials"
{
    my %h = gen_hash;
    is %h.elems, 26, "basic sanity";

    isa_ok %h<b>:exists, Bool, "Bool test for exists single key";
    isa_ok %h<X>:exists, Bool, "Bool test for non-exists single key";
    ok     %h<b>:exists,       "Test for exists single key";
    ok   !(%h<X>:exists),      "Test for non-exists single key";

    #?niecza  8 todo "adverbial pairs only used as True"
    ok !(%h<c>:!exists),       "Test non-exists with ! single key c";
    ok   %h<X>:!exists,        "Test non-exists with ! single key X";
    ok !(%h<c>:exists(0)),     "Test non-exists with (0) single key c";
    ok   %h<X>:exists(0),      "Test non-exists with (0) single key X";
    ok !(%h<c>:exists(False)), "Test non-exists with (False) single key c";
    ok   %h<X>:exists(False),  "Test non-exists with (False) single key X";
    ok !(%h<c>:exists($dont)), "Test non-exists with (\$dont) single key c";
    ok   %h<X>:exists($dont),  "Test non-exists with (\$dont) single key X";
    ok   %h<c>:exists(1),      "Test exists with (1) single key c";
    ok !(%h<X>:exists(1)),     "Test exists with (1) single key X";

    is_deeply %h<c d e>:exists,  (True, True, True),   "Test exists TTT";
    is_deeply %h<c d X>:exists,  (True, True, False),  "Test exists TTF";
    is_deeply %h{*}:exists,      (True  xx 26).Parcel, "Test non-exists T*";
    #?niezca 3 todo "adverbial pairs only used as True"
    is_deeply %h<c d e>:!exists, (False,False,False),  "Test non-exists FFF";
    is_deeply %h<c d X>:!exists, (False,False,True),   "Test non-exists FFT";
    is_deeply %h{*}:!exists,     (False xx 26).Parcel, "Test non-exists F*";

    #?niezca 6 todo "no combined adverbial pairs"
    is_deeply %h<c d e>:exists:kv,
      ("c",True,"d",True,"e",True),                     "Test exists:kv TTT";
    is_deeply %h<c d X>:exists:kv,
      ("c",True,"d",True),                              "Test exists:kv TT.";
    is_deeply %h<c d X>:exists:!kv,
      ("c",True,"d",True,"X",False),                    "Test exists:kv TTF";
    is_deeply %h<c d e>:!exists:kv,
      ("c",False,"d",False,"e",False),                  "Test exists:kv FFF";
    is_deeply %h<c d X>:!exists:kv,
      ("c",False,"d",False),                            "Test exists:kv FF.";
    is_deeply %h<c d X>:!exists:!kv,
      ("c",False,"d",False,"X",True),                   "Test exists:kv FFT";

    #?niezca 6 todo "no combined adverbial pairs"
    is_deeply %h<c d e>:exists:p,
      (c=>True,d=>True,e=>True),                     "Test exists:p TTT";
    is_deeply %h<c d X>:exists:p,
      (c=>True,d=>True),                             "Test exists:p TT.";
    is_deeply %h<c d X>:exists:!p,
      (c=>True,d=>True,X=>False),                    "Test exists:p TTF";
    is_deeply %h<c d e>:!exists:p,
      (c=>False,d=>False,e=>False),                  "Test exists:p FFF";
    is_deeply %h<c d X>:!exists:p,
      (c=>False,d=>False),                           "Test exists:p FF.";
    is_deeply %h<c d X>:!exists:!p,
      (c=>False,d=>False,X=>True),                   "Test exists:p FFT";

    is %h.elems, 26, "should not have changed hash";
} #34

# vim: ft=perl6
