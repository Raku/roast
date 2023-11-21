use v6.c;
use Test;

plan 25;

=begin description

Testing the C<:ignorecase> regex modifier - more tests are always welcome

There are still a few things missing, like lower case <-> title case <-> upper
case tests

Note that the meaning of C<:i> does B<not> descend into subrules.

=end description

# tests for inline modifiers
# L<S05/Modifiers/and Unicode-level modifiers can be>

ok("abcDEFghi" ~~ m/abc (:i def) ghi/, 'Match');
ok(!( "abcDEFGHI" ~~ m/abc (:i def) ghi/ ), 'Mismatch');


#L<S05/Modifiers/"The :i">

my regex mixedcase { Hello };

# without :i

ok "Hello" ~~ m/<&mixedcase>/, "match mixed case (subrule)";
ok 'Hello' ~~ m/Hello/,       "match mixed case (direct)";

ok "hello" !~~ m/<&mixedcase>/, "do not match lowercase (subrule)";
ok "hello" !~~ m/Hello/,       "do not match lowercase (direct)";

ok "hello" !~~ m:i/<&mixedcase>/, "no match with :i if matched by subrule";
ok "hello"  ~~ m:i/Hello/,       "match with :i (direct)";

ok "hello" !~~ m:ignorecase/<&mixedcase>/,  "no match with :ignorecase + subrule";
ok "hello"  ~~ m:ignorecase/Hello/,        "match with :ignorecase (direct)";
ok('Δ' ~~ m:i/δ/, ':i with greek chars');

# The German ß (&szlig;) maps to uppercase SS:
#?niecza todo
ok('ß' ~~ m:i/SS/, "ß matches SS with :ignorecase");
#?niecza todo
ok('SS' ~~ m:i/ß/, "SS matches ß with :ignorecase");


#RT #76750
ok('a' ~~ m/:i 'A'/, ':i descends into quotes');

# RT #76500
{
    my $matcher = 'aA';
    nok 'aa' ~~ /   $matcher/, 'interpolation: no match without :i';
    #?niecza todo
     ok 'aa' ~~ /:i $matcher/, 'interpolation: match with :i';
}

ok 'a' ~~ /:i A|B /, ':i and LTM sanity';
ok 'a' ~~ /:i < A B > /, ':i and quote words';

ok 'A4' ~~ /:i a[3|4|5] | b[3|4] /, 'alternation sanity';

#RT #114362
{
    ok "BLAR" ~~ /:ignorecase [blar | blubb]/, ":ignorecase works with |";
    ok "BluBb" ~~ /:ignorecase [blar || blubb]/, ":ignorecase works with |";
}

# RT #114692
{
    try EVAL '"ABC" ~~ /:iabc/';
    ok $!, "need whitespace after modifier";
}

# RT #77410
{
    #?niecza todo "NYI"
    ok  "m" ~~ /:i <[M]>/, "ignore case of character classes";
    nok "m" ~~ /<[M]>/,    "ignore case of character classes";
    nok "n" ~~ /:i <[M]>/, "ignore case of character classes";
}

# vim: syn=perl6 sw=4 ts=4 expandtab
