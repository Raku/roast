use v6.e.PREVIEW;

use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use lib $?FILE.IO.parent(2).add("packages/S02-names/lib");
use Test::Util;

plan 203;

# I'm not convinced this is in the right place
# Some parts of this testing (i.e. WHO) seem a bit more S10ish -sorear

# L<S02/Names>

# (root)
#?rakudo skip 'the binding in here is NYI'
{
    my $x = 1; #OK
    my $y = 2; #OK
    is ::<$x>, 1, 'Access via root finds lexicals';

    {
        my $y = 3; #OK
        is ::<$y>, 3, 'Access via root finds lexicals in inner block';
        is ::<$x>, 1, 'Access via root finds lexicals in outer block';
    }

    {
        ::<$x> := $y;
        $y = 1.5;
        is $x, 1.5, 'Can bind via root';
    }

    # XXX Where else should rooty access look?
    # OUR and GLOBAL are the main (mutually exclusive) choices.
}

# MY
{
    my $x = 10; #OK
    my $y = 11; #OK

    is $MY::x, 10, '$MY::x works';
    is MY::<$x>, 10, 'MY::<$x> works';
    is MY::.{'$x'}, 10, 'MY::.{\'$x\'} works';
    is MY.WHO.{'$x'}, 10, 'MY.WHO access works';

    {
        my $y = 12; #OK
        is $MY::y, 12, '$MY::y finds shadow';
        is MY::.{'$y'}, 12, 'Hash-like access finds shadow $y';
        throws-like { $MY::x },
            X::NoSuchSymbol,
            '$MY::x is not visible in inner scope';
        throws-like { MY::.{'$x'} },
            X::NoSuchSymbol,
            q<Hash-like access doesn't see the original $x>;
    }

    my class A1 {
        our $pies = 14;
        method pies() { }
    }
    ok MY::A1.^can('pies'), 'MY::classname works';
    is $MY::A1::pies, 14, 'Can access package hashes through MY::A1';
    ok MY::.{'A1'}.^can('pies'), 'MY::.{classname} works';

    {
        throws-like { MY::A1 },
            X::NoSuchSymbol,
            q<MY::classname isn't visible from inner scope>;
    }

    throws-like { EVAL 'MY::A2' },
      X::NoSuchSymbol,
      'Cannot use MY::A2 directly from outer scope';
    throws-like { MY::.{'A2'}.spies },
      X::NoSuchSymbol,
      'Cannot use MY::.{"A2"} from outer scope';

    # niecza does a case analysis on the variable's storage type to implement
    # this, so there is room for bugs to hide in all cases
    our $a18 = 19;
    is $MY::a18, 19, '$MY:: can be used on our-aliases';
    is MY::.{'$a18'}, 19, 'MY::.{} can be used on our-aliases';
    $MY::a18 := $x;
    ok $a18 =:= $x, '$MY:: binding works on our-aliases';

#?rakudo skip "No ? twigil yet"
{
    my constant $?q = 20;
    is $?MY::q, 20, '$?MY:: can be used on constants';  #OK
    is MY::.{'$?q'}, 20, 'MY::.{} can be used on constants';
}

    for 1 .. 1 {
        state $r = 21;
        is MY::.{'$r'}, 21, 'MY::.{} can access state names';
        is $MY::r, 21, '$MY:: can access state names';
    }

    my $my = 'MY';
    my $l = 22; #OK
    is ::($my)::('$l'), 22, 'Can access MY itself indirectly ::()';
    is ::.<MY>.WHO.<$l>, 22, 'Can access MY itself indirectly via ::';
}

