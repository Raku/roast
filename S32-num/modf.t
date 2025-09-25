use Test;
# L<S32::Numeric/Numeric/"=item modf">

#plan 244;
#plan 4;
#plan 20;

my $debug = 0;

# test values and data defined in the BEGIN block below
my @n;
my $i;

sub test-routine($val, $exp-int, $exp-frac, , $places, :$test-sign!) {
}
sub test-method($val, $exp-int, $exp-frac, , $places, :$test-sign!) {
}

# test the internal subs with positive data
$i = 0;
for @n -> ($val is copy, $exp-int is copy, $exp-frac is copy, $places) {
    ++$i;

    # raw data are originally Cool strings with leading minus signs
    my $test-sign = +1;
    test-helpers($val, $exp-int, $exp-frac, , $places, :$test-sign!) {
}

# test the internal subs with negative data
$i = 0;
for @n -> ($val is copy, $exp-int is copy, $exp-frac is copy, $places) {
    ++$i;
    my $test-sign = -1;
    test-helpers($val, $exp-int, $exp-frac, , $places, :$test-sign!) {
}



=begin comment

next;

    note "DEBUG: item $i val = '$val', int = '$Int'. frac = '$Frac', places = '$places'" if $debug;
    my $s = _num2str $val;
    cmp-ok $s, '~~', Str;
    note "DEBUG: item $i val = '$val', _num2str = '$s', str2num '{$s.Num}'" if $debug;

#    next;

    my $I = $Int.Str;
    my $F = $Frac.Str;
    my $P = $places.Str;

    cmp-ok $val, '~~', Str;
    cmp-ok $I, '~~', Str;
    cmp-ok $F, '~~', Str;
    cmp-ok $P, '~~', Str;

    $val = $val.Real;
    if $val ~~ Rational {
        $val = $val.base(10, *);
    }
    else {
        $val = $val.base(10, $places);
    }

    my ($left, $right) = _modf-str $val;
    note "DEBUG: val = '$val', base(10) = '$left'" if $debug;
    is $left, $I;
    is $right, $F;

}
=end comment

done-testing;

=begin comment
# test the routine
#for @n -> ($val is copy, $Int is copy, $Frac is copy, $places) {
for %n.kv -> $val is copy, $arr {
    my $int-part  = @($arr)[0];
    my $frac-part = @($arr)[1];
    my $places    = @($arr)[2];

    # check the negative values
    my ($int, $frac) = modf $val;
    is $int, $int-part, "modf($val), int: expected $int-part, got $int";
    is-approx $frac, $frac-part, "modf($val), approx frac: expected $frac-part, got $frac";

    # using places for exact frac match
    ($int, $frac) = modf $val, $places;
    is $frac, $frac-part, "modf($val, $places), exact frac: expected $frac-part, got $frac";

    # check the positive values
    $val       .= abs;
    $int-part  .= abs;
    $frac-part .= abs;

    ($int, $frac) = modf $val;
    is $int, $int-part, "modf($val), int: expected $int-part, got $int";
    is-approx $frac, $frac-part, "modf($val), approx frac: expected $frac-part, got $frac";

    # using places for exact frac match
    ($int, $frac) = modf $val, $places;
    is $frac, $frac-part, "modf($val, $places), exact frac: expected $frac-part, got $frac";
}

# test the method
#for @n -> ($val is copy, $Int is copy, $Frac is copy, $places) {
for %n.kv -> $val is copy, $arr {
    $val .= Real;

    my $int-part  = @($arr)[0];
    my $frac-part = @($arr)[1];
    my $places    = @($arr)[2];

    # check the negative values
    my ($int, $frac) = $val.modf;
    is $int, $int-part, "$val.modf(), int: expected $int-part, got $int";
    is-approx $frac, $frac-part, "modf($val), approx frac: expected $frac-part, got $frac";

    # using places for exact frac match
    ($int, $frac) = $val.modf($places);
    is $frac, $frac-part, "$val.modf($places), exact frac: expected $frac-part, got $frac";

    # check the positive values
    $val       .= abs;
    $int-part  .= abs;
    $frac-part .= abs;

    ($int, $frac) = $val.modf;
    is $int, $int-part, "$val.modf(), int: expected $int-part, got $int";
    is-approx $frac, $frac-part, "modf($val), approx frac: expected $frac-part, got $frac";

    # using places for exact frac match
    ($int, $frac) = $val.modf($places);
    is $frac, $frac-part, "$val.modf($places), exact frac: expected $frac-part, got $frac";
}
=end comment

sub test-helpers($val, $exp-int, $exp-frac, , $places, :$test-sign!) {
    
}

sub test-routine($val, $exp-int, $exp-frac, , $places, :$test-sign!) {
}
sub test-method($val, $exp-int, $exp-frac, , $places, :$test-sign!) {
}

sub _num2str(Cool $n is copy --> Str) {
    #===========================================================
    # THIS SUB IS DUPLICATED IN CORE AND ROAST AND MUST REMAIN
    # IDENTICAL IN BOTH PLACES. THE TWO FILES CONTAINING IT ARE:
    #   repo https://github.com/rakudo/rakudo/src/core.*/Num.pm6
    #   repo https://github.com/Raku/roast/S32-Num/modf.t
    #===========================================================

    # the incoming value a string representing a number
    my $s = $n.Str;
    given $s {
        when /^ <[+-]>? \d* '.' \d* $/ {
            # base 10 rational as string
            # use as is
        }
        when /^ :i <[+-]>? 0 <[box]> <[abcde\d]>* '.' <[abcde\d]>* $/ {
            # base 2, 8, or 16 rational as string
            # use base 10,*
            $s = $s.Num.base(10, *)
        }
        when /:i e/ {
            # 1.3e-1
            # use base, but how many places?
            $s = $s.Num.base(10, 15)
        }
        when /:i '/' / {
            # 1/3
            # rational as string
            # use base 10,*
            $s = $s.Num.base(10, *)
        }
        when $s.Numeric ~~ Int  {
            $s = $s.Num.base(10)
        }
        default {
            note "|--  DEBUG: incoming, unhandled value '$n' is type '{$n.^name}'";
        }
    }
    $s
}

sub _modf-str(Str $s is copy, $places? --> List) {
    #===========================================================
    # THIS SUB IS DUPLICATED IN CORE AND ROAST AND MUST REMAIN
    # IDENTICAL IN BOTH PLACES. THE TWO FILES CONTAINING IT ARE:
    #   repo https://github.com/rakudo/rakudo/src/core.*/Num.pm6
    #   repo https://github.com/Raku/roast/S32-Num/modf.t
    #===========================================================

    # the incoming string was a number converted to
    # an integer OR a decimal number

    # check for the sign, if any
    my $sign = '';
    if $s ~~ /^ (<[+-]>) (.*) $/ {
        $sign = ~$0;
        $s    = ~$1;
    }

    my ($left, $right);
    my $idx = index $s, '.';
    if $idx.defined {
        $left  = $s.substr: 0, $idx;
        $right = $s.substr: $idx+1; # do NOT keep the decimal point here

        # get the length of the bare right side
        my $nr-chars = $right.chars;
        # now embellish it
        $right = '0.' ~ $right;

        if $sign {
            $left  = $sign ~ $left;
            $right = $sign ~ $right;
        }
        # pad right with zeroes if need be
        # note we do NOT trim any chars if right is too long
        if $places.defined and $places > $nr-chars {
            my $n = $places - $nr-chars;
            $right ~= ('0' x $n);
        }
        $right = _trim-zeroes $right;

        $left  = '0' if $left.Num == 0;
        $right = '0' if $right.Num == 0;
    }
    else {
        $left = $s;
        note "DEBUG dotless left: '$left'" if $debug;
        $left  = $sign ?? ($sign ~ $left) !! $left;
        $left  = '0' if $left.Num == 0;
        $right = '0';
    }
    $left, $right
} # sub _modf-str

sub _trim-zeroes(Str $x is copy --> Str) {
    #===========================================================
    # THIS SUB IS DUPLICATED IN CORE AND ROAST AND MUST REMAIN
    # IDENTICAL IN BOTH PLACES. THE TWO FILES CONTAINING IT ARE:
    #   repo https://github.com/rakudo/rakudo/src/core.*/Num.pm6
    #   repo https://github.com/Raku/roast/S32-Num/modf.t
    #===========================================================
     
    # the incoming string may have a decimal point. if
    # so, leave it
    while $x ~~ /<[.1..9]>0$/ {
        note "DEBUG before trim '$x'";
        $x ~~ s/0$//;
        note "DEBUG  after trim '$x'";
    }
    $x
} # sub _trim-zeroes

BEGIN {

    @n =
    # 27 elements

    #=== two cases reported by reviewers:
    # possible problem child:
    ['-6.2'                 , -6,                    -0.2000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000, 100],
    # okay tests
    ['-123456789123456789.6', -123456789123456789,   -0.6,              1],

    #=== other possible problem children:
    ['-1.5e-10'             ,  0,                    -0.000_000_000_15, 11],
    ['-123457e-3'           , -123,                  -0.457,            3],

    # okay tests
    ['-0x10.1'              , -16,                   -0.0625,           4],
    ['-0o10.1'              , -8,                    -0.125,            3],
    ['-0xa.1'               , -10,                   -0.0625,           4],
    ['-0b10.1'              , -2,                    -0.5,              1],
    ['-0b10'                , -2,                     0,                0],
    ['-10'                  , -10,                    0,                0],
    ['-0x10'                , -16,                    0,                0],
    ['-0o10'                , -8,                     0,                0],
    ['-0xa'                 , -10,                    0,                0],
    ['-0o127'               , -87,                    0,                0],
    ['-100'                 , -100,                   0,                0],
    ['-5.9'                 , -5,                    -0.9,              1],
    ['-5.499'               , -5,                    -0.499,            3],
    ['-2'                   , -2,                     0,                0],
    ['-3/2'                 , -1,                    -0.5,              1],
    ['-1.5e0'               , -1,                    -0.5,              1],
    ['-1.4999'              , -1,                    -0.4999,           4],
    ['-1.23456'             , -1,                    -0.23456,          5],
    ['-1'                   , -1,                     0,                0],
    ['-0.5'                 ,  0,                    -0.5,              1],
    ['-0.499'               ,  0,                    -0.499,            3],
    ['-0.1'                 ,  0,                    -0.1,              1],
    ['-0'                   ,  0,                     0,                0],
    ;
}

# vim: expandtab shiftwidth=4
