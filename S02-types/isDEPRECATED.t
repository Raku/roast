use v6;

use Test;

plan 21;

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
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'right deprecation for a()';
Saw 1 call to deprecated code during execution.
================================================================================
Sub a (from GLOBAL) called at:
  $*PROGRAM, line $line
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $line = $?LINE; awith();
    awith();
    is $awith, 2, 'was "awith" really called';
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'right deprecation for awith()';
Saw 1 call to deprecated code during execution.
================================================================================
Sub awith (from GLOBAL) called at:
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
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'right deprecation for A.new';
Saw 1 call to deprecated code during execution.
================================================================================
Method new (from A) called at:
  $*PROGRAM, line $line
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $line = $?LINE; Awith.new;
    Awith.new;
    #?rakudo todo 'NYI'
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'right deprecation for Awith.new';
Saw 1 call to deprecated code during execution.
================================================================================
Method new (from Awith) called at:
  $*PROGRAM, lines $line,{$line + 1}
Please use 'Fnorkle.new' instead.
--------------------------------------------------------------------------------
TEXT
} #2

# class with explicit new()
#?niecza skip 'is DEPRECATED NYI'
{
    my $B;
    my $Bwith;
    class B     is DEPRECATED                 { method new { $B++     } };
    class Bwith is DEPRECATED("'Borkle.new'") { method new { $Bwith++ } };

    $line = $?LINE; B.new;
    is $B, 1, 'was "B.new" really called';
    #?rakudo todo 'NYI'
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'right deprecation for B.new';
Saw 1 call to deprecated code during execution.
================================================================================
Method new (from B) called at:
  $*PROGRAM, line $line
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $line = $?LINE; Bwith.new;
    Bwith.new;
    is $Bwith, 2, 'was "Bwith.new" really called';
    #?rakudo todo 'NYI'
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'right deprecation for Bwith.new';
Saw 1 call to deprecated code during execution.
================================================================================
Method new (from Bwith) called at:
  $*PROGRAM, lines $line,{$line + 1}
Please use 'Borkle.new' instead.
--------------------------------------------------------------------------------
TEXT
} #4

# method in class
#?niecza skip 'is DEPRECATED NYI'
{
    my $C;
    my $Cwith;
    class C     { method foo is DEPRECATED          { $C++     } };
    class Cwith { method foo is DEPRECATED("'bar'") { $Cwith++ } };

    $line = $?LINE; C.new.foo;
    is $C, 1, 'was "C.new.foo" really called';
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'right deprecation for C.new.foo';
Saw 1 call to deprecated code during execution.
================================================================================
Method foo (from C) called at:
  $*PROGRAM, line $line
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $line = $?LINE; Cwith.new.foo;
    Cwith.new.foo;
    is $Cwith, 2, 'was "Cwith.new.foo" really called';
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'right deprecation Cwith.new.foo';
Saw 1 call to deprecated code during execution.
================================================================================
Method foo (from Cwith) called at:
  $*PROGRAM, lines $line,{$line + 1}
Please use 'bar' instead.
--------------------------------------------------------------------------------
TEXT
} #4

# class with auto-generated public attribute
#?niecza skip 'is DEPRECATED NYI'
{
    class D     { has $.foo is DEPRECATED          };
    class Dwith { has $.foo is DEPRECATED("'bar'") };

    $line = $?LINE; D.new.foo;
    #?rakudo todo 'NYI'
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'right deprecation for D.new.foo';
Saw 1 call to deprecated code during execution.
================================================================================
Method foo (from D) called at:
  $*PROGRAM, line $line
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $line = $?LINE; Dwith.new;
    Dwith.new;
    #?rakudo todo 'NYI'
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'right deprecation Dwith.new.foo';
Saw 1 call to deprecated code during execution.
================================================================================
Method foo (from Dwith) called at:
  $*PROGRAM, lines $line,{$line + 1}
Please use 'bar' instead.
--------------------------------------------------------------------------------
TEXT
} #2

# class with private attribute and homemade accessor
#?niecza skip 'is DEPRECATED NYI'
{
    my $E;
    my $Ewith;
    class E     { has $!foo is DEPRECATED;          method foo { $E++     } };
    class Ewith { has $!foo is DEPRECATED("'bar'"); method foo { $Ewith++ } };

    $line = $?LINE; E.new.foo;
    is $E, 1, 'was "E.new.foo" really called';
    #?rakudo todo 'NYI'
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'right deprecation for E.new.foo';
Saw 1 call to deprecated code during execution.
================================================================================
Method foo (from E) called at:
  $*PROGRAM, line $line
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $line = $?LINE; Ewith.new.foo;
    Ewith.new.foo;
    is $Ewith, 2, 'was "Ewith.new.foo" really called';
    #?rakudo todo 'NYI'
    is Deprecation.report, qq:to/TEXT/.chop.subst(/\r/, '', :g), 'right deprecation Ewith.new.foo';
Saw 1 call to deprecated code during execution.
================================================================================
Method foo (from Ewith) called at:
  $*PROGRAM, lines $line,{$line + 1}
Please use 'bar' instead.
--------------------------------------------------------------------------------
TEXT
} #4

# RT #120908
{
    sub rt120908 is DEPRECATED((sub { "a" })()) { };
    rt120908();
    ok Deprecation.report ~~ m/'Sub rt120908 (from GLOBAL) called at:'/,
        'right deprecation for rt120908()';
}

# vim:set ft=perl6
