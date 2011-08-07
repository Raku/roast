use v6;
use Test;
BEGIN { @*INC.push('t/spec/packages/') };
use Test::Util;

=begin pod

'Mu' and 'undefine' tests

This test file contains two sections: a port of the perl5 'undef.t' tests, and
perl6-specific tests.

=end pod

# Note: See thread "Undef issues" by Adrian Taylor on p6l
# L<http://groups.google.com/groups?threadm=20050601002444.GB32060@wall.org>
#   On Tue, May 24, 2005 at 10:53:59PM +1000, Stuart Cook wrote:
#   : I'm not sure whether this behaviour is supposed to be changing.
#   
#   It is.  I think we decided to make the value undef, and the function
#   undefine().  (But these days most values of undef really ought to
#   be constructed and returned (or thrown) using fail().)
#   
#   Larry

plan 87;

our $GLOBAL;

# L<S32::Basics/Mu/=item defined>

ok(Mu === Mu, "Mu is equal to Mu");
ok(!defined(Mu), "Mu is not defined");

{
    my $a;
    ok(!defined($a), "uninitialized lexicals are undefined");

    ok(!defined($GLOBAL), "uninitialized package vars are undefined");

    $a += 1;
    ok(defined($a), "initialized var is defined");
    is_run( 'my $a; $a += 1', { err => '', out => '', status => 0 },
            'increment of undefined variable does not warn' );

    undefine $a;
    ok(!defined($a), "undefine($a) does");

    $a = "hi";
    ok(defined($a), "string");

    my $b;
    $a = $b;
    ok(!defined($a), "assigning another undefined lexical");

    $a = $GLOBAL;
    ok(!defined($a), "assigning another undefined global");
}

# L<S32::Basics/Mu/"=item undefine">
{
    my @ary = "arg1";
    my $a = @ary.pop;
    ok(defined($a), "pop from array");
    $a = @ary.pop;
    ok(!defined($a), "pop from empty array");

    @ary = "arg1";
    $a = @ary.shift;
    ok(defined($a), "shift from array");
    $a = @ary.shift;
    ok(!defined($a), "shift from empty array");

    my %hash = ( bar => 'baz', quux => 'quuz' );
    ok(defined(%hash<bar>), "hash subscript");
    ok(!defined(%hash<bargho>), "non-existent hash subscript");

    undefine %hash<bar>;
    ok(!defined(%hash<bar>), "undefine hash subscript");

    %hash<bar> = "baz";
    %hash.delete("bar");
    ok(!defined(%hash<bar>), "delete hash subscript");

    ok(defined(@ary), "aggregate array defined");
    ok(defined(%hash), "aggregate hash defined");

    undefine(@ary);
#?pugs todo 'bug'
#?rakudo todo 'definedness of array'
    ok(!defined(@ary), "undefine array");

    #?rakudo emit #
    undefine(%hash);
#?pugs todo 'bug'
#?rakudo todo 'definedness of hash'
    ok(!defined(%hash), "undefine hash");

    @ary = (1);
    ok(defined(@ary), "define array again");
    %hash = (1,1);
    ok(defined(%hash), "define hash again");
}

#?rakudo skip 'access to &your_sub'
{
    sub a_sub { "møøse" }

    ok(defined(&a_sub), "defined sub");
#?pugs todo 'parsefail'
    ok(eval('defined(%«$?PACKAGE\::»<&a_sub>)'), "defined sub (symbol table)");

#?pugs todo 'feature'
    ok(eval('!defined(&a_subwoofer)'), "undefined sub");
#?pugs todo 'feature'
    ok(eval('!defined(%«$?PACKAGE\::»<&a_subwoofer>)'), "undefined sub (symbol table)");
    
    dies_ok { undefine &a_sub }, 'die trying to undefine a sub';
    ok defined &a_sub, 'sub is still defined after attempt to undefine';
}

# TODO: find a read-only value to try and assign to, since we don't
# have rules right now to play around with (the p5 version used $1)
#eval { "constant" = "something else"; };
#is($!, "Modification of a read", "readonly write yields exception");

# skipped tests for tied things

# skipped test for attempt to undef a bareword -- no barewords here.

# TODO: p5 "bugid 3096
# undefing a hash may free objects with destructors that then try to
# modify the hash. To them, the hash should appear empty."


# Test LHS assignment to undef:
# XXX shouldn't that be * instead of undef?
# yes, this chunk should move to a different file --Larry

{
    my $interesting;
    (*, *, $interesting) = (1,2,3);
    is($interesting, 3, "Undef on LHS of list assignment");

    (*, $interesting, *) = (1,2,3);
    is($interesting, 2, "Undef on LHS of list assignment");

    ($interesting, *, *) = (1,2,3);
    is($interesting, 1, "Undef on LHS of list assignment");

    sub two_elements() { (1,2) };
    (*,$interesting) = two_elements();
    is($interesting, 2, "Undef on LHS of function assignment");

    ($interesting, *) = two_elements();
    is($interesting, 1, "Undef on LHS of function assignment");
}

=begin pod

Perl6-specific tests

=end pod

#?rakudo skip 'fun with undefine'
{
    # aggregate references

    my @ary = (<a b c d e>);
    my $ary_r = @ary; # ref
    isa_ok($ary_r, Array);
    ok(defined($ary_r), "array reference");

    undefine @ary;
    ok(!+$ary_r, "undefine array referent");

    is(+$ary_r, 0, "dangling array reference");

    my %hash = (1, 2, 3, 4);
    my $hash_r = %hash;
    isa_ok($hash_r, "Hash");
    ok(defined($hash_r), "hash reference");
    undefine %hash;
    ok(defined($hash_r), "undefine hash referent:");
    is(+$hash_r.keys, 0, "dangling hash reference");
}

