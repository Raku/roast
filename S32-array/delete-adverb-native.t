use v6;

use Test;

plan 138;

# THIS IS A COPY OF S32-array/delete-adverb.t, WITH ALL MULTIPLE ELEMENT TESTS
# REMOVED AND THE REMAINING TESTS CHANGED SO THAT THEY USE A native int AS THE
# PARAMETER FOR THE POSITION.

# L<S02/Names and Variables/:delete> using native keys

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
    my Int @a = gen_array;
    my $b     = @a[my int$=3];

    #?pugs   3 skip "no adverbials"
    #?niecza 3 skip "no adverbials"
    is @a[my int$=3]:delete, $b, "Test for delete single element";
    is @a[my int$=3], $default,  "3 should be deleted now";
    is +@a, 10,          "array still has same length";

    #?pugs   11 skip "no adverbials"
    #?niecza 11 skip "no adverbials"
    my $c = @a[my int$=9];
    is @a[my int$=9]:!delete, $c,       "Test non-deletion with ! single elem";
    is @a[my int$=9], $c,               "9 should not have been deleted";
    is @a[my int$=9]:delete(0), $c,     "Test non-deletion with (0) single elem";
    is @a[my int$=9], $c,               "9 should not have been deleted";
    is @a[my int$=9]:delete(False), $c, "Test non-deletion with (False) single elem";
    is @a[my int$=9], $c,               "9 should not have been deleted";
    is @a[my int$=9]:delete($dont), $c, "Test non-deletion with (\$dont) single elem";
    is @a[my int$=9], $c,               "9 should not have been deleted";
    is @a[my int$=9]:delete(1), $c,     "Test deletion with (1) single elem";
    is @a[my int$=9], $default,         "9 should be deleted now";
    is +@a, 9,                  "array should be shortened now";

    my $d = @a[my int$=8]:p;
    #?pugs   7 skip "no adverbials"
    #?niecza 3 todo "cannot combine adverbial pairs"
    is_deeply @a[my int$=8]:p:!delete, $d,       "return a single pair out";
    ok @a[my int$=8]:exists,                     "8 should not have been deleted";
    is_deeply @a[my int$=8]:p:delete,  $d,       "slice a single pair out";
    ok !defined(@a[my int$=8]),                  "8 should be deleted now";
    #?niecza 3 todo "cannot combine adverbial pairs"
    is_deeply @a[my int$=8]:p:delete,  (),       "slice unexisting single pair out";
    is_deeply @a[my int$=8]:!p:delete, (8=>Int), "slice unexisting single pair out";
    is @a.elems, 8, "should have been shortened";

    my $e= (7, @a[my int$=7]);
    #?pugs   7 skip "no adverbials"
    #?niecza 7 todo "cannot combine adverbial pairs"
    is_deeply @a[my int$=7]:kv:!delete, $e,      "return a single elem/value out";
    ok @a[my int$=7]:exists,                     "7 should not have been deleted";
    is_deeply @a[my int$=7]:kv:delete,  $e,      "slice a single elem/value out";
    ok @a[my int$=7]:!exists,                    "7 should be deleted now";
    is_deeply @a[my int$=7]:kv:delete,  (),      "slice unexisting single elem/value";
    is_deeply @a[my int$=7]:!kv:delete, (7,Int), "slice unexisting single elem/value";
    is @a.elems, 7, "should have been shortened";

    #?pugs   7 skip "no adverbials"
    #?niecza 7 todo "cannot combine adverbial pairs"
    is @a[my int$=6]:k:!delete,        6, "return a single elem out";
    ok @a[my int$=6]:exists,              "6 should not have been deleted";
    is @a[my int$=6]:k:delete,         6, "slice a single elem out";
    ok @a[my int$=6]:!exists,             "6 should be deleted now";
    is_deeply @a[my int$=6]:k:delete, (), "slice unexisting single elem";
    is @a[my int$=6]:!k:delete,        6, "slice unexisting single elem";
    is @a.elems, 6, "should have been shortened";

    my $g= @a[my int$=5];
    #?pugs   7 skip "no adverbials"
    #?niecza 7 todo "cannot combine adverbial pairs"
    is @a[my int$=5]:v:!delete,        $g, "return a single value out";
    ok @a[my int$=5]:exists,               "5 should not have been deleted";
    is @a[my int$=5]:v:delete,         $g, "slice a single value out";
    ok @a[my int$=5]:!exists,              "5 should be deleted now";
    is_deeply @a[my int$=5]:v:delete,  (), "slice unexisting single elem";
    is @a[my int$=5]:!v:delete,       Int, "slice unexisting single elem";
    is @a.elems, 5, "should have been shortened";
} #42

