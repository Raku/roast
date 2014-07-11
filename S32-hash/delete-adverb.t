use v6;

use Test;

plan 130;

# L<S02/Names and Variables/:delete>

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

{ # basic sanity
    my %h = gen_hash;
    is +%h, 26, "basic sanity";
} #1

{ # single key
    my Int %h = gen_hash;
    my $b = %h<b>;

    is %h<b>:delete, $b, "Test for delete single key";
    ok !defined(%h<b>),  "b hould be deleted now";
    is +%h, 25,          "b should be deleted now by count";

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
    is +%h, 24,                 "c should be deleted now by count";

    my $d = %h<d>:p;
    #?niecza 3 todo "cannot combine adverbial pairs"
    is_deeply %h<d>:p:!delete, $d,       "return a single pair out";
    ok %h<d>:exists,                     "d should not have been deleted";
    is_deeply %h<d>:p:delete,  $d,       "slice a single pair out";
    ok !defined(%h<d>),                  "d should be deleted now";
    #?niecza 2 todo "cannot combine adverbial pairs"
    is_deeply %h<d>:p:delete,  (),       "slice unexisting single pair out";
    is_deeply %h<d>:!p:delete, (d=>Int), "slice unexisting single pair out";

    my $e= ("e", %h<e>);
    #?niecza 6 todo "cannot combine adverbial pairs"
    is_deeply %h<e>:kv:!delete, $e,        "return a single key/value out";
    ok %h<e>:exists,                       "e should not have been deleted";
    is_deeply %h<e>:kv:delete,  $e,        "slice a single key/value out";
    ok %h<e>:!exists,                      "e should be deleted now";
    is_deeply %h<e>:kv:delete,  (),        "slice unexisting single key/value";
    is_deeply %h<e>:!kv:delete, ('e',Int), "slice unexisting single key/value";

    #?niecza 6 todo "cannot combine adverbial pairs"
    is %h<f>:k:!delete,      'f', "return a single key out";
    ok %h<f>:exists,              "f should not have been deleted";
    is %h<f>:k:delete,       'f', "slice a single key out";
    ok %h<f>:!exists,             "f should be deleted now";
    is_deeply %h<f>:k:delete, (), "slice unexisting single key";
    is %h<f>:!k:delete,      'f', "slice unexisting single key";

    my $g= %h<g>;
    #?niecza 6 todo "cannot combine adverbial pairs"
    is %h<g>:v:!delete,        $g,  "return a single value out";
    ok %h<g>:exists,                "g should not have been deleted";
    is %h<g>:v:delete,         $g,  "slice a single value out";
    ok %h<g>:!exists,               "g should be deleted now";
    is_deeply %h<g>:v:delete,  (),  "slice unexisting single key";
    is %h<g>:!v:delete,        Int, "slice unexisting single key";
} #38

{ # single key, combinations with :exists
    my %h = gen_hash;

    #?niecza 4 todo "cannot combine adverbial pairs"
    ok (%h<b>:delete:exists) === True,  "d:exists single existing key";
    ok %h<b>:!exists,                   "b should be deleted now";
    ok (%h<b>:delete:exists) === False, "b:exists one non-existing key";
    ok (%h<b>:delete:!exists) === True, "b:!exists one non-existing key";

    #?niecza 6 todo "cannot combine adverbial pairs"
    is_deeply %h<d>:delete:!exists:kv, ("d",False), "d:exists:kv 1 ekey";
    ok %h<d>:!exists,                               "d should be deleted now";
    is_deeply %h<d>:delete:exists:!kv, ("d",False), "1 nekey d:exists:!kv";
    is_deeply %h<d>:delete:!exists:!kv, ("d",True), "1 nekey d:!exists:!kv";
    is_deeply %h<d>:delete:exists:kv, (),           "1 nekey d:exists:kv";
    is_deeply %h<d>:delete:!exists:kv, (),          "1 nekey d:!exists:kv";

    #?niecza 6 todo "cannot combine adverbial pairs"
    is_deeply %h<e>:delete:!exists:p, (e=>False), "d:exists:p 1 ekey";
    ok %h<e>:!exists,                             "e should be deleted now";
    is_deeply %h<e>:delete:exists:!p, (e=>False), "1 nekey exists:!p";
    is_deeply %h<e>:delete:!exists:!p, (e=>True), "1 nekey !exists:!p";
    is_deeply %h<e>:delete:exists:p, (),          "1 nekey exists:p";
    is_deeply %h<e>:delete:!exists:p, (),         "1 nekey !exists:p";
} #16

