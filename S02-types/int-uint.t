use v6;
use Test;

# L<S09/Sized types/Sized low-level types are named most generally by appending the number of bits to a generic low-level type name>

my @inttypes = map {"int$_", "uint$_"}, <1 2 4 8 16 32 64>;
plan 10 * @inttypes;

for @inttypes -> $type {
    eval_lives_ok "my $type \$var; 1", "Type $type lives"
        or do {
            skip "low-level data type $type not supported on this platform", 7;
            next;
        }

    my $maxval; my $minval;
    $type ~~ /(\d+)/;
    my $len = $/[0]; # get the numeric value
    if $type ~~ /^uint/ {
        $maxval = 2**$len - 1;
        $minval = 0;
    } else { # /^int/
        $maxval = 2**($len - 1) - 1;
        $minval = -(2**($len - 1));
    }

    is(EVAL("my $type \$var = $maxval"), $maxval, "$type can be $maxval");
    is(EVAL("my $type \$var = $minval"), $minval, "$type can be $minval");
    eval_dies_ok("my $type \$var = {$maxval+1}", "$type cannot be {$maxval+1}");
    eval_dies_ok("my $type \$var = {$minval-1}", "$type cannot be {$minval-1}");
    eval_dies_ok("my $type \$var = 'foo'", "$type cannot be a string");
    eval_dies_ok("my $type \$var = 42.1", "$type cannot be non-integer");
    eval_dies_ok("my $type \$var = NaN", "$type cannot be NaN");

    #?rakudo 2 skip "Cannot modify an immutable value"
    is(EVAL("my $type \$var = 0; \$var++; \$var"), 1, "$type \$var++ works");
    is(EVAL("my $type \$var = 1; \$var--; \$var"), 0, "$type \$var-- works");
}

# vim: ft=perl6
