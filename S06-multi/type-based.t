use v6;
use Test;
plan 26;

# type based dispatching
#
#L<S06/"Longname parameters">
#L<S12/"Multisubs and Multimethods">

multi foo (Int $bar)   { "Int "  ~ $bar  }
multi foo (Str $bar)   { "Str "  ~ $bar  }
multi foo (Num $bar)   { "Num "  ~ $bar  }
multi foo (Bool $bar)  { "Bool " ~ $bar  }
multi foo (Regex $bar) { "Regex " ~ WHAT( $bar ) } # since Rule's don't stringify
multi foo (Sub $bar)   { "Sub " ~ $bar() }
multi foo (Array @bar) { "Array " ~ join(', ', @bar) }
multi foo (Hash %bar)  { "Hash " ~ join(', ', %bar.keys.sort) }
multi foo (IO $fh)     { "IO" }

is(foo('test'), 'Str test', 'dispatched to the Str sub');
is(foo(2), 'Int 2', 'dispatched to the Int sub');

my $num = '4';
is(foo(1.4), 'Num 1.4', 'dispatched to the Num sub');
is(foo(1 == 1), 'Bool 1', 'dispatched to the Bool sub');
#?rakudo skip 'type Regex'
is(foo(/a/),'Regex Regex','dispatched to the Rule sub');
is(foo(sub { 'baz' }), 'Sub baz', 'dispatched to the Sub sub');

my @array = ('foo', 'bar', 'baz');
is(foo(@array), 'Array foo, bar, baz', 'dispatched to the Array sub');

my %hash = ('foo' => 1, 'bar' => 2, 'baz' => 3);
is(foo(%hash), 'Hash bar, baz, foo', 'dispatched to the Hash sub');

is(foo($*ERR), 'IO', 'dispatched to the IO sub');

# You're allowed to omit the "sub" when declaring a multi sub.
# L<S06/"Routine modifiers">

multi declared_wo_sub (Int $x) { 1 }
multi declared_wo_sub (Str $x) { 2 }
is declared_wo_sub(42),   1, "omitting 'sub' when declaring 'multi sub's works (1)";
is declared_wo_sub("42"), 2, "omitting 'sub' when declaring 'multi sub's works (2)";

# Test for slurpy MMDs
proto mmd {}  # L<S06/"Routine modifiers">
multi mmd () { 1 }
multi mmd (*$x, *@xs) { 2 }

is(mmd(), 1, 'Slurpy MMD to nullary');
is(mmd(1,2,3), 2, 'Slurpy MMD to listop via args');
is(mmd(1..3), 2, 'Slurpy MMD to listop via list');

#?rakudo skip 'Dispatch on sigil-implied type constraints'
{
    my %h = (:a<b>, :c<d>);
    multi sub sigil-t (&code) { 'Callable'      }
    multi sub sigil-t ($any)  { 'Any'           }
    multi sub sigil-t (@ary)  { 'Positional'    }
    multi sub sigil-t (%h)    { 'Associative'   }
    is sigil-t(1),          'Any',      'Sigil-based dispatch (Any)';
    is sigil-t({ $_ }),     'Callable', 'Sigil-based dispatch (Callable)';
    is sigil-t(<a b c>),    'Positional','Sigil-based dispatch (Arrays)';
    is sigil-t(%h),         'Associative','Sigil-based dispatch (Associative)';

}

{

    class Scissor { };
    class Paper   { };

    multi wins(Scissor $x, Paper   $y) { 1 };
    multi wins(::T     $x, T       $y) { 0 };
    multi wins($x, $y)                { -1 };

    is wins(Scissor.new, Paper.new),   1,  'Basic sanity';
    #?rakudo 2 skip 'RT 63276'
    is wins(Paper.new,   Paper.new),   0,  'multi dispatch with ::T generics';
    is wins(Paper.new,   Scissor.new), -1, 'fallback if there is a ::T variant';

    multi wins2(Scissor $x, Paper   $y) { 1 };
    multi wins2($x, $y where { $x.WHAT eq $y.WHAT }) { 0 };
    multi wins2($x, $y)                { -1 };
    is wins(Scissor.new, Paper.new),   1,  'Basic sanity 2';
    #?rakudo 2 skip 'subset types that involve multiple parameters'
    is wins(Paper.new,   Paper.new),   0,  'multi dispatch with faked generics';
    is wins(Paper.new,   Scissor.new), -1, 'fallback if there is a faked generic';
}

{
    multi m($x,$y where { $x==$y }) { 0 };
    multi m($x,$y) { 1 };

    #?rakudo 2 skip 'subset types that involve multiple parameters'
    is m(2, 3), 1, 'subset types involving mulitple parameters (fallback)';
    is m(1, 1), 0, 'subset types involving mulitple parameters (success)';
}


# vim: ft=perl6
