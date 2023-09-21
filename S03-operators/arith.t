use v6.c;
use Test;
plan 157;

my $five = abs(-5);

unless ($five == 5) {
    say "Bail out!";
    say "Unreliable abs()";
    exit();
}

# 2008-May-01 .nextwith tailcalls removed to help rakudo.
# Probably degrades error messages, so restore once rakudo does .nextwith.

#?DOES 1
sub tryeq ($lhs, $rhs) {
    ok($lhs == $rhs, "$lhs == $rhs");
}

#?DOES 1
sub tryeq_sloppy ($lhs, $rhs, $todo1 = '') {
    my $todo = $todo1;  # TODO is rw
    $todo = ' # TODO ' ~ $todo if $todo;
    if ($lhs == $rhs) {
        if ($todo) {
            #&ok.nextwith($lhs==$rhs,$todo, :todo);
            ok($lhs==$rhs,$todo, :todo);
        } else {
            #&ok.nextwith($lhs==$rhs,$todo);
            ok($lhs==$rhs,$todo);
        }
    } else {
        my $error = abs($lhs - $rhs);
        $error   /= $lhs; # Syntax highlighting fix
        if ($todo) {
            #&ok.nextwith($error <1e-9,$todo ~ " # " ~ $lhs ~ " is close to " ~ $rhs, :todo);
            ok($error < 1e-9, $todo ~ " # " ~ $lhs ~ " is close to " ~ $rhs, :todo);
        } else {
            #&ok.nextwith($error <1e-9);
            ok($error < 1e-9);
        }
    }
}

# L<S03/Operator precedence>
tryeq  13 %  4, 1;
tryeq -13 %  4, 3;
tryeq  13 % -4, -3;
tryeq -13 % -4, -1;

tryeq  13.0 %  4.0, 1;
tryeq -13.0 %  4.0, 3;
tryeq  13.0 % -4.0, -3;
tryeq -13.0 % -4.0, -1;

{
    tryeq 5 % 2.5, 0;
    tryeq 2.5 % 1, .5;
}

# RT #107492
ok 9 % (-9) == 0,    'modulo with negative divisor (1)';
ok (-9) % (-9) == 0, 'modulo with negative divisor (2)';


my $limit = 1e6;

ok abs( 13e21 %  4e21 -  1e21) < $limit;
ok abs(-13e21 %  4e21 -  3e21) < $limit;
ok abs( 13e21 % -4e21 - -3e21) < $limit;
ok abs(-13e21 % -4e21 - -1e21) < $limit;

# Hmm. Don t forget the simple stuff
tryeq 1 + 1, 2;
tryeq 4 + -2, 2;
tryeq -10 + 100, 90;
tryeq -7 + -9, -16;
tryeq -63 + +2, -61;
tryeq 4 + -1, 3;
tryeq -1 + 1, 0;
tryeq +29 + -29, 0;
tryeq -1 + 4, 3;
tryeq +4 + -17, -13;

# subtraction
tryeq 3 - 1, 2;
tryeq 3 - 15, -12;
tryeq 3 - -7, 10;
tryeq -156 - 5, -161;
tryeq -156 - -5, -151;
tryeq -5 - -12, 7;
tryeq -3 - -3, 0;
tryeq 15 - 15, 0;

tryeq 2147483647 - 0, 2147483647;
tryeq 0 - -2147483647, 2147483647;
# No warnings should appear;
{
    my $a;
    $a += 1;
    tryeq $a, 1;
    undefine $a;
    $a += -1;
    tryeq $a, -1;
    undefine $a;
    $a += 4294967290;
    tryeq $a, 4294967290;
    undefine $a;
    $a += -4294967290;
    tryeq $a, -4294967290;
    undefine $a;
    $a += 4294967297;
    tryeq $a, 4294967297;
    undefine $a;
    $a += -4294967297;
    tryeq $a, -4294967297;
}

{
    my $s;
    $s -= 1;
    tryeq $s, -1;
    undefine $s;
    $s -= -1;
    tryeq $s, +1;
    undefine $s;
    $s -= -4294967290;
    tryeq $s, +4294967290;
    undefine $s;
    $s -= 4294967290;
    tryeq $s, -4294967290;
    undefine $s;
    $s -= 4294967297;
    tryeq $s, -4294967297;
    undefine $s;
    $s -= -4294967297;
    tryeq $s, +4294967297;
}

# Multiplication

tryeq 1 * 3, 3;
tryeq -2 * 3, -6;
tryeq 3 * -3, -9;
tryeq -4 * -3, 12;

