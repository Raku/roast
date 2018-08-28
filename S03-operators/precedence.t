use v6;
use lib $?FILE.IO.parent(2).add: 'packages';
use Test;
use Test::Util;

# L<S03/Operator precedence>

=begin pod

Tests that each level bind tighter than the next by sampling some ops.

In between each precedence level are some tests that demonstrate the
proper separation of the two levels.

=end pod

plan 77;


# terms

# FIXME how do we test this?

# postfix method
{
    my @a = 1,2,3;
    is(++@a[2], 4, "bare postfix binds tighter than ++");
    is(++@a.[2], 5, "dotted postfix binds tighter than ++");
}

# autoincrement
{
    my $i = 2;
    is(++$i ** 2, 9, "++ bind tighter than **");
    is(--$i ** 2, 4, "-- does too");
}

# exponentiation

is(-2**2, -4, "** bind tighter than unary -");
isa-ok(~2**4, Str, "~2**4 is a string");

# symbolic unary

is(!0 * 2, 2, "unary ! binds tighter than *");
ok(!(0 * 2), "beh");
is(?2*2, 2, "binary -> numify causes reinterpretation as, binds tighter than *");

is -2**2 . abs, 4, "on left side . is looser than ** and left-to-right with unary -";
is -2**2 . abs + 1, 5, "on right side . is tighter than addition";
is -2**2 . abs.Str.ord, "4".ord, "on right side . is tighter than methodcall";
is -1 * -1 . abs, -1, "on left side . is tighter than *";

# multiplicative

is(4 + 3 * 2, 10, "* binds tighter than binary +");
is(2 - 2 div 2, 1, "div binds tighter than binary -");
is(2 - 2 / 2, 1 / 1, "/ binds tighter than binary -");

# additive

is(1 ~ 2 * 3, 16, "~ binds looser than *");
ok(?((1 ~ 2 & 12) == 12), "but tighter than &");
ok(?((2 + 2 | 4 - 1) == 4), "and + binds tighter than |");

# replication

is(2 x 2 + 3, "22222", "x binds looser than binary +");
is((2 x 2) + 3, 25, "doublecheck");

# concatenation

is(2 x 2 ~ 3, "223", "x binds tighter than binary ~");
ok(?((2 ~ 2 | 4 ~ 1) == 41), "and ~ binds tighter than |");

# junctive and

ok(  ?(   (1 & 2 | 3) ==3), '& binds tighter than |');
ok((!(1 & 2 | 3) < 2), "ditto");
ok(?((1 & 2 ^ 3) < 3), "and also ^");
ok(?(!(1 & 2 ^ 4) != 3), "blah blah blah");

# junctive or

{ # test that | and ^ are on the same level but parsefail
    throws-like 'my Mu $a = (1 | 2 ^ 3)',
        X::Syntax::NonListAssociative,
        '| and ^ may not associate';
    throws-like 'my Mu $a = (1 ^ 2 | 3)',
        X::Syntax::NonListAssociative,
        '^ and | may not associate';
};


{
    my Mu $b = ((abs -1) ^ -1); # -> (1 ^ -1)
    ok($b == 1, "this is true because only one is == 1");
};

# named unary


ok(0 < 2 <=> 1 < 2, "0 < 2 <=> 1 < 2 means 0 < 1 < 2");

# structural infix

is-deeply-junction (1 | 3 <=> 2), any(Less, More), '<=> binds looser than |';
is-deeply (1 == 3 <=> 2), True, '<=> binds tighter than ==';
throws-like '1 .. 2 .. 3',
    X::Syntax::NonAssociative,
    'identical .. is not associative';
throws-like '1 <=> 2 leg 3',
    X::Syntax::NonAssociative,
    '<=> and leg are not associative';


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
    throws-like { EVAL '$a ?? $a = 42 !! $a = 43' },
        X::Syntax::ConditionalOperator::PrecedenceTooLoose,
        "Can't use assignop inside ??!!";
    throws-like { EVAL '$a ?? $a += 42 !! $a = 43' },
        X::Syntax::ConditionalOperator::PrecedenceTooLoose,
        "Can't use meta-assignop inside ??!!";
#    (my $b = 1) ?? "true" !! "false";
#    is($b, 1, "?? !! just thrown away with = in parens");
};


# item assignment

