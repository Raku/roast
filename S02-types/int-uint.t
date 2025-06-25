use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

# L<S09/Sized types/Sized low-level types are named most generally by appending the number of bits to a generic low-level type name>

my @inttypes = <int uint> X~ <1 2 4 8 16 32 64>;
push @inttypes, "byte";
@inttypes .= grep: {
    use MONKEY-SEE-NO-EVAL;
    try EVAL "my $_ \$var = 1; \$var"
};

# nothing to test, we're done
unless @inttypes {
    plan 1;
    pass "No native types to test yet";
    exit;
}

plan 11 * @inttypes + 5;

for @inttypes -> $type {
    my ($minval,$maxval) = ::($type).Range.int-bounds;

    # TODO: merge this if/else into one test once the fudge isn't needed
    if $type eq "uint64" {
        #?rakudo.jvm todo 'getting -1 instead of 18446744073709551615'
        is EVAL("my $type \$var = $maxval; \$var"), $maxval,
          "$type can be $maxval";
    } else {
        is EVAL("my $type \$var = $maxval; \$var"), $maxval,
          "$type can be $maxval";
    }

    is EVAL("my $type \$var = $minval; \$var"), $minval,
      "$type can be $minval";

    # TODO: merge this if/else into one test once the fudge isn't needed
    if $type eq "uint64" || $type eq "int64" {
        is EVAL("my $type \$var = $maxval; \$var++; \$var"), $minval,
          "$type overflows to $minval";
    } else {
        #?rakudo.jvm todo 'max overflow to min'
        is EVAL("my $type \$var = $maxval; \$var++; \$var"), $minval,
          "$type overflows to $minval";
    }

    # TODO: merge this if/else into one test once the fudge isn't needed
    if $type eq "int64" {
        is EVAL("my $type \$var = $minval; \$var--; \$var"), $maxval,
          "$type underflows to $maxval";
    } else {
        #?rakudo.jvm todo 'underflow to max'
        is EVAL("my $type \$var = $minval; \$var--; \$var"), $maxval,
          "$type underflows to $maxval";
    }

    # XXX TODO: merge this if/else into one test once the fudge isn't needed
    if $type eq "uint64" || $type eq "int64" {
        #?rakudo.jvm todo 'setting to more than max'
        throws-like { EVAL "my $type \$var = {$maxval+1}" },
          Exception,
          "setting $type to more than $maxval throws";
    } else {
        #?rakudo todo 'setting more than max throws'
        throws-like { EVAL "my $type \$var = {$maxval+1}" },
          Exception,
          "setting $type to more than $maxval throws";
    }

    # XXX TODO: merge this if/else into one test once the fudge isn't needed
    if $type eq 'int64' {
        #?rakudo.jvm todo 'setting less than min throws'
        throws-like { EVAL "my $type \$var = {$minval-1}" },
          Exception,
          "setting $type to less than $minval throws";
    }
    else {
        #?rakudo todo 'setting less than min throws'
        throws-like { EVAL "my $type \$var = {$minval-1}" },
          Exception,
          "setting $type to less than $minval throws";
    }

    throws-like { EVAL "my $type \$var = 'foo'" },
      Exception,
      "$type cannot be a string";
    throws-like { EVAL "my $type \$var = 42.1" },
      Exception,
      "$type cannot be non-integer";
    throws-like { EVAL "my $type \$var = NaN" },
      Exception,
      "$type cannot be NaN";

    is(EVAL("my $type \$var = 0; \$var++; \$var"), 1, "$type \$var++ works");
    is(EVAL("my $type \$var = 1; \$var--; \$var"), 0, "$type \$var-- works");
}

# https://github.com/Raku/old-issue-tracker/issues/5022
#?rakudo.js.browser skip "CUnion doesn't work in the browser we don't have proper NativeCall there"
{
    class Overlap is repr('CUnion') {
        has uint32 $.u32;
        has uint16 $.u16;
        has uint8  $.u8;
    }
    my $overlap = Overlap.new(u32 => 1234567);
    is $overlap.u32, 1234567, "uint32 in union is unsigned";
    is $overlap.u16,   54919, "uint16 in union is unsigned";
    is $overlap.u8,      135,  "uint8 in union is unsigned";
}

# https://github.com/Raku/old-issue-tracker/issues/6332
is-eqv byte.Range.int-bounds, (0, 255), "byte.Range works";

# Check coercers
subtest "Testing native coercers" => {
    my $on-jvm = $*RAKU.compiler.backend eq 'jvm';
    for (
        byte   => (
          255, 255,  256, 0,
        ),
        uint8  => (
          255, 255,  256, 0,
        ),
        uint16 => (
          65535, 65535,  65536, 0,
        ),
        uint32 => (
          4294967295, 4294967295,  4294967296, 0,
        ),
        uint64 => (
          # rakudo.jvm todo 'Activate all tests for JVM once overflow works as expected.'
          $on-jvm
            ?? (18446744073709551616, 0)
            !! (18446744073709551615, 18446744073709551615,
                18446744073709551616, 0)
        ),
        uint => (
          # rakudo.jvm todo 'Activate all tests for JVM once overflow works as expected.'
          $on-jvm
            ?? (18446744073709551616, 0)
            !! (18446744073709551615, 18446744073709551615,
                18446744073709551616, 0)
        ),

        int8  => (
          # rakudo.jvm todo 'Activate all tests for JVM once overflow works as expected.'
          $on-jvm
            ?? (127, 127)
            !! (255, -1,  256, 0,  127, 127,  128,  -128)
        ),
        int16 => (
          # rakudo.jvm todo 'Activate all tests for JVM once overflow works as expected.'
          $on-jvm
            ?? (32767, 32767)
            !! (65535,    -1,  65536,      0,
                32767, 32767,  32768, -32768)
        ),
        int32 => (
          # rakudo.jvm todo 'Activate all tests for JVM once overflow works as expected.'
          $on-jvm
            ?? (2147483647, 2147483647)
            !! (4294967295,         -1,  4294967296,           0,
                2147483647, 2147483647,  2147483648, -2147483648)
        ),
        int64 => (
           9223372036854775807,  9223372036854775807,
           9223372036854775808, -9223372036854775808,
          18446744073709551615,                   -1,
          18446744073709551616,                    0,
        ),
        int => (
           9223372036854775807,  9223372036854775807,
           9223372036854775808, -9223372036854775808,
          18446744073709551615,                   -1,
          18446744073709551616,                    0,
        ),
    ) {
        my str $coercer = .key;

        is   0."$coercer"(), 0, "Did 0.$coercer coerce to 0";
        is "0"."$coercer"(), 0, "Did '0'.$coercer coerce to 0";

        for .value -> $value, $coerced {
            is $value."$coercer"(), $coerced,
              "Did $value\.$coercer coerce to $coerced";
            is "$value"."$coercer"(), $coerced,
              "Did '$value'.$coercer coerce to $coerced";
        }
    }
}

# vim: expandtab shiftwidth=4
