use v6;
use Test;

plan 5;

grammar WithMethod {
    rule TOP { 'lorem' | <.panic> }
    method panic { die "The sky is falling!"; }
};

dies_ok { WithMethod.parse('unrelated') },
   'Can call die() from a method within a grammar';

try { WithMethod.parse('unrelated') };
ok "$!" ~~ /'The sky is falling!'/, 'and got the exception message';

my $x = 0;
grammar WithOuterLex {
    regex TOP { x { $x = 42 } }
}
WithOuterLex.parse('xxx');
is $x, 42, 'regex in a grammar can see outer lexicals';

grammar WithAttrib {
    has Str $.sep;
}
# RT #73680
is WithAttrib.new(sep => ',').sep, ',', 'attributes work in grammars too';
isa_ok WithAttrib.new.sep, Str, 'empty attribute intilized to Str';
