use v6;

use Test;

plan 2;

# currently deprecated core features

my $line;
my $absPROGRAM = $*PROGRAM.abspath;

# $*OS and $OSVER
#?niecza skip 'is DEPRECATED NYI'
{
    $line = $?LINE; $*OS;
    $*OSVER;
    $*OS;
    $*OSVER;
    $*EXECUTABLE_NAME;
    $*PROGRAM_NAME;
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'deprecation $*OS and $*OSVER';
Saw 4 occurrences of deprecated code.
================================================================================
\$*EXECUTABLE_NAME seen at:
  $absPROGRAM, line {$line + 4}
Deprecated since v2015.6, will be removed with release v2015.9!
Please use \$*EXECUTABLE-NAME instead.
--------------------------------------------------------------------------------
\$*OS seen at:
  $absPROGRAM, lines $line,{$line + 2}
Deprecated since v2014.9, will be removed with release v2015.9!
Please use \$*DISTRO.name instead.
--------------------------------------------------------------------------------
\$*OSVER seen at:
  $absPROGRAM, lines {$line + 1},{$line + 3}
Deprecated since v2014.9, will be removed with release v2015.9!
Please use \$*DISTRO.version instead.
--------------------------------------------------------------------------------
\$*PROGRAM_NAME seen at:
  $absPROGRAM, line {$line + 5}
Deprecated since v2015.6, will be removed with release v2015.9!
Please use \$*PROGRAM-NAME instead.
--------------------------------------------------------------------------------
TEXT
} #1

# %foo = {...}
#?niecza skip 'is DEPRECATED NYI'
{
    my %h; $line = $?LINE; %h = { a => 1 };
    %h = { b => 2 };
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'deprecation %h = itemized hash';
Saw 1 occurrence of deprecated code.
================================================================================
%h = itemized hash seen at:
  $*PROGRAM, lines $line,{$line + 1}
Deprecated since v2014.7, will be removed with release v2015.7!
Please use %h = \%(itemized hash) instead.
--------------------------------------------------------------------------------
TEXT
} #1

# vim:set ft=perl6
