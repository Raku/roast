use v6;
use Test;

plan 6;

# L<S05/Simplified lexical parsing of patterns/not all non-identifier glyphs are currently meaningful as metasyntax>

# testing unknown metasyntax handling

eval_dies_ok('"aa!" ~~ /!/', '"!" is not valid metasyntax');
lives_ok({"aa!" ~~ /\!/}, 'escaped "!" is valid');
lives_ok({"aa!" ~~ /'!'/}, 'quoted "!" is valid');

eval_dies_ok('"aa!" ~~ /\a/', 'escaped "a" is not valid metasyntax');
lives_ok({"aa!" ~~ /a/}, '"a" is valid');
lives_ok({"aa!" ~~ /'a'/}, 'quoted "a" is valid');
