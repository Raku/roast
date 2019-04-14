use v6;

#BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = True;
use Test;

# Test combinations of flags for "%c".  The @info array is intialized with the
# flags (as a string), the size/precision specification (either a string or a
# number), and the expected strings for the values 0, 65 and 129419.  The flags
# values will be expanded to all possible permutations to ensure that the
# order of the flags is irrelevant.  Each flag permutation is combined with
# the size/permutation value to create a proper format string.

my ($v0, $vA, $vB) =
                         0 ,        65 ,    129419 ;
my @info = ( # |-----------|-----------|-----------|
             # no size or size explicitely 0
       '',   '',       "\0",        "A",       "🦋",
      ' ',   '',       "\0",        "A",       "🦋",
      '0',   '',       "\0",        "A",       "🦋",
     '0 ',   '',       "\0",        "A",       "🦋",
      '+',   '',       "\0",        "A",       "🦋",
     '+ ',   '',       "\0",        "A",       "🦋",
     '+0',   '',       "\0",        "A",       "🦋",
    '+0 ',   '',       "\0",        "A",       "🦋",
      '-',   '',       "\0",        "A",       "🦋",
     '-+',   '',       "\0",        "A",       "🦋",
     '- ',   '',       "\0",        "A",       "🦋",
    '-+ ',   '',       "\0",        "A",       "🦋",
     '-0',   '',       "\0",        "A",       "🦋",
    '-+0',   '',       "\0",        "A",       "🦋",
    '-0 ',   '',       "\0",        "A",       "🦋",
   '-+0 ',   '',       "\0",        "A",       "🦋",
      '#',   '',       "\0",        "A",       "🦋",
     '# ',   '',       "\0",        "A",       "🦋",
     '#0',   '',       "\0",        "A",       "🦋",
    '#0 ',   '',       "\0",        "A",       "🦋",
     '#+',   '',       "\0",        "A",       "🦋",
    '#+ ',   '',       "\0",        "A",       "🦋",
    '#+0',   '',       "\0",        "A",       "🦋",
   '#+0 ',   '',       "\0",        "A",       "🦋",
     '#-',   '',       "\0",        "A",       "🦋",
    '#-+',   '',       "\0",        "A",       "🦋",
    '#- ',   '',       "\0",        "A",       "🦋",
   '#-+ ',   '',       "\0",        "A",       "🦋",
    '#-0',   '',       "\0",        "A",       "🦋",
   '#-+0',   '',       "\0",        "A",       "🦋",
   '#-0 ',   '',       "\0",        "A",       "🦋",
  '#-+0 ',   '',       "\0",        "A",       "🦋",

             # size that fits
       '',    3,     "  \0",      "  A",     "  🦋",
      ' ',    3,     "  \0",      "  A",     "  🦋",
      '0',    3,     "00\0",      "00A",     "00🦋",
     '0 ',    3,     "00\0",      "00A",     "00🦋",
      '+',    3,     "  \0",      "  A",     "  🦋",
     '+ ',    3,     "  \0",      "  A",     "  🦋",
     '+0',    3,     "00\0",      "00A",     "00🦋",
    '+0 ',    3,     "00\0",      "00A",     "00🦋",
      '-',    3,     "\0  ",      "A  ",     "🦋  ",
     '-+',    3,     "\0  ",      "A  ",     "🦋  ",
     '- ',    3,     "\0  ",      "A  ",     "🦋  ",
    '-+ ',    3,     "\0  ",      "A  ",     "🦋  ",
     '-0',    3,     "\0  ",      "A  ",     "🦋  ",
    '-+0',    3,     "\0  ",      "A  ",     "🦋  ",
    '-0 ',    3,     "\0  ",      "A  ",     "🦋  ",
   '-+0 ',    3,     "\0  ",      "A  ",     "🦋  ",
      '#',    3,     "  \0",      "  A",     "  🦋",
     '# ',    3,     "  \0",      "  A",     "  🦋",
     '#0',    3,     "00\0",      "00A",     "00🦋",
    '#0 ',    3,     "00\0",      "00A",     "00🦋",
     '#+',    3,     "  \0",      "  A",     "  🦋",
    '#+ ',    3,     "  \0",      "  A",     "  🦋",
    '#+0',    3,     "00\0",      "00A",     "00🦋",
   '#+0 ',    3,     "00\0",      "00A",     "00🦋",
     '#-',    3,     "\0  ",      "A  ",     "🦋  ",
    '#-+',    3,     "\0  ",      "A  ",     "🦋  ",
    '#- ',    3,     "\0  ",      "A  ",     "🦋  ",
   '#-+ ',    3,     "\0  ",      "A  ",     "🦋  ",
    '#-0',    3,     "\0  ",      "A  ",     "🦋  ",
   '#-+0',    3,     "\0  ",      "A  ",     "🦋  ",
   '#-0 ',    3,     "\0  ",      "A  ",     "🦋  ",
  '#-+0 ',    3,     "\0  ",      "A  ",     "🦋  ",

).map: -> $flags, $size, $r0, $rA, $rB {
    my @flat;
    @flat.append('%' ~ $_ ~ $size ~ 'c', $r0, $rA, $rB)
      for $flags.comb.permutations>>.join;
    |@flat
}

plan @info/4;

for @info -> $format, $r0, $rA, $rB {
    subtest {
        plan 3;

        is sprintf($format, $v0), $r0,
          "sprintf('$format',$v0) eq '$r0'";
        is sprintf($format, $vA), $rA,
          "sprintf('$format',$vA) eq '$rA'";
        is sprintf($format, $vB), $rB,
          "sprintf('$format',$vB) eq '$rB'";

    }, "Tested '$format'";
}

# vim: ft=perl6

=finish
