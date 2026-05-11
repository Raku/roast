use v6.e.PREVIEW;
BEGIN %*ENV<RAKU_TEST_DIE_ON_FAIL> = True;
use Test;

# Test combinations of flags for "%c".  The @info array is intialized with the
# flags (as a string), the size/precision specification (either a string or a
# number), and the expected strings for the values 0, 65 and 129419.  The flags
# values will be expanded to all possible permutations to ensure that the
# order of the flags is irrelevant.  Each flag permutation is combined with
# the size/permutation value to create a proper format string.

#                        0 ,        65 ,    129419 ;
my @info = ( # |-----------|-----------|-----------|
             # no size or size explicitely 0
       '',   '',       "\0",        "A",       "🦋", $?LINE,
      ' ',   '',       "\0",        "A",       "🦋", $?LINE,
      '0',   '',       "\0",        "A",       "🦋", $?LINE,
     '0 ',   '',       "\0",        "A",       "🦋", $?LINE,
      '+',   '',       "\0",        "A",       "🦋", $?LINE,
     '+ ',   '',       "\0",        "A",       "🦋", $?LINE,
     '+0',   '',       "\0",        "A",       "🦋", $?LINE,
    '+0 ',   '',       "\0",        "A",       "🦋", $?LINE,
      '-',   '',       "\0",        "A",       "🦋", $?LINE,
     '-+',   '',       "\0",        "A",       "🦋", $?LINE,
     '- ',   '',       "\0",        "A",       "🦋", $?LINE,
    '-+ ',   '',       "\0",        "A",       "🦋", $?LINE,
     '-0',   '',       "\0",        "A",       "🦋", $?LINE,
    '-+0',   '',       "\0",        "A",       "🦋", $?LINE,
    '-0 ',   '',       "\0",        "A",       "🦋", $?LINE,
   '-+0 ',   '',       "\0",        "A",       "🦋", $?LINE,

             # size that fits
       '',    3,     "  \0",      "  A",     "  🦋", $?LINE,
      ' ',    3,     "  \0",      "  A",     "  🦋", $?LINE,
      '0',    3,     "00\0",      "00A",     "00🦋", $?LINE,
     '0 ',    3,     "00\0",      "00A",     "00🦋", $?LINE,
      '+',    3,     "  \0",      "  A",     "  🦋", $?LINE,
     '+ ',    3,     "  \0",      "  A",     "  🦋", $?LINE,
     '+0',    3,     "00\0",      "00A",     "00🦋", $?LINE,
    '+0 ',    3,     "00\0",      "00A",     "00🦋", $?LINE,
      '-',    3,     "\0  ",      "A  ",     "🦋  ", $?LINE,
     '-+',    3,     "\0  ",      "A  ",     "🦋  ", $?LINE,
     '- ',    3,     "\0  ",      "A  ",     "🦋  ", $?LINE,
    '-+ ',    3,     "\0  ",      "A  ",     "🦋  ", $?LINE,
     '-0',    3,     "\0  ",      "A  ",     "🦋  ", $?LINE,
    '-+0',    3,     "\0  ",      "A  ",     "🦋  ", $?LINE,
    '-0 ',    3,     "\0  ",      "A  ",     "🦋  ", $?LINE,
   '-+0 ',    3,     "\0  ",      "A  ",     "🦋  ", $?LINE,
  '#-+0 ',    3,     "\0  ",      "A  ",     "🦋  ", $?LINE,

).map: -> $flags, $size, $r0, $rA, $rB, $line {
    my @flat;
    @flat.append(
      $line,
      '%' ~ $_ ~ $size ~ 'c',
      ($r0 => 0, $rA => 65, $rB => 129419)
    ) for $flags.comb.permutations>>.join;
    @flat.append(
      $line,
      '%' ~ $_ ~ $size ~ 'c',
      ($r0 => 0, $rA => 65, $rB => 129419)
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
