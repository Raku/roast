use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 19;

sub f($x) returns Int { return $x };

ok &f.returns === Int, 'sub f returns Int can be queried for its return value';
ok &f.of === Int, 'sub f returns Int can be queried for its return value (.of)';

# https://github.com/Raku/old-issue-tracker/issues/3355
ok &f ~~ Callable[Int], 'sub f ~~ Callable[Int]';

lives-ok { f(3) },      'type check allows good return';
dies-ok  { f('m') },    'type check forbids bad return';

sub g($x) returns  Int { $x };

lives-ok { g(3)   },    'type check allows good implicit return';
dies-ok  { g('m') },    'type check forbids bad implicit return';

# https://github.com/Raku/old-issue-tracker/issues/2056
is-deeply .raku.EVAL, $_, ".raku on an {.raku} roundtrips"
    for :(Int), :(Array of Int);

# https://github.com/Raku/old-issue-tracker/issues/3678
{
    sub rt123789 (int $x) { say $x };
    throws-like { rt123789(Int) }, Exception,
        'no segfault when calling a routine having a native parameter with a type object argument';
}

# https://github.com/Raku/old-issue-tracker/issues/4569
{
    throws-like { sub f(Mu:D $a) {}; f(Int) }, X::Parameter::InvalidConcreteness, :expected<Mu>, :got<Int>,
        'expected and got types in the exception are the correct ones';
    throws-like { sub f(Mu:U $a) {}; f(123) }, X::Parameter::InvalidConcreteness, :expected<Mu>, :got<Int>,
        'expected and got types in the exception are the correct ones';
    throws-like { UInt.abs }, X::Parameter::InvalidConcreteness,
        :expected<Int>, :got<UInt>,
        'expected and got types in the exception are the correct ones';
}

# https://github.com/Raku/old-issue-tracker/issues/5676
#?rakudo.jvm skip "'١' is not a valid number"
{
    lives-ok
        { sub f(-١) { 2 }; f(-1) },
        'Unicode digit negative type constraints work';
}

# coverage; 2016-09-25
subtest 'Code.of() returns return type' => {
    plan 4;
    my subset ofTest where True;
    cmp-ok -> () --> Int    {}.of, '=:=', Int,    '--> type';
    #?rakudo.jvm todo "got: ''"
    cmp-ok -> () --> Str:D  {}.of, '=:=', Str:D,  '--> smiley';
    cmp-ok -> () --> ofTest {}.of, '=:=', ofTest, '--> subset';
    cmp-ok                 {;}.of, '=:=', Mu, 'no explicit return constraint';
}