{
    my Array $an_ary;
    ok(!defined($an_ary), "my Array");
    #?rakudo todo 'nom regression'
    ok((try { !defined($an_ary[0]) }), "my Array subscript - Mu");
    try { $an_ary.push("blergh") };
    #?rakudo todo 'nom regression'
    ok((try { defined($an_ary.pop) }), "push");
    #?rakudo todo 'nom regression'
    ok((try { !defined($an_ary.pop) }), "comes to shove");
}

#?rakudo skip 'Autovivify hashes'
{
    my Hash $a_hash;

    ok(!defined($a_hash), "my Hash");
    ok((try { !defined($a_hash<blergh>) }), "my Hash subscript - Mu");
    ok((try { !defined($a_hash<blergh>) }), "my Hash subscript - Mu, no autovivification happened");

    $a_hash<blergh> = 1;
    ok(defined($a_hash.delete('blergh')), "delete");
    ok(!defined($a_hash.delete("blergh")), " - once only");
}


{
    class Dog {};
    my Dog $spot;

    ok(!defined($spot), "Unelaborated mutt");
    $spot .= new;
    ok(defined $spot, " - now real");
}

# rules
# TODO. refer to S05
# L<S05/Match objects/"they will all be undefined" closure
#                                 "let keyword">

# - unmatched alternative should bind to undef
#?rakudo skip 'null PMC access in type()'
#?DOES 10
{
    my ($num, $alpha);
    my ($rx1, $rx2);   #OK not used
    eval '
        $rx1 = rx
        / [ (\d+)      { let $<num>   := $0 }
        | (<alpha>+) { let $<alpha> := $1 }
        ]
        /;
        $rx2 = rx
        / [ $<num>  := (\d+)
        | $<alpha>:= (<alpha>+)
        ]
        /;
    ';
    for (<rx1 rx2>) {
        # I want symbolic lookups because I need the rx names for test results.

        eval '"1" ~~ %MY::{$_}';
    #?pugs todo 'unimpl'
        ok(defined($num), '{$_}: successful hypothetical');
        ok(!defined($alpha), '{$_}: failed hypothetical');

        eval '"A" ~~ %MY::{$_}';
        ok(!defined($num), '{$_}: failed hypothetical (2nd go)');
    #?pugs todo 'unimpl'
        ok(defined($alpha), '{$_}: successful hypothetical (2nd go)');
    }

    # - binding to hash keys only would leave values undefined
    eval '"a=b\nc=d\n" ~~ / $<matches> := [ (\w) = \N+ ]* /';
    #?pugs todo 'unimpl'
    ok(eval('$<matches> ~~ all(<a b>)'), "match keys exist");

    #ok(!defined($<matches><a>) && !defined($<matches><b>), "match values don't");
    #?pugs todo 'unimpl'
    ok(0 , "match values don't");
}

#?DOES 1
{
    # - $0, $1 etc. should all be undefined after a failed match
    #   (except for special circumstances)
        "abcde" ~~ /(.)(.)(.)/;
        "abcde" ~~ /(\d)/;
    ok((!try { grep { defined($_) }, ($0, $1, $2, $3, $4, $5) }),
            "all submatches undefined after failed match") or
        diag("match state: " ~ eval '$/');

    # XXX write me: "special circumstances"
}


# subroutines
{
    sub bar ($bar, $baz?, :$quux) {
        is($bar, "BAR", "defined param"); # sanity

        # L<S06/Optional parameters/Missing optional arguments>
        ok(!defined($baz), "unspecified optional param");

        # L<S06/Named parameters/Named parameters are optional>
        ok(!defined($quux), "unspecified optional param");
    }

    bar("BAR");

}

# autoloading
# L<S10/Autoloading>

# Currently waiting on
# - packages
# - symtable hash
# - autoloading itself

# Extra tests added due to apparent bugs
is((Any) + 1, 1, 'Any + 1');
is(1 + (Any), 1, '1 + Any');
is((Any) * 2, 0, 'Any * 2');
is(2 * (Any), 0, '2 * Any');
is((Any) xx 2, [Any, Any], 'Any xx 2');
is((Any) * (Any), 0, 'Any * Any');

# L<http://colabti.de/irclogger/irclogger_log/perl6?date=2006-09-12,Tue&sel=145#l186>
# See log above.  From IRC, TimToady says that both of these
# should be false.  (At time of writing, @(Mu,) is true.)
#?pugs todo 'feature', :depends<@() imposing context and not [] constructor>;
#?rakudo 2 skip 'todo: lists, defined, truthness'
is ?(@(Mu,)), Bool::False, '?(@(Mu,)) is false';
is ?(list(Mu,)), Bool::False, '?(@(Mu,)) is false';

lives_ok { uc(eval("")) }, 'can use eval("") in further expressions';

{
    sub lie { Bool::False }
    ok lie() ~~ Bool, 'sub returns a bool';
    dies_ok { undefine lie }, 'attempt to undefine returned Bool type dies';
    ok lie() ~~ Bool, 'sub still returns a bool';
}

{
    sub def { my $x = [] }   #OK not used
    ok def() ~~ Array, 'sub returns array';
    #?rakudo todo 'nom regression'
    lives_ok { undefine def }, 'attempt to undefine returned array lives';
    ok def() ~~ Array, 'sub still returns array';

    dies_ok { undefine &def }, 'attempt to undefine sub dies';
    ok defined &def, 'attempt to undefine sub fails';
    ok def() ~~ Array, 'can still call sub after attempt to undefine it';
}

# RT #69238
{
    sub foo { my $a = "baz"; undefine $a; undefine $a; $a; }
    ok !defined(foo()), 'can undefine $a twice without any troubles';
}

done;

# vim: ft=perl6
