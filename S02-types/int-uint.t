use v6;
use Test;

# L<S09/Sized types/Sized low-level types are named most generally by appending the number of bits to a generic low-level type name>

my @inttypes = <1 2 4 8 16 32 64>.map({
  |("int$_","uint$_")
}).grep: {
    use MONKEY-SEE-NO-EVAL;
    try EVAL "my $_ \$var = 1; \$var"
};

# nothing to test, we're done
unless @inttypes {
    plan 1;
    pass "No native types to test yet";
    exit;
}

plan 9 * @inttypes + 3;

for @inttypes -> $type {
    my ($minval,$maxval) = ::($type).Range.int-bounds;

if $type eq "uint64" {
#?rakudo todo 'getting -1 instead of 18446744073709551615'
    is EVAL("my $type \$var = $maxval; \$var"), $maxval,
      "$type can be $maxval";
} else {
    is EVAL("my $type \$var = $maxval; \$var"), $maxval,
      "$type can be $maxval";
}
    is EVAL("my $type \$var = $minval; \$var"), $minval,
      "$type can be $minval";

if $type eq "uint64" {
#?rakudo.moar 2 skip 'Cannot unbox 65 bit wide bigint into native integer'
    is EVAL("my $type \$var = {$maxval+1}; \$var"), $minval,
      "$type overflows to $minval";
#?rakudo.jvm 1 todo "expected: '18446744073709551615' got: '-1'"
    is EVAL("my $type \$var = {$minval-1}; \$var"), $maxval,
      "$type underflows to $maxval";
} elsif $type eq 'int64' {
    is EVAL("my $type \$var = {$maxval+1}; \$var"), $minval,
      "$type overflows to $minval";
    is EVAL("my $type \$var = {$minval-1}; \$var"), $maxval,
      "$type underflows to $maxval";
} else {
#?rakudo.jvm todo 'wrong overflow'
    is EVAL("my $type \$var = {$maxval+1}; \$var"), $minval,
      "$type overflows to $minval";
#?rakudo.jvm todo 'wrong underflow'
    is EVAL("my $type \$var = {$minval-1}; \$var"), $maxval,
      "$type underflows to $maxval";
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

# RT #127210
{
    class Overlap is repr('CUnion') {
        has uint32 $.u32;
        has uint16 $.u16;
        has uint8  $.u8;
    }
    my $overlap = Overlap.new(u32 => 1234567);
    is $overlap.u32, 1234567, "uint32 in union is unsigned";
    #?rakudo 2 todo 'uint behaves like signed int in CUnion'
    is $overlap.u16,   54919, "uint16 in union is unsigned";
    is $overlap.u8,      135,  "uint8 in union is unsigned";
}

# vim: ft=perl6
