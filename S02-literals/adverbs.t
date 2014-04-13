use v6;
use Test;

plan 11;

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

    is (:a{ 42 + 24 })<a>(), 66, "Adverb with postfix:<{ }> makes code object";
}
