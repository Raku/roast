use v6;
use Test;

# L<S09/Sized types/Sized low-level types are named most generally by appending the number of bits to a generic low-level type name>

my @inttypes = <1 2 4 8 16 32 64>.map({
  "int$_","uint$_"
}).grep: {
    try EVAL "my $_ \$var; \$var.WHAT eq \"($_)\""
};

# nothing to test, we're done
unless @inttypes {
    plan 1;
    pass "No native types to test yet";
    exit;
}

plan 9 * @inttypes;

for @inttypes -> $type {

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

    throws_like { EVAL "my $type \$var = {$maxval+1}" },
      X::AdHoc,
      "$type cannot be {$maxval+1}";
    throws_like { EVAL "my $type \$var = {$minval-1}" },
      X::AdHoc,
      "$type cannot be {$minval-1}";
    throws_like { EVAL "my $type \$var = 'foo'" },
      X::AdHoc,
      "$type cannot be a string";
    throws_like { EVAL "my $type \$var = 42.1" },
      X::AdHoc,
      "$type cannot be non-integer";
    throws_like { EVAL "my $type \$var = NaN" },
      X::AdHoc,
      "$type cannot be NaN";

    #?rakudo 2 skip "Cannot modify an immutable value"
    is(EVAL("my $type \$var = 0; \$var++; \$var"), 1, "$type \$var++ works");
    is(EVAL("my $type \$var = 1; \$var--; \$var"), 0, "$type \$var-- works");
}

# vim: ft=perl6