{ # multiple key, not with :exists
    my Int %h   = gen_hash;
    my @cde = %h<c d e>;

    is %h<c d e>:delete, @cde, "Test for delete multiple keys";
    ok !any(%h<c d e>),        "c d e should be deleted now";
    is +%h, 23,                "c d e should be deleted now by count";

    #?niecza 11 todo "adverbial pairs only used as boolean True"
    my $fg = %h<f g>;
    is_deeply %h<f g>:!delete, $fg,       "non-deletion with ! mult";
    is_deeply %h<f g>, $fg,               "f g should not have been deleted";
    is_deeply %h<f g>:delete(0), $fg,     "non-deletion with (0) mult";
    is_deeply %h<f g>, $fg,               "f g should not have been deleted";
    is_deeply %h<f g>:delete(False), $fg, "non-deletion with (False) mult";
    is_deeply %h<f g>, $fg,               "f g should not have been deleted";
    is_deeply %h<f g>:delete($dont), $fg, "non-deletion with (\$dont) multi";
    is_deeply %h<f g>, $fg,               "f g should not have been deleted";
    is_deeply %h<f g>:delete(1), $fg,     "deletion with (1) multi";
    is_deeply %h<f g>, (Int,Int),         "f g should be deleted now";
    is +%h, 21,                           "f g should be deleted now by count";

    my $hi = %h<h i>:p;
    #?niecza 3 todo "cannot combine adverbial pairs"
    is_deeply %h<h i>:p:!delete, $hi, "return pairs";
    is %h<h i>:p, $hi,                "h i should not have been deleted";
    is_deeply %h<h i>:p:delete,  $hi, "slice pairs out";
    is +%h, 19,                       "h i should be deleted now by count";
} #18

{ # multiple keys, combinations with :exists
    my %h = gen_hash;

    #?niecza 8 todo "cannot combine adverbial pairs"
    is_deeply %h<b c>:!delete:exists, (True,True),  "!d:exists ekeys";
    is_deeply %h<b c>:delete:exists, (True,True),   "d:exists ekeys";
    ok %h<b>:!exists,                               "b should be deleted now";
    ok %h<c>:!exists,                               "c should be deleted now";
    is_deeply %h<b c>:delete:exists, (False,False), "d:exists nekeys";
    is_deeply %h<b c>:delete:!exists, (True,True),  "d:!exists nekeys";
    is_deeply %h<a b>:delete:exists, (True,False),  "d:exists nekeys";
    is_deeply %h<c x>:delete:!exists, (True,False), "d:!exists nekeys";

    #?niecza 8 todo "cannot combine adverbial pairs"
    is_deeply %h<e f>:!delete:!exists:kv,
      ("e",False,"f",False),              "!d:!exists:kv ekeys";
    is_deeply %h<e f>:delete:!exists:kv,
      ("e",False,"f",False),              "d:!exists:kv ekeys";
    ok %h<e>:!exists,                     "e should be deleted now";
    ok %h<f>:!exists,                     "f should be deleted now";
    is_deeply %h<e f>:delete:exists:!kv,
      ("e",False,"f",False),              "d:exists:!kv nekeys";
    is_deeply %h<e f>:delete:!exists:!kv,
      ("e",True,"f",True),                "d:!exists:!kv nekeys";
    is_deeply %h<e g>:delete:exists:kv,
      ("g",True),                         "d:exists:kv nekey/ekey";
    is_deeply %h<h e>:delete:!exists:kv,
      ("h",False),                        "d:!exists:kv ekey/nekey";

    #?niecza 8 todo "cannot combine adverbial pairs"
    is_deeply %h<m n>:!delete:!exists:p,
      (m=>False,n=>False),                "!d:!exists:p ekeys";
    is_deeply %h<m n>:delete:!exists:p,
      (m=>False,n=>False),                "d:!exists:p ekeys";
    ok %h<m>:!exists,                     "m should be deleted now";
    ok %h<n>:!exists,                     "n should be deleted now";
    is_deeply %h<m n>:delete:exists:!p,
      (m=>False,n=>False),                "d:exists:!p nekeys";
    is_deeply %h<m n>:delete:!exists:!p,
      (m=>True,n=>True),                  "d:!exists:!p nekeys";
    is_deeply %h<m o>:delete:exists:p,
      ((),o=>True),                       "d:exists:p nekey/ekey";
    is_deeply %h<p n>:delete:!exists:p,
      (p=>False,()),                      "d:!exists:p ekey/nekey";
} #24

