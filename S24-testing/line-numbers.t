use v6;
use Test;

plan 15;

my $dir    = $?FILE.IO.parent.add('test-data');
my $prefix = 'line-number-';
my $suffix = '.txt';

sub execute-test(:$function, :$line) is test-assertion {
    my $full-path = $dir.add($prefix ~ $function ~ $suffix);
    my $proc = run($*EXECUTABLE, $full-path, :!out, :err);
    my $err := $proc.err.slurp;
    diag $err unless like $err,
        /'Failed test ' (\N* \n \N*)? 'at ' $full-path ' line ' $line/,
        "failing test with $function reports correct line number $line";
}

#?DOES 1
execute-test(:function("cmp-ok"), :line(9));

#?DOES 1
execute-test(:function("dies-ok"), :line(9));

#?DOES 1
execute-test(:function("eval-dies-ok"), :line(9));

#?DOES 1
execute-test(:function("eval-lives-ok"), :line(9));

#?DOES 1
execute-test(:function("isa-ok"), :line(9));

#?DOES 1
execute-test(:function("is_approx"), :line(9));

#?DOES 1
execute-test(:function("is-deeply"), :line(9));

#?DOES 1
execute-test(:function("isnt"), :line(9));

#?DOES 1
execute-test(:function("is"), :line(9));

#?DOES 1
execute-test(:function("lives-ok"), :line(9));

#?DOES 1
execute-test(:function("nok"), :line(9));

#?DOES 1
execute-test(:function("ok"), :line(9));

#?DOES 1
execute-test(:function("throws-like"), :line(9));

#?DOES 1
execute-test(:function("foo-ok"), :line(11));

#?DOES 1
execute-test(:function("bar-ok"), :line(12));

# vim: expandtab shiftwidth=4
