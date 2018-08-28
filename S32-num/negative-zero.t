use v6;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;
plan 20;

=begin pod

Tests for correct handling of negative zeros

=end pod

sub is-neg-zero ($v, $desc) {
    # atan2 is sensitive to the sign of the zero; use it as a way to determine
    # which zero we got from val()
    is-approx atan2($v, -1e0), -π, $desc;
}



subtest 'sprintf formats' => {
    plan 6;

    is-deeply sprintf('%f', -0e0), '-0.000000',     'sub, %f, -0e0';
    is-deeply sprintf('%e', -0e0), '-0.000000e+00', 'sub, %e, -0e0';
    is-deeply sprintf('%g', -0e0), '-0',            'sub, %g, -0e0';
    is-deeply '%f'.sprintf( -0e0), '-0.000000',     'method, %f, -0e0';
    is-deeply '%e'.sprintf( -0e0), '-0.000000e+00', 'method, %e, -0e0';
    is-deeply '%g'.sprintf( -0e0), '-0',            'method, %g, -0e0';
}

# RT#128897
{
    is-neg-zero val(<-0e0>), 'val() negative zero, U+002D minus';
    is-neg-zero val(<−0e0>), 'val() negative zero, U+2212 minus';
    is-neg-zero '-0e0'.Num,  'Str.Num gives neg. zero, U+002D minus';
    is-neg-zero '−0e0'.Num,  'Str.Num gives neg. zero, U+2212 minus';
    is-neg-zero   '-0'.Num,  'Str.Num gives neg. zero (non-num str), U+002D';
    is-neg-zero   '−0'.Num,  'Str.Num gives neg. zero (non-num str), U+2212';
}

subtest 'cmp on num zeros' => {
    plan 12;

    is-deeply ( 0e0 cmp -0e0), Same, ' 0e0 cmp -0e0';
    is-deeply (-0e0 cmp  0e0), Same, '-0e0 cmp  0e0';
    is-deeply (-0e0 cmp -0e0), Same,  '-0e0 cmp -0e0';
    is-deeply ( 0e0 cmp  0e0), Same,  ' 0e0 cmp  0e0';

    my num $nz = -0e0;
    my num $pz =  0e0;
    is-deeply ( $pz cmp  $nz), Same, ' 0e0 cmp -0e0, native nums';
    is-deeply ( $nz cmp  $pz), Same, '-0e0 cmp  0e0, native nums';
    is-deeply ( $nz cmp  $nz), Same,  '-0e0 cmp -0e0, native nums';
    is-deeply ( $pz cmp  $pz), Same,  ' 0e0 cmp  0e0, native nums';

    is-deeply (  0e0 cmp  $nz), Same, ' 0e0 cmp -0e0 (native)';
    is-deeply (  $nz cmp  0e0), Same, '-0e0 (native) cmp  0e0';
    is-deeply (  $pz cmp -0e0), Same, ' 0e0 (native) cmp -0e0';
    is-deeply ( -0e0 cmp  $pz), Same, '-0e0 cmp  0e0 (native)';
}


# RT #128395
subtest 'infix:<===> on num zeros' => {
    plan 12;

    is-deeply ( 0e0 === -0e0), False, ' 0e0 === -0e0';
    is-deeply (-0e0 ===  0e0), False, '-0e0 ===  0e0';
    is-deeply (-0e0 === -0e0), True,  '-0e0 === -0e0';
    is-deeply ( 0e0 ===  0e0), True,  ' 0e0 ===  0e0';

    my num $nz = -0e0;
    my num $pz =  0e0;
    is-deeply ( $pz ===  $nz), False, ' 0e0 === -0e0, native nums';
    is-deeply ( $nz ===  $pz), False, '-0e0 ===  0e0, native nums';
    is-deeply ( $nz ===  $nz), True,  '-0e0 === -0e0, native nums';
    is-deeply ( $pz ===  $pz), True,  ' 0e0 ===  0e0, native nums';

    is-deeply (  0e0 ===  $nz), False, ' 0e0 === -0e0 (native)';
    is-deeply (  $nz ===  0e0), False, '-0e0 (native) ===  0e0';
    is-deeply (  $pz === -0e0), False, ' 0e0 (native) === -0e0';
    is-deeply ( -0e0 ===  $pz), False, '-0e0 ===  0e0 (native)';
}

