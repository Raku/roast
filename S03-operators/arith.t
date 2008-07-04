use v6;

use Test;

plan 190;

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
            ok($error <1e-9,$todo ~ " # " ~ $lhs ~ " is close to " ~ $rhs, :todo);
        } else {
            #&ok.nextwith($error <1e-9);
            ok($error <1e-9);
        }
    }
}

# L<S03/Operator precedence>
tryeq  13 %  4, 1;
tryeq -13 %  4, 3;
tryeq  13 % -4, -3;
tryeq -13 % -4, -1;

#?rakudo skip 'modulo with floats'
{
    tryeq 5 % 2.5, 0;
    tryeq 2.5 % 1, .5;
}


my $limit = 1e6;

ok abs( 13e21 %  4e21 -  1e21) < $limit;
ok abs(-13e21 %  4e21 -  3e21) < $limit;
ok abs( 13e21 % -4e21 - -3e21) < $limit;
ok abs(-13e21 % -4e21 - -1e21) < $limit;

# UVs, IVs, etc make no sense but the tests are useful anyhow.

# UVs should behave properly
#?rakudo 3 skip 'modulo bugs'
{
    tryeq 4063328477 % 65535, 27407;
    tryeq 4063328477 % 4063328476, 1;
    tryeq 4063328477 % 2031664238, 1;
}
tryeq 2031664238 % 4063328477, 2031664238;

# These should trigger wrapping on 32 bit IVs and UVs

tryeq 2147483647 + 0, 2147483647;

{
    # IV + IV promote to UV
    tryeq 2147483647 + 1, 2147483648;
    tryeq 2147483640 + 10, 2147483650;
    tryeq 2147483647 + 2147483647, 4294967294;
    # IV + UV promote to NV
    tryeq 2147483647 + 2147483649, 4294967296;
    # UV + IV promote to NV
    tryeq 4294967294 + 2, 4294967296;
    # UV + UV promote to NV
    tryeq 4294967295 + 4294967295, 8589934590;

# UV + IV to IV
tryeq 2147483648 + -1, 2147483647;
tryeq 2147483650 + -10, 2147483640;
# IV + UV to IV
tryeq -1 + 2147483648, 2147483647;
tryeq -10 + 4294967294, 4294967284;
# IV + IV to NV
tryeq -2147483648 + -2147483648, -4294967296;
tryeq -2147483640 + -10, -2147483650;
}

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
tryeq 2147483648 - 0, 2147483648;
tryeq -2147483648 - 0, -2147483648;

tryeq 0 - -2147483647, 2147483647;

#?rakudo skip 'subtraction bugs'
{
    tryeq -1 - -2147483648, 2147483647;
    tryeq 2 - -2147483648, 2147483650;

    tryeq 4294967294 - 3, 4294967291;
    tryeq -2147483648 - -1, -2147483647;

    # IV - IV promote to UV
    tryeq 2147483647 - -1, 2147483648;
    tryeq 2147483647 - -2147483648, 4294967295;
    # UV - IV promote to NV
    tryeq 4294967294 - -3, 4294967297;
    # IV - IV promote to NV
    tryeq -2147483648 - +1, -2147483649;
    # UV - UV promote to IV
    tryeq 2147483648 - 2147483650, -2;
}
# IV - UV promote to IV
tryeq 2000000000 - 4000000000, -2000000000;

# No warnings should appear;
#?rakudo skip '+= MMD bug'
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

#?rakudo skip '-= MMD bug'
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

