# S02-literals/allomorphic.t --- Tests for the various allmorphic types, and val() processing

use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S02/Allomorphic value semantics>

plan 118;

## Sanity tests (if your compiler fails these, there's not much hope for the
## rest of the test)

lives-ok {val("foo")}, "val() exists";

## IntStr

{
    my $intval = val("42");

    isa-ok $intval, IntStr, "val(\"42\") returns an IntStr";
    isa-ok $intval, Int,    "val(\"42\") can be an Int";
    isa-ok $intval, Str,    "val(\"42\") can be a Str";

    is +$intval, 42, "val(\"42\") is equal to integer 42";
    is ~$intval, "42", "val(\"42\") is equal to string \"42\"";
}

{
    my $intval = val("    -42");

    isa-ok $intval, IntStr, "val(\"    -42\") returns an IntStr";
    isa-ok $intval, Int,    "val(\"    -42\") can be an Int";
    isa-ok $intval, Str,    "val(\"    -42\") can be a Str";

    is +$intval, -42, "val(\"    -42\") is equal to integer -42";
    is ~$intval, "    -42", "val(\"    -42\") is equal to string \"    -42\"";
}

## RatStr

{
    my $ratval = val("1/5");

    isa-ok $ratval, RatStr, "val(\"1/5\") returns a RatStr";
    isa-ok $ratval, Rat,    "val(\"1/5\") can be a Rat";
    isa-ok $ratval, Str,    "val(\"1/5\") can be a Str";

    is +$ratval, 0.2,   "val(\"1/5\") is equal to rational 0.2";
    is ~$ratval, "1/5", "val(\"1/5\") is equal to string \"1/5\"";
}

{
    my $ratval = val(" -0.7\t");

    isa-ok $ratval, RatStr, "val(\" -0.7\\t\") returns a RatStr";
    isa-ok $ratval, Rat,    "val(\" -0.7\\t\") can be a Rat";
    isa-ok $ratval, Str,    "val(\" -0.7\\t\") can be a Str";

    is +$ratval, -0.7, "val(\" -0.7\\t\") is equal to rational -0.7";
    is ~$ratval, " -0.7\t", "val(\" -0.7\\t\") is equal to string \" -0.7\\t\"";
}

## NumStr

{
    my $numval = val("6.02e23");

    isa-ok $numval, NumStr, "val(\"6.02e23\") returns a NumStr";
    isa-ok $numval, Num,    "val(\"6.02e23\") can be a Num";
    isa-ok $numval, Str,    "val(\"6.02e23\") can be a Str";

    is +$numval, 6.02e23, "val(\"6.02e23\") is equal to floating-point 6.02e23";
    is ~$numval, "6.02e23", "val(\"6.02e23\") is equal to string \"6.02e23\"";
}

{
    my $numval = val("+1.200e-10  ");

    isa-ok $numval, NumStr, "val(\"+1.200e-10  \") returns a NumStr";
    isa-ok $numval, Num,    "val(\"+1.200e-10  \") can be a Num";
    isa-ok $numval, Str,    "val(\"+1.200e-10  \") can be a Str";

    is +$numval, 1.2e-10, "val(\"+1.200e-10  \") is equal to floating-point 1.2e-10";
    is ~$numval, "+1.200e-10  ", "val(\"+1.200e-10  \") is equal to string \"+1.200e-10  \"";
}

## ComplexStr

{
    my $cmpxval = val("1+2i");

    isa-ok $cmpxval, ComplexStr, "val(\"1+2i\") returns a ComplexStr";
    isa-ok $cmpxval, Complex,    "val(\"1+2i\") can be a Complex";
    isa-ok $cmpxval, Str,        "val(\"1+2i\") can be a Str";

    is +$cmpxval, (1+2i), "val(\"1+2i\") is equal to complex number 1+2i";
    is ~$cmpxval, "1+2i", "val(\"1+2i\") is equal to string \"1+2i\"";
}

