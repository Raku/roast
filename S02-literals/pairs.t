use v6;

use Test;

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
#   foo([,] $pair);     # named

plan 40;

sub f1 ($a, $b) { WHAT($a) ~ WHAT($b) }
#?rakudo skip 'call positional parameters as named ones'
{
    is f1(a     => 42, 23), "IntInt", "'a => 42' is a named";
    is f1(:a(42),  23),     "IntInt", "':a(42)' is a named";
    is f1(:a,      23),     "BoolInt",  "':a' is a named";
    is f1(:!a,     23),     "BoolInt",  "':!a' is also named";

    is f1("a"   => 42, 23), "PairInt", "'\"a\" => 42' is a named";
    is f1(("a") => 42, 23), "PairInt", "'(\"a\") => 42' is a pair";
    is f1((a   => 42), 23), "PairInt", "'(a => 42)' is a pair";
    is f1(("a" => 42), 23), "PairInt", "'(\"a\" => 42)' is a pair";
    is f1((:a(42)),    23), "PairInt", "'(:a(42))' is a pair";
    is f1((:a),        23), "PairInt",  "'(:a)' is a pair";
    is f1((:!a),       23), "PairInt",  "'(:a)' is also a pair";
}

sub f2 (:$a!) { ~WHAT($a) }
{
    my $f2 = &f2;

    is f2(a     => 42), "Int", "'a => 42' is a named";
    is f2(:a(42)),      "Int", "':a(42)' is a named";
    #?rakudo todo 'Adverbial pairs without should produce a Bool (not Int)'
    is f2(:a),          "Bool", "':a' is a named";
    
    #?rakudo todo '.() sub calls'
    is(f2.(:a),         "Bool",  "in 'f2.(:a)', ':a' is a named");
    #?rakudo todo 'Adverbial pairs without should produce a Bool (not Int)'
    is $f2(:a),         "Bool",  "in '\$f2(:a)', ':a' is a named";
    #?rakudo skip '.() sub calls'
    is $f2.(:a),        "Bool",  "in '\$f2.(:a)', ':a' is a named";

    #?rakudo 6 todo 'unknown'
    dies_ok { f2("a"   => 42) }, "'\"a\" => 42' is a pair";
    dies_ok { f2(("a") => 42) }, "'(\"a\") => 42' is a pair";
    dies_ok { f2((a   => 42)) }, "'(a => 42)' is a pair";
    dies_ok { f2(("a" => 42)) }, "'(\"a\" => 42)' is a pair";
    dies_ok { f2((:a(42)))    }, "'(:a(42))' is a pair";
    dies_ok { f2((:a))        }, "'(:a)' is a pair";
    #?rakudo todo '.() sub calls'
    dies_ok { f2.((:a))       }, "in 'f2.((:a))', '(:a)' is a pair";
    
    #?rakudo todo 'unknown'
    dies_ok { $f2((:a))       }, "in '\$f2((:a))', '(:a)' is a pair";
    #?rakudo skip '.() sub calls'
    dies_ok { $f2.((:a))      }, "in '\$f2.((:a))', '(:a)' is a pair";
    #?rakudo todo 'unknown'
    dies_ok { $f2(((:a)))     }, "in '\$f2(((:a)))', '(:a)' is a pair";
    #?rakudo skip '.() sub calls'
    dies_ok { $f2.(((:a)))    }, "in '\$f2.(((:a)))', '(:a)' is a pair";
}

sub f3 ($a) { ~WHAT($a) }
{
    my $pair = (a => 42);

    is f3($pair),  "Pair", 'a $pair is not treated magically...';
    #?pugs todo '[,]'
    #?rakudo skip 'reduce meta op'
    is f3([,] $pair), "Int",    '...but [,] $pair is';
}

sub f4 ($a)    { ~WHAT($a) }
sub get_pair () { (a => 42) }
{

    is f4(get_pair()),  "Pair", 'get_pair() is not treated magically...';
    #?pugs todo '[,]'
    #?rakudo skip 'reduce meta op'
    is f4([,] get_pair()), "Int",    '...but *get_pair() is';
}

sub f5 ($a) { ~WHAT($a) }
{
    my @array_of_pairs = (a => 42);

    is f5(@array_of_pairs), "Array",
        'an array of pairs is not treated magically...';
    #?rakudo skip 'reduce meta op'
    is f5([,] @array_of_pairs), "Array", '...and [,] @array isn\'t either';
}

sub f6 ($a) { ~WHAT($a) }
{

    my %hash_of_pairs = (a => "str");

    is f6(%hash_of_pairs),  "Hash", 'a hash is not treated magically...';
    #?pugs todo '[,]'
    #?rakudo skip 'reduce meta op'
    is f6([,] %hash_of_pairs), "Str",  '...but [,] %hash is';
    #?rakudo skip 'prefix:<|>'
    is f6(|%hash_of_pairs),     'Str',  '... and so is |%hash';
}

sub f7 (:$bar!) { ~WHAT($bar) }
#?rakudo 3 todo 'variables as keys of pairs forbidden'
{
    my $bar = "bar";

    dies_ok { f7($bar => 42) },
        "variables cannot be keys of syntactical pairs (1)";
}

sub f8 (:$bar!) { ~WHAT($bar) }
{
    my @array = <bar>;

    dies_ok { f8(@array => 42) },
        "variables cannot be keys of syntactical pairs (2)";
}

sub f9 (:$bar!) { ~WHAT($bar) }
{
    my $arrayref = <bar>;

    dies_ok { f9($arrayref => 42) },
        "variables cannot be keys of syntactical pairs (3)";
}