{   
    # 2147483647 is prime. bah.
    
    tryeq 46339 * 46341, 0x7ffea80f;
    tryeq 46339 * -46341, -0x7ffea80f;
    tryeq -46339 * 46341, -0x7ffea80f;
    tryeq -46339 * -46341, 0x7ffea80f;
}

# leading space should be ignored

tryeq 1 + " 1", 2;
tryeq 3 + " -1", 2;
tryeq 1.2, " 1.2";
tryeq -1.2, " -1.2";

# divide
tryeq 28 div 14, 2;
tryeq 28 div -7, -4;
tryeq -28 div 4, -7;
tryeq -28 div -2, 14;

is(9 div 4, 2, "9 div 4 == 2");
is(-9 div 4, -3, "-9 div 4 == -3");
is(9 div -4, -3, "9 div -4 == -3");
is(-9 div -4, 2, "-9 div -4 == 2");

# modulo
is  13 mod  4, 1,  '13 mod 4';
is -13 mod  4, 3,  '-13 mod 4';
is  13 mod -4, -3, '13 mod -4';
is -13 mod -4, -1, '-13 mod -4';
is 4850761783423467784 mod 256, 8, '4850761783423467784 mod 256';
# RT #117933
is 2804985923338703271682399481743033703427656749129565173066 mod 256, 74,
    '2804985923338703271682399481743033703427656749129565173066 mod 256';

tryeq 2.5 / 2, 1.25;
tryeq 3.5 / -2, -1.75;
tryeq -4.5 / 2, -2.25;
tryeq -5.5 / -2, 2.75;

# exponentiation

is 2**2, 4;
is 2.2**2, 4.84;
is-approx 2**2.2,   4.59479341;
is-approx 2.2**2.2, 5.66669577;
is 1**0, 1;
is 1**1, 1;
isnt 2**3**4, 4096, "** is right associative";

# test associativity
is 2 ** 2 ** 3, 256, 'infix:<**> is right associative';

{
    is-approx(-1, (0 + 1i)**2, "i^2 == -1");

    is-approx(-1, (0.7071067811865476 + -0.7071067811865475i)**4, "sqrt(-i)**4 ==-1" );
    is-approx(1i, (-1+0i)**0.5, '(-1+0i)**0.5 == i ');
}

{
# Inf
    is Inf, Inf;
    is -Inf, -Inf;
    isnt Inf, -Inf;
    is (-Inf).abs, Inf;
    is Inf+100, Inf;
    is Inf-100, Inf;
    is Inf*100, Inf;
    is Inf / 100, Inf;
    is Inf*-100, -Inf;
    is Inf / -100, -Inf;
    is 100 / Inf, 0;
    is Inf**100, Inf;
    is Inf*0, NaN;
    is Inf - Inf, NaN;
    is Inf*Inf, Inf;
    is Inf / Inf, NaN;
    is Inf*Inf / Inf, NaN;
    is Inf**0, 1;
    is 0**0, 1;
    is 0**Inf, 0;
}

{
    my $inf1 = 100**Inf;
    is $inf1, Inf, "100**Inf";
    my $inf2 = Inf**Inf;
    is $inf2, Inf, "Inf**Inf";
}

# See L<"http://mathworld.wolfram.com/Indeterminate.html">
# but also http://pubs.opengroup.org/onlinepubs/9699919799/
# and the 2008 version of the IEEE 754 standard
# for why these three values are defined like they are.
{
    is 0.9**Inf, 0,   "0.9**Inf converges towards 0";
    is 1.1**Inf, Inf, "1.1**Inf diverges towards Inf";

    if $*DISTRO.name eq 'netbsd' {
        ## NetBSD PR lib/49240
        ## cmp. http://gnats.netbsd.org/cgi-bin/query-pr-single.pl?number=49240
        is 1**Inf, 1, "1**Inf returns 1";
    }
    else {  
        is 1**Inf, 1, "1**Inf returns 1";
    }

}

{
    # NaN
    is NaN, NaN;
    is -NaN, NaN;
    is NaN+100, NaN;
    is NaN-100, NaN;
    is NaN*100, NaN;
    is NaN / 100, NaN;
    is NaN**100, NaN;
    is NaN+NaN, NaN;
    is NaN - NaN, NaN;
    is NaN*NaN, NaN;
    is NaN / NaN, NaN;

    is NaN+Inf, NaN;
    is NaN - Inf, NaN;
    is NaN*Inf, NaN;
    is NaN / Inf, NaN;
    is Inf / NaN, NaN;

    my $nan1 = NaN**NaN;
    is $nan1, NaN, "NaN**NaN";
    my $nan2 = NaN**Inf;
    is $nan2, NaN, "NaN**Inf";
    my $nan3 = Inf**NaN;
    is $nan3, NaN, "Inf**NaN";
}