{
    my $cmpxval = val(" +1.0-Inf\\i ");

    isa-ok $cmpxval, ComplexStr, Q[val(" +1.0-Inf\\i ") returns a ComplexStr];
    isa-ok $cmpxval, Complex,    Q[val(" +1.0-Inf\\i ") can be a Complex];
    isa-ok $cmpxval, Str,        Q[val(" +1.0-Inf\\i ") can be a Str];

    is +$cmpxval, (1-Inf\i), Q[val(" +1.0-Inf\\i ") is equal to complex number 1-Inf\i];
    is ~$cmpxval, " +1.0-Inf\\i ", Q[val(" +1.0-Inf\\i ") is equal to string " +1.0-Inf\\i "];
}

# Note: L<S02/The :val modifier> seems to suggest that version literals and
# enums would be recognized by val() as well, which implies a VersionStr (not
# fundamentally different from the others) and some kind of EnumStr that sounds
# quite a bit more interesting.

## Quoting forms (consider using subtests on these?)

{
    my @wordlist = qw[1 2/3 4.5 6e7 8+9i] Z (IntStr, RatStr, RatStr, NumStr, ComplexStr);

    for @wordlist -> ($val, $wrong-type) {
        isa-ok $val, Str, "'$val' from qw[] is a Str";
        nok $val.isa($wrong-type), "'$val' from qw[] is not a $wrong-type.raku()";
    }
}

{
    my @wordlist = qqww[1 2/3 4.5 6e7 8+9i] Z (IntStr, RatStr, RatStr, NumStr, ComplexStr);

    for @wordlist -> ($val, $wrong-type) {
        isa-ok $val, Str, "'$val' from qqww[] is a Str";
        nok $val.isa($wrong-type), "'$val' from qqww[] is not a $wrong-type.raku()";
    }
}

{
    my @wordlist  = qw:v[1 2/3 4.5 6e7 8+9i];
    my @purenum   = Int, Rat, Rat, Num, Complex;
    my @allotypes = IntStr, RatStr, RatStr, NumStr, ComplexStr;

    for (@wordlist Z @purenum Z @allotypes) -> ($val, $ntype, $atype) {
        isa-ok $val, Str,    "'$val' from qw:v[] is a Str";
        isa-ok $val, $ntype, "'$val' from qw:v[] is a $ntype.raku()";
        isa-ok $val, $atype, "'$val' from qw:v[] is a $atype.raku()";
    }
}

{
    my @wordlist  = qqww:v[1 2/3 4.5 6e7 8+9i];
    my @purenum   = Int, Rat, Rat, Num, Complex;
    my @allotypes = IntStr, RatStr, RatStr, NumStr, ComplexStr;

    for (@wordlist Z @purenum Z @allotypes) -> ($val, $ntype, $atype) {
        isa-ok $val, Str,    "'$val' from qw:v[] is a Str";
        isa-ok $val, $ntype, "'$val' from qw:v[] is a $ntype.raku()";
        isa-ok $val, $atype, "'$val' from qw:v[] is a $atype.raku()";
    }
}

{
    my @written = qw:v[1 2/3 4.5 6e7 8+9i ten];
    my @angled  =     <1 2/3 4.5 6e7 8+9i ten>;

    is-deeply @angled, @written, "<...> is equivalent to qw:v[...]";
}

{
    my $num = "4.5";
    my @written = qqww:v[1 2/3 $num 6e7 8+9i ten];
    my @angled  =       «1 2/3 $num 6e7 8+9i ten»;

    is-deeply @angled, @written, "«...» is equivalent to qqww:v[...]";
}

