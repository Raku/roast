# http://perl6advent.wordpress.com/2012/12/14/primal-needs/
use v6;
use Test;

plan 6;

sub is-prime-alpha($n) { $n %% none 2..sqrt $n }

my @primes := 2, 3, 5, -> $p { ($p+2, $p+4 ... &is-prime-beta)[*-1] } ... *;
sub is-prime-beta($n) { $n %% none @primes ...^  * > sqrt $n }

sub expmod(Int $a is copy, Int $b is copy, $n) {
    my $c = 1;
    repeat while $b div= 2 {
    	   ($c *= $a) %= $n if $b % 2;
	       ($a *= $a) %= $n;
	       }
	       $c;
}

subset PrimeCandidate of Int where { $_ > 2 and $_ % 2 };
subset Two of Int where { $_ == 2 };

my Bool multi sub is-prime-rm(Int $n, Int $k) is default { return False; }
my Bool multi sub is-prime-rm(2, Int $k)                 { return True; }
my Bool multi sub is-prime-rm(PrimeCandidate $n, Int $k) {
   my Int $d = $n - 1;
   my Int $s = 0;

   while $d %% 2 {
       $d div= 2;
       $s++;
   }

   for (2 ..^ $n).pick($k) -> $a {
       my $x = expmod($a, $d, $n);

       next if $x == 1 or $x == $n - 1;

       for 1 ..^ $s {
	   $x = $x ** 2 mod $n;
	   return False if $x == 1;
	   last if $x == $n - 1;
       }
       return False if $x !== $n - 1;
   }

   return True;
}

my @primes_lt_20 = 2, 3, 5, 7, 11, 13, 17, 19;

# don't check  1. errouneously considered a prime by is-prime-alpha() and
# is-prime-beta()
is_deeply [(2 .. 20).grep({is-prime-alpha($_)})], @primes_lt_20, 'prime (alpha)';
is_deeply [(2 .. 20).grep({is-prime-beta($_)})], @primes_lt_20, 'prime (beta)';
is_deeply [(2 .. 20).grep({is-prime-rm($_, $_)})], @primes_lt_20, 'prime (rabin-miller)';

my $primes_lt_200 = set (@primes_lt_20, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199);
my $primes-beta = set (2 .. 200).grep({is-prime-beta($_)});

is_deeply $primes-beta, $primes_lt_200, 'primes under 200 (beta)';

my $primes-rm = set (2 .. 200).grep({is-prime-rm($_, 3)});
my $is-superset = ($primes-rm (>=) $primes_lt_200);
ok $is-superset, 'primes under 200 (rabin-miller)';

# ... "there is a chance that it will tell you that a number
#     is prime when it actually isn’t"
my $false-positives = ($primes-rm (-) $primes_lt_200);
ok $false-positives <= 4, 'accuracy (rabin-miller)';