# LEXICAL
{
    # Must be like LEXICAL but cover outer scopes and caller chain for dynamics.
    my $x = 10; #OK
    my $y = 11; #OK

    is $LEXICAL::x, 10, '$LEXICAL::x works';
    is LEXICAL::<$x>, 10, 'LEXICAL::<$x> works';
    is LEXICAL::.{'$x'}, 10, 'LEXICAL::.{\'$x\'} works';
    is LEXICAL.WHO.{'$x'}, 10, 'LEXICAL.WHO access works';

    {
        my $y = 12; #OK
        is $LEXICAL::y, 12, '$LEXICAL::y finds shadow';
        is $LEXICAL::x, 10, '$LEXICAL::x finds original';
        is LEXICAL::.{'$y'}, 12, 'Hash-like access finds shadow $y';
        is LEXICAL::.{'$x'}, 10, 'Hash-like access finds original $x';
    }

    my $z;
    {
        $x = [1,2,3];
        $LEXICAL::z := $x;
        ok $z =:= $x, 'Can bind through $LEXICAL::z';
        is +[$z], 1, '... it is a scalar binding';
        lives-ok { $z = 15 }, '... it is mutable';

        LEXICAL::.{'$z'} := $y;
        ok $z =:= $y, 'Can bind through LEXICAL::.{}';

#?rakudo skip "::= isn't implemented yet"
{
        $LEXICAL::z ::= $y;
        is $z, $y, '::= binding through $LEXICAL::z works';
        throws-like { $z = 5 },
          Exception,
          '... and makes readonly';

        LEXICAL::.{'$z'} ::= $x;
        is $z, $x, '::= binding through LEXICAL::.{} works';
        throws-like { $z = 5 },
          Exception,
          '... and makes readonly';
}
    }

    my class A1 {
        our $pies = 14;
        method pies() { }
    }
    ok LEXICAL::A1.^can('pies'), 'LEXICAL::classname works';
    is $LEXICAL::A1::pies, 14, 'Can access package hashes through LEXICAL::A1';
    ok LEXICAL::.{'A1'}.^can('pies'), 'LEXICAL::.{classname} works';

    {
        ok LEXICAL::A1.^can('pies'), 'LEXICAL::classname works from inner scope';
        ok LEXICAL::.{'A1'}.^can('pies'), 'LEXICAL::.{classname} works from inner scope';

        my class A2 {
            method spies { 15 }
        }
    }

    throws-like { EVAL 'LEXICAL::A2' },
      Exception,
      'Cannot use LEXICAL::A2 directly from outer scope';
    throws-like { LEXICAL::.{'A2'}.spies },
      Exception,
      'Cannot use LEXICAL::.{"A2"} from outer scope';

    sub callee { LEXICAL::.{'$*k'} }
    sub callee2($f is rw) { LEXICAL::.{'$*k'} := $f }
    # slightly dubious, but a straightforward extrapolation from the behavior
    # of CALLER::<$*k> and OUTER::<$*k>
    {
        my $*k = 16;
        my $z  = 17;
        is callee(), 16, 'LEXICAL::.{\'$*k\'} does a dynamic search';
        callee2($z);
        ok $*k =:= $z, 'LEXICAL::.{\'$*k\'} can be used to bind dynamic variables';
    }

    # niecza does a case analysis on the variable's storage type to implement
    # this, so there is room for bugs to hide in all cases
    our $a18 = 19;
    is $LEXICAL::a18, 19, '$LEXICAL:: can be used on our-aliases';
    is LEXICAL::.{'$a18'}, 19, 'LEXICAL::.{} can be used on our-aliases';
    $LEXICAL::a18 := $x;
    ok $a18 =:= $x, '$LEXICAL:: binding works on our-aliases';

#?rakudo skip "No ? twigil yet"
{
    my constant $?q = 20;
    is $?LEXICAL::q, 20, '$?LEXICAL:: can be used on constants';  #OK
    is LEXICAL::.{'$?q'}, 20, 'LEXICAL::.{} can be used on constants';
}

    ok LEXICAL::{'&say'} === &say, 'LEXICAL::.{} can find CORE names';
    ok &LEXICAL::say === &say, '&LEXICAL:: can find CORE names';

    for 1 .. 1 {
        state $r = 21;
        is LEXICAL::.{'$r'}, 21, 'LEXICAL::.{} can access state names';
        is $LEXICAL::r, 21, '$LEXICAL:: can access state names';
    }

    my $my = 'LEXICAL';
    my $l = 22; #OK
    is ::($my)::('$l'), 22, 'Can access LEXICAL itself indirectly ::()';
    is ::.<LEXICAL>.WHO.<$l>, 22, 'Can access LEXICAL itself indirectly via ::';
}

# OUR

{
    {
        our $x30 = 31;
        our $x32 = 33;
        our $x34 = 35;
    }
    my $x = 39;

    is $OUR::x30, 31, 'basic OUR:: testing';
    $OUR::x30 := $x;
    ok $OUR::x30 =:= $x, 'can bind through OUR::';
    is OUR::.<$x32>, 33, 'basic OUR::.{} works';
    OUR::.<$x32> := $x;
    ok $OUR::x32 =:= $x, 'can bind through OUR::.{}';

    my $our = 'OUR';
    is ::($our)::('$x34'), 35, 'OUR works when indirectly accessed';

    our package A36 { # for explicitness
        { our $x37 = 38; }
        ok !defined($OUR::x30), '$OUR:: does not find GLOBAL';
        is $OUR::x37, 38, '$OUR:: does find current package';
        ok !defined(OUR::.<$x30>), 'OUR::.{} does not find GLOBAL';
        is OUR::.{'$x37'}, 38, 'OUR::.{} does find current package';
        ok !defined(::($our)::('$x34')), '::("OUR") does not find GLOBAL';
        is ::($our)::('$x37'), 38, '::("OUR") does find current package';
    }

    is $OUR::A36::x37, 38, '$OUR:: syntax can indirect through a package';
    is ::($our)::('A36')::('$x37'), 38, '::("OUR") can also indirect';

    $OUR::A40::x = 41;
    is OUR::A40.WHO.<$x>, 41, '$OUR:: can autovivify packages (reference)';
    $OUR::A41::x := 42;
    is OUR::A41.WHO.<$x>, 42, '$OUR:: can autovivify packages (binding)';
    #?rakudo emit #
    $::($our)::A42::x = 43;
    #?rakudo skip 'interpolation and auto-viv NYI'
    is ::($our)::A42.WHO.<$x>, 43, '::("OUR") can autovivify packages (r)';

    #?rakudo emit #
    $::($our)::A43::x := 44;
    #?rakudo skip 'binding and interpolation together NYI'
    is ::($our)::A43.WHO.<$x>, 44, '::("OUR") can autovivify packages (b)';

    #?rakudo emit #
    ::($our)::A44 := class { our $x = 41; };
    #?rakudo skip 'binding and interpolation together NYI'
    is $::($our)::A44::x, 41, '::("OUR") can follow aliased packages';
}

