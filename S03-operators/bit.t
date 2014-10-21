use v6;

use Test;

# Mostly copied from Perl 5.8.4 s t/op/bop.t

plan 38;

# test the bit operators '&', '|', '^', '+<', and '+>'

# numerics

# L<S03/Changes to Perl 5 operators/Bitwise operators get a data type prefix>
{

  # numeric
  is( 0xdead +& 0xbeef,   0x9ead,    'numeric bitwise +& of hexadecimal' );
  is( 0xdead +| 0xbeef,   0xfeef,    'numeric bitwise +| of hexadecimal' );
  is( 0xdead +^ 0xbeef,   0x6042,    'numeric bitwise +^ of hexadecimal' );
  is( +^0xdead +& 0xbeef, 0x2042,    'numeric bitwise +^ and +& together' );

  # very large numbers
  is 0xdeaddead0000deaddead0000dead +& 0xbeef0000beef0000beef0000beef,
     0x9ead0000000000009ead00009ead,
     'numeric bitwise +& of bigint';
  is 0xdeaddead0000deaddead0000dead +| 0xbeef0000beef0000beef0000beef,
     0xfeefdeadbeefdeadfeef0000feef,
     'numeric bitwise +| of bigint';
  is 0xdeaddead0000deaddead0000dead +^ 0xbeef0000beef0000beef0000beef,
     0x6042deadbeefdead604200006042,
     'numeric bitwise +^ of bigint';
  is +^ 0xdeaddead0000deaddead0000dead, -0xdeaddead0000deaddead0000deae,
     'numeric bitwise negation';

  # RT #121810
  is 0x0123456789abcdef, 81985529216486895,
      'correct bit result with big enough hexadecimal (0x) literal';

  # Negative numbers.  These really need more tests for bigint vs sized natives
  # RT #122310
  is (-5 +& -2),(-6), "logical AND of two negative Int is twos complement";
  is (-7 +| -6),(-5), "logical OR of two negative Int is twos complement";
  is (-7 +^ -6),( 3), "logical XOR of two negative Int is twos complement";

  # string
  #?niecza 6 skip 'string bitops'
  is( 'a' ~& 'A',         'A',       'string bitwise ~& of "a" and "A"' );
  is( 'a' ~| 'b',         'c',       'string bitwise ~| of "a" and "b"' );
  is( 'a' ~^ 'B',         '#',       'string bitwise ~^ of "a" and "B"' );
  is( 'AAAAA' ~& 'zzzzz', '@@@@@',   'short string bitwise ~&' );
  is( 'AAAAA' ~| 'zzzzz', '{{{{{',   'short string bitwise ~|' );
  is( 'AAAAA' ~^ 'zzzzz', ';;;;;',   'short string bitwise ~^' );

  # long strings
  my $foo = "A" x 150;
  my $bar = "z" x 75;
  my $zap = "A" x 75;

  #?niecza 3 skip 'string bitops'
  is( $foo ~& $bar, '@' x 75,        'long string bitwise ~&, truncates' );
  is( $foo ~| $bar, '{' x 75 ~ $zap, 'long string bitwise ~|, no truncation' );
  is( $foo ~^ $bar, ';' x 75 ~ $zap, 'long string bitwise ~^, no truncation' );

  # "interesting" tests from a long time back...
  #?niecza 2 skip 'string bitops'
  is( "ok \xFF\xFF\n" ~& "ok 19\n", "ok 19\n", 'stringwise ~&, arbitrary string' );
  is( "ok 20\n" ~| "ok \0\0\n", "ok 20\n",     'stringwise ~|, arbitrary string' );

  # bit shifting
  is( 32 +< 1,            64,     'shift one bit left' );
  is( 32 +> 1,            16,     'shift one bit right' );
  is( 257 +< 7,           32896,  'shift seven bits left' );
  is( 33023 +> 7,         257,    'shift seven bits right' );
  # RT #115958
  is (-4..-1 X+> 1..3), (-2,-1,-1,-2,-1 xx 8), "right shift is 2s complement";

  is 0xdeaddead0000deaddead0000dead +< 4, 0xdeaddead0000deaddead0000dead0, 'shift bigint 4 bits left';
  is 0xdeaddead0000deaddead0000dead +> 4, 0xdeaddead0000deaddead0000dea, 'shift bigint 4 bits right';
}

{
  # Tests to see if you really can do casts negative floats to unsigned properly
  my $neg1 = -1.0.Num;
  my $neg7 = -7.0.Num;

  is(+^ $neg1, 0, 'cast numeric float to unsigned' );
  is(+^ $neg7, 6, 'cast -7 to 6 with +^' );
  ok(+^ $neg7 == 6, 'cast -7 with equality testing' );

}

# RT #77232 - precedence of +< and +>
{
  is( 48 + 0 +< 8, 48 + (0 +< 8), 'RT 77232 precedence of +<' );
  is( 48 + 0 +< 8, 48 + (0 +< 8), 'RT 77232 precedence of +>' );
  is( 2 ** 3 +< 3, (2 ** 3) +< 3, 'RT 77232 precedence of +<' );
  is( 2 ** 5 +> 2, (2 ** 5) +> 2, 'RT 77232 precedence of +>' );
}

# RT #109740
{
    my ($x, $y) = (2**30, 1);
    is +^$x +& $y, 1, 'large-ish bit ops';
}


# signed vs. unsigned
#ok((+^0 +> 0 && do { use integer; ~0 } == -1));

#my $bits = 0;
#for (my $i = ~0; $i; $i >>= 1) { ++$bits; }
#my $cusp = 1 << ($bits - 1);


#ok(($cusp & -1) > 0 && do { use integer; $cusp & -1 } < 0);
#ok(($cusp | 1) > 0 && do { use integer; $cusp | 1 } < 0);
#ok(($cusp ^ 1) > 0 && do { use integer; $cusp ^ 1 } < 0);
#ok((1 << ($bits - 1)) == $cusp &&
#    do { use integer; 1 << ($bits - 1) } == -$cusp);
#ok(($cusp >> 1) == ($cusp / 2) &&
#    do { use integer; abs($cusp >> 1) } == ($cusp / 2));

#--
#$Aaz = chr(ord("A") & ord("z"));
#$Aoz = chr(ord("A") | ord("z"));
#$Axz = chr(ord("A") ^ ord("z"));
# instead of $Aaz x 5, literal "@@@@@" is used and thus ascii assumed below
# (for now...)


#if ("o\o000 \0" ~ "1\o000" ~^ "\o000k\02\o000\n" eq "ok 21\n") { say "ok 15" } else { say "not ok 15" }

#if ("ok \x{FF}\x{FF}\n" ~& "ok 22\n" eq "ok 22\n") { say "ok 16" } else { say "not ok 16" }
#if ("ok 23\n" ~| "ok \x{0}\x{0}\n" eq "ok 23\n") { say "ok 17" } else { say "not ok 17" }
#if ("o\x{0} \x{0}4\x{0}" ~^ "\x{0}k\x{0}2\x{0}\n" eq "ok 24\n") { say "ok 18" } else { say "not ok 18" }

# More variations on 19 and 22
#if ("ok \xFF\x{FF}\n" ~& "ok 41\n" eq "ok 41\n") { say "ok 19" } else { say "not ok 19" }
#if ("ok \x{FF}\xFF\n" ~& "ok 42\n" eq "ok 42\n") { say "ok 20" } else { say "not ok 20" }

# vim: ft=perl6
