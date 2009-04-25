use v6;

use Test;
plan 3;

class Match is also { method keys () {return %(self).keys }; };
rule a {H};
"Hello" ~~ /<a>/;
is $/.keys.perl, '["a"]', 'test 1';
my $x = $/;
eval_lives_ok '$x.perl', 'test 2';
is eval('$x.perl'), '["a"]', 'test 3' ;

