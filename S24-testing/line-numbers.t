use v6;
use Test;

plan 13;

my $dir    = 't/spec/S24-testing/test-data/';
my $prefix = 'line-number-';
my $suffix = '.txt';

my $cmd;
my $full-path;

sub execute-test ( :$function, :$line ) {
    $full-path = $dir ~ $prefix ~ $function ~ $suffix;
    $cmd = "$*EXECUTABLE $full-path 2>&1";
    ok qqx[$cmd] ~~ /'Failed test ' (\N* \n \N*)? 'at ' $full-path ' line ' $line/,
        "failing test with $function reports correct line number $line";
}

#?DOES 1
execute-test(:function("cmp_ok"), :line(9));

#?DOES 1
execute-test(:function("dies_ok"), :line(9));

#?DOES 1
execute-test(:function("eval_dies_ok"), :line(9));

#?DOES 1
execute-test(:function("eval_lives_ok"), :line(9));

#?DOES 1
execute-test(:function("isa_ok"), :line(9));

#?DOES 1
execute-test(:function("is_approx"), :line(9));

#?DOES 1
execute-test(:function("is_deeply"), :line(9));

#?DOES 1
execute-test(:function("isnt"), :line(9));

#?DOES 1
execute-test(:function("is"), :line(9));

#?DOES 1
execute-test(:function("lives_ok"), :line(9));

#?DOES 1
execute-test(:function("nok"), :line(9));

#?DOES 1
execute-test(:function("ok"), :line(9));

#?DOES 1
execute-test(:function("throws_like"), :line(9));
