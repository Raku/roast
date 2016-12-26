use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 18;

sub f($x) returns Int { return $x };

ok &f.returns === Int, 'sub f returns Int can be queried for its return value';
ok &f.of === Int, 'sub f returns Int can be queried for its return value (.of)';

# RT #121426
ok &f ~~ Callable[Int], 'sub f ~~ Callable[Int]';

lives-ok { f(3) },      'type check allows good return';
dies-ok  { f('m') },    'type check forbids bad return';

sub g($x) returns  Int { $x };

lives-ok { g(3)   },    'type check allows good implicit return';
dies-ok  { g('m') },    'type check forbids bad implicit return';

# RT #77158
{
    ok :(Int).perl eq ':(Int $)',
        "RT #77158 Doing .perl on an :(Int)";
    ok :(Array of Int).perl eq ':(Array[Int] $)',
        "RT #77158 Doing .perl on an :(Array of Int)";
}

# RT #123789
{
    sub rt123789 (int $x) { say $x };
    throws-like { rt123789(Int) }, Exception,
        message => /'Cannot unbox a type object'/,
        'no segfault when calling a routine having a native parameter with a type object argument';
}

# RT #126124
{
    throws-like { sub f(Mu:D $a) {}; f(Int) }, Exception,
        message => /'instance of type Mu' .+ 'type object'/,
        'type shown in the exception message is the right one';
    throws-like { sub f(Mu:U $a) {}; f(123) }, Exception,
        message => /'object of type Mu' .+ 'object instance'/,
        'type shown in the exception message is the right one';
}

# RT #129279
#?rakudo.jvm todo "Constraint type check failed for parameter 'null'"
{
    lives-ok
        { sub f(-١) { 2 }; f(-1) },
        'Unicode digit negative type constraints work';
}

# coverage; 2016-09-25
subtest 'Code.of() returns return type' => {
    plan 4;
    my subset ofTest where True;
    cmp-ok -> () --> Int    {}.of, '===', Int,    '--> type';
    #?rakudo.jvm todo "got: ''"
    cmp-ok -> () --> Str:D  {}.of, '===', Str:D,  '--> smiley';
    cmp-ok -> () --> ofTest {}.of, '===', ofTest, '--> subset';
    is {;}.of.^name, 'Mu', 'no explicit return constraint';
}

# RT #129915
subtest 'numeric literals as type constraints' => {
    subtest 'integers' => {
        eval-lives-ok ｢sub f( 42){}( 42)｣, 'bare';
        eval-lives-ok ｢sub f(+42){}(+42)｣, 'plus';
        eval-lives-ok ｢sub f(-42){}(-42)｣, 'minus';
        eval-lives-ok ｢sub f(−42){}(−42)｣, 'U+2212 minus';
    }
    subtest 'unum' => {
        eval-lives-ok ｢sub f( ½){}( .5)｣, 'bare';
        eval-lives-ok ｢sub f(+½){}( .5)｣, 'plus';
        eval-lives-ok ｢sub f(-½){}(-.5)｣, 'minus';
        eval-lives-ok ｢sub f(−½){}(-.5)｣, 'U+2212 minus';
    }
    subtest 'rats' => {
        eval-lives-ok ｢sub f( <1/2>){}( .5) ｣, 'bare </> literal';
        eval-lives-ok ｢sub f(<-1/2>){}(-.5) ｣, 'minus </> literal';
        eval-lives-ok ｢sub f(<−1/2>){}(-.5) ｣, 'U+2212 minus </> literal';
        eval-lives-ok ｢sub f(   1.5){}( 1.5)｣, 'bare \d.\d literal';
        eval-lives-ok ｢sub f(  -1.5){}(-1.5)｣, 'minus \d.\d literal';
        eval-lives-ok ｢sub f(  −1.5){}(-1.5)｣, 'U+2212 minus \d.\d literal';
    }
    subtest 'nums' => {
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
    subtest 'complex' => {
        eval-lives-ok ｢sub f( <1+2i>){}( 1+2i)｣, 'bare';
        eval-lives-ok ｢sub f(<-1+2i>){}(-1+2i)｣, 'minus (real)';
        eval-lives-ok ｢sub f(<−1+2i>){}(-1+2i)｣, 'U+2212 minus (real)';
        eval-lives-ok ｢sub f( <1-2i>){}( 1-2i)｣, 'minus (imaginary)';
        eval-lives-ok ｢sub f( <1−2i>){}( 1−2i)｣, 'U+2212 minus (imaginary)';
        eval-lives-ok ｢sub f(<-1-2i>){}(-1-2i)｣, 'minus (real and imaginary)';
        eval-lives-ok ｢sub f(<−1−2i>){}(-1-2i)｣, 'U+2212 minus (real and imagin.)';
    }
    subtest 'infinity' => {
        eval-lives-ok ｢sub f( Inf){}( Inf)｣, 'bare Inf';
        eval-lives-ok ｢sub f(+Inf){}( Inf)｣, 'plus Inf';
        eval-lives-ok ｢sub f(-Inf){}(-Inf)｣, 'minus Inf';
        eval-lives-ok ｢sub f(−Inf){}(-Inf)｣, 'U+2212 minus Inf';
        eval-lives-ok ｢sub f(   ∞){}( Inf)｣, 'bare ∞';
        eval-lives-ok ｢sub f(  +∞){}( Inf)｣, 'plus ∞';
        eval-lives-ok ｢sub f(  -∞){}(-Inf)｣, 'minus ∞';
        eval-lives-ok ｢sub f(  −∞){}(-Inf)｣, 'U+2212 minus ∞';
    }
    subtest 'NaN' => {
        eval-lives-ok ｢sub f(NaN){}(NaN)｣, 'bare';
    }
    subtest 'π' => {
        eval-lives-ok ｢sub f(  π){}( π)｣, 'bare, π';
        eval-lives-ok ｢sub f( pi){}( π)｣, 'bare, pi';
    }
    subtest 'τ' => {
        eval-lives-ok ｢sub f(   τ){}( τ)｣, 'bare, τ';
        eval-lives-ok ｢sub f( tau){}( τ)｣, 'bare, tau';
    }
    subtest '𝑒' => {
        #?rakudo.jvm 2 skip '𝑒 does not work on JVM'
        eval-lives-ok ｢sub f( 𝑒){}( 𝑒)｣, 'bare, 𝑒';
        eval-lives-ok ｢sub f( e){}( 𝑒)｣, 'bare, e';
    }
}

# RT#130182
{
    is_run ｢-> True  { }($)｣, {:err(/'smartmatch'/), :out('')},
        '`True` signature literal warns';
    is_run ｢-> False { }($)｣, {:err(/'smartmatch'/), :out('')},
        '`False` signature literal warns';
    is_run ｢-> Bool  { print "ok" }(True)｣, {:err(''), :out('ok')},
        '`Bool` type constraint does not warn';
}

# vim: ft=perl6
