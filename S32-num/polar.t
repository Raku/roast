use v6;
use Test;
plan 48;

# L<S32::Numeric/Complex/"=item polar">

=begin pod

#Basic tests for polar()

=end pod

my $sq2 = 2.sqrt;
sub check_polar($complex, $magnitude_want, $angle_want) {
   my ($magnitude, $angle) = $complex.polar;
   is-approx($magnitude, $magnitude_want, "$complex has a magnitude of $magnitude_want");
   is-approx($angle, $angle_want, "$complex has an angle of $angle_want");
}

# reference angles
{
   check_polar( 1+0i, 1   , 0         );
   check_polar( 1+1i, $sq2, pi/4      );
   check_polar( 0+1i, 1   , pi/2      );
   check_polar(-1+1i, $sq2, pi/4+pi/2 );
   check_polar(-1+0i, 1   , pi        );
   check_polar(-1-1i, $sq2, -pi+pi/4  );
   check_polar( 0-1i, 1   , -pi/2     );
   check_polar( 1-1i, $sq2, -pi/4     );
}

# ints
{
   check_polar( 4+0i, 4      , 0         );
   check_polar( 2+5i, 5.38516, 1.19028995);
   check_polar( 0+9i, 9      , pi/2      );
   check_polar(-3+2i, 3.60555, 2.55359005);
   check_polar(-9+0i, 9      , pi        );
   check_polar(-4-7i, 8.06226, -2.0899424);
   check_polar( 0-6i, 6      , -pi/2     );
   check_polar( 7-6i, 9.21954, -0.7086263);
}

# rats
{
   check_polar( 9.375+0i    , 9.375   , 0         );
   check_polar( 4.302+8.304i, 9.352198, 1.09280250);
   check_polar( 0+    2.631i, 2.631   , pi/2      );
   check_polar(-4.175+6.180i, 7.458085, 2.16493496);
   check_polar(-8.087+0i    , 8.087   , pi        );
   check_polar(-9.191-4.810i, 10.37355, -2.6594494);
   check_polar( 0-    0.763i, 0.763   , -pi/2     );
   check_polar( 9.927-5.192i, 11.20277, -0.4818920);
}

# vim: ft=perl6
