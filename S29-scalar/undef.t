use v6;

use Test;

=begin pod

`undef` and `undefine` tests

This test file contains two sections: a port of the perl5 `undef.t` tests, and
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

plan 74;

our $GLOBAL;

# L<S29/Scalar/"=item undef">

is(undef, undef, "undef is equal to undef");
ok(!defined(undef), "undef is not defined");

{
    my $a;
    is($a, undef, "uninitialized lexicals are undef");

    is($GLOBAL, undef, "uninitialized globals are undef");

    $a += 1; # should not emit a warning. how to test that?
    ok(defined($a), "initialized var is defined");

    undefine $a;
    ok(!defined($a), "undefine($a) does");

    $a = "hi";
    ok(defined($a), "string");

    my $b;
    $a = $b;
    ok(!defined($a), "assigning another undef lexical");

    $a = $GLOBAL;
    ok(!defined($a), "assigning another undef global");
}

# L<S29/Scalar/"=item undefine">
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
    ok(!defined(@ary), "undefine array");

    undefine(%hash);
#?pugs todo 'bug'
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

{
    my $interesting;
    (undef, undef, $interesting) = (1,2,3);
    is($interesting, 3, "Undef on LHS of list assignment");

    (undef, $interesting, undef) = (1,2,3);
    is($interesting, 2, "Undef on LHS of list assignment");

    ($interesting, undef, undef) = (1,2,3);
    is($interesting, 1, "Undef on LHS of list assignment");

    sub two_elements() { (1,2) };
    (undef,$interesting) = two_elements();
    is($interesting, 2, "Undef on LHS of function assignment");

    ($interesting, undef) = two_elements();
    is($interesting, 1, "Undef on LHS of function assignment");
}

=begin pod

Perl6-specific tests

=end pod

{
    # aggregate references

    my @ary = (<a b c d e>);
    my $ary_r = @ary; # ref
    isa_ok($ary_r, Array);
    ok(defined($ary_r), "array reference");

    undefine @ary;
    ok(!+$ary_r, "undef array referent");

    is(+$ary_r, 0, "dangling array reference");

    my %hash = (1, 2, 3, 4);
    my $hash_r = %hash;
    isa_ok($hash_r, "Hash");
    ok(defined($hash_r), "hash reference");
    undefine %hash;
    #?rakudo 2 skip 'hash binding (?)'
    ok(defined($hash_r), "undefine hash referent:");
    is(+$hash_r.keys, 0, "dangling hash reference");
}

#?rakudo skip 'Autovivify arrays'
{
    # types
    # TODO: waiting on my Dog $spot;

    my Array $an_ary;
    ok(!defined($an_ary), "my Array");
    ok((try { !defined($an_ary[0]) }), "my Array subscript - undef");
    try { $an_ary.push("blergh") };
    ok((try { defined($an_ary.pop) }), "push");
    ok((try { !defined($an_ary.pop) }), "comes to shove");

    my Hash $a_hash;

    ok(!defined($a_hash), "my Hash");
    ok((try { !defined($a_hash<blergh>) }), "my Hash subscript - undef");
    ok((try { !defined($a_hash<blergh>) }), "my Hash subscript - undef, no autovivification happened");

    $a_hash<blergh> = 1;
    ok(defined($a_hash.delete('blergh')), "delete");
    ok(!defined($a_hash.delete("blergh")), " - once only");

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
    my($num, $alpha);
    my($rx1, $rx2);
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

    # - binding to hash keys only would leave values undef
    eval '"a=b\nc=d\n" ~~ / $<matches> := [ (\w) = \N+ ]* /';
    #?pugs todo 'unimpl'
    ok(eval('$<matches> ~~ all(<a b>)'), "match keys exist");

    #ok(!defined($<matches><a>) && !defined($<matches><b>), "match values don't");
    #?pugs todo 'unimpl'
    ok(0 , "match values don't");
}

#?rakudo skip 'rx:Perl5'
#?DOES 1
{
    # - $0, $1 etc. should all be undef after a failed match
    #   (except for special circumstances)
        "abcde" ~~ rx:Perl5/(.)(.)(.)/;
        "abcde" ~~ rx:Perl5/(\d)/;
    ok((!try { grep { defined($_) }, ($0, $1, $2, $3, $4, $5) }),
            "all submatches undefined after failed match") or
        diag("match state: " ~ eval '$/');

    # XXX write me: "special circumstances"
}


# subroutines
{
    sub bar ($bar, $baz?, :$quux) {
        is($bar, "BAR", "defined param"); # sanity

        # L<<S06/Optional parameters/Missing optional arguments>>
        ok(!defined($baz), "unspecified optional param");

        # L<<S06/Named parameters/Named parameters are optional>>
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

#?pugs skip 'parsefail'
#?rakudo skip 'parsefail'
flunk('FIXME: parsefail');
# {
#    package AutoMechanic {
#        AUTOSCALAR    { \my $_scalar }
#        AUTOARRAY     { \my @_array }
#        AUTOHASH      { \my %_hash }
#        AUTOSUB       { { "code" } }
#        AUTOMETH      { { "code" } }
# 
#        AUTOSCALARDEF { %::«{'$' ~ $_}» = "autoscalardef" }
#        AUTOARRAYDEF  { %::«{'@' ~ $_}» = "autoarraydef".split("") }
#        AUTOHASHDEF   { %::«{'%' ~ $_}» = <autohashdef yes> }
#        AUTOSUBDEF    { %::«{'&' ~ $_}» = { "autosubdef" } }
#        AUTOMETHDEF   { %::«{'&' ~ $_}» = { "automethdef" } }
#    }
# 
#    is(WHAT $AutoMechanic::scalar0,    "Scalar", "autoload - scalar");
#    is(WHAT @AutoMechanic::array0,     "Array",  "autoload - array");
#    is(WHAT %AutoMechanic::hash,       "Hash",   "autoload - hash");
#    is(WHAT &AutoMechanic::sub0,       "Code",   "autoload - sub");
#    is(WHAT AutoMechanic.can("meth0"), "Code",   "autoload - meth");
# 
#    is($AutoMechanic::scalar, "autoscalardef",            "autoloaddef - scalar");
#    is(~@AutoMechanic::ary,   ~("autoarraydef".split(""), "autoloaddef - array");
#    is(~%AutoMechanic::hash,  ~<autohashdef yes>,         "autoloaddef - hash");
#    is(&AutoMechanic::sub.(), "autosubdef",               "autoloaddef - sub");
#    is(AutoMechanic.meth(),   "automethdef",              "autoloaddef - method");
# }

# Extra tests added due to apparent bugs
is((undef) + 1, 1, 'undef + 1');
is(1 + (undef), 1, '1 + undef');
is((undef) * 2, 0, 'undef * 2');
is(2 * (undef), 0, '2 * undef');
is((undef) xx 2, [undef, undef], 'undef xx 2');
is((undef) * (undef), 0, 'undef * undef');

# L<http://colabti.de/irclogger/irclogger_log/perl6?date=2006-09-12,Tue&sel=145#l186>
# See log above.  From IRC, TimToady says that both of these
# should be false.  (At time of writing, @(undef,) is true.)
#?pugs todo 'feature', :depends<@() imposing context and not [] constructor>;
#?rakudo 2 skip 'todo: lists, defined, truthness'
is ?(@(undef,)), Bool::False, '?(@(undef,)) is false';
is ?(list(undef,)), Bool::False, '?(@(undef,)) is false';

# vim: ft=perl6
