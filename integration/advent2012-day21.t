# http://perl6advent.wordpress.com/2012/12/21/day-21-collatz-variations/
# more about benchmarking than anything else. Definitely a stress test!
use v6;
use Test;
plan 9;

use lib 't/spec/packages';
use Test::Util;

our $basic = q:to"END";
sub collatz-sequence(Int $start) { 
    $start, { when * %% 2 { $_ / 2 }; when * !%% 2 { 3 * $_ + 1 }; } ... 1;
}
 
sub MAIN(Int $min, Int $max) {
    say [max] ($min..$max).map({ +collatz-sequence($_) });        
}
END

is_run $basic, {out => '', err => /^'Usage:' .*? '<min> <max>'/}, 'main usage';

our $bench1 = q:to"END";
sub collatz-length(Int $start) { 
    +($start, { when * %% 2 { $_ / 2 }; when * !%% 2 { 3 * $_ + 1 }; } ... 1);
}
END

our $bench2 = q:to"END";
sub collatz-length($start) {
    given $start {
        when 1       { 1 }
        when * !%% 2 { 1 + collatz-length(3 * $_ + 1) } 
        when * %% 2  { 1 + collatz-length($_ / 2) } 
    }
}
END

our $bench3 = q:to"END";
sub collatz-length(Int $start) { 
    +($start, { $_ %% 2 ?? $_ div 2 !! 3 * $_ + 1 } ... 1);
}
END

our $bench4 = q:to"END";
sub collatz-length(Int $n is copy) {
    my $length = 1;
    while $n != 1 {
        $n = $n %% 2 ?? $n div 2 !! 3 * $n + 1;
        $length++;
    }
    $length;
}
END

our $bench5 = q:to"END";
sub collatz-length(Int $n) {
    return 1 if $n == 1;
    1 + ($n %% 2 ?? collatz-length($n div 2) !! collatz-length(3 * $n + 1));
}
END

our $bench6 = q:to"END";
sub collatz-length(Int $n) {
    return 1 if $n == 1;
    state %lengths;
    return %lengths{$n} if %lengths{$n}:exists;
    %lengths{$n} = 1 + ($n %% 2 ?? collatz-length($n div 2) !! collatz-length(3 * $n + 1));
}
END

# a couple of contributions from gerdr and kaz

our $bench7 = q:to"END";
sub collatz-length(Int $n) {
    state %cache = 1 => 1;
    %cache{$n} //= 1 + collatz-length($n %% 2 ?? $n div 2 !! 3 * $n + 1);
}
END

our $bench8 = q:to"END";
sub collatz-length(Int $n) {
    state %seq = 1 => 1;
    %seq{$n} //= 1 + collatz-length($n +& 1 ?? 3 * $n + 1 !! $n +> 1);
}
END

our $common-main = q:to"END";
sub MAIN(*@numbers) {
    for @numbers -> $n {
        say "$n: " ~ collatz-length($n.Int);
    }
}
END

my @numbers = 1..200, 10000..10200;

sub collatz-length(Int $start) { 
    +($start, { when * %% 2 { $_ / 2 }; when * !%% 2 { 3 * $_ + 1 }; } ... 1);
}
my $expected-output = @numbers.map( -> $n {"$n: " ~ collatz-length($n)}).join("\n") ~ "\n";

our %results;

sub run-harness($code,$bench-name) {
    my $start = now;
    my $out = Test::Util::run( $code ~ $common-main, :args(@numbers));
    my $end = now;
    %results{$bench-name} = $end - $start;
    $out;
}

is run-harness($bench1, 'sequence'), $expected-output, 'sequence';
is run-harness($bench2, 'recursive-ternary-hand-cached'), $expected-output, 'recursive-ternary-hand-cached';
is run-harness($bench3, 'sequence-ternary'), $expected-output, 'sequence-ternary';
is run-harness($bench4, 'loop'), $expected-output, 'loop';
is run-harness($bench5, 'recursive-ternary'), $expected-output, 'recursive-ternary';
#?rakudo.jvm skip 'RT #122497'
#?rakudo.parrot skip 'RT #122497'
is run-harness($bench6, 'hand-memoization'), $expected-output, 'hand-memoization';
is run-harness($bench7, 'gerdr'), $expected-output, 'gerdr';
is run-harness($bench8, 'kaz'), $expected-output, 'kaz';

for %results.pairs.sort(*.value) -> (:key($script), :value($time)) {
    diag "$script: $time seconds";
}