# CORE
{
    my $real = &not;
    my $core = "CORE";
    ok &CORE::not === $real, '&CORE:: works';
    ok CORE::.<&not> === $real, 'CORE::.{} works';
    ok ::($core)::('&not') === $real, '::("CORE") works';

    {
        sub not($x) { $x } #OK
        ok &CORE::not === $real, '&CORE:: works when shadowed';
        ok CORE::.<&not> === $real, 'CORE::.{} works when shadowed';
        ok &::($core)::not === $real, '::("CORE") works when shadowed';

        ok EVAL('&CORE::not') === $real, '&CORE:: is not &SETTING::';
        ok EVAL('CORE::.<&not>') === $real, 'CORE::.{} is not SETTING::';
        ok EVAL('&::($core)::not') === $real, '::("CORE") is not SETTING';
    }

    sub f1() { }; sub f2() { }; sub f3() { }
    lives-ok { &CORE::none := &f1 }, '&CORE:: binding lives';
    ok &none =:= &f1, '... and works';
    lives-ok { CORE::.<&none> := &f2 }, 'CORE::.{} binding lives';
    ok &none =:= &f2, '... and works';
    # https://github.com/Raku/old-issue-tracker/issues/4560
    #?rakudo 2 skip 'Cannot bind to &::("CORE")::foo'
    lives-ok { &::($core)::none := &f3 }, '::("CORE") binding lives';
    ok &none =:= &f3, '... and works';

    # in niecza v8, dynamic variables go through a separate code path.
    # make sure accessing it in CORE works
    lives-ok { $CORE::_ := 50 }, 'Binding to $CORE::_ lives';
    is $CORE::_, 50, 'Accessing $CORE::_ works';
    # https://github.com/Raku/old-issue-tracker/issues/4560
    #?rakudo 2 skip 'Cannot bind to &::("CORE")::foo'
    lives-ok { $::($core)::_ := 51 }, 'Binding to $::("CORE")::_ lives';
    is $::($core)::_, 51, 'Accessing $::("CORE")::_ works';
}

# GLOBAL - functionality is very similar to OUR
{
    { our $x60 = 60; }
    package A61 {
        is $GLOBAL::x60, 60, '$GLOBAL:: works';
        is ::("GLOBAL")::('$x60'), 60, '::("GLOBAL") works';
        is GLOBAL::.<$x60>, 60, 'GLOBAL::.{} works';
    }
    ok !defined(&GLOBAL::say), 'GLOBAL:: does not find CORE symbols';
}