{ # single elem, combinations with :exists
    my @a = gen_array;

    #?pugs   5 skip "no adverbials"
    #?niecza 5 todo "cannot combine adverbial pairs"
    ok (@a[my int$=9]:delete:exists) === True,  "9:exists single existing elem";
    ok @a[my int$=9]:!exists,                   "9 should be deleted now";
    ok (@a[my int$=9]:delete:exists) === False, "9:exists one non-existing elem";
    ok (@a[my int$=9]:delete:!exists) === True, "9:!exists one non-existing elem";
    is @a.elems, 9, "should have been shortened";

    #?pugs   7 skip "no adverbials"
    #?niecza 7 todo "cannot combine adverbial pairs"
    is_deeply @a[my int$=8]:delete:!exists:kv, (8,False), "8:exists:kv 1 eelem";
    ok @a[my int$=8]:!exists,                             "8 should be deleted now";
    is_deeply @a[my int$=8]:delete:exists:!kv, (8,False), "1 neelem d:exists:!kv";
    is_deeply @a[my int$=8]:delete:!exists:!kv, (8,True), "1 neelem d:!exists:!kv";
    is_deeply @a[my int$=8]:delete:exists:kv, (),         "1 neelem d:exists:kv";
    is_deeply @a[my int$=8]:delete:!exists:kv, (),        "1 neelem d:!exists:kv";
    is @a.elems, 8, "should have been shortened";

    #?pugs   7 skip "no adverbials"
    #?niecza 7 todo "cannot combine adverbial pairs"
    is_deeply @a[my int$=7]:delete:!exists:p, (7=>False), "7:exists:p 1 eelem";
    ok @a[my int$=7]:!exists,                             "7 should be deleted now";
    is_deeply @a[my int$=7]:delete:exists:!p, (7=>False), "1 neelem exists:!p";
    is_deeply @a[my int$=7]:delete:!exists:!p, (7=>True), "1 neelem !exists:!p";
    is_deeply @a[my int$=7]:delete:exists:p, (),          "1 neelem exists:p";
    is_deeply @a[my int$=7]:delete:!exists:p, (),         "1 neelem !exists:p";
    is @a.elems, 7, "should have been shortened";
} #19

