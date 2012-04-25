use v6;

use Test;

plan 140;

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
#?rakudo skip 'various issues, skipping all for now'
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
        is $MY::x, 10, '$MY::x finds original';
        is MY::.{'$y'}, 12, 'Hash-like access finds shadow $y';
        is MY::.{'$x'}, 10, 'Hash-like access finds original $x';
    }

    my $z;
    {
        $x = [1,2,3];
        $MY::z := $x;
        ok $z =:= $x, 'Can bind through $MY::z';
        is +[$z], 1, '... it is a scalar binding';
        lives_ok { $z = 15 }, '... it is mutable';

        MY::.{'$z'} := $y;
        ok $z =:= $y, 'Can bind through MY::.{}';

        $MY::z ::= $y;
        is $z, $y, '::= binding through $MY::z works';
        dies_ok { $z = 5 }, '... and makes readonly';

        MY::.{'$z'} ::= $x;
        is $z, $x, '::= binding through MY::.{} works';
        dies_ok { $z = 5 }, '... and makes readonly';
    }

    my class A1 {
        our $pies = 14;
        method pies() { }
    }
    ok MY::A1.^can('pies'), 'MY::classname works';
    is $MY::A1::pies, 14, 'Can access package hashes through MY::A1';
    ok MY::.{'A1'}.^can('pies'), 'MY::.{classname} works';

    {
        ok MY::A1.^can('pies'), 'MY::classname works from inner scope';
        ok MY::.{'A1'}.^can('pies'), 'MY::.{classname} works from inner scope';

        my class A2 {
            method spies { 15 }
        }
    }

    dies_ok { eval 'MY::A2' }, 'Cannot use MY::A2 directly from outer scope';
    dies_ok { MY::.{'A2'}.spies }, 'Cannot use MY::.{"A2"} from outer scope';

    sub callee { MY::.{'$*k'} }
    sub callee2($f is rw) { MY::.{'$*k'} := $f }
    # slightly dubious, but a straightforward extrapolation from the behavior
    # of CALLER::<$*k> and OUTER::<$*k>
    {
        my $*k = 16;
        my $z  = 17;
        is callee(), 16, 'MY::.{\'$*k\'} does a dynamic search';
        callee2($z);
        ok $*k =:= $z, 'MY::.{\'$*k\'} can be used to bind dynamic variables';
    }

    # niecza does a case analysis on the variable's storage type to implement
    # this, so there is room for bugs to hide in all cases
    our $a18 = 19;
    is $MY::a18, 19, '$MY:: can be used on our-aliases';
    is MY::.{'$a18'}, 19, 'MY::.{} can be used on our-aliases';
    $MY::a18 := $x;
    ok $a18 =:= $x, '$MY:: binding works on our-aliases';

    my constant $?q = 20;
    is $?MY::q, 20, '$?MY:: can be used on constants';  #OK
    is MY::.{'$?q'}, 20, 'MY::.{} can be used on constants';

    ok MY::{'&say'} === &say, 'MY::.{} can find CORE names';
    ok &MY::say === &say, '&MY:: can find CORE names';

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
    #?rakudo todo 'interpolation and auto-viv NYI'
    is ::($our)::A42.WHO.<$x>, 43, '::("OUR") can autovivify packages (r)';
    
    #?rakudo emit #
    $::($our)::A43::x := 44;
    #?rakudo todo 'binding and interpolation together NYI'
    is ::($our)::A43.WHO.<$x>, 44, '::("OUR") can autovivify packages (b)';

    #?rakudo emit #
    ::($our)::A44 := class { our $x = 41; };
    #?rakudo todo 'binding and interpolation together NYI'
    is $::($our)::A44::x, 41, '::("OUR") can follow aliased packages';
}

