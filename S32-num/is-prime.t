use v6;
use Test;
plan 37;

# L<S32::Numeric/Numeric/"=item is-prime">

=begin pod

Basic tests for the is-prime() builtin

=end pod

# I know the all the 45724385972894572891 tests seem repetitious, but
# I am seeing inconsistent results on my Rakudo build, and I am hoping
# these repeated tests might help track it down.

nok 45724385972894572891.is-prime, "45724385972894572891 is not prime";
nok 45724385972894572891.is-prime, "45724385972894572891 is still not prime";
nok 45724385972894572891.is-prime, "45724385972894572891 is still not prime";
nok 45724385972894572891.is-prime, "45724385972894572891 is still not prime";

subtest 'all primes < 100' => {
    plan 2;
    my $expected := 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53,
        59, 61, 67, 71, 73, 79, 83, 89, 97;
    is-deeply (1..100).grep(*.is-prime),    $expected.Seq, 'method form';
    is-deeply (1..100).grep({is-prime $_}), $expected.Seq, 'sub form';
}

nok 45724385972894572891.is-prime, "45724385972894572891 is still not prime";
nok 45724385972894572891.is-prime, "45724385972894572891 is still not prime";
nok 45724385972894572891.is-prime, "45724385972894572891 is still not prime";
nok 45724385972894572891.is-prime, "45724385972894572891 is still not prime";

for 2801, 104743, 105517, 1300129, 15485867, 179424691, 32416187773 -> $prime {
    is-deeply $prime.is-prime,  True, "$prime is a prime (method)";
    is-deeply is-prime($prime), True, "$prime is a prime (sub)";
}

for 0, 32416187771, 32416187772, 32416187775 -> $composite {
    is-deeply $composite.is-prime,  False, "$composite is not a prime (method)";
    is-deeply is-prime($composite), False, "$composite is not a prime (sub)";
}

is-deeply 170141183460469231731687303715884105727.is-prime, True,
    "170141183460469231731687303715884105727 is prime";
is-deeply 170141183460469231731687303715884105725.is-prime, False,
    "170141183460469231731687303715884105725 is not prime";
is-deeply 6864797660130609714981900799081393217269435300143305409394463459185543183397656052122559640661454554977296311391480858037121987999716643812574028291115057151.is-prime,
    True, 'M13 is prime';

subtest 'coersion from different types' => {
    my @prime    := '2.0', 3, <5>,  2.0, <3.0>,  5e0, <2e0>, <3+0i>, <5+0i >,
        FatRat.new(2,1), FatRat.new(6,2);
    my @un-prime := '4.0', 6, <8>,  4.0, <6.0>,  8e0, <4e0>, <6+0i>, <8+0i >,
        '2.1', 2.3, <3.4>,  5.1e0, <2.7e0>, <3.8+0i>, <5.3+0i >, <3.8e0+0i>,
        <5.3e0+0i >, '-4.0', '−4.0', -6, <-8>,  -4.0, <-6.0>,  -8e0, <-4e0>,
        <-6+0i>, <-8+0i >, FatRat.new(4,1), FatRat.new(12,2);
    plan 2*(@prime + @un-prime);

    for @prime {
        my $desc := "{.raku} {.^name} is prime";
        is-deeply  is-prime($_), True, "$desc (sub form)";
        is-deeply .is-prime,     True, "$desc (method form)";
    }
    for @un-prime {
        my $desc := "{.raku} {.^name} is NOT prime";
        is-deeply  is-prime($_), False, "$desc (sub form)";
        is-deeply .is-prime,     False, "$desc (method form)";
    }
}

subtest 'Complex.is-prime with Complex that cannot be Real throw' => {
    plan 2*my @tests := <3-3i >, <2+5i>, <-3-3i >, <-2+5i>, <0+31337i>;
    for @tests {
        throws-like { .is-prime    }, X::Numeric::Real, "{.raku} (method form)";
        throws-like {  is-prime $_ }, X::Numeric::Real, "{.raku} (sub form)";
    }
}

is-deeply is-prime(-2), False, 'negative numbers are *not* prime';

# vim: expandtab shiftwidth=4
