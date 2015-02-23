use v6;

use Test;

plan 11;

# currently deprecated core features

my $line;

my $PROGRAM = $*PROGRAM.relpath;

# $*OS
#?niecza skip 'is DEPRECATED NYI'
{
    $line = $?LINE; say $*OS;
    say $*OS;
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'deprecation $*OS';
Saw 1 call to deprecated code during execution.
================================================================================
\$*OS called at:
  $PROGRAM, lines $line,{$line + 1}
Deprecated since v2014.9, will be removed with release v2015.9!
Please use \$*DISTRO.name instead.
--------------------------------------------------------------------------------
TEXT
} #1

# $*OSVER
#?niecza skip 'is DEPRECATED NYI'
{
    $line = $?LINE; say $*OSVER;
    say $*OSVER;
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'deprecation $*OSVER';
Saw 1 call to deprecated code during execution.
================================================================================
\$*OSVER called at:
  $PROGRAM, lines $line,{$line + 1}
Deprecated since v2014.9, will be removed with release v2015.9!
Please use \$*DISTRO.version instead.
--------------------------------------------------------------------------------
TEXT
} #1

# $*VM<name>
#?niecza skip 'is DEPRECATED NYI'
{
    $line = $?LINE; say $*VM<name>;
    say $*VM<name>;
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'deprecation $*VM<name>';
Saw 1 call to deprecated code during execution.
================================================================================
\$*VM<name> called at:
  $PROGRAM, lines $line,{$line + 1}
Deprecated since v2014.5, will be removed with release v2015.5!
Please use \$*VM.name instead.
--------------------------------------------------------------------------------
TEXT
} #1

# $*VM<config>
#?niecza skip 'is DEPRECATED NYI'
{
    $line = $?LINE; say $*VM<config>;
    say $*VM<config>;
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'deprecation $*VM<config>';
Saw 1 call to deprecated code during execution.
================================================================================
\$*VM<config> called at:
  $PROGRAM, lines $line,{$line + 1}
Deprecated since v2014.5, will be removed with release v2015.5!
Please use \$*VM.config instead.
--------------------------------------------------------------------------------
TEXT
} #1

# $*PERL<name>
#?niecza skip 'is DEPRECATED NYI'
{
    $line = $?LINE; say $*PERL<name>;
    say $*PERL<name>;
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'deprecation $*PERL<name>';
Saw 1 call to deprecated code during execution.
================================================================================
\$*PERL<name> called at:
  $PROGRAM, lines $line,{$line + 1}
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
Saw 1 call to deprecated code during execution.
================================================================================
\$*PERL<compiler><name> called at:
  $PROGRAM, lines $line,{$line + 1}
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
Saw 1 call to deprecated code during execution.
================================================================================
\$*PERL<compiler><ver> called at:
  $PROGRAM, lines $line,{$line + 1}
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
Saw 1 call to deprecated code during execution.
================================================================================
\$*PERL<compiler><release-number> called at:
  $PROGRAM, lines $line,{$line + 1}
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
Saw 1 call to deprecated code during execution.
================================================================================
\$*PERL<compiler><build-date> called at:
  $PROGRAM, lines $line,{$line + 1}
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
Saw 1 call to deprecated code during execution.
================================================================================
\$*PERL<compiler><codename> called at:
  $PROGRAM, lines $line,{$line + 1}
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
Saw 1 call to deprecated code during execution.
================================================================================
%h = itemized hash called at:
  $PROGRAM, lines $line,{$line + 1}
Deprecated since v2014.7, will be removed with release v2015.7!
Please use %h = \%(itemized hash) instead.
--------------------------------------------------------------------------------
TEXT
} #1

# vim:set ft=perl6
