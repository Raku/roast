use v6;
use Test;

plan 5;

eval_lives_ok 'my $x = 3; END { $x * $x }',
              'outer lexicals are visible in END { ... } blocks';

eval_lives_ok 'my %rt112408 = END => "parsing clash with block-less END"',
	      'Can use END as a bareword hash key (RT 112408)';

my $a = 0;
#?rakudo 2 todo 'lexicals and EVAL()'
#?niecza todo
eval_lives_ok 'my $x = 3; END { $a = $x * $x };',
              'and those from eval as well';

#?niecza todo
#?pugs todo
is $a, 9, 'and they really worked';

END { pass("exit does not prevent running of END blocks"); }
exit;

# vim: ft=perl6
