use v6.e.PREVIEW;
BEGIN %*ENV<RAKU_TEST_DIE_ON_FAIL> = True;
use Test;

# Test combinations of flags for "%a" and "%A".  The @info array is
# initialized with the flags (as a string), the size/precision specification
# (as a string), and the expected strings for the values 0, 27.1 and -2.71.
# The flags values will be expanded to all possible permutations to ensure
# that the order of the flags is irrelevant.  Each flag permutation is
# combined with the size/precision value to create a proper format string.
# Each test will be done twice, once for "a" and once for "A".
#
# Without a precision, the output is the exact representation of the double:
# the full mantissa is rendered, with trailing zeroes omitted.  With a
# precision, the mantissa is correctly rounded, ties-to-even.  The "0" flag
# pads between the "0x" prefix and the mantissa, and is ignored when
# combined with "-", as in C.

#                                        0 ,                  27.1 ,                 -2.71 ;
my @info = ( (

             # no size or precision
      '', '',  "0x0p+0",  "0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
     ' ', '', " 0x0p+0", " 0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
     '0', '',  "0x0p+0",  "0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
    '0 ', '', " 0x0p+0", " 0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
     '+', '', "+0x0p+0", "+0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
    '+ ', '', "+0x0p+0", "+0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
    '+0', '', "+0x0p+0", "+0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
   '+0 ', '', "+0x0p+0", "+0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
     '-', '',  "0x0p+0",  "0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
    '-+', '', "+0x0p+0", "+0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
    '- ', '', " 0x0p+0", " 0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
   '-+ ', '', "+0x0p+0", "+0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
    '-0', '',  "0x0p+0",  "0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
   '-+0', '', "+0x0p+0", "+0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
   '-0 ', '', " 0x0p+0", " 0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
  '-+0 ', '', "+0x0p+0", "+0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,

             # hash: always show radix point
     '#', '',  "0x0.p+0",  "0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
    '# ', '', " 0x0.p+0", " 0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
    '#0', '',  "0x0.p+0",  "0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
   '#0 ', '', " 0x0.p+0", " 0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
    '#+', '', "+0x0.p+0", "+0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
   '#+ ', '', "+0x0.p+0", "+0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
   '#+0', '', "+0x0.p+0", "+0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
  '#+0 ', '', "+0x0.p+0", "+0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
    '#-', '',  "0x0.p+0",  "0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
   '#-+', '', "+0x0.p+0", "+0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
   '#- ', '', " 0x0.p+0", " 0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
  '#-+ ', '', "+0x0.p+0", "+0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
   '#-0', '',  "0x0.p+0",  "0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
  '#-+0', '', "+0x0.p+0", "+0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
  '#-0 ', '', " 0x0.p+0", " 0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,
 '#-+0 ', '', "+0x0.p+0", "+0x1.b19999999999ap+4", "-0x1.5ae147ae147aep+1", $?LINE,

             # precision 0
      '',   '.0',  "0x0p+0",  "0x2p+4", "-0x1p+1", $?LINE,
     ' ',   '.0', " 0x0p+0", " 0x2p+4", "-0x1p+1", $?LINE,
     '0',   '.0',  "0x0p+0",  "0x2p+4", "-0x1p+1", $?LINE,
    '0 ',   '.0', " 0x0p+0", " 0x2p+4", "-0x1p+1", $?LINE,
     '+',   '.0', "+0x0p+0", "+0x2p+4", "-0x1p+1", $?LINE,
    '+ ',   '.0', "+0x0p+0", "+0x2p+4", "-0x1p+1", $?LINE,
    '+0',   '.0', "+0x0p+0", "+0x2p+4", "-0x1p+1", $?LINE,
   '+0 ',   '.0', "+0x0p+0", "+0x2p+4", "-0x1p+1", $?LINE,
     '-',   '.0',  "0x0p+0",  "0x2p+4", "-0x1p+1", $?LINE,
    '-+',   '.0', "+0x0p+0", "+0x2p+4", "-0x1p+1", $?LINE,
    '- ',   '.0', " 0x0p+0", " 0x2p+4", "-0x1p+1", $?LINE,
   '-+ ',   '.0', "+0x0p+0", "+0x2p+4", "-0x1p+1", $?LINE,
    '-0',   '.0',  "0x0p+0",  "0x2p+4", "-0x1p+1", $?LINE,
   '-+0',   '.0', "+0x0p+0", "+0x2p+4", "-0x1p+1", $?LINE,
   '-0 ',   '.0', " 0x0p+0", " 0x2p+4", "-0x1p+1", $?LINE,
  '-+0 ',   '.0', "+0x0p+0", "+0x2p+4", "-0x1p+1", $?LINE,

             # precision 3
      '',   '.3',  "0x0.000p+0",  "0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
     ' ',   '.3', " 0x0.000p+0", " 0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
     '0',   '.3',  "0x0.000p+0",  "0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
    '0 ',   '.3', " 0x0.000p+0", " 0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
     '+',   '.3', "+0x0.000p+0", "+0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
    '+ ',   '.3', "+0x0.000p+0", "+0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
    '+0',   '.3', "+0x0.000p+0", "+0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
   '+0 ',   '.3', "+0x0.000p+0", "+0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
     '-',   '.3',  "0x0.000p+0",  "0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
    '-+',   '.3', "+0x0.000p+0", "+0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
    '- ',   '.3', " 0x0.000p+0", " 0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
   '-+ ',   '.3', "+0x0.000p+0", "+0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
    '-0',   '.3',  "0x0.000p+0",  "0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
   '-+0',   '.3', "+0x0.000p+0", "+0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
   '-0 ',   '.3', " 0x0.000p+0", " 0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
  '-+0 ',   '.3', "+0x0.000p+0", "+0x1.b1ap+4", "-0x1.5aep+1", $?LINE,

             # 24 positions
      '',   '24', "                  0x0p+0", "    0x1.b19999999999ap+4", "   -0x1.5ae147ae147aep+1", $?LINE,
     ' ',   '24', "                  0x0p+0", "    0x1.b19999999999ap+4", "   -0x1.5ae147ae147aep+1", $?LINE,
     '0',   '24', "0x0000000000000000000p+0", "0x00001.b19999999999ap+4", "-0x0001.5ae147ae147aep+1", $?LINE,
    '0 ',   '24', " 0x000000000000000000p+0", " 0x0001.b19999999999ap+4", "-0x0001.5ae147ae147aep+1", $?LINE,
     '+',   '24', "                 +0x0p+0", "   +0x1.b19999999999ap+4", "   -0x1.5ae147ae147aep+1", $?LINE,
    '+ ',   '24', "                 +0x0p+0", "   +0x1.b19999999999ap+4", "   -0x1.5ae147ae147aep+1", $?LINE,
    '+0',   '24', "+0x000000000000000000p+0", "+0x0001.b19999999999ap+4", "-0x0001.5ae147ae147aep+1", $?LINE,
   '+0 ',   '24', "+0x000000000000000000p+0", "+0x0001.b19999999999ap+4", "-0x0001.5ae147ae147aep+1", $?LINE,
     '-',   '24', "0x0p+0                  ", "0x1.b19999999999ap+4    ", "-0x1.5ae147ae147aep+1   ", $?LINE,
    '-+',   '24', "+0x0p+0                 ", "+0x1.b19999999999ap+4   ", "-0x1.5ae147ae147aep+1   ", $?LINE,
    '- ',   '24', " 0x0p+0                 ", " 0x1.b19999999999ap+4   ", "-0x1.5ae147ae147aep+1   ", $?LINE,
   '-+ ',   '24', "+0x0p+0                 ", "+0x1.b19999999999ap+4   ", "-0x1.5ae147ae147aep+1   ", $?LINE,
    '-0',   '24', "0x0p+0                  ", "0x1.b19999999999ap+4    ", "-0x1.5ae147ae147aep+1   ", $?LINE,
   '-+0',   '24', "+0x0p+0                 ", "+0x1.b19999999999ap+4   ", "-0x1.5ae147ae147aep+1   ", $?LINE,
   '-0 ',   '24', " 0x0p+0                 ", " 0x1.b19999999999ap+4   ", "-0x1.5ae147ae147aep+1   ", $?LINE,
  '-+0 ',   '24', "+0x0p+0                 ", "+0x1.b19999999999ap+4   ", "-0x1.5ae147ae147aep+1   ", $?LINE,


).map: -> $flags, $size, $r0, $r1, $rm, $line {
    my @flat;
    @flat.append(
      $line,
      '%' ~ $_ ~ $size ~ 'a',
      ($r0 => (0,), $r1 => (27.1,), $rm => (-2.71,))
   ) for $flags.comb.permutations>>.join;
   |@flat
} );

