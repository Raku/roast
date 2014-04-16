# http://perl6advent.wordpress.com/2012/12/09/day-9-longest-token-matching/
use v6;
use Test;
plan 8;

is ~("food and drink" ~~ / foo | food /), 'food', 'ltm';
is ~("food and drink" ~~ / foo || food /), 'foo', 'first alternantive';

grammar Letter {
    rule text     { <greet> $<body>=<line>+? <close> }
    rule greet    { [Hi|Hey|Yo] $<to>=\S+? ',' }
    rule close    { Later dude ',' $<from>=.+ }
    token line    { \N* \n}
}

is ~Letter.parse("Hi perl6,", :rule<greet>), 'Hi perl6,', 'greeting parse';
is ~Letter.parse("Later dude, Fred", :rule<close>), 'Later dude, Fred', 'closing parse';

my $informal-letter = "Yo Cabal,
Informal body text.
Later dude, Random Hacker";

my $p = Letter.parse($informal-letter, :rule<text>);
is ~$p, $informal-letter, 'informal letter parse';

for $p -> $/ {
    is ~$<greet><to>, 'Cabal', 'informal letter greet';
    is ~$<close><from>, 'Random Hacker', 'informal letter close';
}

grammar FormalLetter is Letter {
    rule greet { Dear $<to>=\S+? ',' }
    rule close { Yours sincerely ',' $<from>=.+ }
}

my $formal-letter = "Dear Perl6,
   Formal body text.
   Yours sincerely, Tester";

$p = FormalLetter.parse($formal-letter, :rule<text>);
is ~$p, $formal-letter, 'formal letter parse';
