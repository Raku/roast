use Test;

# L<S32::Numeric/Numeric/"=item modf">

plan 240;

my %n =
    '-123457e-3' => [-123, -0.457,            3],
    '-10'        => [-10,   0,                0],
    '-0x10'      => [-16,   0,                0],
    '-0o10'      => [-8,    0,                0],
    '-0xa'       => [-10,   0,                0],
    '-0o127'     => [-87,   0,                0],
    '-100'       => [-100,  0,                0],
    '-5.9'       => [-5,   -0.9,              1],
    '-5.499'     => [-5,   -0.499,            3],
    '-2'         => [-2,    0,                0],
    '-3/2'       => [-1,   -0.5,              1],
    '-1.5e0'     => [-1,   -0.5,              1],
    '-1.4999'    => [-1,   -0.4999,           4],
    '-1.23456'   => [-1,   -0.23456,          5],
    '-1'         => [-1,    0,                0],
    '-0.5'       => [ 0,   -0.5,              1],
    '-0.499'     => [ 0,   -0.499,            3],
    '-0.1'       => [ 0,   -0.1,              1],
    '-0'         => [ 0,    0,                0],
    '-1.5e-10'   => [ 0,   -0.000_000_000_15, 11], # -0.000_000_000_15
;


# test the routine
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
    $int-part .= abs;
    $frac-part .= abs;

    ($int, $frac) = modf $val;
    is $int, $int-part, "modf($val), int: expected $int-part, got $int";
    is-approx $frac, $frac-part, "modf($val), approx frac: expected $frac-part, got $frac";

    # using places for exact frac match
    ($int, $frac) = modf $val, $places;
    is $frac, $frac-part, "modf($val, $places), exact frac: expected $frac-part, got $frac";
}

# test the method
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
    $int-part .= abs;
    $frac-part .= abs;

    ($int, $frac) = $val.modf;
    is $int, $int-part, "$val.modf(), int: expected $int-part, got $int";
    is-approx $frac, $frac-part, "modf($val), approx frac: expected $frac-part, got $frac";

    # using places for exact frac match
    ($int, $frac) = $val.modf($places);
    is $frac, $frac-part, "$val.modf($places), exact frac: expected $frac-part, got $frac";
}

# vim: expandtab shiftwidth=4
