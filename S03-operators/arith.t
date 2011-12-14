use v6;
use Test;
plan 136;

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
#?niecza todo "negative divisor"
tryeq  13 % -4, -3;
tryeq -13 % -4, -1;

{
    tryeq 5 % 2.5, 0;
    tryeq 2.5 % 1, .5;
}


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
#?niecza skip "undefine NYI"
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

#?niecza skip "undefine NYI"
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
#?rakudo 2 todo 'negative div'
is(-9 div 4, -3, "-9 div 4 == -3");
#?niecza todo "negative divisor"
is(9 div -4, -3, "9 div -4 == -3");
is(-9 div -4, 2, "-9 div -4 == 2");

# modulo

is  13 mod  4, 1,  '13 mod 4';
#?rakudo 2 todo 'negative mod'
is -13 mod  4, 3,  '-13 mod 4';
#?niecza todo "negative divisor"
is  13 mod -4, -3, '13 mod -4';
is -13 mod -4, -1, '-13 mod -4';

tryeq 2.5 / 2, 1.25;
tryeq 3.5 / -2, -1.75;
tryeq -4.5 / 2, -2.25;
tryeq -5.5 / -2, 2.75;

# exponentiation

is 2**2, 4;
is 2.2**2, 4.84;
is_approx 2**2.2,   4.59479341;
is_approx 2.2**2.2, 5.66669577;
is 1**0, 1;
is 1**1, 1;
isnt 2**3**4, 4096, "** is right associative";

# test associativity
is 2 ** 2 ** 3, 256, 'infix:<**> is right associative';

{
    is_approx(-1, (0 + 1i)**2, "i^2 == -1");

    is_approx(-1, (0.7071067811865476 + -0.7071067811865475i)**4, "sqrt(-i)**4 ==-1" );
    is_approx(1i, (-1+0i)**0.5, '(-1+0i)**0.5 == i ');
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

    my $inf1 = 100**Inf;
    is $inf1, Inf, "100**Inf";
    my $inf2 = Inf**Inf;
    is $inf2, Inf, "Inf**Inf";

}
# See L<"http://mathworld.wolfram.com/Indeterminate.html">
# for why these three values are defined like they are.
{
    is 0.9**Inf, 0,   "0.9**Inf converges towards 0";
    is 1.1**Inf, Inf, "1.1**Inf diverges towards Inf";
    #?niecza todo "No agreement over correct behavior here -- above web page not helpful!"
    is 1**Inf, 1;
}

##?pugs todo
#flunk("1**Inf is platform-specific -- it's 1 on OSX and NaN elsewhere");

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

This test tests the behaviour of '%' and '/' when used with
a zero modulus resp. divisor.

All uses of a zero modulus or divisor should 'die', and the
'die' should be non-fatal.

=end pod

my $x;

#?rakudo 2 todo 'modulo by zero'
dies_ok( { say 3 % 0 }, 'Modulo zero dies and is catchable');
dies_ok( { $x = 0; say 3 % $x; }, 'Modulo zero dies and is catchable with VInt/VRat variables');
#?rakudo todo 'die or fail?'
dies_ok( { $x := 0; say 3 % $x; }, 'Modulo zero dies and is catchable with VRef variables');

dies_ok( { say 3 div 0 }, 'Division by zero dies and is catchable');
dies_ok( { $x = 0; say 3 div $x; }, 'Division by zero dies and is catchable with VInt div VRat variables');
dies_ok( { $x := 0; say 3 div $x; }, 'Division by zero dies and is catchable with VRef variables');

# This is a rakudo regression wrt bignum:
{
    my $f = 1; $f *= $_ for 2..25;
    ok $f == 15511210043330985984000000, 
       'Can calcualte 25! without loss of precision';
    ok 2**65 == 36893488147419103232,
       'Can calcualte 2**65 without loss of precision';
}

# RT #73264
# Rat literals are gone
{
    ok 1/7 / 1/7 == 1/49, 'no more Rat literals, infix:</> has normal left assoc';
}

# RT #73386
eval_dies_ok '3 !+ 4',  'infix:<+> is not iffy enough';

# RT #100768
eval_lives_ok '-Inf', '-Inf warns (and yields 0) but does not give an error';

done;

# vim: ft=perl6
