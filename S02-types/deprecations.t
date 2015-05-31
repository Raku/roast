use v6;

use Test;

plan 8;

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
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'deprecation $*OS and $*OSVER';
Saw 2 occurrences of deprecated code.
================================================================================
\$*OSVER seen at:
  $absPROGRAM, lines {$line + 1},{$line + 3}
Deprecated since v2014.9, will be removed with release v2015.9!
Please use \$*DISTRO.version instead.
--------------------------------------------------------------------------------
\$*OS seen at:
  $absPROGRAM, lines $line,{$line + 2}
Deprecated since v2014.9, will be removed with release v2015.9!
Please use \$*DISTRO.name instead.
--------------------------------------------------------------------------------
TEXT
} #1

# $*PERL<name>
#?niecza skip 'is DEPRECATED NYI'
{
    $line = $?LINE; say $*PERL<name>;
    say $*PERL<name>;
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'deprecation $*PERL<name>';
Saw 1 occurrence of deprecated code.
================================================================================
\$*PERL<name> seen at:
  $*PROGRAM, lines $line,{$line + 1}
Deprecated since v2014.6, will be removed with release v2015.6!
Please use \$*PERL.name instead.
--------------------------------------------------------------------------------
TEXT
} #1

# $*PERL<compiler><name>
#?niecza skip 'is DEPRECATED NYI'
{
    $line = $?LINE; say $*PERL<compiler><name>;
    say $*PERL<compiler><name>;
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'deprecation $*PERL<compiler><name>';
Saw 1 occurrence of deprecated code.
================================================================================
\$*PERL<compiler><name> seen at:
  $*PROGRAM, lines $line,{$line + 1}
Deprecated since v2014.6, will be removed with release v2015.6!
Please use \$*PERL.compiler.name instead.
--------------------------------------------------------------------------------
TEXT
} #1

# $*PERL<compiler><ver>
#?niecza skip 'is DEPRECATED NYI'
{
    $line = $?LINE; say $*PERL<compiler><ver>;
    say $*PERL<compiler><ver>;
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'deprecation $*PERL<compiler><ver>';
Saw 1 occurrence of deprecated code.
================================================================================
\$*PERL<compiler><ver> seen at:
  $*PROGRAM, lines $line,{$line + 1}
Deprecated since v2014.6, will be removed with release v2015.6!
Please use \$*PERL.compiler.version instead.
--------------------------------------------------------------------------------
TEXT
} #1

# $*PERL<compiler><release-number>
#?niecza skip 'is DEPRECATED NYI'
{
    $line = $?LINE; say $*PERL<compiler><release-number>;
    say $*PERL<compiler><release-number>;
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'deprecation $*PERL<compiler><release-number>';
Saw 1 occurrence of deprecated code.
================================================================================
\$*PERL<compiler><release-number> seen at:
  $*PROGRAM, lines $line,{$line + 1}
Deprecated since v2014.6, will be removed with release v2015.6!
Please use \$*PERL.compiler.release instead.
--------------------------------------------------------------------------------
TEXT
} #1

# $*PERL<compiler><build-date>
#?niecza skip 'is DEPRECATED NYI'
{
    $line = $?LINE; say $*PERL<compiler><build-date>;
    say $*PERL<compiler><build-date>;
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'deprecation $*PERL<compiler><build-date>';
Saw 1 occurrence of deprecated code.
================================================================================
\$*PERL<compiler><build-date> seen at:
  $*PROGRAM, lines $line,{$line + 1}
Deprecated since v2014.6, will be removed with release v2015.6!
Please use \$*PERL.compiler.build-date instead.
--------------------------------------------------------------------------------
TEXT
} #1

# $*PERL<compiler><codename>
#?niecza skip 'is DEPRECATED NYI'
{
    $line = $?LINE; say $*PERL<compiler><codename>;
    say $*PERL<compiler><codename>;
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'deprecation $*PERL<compiler><codename>';
Saw 1 occurrence of deprecated code.
================================================================================
\$*PERL<compiler><codename> seen at:
  $*PROGRAM, lines $line,{$line + 1}
Deprecated since v2014.6, will be removed with release v2015.6!
Please use \$*PERL.compiler.codename instead.
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
