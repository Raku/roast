# http://perl6advent.wordpress.com/2011/12/15/day-15-something-exceptional/
use v6;
use Test;
plan 9;

sub might_die(Real $x) {
    die "negative" if $x < 0;
    $x.sqrt;
}

my @inputs = 5, 0, -3, 1+2i;
my @expected = /^'The square root of 5 is 2.23'\d+$/,
    'The square root of 0 is 0',
    'Cannot take square root of -3: negative',
    /^'Other error: '.+$/;
my @results;
 
for @inputs -> $n {
    @results.push: "The square root of $n is " ~ might_die($n);
 
    CATCH {
        # CATCH sets $_ to the error object,
        # and then checks the various cases:
        when 'negative' {
            # note that $n is still in scope,
            # since the CATCH block is *inside* the
            # to-be-handled block
            @results.push: "Cannot take square root of $n: negative"
        }
        default {
            @results.push: "Other error: $_";
        }
    }
}

for @inputs Z @results Z @expected -> $input, $result, $expected {
    ok $result ~~ $expected, "handing of $input"
        or diag "got: $result";
}

try EVAL q[ class A; method { $!x } ];
is $!, 'Attribute $!x not declared in class A', 'compiler error message';
isa_ok $!, X::Attribute::Undeclared, 'compiler error class';
ok $! ~~ X::Comp, 'compile error does X::Comp';

try EVAL q[ die 42 ];
ok $!, 'runtime error';
nok $! ~~ X::Comp, "runtime error doesn't X::Comp";




