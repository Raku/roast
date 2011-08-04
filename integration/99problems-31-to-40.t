use v6;
use Test;
plan 67;

{
    # P31 (**) Determine whether a given integer number is prime.
    # 
    # Example:
    # * (is-prime 7)
    # T
    
    # Very Naive implementation and 
    # could probably use something like: 
    #  subset Divisible::Int of Int where { $_ > 1 };
    #  sub is_prime(Divisible::Int $num) {
    # but "subset" is not working yet.
    
    sub is_prime(Int $num) returns Bool {
        
        # 0 and 1 are not prime by definition
        return Bool::False if $num < 2;
        
        # 2 and 3 are
        return Bool::True  if $num < 4;
    
        # no even number is prime
        return Bool::False if $num % 2 == 0;
    
        # let's try what's left
        my $max=floor(sqrt($num));
    
        # we could use
        #  for  3 ... *+2, $max -> $i {
        # but it doesn't seem to work yet
        loop (my $i=3; $i <= $max ; $i+=2) {
            return Bool::False if $num % $i == 0;
        }
        return Bool::True;
    }
    
    ok !is_prime(0), "We should find that 0 is not prime";
    ok !is_prime(1), ".. and neither is 1";
    ok  is_prime(2), ".. 2 is prime";
    ok  is_prime(3), ".. 3 is prime";
    ok !is_prime(4), ".. 4 is not";
    ok  is_prime(5), ".. 5 is prime";
    ok !is_prime(6), ".. 6 is even, thus not prime";
    ok !is_prime(15), ".. 15 is product of two primes, but not prime";
    ok  is_prime(2531), ".. 2531 is a larger prime";
    ok !is_prime(2533), ".. 2533 is not";
}

{
    # P32 (**) Determine the greatest common divisor of two positive 
    # integer numbers.
    # 
    # Use Euclid's algorithm.
    # Example:
    # * (gcd 36 63)
    # 9
    
    # Makes sense to declare types since gcd makes sense only for Ints.
    # Yet, it should be possible to define it even for commutative rings
    # other than Integers, so we use a multi sub.
    
    multi sub gcd(Int $a, Int $b){
        return $a if $b == 0;
        return gcd($b,$a % $b);
    }

    is gcd(36,63), 9, "We should be able to find the gcd of 36 and 63";
    is gcd(63,36), 9, ".. and viceversa";
    is gcd(0,5)  , 5, '.. and that gcd(0,$x) is $x';
    is gcd(0,0)  , 0, '.. even when $x is 0';
}

{
    # P33 (*) Determine whether two positive integer numbers are coprime.
    # 
    # Two numbers are coprime if their greatest common divisor equals 1.
    # Example:
    # * (coprime 35 64)
    # T

    sub coprime(Int $a, Int $b) { $a gcd $b == 1}
    ok  coprime(35,64), "We should be able to tell that 35 and 64 are coprime";
    ok  coprime(64,35), ".. and viceversa";
    ok !coprime(13,39), ".. but 13 and 39 are not";
}

{
    sub totient_phi(Int $num) {
        +grep({$_ gcd $num == 1}, 1 .. $num);
    }

    # TODO: s/my/constant/
    my @phi = *,1,1,2,2,4,2,6,4,6,4,10,4,12,6,8,8,16,6,18,8;

    # from Sloane OEIS A000010
    for 1..20 -> $n {
        is @phi[$n], totient_phi($n), "totient of $n is @phi[$n]";
    }
}

{
    # P35 (**) Determine the prime factors of a given positive integer.
    #
    # Construct a flat list containing the prime factors in ascending order.
    # Example:
    # * (prime-factors 315)
    # (3 3 5 7)
    sub prime_factors($n is copy) {
        my @factors;

        my $cand = 2;
        while ($n > 1) {
            if $n % $cand == 0 {
                @factors.push($cand);
                $n /= $cand;
            }
            else {
                $cand++;
            }
        }
        return @factors
    }

    is prime_factors(315), (3,3,5,7), 'prime factors of 315 are 3,3,5,7';
}

