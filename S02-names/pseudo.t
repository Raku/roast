use v6;

use Test;

plan 18;

# I'm not convinced this is in the right place
# Some parts of this testing (i.e. WHO) seem a bit more S10ish -sorear

# L<S02/Names>

# (root)
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
        $y--;
        is $x, 0, 'Can bind via root';
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
            our $spies = 15;
        }
    }

    dies_ok { eval 'MY::A2' }, 'Cannot use MY::A2 directly from outer scope';
    dies_ok { MY::.{'A2'} }, 'Cannot use MY::.{"A2"} from outer scope';

    sub callee { MY::.{'$*k'} }
    sub callee2($f) { MY::.{'$*k'} := $f }
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
    is $?MY::q, 20, '$?MY:: can be used on constants';
    is MY::.{'$?q'}, 20, 'MY::.{} can be used on constants';

    ok MY::{'&say'} === &say, 'MY::.{} can find CORE names';
    ok &MY::say === &say, '&MY:: can find CORE names';

    for 1 .. 1 {
        state $r = 21;
        is MY::.{'$r'}, 21, 'MY::.{} can access state names';
        is $MY::r, 21, '$MY:: can access state names';
    }
}

# OUR
# CORE
# GLOBAL
# PROCESS
# COMPILING
# DYNAMIC

# CALLER
# OUTER
# UNIT
# SETTING
# PARENT

# vim: ft=perl6
