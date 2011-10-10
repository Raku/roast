use v6;
use Test;

plan 10;

# L<S05/Simplified lexical parsing of patterns/not all non-identifier glyphs are currently meaningful as metasyntax>

# testing unknown metasyntax handling

eval_dies_ok('"aa!" ~~ /!/', '"!" is not valid metasyntax');
lives_ok({"aa!" ~~ /\!/}, 'escaped "!" is valid');
lives_ok({"aa!" ~~ /'!'/}, 'quoted "!" is valid');

eval_dies_ok('"aa!" ~~ /\a/', 'escaped "a" is not valid metasyntax');
lives_ok({"aa!" ~~ /a/}, '"a" is valid');
lives_ok({"aa!" ~~ /'a'/}, 'quoted "a" is valid');

# used to be a pugs bug

#?rakudo skip 'calling <foo> from outer scopes'
#?niecza skip 'Unable to resolve method foo in class Cursor'
{
    my rule foo { \{ };
    ok '{'  ~~ /<foo>/, '\\{ in a rule (+)';
    ok '!' !~~ /<foo>/, '\\{ in a rule (-)';
}

# RT #74832
{
    dies_ok {eval('/ a+ + /')}, 'Cannot parse regex a+ +';
    #?rakudo todo 'RT 74832'
    ok "$!" ~~ /:i quantif/, 'error message mentions quantif{y,ier}';
}

# vim: ft=perl6
