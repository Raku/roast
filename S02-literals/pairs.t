use v6;

use Test;

# L<S02/Adverbial Pair forms/"There is now a generalized adverbial form of Pair">

# See thread "Demagicalizing pair" on p6l started by Luke Palmer,
# L<"http://article.gmane.org/gmane.comp.lang.perl.perl6.language/4778/"> and
# L<"http://colabti.de/irclogger/irclogger_log/perl6?date=2005-10-09,Sun&sel=528#l830">.
# Also see L<"http://www.nntp.perl.org/group/perl.perl6.language/23532">.

# To summarize:
#   foo(a => 42);  # named
#   foo(:a(42));   # named
#
#   foo((a => 42));  # pair passed positionally
#   foo((:a(42)));   # pair passed positionally
#
#   my $pair = (a => 42);
#   foo($pair);      # pair passed positionally
#   foo(|$pair);     # named
#
#   S02 lists ':a' as being equivlaent to a => 1, so
#   the type of the value of that pair is Int, not Bool

plan 76;

sub f1n (:$a) { $a.WHAT.gist }
sub f1p ( $a) { $a.WHAT.gist }
{
    is f1n(a => 42), Int.gist, "'a => 42' is a named";
    is f1n(:a(42)),  Int.gist, "':a(42)' is a named";

    is f1n(:a),      Bool.gist,  "':a' is a named";
    is f1n(:!a),     Bool.gist,  "':!a' is also named";

    is f1p("a"   => 42), Pair.gist, "'\"a\" => 42' is a pair";
    is f1p(("a") => 42), Pair.gist, "'(\"a\") => 42' is a pair";
    is f1p((a   => 42)), Pair.gist, "'(a => 42)' is a pair";
    is f1p(("a" => 42)), Pair.gist, "'(\"a\" => 42)' is a pair";
    is f1p((:a(42)),  ), Pair.gist, "'(:a(42))' is a pair";
    is f1p((:a),      ), Pair.gist,  "'(:a)' is a pair";
    is f1p((:!a),     ), Pair.gist,  "'(:a)' is also a pair";
    is f1n(:a[1, 2, 3]), Array.gist, ':a[...] constructs an Array value';
    is f1n(:a{b => 3}),  Hash.gist, ':a{...} constructs a Hash value';
}

{
    my $p = :a[1, 2, 3];
    is $p.key, 'a', 'correct key for :a[1, 2, 3]';
    is $p.value.join('|'), '1|2|3', 'correct value for :a[1, 2, 3]';
}

{
    my $p = :a{b => 'c'};
    is $p.key, 'a', 'correct key for :a{ b => "c" }';
    is $p.value.keys, 'b', 'correct value for :a{ b => "c" } (keys)';
    is $p.value.values, 'c', 'correct value for :a{ b => "c" } (values)';
}

sub f2 (:$a!) { WHAT($a) }
{
    my $f2 = &f2;

    isa_ok f2(a     => 42), Int, "'a => 42' is a named";
    isa_ok f2(:a(42)),      Int, "':a(42)' is a named";
    isa_ok f2(:a),          Bool,"':a' is a named";

    #?niecza skip "Action method escape:sym<&> not yet implemented"
    isa_ok(&f2.(:a),        Bool, "in '\&f2.(:a)', ':a' is a named");
    isa_ok $f2(:a),         Bool, "in '\$f2(:a)', ':a' is a named";
    isa_ok $f2.(:a),        Bool, "in '\$f2.(:a)', ':a' is a named";

    throws_like { f2("a"   => 42) },
      Exception,
      "'\"a\" => 42' is a pair";
    throws_like { f2(("a") => 42) },
      Exception,
      "'(\"a\") => 42' is a pair";
    throws_like { f2((a   => 42)) },
      Exception,
      "'(a => 42)' is a pair";
    throws_like { f2(("a" => 42)) },
      Exception,
      "'(\"a\" => 42)' is a pair";
    throws_like { f2((:a(42))) },
      Exception,
      "'(:a(42))' is a pair";
    throws_like { f2((:a)) },
      Exception,
      "'(:a)' is a pair";
    throws_like { &f2.((:a)) },
      Exception,
      'in \'&f2.((:a))\', \'(:a)\' is a pair';

    throws_like { $f2((:a)) },
      Exception,
      "in '\$f2((:a))', '(:a)' is a pair";
    throws_like { $f2.((:a)) },
      Exception,
      "in '\$f2.((:a))', '(:a)' is a pair";
    throws_like { $f2(((:a))) },
      Exception,
      "in '\$f2(((:a)))', '(:a)' is a pair";
    throws_like { $f2.(((:a))) },
      Exception,
      "in '\$f2.(((:a)))', '(:a)' is a pair";
}

sub f3 ($a) { WHAT($a) }
{
    my $pair = (a => 42);

    isa_ok f3($pair),  Pair, 'a $pair is not treated magically...';
    dies_ok { EVAL 'f3(|$pair)' }, '|$pair becomes a name, which fails to dispatch';
}

sub f4 ($a)    { WHAT($a) }
sub get_pair () { (a => 42) }
{

    isa_ok f4(get_pair()),  Pair, 'get_pair() is not treated magically...';
}

sub f5 ($a) { WHAT($a) }
{
    my @array_of_pairs = (a => 42);

    isa_ok f5(@array_of_pairs), Array,
        'an array of pairs is not treated magically...';
    isa_ok f5(|@array_of_pairs), Pair, '...and |@array isn\'t either';
}

sub f7 (:$bar!) { WHAT($bar) }
{
    my $bar = 'bar';

    throws_like { f7($bar => 42) },
      Exception,
      "variables cannot be keys of syntactical pairs (1)";
}

sub f8 (:$bar!) { WHAT($bar) }
{
    my @array = <bar>;

    throws_like { f8(@array => 42) },
      Exception,
      "variables cannot be keys of syntactical pairs (2)";
}

sub f9 (:$bar!) { WHAT($bar) }
{
    my $arrayref = <bar>;

    throws_like { f9($arrayref => 42) },
      Exception,
      "variables cannot be keys of syntactical pairs (3)";
}

{
    is (a => 3).elems, 1, 'Pair.elems';
}

# RT #74948
#?DOES 32
{
    for <
        self rand time now YOU_ARE_HERE package module class role
        grammar my our state let temp has augment anon supersede
        sub method submethod macro multi proto only regex token
        rule constant enum subset
    > { 
        is EVAL("($_ => 1).key"), $_, "Pair with '$_' as key" 
    }
}

# vim: ft=perl6