{
    sub want-int(int $x) { $x }
    sub want-num(num $x) { $x }
    sub want-str(str $x) { $x }
    lives-ok { want-int(val('42')) }, 'val("42") can be passed to native int parameter';
    dies-ok { want-int(val('4e2')) }, 'val("4e2") cannot be passed to native int parameter';
    lives-ok { want-num(val('4e2')) }, 'val("4e2") can be passed to native num parameter';
    dies-ok { want-num(val('42')) }, 'val("42") cannot be passed to native num parameter';
    lives-ok { want-str(val('42')) }, 'val("42") can be passed to native str parameter';
    lives-ok { want-str(val('4e2')) }, 'val("4e2") can be passed to native str parameter';
}

# Environment variables produce allomorphic types, too.
{
    %*ENV<FOO> = '42';
    is_run 'print %*ENV<FOO>.^name', { status => 0, out => 'IntStr', err => '' },
        'int/string "42" is an IntStr when passed via ENV';

    # This test would break without allomorphs because the string "0" is trueish.
    %*ENV<FOO> = '0';
    is_run 'print so %*ENV<FOO>', { status => 0, out => 'False', err => '' },
        'int/string "0" is falsish when passed via ENV';
}

# https://irclog.perlgeek.de/perl6/2016-11-21#i_13606506
is-deeply ~<2>, '2', 'prefix:<~> coerces allomorphs to Str';

subtest 'U+2212 parses correctly in compound literals' => {
    plan 4;

    is-deeply <5−1i>,   5-1i, '<5−1i> is a literal Complex';
    is-deeply <−5−1i>, -5-1i, '<−5−1i> is a literal Complex';
    is-deeply <−5+1i>, -5+1i, '<−5+1i> is a literal Complex';
    is-deeply <−1/2>,   -0.5, '<−1/2> is a literal Rat';
}

# https://irclog.perlgeek.de/perl6/2017-05-01#i_14514985
subtest 'eqv with allomorphs' => {
    my @tests = [X] <1 1.0 1e0 1+0i> xx 2;
    plan +@tests;
    for @tests -> ($a, $b) {
        $a.^name eq $b.^name
            ?? is-deeply $a eqv $b, True,  "$a.raku() eqv $b.raku()"
            !! is-deeply $a eqv $b, False, "$a.raku() eqv $b.raku()"
    }
}

# https://irclog.perlgeek.de/perl6/2017-05-01#i_14514985
subtest 'cmp with allomorphs' => {
    my @same = <1  1.0  1e0  1+0i  1+1i>;
    my @less =  <1>    => <2>, <1>    => <2.0>, <1>    => <2e0>, <1>    => <2+0i>,
                <1.0>  => <2>, <1.0>  => <2.0>, <1.0>  => <2e0>, <1.0>  => <2+0i>,
                <1e0>  => <2>, <1e0>  => <2.0>, <1e0>  => <2e0>, <1e0>  => <2+0i>,
                <1+0i> => <2>, <1+0i> => <2.0>, <1+0i> => <2e0>, <1+0i> => <2+0i>;
    my @more = @less.map: { .value => .key };
    plan @same + @less + @more;

    is-deeply $_ cmp $_, Same,  "{.raku} cmp {.raku}" for @same;

    for @less -> (:key($a), :value($b)) {
        is-deeply $a cmp $b, Less, "$a.raku() cmp $b.raku()"
    }

    for @more -> (:key($a), :value($b)) {
        is-deeply $a cmp $b, More, "$a.raku() cmp $b.raku()"
    }
}