# check with 0xFFFF and 0xFFFF
#?rakudo skip 'arithmetics'
{
    tryeq 65535 * 65535, 4294836225;
    tryeq 65535 * -65535, -4294836225;
    tryeq -65535 * 65535, -4294836225;
    tryeq -65535 * -65535, 4294836225;

    # check with 0xFFFF and 0x10001
    tryeq 65535 * 65537, 4294967295;
    tryeq 65535 * -65537, -4294967295;
    tryeq -65535 * 65537, -4294967295;
    tryeq -65535 * -65537, 4294967295;
    
    # check with 0x10001 and 0xFFFF
    tryeq 65537 * 65535, 4294967295;
    tryeq 65537 * -65535, -4294967295;
    tryeq -65537 * 65535, -4294967295;
    tryeq -65537 * -65535, 4294967295;
    
    # These should all be dones as NVs
    tryeq 65537 * 65537, 4295098369;
    tryeq 65537 * -65537, -4295098369;
    tryeq -65537 * 65537, -4295098369;
    tryeq -65537 * -65537, 4295098369;
    
    # will overflow an IV (in 32-bit)
    tryeq 46340 * 46342, 0x80001218;
    tryeq 46340 * -46342, -0x80001218;
    tryeq -46340 * 46342, -0x80001218;
    tryeq -46340 * -46342, 0x80001218;
    
    tryeq 46342 * 46340, 0x80001218;
    tryeq 46342 * -46340, -0x80001218;
    tryeq -46342 * 46340, -0x80001218;
    tryeq -46342 * -46340, 0x80001218;
    
    # will overflow a positive IV (in 32-bit)
    tryeq 65536 * 32768, 0x80000000;
    tryeq 65536 * -32768, -0x80000000;
    tryeq -65536 * 32768, -0x80000000;
    tryeq -65536 * -32768, 0x80000000;
    
    tryeq 32768 * 65536, 0x80000000;
    tryeq 32768 * -65536, -0x80000000;
    tryeq -32768 * 65536, -0x80000000;
    tryeq -32768 * -65536, 0x80000000;
    
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

tryeq 28/14, 2;
tryeq 28/-7, -4;
tryeq -28/4, -7;
tryeq -28/-2, 14;

tryeq 0x80000000/1, 0x80000000;
tryeq 0x80000000/-1, -0x80000000;
tryeq -0x80000000/1, -0x80000000;
tryeq -0x80000000/-1, 0x80000000;

# The example for sloppy divide, rigged to avoid the peephole optimiser.
is_approx "20." / "5.", 4;

tryeq 2.5 / 2, 1.25;
tryeq 3.5 / -2, -1.75;
tryeq -4.5 / 2, -2.25;
tryeq -5.5 / -2, 2.75;

# Bluuurg if your floating point can't accurately cope with powers of 2
# [I suspect this is parsing string-to-float problems, not actual arith]
is 18446744073709551616/1, 18446744073709551616; # Bluuurg

{
    tryeq_sloppy 18446744073709551616/2, 9223372036854775808;
    tryeq_sloppy 18446744073709551616/4294967296, 4294967296;
    tryeq_sloppy 18446744073709551616/9223372036854775808, 2;
}

#?rakudo skip 'multiplication accuracy bugs'
{
    # The peephole optimiser is wrong to think that it can substitute intops
    # in place of regular ops, because i_multiply can overflow.
    # (Perl 5) Bug reported by "Sisyphus" (kalinabears@hdc.com.au)
    my $n = 1127;
    my $float = ($n % 1000) * 167772160.0;
    tryeq_sloppy $float, 21307064320;
  
    # On a 32 bit machine, if the i_multiply op is used, you will probably get
    # -167772160. It's actually undefined behaviour, so anything may happen.
    my $int = ($n % 1000) * 167772160;
    tryeq $int, 21307064320;

}


# exponentiation

is 2**2, 4;
is 2.2**2, 4.84;
is_approx 2**2.2, 4.59479341998814;
is_approx 2.2**2.2, 5.66669577875008;
is 1**0, 1;
is 1**1, 1;

# Inf
is Inf, Inf;
is -Inf, -Inf;
isnt Inf, -Inf;
#?rakudo skip 'undef.abs'
is -Inf.abs, Inf;
#?rakudo 4 skip 'Inf'
is Inf+100, Inf;
is Inf-100, Inf;
is Inf*100, Inf;
is Inf/100, Inf;
is Inf*-100, -Inf;
is Inf/-100, -Inf;
#?rakudo skip 'Inf, NaN'
{
    is 100/Inf, 0;
    is Inf**100, Inf;
    is Inf*0, NaN;
    is Inf-Inf, NaN;
    is Inf*Inf, Inf;
    is Inf/Inf, NaN;
    is Inf*Inf/Inf, NaN;
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
#?rakudo skip 'Inf, NaN'
{
    is 0.9**Inf, 0,   "0.9**Inf converges towards 0";
    is 1.1**Inf, Inf, "1.1**Inf diverges towards Inf";
    is 1**Inf, 1;
}

#flunk("1**Inf is platform-specific -- it's 1 on OSX and NaN elsewhere", :todo);

#?rakudo skip 'Inf, NaN'
{
    # NaN
    is NaN, NaN;
    is -NaN, NaN;
    is NaN+100, NaN;
    is NaN-100, NaN;
    is NaN*100, NaN;
    is NaN/100, NaN;
    is NaN**100, NaN;
    is NaN+NaN, NaN;
    is NaN-NaN, NaN;
    is NaN*NaN, NaN;
    is NaN/NaN, NaN;

    is NaN+Inf, NaN;
    is NaN-Inf, NaN;
    is NaN*Inf, NaN;
    is NaN/Inf, NaN;
    is Inf/NaN, NaN;

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

#?rakudo 3 skip 'modulo by zero'
dies_ok( { say 3 % 0 }, 'Modulo zero dies and is catchable');
dies_ok( { $x = 0; say 3 % $x; }, 'Modulo zero dies and is catchable with VInt/VRat variables');
dies_ok( { $x := 0; say 3 % $x; }, 'Modulo zero dies and is catchable with VRef variables');

dies_ok( { say 3 / 0 }, 'Division by zero dies and is catchable');
dies_ok( { $x = 0; say 3 / $x; }, 'Division by zero dies and is catchable with VInt/VRat variables');
dies_ok( { $x := 0; say 3 / $x; }, 'Division by zero dies and is catchable with VRef variables');
