use v6;

BEGIN %*ENV<RAKUDO_DEPRECATIONS_FATAL>:delete; # disable fatal setting for tests

use Test;

plan 1;

# currently deprecated core features

my $line;
my $absPROGRAM = $*PROGRAM.abspath;

#?niecza skip 'is DEPRECATED NYI'
{
    $line = $?LINE; $*OS;
    $*EXECUTABLE_NAME;
    $*PROGRAM_NAME;
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'deprecation $*OS and $*OSVER';
Saw 2 occurrences of deprecated code.
================================================================================
\$*EXECUTABLE_NAME seen at:
  $absPROGRAM, line {$line + 1}
Deprecated since v2015.6, will be removed with release v2015.9!
Please use \$*EXECUTABLE-NAME instead.
--------------------------------------------------------------------------------
\$*PROGRAM_NAME seen at:
  $absPROGRAM, line {$line + 2}
Deprecated since v2015.6, will be removed with release v2015.9!
Please use \$*PROGRAM-NAME instead.
--------------------------------------------------------------------------------
TEXT
} #1

# vim:set ft=perl6