{
    my $c = 1, 2, 3;
    is($c, 1, '$ = binds tighter than ,');
    my $a = (1, 3) X (2, 4);
    is($a, [1, 3], "= binds tighter than X");
}

# loose unary

my $x;
is((so $x = 42), True, "item assignment is tighter than true");

# comma

is(((not 1,42)[1]), 42, "not is tighter than comma");

# list infix

{
    my @d;
    ok (@d = 1,3 Z 2,4), "list infix tighter than list assignment, looser t than comma";
    is(@d, [1 .. 4], "to complicate things further, it dwims");
}

{
    my @b;
    @b = ((1, 3) Z (2, 4));
    is(@b, [1 .. 4], "parens work around this");
};

# RT #77848
{
    throws-like '4 X+> 1...2',
         X::Syntax::NonListAssociative,
        'X+> must not associate with ...';
    throws-like q['08:12:23'.split(':') Z* 60 X** reverse ^3],
        X::Syntax::NonListAssociative,
        'Z* and X** are non associative';
}

# list prefix

{
    my $c = any flat 1, 2 Z 3, 4;
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

# superscript exponentiation
{
    my $i = 2;

    #?rakudo 2 skip 'superscript exponent associativity RT #130414'
    is(++$i², 9, "++ bind tighter than superscript exponent");
    is(--$i², 4, "-- does too");

    #?rakudo todo 'superscript exponent associativity RT #130414'
    is(2²**3, 256, "mixed exponent does right associative");

    is(-2², -4, "superscript exponent binds tighter than unary -");
    isa-ok(~2⁴, Str, "~2⁴ is a string");

    is -2² . abs, 4, "on left side . is looser than superscript exponent and left-to-right with unary -";
    is -2² . abs + 1, 5, "on right side . is tighter than addition";
    is -2² . abs.Str.ord, "4".ord, "on right side . is tighter than methodcall";
}

# Contrary to Perl 5 there are no prototypes, and since normal built-ins
# are not defined as prefix ops, 'uc $a eq $A' actually parses as
# uc($a eq $A), not uc($a) eq $A.
# http://irclog.perlgeek.de/perl6/2009-07-14#i_1316200
#
# so uc(False) stringifies False to 'FALSE', and uc('0') is false. Phew.
is (uc "a" eq "A"), uc(False.Str), "uc has the correct precedence in comparison to eq";

# L<S03/Named unary precedence/my $i = int $x;   # ILLEGAL>
throws-like 'int 4.5', X::Syntax::Confused, 'there is no more prefix:<int>';


# http://irclog.perlgeek.de/perl6/2009-07-14#i_1315249
ok ((1 => 2 => 3).key  !~~ Pair), '=> is right-assoc (1)';
ok ((1 => 2 => 3).value ~~ Pair), '=> is right-assoc (2)';


# L<S03/Operator precedence/only works between identical operators>

throws-like '1, 2 Z 3, 4 X 5, 6',
    X::Syntax::NonListAssociative,
    'list associativity only works between identical operators';

{
    # Check a 3 != 3 vs 3 !=3 parsing issue that can cropped up in Rakudo.
    # Needs careful following of STD to get it right. :-)
    my $r;
    sub foo($x) { $r = $x }
    foo 3 != 3;
    is($r, False, 'sanity 3 != 3');
    $r = True;
    #?rakudo 2 todo 'Inequality (!=) misparsed as assignment RT #121108'
    lives-ok { foo 3 !=3 }, '3 !=3 does not die';
    is($r, False, 'ensure 3 !=3 gives same result as 3 != 3');
}

# RT #73266
{
    try { EVAL 'say and die 73266' };
    ok ~$! !~~ '73266', 'and after say is not interpreted as infix:<and>';
}

# RT #116100
{
    my $s = set(); my $e = 5; $s = $s (|) $e;
    is $s, Set.new(5), '(|) has correct precedence.';
}

# RT #114210
{
    is not(0) + 1, 2,
        '"not(0) + 1" is parsed as "(not 0) + 1"';
}

# RT #125210
throws-like 'my $lizmat = 42; ++$lizmat++',
    X::Syntax::NonAssociative,
    'prefix/postfix ++ are not associative';

# RT #128042
{
    module RT128042 {
        multi infix:<§>($,$) is tighter(&[+]) is export {0};
    };
    import RT128042;

    #?rakudo todo 'RT 128042'
    is (1 + 2 § 3), 1, 'exported multi has correct precedence';
}

# vim: ft=perl6