subtest 'test eqv for weird allomorphs' => {
    plan 8;

    is-deeply IntStr    .new(42,    "x") eqv IntStr    .new(72,    "x"),
        False, 'Int (same Str part)';
    is-deeply RatStr    .new(42.0,  "x") eqv RatStr    .new(72.0,  "x"),
        False, 'Rat (same Str part)';
    is-deeply NumStr    .new(42e0,  "x") eqv NumStr    .new(72e0,  "x"),
        False, 'Num (same Str part)';
    is-deeply ComplexStr.new(42+0i, "x") eqv ComplexStr.new(72+0i, "x"),
        False, 'Complex (same Str part)';

    is-deeply IntStr    .new(42,    "x") eqv IntStr    .new(42,    "a"),
        False, 'Int (same Numeric part)';
    is-deeply RatStr    .new(42.0,  "x") eqv RatStr    .new(42.0,  "a"),
        False, 'Rat (same Numeric part)';
    is-deeply NumStr    .new(42e0,  "x") eqv NumStr    .new(42e0,  "a"),
        False, 'Num (same Numeric part)';
    is-deeply ComplexStr.new(42+0i, "x") eqv ComplexStr.new(42+0i, "a"),
        False, 'Complex (same Numeric part)';
}

subtest '.ACCEPTS' => {
    my @true = gather {
        my class IntFoo { method Numeric { 3    }; method Str { '3'    } }
        my class RatFoo { method Numeric { 3.0  }; method Str { '3.0'  } }
        my class NumFoo { method Numeric { 3e0  }; method Str { '3e0'  } }
        my class ComFoo { method Numeric { 3+5i }; method Str { '3+5i' } }

        take <0>       => $_ for      '0', 0, 0.0, 0e0, 0+0i;
        take <000>     => $_ for    '000', 0, 0.0, 0e0, 0+0i;
        take <3>       => $_ for      '3', 3, 3.0, 3e0, 3+0i, IntFoo.new;

        take <0.0>     => $_ for    '0.0', 0, 0.0, 0e0, 0+0i;
        take <000.0>   => $_ for  '000.0', 0, 0.0, 0e0, 0+0i;
        take <3.0>     => $_ for    '3.0', 3, 3.0, 3e0, 3+0i, RatFoo.new;

        take <0e0>     => $_ for    '0e0', 0, 0.0, 0e0, 0+0i;
        take <000e0>   => $_ for  '000e0', 0, 0.0, 0e0, 0+0i;
        take <3e0>     => $_ for    '3e0', 3, 3.0, 3e0, 3+0i, NumFoo.new;

        take < 0+0i>   => $_ for   '0+0i', 0, 0.0, 0e0, 0+0i;
        take < 0.0+0i> => $_ for '0.0+0i', 0, 0.0, 0e0, 0+0i;
        take < 3+5i>   => $_ for   '3+5i', 3+5i, 3.0+5i, 3e0+5i, ComFoo.new;

        for <0>, <000>, <0.0>, <0e0>, < 0+0i> -> \al {
            take $_ => al
            for <0>, <000>, <0.0>, <000.0>, <0e0>, <000e0>, < 0+0i>, < 0.0+0i>,
              IntStr.new(0,   'meow'), RatStr    .new(0.0,  'meow'),
              NumStr.new(0e0, 'meow'), ComplexStr.new(0+0i, 'meow');
        }

        for <3>, <003>, <3.0>, <3e0>, < 3+0i> -> \al {
            take $_ => al
            for <3>, <003>, <3.0>, <003.0>, <3e0>, <003e0>, < 3+0i>, < 3.0+0i>,
              IntStr.new(3,   'meow'), RatStr    .new(3.0,  'meow'),
              NumStr.new(3e0, 'meow'), ComplexStr.new(3+0i, 'meow');
        }

        take < 3+5i> => $_ for < 3.0+5i>, < 3e0+5i>;
    }

    my @false = gather {
        my class IntFoo { method Numeric { 42    }; method Str { '3'    } }
        my class RatFoo { method Numeric { 42.0  }; method Str { '3.0'  } }
        my class NumFoo { method Numeric { 42e0  }; method Str { '3e0'  } }
        my class ComFoo { method Numeric { 42+5i }; method Str { '3+5i' } }

        take <0>       => $_ for '', '00',  '0.0',  '0e0',  '0+0i', 'meows';
        take <3>       => $_ for     '03',  '3.0',  '3e0',  '3+0i', IntFoo.new;

        take <0.0>     => $_ for '',  '0', '00.0',  '0e0',  '0+0i', 'meows';
        take <3.0>     => $_ for      '3', '03.0',  '3e0',  '3+0i', RatFoo.new;

        take <0e0>     => $_ for '',  '0',  '0.0', '00e0',  '0+0i', 'meows';
        take <3e0>     => $_ for      '3',  '3.0', '03e0',  '3+0i', RatFoo.new;

        take < 0+0i>   => $_ for '',  '0',  '0.0',  '0e0', '00+0i', 'meows';
        take < 3+5i>   => $_ for      '3',  '3.0',  '3e0', '03+5i', ComFoo.new;
    }

    plan @true + @false;

    for @true -> (:key($allo), :value($thing)) {
        is-deeply $allo.ACCEPTS($thing), True,
            "{$allo.raku}.ACCEPTS({$thing.raku})"
    }

    for @false -> (:key($allo), :value($thing)) {
        is-deeply $allo.ACCEPTS($thing), False,
            "{$allo.raku}.ACCEPTS({$thing.raku})"
    }
}