# CORE
#?rakudo skip 'CORE NYI'
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

        ok eval('&CORE::not') === $real, '&CORE:: is not &SETTING::';
        ok eval('CORE::.<&not>') === $real, 'CORE::.{} is not SETTING::';
        ok eval('&::($core)::not') === $real, '::("CORE") is not SETTING';
    }

    sub f1() { }; sub f2() { }; sub f3() { }
    lives_ok { &CORE::none := &f1 }, '&CORE:: binding lives';
    ok &none =:= &f1, '... and works';
    lives_ok { CORE::.<&none> := &f2 }, 'CORE::.{} binding lives';
    ok &none =:= &f2, '... and works';
    lives_ok { &::($core)::none := &f3 }, '::("CORE") binding lives';
    ok &none =:= &f3, '... and works';

    # in niecza v8, dynamic variables go through a separate code path.
    # make sure accessing it in CORE works
    lives_ok { $CORE::_ := 50 }, 'Binding to $CORE::_ lives';
    is $CORE::_, 50, 'Accessing $CORE::_ works';
    lives_ok { $::($core)::_ := 51 }, 'Binding to $::("CORE")::_ lives';
    is $::($core)::_, 51, 'Accessing $::("CORE")::_ works';
}

# GLOBAL - functionality is very similar to OUR
{
    { our $x60 = 60; }
    package A61 {
        is $GLOBAL::x60, 60, '$GLOBAL:: works';
        #?rakudo todo 'GLOBAL and interpolation'
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
    sub f1($f) { my $x is dynamic = 90; $f() } #OK
    sub f2($f) { my $x is dynamic = 91; f1($f) } #OK
    my $caller = 'CALLER';

    is f1({ $CALLER::x }), 90, '$CALLER:: works';
    is f1({ CALLER::.<$x> }), 90, 'CALLER::.{} works';
    is f1({ $::($caller)::x }), 90, '::("CALLER") works';

    is f2({ $CALLER::CALLER::x }), 91, 'CALLER::CALLER:: works';
    is f2({ $::($caller)::($caller)::x }), 91, 'indirect CALLER::CALLER works';

    my $*foo = 92;
    #?rakudo 2 todo 'not entirely sure these make sense...'
    is f2({ CALLER::<$*foo> }), 92, 'CALLER::<$*foo> works';
    is f2({ ::($caller)::('$*foo') }), 92, '::("CALLER")::<$*foo> works';

    my $y = 93; #OK
    if 1 {
        is $CALLER::y, 93, 'CALLER:: works in inline blocks';
        is $::($caller)::y, 93, '::("CALLER") works in inline blocks';
    }
}

# OUTER
{
    sub f1($f) { my $x is dynamic = 100; $f() } #OK
    sub f2($f) { my $*x = 101; $f() } #OK
    my $outer = 'OUTER';

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
            #?rakudo 2 todo 'these tests disagree with STD'
            is $OUTER::y, 103, '$OUTER:: keeps going until match';
            is $::($outer)::y, 103, '::("OUTER") keeps going until match';

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
    is eval('my $x110 = 112; $UNIT::x110'), 112, '$UNIT:: finds eval heads';
    is eval('my $x110 = 112; $::($unit)::x110 #OK'), 112, '::("UNIT") finds eval heads';
    my $f = eval('my $x110 is dynamic = 113; -> $fn { my $x110 is dynamic = 114; $fn(); } #OK');
    is $f({ $CALLER::UNIT::x110 }), 113, 'CALLER::UNIT works';
    is $f({ $CALLER::($unit)::x110 }), 113, 'CALLER::UNIT works (indirect)';
}

# SETTING
#?rakudo skip 'SETTING NYI'
{
    sub not($x) { $x } #OK
    my $setting = 'SETTING';
    ok &SETTING::not(False), 'SETTING:: works';
    ok &::($setting)::not.(False), '::("SETTING") works';

    ok eval('&SETTING::not(True)'), 'SETTING finds eval context';
    ok eval('&::($setting)::not(True)'), '::("SETTING") finds eval context';
    my $f = eval('-> $fn { $fn(); }');
    ok $f({ &CALLER::SETTING::not(True) }), 'CALLER::SETTING works';
    ok $f({ &CALLER::($setting)::not(True) }), 'CALLER::SETTING works (ind)';
}

# PARENT - NYI in any compiler

# vim: ft=perl6
