use v6.c;
use Test;

plan 13;

# L<S05/Simplified lexical parsing of patterns/not all non-identifier glyphs are currently meaningful as metasyntax>

# testing unknown metasyntax handling

throws-like '"aa!" ~~ /!/', X::Syntax::Regex::UnrecognizedMetachar,
    '"!" is not valid metasyntax';
lives-ok({"aa!" ~~ /\!/}, 'escaped "!" is valid');
lives-ok({"aa!" ~~ /'!'/}, 'quoted "!" is valid');

throws-like '"aa!" ~~ /\a/', Exception, 'escaped "a" is not valid metasyntax';
lives-ok({"aa!" ~~ /a/}, '"a" is valid');
lives-ok({"aa!" ~~ /'a'/}, 'quoted "a" is valid');

{
    my rule foo { \{ };
    ok '{'  ~~ /<foo>/, '\\{ in a rule (+)';
    ok '!' !~~ /<foo>/, '\\{ in a rule (-)';
}

# RT #74832
{
    dies-ok {EVAL('/ a+ + /')}, 'Cannot parse regex a+ +';
    #?rakudo todo 'RT #74832'
    #?niecza todo
    ok "$!" ~~ /:i quantif/, 'error message mentions quantif{y,ier}';
}

# RT #77110, #77386
#?niecza skip "throws-like"
#?DOES 3
{
    throws-like '$_ = "0"; s/-/1/', X::Syntax::Regex::UnrecognizedMetachar, metachar => '-';
}

# RT #77562
# not sure this is the right place for this test
{
    lives-ok { /$'x'/ }, 'can parse /$\'x\'/';
}

# RT #125648
throws-like '/00:11:22/', X::Syntax::Regex::UnrecognizedModifier, modifier => '11';

# vim: ft=perl6
