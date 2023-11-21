use v6.c;

BEGIN %*ENV<RAKUDO_DEPRECATIONS_FATAL>:delete; # disable fatal setting for tests

use Test;

plan 9;

# L<S02/Deprecations>

my $line;

# just a sub
#?niecza skip 'is DEPRECATED NYI'
{
    my $a;
    my $awith;
    sub a     is DEPRECATED              { $a++     };
    sub awith is DEPRECATED("'fnorkle'") { $awith++ };

    $line = $?LINE; a();
    is $a, 1, 'was "a" really called';
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'right deprecation for a()';
Saw 1 occurrence of deprecated code.
================================================================================
Sub a (from GLOBAL) seen at:
  $*PROGRAM, line $line
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $line = $?LINE; awith();
    awith();
    is $awith, 2, 'was "awith" really called';
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'right deprecation for awith()';
Saw 1 occurrence of deprecated code.
================================================================================
Sub awith (from GLOBAL) seen at:
  $*PROGRAM, lines $line,{$line + 1}
Please use 'fnorkle' instead.
--------------------------------------------------------------------------------
TEXT
} #4

# class with auto/inherited new()
#?niecza skip 'is DEPRECATED NYI'
{
    class A     is DEPRECATED                  { };
    class Awith is DEPRECATED("'Fnorkle.new'") { };

    $line = $?LINE; A.new;
    #?rakudo todo 'NYI'
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'right deprecation for A.new';
Saw 1 occurrence of deprecated code.
================================================================================
Method new (from A) seen at:
  $*PROGRAM, line $line
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $line = $?LINE; Awith.new;
    Awith.new;
    #?rakudo todo 'NYI'
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'right deprecation for Awith.new';
Saw 1 occurrence of deprecated code.
================================================================================
Method new (from Awith) seen at:
  $*PROGRAM, lines $line,{$line + 1}
Please use 'Fnorkle.new' instead.
--------------------------------------------------------------------------------
TEXT
} #2

# class with auto-generated public attribute
#?niecza skip 'is DEPRECATED NYI'
{
    class D     { has $.foo is DEPRECATED          };
    class Dwith { has $.foo is DEPRECATED("'bar'") };

    $line = $?LINE; D.new.foo;
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'right deprecation for D.new.foo';
Saw 1 occurrence of deprecated code.
================================================================================
Method foo (from D) seen at:
  $*PROGRAM, line $line
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $line = $?LINE; Dwith.new;
    Dwith.new;
    #?rakudo todo 'NYI'
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'right deprecation Dwith.new.foo';
Saw 1 occurrence of deprecated code.
================================================================================
Method foo (from Dwith) seen at:
  $*PROGRAM, lines $line,{$line + 1}
Please use 'bar' instead.
--------------------------------------------------------------------------------
TEXT
} #2

# RT #120908
{
    sub rt120908 is DEPRECATED((sub { "a" })()) { };
    rt120908();
    ok Deprecation.report ~~ m/'Sub rt120908 (from GLOBAL) seen at:'/,
        'right deprecation for rt120908()';
}

# vim:set ft=perl6