=begin pod

=head2 BEHAVIOUR OF DIVISION AND MODULUS WITH ZERO

This tests the behaviour of infix:<mod >, infix:<%>, infix:<div>
and infix:</> when used with a zero modulus resp. divisor.

All uses of a zero modulus or divisor should 'die', and the
'die' should be non-fatal.

=end pod

# RT #77592
{
    throws-like { 3 mod 0 }, X::Numeric::DivideByZero,
        numerator => 3,
        'Modulo zero with infix:<mod> dies and is catchable';
    throws-like { my $x = 0; 3 mod $x }, X::Numeric::DivideByZero,
        numerator => 3,
        'Modulo zero with infix:<mod> dies and is catchable with VInt variables';
    throws-like { my $x := 0; 3 mod $x }, X::Numeric::DivideByZero,
        'Modulo zero with infix:<mod> dies and is catchable with VRef variables';

    throws-like { say 3 % 0 }, X::Numeric::DivideByZero,
#        expectedn => Int,
#        gotn      => Failure,
        'Modulo zero with infix:<%> dies and is catchable';
    throws-like { my $x = 0; say 3 % $x }, X::Numeric::DivideByZero,
#        expectedn => Int,
#        gotn      => Failure,
        'Modulo zero with infix:<%> dies and is catchable with VInt variables';
    throws-like { my $x := 0; say 3 % $x }, X::Numeric::DivideByZero,
#        expectedn => Int,
#        gotn      => Failure,
        'Modulo zero with infix:<%> dies and is catchable with VRef variables';

    throws-like { 3 div 0 }, X::Numeric::DivideByZero,
        numerator => 3,
        'Division by zero with infix:<div> dies and is catchable';
    throws-like { my $x = 0; 3 div $x }, X::Numeric::DivideByZero,
        numerator => 3,
        'Division by zero with infix:<div> dies and is catchable with VInt variables';
    throws-like { my $x := 0; 3 div $x }, X::Numeric::DivideByZero,
        numerator => 3,
        'Division by zero with infix:<div> dies and is catchable with VRef variables';

    throws-like { say 0 / 0 }, X::Numeric::DivideByZero,
        'Division by zero with infix:</> dies and is catchable (1)';
    throws-like { say 3 / 0 }, X::Numeric::DivideByZero,
        'Division by zero with infix:</> dies and is catchable (2)';
    throws-like { my $x = 0; say 3.5 / $x }, X::Numeric::DivideByZero,
#        numerator => 3.5,   # numerator is always an Int, so we get 7
        'Division by zero with infix:</> dies and is catchable with VInt/VRat variables';
    throws-like { my $x = 0; say 4 / $x }, X::Numeric::DivideByZero,
        'Division by zero with infix:</> dies and is catchable with VRef variables';
}

# RT #123077
{
    my $rt123077 = 1 / 0;
    throws-like '$rt123077.gist', X::Numeric::DivideByZero,
        ".gist on '1/0' blows up with X::Numeric::DivideByZero";
}

# This is a rakudo regression wrt bignum:
{
    my $f = 1; $f *= $_ for 2..25;
    ok $f == 15511210043330985984000000,
       'Can calculate 25! without loss of precision';
    ok 2**65 == 36893488147419103232,
       'Can calculate 2**65 without loss of precision';
}

# RT #73264
# Rat literals are gone
{
    ok 1/7 / 1/7 == 1/49, 'no more Rat literals, infix:</> has normal left assoc';
}

# RT #73386
{
    # TODO: implement typed exception and adapt test
    throws-like { EVAL q[ 3 !+ 4 ] }, X::Syntax::CannotMeta,
        'infix<!+> is not iffy enough; RT #73386';
}

# RT #100768
{
    my $x = -Int;
    is $x, 0, '-Int warns (and yields 0) but does not give an error';
}

# RT #108052
{
    my role orig-string[$o] { method Str() { $o.Str } };
    my $a = 7 but orig-string['7'];
    is ($a - 3).Str, '4',
        'infix:<-> produces a proper Int, even if some of the types invovled have mixins';
}

# RT #122053
isa-ok 4.8 / 1, Rat, 'infix:</> returns Rat when it can';
isa-ok 4.8 % 1, Rat, 'infix:<%> returns Rat when it can';
isa-ok 4 % 1.1, Rat, 'infix:<%> returns Rat when it can';
isa-ok 4.8 % 1.1, Rat, 'infix:<%> returns Rat when it can';

# vim: ft=perl6