# [Issue 1204](https://github.com/rakudo/rakudo/issues/1204)
{
    cmp-ok val(<1 2 3>     ), '!~~', Slip, 'val List candidate returns List by default (1)';
    isa-ok val(<1 2 3>     ), List, 'val List candidate returns List by default (2)';
    isa-ok val(<1 2 3>.Slip), Slip, 'val List candidate preserves slip-ness if passed Slip';
}

# https://github.com/rakudo/rakudo/issues/1387
subtest '.succ on allomorphs' => {
    # math on allomorphs collapses them to standard numerics
    plan 5*my @tests = <2> => 3, <2e0> => 3e0, <2.1> => 3.1, <2+1i > => <3+1i>;

    for @tests -> (:key($from), :value($to)) {
        is-deeply $from.succ, $to, '.succ';

        my $post = $from;
        is-deeply $post++, $from, 'postincrement, return value';
        is-deeply $post,   $to,   'postincrement, result';

        my $pre = $from;
        is-deeply ++$pre, $to, 'preincrement, return value';
        is-deeply   $pre, $to, 'preincrement, result';
    }
}

# https://github.com/rakudo/rakudo/issues/1387
subtest '.pred on allomorphs' => {
    # math on allomorphs collapses them to standard numerics
    plan 5*my @tests = <2> => 1, <2e0> => 1e0, <2.1> => 1.1, <2+1i > => <1+1i>;

    for @tests -> (:key($from), :value($to)) {
        is-deeply $from.pred, $to, '.pred';

        my $post = $from;
        is-deeply $post--, $from, 'postdecrement, return value';
        is-deeply $post,   $to,   'postdecrement, result';

        my $pre = $from;
        is-deeply --$pre, $to, 'predecrement, return value';
        is-deeply   $pre, $to, 'predecrement, result';
    }
}

subtest '.Numeric on :U allomorphs and Numeric type objects' => {
    my class CustomNumeric does Numeric { method new { 42 } }
    my @types := Int, Num, Rat, FatRat, Complex;
    my @allos := IntStr, NumStr, RatStr, ComplexStr;
    plan 3*@types + @allos + 6;

    for flat CustomNumeric, @types, @allos -> \T {
        warns-like { T.Numeric }, *.contains('uninitialized'&'numeric'), T.raku;
    }

    quietly {
        is-deeply CustomNumeric.Numeric, 42, 'Numeric:U.Numeric calls self.new';
        for @types {
            isa-ok .Numeric, $_,      "{.raku}.Numeric gives a {.raku} value";
            cmp-ok .Numeric, '==', 0, "{.raku}.Numeric gives a zero";
        }

        is-deeply IntStr    .Numeric, 0,      'IntStr    .Numeric gives a 0';
        is-deeply RatStr    .Numeric, 0.0,    'RatStr    .Numeric gives a 0.0';
        is-deeply NumStr    .Numeric, 0e0,    'NumStr    .Numeric gives a 0e0';
        is-deeply ComplexStr.Numeric, <0+0i>, 'ComplexStr.Numeric gives a <0+0i>';
    }
}

