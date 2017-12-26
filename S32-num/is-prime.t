use v6;
use Test;
plan 40;

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

ok  is-prime(2.0),   'correct coersion (Rat)';
ok  is-prime(2e0),   'correct coersion (Num)';
ok  is-prime('2.0'), 'correct coersion (Str)';
nok is-prime(2.5),   'decimal numbers are not prime (Rat)';
nok is-prime(2e5),   'decimal numbers are not prime (Num)';
nok is-prime(-2),    'negative numbers are not prime';
