use v6;
use Test;

plan 14;

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
#?niecza skip 'TODO'
ok "hello" !~~ m:ignorecase/Hello/,        "match with :ignorecase (direct)";
ok('Δ' ~~ m:i/δ/, ':i with greek chars');

# The German ß (&szlig;) maps to uppercase SS:
#?rakudo 2 todo 'ignorecase and SS/&szlig;'
#?niecza skip 'TODO'
ok('ß' ~~ m:i/SS/, "ß matches SS with :ignorecase");
#?niecza skip 'TODO'
ok('SS' ~~ m:i/ß/, "SS matches ß with :ignorecase");


#RT #76750
ok('a' ~~ m/:i 'A'/, ':i descends into quotes');

# vim: syn=perl6 sw=4 ts=4 expandtab
