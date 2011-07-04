
use Test;

# Tests for auto-increment and auto-decrement operators
# originally from Perl 5, by way of t/operators/auto.t

plan 54;

#L<S03/Autoincrement precedence>

my $base = 10000;

my $x = 10000;
is(0 + ++$x - 1, $base, '0 + ++$x - 1');
is(0 + $x-- - 1, $base, '0 + $x-- - 1');
is(1 * $x,       $base, '1 * $x');
is(0 + $x-- - 0, $base, '0 + $x-- - 0');
is(1 + $x,       $base, '1 + $x');
is(1 + $x++,     $base, '1 + $x++');
is(0 + $x,       $base, '0 + $x');
is(0 + --$x + 1, $base, '0 + --$x + 1');
is(0 + ++$x + 0, $base, '0 + ++$x + 0');
is($x,           $base, '$x');

my @x;
@x[0] = 10000;
is(0 + ++@x[0] - 1, $base, '0 + ++@x[0] - 1');
is(0 + @x[0]-- - 1, $base, '0 + @x[0]-- - 1');
is(1 * @x[0],       $base, '1 * @x[0]');
is(0 + @x[0]-- - 0, $base, '0 + @x[0]-- - 0');
is(1 + @x[0],       $base, '1 + @x[0]');
is(1 + @x[0]++,     $base, '1 + @x[0]++');
is(0 + @x[0],       $base, '0 + @x[0]');
is(0 + ++@x[0] - 1, $base, '0 + ++@x[0] - 1');
is(0 + --@x[0] + 0, $base, '0 + --@x[0] + 0');
is(@x[0],           $base, '@x[0]');

my %z;
%z{0} = 10000;
is(0 + ++%z{0} - 1, $base, '0 + ++%z{0} - 1');
is(0 + %z{0}-- - 1, $base, '0 + %z{0}-- - 1');
is(1 * %z{0},       $base, '1 * %z{0}');
is(0 + %z{0}-- - 0, $base, '0 + %z{0}-- - 0');
is(1 + %z{0},       $base, '1 + %z{0}');
is(1 + %z{0}++,     $base, '1 + %z{0}++');
is(0 + %z{0},       $base, '0 + %z{0}');
is(0 + ++%z{0} - 1, $base, '0 + ++%z{0} - 1');
is(0 + --%z{0} + 0, $base, '0 + --%z{0} + 0');
is(%z{0},           $base, '%z{0}');

# Increment of a Str
#L<S03/Autoincrement precedence/Increment of a>

# XXX: these need to be re-examined and extended per changes to S03.
# Also, see the thread at
# http://www.nntp.perl.org/group/perl.perl6.compiler/2007/06/msg1598.html
# which prompted many of the changes to Str autoincrement/autodecrement.

{
# These are the ranges specified in S03.
# They might be handy for some DDT later.

    my @rangechar = (
        [ 'A', 'Z' ],
        [ 'a', 'z' ],
        [ "\x[391]", "\x[3a9]" ],
        [ "\x[3b1]", "\x[3c9]" ],
        [ "\x[5d0]", "\x[5ea]" ],

        [ '0', '9' ],
        [ "\x[660]", "\x[669]" ],
        [ "\x[966]", "\x[96f]" ],
        [ "\x[9e6]", "\x[9ef]" ],
        [ "\x[a66]", "\x[a6f]" ],
        [ "\x[ae6]", "\x[aef]" ],
        [ "\x[b66]", "\x[b6f]" ],
    );
}

{
    my $x;

    $x = "123.456";
    is( ++$x, "124.456", "'123.456'++ is '124.456' (NOT 123.457)" );
    $x = "124.456";
    is( --$x, "123.456", "'124.456'-- is '123.456'" );
}

{
    my $x;

    $x = "/tmp/pix000.jpg";
    is( ++$x, "/tmp/pix001.jpg", "'/tmp/pix000.jpg'++ is '/tmp/pix001.jpg'" );
    $x = "/tmp/pix001.jpg";
    is( --$x, "/tmp/pix000.jpg", "'/tmp/pix001.jpg'-- is '/tmp/pix000.jpg'" );
}

{
    my $x;

    # EBCDIC check (i and j not contiguous)
    $x = "zi";
    is( ++$x, "zj", "'zi'++ is 'zj'" );
    $x = "zj";
    is( --$x, "zi", "'zj'-- is 'zi'" );
    $x = "zr";

    # EBCDIC check (r and s not contiguous)
    is( ++$x, "zs", "'zr'++ is 'zs'" );
    $x = "zs";
    is( --$x, "zr", "'zs'-- is 'zr'" );
}

{
    my $foo;

    $foo = 'A00';
    ok(--$foo ~~ Failure, "Decrement of 'A00' should fail");

# TODO: Check that the Failure is "Decrement out of range" and not
#       some other unrelated error (for the fail tests above).
}

{
    my $foo;

    $foo = "\x[3a1]";
    #?rakudo todo 'weird ranges'
    is( ++$foo, "\x[3a3]", 'there is no \\x[3a2]' );
}

{
    my $foo = "K\x[3c9]";
    #?rakudo todo 'weird ranges'
    is( ++$foo, "L\x[3b1]", "increment 'K\x[3c9]'" );
}

{
    my $x;
    is ++$x, 1, 'Can autoincrement a Mu variable (prefix)';

    my $y;
    $y++;
    is $y, 1, 'Can autoincrement a Mu variable (postfix)';
}

{
    class Incrementor {
        has $.value;

        method succ() {
            Incrementor.new( value => $.value + 42);
        }
    }

    my $o = Incrementor.new( value => 0 );
    $o++;
    is $o.value, 42, 'Overriding succ catches postfix increment';
    ++$o;
    is $o.value, 84, 'Overriding succ catches prefix increment';
}

{
    class Decrementor {
        has $.value;

        method pred() {
            Decrementor.new( value => $.value - 42);
        }
    }

    my $o = Decrementor.new( value => 100 );
    $o--;
    is $o.value, 58, 'Overriding pred catches postfix decrement';
    --$o;
    is $o.value, 16, 'Overriding pred catches prefix decrement';
}

{
    # L<S03/Autoincrement precedence/Increment of a>
   
    my $x = "b";
    is $x.succ, 'c', '.succ for Str';
    is $x.pred, 'a', '.pred for Str';

    my $y = 1;
    is $y.succ, 2, '.succ for Int';
    is $y.pred, 0, '.pred for Int';

    my $z = Num.new();
    is $z.succ, 1 , '.succ for Num';
    is $z.pred, -1, '.pred for Num'
}

# RT #63644
eval_dies_ok 'my $a; $a++ ++;', 'parse error for "$a++ ++"';

# vim: ft=perl6
