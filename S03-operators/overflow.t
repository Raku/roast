use v6;

use Test;

plan 98;

#L<S03/Autoincrement precedence>

=begin description

Mostly copied from Perl 5.8.4 s t/op/inc.t

Verify that addition/subtraction properly handle "overflow"
conditions on common architectures.  The current tests are
significant on machines with 32-bit longs, but should not
fail anywhere.

=end description

my $a = 2147483647;
my $c=$a++;
is($a, 2147483648, "var incremented after post-autoincrement");
is($c, 2147483647, "during post-autoincrement return value is not yet incremented");

$a = 2147483647;
$c=++$a;
is($a, 2147483648, "var incremented  after pre-autoincrement");
is($c, 2147483648, "during pre-autoincrement return value is incremented");

$a = 2147483647;
$a=$a+1;
is($a, 2147483648, 'simple assignment: $a = $a+1');

$a = -2147483648;
$c=$a--;
is($a, -2147483649, "var decremented after post-autodecrement");
is($c, -2147483648, "during post-autodecrement return value is not yet decremented");

$a = -2147483648;
$c=--$a;
is($a, -2147483649, "var decremented  after pre-autodecrement");
is($c, -2147483649, "during pre-autodecrement return value is decremented");

$a = -2147483648;
$a=$a-1;
is($a, -2147483649, 'simple assignment: $a = $a-1');

$a = 2147483648;
$a = -$a;
$c=$a--;
is($a, -2147483649, "post-decrement negative value");

$a = 2147483648;
$a = -$a;
$c=--$a;
is($a, -2147483649, "pre-decrement negative value");

$a = 2147483648;
$a = -$a;
$a=$a-1;
is($a, -2147483649, 'assign $a = -$a; $a = $a-1');

$a = 2147483648;
my $b = -$a;
$c=$b--;

is($b, ((-$a)-1), "compare -- to -1 op with same origin var");
is($a, 2147483648, "make sure origin var remains unchanged");

$a = 2147483648;
$b = -$a;
$c=--$b;
is($b, ((-$a)-1), "same thing with predecremenet");

$a = 2147483648;
$b = -$a;
$b= $b - 1;
is($b, -(++$a), 'est oder of predecrement in -(++$a)');

{
    is(0x80000000 div 1, 0x80000000, "0x80000000 div 1 == 0x80000000");
    is(0x80000000 div -1, -0x80000000, "0x80000000 div -1 == -0x80000000");
    is(-0x80000000 div 1, -0x80000000, "-0x80000000 div 1 == -0x80000000");
    is(-0x80000000 div -1, 0x80000000, "-0x80000000 div -1 == 0x80000000");
    is 18446744073709551616 div 1, 18446744073709551616;
    is 18446744073709551616 div 2, 9223372036854775808, "Bignums are not working yet";
    is 18446744073709551616 div 4294967296, 4294967296, "Bignums are not working yet";
    ok 18446744073709551616 div 9223372036854775808 == 2, '$bignum1 div $bignum2';
}

# UVs should behave properly
{
    is 4063328477 % 65535, 27407;
    is 4063328477 % 4063328476, 1;
    is 4063328477 % 2031664238, 1;
    
    is 2031664238 % 4063328477, 2031664238;

    # These should trigger wrapping on 32 bit IVs and UVs

    is 2147483647 + 0, 2147483647;

    # IV + IV promote to UV
    is 2147483647 + 1, 2147483648;
    is 2147483640 + 10, 2147483650;
    is 2147483647 + 2147483647, 4294967294;
    # IV + UV promote to NV
    is 2147483647 + 2147483649, 4294967296;
    # UV + IV promote to NV
    is 4294967294 + 2, 4294967296;
    # UV + UV promote to NV
    is 4294967295 + 4294967295, 8589934590;

    # UV + IV to IV
    is 2147483648 + -1, 2147483647;
    is 2147483650 + -10, 2147483640;
    # IV + UV to IV
    is -1 + 2147483648, 2147483647;
    is -10 + 4294967294, 4294967284;
    # IV + IV to NV
    is -2147483648 + -2147483648, -4294967296;
    is -2147483640 + -10, -2147483650;
}

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

{
    tryeq 2147483648 - 0, 2147483648;
    tryeq -2147483648 - 0, -2147483648;
    tryeq 2000000000 - 4000000000, -2000000000;
}

# Believe it or not, this one overflows on 32-bit Rakduo as of 3/8/2010.
{
    # RT #73262
    is_approx 7**(-1), 0.14285714285714, '7**(-1) works';
}

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

# check with 0xFFFF and 0xFFFF
{
    is 65535 * 65535, 4294836225;
    is 65535 * -65535, -4294836225;
    is -65535 * 65535, -4294836225;
    is -65535 * -65535, 4294836225;

    # check with 0xFFFF and 0x10001
    is 65535 * 65537, 4294967295;
    is 65535 * -65537, -4294967295;
    is -65535 * 65537, -4294967295;
    is -65535 * -65537, 4294967295;
    
    # check with 0x10001 and 0xFFFF
    is 65537 * 65535, 4294967295;
    is 65537 * -65535, -4294967295;
    is -65537 * 65535, -4294967295;
    is -65537 * -65535, 4294967295;
    
    # These should all be dones as NVs
    is 65537 * 65537, 4295098369;
    is 65537 * -65537, -4295098369;
    is -65537 * 65537, -4295098369;
    is -65537 * -65537, 4295098369;
    
    # will overflow an IV (in 32-bit)
    is 46340 * 46342, 0x80001218;
    is 46340 * -46342, -0x80001218;
    is -46340 * 46342, -0x80001218;
    is -46340 * -46342, 0x80001218;
    
    is 46342 * 46340, 0x80001218;
    is 46342 * -46340, -0x80001218;
    is -46342 * 46340, -0x80001218;
    is -46342 * -46340, 0x80001218;
    
    # will overflow a positive IV (in 32-bit)
    is 65536 * 32768, 0x80000000;
    is 65536 * -32768, -0x80000000;
    is -65536 * 32768, -0x80000000;
    is -65536 * -32768, 0x80000000;
    
    is 32768 * 65536, 0x80000000;
    is 32768 * -65536, -0x80000000;
    is -32768 * 65536, -0x80000000;
    is -32768 * -65536, 0x80000000;
}

#overflow tests from radix.t
#?niecza skip 'general radix notation'
{
    # some random mad up hex strings (these values are checked against perl5)
    is :16("FFACD5FE"), 4289517054, 'got the correct int value from hex FFACD5FE';
    is :16("AAA4872D"), 2862909229, 'got the correct int value from hex AAA4872D';
    is :16<DEAD_BEEF>,  0xDEADBEEF, 'got the correct int value from hex DEAD_BEEF';

    is(:8<37777777777>, 0xffff_ffff, 'got the correct int value from oct 3777777777');
    is +":16<DeAdBeEf>", 0xDEADBEEF, "radix 16 notation works";
    #?rakudo todo 'RT #105116'
    is +":16<dead_beef.face>", 0xDEADBEEF + 0xFACE / 65536.0, "fractional base 16 works";
    
    is( :2<1.1> * 10 ** 10,        15_000_000_000, 'binary number to power of 10' );
    is( :2<1.1*10**10>,        15_000_000_000, 'Power of ten in <> works');
    
}

# RT #77016
{
    ok 1 / 10000000000000000000000000000000 < 1/1000,
        'can construct Rat (or similar) with big denominator';
}


# vim: ft=perl6
