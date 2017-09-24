use v6;
use Test;

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

plan 11 * @inttypes + 4;

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
        is EVAL("my $type \$var = $maxval; \$var++; \$var"), $minval,
          "$type overflows to $minval";
    } elsif $type eq "int64" {
        is EVAL("my $type \$var = $maxval; \$var++; \$var"), $minval,
          "$type overflows to $minval";
    } else {
        #?rakudo.jvm todo 'max overflow to min'
        is EVAL("my $type \$var = $maxval; \$var++; \$var"), $minval,
          "$type overflows to $minval";
    }

    if $type eq "uint64" {
        #?rakudo todo 'getting -1 instead of 0'
        is EVAL("my $type \$var = $minval; \$var--; \$var"), $maxval,
          "$type underflows to $maxval";
    } elsif $type eq "int64" {
        is EVAL("my $type \$var = $minval; \$var--; \$var"), $maxval,
          "$type underflows to $maxval";
    } else {
        #?rakudo.jvm todo 'underflow to max'
        is EVAL("my $type \$var = $minval; \$var--; \$var"), $maxval,
          "$type underflows to $maxval";
    }

    if $type eq "uint64" {
        #?rakudo.jvm todo 'setting to more than max'
        throws-like { EVAL "my $type \$var = {$maxval+1}" },
          Exception,
          "setting $type to more than $maxval throws";
    } else {
        # XXX TODO: merge this if/else into one test once the fudge isn't needed
        if $type eq 'int64' {
            #?rakudo.jvm todo 'setting more than max throws'
            throws-like { EVAL "my $type \$var = {$maxval+1}" },
              Exception,
              "setting $type to more than $maxval throws";
        }
        else {
            #?rakudo todo 'setting more than max throws'
            throws-like { EVAL "my $type \$var = {$maxval+1}" },
              Exception,
              "setting $type to more than $maxval throws";
        }
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

# RT #131529
{
    is byte.Range.int-bounds, (0, 255), "byte.Range works";
}

# vim: ft=perl6 expandtab sw=4
