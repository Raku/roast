use v6;
use Test;

plan 12;

is_approx sin(0), 0, 'sin(0)';
is_approx sin(3.1415927), 0, 'sin(pi)';
is_approx sin(6.2831853), 0, 'sin(2 pi)';

# random numbers
my $rn1 = 4.8758e0;
my $rn2 = 0.60612e0;
is_approx sin($rn1), -0.9866781036e0, 'sin(random number 1)';
is_approx sin($rn2), 0.5696829216e0, 'sin(random number 2)';

is_approx cos(0),            1, 'cos(0)';
is_approx cos(3.1415927),     -1, 'cos(pi)';
is_approx cos(6.2831853),     1, 'cos(2 pi)';
is_approx cos($rn1), 0.1626847248e0, 'cos(random number 1)';
is_approx cos($rn2), 0.8218645683e0, 'cos(random number 2)';

is_approx tan($rn1), -6.0649708e0, 'tan(random number 1)';
is_approx tan($rn2), 6.9315912e-1, 'tan(random number 2)';
