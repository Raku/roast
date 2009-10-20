use v6;
use Test;

plan *;

grammar WithMethod {
    rule TOP { 'lorem' | <.panic> }
    method panic { die "The sky is falling!"; }
};

dies_ok { WithMethod.parse('unrelated') },
   'Can call die() from a method within a grammar';

try { WithMethod.parse('unrelated') };
ok "$!" ~~ /'The sky is falling!'/, 'and got the exception message';

done_testing;