{
    my @a is default(42);
    is @a[my int $=0]:delete, 42,  ':delete non-existing';
    is @a.elems, 0,       'should not vivify';
    is @a[my int $=0]:!delete, 42, ':!delete non-existing';
    is @a.elems, 0,       'should not vivify';

    is @a[my int $=0]:delete:exists, False,  ':delete:exists non-existing';
    is @a.elems, 0,                 'should not vivify';
    is @a[my int $=0]:!delete:exists, False, ':!delete:exists non-existing';
    is @a.elems, 0,                 'should not vivify';

    is @a[my int $=0]:delete:!exists, True,  ':delete:!exists non-existing';
    is @a.elems, 0,                 'should not vivify';
    is @a[my int $=0]:!delete:!exists, True, ':!delete:!exists non-existing';
    is @a.elems, 0,                 'should not vivify';

    is @a[my int $=0]:delete:exists:kv, (),   ':delete:exists:kv non-existing';
    is @a.elems, 0,                  'should not vivify';
    is @a[my int $=0]:!delete:exists:kv, (),  ':!delete:exists:kv non-existing';
    is @a.elems, 0,                  'should not vivify';

    is @a[my int $=0]:delete:!exists:kv, (),  ':delete:!exists:kv non-existing';
    is @a.elems, 0,                  'should not vivify';
    is @a[my int $=0]:!delete:!exists:kv, (), ':!delete:!exists:kv non-existing';
    is @a.elems, 0,                  'should not vivify';

    is @a[my int $=0]:delete:exists:!kv, (0,False),  ':delete:exists:!kv non-existing';
    is @a.elems, 0,                         'should not vivify';
    is @a[my int $=0]:!delete:exists:!kv, (0,False), ':!delete:exists:!kv non-existing';
    is @a.elems, 0,                         'should not vivify';

    is @a[my int $=0]:delete:!exists:!kv, (0,True),  ':delete:!exists:!kv non-existing';
    is @a.elems, 0,                         'should not vivify';
    is @a[my int $=0]:!delete:!exists:!kv, (0,True), ':!delete:!exists:!kv non-existing';
    is @a.elems, 0,                         'should not vivify';

    is @a[my int $=0]:delete:exists:p, (),   ':delete:exists:p non-existing';
    is @a.elems, 0,                 'should not vivify';
    is @a[my int $=0]:!delete:exists:p, (),  ':!delete:exists:p non-existing';
    is @a.elems, 0,                 'should not vivify';

    is @a[my int $=0]:delete:!exists:p, (),  ':delete:!exists:p non-existing';
    is @a.elems, 0,                 'should not vivify';
    is @a[my int $=0]:!delete:!exists:p, (), ':!delete:!exists:p non-existing';
    is @a.elems, 0,                 'should not vivify';

    is @a[my int $=0]:delete:exists:!p, (0=>False),  ':delete:exists:!p non-existing';
    is @a.elems, 0,                         'should not vivify';
    is @a[my int $=0]:!delete:exists:!p, (0=>False), ':!delete:exists:!p non-existing';
    is @a.elems, 0,                         'should not vivify';

    is @a[my int $=0]:delete:!exists:!p, (0=>True),  ':delete:!exists:!p non-existing';
    is @a.elems, 0,                         'should not vivify';
    is @a[my int $=0]:!delete:!exists:!p, (0=>True), ':!delete:!exists:!p non-existing';
    is @a.elems, 0,                         'should not vivify';

    is @a[my int $=0]:exists:kv, (),         ':exists:kv non-existing';
    is @a.elems, 0,                 'should not vivify';
    is @a[my int $=0]:!exists:kv, (),        ':!exists:kv non-existing';
    is @a.elems, 0,                 'should not vivify';

    is @a[my int $=0]:exists:!kv, (0,False), ':exists:!kv non-existing';
    is @a.elems, 0,                 'should not vivify';
    is @a[my int $=0]:!exists:!kv, (0,True), ':!exists:!kv non-existing';
    is @a.elems, 0,                 'should not vivify';

    is @a[my int $=0]:exists:p, (),          ':exists:p non-existing';
    is @a.elems, 0,                 'should not vivify';
    is @a[my int $=0]:!exists:p, (),         ':!exists:p non-existing';
    is @a.elems, 0,                 'should not vivify';

    is @a[my int $=0]:exists:!p, (0=>False), ':exists:!p non-existing';
    is @a.elems, 0,                 'should not vivify';
    is @a[my int $=0]:!exists:!p, (0=>True), ':!exists:!p non-existing';
    is @a.elems, 0,                 'should not vivify';

    is @a[my int $=0]:kv, (),      ':kv non-existing';
    is @a.elems, 0,       'should not vivify';
    is @a[my int $=0]:!kv, (0,42), ':!kv non-existing';
    is @a.elems, 0,       'should not vivify';

    is @a[my int $=0]:p, (),       ':p non-existing';
    is @a.elems, 0,       'should not vivify';
    is @a[my int $=0]:!p, (0=>42), ':!p non-existing';
    is @a.elems, 0,       'should not vivify';

    is @a[my int $=0]:k, (), ':k non-existing';
    is @a.elems, 0, 'should not vivify';
    is @a[my int $=0]:!k, 0, ':!k non-existing';
    is @a.elems, 0, 'should not vivify';

    is @a[my int $=0]:v, (),  ':v non-existing';
    is @a.elems, 0,  'should not vivify';
    is @a[my int $=0]:!v, 42, ':!v non-existing';
    is @a.elems, 0,  'should not vivify';
} #86
# vim: ft=perl6
