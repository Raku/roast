use v6;
use Test;
plan 27;

# L<S32::Numeric/Numeric/"=item is-prime">

=begin pod

Basic tests for the is-prime() builtin

=end pod

is (1..100).grep(*.is-prime), 
   (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97),
   "Method form gets primes < 100 correct";
is (1..100).grep({ is-prime($_) }), 
  (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97),
  "Sub form gets primes < 100 correct";

for (2801, 104743, 105517, 1300129, 15485867, 179424691, 32416187773) -> $prime {
    ok $prime.is-prime,  "$prime is a prime (method)";
    ok is-prime($prime), "$prime is a prime (sub)";
}

for (0, 32416187771, 32416187772, 32416187775) -> $composite {
    nok $composite.is-prime,  "$composite is not a prime (method)";
    nok is-prime($composite), "$composite is not a prime (sub)";
}

ok  170141183460469231731687303715884105727.is-prime, "170141183460469231731687303715884105727 is prime";
nok 170141183460469231731687303715884105725.is-prime, "170141183460469231731687303715884105725 is not prime";
ok 6864797660130609714981900799081393217269435300143305409394463459185543183397656052122559640661454554977296311391480858037121987999716643812574028291115057151.is-prime, "M13 is prime";