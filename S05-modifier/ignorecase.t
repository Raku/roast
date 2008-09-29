use v6;
use Test;

plan 7;

=begin description

Testing the C<:ignorecase> regex modifier - more tests are always welcome

There are still a few things missing, like lower case <-> title case <-> upper
case tests

=end description

#L<S05/Modifiers/"The :i">

regex mixedcase { Hello };

# without :i

"Hello" ~~ m/<mixedcase>/;
is(~$/, "Hello", "match mixed case");

"hello" ~~ m/<mixedcase>/;
is(~$/, "", "do not match lowercase");

#?rakudo emit skip_rest('unimplemented m:i parsing');

#?rakudo emit =begin

"hello" ~~ m:i/<mixedcase>/;
is(~$/, "hello", "match with :i");

"hello" ~~ m:ignorecase/<mixedcase>/;
is(~$/, "hello", "match with :ignorecase");
ok('Δ' ~~ m:i/δ/, ':i with greek chars');

# The German ß (&szlig;) maps to uppercase SS:
ok('ß' ~~ m:i/SS/, "ß matches SS with :ignorecase");
ok('SS' ~~ m:i/ß/, "SS matches ß with :ignorecase");

#?rakudo emit =end

# vim: syn=perl6 sw=4 ts=4 expandtab
