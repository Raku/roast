use v6;
use Test;
plan 18;

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

#?rakudo skip 'based dispatch on Str'
is(foo('test'), 'Str test', 'dispatched to the Str sub');
is(foo(2), 'Int 2', 'dispatched to the Int sub');

my $num = '4';
is(foo(1.4), 'Num 1.4', 'dispatched to the Num sub');
is(foo(1 == 1), 'Bool 1', 'dispatched to the Bool sub');
#?rakudo skip 'rx:P5'
is(foo(rx:P5/a/),'Rule Rule','dispatched to the Rule sub', :todo<bug>);
#?rakudo skip '"parameter type check failed"'
is(foo(sub { 'baz' }), 'Sub baz', 'dispatched to the Sub sub');

my @array = ('foo', 'bar', 'baz');
#?rakudo skip 'based dispatch on Array'
is(foo(@array), 'Array foo, bar, baz', 'dispatched to the Array sub');

my %hash = ('foo' => 1, 'bar' => 2, 'baz' => 3);
is(foo(%hash), 'Hash bar, baz, foo', 'dispatched to the Hash sub');

is(foo($*ERR), 'IO', 'dispatched to the IO sub');

#?pugs 4 todo "feature"
#?rakudo 2 skip 'Null PMC access in type()'
ok(eval('multi sub foo( (Int, Str) $tuple: ) '
    ~ '{ "Tuple(2) " ~ $tuple.join(",") }'),
    "declare sub with tuple argument");

ok(eval('multi sub foo( (Int, Str, Str) $tuple: ) '
    ~ '{ "Tuple(3) " ~ $tuple.join(",") }'),
    "declare multi sub with tuple argument");

# XXX isn't that just an Array nowadays?
#?rakudo 2 skip '"No applicable methods"'
is(foo([3, "Four"]), "Tuple(2) 3,Four", "call tuple multi sub");
is(foo([3, "Four", "Five"]), "Tuple(3) 3,Four,Five", "call tuple multi sub");

# You're allowed to omit the "sub" when declaring a multi sub.
# L<S06/"Routine modifiers">

multi declared_wo_sub (Int $x) { 1 }
multi declared_wo_sub (Str $x) { 2 }
is declared_wo_sub(42),   1, "omitting 'sub' when declaring 'multi sub's works (1)";
#?rakudo skip 'based dispatch on Str'
is declared_wo_sub("42"), 2, "omitting 'sub' when declaring 'multi sub's works (2)";

# Test for slurpy MMDs

proto mmd {}  # L<S06/"Routine modifiers">
multi mmd () { 1 }
multi mmd (*$x, *@xs) { 2 }

#?rakudo 3 skip '"Null PMC access in type()'
is(mmd(), 1, 'Slurpy MMD to nullary');
is(mmd(1,2,3), 2, 'Slurpy MMD to listop via args');
is(mmd(1..3), 2, 'Slurpy MMD to listop via list');

