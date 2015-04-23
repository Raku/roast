use v6;
use Test;
plan 8;

# Problem 2
is do { [+] grep * %% 2, (1, 2, *+* ...^ * > 4_000_000) }, 4613732, 'fibonacci';

sub largest-prime-factor($n is copy) {
    for 2, 3, *+2 ... * {
        while $n %% $_ {
            $n div= $_;
            return $_ if $_ > $n;
        }
    }
}

# Problem 3
is largest-prime-factor(600_851_475_143), 6857, 'largest prime factor';

# Problem 53
is_deeply do {
    [1], -> @p { [0, @p Z+ @p, 0] } ... * #    generate Pascal's triangle
        ==> (*[0..100])()                     # get rows up to n = 100
        ==> map *.list                        # flatten rows into a single list
        ==> grep * > 1_000_000                # filter elements exceeding 1e6
        ==> elems()
}, 4075, "Pascal's triangle";

# Problem 9
my @triplet-prods = gather {
    sub triplets(\N) {
        for 1..Int((1 - sqrt(0.5)) * N) -> \a {
            my \u = N * (N - 2 * a);
            my \v = 2 * (N - a);

            # check if b = u/v is an integer
            # if so, we've found a triplet
            if u %% v {
                my \b = u div v;
                my \c = N - a - b;
                take $(a, b, c);
            }
        }
    }

    take [*] .list for gather triplets(1000);
}

is_deeply @triplet-prods, [31875000], 'Pythagorean triplet products (gathered)';

@triplet-prods = do {
    constant N = 1000;

    1..Int((1 - sqrt(0.5)) * N)
    ==> map -> \a { [ a, N * (N - 2 * a), 2 * (N - a) ] } \
    ==> grep -> [ \a, \u, \v ] { u %% v } \
    ==> map -> [ \a, \u, \v ] {
        my \b = u div v;
        my \c = N - a - b;
        a * b * c
    }
}

is_deeply @triplet-prods, [31875000], 'Pythagorean triplet products (dataflow)';

# Problem 47

BEGIN my %cache = 1 => 0;

multi factors($n where %cache{$n}:exists) { %cache{$n} }
multi factors($n) {
    for 2, 3, *+2 ...^ * > sqrt($n) {
        if $n %% $_ {
            my $r = $n;
            $r div= $_ while $r %% $_;
            return %cache{$n} = 1 + factors($r);
        }
    }
    return %cache{$n} = 1;
}

constant $N = 3; # 4 in advent post - very expensive

my $i = 0;
my $result;

{
    for 2..* {
        $i = factors($_) == $N ?? $i + 1 !! 0;
        if $i == $N {
            $result = $_ - $N + 1;
            last;
        }
    }

    is $result, 644, 'consecutive prime factors';
}

# Note: have not attempted NativeCall implementation

# Problem 29

is +(2..100 X=> 2..100).classify({ .key ** .value }), 9183, 'distinct term count';

{
    constant A = 100;
    constant B = 100;

    my (%powers, %count);

    # find bases which are powers of a preceding root base
    # store decomposition into base and exponent relative to root
    for 2..Int(sqrt A) -> \a {
        next if a ~~ %powers;
        %powers{a, a**2, a**3 ...^ * > A} = a X=> 1..*;
    }

    # count duplicates
    for %powers.values -> \p {
        for 2..B -> \e {
            # raise to power \e
            # classify by root and relative exponent
            ++%count{p.key => p.value * e}
        }
    }

    # add +%count as one of the duplicates needs to be kept
    is ((A - 1) * (B - 1) + %count - [+] %count.values), 9183, 'distinct term count - optimized';
}