# https://github.com/Raku/old-issue-tracker/issues/5759
group-of 10 => 'numeric literals as type constraints' => {
    group-of 4 => 'integers' => {
        eval-lives-ok ｢sub f( 42){}( 42)｣, 'bare';
        eval-lives-ok ｢sub f(+42){}(+42)｣, 'plus';
        eval-lives-ok ｢sub f(-42){}(-42)｣, 'minus';
        eval-lives-ok ｢sub f(−42){}(−42)｣, 'U+2212 minus';
    }
    group-of 4 => 'unum' => {
        #?rakudo.jvm 4 todo 'Missing block / Malformed parameter on JVM, RT #129915'
        eval-lives-ok ｢sub f( ½){}( .5)｣, 'bare';
        eval-lives-ok ｢sub f(+½){}( .5)｣, 'plus';
        eval-lives-ok ｢sub f(-½){}(-.5)｣, 'minus';
        eval-lives-ok ｢sub f(−½){}(-.5)｣, 'U+2212 minus';
    }
    group-of 6 => 'rats' => {
        eval-lives-ok ｢sub f( <1/2>){}( .5) ｣, 'bare </> literal';
        eval-lives-ok ｢sub f(<-1/2>){}(-.5) ｣, 'minus </> literal';
        eval-lives-ok ｢sub f(<−1/2>){}(-.5) ｣, 'U+2212 minus </> literal';
        eval-lives-ok ｢sub f(   1.5){}( 1.5)｣, 'bare \d.\d literal';
        eval-lives-ok ｢sub f(  -1.5){}(-1.5)｣, 'minus \d.\d literal';
        eval-lives-ok ｢sub f(  −1.5){}(-1.5)｣, 'U+2212 minus \d.\d literal';
    }
    group-of 10 => 'nums' => {
        eval-lives-ok ｢sub f( 1e2 ){}( 1e2 )｣, 'bare';
        eval-lives-ok ｢sub f(-1e2 ){}(-1e2 )｣, 'minus (base)';

        eval-lives-ok ｢sub f(−1e2 ){}(-1e2 )｣, 'U+2212 minus (base)';
        eval-lives-ok ｢sub f( 1e+2){}( 1e2 )｣, 'bare (plus exp)';
        eval-lives-ok ｢sub f(-1e+2){}(-1e2 )｣, 'minus (base) (plus exp)';
        eval-lives-ok ｢sub f(−1e+2){}(-1e2 )｣, 'U+2212 minus (base) (plus exp)';

        eval-lives-ok ｢sub f( 1e-2){}( 1e-2)｣, 'minus (exp)';
        eval-lives-ok ｢sub f( 1e−2){}( 1e−2)｣, 'U+2212 minus (exp)';
        eval-lives-ok ｢sub f(-1e-2){}(-1e-2)｣, 'minus (base and exp)';
        eval-lives-ok ｢sub f(−1e−2){}(-1e-2)｣, 'U+2212 minus (base and exp)';
    }
    group-of 7 => 'complex' => {
        eval-lives-ok ｢sub f( <1+2i>){}( 1+2i)｣, 'bare';
        eval-lives-ok ｢sub f(<-1+2i>){}(-1+2i)｣, 'minus (real)';
        eval-lives-ok ｢sub f(<−1+2i>){}(-1+2i)｣, 'U+2212 minus (real)';

        eval-lives-ok ｢sub f( <1-2i>){}( 1-2i)｣, 'minus (imaginary)';
        eval-lives-ok ｢sub f( <1−2i>){}( 1−2i)｣, 'U+2212 minus (imaginary)';
        eval-lives-ok ｢sub f(<-1-2i>){}(-1-2i)｣, 'minus (real and imaginary)';
        eval-lives-ok ｢sub f(<−1−2i>){}(-1-2i)｣, 'U+2212 minus (real and imagin.)';
    }
    group-of 8 => 'infinity' => {
        eval-lives-ok ｢sub f( Inf){}( Inf)｣, 'bare Inf';
        eval-lives-ok ｢sub f(+Inf){}( Inf)｣, 'plus Inf';
        eval-lives-ok ｢sub f(-Inf){}(-Inf)｣, 'minus Inf';
        eval-lives-ok ｢sub f(−Inf){}(-Inf)｣, 'U+2212 minus Inf';

        eval-lives-ok ｢sub f(   ∞){}( Inf)｣, 'bare ∞';
        eval-lives-ok ｢sub f(  +∞){}( Inf)｣, 'plus ∞';
        eval-lives-ok ｢sub f(  -∞){}(-Inf)｣, 'minus ∞';
        eval-lives-ok ｢sub f(  −∞){}(-Inf)｣, 'U+2212 minus ∞';
    }
    group-of 1 => 'NaN' => {
        eval-lives-ok ｢sub f(NaN){}(NaN)｣, 'bare';
    }
    group-of 2 => 'π' => {
        eval-lives-ok ｢sub f(  π){}( π)｣, 'bare, π';
        eval-lives-ok ｢sub f( pi){}( π)｣, 'bare, pi';
    }
    group-of 2 => 'τ' => {
        eval-lives-ok ｢sub f(   τ){}( τ)｣, 'bare, τ';
        eval-lives-ok ｢sub f( tau){}( τ)｣, 'bare, tau';
    }
    group-of 2 => '𝑒' => {
        #?rakudo.jvm 2 todo '𝑒 does not work on JVM'
        eval-lives-ok ｢sub f( 𝑒){}( 𝑒)｣, 'bare, 𝑒';
        eval-lives-ok ｢sub f( e){}( 𝑒)｣, 'bare, e';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5824

{
    is_run ｢-> True  { }($)｣, {:err(/'smartmatch'/), :out('')},
        '`True` signature literal warns';
    is_run ｢-> False { }($)｣, {:err(/'smartmatch'/), :out('')},
        '`False` signature literal warns';
    is_run ｢-> Bool  { print "ok" }(True)｣, {:err(''), :out('ok')},
        '`Bool` type constraint does not warn';
}

# vim: expandtab shiftwidth=4