{ # whatever
    my %h   = gen_hash;
    my @all = %h{ %h.keys };

    is %h{*}:delete, @all, "Test deletion with whatever";
    is +%h, 0,             "* should be deleted now";
} #2

{
    my %h   = gen_hash;
    my $all = %h{ %h.keys };

    #?niecza 10 todo "adverbial pairs only used as boolean True"
    is_deeply %h{*}:!delete, $all,       "Test non-deletion with ! *";
    is_deeply %h{*}:delete(0), $all,     "Test non-deletion with (0) *";
    is_deeply %h{*}:delete(False), $all, "Test non-deletion with (False) *";
    is_deeply %h{*}:delete($dont), $all, "Test non-deletion with (\$dont) *";
    is_deeply +%h, 26,                   "* should not be deleted now";
    is_deeply %h{*}:delete(1), $all,     "Test deletion with (1) *";
    is_deeply +%h, 0,                    "* should be deleted now by count";
} #7

{
    my %h = gen_hash;
    my %i = %h.clone;

    #?niecza 4 todo "cannot combine adverbial pairs"
    is %h{*}:p:!delete, %i, "return all pairs";
    is +%h, 26,             "* should not be deleted";
    is %h{*}:p:delete,  %i, "slice out all pairs";
    is +%h, 0,             "* should be deleted now";
} #4

{
    my %h  = gen_hash;
    my @i  = True  xx %h.keys;
    my @ni = False xx %h.keys;

    #?niecza 4 todo "cannot combine adverbial pairs"
    is %h{*}:!delete:exists, @i,  "!d:exists whatever";
    is +%h, 26,                   "* should not be deleted";
    is %h{*}:delete:!exists, @ni, "d:!exists whatever";
    is +%h, 0,                    "* should be deleted now";
} #4

{
    my %h  = gen_hash;
    my @i  = map { ($_,True) },  %h.keys;
    my @ni = map { ($_,False) }, %h.keys;

    #?niecza 4 todo "cannot combine adverbial pairs"
    is %h{*}:!delete:exists:kv, @i,  ":!d:exists:kv whatever";
    is +%h, 26,                      "* should not be deleted";
    is %h{*}:delete:!exists:kv, @ni, "d:!exists:kv whatever";
    is +%h, 0,                       "* should be deleted now";

    %h = gen_hash;
    #?niecza 4 todo "cannot combine adverbial pairs"
    is %h{*}:!delete:exists:!kv, @i,  ":!d:exists:!kv whatever";
    is +%h, 26,                      "* should not be deleted";
    is %h{*}:delete:!exists:!kv, @ni, "d:!exists:!kv whatever";
    is +%h, 0,                       "* should be deleted now";
} #8

{
    my %h  = gen_hash;
    my %i  = map { $_ => True },  %h.keys;
    my %ni = map { $_ => False }, %h.keys;

    #?niecza 4 todo "cannot combine adverbial pairs"
    is %h{*}:!delete:exists:p, %i,  ":!d:exists:p whatever";
    is +%h, 26,                     "* should not be deleted";
    is %h{*}:delete:!exists:p, %ni, "d:!exists:p whatever";
    is +%h, 0,                      "* should be deleted now";

    %h = gen_hash;
    #?niecza 4 todo "cannot combine adverbial pairs"
    is %h{*}:!delete:exists:!p, %i,  ":!d:exists:!p whatever";
    is +%h, 26,                     "* should not be deleted";
    is %h{*}:delete:!exists:!p, %ni, "d:!exists:!p whatever";
    is +%h, 0,                      "* should be deleted now";
} #8

# vim: ft=perl6