subtest '.Real on :U allomorphs and Numeric type objects' => {
    my @types := Int, Num, Rat, FatRat, Complex, my class CustomReal does Real {
        method new { 42 }
    };
    my @allos := IntStr, NumStr, RatStr, ComplexStr;
    plan @types + @allos + 9;

    for flat @types, @allos -> \T {
        warns-like { T.Real }, *.contains('uninitialized'&'numeric'), T.raku;
    }

    quietly {
        is-deeply CustomReal.Real, 42, 'Real:U.Real calls self.new';
        is-deeply Int       .Real, 0,   'Int       .Real gives a 0';
        is-deeply Rat       .Real, 0.0, 'Rat       .Real gives a 0.0';
        is-deeply Num       .Real, 0e0, 'Num       .Real gives a 0e0';
        is-deeply IntStr    .Real, 0,   'IntStr    .Real gives a 0';
        is-deeply RatStr    .Real, 0.0, 'RatStr    .Real gives a 0.0';
        is-deeply NumStr    .Real, 0e0, 'NumStr    .Real gives a 0e0';
        # Complex is not a Real, so its .Real here returns a Num
        is-deeply Complex   .Real, 0e0, 'Complex   .Real gives a 0e0';
        is-deeply ComplexStr.Real, 0e0, 'ComplexStr.Real gives a 0e0';
    }
}

subtest '.Real on :D allomorphs' => {
    plan 5;
    is-deeply <42>   .Real, 42, 'IntStr';
    is-deeply <42e0> .Real, 42e0, 'NumStr';
    is-deeply <42.0> .Real, 42.0, 'RatStr';
    is-deeply <42+0i>.Real, 42e0, 'ComplexStr'; # Complex isn't real; so here it returns Num
    fails-like { <42+42i>.Real }, X::Numeric::Real, 'ComplexStr (with large imaginary part)';
}

# https://irclog.perlgeek.de/perl6-dev/2018-02-23#i_15851777
subtest '.Bool on allomorphs' => {
    my @true := <1>, <-1>, <1e0>, <-1e0>, <1.0>, <-1.0>, <1/0>, <-1/0>,
        <1+0i >, <1+1i >, <1-1i >, <-1+0i >, <-1+1i >, <-1-1i >, <0+1i >, <0-1i >,
        IntStr.new(1, ''), NumStr.new(1e0, ''), RatStr.new(1.0, ''), ComplexStr.new(<1+1i>, '');
    my @false := <0>, <0e0>, <-0e0>, <0.0>, <0/0>,
        <0+0i>, <0e0+0e0i>, <-0e0+0e0i>, <-0e0-0e0i>, <0e0-0e0i>;
    plan @true + @false;
    is-deeply .so, True,  .raku for @true;
    is-deeply .so, False, .raku for @false;
}

# GH#2010
group-of 4 => '.comb on allomorphs uses Str variant' => {
    is-eqv <0000>     .comb, <0 0 0 0        >».Str.Seq, 'IntStr';
    is-eqv <0000e0>   .comb, <0 0 0 0 e 0    >».Str.Seq, 'NumStr';
    is-eqv <0001.0>   .comb, <0 0 0 1 . 0    >».Str.Seq, 'RatStr';
    is-eqv <01.0+42i >.comb, <0 1 . 0 + 4 2 i>».Str.Seq, 'ComplexStr';
}

# https://github.com/rakudo/rakudo/issues/3308
isa-ok Str($*USER), Str, 'No leaking of guts types when coercing allomorph to Str';

# vim: expandtab shiftwidth=4
