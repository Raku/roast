use v6.c;
use Test;

plan 8;

grammar WithMethod {
    rule TOP { 'lorem' | <.panic> }
    method panic { die "The sky is falling!"; }
};

dies-ok { WithMethod.parse('unrelated') },
   'Can call die() from a method within a grammar';

try { WithMethod.parse('unrelated') };
ok "$!" ~~ /'The sky is falling!'/, 'and got the exception message';

my $x = 0;
grammar WithOuterLex {
    regex TOP { x { $x = 42 } }
}
try WithOuterLex.parse('xxx');
is $x, 42, 'regex in a grammar can see outer lexicals';

grammar WithAttrib {
    has Str $.sep;
}
# RT #73680
is WithAttrib.new(sep => ',').sep, ',', 'attributes work in grammars too';
isa-ok WithAttrib.new.sep, Str, 'empty attribute intilized to Str';

# RT #113552
{
    try { EVAL 'grammar A { token a { ... }; token a { ... } }' };
    my $error = ~$!;
    ok $error ~~ /:i 'already has a Regex \'a\'' /, "duplicate methods err sanely";
}

# RT #125169
{
    grammar D { our token doo { doo }; };
    ok 'doo' ~~ &D::doo,        'our token as rhs of smartmatch';
    ok 'doo' ~~ / <&D::doo> /, 'our token in regey assertion';
}
