use v6;

use Test;

plan 48;

# L<S02/Names and Variables/:exists>

#-------------------------------------------------------------------------------
# initialisations

my $default = Any;
my $dont    = False;

sub gen_hash {
    my %h;
    my $i = 0;
    for 'a'..'z' { %h{$_} = ++$i; }
    return %h;
}

#-------------------------------------------------------------------------------
# Hash

{
    my %h = gen_hash;
    is %h.elems, 26, "basic sanity";

    isa-ok %h<b>:exists, Bool,  "Bool test for exists single key";
    isa-ok %h<b>:!exists, Bool, "!Bool test for exists single key";
    isa-ok %h<X>:exists, Bool,  "Bool test for non-exists single key";
    isa-ok %h<X>:!exists, Bool, "!Bool test for non-exists single key";
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

    is-deeply %h<c d e>:exists,  (True, True, True),   "Test exists TTT";
    is-deeply %h<c d X>:exists,  (True, True, False),  "Test exists TTF";
    is-deeply %h{}:exists,       (True  xx 26).List, "Test exists T{}";
    is-deeply %h{*}:exists,      (True  xx 26).List, 'Test exists T{*}';
    #?niezca 3 todo "adverbial pairs only used as True"
    is-deeply %h<c d e>:!exists, (False,False,False),  "Test non-exists FFF";
    is-deeply %h<c d X>:!exists, (False,False,True),   "Test non-exists FFT";
    is-deeply %h{}:!exists,      (False xx 26).List, "Test non-exists F{}";
    is-deeply %h{*}:!exists,     (False xx 26).List, 'Test non-exists F{*}';

    #?niezca 6 todo "no combined adverbial pairs"
    is-deeply %h<c d e>:exists:kv,
      ("c",True,"d",True,"e",True),                     "Test exists:kv TTT";
    is-deeply %h<c d X>:exists:kv,
      ("c",True,"d",True),                              "Test exists:kv TT.";
    is-deeply %h<c d X>:exists:!kv,
      ("c",True,"d",True,"X",False),                    "Test exists:kv TTF";
    is-deeply %h<c d e>:!exists:kv,
      ("c",False,"d",False,"e",False),                  "Test exists:kv FFF";
    is-deeply %h<c d X>:!exists:kv,
      ("c",False,"d",False),                            "Test exists:kv FF.";
    is-deeply %h<c d X>:!exists:!kv,
      ("c",False,"d",False,"X",True),                   "Test exists:kv FFT";

    #?niezca 6 todo "no combined adverbial pairs"
    is-deeply %h<c d e>:exists:p,
      (c=>True,d=>True,e=>True),                     "Test exists:p TTT";
    is-deeply %h<c d X>:exists:p,
      (c=>True,d=>True),                             "Test exists:p TT.";
    is-deeply %h<c d X>:exists:!p,
      (c=>True,d=>True,X=>False),                    "Test exists:p TTF";
    is-deeply %h<c d e>:!exists:p,
      (c=>False,d=>False,e=>False),                  "Test exists:p FFF";
    is-deeply %h<c d X>:!exists:p,
      (c=>False,d=>False),                           "Test exists:p FF.";
    is-deeply %h<c d X>:!exists:!p,
      (c=>False,d=>False,X=>True),                   "Test exists:p FFT";

    #?niezca 6 todo "no combined adverbial pairs"
    dies-ok { %h<c>:exists:k },    "Test exists:k,   invalid combo";
    dies-ok { %h<c>:exists:!k },   "Test exists:!k,  invalid combo";
    dies-ok { %h<c>:!exists:k },   "Test !exists:k,  invalid combo";
    dies-ok { %h<c>:!exists:!k },  "Test !exists:!k, invalid combo";

    #?niezca 6 todo "no combined adverbial pairs"
    dies-ok { %h<c>:exists:v },    "Test exists:v,   invalid combo";
    dies-ok { %h<c>:exists:!v },   "Test exists:!v,  invalid combo";
    dies-ok { %h<c>:!exists:v },   "Test !exists:v,  invalid combo";
    dies-ok { %h<c>:!exists:!v },  "Test !exists:!v, invalid combo";

    is %h.elems, 26, "should not have changed hash";

    my %multi-dim := { 1 => { 2 => { 3 => 42 } } };
    isa-ok %multi-dim{1;2;3}:exists, Bool, "Bool test for literal multi dim key;"
} #46

# RT #122497
{
    BEGIN my %cache = 1 => 0;
    sub foo($n) {%cache{$n}:exists}
    is foo(42), False,
        'no internal error with :exists adverb on non existing key of hash initialized at BEGIN time';
}

# vim: ft=perl6
