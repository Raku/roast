use v6;

use Test;

=begin pod

Tests that each level bind tighter than the next by sampling some ops.

In between each precedence level are some tests that demonstrate the
proper separation of the two levels.

L<S03/Operator precedence>

=end pod

plan 51;


# terms

# FIXME how do we test this?

# postfix method

my @a = 1,2,3;
is(++@a[2], 4, "bare postfix binds tighter than ++");
is(++@a.[2], 5, "dotted postfix binds tighter than ++");

# autoincrement

my $i = 2;
is(++$i ** 2, 9, "++ bind tighter than **");
is(--$i ** 2, 4, "-- does too");

# exponentiation

is(-2**2, -4, "** bind tighter than unary -");
isa_ok(~2**4, "Str", "~4**4 is a string");

# symbolic unary

is(!0 * 2, 2, "unary ! binds tighter than *");
is(!(0 * 2), 1, "beh");
is(?2*2, 2, "binary -> numify causes reinterpretation as, binds tighter than *");

# multiplicative

is(4 + 3 * 2, 10, "* binds tighter than binary +");
is(2 - 2 / 2, 1, "/ binds tighter than binary -");

# additive

is(1 ~ 2 * 3, 16, "~ binds looser than *");
ok((1 ~ 2 & 12) == 12, "but tighter than &");
ok((2 + 2 | 4 - 1) == 4, "and + binds tighter than |");

# replication

is(2 x 2 + 3, "22222", "x binds looser than binary +");
is((2 x 2) + 3, 25, "doublecheck");

# concatenation

is(2 x 2 ~ 3, "223", "x binds tighter than binary ~");
ok((2 ~ 2 | 4 ~ 1) == 41, "and ~ binds tighter than |");

# junctive and

ok(  ?(   (1 & 2 | 3) !=3), '& binds tighter than |');
#?rakudo skip "Negate a junction (???)"
ok((!(1 & 2 | 3) < 2), "ditto");
ok(?((1 & 2 ^ 3) < 3), "and also ^");
#?rakudo skip "Negate a junction (???)"
ok(     !(1 & 2 ^ 4) != 3, "blah blah blah");

# junctive or

{ # test that | and ^ are on the same level
    my $a = (1 | 2 ^ 3);
    my $b = (1 ^ 2 | 3);

    ok($a == 3, "only one is eq 3");
    ok($a != 3, "either is ne 3");
    ok($a == 1, "either is eq 1");
    ok($b == 2, "either is eq 2, ne 3");
    ok($b == 1, "either is eq 1");
    ok($b == 3, "either is eq 3, of which only one is");
    ok(!($b != 3), "1 is ne 3, and (2 | 3) is both ne 3 and eq 3, so it's ne, so 1 ^ 2 | 3");
};

#?rakudo skip "Junction autothreading"
{
    my $a = (abs -1 ^ -1); # read as abs(-1 ^ -1) -> (1^1)
    ok(!($a == 1), 'junctive or binds more tightly then abs (1)');

    my $b = ((abs -1) ^ -1); # -> (1 ^ -1)
    ok($b == 1, "this is true because only one is == 1");
};

# named unary

is((abs -1 .. 3), (1 .. 3), "abs binds tighter than ..");
#is((rand 3 <=> 5), -1, "rand binds tighter than <=>");   # XXX rand N is obsolete

# nonchaining

ok(0 < 2 <=> 1 < 2, "0 < 2 <=> 1 < 2 means 0 < 1 < 2");

# chaining

is((0 != 1 && "foo"), "foo", "!= binds tighter than &&");
ok((0 || 1 == (2-1) == (0+1) || "foo") ne "foo", "== binds tighter than || also when chaning");

# tight and (&&)

# tight or (||, ^^, //)

is((1 && 0 ?? 2 !! 3), 3, "&& binds tighter than ??");
### FIXME - need also ||, otherwise we don't prove || and ?? are diff

# conditional

{
    my $a = 0 ?? "yes" !! "no";
    is($a, "no", "??!! binds tighter than =");
#    (my $b = 1) ?? "true" !! "false";
#    is($b, 1, "?? !! just thrown away with = in parens");
};


# item assignment

# XXX this should be a todo, not a skip, but that
# messes up the rest of the file, somehow :(
#?rakudo skip 'item assignment'
{
    my $c = 1, 2, 3;
    is($c, 1, '$ = binds tighter than ,');
    my $a = (1, 3) X (2, 4);
    is($a, [1, 3], "= binds tighter than X");
}

# loose unary

my $x;
is((true $x = 42), 1, "item assignment is tighter than true");

# comma

is(((not 1,42)[1]), 42, "not is tighter than comma");

# list infix

#?rakudo skip 'list infix and assignment'
#?pugs todo 'list infix and assignment'
{
    my @d;
    ok eval('@d = 1,3 Z 2,4'), "list infix tighter than list assignment, looser t than comma";
    is(@d, [1 .. 4], "to complicate things further, it dwims");
}

{
    my @b;
    eval('@b = ((1, 3) Z (2, 4))');
    is(@b, [1 .. 4], "parens work around this");
};

# list prefix

{
    my $c;
    eval('$c = any 1, 2, Z 3, 4');
    ok($c == 3, "any is less tight than comma and Z");
}

my @c = 1, 2, 3;
is(@c, [1,2,3], "@ = binds looser than ,");

# loose and

{
    my $run = 1;
    sub isfive (*@args) {
        is(@args[0], 5, "First arg is 5, run " ~ $run++);
        1;
    }

    # these are two tests per line, actually
    # we should have a better way that doesn't just result in 
    # a wrong plan if gone wrong.
    isfive(5) and isfive(5);
    isfive 5  and isfive 5;
}

# loose or

# terminator

# uc|ucfirst|lc|lcfirst
# t/builtins/strings/uc|ucfirst|lc|lcfirst.t didn't compile because of this bug.
# Compare:
#   $ perl -we 'print uc "a" eq "A"'
#   1
# opposed to Pugs parses it:
#   $ perl -we 'print uc("a" eq "A")'
#   $    (no output)
ok (uc "a" eq "A"), "uc has the correct precedence in comparision to eq";

