use v6;
use Test;
plan 53;

# type based dispatching
#
#L<S06/"Longname parameters">
#L<S12/"Multisubs and Multimethods">

multi foo (5)          { "Constant"  }
multi foo (Int $bar)   { "Int "  ~ $bar  }
multi foo (Str $bar)   { "Str "  ~ $bar  }
multi foo (Rat $bar)   { "Rat "  ~ $bar  }
multi foo (Bool $bar)  { "Bool " ~ $bar  }
multi foo (Regex $bar) { "Regex " ~ gist(WHAT( $bar )) } # since Rule's don't stringify
multi foo (Sub $bar)   { "Sub " ~ $bar() }
multi foo (@bar) { "Positional " ~ join(', ', @bar) }
multi foo (%bar)  { "Associative " ~ join(', ', %bar.keys.sort) }
multi foo (IO $fh)     { "IO" }   #OK not used
#?niecza emit # foo (Inf) NYI
multi foo (Inf)        { "Inf" }
#?niecza emit # foo (5) NYI
multi foo (NaN)        { "NaN" }

is foo(5), 'Constant', 'dispatched to the constant sub';

is(foo(2), 'Int 2', 'dispatched to the Int sub');
is(foo('test'), 'Str test', 'dispatched to the Str sub');

my $num = '4';
is(foo(1.4), 'Rat 1.4', 'dispatched to the Num sub');
is(foo(1 == 1), 'Bool ' ~ True, 'dispatched to the Bool sub');
is(foo(/a/),'Regex (Regex)','dispatched to the Rule sub');
is(foo(sub { 'baz' }), 'Sub baz', 'dispatched to the Sub sub');

my @array = ('foo', 'bar', 'baz');
is(foo(@array), 'Positional foo, bar, baz', 'dispatched to the Positional sub');

my %hash = ('foo' => 1, 'bar' => 2, 'baz' => 3);
is(foo(%hash), 'Associative bar, baz, foo', 'dispatched to the Associative sub');

#?niecza skip '$*ERR is apparently not IO'
is(foo($*ERR), 'IO', 'dispatched to the IO sub');

#?niecza 2 skip 'We turned these off because of a niecza bug'
is foo(Inf), 'Inf', 'dispatched to the Inf sub';
is foo(NaN), 'NaN', 'dispatched to the NaN sub';

# You're allowed to omit the "sub" when declaring a multi sub.
# L<S06/"Routine modifiers">

multi declared_wo_sub (Int $x) { 1 }   #OK not used
multi declared_wo_sub (Str $x) { 2 }   #OK not used
is declared_wo_sub(42),   1, "omitting 'sub' when declaring 'multi sub's works (1)";
is declared_wo_sub("42"), 2, "omitting 'sub' when declaring 'multi sub's works (2)";

# Test for slurpy MMDs
# L<S06/"Routine modifiers">
proto mmd(*@) {*}
multi mmd () { 1 }
multi mmd (*$x, *@xs) { 2 }   #OK not used

is(mmd(), 1, 'Slurpy MMD to nullary');
is(mmd(1,2,3), 2, 'Slurpy MMD to listop via args');
is(mmd(1..3), 2, 'Slurpy MMD to listop via list');

#?niecza skip 'two or more Anys error'
{
    my %h = (:a<b>, :c<d>);
    multi sub sigil-t (&code) { 'Callable'      }   #OK not used
    multi sub sigil-t ($any)  { 'Any'           }   #OK not used
    multi sub sigil-t (@ary)  { 'Positional'    }   #OK not used
    multi sub sigil-t (%h)    { 'Associative'   }   #OK not used
    is sigil-t(1),          'Any',      'Sigil-based dispatch (Any)';
    is sigil-t({ $_ }),     'Callable', 'Sigil-based dispatch (Callable)';
    is sigil-t(<a b c>),    'Positional','Sigil-based dispatch (Arrays)';
    is sigil-t(%h),         'Associative','Sigil-based dispatch (Associative)';

}

#?niecza skip 'GLOBAL::T does not name any package'
{

    class Scissor { }
    class Paper   { }
    class Stone   { }

    multi wins(Scissor $x, Paper   $y) { 1 }   #OK not used
    multi wins(::T     $x, T       $y) { 0 }   #OK not used
    multi wins($x, $y)                { -1 }   #OK not used

    is wins(Scissor.new, Paper.new),   1,  'Basic sanity';
    is wins(Paper.new,   Paper.new),   0,  'multi dispatch with ::T generics';
    is wins(Paper.new,   Scissor.new), -1, 'fallback if there is a ::T variant';

    # RT #114394
    sub p($a, $b) { wins($a, $b) };
    is p(Paper, Paper), 0, 'Type captures and containers mix (RT 114394)';

    multi wins2(Scissor $x, Paper   $y) { 1 }   #OK not used
    multi wins2($x, $y where { $x.WHAT.gist eq $y.WHAT.gist }) { 0 }
    multi wins2($x, $y)                { -1 }   #OK not used
    is wins2(Scissor.new, Paper.new),   1,  'Basic sanity 2';
    is wins2(Paper.new,   Paper.new),   0,  'multi dispatch with faked generics';
    is wins2(Paper.new,   Scissor.new), -1, 'fallback if there is a faked generic';

    # now try again with anonymous parameters (see RT #69798)
    multi wins_anon(Scissor $, Paper   $) { 1  }
    multi wins_anon(Paper   $, Stone   $) { 1  }
    multi wins_anon(Stone   $, Scissor $) { 1  }
    multi wins_anon(::T     $, T       $) { 0  }
    multi wins_anon(        $,         $) { -1 }

    is wins_anon(Scissor, Paper),  1, 'MMD with anonymous parameters (1)';
    is wins_anon(Paper,   Paper),  0, 'MMD with anonymous parameters (2)';
    is wins_anon(Stone,   Paper), -1, 'MMD with anonymous parameters (3)';

}