# RT #128999
subtest 'infix:<===> on complex zeros' => {
    plan 16;

    is-deeply <-0-0i> === <-0-0i>, True,  '-0-0i === -0-0i';
    is-deeply <-0-0i> === <+0-0i>, False, '-0-0i === +0-0i';
    is-deeply <-0-0i> === <-0+0i>, False, '-0-0i === -0+0i';
    is-deeply <-0-0i> === <+0+0i>, False, '-0-0i === +0+0i';

    is-deeply <+0-0i> === <-0-0i>, False, '+0-0i === -0-0i';
    is-deeply <+0-0i> === <+0-0i>, True,  '+0-0i === +0-0i';
    is-deeply <+0-0i> === <-0+0i>, False, '+0-0i === -0+0i';
    is-deeply <+0-0i> === <+0+0i>, False, '+0-0i === +0+0i';

    is-deeply <-0+0i> === <-0-0i>, False, '-0+0i === -0-0i';
    is-deeply <-0+0i> === <+0-0i>, False, '-0+0i === +0-0i';
    is-deeply <-0+0i> === <-0+0i>, True,  '-0+0i === -0+0i';
    is-deeply <-0+0i> === <+0+0i>, False, '-0+0i === +0+0i';

    is-deeply <+0+0i> === <-0-0i>, False, '+0+0i === -0-0i';
    is-deeply <+0+0i> === <+0-0i>, False, '+0+0i === +0-0i';
    is-deeply <+0+0i> === <-0+0i>, False, '+0+0i === -0+0i';
    is-deeply <+0+0i> === <+0+0i>, True,  '+0+0i === +0+0i';
}

subtest 'Stringification of Complex handles signed zeros' => {
    plan 12;
    cmp-ok <-0-0i>.perl.EVAL, '===', <-0-0i>, '<-0-0i>.perl';
    cmp-ok <-0+0i>.perl.EVAL, '===', <-0+0i>, '<-0+0i>.perl';
    cmp-ok <+0-0i>.perl.EVAL, '===',  <0-0i>, '<+0-0i>.perl';
    cmp-ok <+0+0i>.perl.EVAL, '===',  <0+0i>, '<+0+0i>.perl';

    is-deeply <-0-0i>.gist, '-0-0i',   '<-0-0i>.gist';
    is-deeply <-0+0i>.gist, '-0+0i',   '<-0+0i>.gist';
    is-deeply <+0-0i>.gist,  '0-0i',   '<+0-0i>.gist';
    is-deeply <+0+0i>.gist,  '0+0i',   '<+0+0i>.gist';

    is-deeply <-0-0i>.Str,  '-0-0i',   '<-0-0i>.Str';
    is-deeply <-0+0i>.Str,  '-0+0i',   '<-0+0i>.Str';
    is-deeply <+0-0i>.Str,   '0-0i',   '<+0-0i>.Str';
    is-deeply <+0+0i>.Str,   '0+0i',   '<+0+0i>.Str';
}

{ # https://irclog.perlgeek.de/perl6/2017-01-20#i_13959538
    my $a =  0e0;
    my $b = -0e0;
    is-deeply $a  eqv $b,   False, '-0e0 eqv 0e0 when stored in variables';
    is-deeply 0e0 eqv -0e0, False, '-0e0 eqv 0e0 when using literals';
    is-deeply (my num $ = 0e0) eqv (my num $ = -0e0), False,
        '-0e0 eqv 0e0 when using native nums';
}

{ # https://github.com/MoarVM/MoarVM/pull/526
    is-deeply abs(       $ = -0e0),  0e0, 'abs(-0e0) == 0e0 when stored in variables [sub]';
    is-deeply abs(           -0e0),  0e0, 'abs(-0e0) == 0e0 when using literals [sub]';
    is-deeply abs(my num $ = -0e0),  0e0, 'abs(-0e0) == 0e0 when using native nums [sub]';

    is-deeply (       $ = -0e0).abs, 0e0, 'abs(-0e0) == 0e0 when stored in variables [method]';
    is-deeply (           -0e0).abs, 0e0, 'abs(-0e0) == 0e0 when using literals [method]';
    is-deeply (my num $ = -0e0).abs, 0e0, 'abs(-0e0) == 0e0 when using native nums [method]';
}