@info.append( (
             # star precision 3
      '',   '.*',  "0x0.000p+0",  "0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
     ' ',   '.*', " 0x0.000p+0", " 0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
     '0',   '.*',  "0x0.000p+0",  "0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
    '0 ',   '.*', " 0x0.000p+0", " 0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
     '+',   '.*', "+0x0.000p+0", "+0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
    '+ ',   '.*', "+0x0.000p+0", "+0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
    '+0',   '.*', "+0x0.000p+0", "+0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
   '+0 ',   '.*', "+0x0.000p+0", "+0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
     '-',   '.*',  "0x0.000p+0",  "0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
    '-+',   '.*', "+0x0.000p+0", "+0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
    '- ',   '.*', " 0x0.000p+0", " 0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
   '-+ ',   '.*', "+0x0.000p+0", "+0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
    '-0',   '.*',  "0x0.000p+0",  "0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
   '-+0',   '.*', "+0x0.000p+0", "+0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
   '-0 ',   '.*', " 0x0.000p+0", " 0x1.b1ap+4", "-0x1.5aep+1", $?LINE,
  '-+0 ',   '.*', "+0x0.000p+0", "+0x1.b1ap+4", "-0x1.5aep+1", $?LINE,

).map: -> $flags, $size, $r0, $r1, $rm, $line {
    my @flat;
    @flat.append(
      $line,
      '%' ~ $_ ~ $size ~ 'a',
      ($r0 => (3,0), $r1 => (3,27.1), $rm => (3,-2.71))
   ) for $flags.comb.permutations>>.join;
   |@flat
} );

plan @info/3;

for @info -> $line, $format, @tests {
    subtest  "Tested '$format' at line $line" => {
        plan 2 * @tests;

        for @tests {
            is-deeply sprintf($format, |.value), .key,
              qq/sprintf("$format",{.value.list.join(",")}) eq '{.key}'/;
            is-deeply sprintf($format.uc, |.value), .key.uc,
              qq/sprintf("{$format.uc}",{.value.list.join(",")}) eq '{.key.uc}'/;
        }
    }
}

# vim: expandtab shiftwidth=4
