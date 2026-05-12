use v6.e.PREVIEW;
BEGIN %*ENV<RAKU_TEST_DIE_ON_FAIL> = True;
use Test;

# Test combinations of flags for "%u".  The @info array is intialized with
# the flags (as a string), the size/precision specification (either a string
# or a # number), and the expected strings for the values 0, 1 and 314.
# The flags values will be expanded to all possible permutations to ensure
# that the order of the flags is irrelevant.  Each flag permutation is
# combined with the size/permutation value to create a proper format string.

#                        0 ,         1 ,       314 ;
my @info = ( # |-----------|-----------|-----------|
             # no size or size explicitely 0
       '',   '',        "0",        "1",      "314", $?LINE,
      ' ',   '',        "0",        "1",      "314", $?LINE,
      '0',   '',        "0",        "1",      "314", $?LINE,
     '0 ',   '',        "0",        "1",      "314", $?LINE,
      '+',   '',        "0",        "1",      "314", $?LINE,
     '+ ',   '',        "0",        "1",      "314", $?LINE,
     '+0',   '',        "0",        "1",      "314", $?LINE,
    '+0 ',   '',        "0",        "1",      "314", $?LINE,
      '-',   '',        "0",        "1",      "314", $?LINE,
     '-+',   '',        "0",        "1",      "314", $?LINE,
     '- ',   '',        "0",        "1",      "314", $?LINE,
    '-+ ',   '',        "0",        "1",      "314", $?LINE,
     '-0',   '',        "0",        "1",      "314", $?LINE,
    '-+0',   '',        "0",        "1",      "314", $?LINE,
    '-0 ',   '',        "0",        "1",      "314", $?LINE,
   '-+0 ',   '',        "0",        "1",      "314", $?LINE,

             # 2 positions, usually doesn't fit
       '',    2,       " 0",       " 1",      "314", $?LINE,
      ' ',    2,       " 0",       " 1",      "314", $?LINE,
      '0',    2,       "00",       "01",      "314", $?LINE,
     '0 ',    2,       "00",       "01",      "314", $?LINE,
      '+',    2,       " 0",       " 1",      "314", $?LINE,
     '+ ',    2,       " 0",       " 1",      "314", $?LINE,
     '+0',    2,       "00",       "01",      "314", $?LINE,
    '+0 ',    2,       "00",       "01",      "314", $?LINE,
      '-',    2,       "0 ",       "1 ",      "314", $?LINE,
     '-+',    2,       "0 ",       "1 ",      "314", $?LINE,
     '- ',    2,       "0 ",       "1 ",      "314", $?LINE,
    '-+ ',    2,       "0 ",       "1 ",      "314", $?LINE,
     '-0',    2,       "0 ",       "1 ",      "314", $?LINE,
    '-+0',    2,       "0 ",       "1 ",      "314", $?LINE,
    '-0 ',    2,       "0 ",       "1 ",      "314", $?LINE,
   '-+0 ',    2,       "0 ",       "1 ",      "314", $?LINE,

             # 8 positions, should always fit
       '',    8, "       0", "       1", "     314", $?LINE,
      ' ',    8, "       0", "       1", "     314", $?LINE,
      '0',    8, "00000000", "00000001", "00000314", $?LINE,
     '0 ',    8, "00000000", "00000001", "00000314", $?LINE,
      '+',    8, "       0", "       1", "     314", $?LINE,
     '+ ',    8, "       0", "       1", "     314", $?LINE,
     '+0',    8, "00000000", "00000001", "00000314", $?LINE,
    '+0 ',    8, "00000000", "00000001", "00000314", $?LINE,
      '-',    8, "0       ", "1       ", "314     ", $?LINE,
     '-+',    8, "0       ", "1       ", "314     ", $?LINE,
     '- ',    8, "0       ", "1       ", "314     ", $?LINE,
    '-+ ',    8, "0       ", "1       ", "314     ", $?LINE,
     '-0',    8, "0       ", "1       ", "314     ", $?LINE,
    '-+0',    8, "0       ", "1       ", "314     ", $?LINE,
    '-0 ',    8, "0       ", "1       ", "314     ", $?LINE,
   '-+0 ',    8, "0       ", "1       ", "314     ", $?LINE,

).map: -> $flags, $size, $r0, $r1, $r4, $line {
    my @flat;
    @flat.append(
      $line,
      '%' ~ $_ ~ $size ~ 'u',
      ($r0 => 0, $r1 => 1, $r4 => 314)
    ) for $flags.comb.permutations>>.join;
    @flat.append(
      $line,
      '%' ~ $_ ~ $size ~ 'u',
      ($r0 => 0, $r1 => 1, $r4 => 314)
    ) for "#$flags".comb.permutations>>.join;
    |@flat
}

plan @info/3;

for @info -> $line, $format, @tests {
    subtest "Tested '$format' at line $line" => {
        plan +@tests;

        is-deeply sprintf($format, |.value), .key,
          qq/sprintf("$format",{.value.list.join(",")}) eq '{.key}'/
          for @tests;
    }
}

# vim: expandtab shiftwidth=4
