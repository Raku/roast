use v6;
use Test;

plan 32;

# L<S02/Adverbial Pair forms>

{
    is_deeply (:a), (a => True), "Basic boolean adverb works";
    is_deeply (:!a), (a => False), "Negated boolean adverb works";
    is_deeply (:a(0)), (a => 0), "Adverb with value in parens works";
    is_deeply (:a<foo>), (a => 'foo'), "Adverb with angle quote value works";
    is_deeply (:a<foo bar>), (a => <foo bar>), "...and does the right thing with the value list";
    is_deeply (:a[16,42]), (a => [16,42]), "Adverb with postfix:<[ ]> works";
    my $a = "abcd";
    my @a = <efg hij>;
    my %a = klm => "nop";
    my &a = ->{ "qrst" };
    is_deeply (:$a), (a => $a), ":$a works";
    is_deeply (:@a), (a => @a), ":@a works";
    is_deeply (:%a), (a => %a), ":%a works";
    is_deeply (:&a), (a => &a), ":&a works";
    is_deeply (:42nd), (nd => 42), "Basic numeric adverb works";
    throws_like { EVAL ':69th($_)' },
      X::Comp::AdHoc,
      "Numeric adverb can't have an extra value";

    is (:a{ 42 + 24 })<a>(), 66, "Adverb with postfix:<{ }> makes code object";

=twigils

    is_deeply (:$=pod), (pod => $=pod), 'Adverb with $= twigil works';
    # save for when @=COMMENT works
    # is_deeply (:@=COMMENT), (COMMENT => @=COMMENT), 'Adverb with @= twigil works';
    # There is no %= special variable yet
    is_deeply (:$?PACKAGE), (PACKAGE => $?PACKAGE), 'Adverb with $? twigil works';
    # There is no @? special variable yet
    # save for when %?LANG works
    # is_deeply (:%?LANG), (LANG => %?LANG), 'Adverb with %? twigil works';
    is_deeply (:$*CWD), (CWD => $*CWD), 'Adverb with $* twigil works';
    is_deeply (:@*ARGS), (ARGS => @*ARGS), 'Adverb with @* twigil works';
    is_deeply (:%*ENV), (ENV => %*ENV), 'Adverb with %* twigil works';
    is_deeply ({ :$^f }(3)), (f => 3), 'Adverb with $^ twigil works';
    is_deeply ({ :@^f }([3,3])), (f => [3,3]), 'Adverb with @^ twigil works';
    is_deeply ({ :%^f }((:a(3)))), (f => :a(3)), 'Adverb with %^ twigil works';
    is_deeply ({ :$:f }(:f(3))), (f => 3), 'Adverb with $: twigil works';
    is_deeply ({ :@:f }(:f(3,3))), (f => (3,3)), 'Adverb with @: twigil works';
    is_deeply ({ :%:f }(:f(:a<3>))), (f => :a<3>), 'Adverb with %: twigil works';
    # Not using sigils in rx due to RT #121061 but we do not need to for this
    "aaaa" ~~ m/$<fee>=a $<fie>=((a)(a)) $<foe>=($<fum>=(a))/;
    is_deeply (:$<fee>), (fee => $<fee>), 'Adverb with $< twigil works';
    #?rakudo 2 skip ":@<...> and :%<...> broken needs RT"
    is_deeply (:@<fie>), (fie => @<fie>), 'Adverb with @< twigil works';
    is_deeply (:%<foe>), (foe => %<foe>), 'Adverb with %< twigil works';
    #?rakudo 3 skip "Moar makes new slang object each time, other backend NYI?"
    is_deeply (:$~MAIN), (MAIN => $~MAIN), 'Adverb with $~ twigil works';
    is_deeply (:@~MAIN), (MAIN => @~MAIN), 'Adverb with @~ twigil works';
    is_deeply (:%~MAIN), (MAIN => %~MAIN), 'Adverb with %~ twigil works';

} # 30

# RT #74492
{
    sub foo(:$a, :$b, :$c) {
        ok $a && $b && $c, "Adverbs without punctuations is allowed"
    }
    foo(:a :b :c);
    foo(:a:b:c);
} # 32