#?rakudo skip 'nom regression - cannot see prime_factors_mult'
#?DOES 5
{
    # P36 (**) Determine the prime factors of a given positive integer (2).
    # 
    # Construct a list containing the prime factors and their multiplicity.
    # Example:
    # * (prime-factors-mult 315)
    # ((3 2) (5 1) (7 1))
    # 
    # Hint: The problem is similar to problem P13.
    
    our sub prime_factors_mult(Int $n is copy){
      return () if $n == 1;
      my $count = 0;
      my $cond = 2;
      return gather {
        while $n > 1 {
          if $n % $cond == 0 {
    	$count++;
    	$n div= $cond;
          }
          else {
    	if $count > 0 {
    	  take [$cond,$count];
    	  $count = 0;
    	}
    	$cond++;
          }
        }
        take [$cond,$count];
      }
    }
    is prime_factors_mult(1),(), "We ignore 1";
    is prime_factors_mult(2),([2,1]), "We get prime numbers prime";
    is prime_factors_mult(4),([2,2]),  ".. and multiplicity right";
    is prime_factors_mult(12),([2,2],[3,1]), ".. and products of primes";
    is prime_factors_mult(315),([3,2],[5,1],[7,1]), ".. and ignore multiplicity 0"
}

#?rakudo skip 'nom regression - cannot see prime_factors_mult'
#?DOES 20
{
    # P37 (**) Calculate Euler's totient function phi(m) (improved).
    # 
    # See problem P34 for the definition of Euler's totient function. If the list of
    # the prime factors of a number m is known in the form of problem P36 then the
    # function phi(m) can be efficiently calculated as follows: Let ((p1 m1) (p2 m2)
    # (p3 m3) ...) be the list of prime factors (and their multiplicities) of a given
    # number m. Then phi(m) can be calculated with the following formula:
    # 
    # phi(m) = (p1 - 1) * p1 ** (m1 - 1) + (p2 - 1) * p2 ** (m2 - 1) + (p3 - 1) * p3 ** (m3 - 1) + ...
    # 
    # Note that a ** b stands for the b'th power of a.
    
    # This made me mad, the above formula is wrong
    # where it says + it should be *
    # based on the fact that
    #  phi(prime**m)=prime**(m-1)*(prime-1)
    # and
    #  some_number=some_prime**n * some_other_prime**m * ....
     
    sub phi($n) {
      my $result=1;
      
      # XXX - I think there is a way of doing the unpacking + assignment 
      # in one step but don't know how
    
      for prime_factors_mult($n) -> @a  {
        my ($p,$m) = @a;
        $result *= $p ** ($m - 1) * ($p - 1);
      }
      $result;
    }
    
    
    my @phi = *,1,1,2,2,4,2,6,4,6,4,10,4,12,6,8,8,16,6,18,8;

    for 1..20 -> $n {
        is phi($n), @phi[$n], "totient of $n is {@phi[$n]}";
    }
}

{
    # P38 (*) Compare the two methods of calculating Euler's totient function.
    # 
    # Use the solutions of problems P34 and P37 to compare the algorithms. Take the
    # number of logical inferences as a measure for efficiency. Try to calculate
    # phi(10090) as an example.

    skip 'No Benchmark module yet', 1
}

#?rakudo skip 'nom regression - need ceiling'
#?DOES 2
{
    # P39 (*) A list of prime numbers.
    #
    # Given a range of integers by its lower and upper limit, construct a list of all
    # prime numbers in that range.
    
    our sub primes($from, $to) {
        my @p = (2);
        for 3..$to -> $x {
            push @p, $x unless grep { $x % $_ == 0 }, 2..ceiling sqrt $x;
        }
        grep { $_ >= $from }, @p;
    }
    
    is primes(2,11), (2,3,5,7,11), "a few.";
    is primes(16,100), (17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97), "a few more.";
}

#?rakudo skip 'nom regression - cannot see primes'
#?DOES 1
{
    # P40 (**) Goldbach's conjecture.
    #
    # Goldbach's conjecture says that every positive even number greater than 2 is
    # the sum of two prime numbers. Example: 28 = 5 + 23. It is one of the most
    # famous facts in number theory that has not been proved to be correct in the
    # general case. It has been numerically confirmed up to very large numbers (much
    # larger than we can go with our Prolog system). Write a predicate to find the
    # two prime numbers that sum up to a given even integer.
    #
    # Example:
    # * (goldbach 28)
    # (5 23)
    
    sub goldbach($n) {
        my @p = primes(1, $n-1);
        for @p -> $x {
            for @p -> $y {
                return ($x,$y) if $x+$y == $n;
            }
        }
    }
    
    is goldbach(28), (5, 23), "Goldbach works.";
}

# vim: ft=perl6