# PROCESS - similar to GLOBAL and OUR
{
    package A71 {
        ok $PROCESS::IN === $*IN, '$PROCESS:: works';
        ok PROCESS::.<$IN> === $*IN, 'PROCESS::.{} works';
        ok $::("PROCESS")::IN === $*IN, '::("PROCESS") works';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/2420
{
    $PROCESS::PROGRAM-NAME = "otter";
    is $*PROGRAM-NAME, "otter", 'existing $* assignable via PROCESS';
    $PROCESS::SOME_OTHER_VAR = "else";
    is $*SOME_OTHER_VAR, "else", 'new $* assignable via PROCESS';
}

# COMPILING - not testable without BEGIN

# DYNAMIC
#?rakudo skip 'various issues to resolve'
{
    my $dyn = "DYNAMIC";

    {
        my $*x80 = 82;
        my $y; my $z;
        is $*DYNAMIC::x80, 82, '$DYNAMIC:: works';
        is DYNAMIC::.<$*x80>, 82, 'DYNAMIC::.{} works';
        is ::($dyn)::('$*x80'), 82, '::("DYNAMIC") works';

        $*DYNAMIC::x80 := $y;
        ok $*x80 =:= $y, 'Can bind through $DYNAMIC::';
        ::($dyn)::('$*x80') := $z;
        ok $*x80 =:= $z, 'Can bind through ::("DYNAMIC")';

        ok !defined($*DYNAMIC::x82), 'Unfound dynamics are undefined';
        ok !defined(::($dyn)::('$*x82')), 'Unfound with ::("DYNAMIC")';
    }

    {
        my $x83 is dynamic = 83; #OK
        my $*x84 = 84; #OK

        is $DYNAMIC::x83, 83, 'DYNAMIC on non-$* vars works';
        is $::($dyn)::x83, 83, '::("DYNAMIC") on non-$* vars works';

        ok !defined($DYNAMIC::x84), 'DYNAMIC $x does not find $*x';
        ok !defined($::($dyn)::x84), '::("DYNAMIC") $x does not find $*x';
        ok !defined($*DYNAMIC::x83), 'DYNAMIC $*x does not find $x';
        ok !defined(::($dyn)::('$*x83')), '::("DYNAMIC") $x does not find $*x';
    }

    sub docall($f) { my $*x80 = 80; my $x81 is dynamic = 81; $f() } #OK

    {
        is docall({ $DYNAMIC::x81 }), 81, 'DYNAMIC:: searches callers';
        is docall({ $::($dyn)::x81 }), 81, '::("DYNAMIC") searches callers';
        my ($fun1, $fun2) = do {
            my $x81 is dynamic = 85; #OK
            { $DYNAMIC::x81 }, { $::($dyn)::x81 }
        };
        ok !defined($fun1()), 'DYNAMIC:: does not search outers';
        ok !defined($fun2()), '::("DYNAMIC") does not search outers';

        $GLOBAL::x86 = 86;
        ok !defined($DYNAMIC::x86), 'DYNAMIC:: without twigil ignores GLOBAL';
        ok !defined($::($dyn)::x86), '"DYNAMIC" without twigil ignores GLOBAL';
        is $*DYNAMIC::x86, 86, 'DYNAMIC:: with * searches GLOBAL';
        is ::($dyn)::('$*x86'), 86, '::("DYNAMIC") with * searches GLOBAL';

        ok DYNAMIC::<$*IN> === $PROCESS::IN,
            'DYNAMIC:: with * searches PROCESS';
        ok ::($dyn)::('$*IN') === $PROCESS::IN,
            '::("DYNAMIC") with * searches PROCESS';
    }
}

# CALLER - assumes MY:: has taken care of most access testing
{
    sub f1($f) { my $x is dynamic = 90; my $*bar = 93; $f() } #OK
    sub f2($f) { my $x is dynamic = 91; f1($f) } #OK
    my $caller = 'CALLER';

    is f1({ $CALLER::x }), 90, '$CALLER:: works';
    is f1({ CALLER::.<$x> }), 90, 'CALLER::.{} works';
    is f1({ $::($caller)::x }), 90, '::("CALLER") works';

    is f2({ $CALLER::CALLER::x }), 91, 'CALLER::CALLER:: works';
    is f2({ $::($caller)::($caller)::x }), 91, 'indirect CALLER::CALLER works';

    my $*foo = 92;
    is f1({ CALLER::<$*bar> }), 93, 'CALLER::<$*bar> works';
    is f1({ ::($caller)::('$*bar') }), 93, '::("CALLER")::<$*bar> works';

    my $y is dynamic = 93; #OK
    if 1 {
        is $CALLER::y, 93, 'CALLER:: works in inline blocks';
        is $::($caller)::y, 93, '::("CALLER") works in inline blocks';
    }
}

# CALLERS
{
    sub f1($f) { my $x is dynamic = 90; $f() } #OK
    sub f2($f) { my $x is dynamic = 91; f1($f) } #OK
    my $callers = 'CALLERS';

    is f1({ $CALLERS::x }), 90, '$CALLERS:: works';
    is f1({ CALLERS::.<$x> }), 90, 'CALLERS::.{} works';
    is f1({ $::($callers)::x }), 90, '::("CALLERS") works';

    is f2({ $CALLERS::CALLERS::x }), 91, 'CALLERS::CALLERS:: works';
    is f2({ $::($callers)::($callers)::x }), 91, 'indirect CALLERS::CALLERS works';

    my $*foo = 92;
    is f2({ CALLERS::<$*foo> }), 92, 'CALLERS::<$*foo> works';
    is f2({ ::($callers)::('$*foo') }), 92, '::("CALLERS")::<$*foo> works';

    my $y is dynamic = 93; #OK
    if 1 {
        is $CALLERS::y, 93, 'CALLERS:: works in inline blocks';
        is $::($callers)::y, 93, '::("CALLERS") works in inline blocks';
    }
}

# OUTER
{
    sub f1($f) { my $x is dynamic = 100; $f() } #OK
    sub f2($f) { my $*x = 101; $f() } #OK
    my $outer = 'OUTER';
    my $outers = 'OUTERS';

    my $x = 102; #OK
    my $y = 103; #OK
    {
        my $x = 104; #OK
        is $OUTER::x, 102, '$OUTER:: works';
        is OUTER::.<$x>, 102, 'OUTER::.{} works';
        is $::($outer)::x, 102, '::("OUTER") works';

        {
            my $x = 105; #OK
            my $y = 106; #OK
            is $OUTERS::y, 103, '$OUTER:: keeps going until match';
            is $::($outers)::y, 103, '::("OUTER") keeps going until match';

            is $OUTER::OUTER::x, 102, '$OUTER::OUTER:: works';
            is $::($outer)::($outer)::x, 102, '::("OUTER")::("OUTER") works';
        }

        is f1({ $OUTER::x }), 104, 'OUTER:: is not CALLER::';
        is f1({ $::($outer)::x }), 104, '::("OUTER") is not CALLER::';

        {
            is f1({ $CALLER::OUTER::x }), 102, 'CALLER::OUTER:: works';
        }
    }

    my $*x = 107;
    is f2({ OUTER::<$*x> }), 107, 'OUTER::<$*x> works';
    is f2({ ::($outer)::('$*x') }), 107, '::("OUTER")::<$*x> works';
}

# UNIT
my $x110 = 110; #OK
{
    my $x110 = 111; #OK
    my $unit = "UNIT";
    is $UNIT::x110, 110, '$UNIT:: works';
    is $::($unit)::x110, 110, '::("UNIT") works';
    is EVAL('my $x110 = 112; $UNIT::x110'), 112, '$UNIT:: finds eval heads';
    is EVAL('my $x110 = 112; $::($unit)::x110 #OK'), 112, '::("UNIT") finds eval heads';
    my $f = EVAL('my $x110 is dynamic = 113; -> $fn { my $x110 is dynamic = 114; $fn(); } #OK');
    is $f({ $CALLER::UNIT::x110 }), 113, 'CALLER::UNIT works';
    is $f({ $CALLER::($unit)::x110 }), 113, 'CALLER::UNIT works (indirect)';
}

# PARENT - NYI in any compiler

# https://github.com/Raku/old-issue-tracker/issues/3578
{
    my $x = 'really unlikely value';
    ok MY::.values.grep({ ($_ // '') eq 'really unlikely value' }),
        'MY::.values actually produces values';
    {
        ok OUTER::.values.grep({ ($_ // '') eq 'really unlikely value' }),
            'OUTER::.values actually produces values';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5617
lives-ok { my @keys = CORE::.keys }, 'calling CORE::.keys lives';

# https://github.com/Raku/old-issue-tracker/issues/3222
subtest 'no guts spillage when going too high up scope in pseudopackages' => {
    plan 3 + my @packs = <
        DYNAMIC::  OUTER::   CALLER::   UNIT::     CORE::
        LEXICAL::  OUTERS::  CALLERS::  SETTING::  OUR::
    >;

    eval-lives-ok 'CORE::CALLERS::CORE::True', 'CORE::CALLERS::CORE::...';
    eval-lives-ok 'CORE::UNIT::True',          'CORE::UNIT::...';

    my $mixed := ([~] '$', |(@packs.pick xx 100), 'True');
    #?rakudo.jvm skip 'unknown problem'
    eval-lives-ok($mixed, 'mixed') or diag "Failing mixed combination: $mixed";
    #?rakudo.jvm skip 'unknown problem'
    #?DOES 11
    eval-lives-ok $_ x 100 ~ 'True', $_ for @packs;
}

# GH #3058
{
    is_run q|use v6.e.PREVIEW; our constant &my-not = CORE::<&not>; print "ALIAS: ", my-not(False)|,
            { out => q<ALIAS: True> },
            "CORE symbols are available at compile-time";
    is_run q|use v6.e.PREVIEW; EVAL q«our constant &evaled-not = CORE::<&not>; print "EVAL: ", evaled-not(False)»|,
            { out => q<EVAL: True> },
            "CORE symbols are available at compile-time inside EVAL";
    is_run q|use v6.e.PREVIEW; BEGIN our constant &begin-not = CORE::<&not>; print "BEGIN: ", begin-not(False)|,
            { out => q<BEGIN: True> },
            "CORE symbols are available at compile-time in BEGIN";
    is_run q|use v6.e.PREVIEW; BEGIN EVAL q«our constant &begin-evaled-not = CORE::<&not>; print "BEGIN EVAL: ", begin-evaled-not(False)»|,
            { out => q<BEGIN EVAL: True> },
            "CORE symbols are available at compile-time in BEGIN inside EVAL";
}

# GH #3104
{
    use GH3104_6d;

    my module Foo {
        our $client-rev;
        our $client-pkg;
        our sub report-client-rev {
            $client-pkg = CLIENT::LEXICAL::<$?PACKAGE>;
            $client-rev = CLIENT::CORE::<CORE-SETTING-REV>;
        }
    }

    my $client-rev;
    my $client-pkg;
    sub report-client-rev {
        $client-pkg := CLIENT::LEXICAL::<$?PACKAGE>;
        $client-rev = CLIENT::CORE::<CORE-SETTING-REV>;
    }

    is client-revision, 'e', "code from 6.d reports valid 'e' CLIENT:: revision";
    is client-package.^name, 'GLOBAL', "code from 6.d reports valid CLIENT:: package";

    my @tests =
        'simple callback' => &callback-simple,
        'callback via .map' => &callback-in-map,
        'callback via callback' => &callback-in-callback,
        ;

    for @tests -> (:key($variant), :value(&routine)) {
        routine(&report-client-rev);
        is $client-rev, 'd', "$variant: code from 6.e reports valid CLIENT:: revision when called from 6.d";
        is $client-pkg.^name, 'GH3104_6d', "$variant: valid CLIENT:: module name is reported";
    }

    for @tests -> (:key($variant), :value(&routine)) {
        routine(&Foo::report-client-rev);
        is $Foo::client-rev, 'd', "$variant via module: code from 6.e reports valid CLIENT:: revision when called from 6.d";
        is Foo::<$client-pkg>.^name, 'GH3104_6d', "$variant via module: valid CLIENT:: module name is reported";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5134
is_run q|BEGIN { UNIT; Nil }|, { :0status, :out(''), :err('') },
    'no crash if UNIT:: is used at compile time';

# https://github.com/Raku/problem-solving/issues/80
# Test for CORE::v6<rev> namespaces
{
    for <c d e> -> $rev {
        my $ns = "CORE::v6{$rev}";
        is EVAL("{$ns}::CORE-SETTING-REV"), $rev, "{$ns}::CORE-SETTING-REV reports back correct revision";
    }

    # Skip d here because it doesn't define PseudoStash
    is CORE::v6c::PseudoStash.^ver, '6.c', "core class from CORE::v6c has version 6.c";
    is CORE::v6e::PseudoStash.^ver, '6.e', "core class from CORE::v6e has version 6.e";

    # Multi-dispatch must work depending on what core a class is defined in.
    proto test-dispatch(|) {*}
    multi test-dispatch(CORE::v6c::PseudoStash $p) {
        $p.^ver eq '6.c' ?? "from c" !! "bad revision"
    }
    multi test-dispatch(CORE::v6e::PseudoStash $p) {
        $p.^ver eq '6.e' ?? "from e" !! "bad revision"
    }

    {
        use Pseudo6c;
        is test-dispatch(pseudo-stash), "from c", "class from a 6.c module dispatches correctly";
    }
    {
        use Pseudo6d;
        # Will dispatch to CORE::v6c:: because d doesn't define PseudoStash
        is test-dispatch(pseudo-stash), "from c", "class from a 6.d module dispatches correctly";
    }
    {
        use Pseudo6e;
        is test-dispatch(pseudo-stash), "from e", "class from a 6.e module dispatches correctly";
    }
}

# GH rakudo/rakudo#3270
our $to-be-found-on-GLOBAL = "something unique";
# Dynamic variables created via PROCESS or GLOBAL key assignment must have .VAR.dynamic set.
subtest "Dynamic flag", {
    plan 4;
    nok PROCESS::<$gh3270>:exists, "variable doesn't pre-exists";
    PROCESS::<$gh3270-proc> = 42;
    ok $*gh3270-proc.VAR.dynamic, "container created via PROCESS is marked as dynamic";
    GLOBAL::<$gh3270-glob> = 0;
    ok $*gh3270-glob.VAR.dynamic, "container created via GLOBAL is marked as dynamic";
    nok $to-be-found-on-GLOBAL.VAR.dynamic, "our-declared variable doesn't have dynamic flag";
}

# GH rakudo/rakudo#3257
my module SymDumper {
    sub dynamic-symbols(-->List()) is export {
        DYNAMIC::.keys
    }

    sub callers-symbols(-->List()) is export {
        CALLERS::.keys
    }

    sub lexical-symbols(-->List()) is export {
        CALLER::LEXICAL::.keys
    }
}

sub is-containing($got, $expected, Str:D $msg) {
    my $exp-set = $expected.list.Set;
    my $got-set = $got.list.Set;
    if $exp-set ⊆ $got-set {
        pass $msg
    }
    else {
        flunk $msg;
        diag "expected: " ~ $exp-set.keys.list.gist;
        diag "got     : " ~ $got-set.keys.list.gist;
    }
}

subtest "Dynamic chain pseudo-packages use PROCESS" => {
    plan 30;

    # Take measures as to not leave behind test symbols.
    my $orig-syms = PROCESS::.keys.Set;
    my sub cleanup-namespace {
        for PROCESS::.keys {
            PROCESS::{$_}:delete unless $_ ∈ $orig-syms;
        }
    }

    # Make sure a previously ran test didn't leave anything behind.
    nok DYNAMIC::<$*foo>:exists, "a dynamic variable doesn't exists in DYNAMIC yet";
    nok LEXICAL::<$*foo>:exists, "a dynamic variable doesn't exists in LEXICAL yet";

    my sub check-not-exists($name) {
        nok CALLERS::{$name}:exists, "a dynamic variable doesn't exists in CALLERS yet";
        nok LEXICAL::{$name}:exists,  "a dynamic variable doesn't exists in callee's LEXICAL yet";
    }

    check-not-exists '$*foo';
    check-not-exists '$*foo-constant';

    # Instantiate a dynamic variable and a constant
    PROCESS::<$foo> = 42;
    PROCESS::<$foo-constant> := pi;

    ok DYNAMIC::<$*foo>:exists, "a dynamic variable now exists is DYNAMIC";
    ok DYNAMIC::<$*foo-constant>:exists, "a dynamic constant now exists is DYNAMIC";

    my sub check-exists($name) {
        ok CALLERS::{$name}:exists, "dynamic variable exists in CALLERS";
        ok LEXICAL::{$name}:exists, "dynamic variable exists in callee's LEXICAL";
    }

    check-exists('$*foo');
    check-exists('$*foo-constant');

    is DYNAMIC::<$*foo>, 42, "DYNAMIC finds a variable in PROCESS";
    is DYNAMIC::<$*foo-constant>, pi, "DYNAMIC finds a constant in PROCESS";
    is LEXICAL::<$*foo>, 42, "LEXICAL finds a variable in PROCESS";
    is LEXICAL::<$*foo-constant>, pi, "LEXICAL finds a constant in PROCESS";

    # Assignment to an existing symbol must change it where it is located.
    DYNAMIC::<$*foo> = pi;
    is $*foo, pi, "asignment via DYNAMIC changes the dynamic variable";
    is PROCESS::<$foo>, pi, "asignment via DYNAMIC changes the symbol on PROCESS";

    # Assignment to a non-existing symbol must create it on PROCESS.
    DYNAMIC::<$*new-foo> = "foo";
    DYNAMIC::<$*new-foo-constant> := "foo-constant";

    ok PROCESS::<$new-foo>:exists, "creating a new dynamic variable on DYNAMIC creates it in PROCESS";
    ok PROCESS::<$new-foo-constant>:exists, "creating a new dynamic constant on DYNAMIC creates it in PROCESS";
    is PROCESS::<$new-foo>, "foo", "new dynamic variable value is correct";
    is PROCESS::<$new-foo-constant>, "foo-constant", "new dynamic constant value is correct";

    is $*new-foo, "foo", "new dynamic variable is directly accessible";
    is $*new-foo-constant, "foo-constant", "new dynamic constant is directly accessible";

    cleanup-namespace;

    import SymDumper;
    my $level0;
    sub lev3(&dumper) {
        my $level3; # Won't be exposed
        &dumper()
    }
    sub lev2(&dumper) {
        my $*level2;
        lev3(&dumper)
    }
    sub lev1(&dumper) {
        my $*level1;
        lev2(&dumper)
    }
    sub check-expected-syms($expected, $msg) {
        is-containing lev1(&dynamic-symbols), $expected, "all expected symbols are met in DYNAMIC::.keys$msg";
        is-containing lev1(&callers-symbols), $expected, "all expected symbols are met in CALLERS::.keys$msg";
        is-containing lev1(&lexical-symbols), ($expected ∪ <$level3 $level0>), "all expected symbols are met in CALLER::LEXICAL::.keys$msg";
    }
    check-expected-syms(<$*level1 $*level2>, ", nothing set on PROCESS");
    PROCESS::<$process-level> = 42;
    check-expected-syms(<$*level1 $*level2 $*process-level>, ", including a symbol from PROCESS");

    cleanup-namespace;
}

subtest "Dynamic chain pseudo-packages use GLOBAL" => {
    plan 20;

    # Take measures as to not leave behind test symbols.
    my $orig-syms = GLOBAL::.keys.Set;
    my sub cleanup-namespace {
        for GLOBAL::.keys {
            GLOBAL::{$_}:delete unless $_ ∈ $orig-syms;
        }
    }

    nok DYNAMIC::<$*foo>:exists, "a dynamic variable doesn't exists in DYNAMIC yet";
    nok LEXICAL::<$*foo>:exists, "a dynamic variable doesn't exists in LEXICAL yet";

    my sub check-not-exists($name) {
        nok CALLERS::{$name}:exists, "a dynamic variable doesn't exists in CALLERS yet";
        nok LEXICAL::{$name}:exists,  "a dynamic variable doesn't exists in callee's LEXICAL yet";
    }

    check-not-exists '$*foo';

    GLOBAL::<$foo> = 42;
    GLOBAL::<$foo-constant> := pi;

    ok DYNAMIC::<$*foo>:exists, "a dynamic variable now exists is DYNAMIC";
    ok DYNAMIC::<$*foo-constant>:exists, "a dynamic constant now exists is DYNAMIC";

    my sub check-exists($name) {
        ok CALLERS::{$name}:exists, "dynamic variable exists in CALLERS";
        ok LEXICAL::{$name}:exists, "dynamic variable exists in callee's LEXICAL";
    }

    check-exists('$*foo');

    is DYNAMIC::<$*foo>, 42, "DYNAMIC finds a variable in GLOBAL";
    is DYNAMIC::<$*foo-constant>, pi, "DYNAMIC finds a constant in GLOBAL";
    is LEXICAL::<$*foo>, 42, "LEXICAL finds a variable in GLOBAL";
    is LEXICAL::<$*foo-constant>, pi, "LEXICAL finds a constant in GLOBAL";

    DYNAMIC::<$*foo> = pi;
    is $*foo, pi, "asignment via DYNAMIC changes the dynamic variable";
    is GLOBAL::<$foo>, pi, "assigning via DYNAMIC changes the symbol on GLOBAL";

    cleanup-namespace;

    import SymDumper;
    my $level0;
    sub lev3(&dumper) {
        my $level3; # Won't be exposed
        &dumper()
    }
    sub lev2(&dumper) {
        my $*level2;
        lev3(&dumper)
    }
    sub lev1(&dumper) {
        my $*level1;
        lev2(&dumper)
    }
    GLOBAL::<$global-level> = 42;
    sub check-expected-syms($expected, $msg) {
        is-containing lev1(&dynamic-symbols), $expected, "all expected symbols are met in DYNAMIC::.keys$msg";
        is-containing lev1(&callers-symbols), $expected, "all expected symbols are met in CALLERS::.keys$msg";
        is-containing lev1(&lexical-symbols), ($expected ∪ <$level3 $level0>), "all expected symbols are met in CALLER::LEXICAL::.keys$msg";
    }
    check-expected-syms(<$*level1 $*level2 $*global-level>, ", including symbols from GLOBAL");

    ok DYNAMIC::<$*to-be-found-on-GLOBAL>:exists, "our-declared variable can be found on DYNAMIC";
    is DYNAMIC::<$*to-be-found-on-GLOBAL>, "something unique", "value of our-declared variable taken via DYNAMIC";
    ok '$*to-be-found-on-GLOBAL' ∉ DYNAMIC::.keys, "our-declared value is not iterated over because it's not a real dynamic";

    cleanup-namespace;
}

subtest "Dynamic chain in a Promise" => {
    plan 9;

    my $*out-of-promise = 1;
    PROCESS::<$in-PROCESS> = "proc";
    GLOBAL::<$in-GLOBAL> = "glob";

    await start {
        my $*in-promise = 42;
        await start {
            # Testing for incomplete list of symbols just to see all layers are covered, including
            is-containing DYNAMIC::.keys,
                <$*in-promise $*out-of-promise $*in-PROCESS $*in-GLOBAL $*IN $*OUT $*PROMISE>,
                "symbols outside of Promise wrapper are visible";
            ok DYNAMIC::<$*in-promise>:exists, "DYNAMIC can see symbols outside of current Promise wrapper";
            ok DYNAMIC::<$*out-of-promise>:exists, "DYNAMIC can see symbols outside of nested Promise wrappers";
            is DYNAMIC::<$*out-of-promise>, 1, "out of Promise dynamic symbol value";
            is DYNAMIC::<$*in-promise>, 42, "in-Promise dynamic symbol value";
            is DYNAMIC::<$*in-PROCESS>, "proc", "declared on PROCESS symbol value";
            is DYNAMIC::<$*in-GLOBAL>, "glob", "declared on GLOBAL symbol value";
            DYNAMIC::<$*out-of-promise> = pi;
            DYNAMIC::<$*in-promise> = pi/2;
        }
        is $*in-promise, pi/2, "asignment via DYNAMIC inside a Promise-wrapped code, level 1";
    }
    is $*out-of-promise, pi, "asignment via DYNAMIC inside a Promise-wrapped code, level 2";
}

done-testing;
# vim: ft=perl6