{
    multi m($x,$y where { $x==$y }) { 0 }
    multi m($x,$y) { 1 }   #OK not used

    is m(2, 3), 1, 'subset types involving mulitple parameters (fallback)';
    is m(1, 1), 0, 'subset types involving mulitple parameters (success)';
}

{
    multi f2 ($)        { 1 }
    multi f2 ($, $)     { 2 }
    multi f2 ($, $, $)  { 3 }
    multi f2 ($, $, @)  { '3+' }
    is f2(3),               1, 'arity-based dispatch to ($)';
    is f2('foo', f2(3)),    2, 'arity-based dispatch to ($, $)';
    is f2('foo', 4, 8),     3, 'arity-based dispatch to ($, $, $)';
    #?niecza skip 'Ambiguous dispatch for &f2'
    is f2('foo', 4, <a b>), '3+', 'arity-based dispatch to ($, $, @)';
}

{
    multi f3 ($ where 0 ) { 1 }
    multi f3 ($x)         { $x + 1 }
    is f3(0), 1, 'can dispatch to "$ where 0"';
    is f3(3), 4, '... and the ordinary dispatch still works';
}

# multi dispatch on typed containers
#?niecza skip 'Ambiguous dispatch for &f4'
{
    multi f4 (Int @a )  { 'Array of Int' }   #OK not used
    multi f4 (Str @a )  { 'Array of Str' }   #OK not used
    multi f4 (Array @a) { 'Array of Array' }   #OK not used
    multi f4 (Int %a)   { 'Hash of Int' }   #OK not used
    multi f4 (Str %a)   { 'Hash of Str' }   #OK not used
    multi f4 (Array %a) { 'Hash of Array' }   #OK not used

    my Int @a = 3, 4;
    my Str @b = <foo bar>;
    my Array @c = [1, 2], [3, 4];

    my Int %a = a => 1, b => 2;
    my Str %b = :a<b>, :b<c>;
    my Array %c = a => [1, 2], b => [3, 4];

    is f4(%a), 'Hash of Int',    'can dispatch on typed Hash (Int)';
    is f4(%b), 'Hash of Str',    'can dispatch on typed Hash (Str)';
    is f4(%c), 'Hash of Array',  'can dispatch on typed Hash (Array)';

    is f4(@a), 'Array of Int',   'can dispatch on typed Array (Int)';
    is f4(@b), 'Array of Str',   'can dispatch on typed Array (Str)';
    is f4(@c), 'Array of Array', 'can dispatch on typed Array (Array)';
}

# make sure that multi sub dispatch also works if the sub is defined
# in a class (was a Rakudo regression, RT #65674)

#?rakudo skip 'our sub in class'
#?niecza skip 'Two definitions found for symbol ::GLOBAL::A::&a'
{
    class A {
        our multi sub a(Int $x) { 'Int ' ~ $x }
        our multi sub a(Str $x) { 'Str ' ~ $x }
    }

    is A::a(3),     'Int 3',  'multis in classes (1)';
    is A::a('f'),   'Str f',  'multis in classes (2)';
    dies_ok { A::a([4, 5]) }, 'multis in classes (3)';
}

{
    multi x(@a, @b where { @a.elems == @b.elems }) { 1 }
    multi x(@a, @b)                                { 2 }   #OK not used
    is x([1,2],[3,4]), 1, 'where-clause that uses multiple params (1)';
    is x([1],[2,3,4]), 2, 'where-clause that uses multiple params (1)'; 
}

#?niecza skip 'GLOBAL::T does not name any package'
{
    multi y(::T $x, T $y) { 1 }   #OK not used
    multi y($x, $y)       { 2 }   #OK not used
    is y(1, 2), 1, 'generics in multis (+)';
    is y(1, 2.5), 2, 'generics in multis (-)';
}

#?niecza skip 'no native types yet'
#?rakudo.jvm skip "Cannot call 'rt107638'; none of these signatures match:"
{
    # This once wrongly reported a multi-dispatch circularity.
    multi rt107638(int $a) { 'ok' }      #OK not used
    multi rt107638(Str $a where 1) { }   #OK not used
    ok rt107638(1), 'native types and where clauses do not cause spurious circularities';
}

done;

# vim: ft=perl6
