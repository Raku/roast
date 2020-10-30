use v6;

#BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = True;
use Test;

# Mapping of types to allomorphs
my %type2allo{Any} = Int, IntStr, Rat, RatStr, Num, NumStr, Complex, ComplexStr;

# Check the special empty / whitespace only string
for '', ' ' -> $empty {
    is-deeply val($empty), IntStr.new(0, $empty),
      "does val('$empty') give the correct allomorph";
    is-deeply $empty.Numeric, 0,
      "does '$empty'.Numeric give the correct value";
}

# Set up a list of value, and a list of strings that can be run through
# val(), or have Numeric called on them, or be EVALled.  Each string is
# expanded to have spaces before/after or a + or - prefixed.
my @ok =
                  0, < 0 000 0000 0_0 >,
                 42, < 42 4_2 :10<42> :10[42] :10[4,2]
                       :10<42> :10<4_2>
                       :16<2a> :16<2_a>
                       :2<101010> :2<10_10_10>
                       :10«42» :10«4_2»
                       :16«2a» :16«2_a»
                       :2«101010» :2«10_10_10»
                       :10<0x2a> :10<0x_2a> :10<0x2_a>
                       :8<0d42> :8<0b101010>
                       :2<0x2a> :2<0d42>
                       :10«0x2a» :10«0x_2a» :10«0x2_a»
                       :8«0d42» :8«0b101010»
                       :2«0x2a» :2«0d42»
                     >,
               2000, < 2*10**3 2*+10**3 2*10**+3 2*+10**+3 2*+1_0**3 >,
              -2000, < 2*-10**3 2*−10**3 2*-1_0**3 >,

                  7, < 0b111 0b_111 0b1_11 >,
                 73, < 0o111 0o_111 0o1_11 >,
                111, < 0d111 0d_111 0d1_11 >,
                273, < 0x111 0x_111 0x1_11 >,
              15000, < 0b1111*10**3 0o17*10**3 0d15*10**3 0xf*10**3 >,

              42.13, < 42.13 4_2.13 42.1_3 :10<42.13> :10<4_2.13> :10<42.1_3>
                       :10[42.13] :10[4,2,.,1,3] >,
                .13, < .13 .1_3 0.13 000.13 00_00.13 00_00.1_3
                       :10<.13> :10<.1_3> :10<0.13>
                     >,

               7.75, < 0b111.11 0b_111.11 0b1_11.11 0b111.1_1 :10<0b111.11> >,
          73.140625, < 0o111.11 0o_111.11 0o1_11.11 0o111.1_1 :16<0o111.11> >,
             111.11, < 0d111.11 0d_111.11 0d1_11.11 0d111.1_1  :2<0d111.11> >,
       273.06640625, < 0x111.11 0x_111.11 0x1_11.11 0x111.1_1  :8<0x111.11> >,
             1500.0, < 0b1.1*10**3 0o1.4*10**3 0d1.5*10**3 0x1.8*10**3 >,

                2.8, <  42/15  4_2/15  42/1_5  4_2/1_5
                       42/+15 4_2/+15 42/+1_5  4_2/+1_5
                     >,
               -2.8, < 42/-15 4_2/-15 42/-1_5 4_2/-1_5
                       42/−15 4_2/−15 42/−1_5 4_2/−1_5
                     >,
               2.81, <  42.15/15  4_2.15/15  42.1_5/15  4_2.1_5/15
                       42.15/+15 4_2.15/+15 42.1_5/+15 4_2.1_5/+15
                     >,
              -2.81, < 42.15/-15 4_2.15/-15 42.1_5/-15 4_2.1_5/-15
                       42.15/−15 4_2.15/−15 42.1_5/−15 4_2.1_5/−15
                     >,
            280/103, <  42/15.45  42/1_5.45  42/15.4_5  42/1_5.4_5
                       42/+15.45 42/+1_5.45 42/+15.4_5 42/+1_5.4_5
                        42/15.45  42/1_5.45  42/15.4_5  42/1_5.4_5
                       42/+15.45 42/+1_5.45 42/+15.4_5 42/+1_5.4_5
                     >,
           -280/103, < 42/-15.45 42/-1_5.45 42/-15.4_5 42/-1_5.4_5
                       42/−15.45 42/−1_5.45 42/−15.4_5 42/−1_5.4_5
                       42/-15.45 42/-1_5.45 42/-15.4_5 42/-1_5.4_5
                       42/−15.45 42/−1_5.45 42/−15.4_5 42/−1_5.4_5
                     >,
            281/103, <  42.15/15.45  4_2.15/1_5.45  4_2.1_5/1_5.4_5
                       42.15/+15.45 4_2.15/+1_5.45 4_2.1_5/+1_5.4_5
                        42.15/15.45  4_2.15/1_5.45  4_2.1_5/1_5.4_5
                       42.15/+15.45 4_2.15/+1_5.45 4_2.1_5/+1_5.4_5
                     >,
           -281/103, < 42.15/-15.45 4_2.15/-1_5.45 4_2.1_5/-1_5.4_5
                       42.15/−15.45 4_2.15/−1_5.45 4_2.1_5/−1_5.4_5
                       42.15/-15.45 4_2.15/-1_5.45 4_2.1_5/-1_5.4_5
                       42.15/−15.45 4_2.15/−1_5.45 4_2.1_5/−1_5.4_5
                     >,

              .0042, < 42*10**-4 4_2*10**-4 42*1_0**-4 4_2*1_0**-4
                       42*10**−4 4_2*10**−4 42*1_0**−4 4_2*1_0**−4
                     >,

           422500.0, < 42.25*10**4 4_2.2_5*1_0**4 42.25*+10**4 >,
          -422500.0, < 42.25*-10**4 42.25*−10**4 >,

                NaN, ('NaN',),
                Inf, < Inf ∞ 1e100000000 >,

               42e2, < 42e2  4_2e2 42e+2 4_2e+2 >,
              42e-2, < 42e-2 4_2e-2 >,

            42150e0, < 42.15e3  42.15e+3   4_2.15e3   42.1_5e3
                       4_2.1_5e3 :10<42.15e3>
                     >,
          0.04215e0, < 42.15e-3 4_2.15e-3 42.1_5e-3 4_2.1_5e-3
                       :10<42.15e-3>
                     >,
           422500e0, < 42.25e0*10**4 4_2.2_5e0*1_0**4 42.25e0*+10**4
                       :10<42.25e0*+10**4>
                     >,
          -422500e0, < 42.25e0*-10**4 42.25e0*−10**4 :10<42.25e0*-10**4>
                       :10<42.25e0*−10**4>
                     >,

                42i, < 42i 42\i 4_2i 4_2\i 0+42i 0+42\i 0+4_2i 0+4_2\i >,
             42+34i, < 42+34i 42+34\i 4_2+34i 4_2+34\i 42+3_4i 42+3_4\i >,
           42e0+34i, < 42e0+34i  4_2e0+34i  42e0+3_4i
                       42e0+34\i 4_2e0+34\i 42e0+3_4\i
                     >,
           42+34e0i, < 42+34e0i  4_2+34e0i  42+3_4e0i
                       42+34e0\i 4_2+34e0\i 42+3_4e0\i
                     >,
         42e0+34e0i, < 42e0+34e0i  4_2e0+34e0i  42e0+3_4e0i
                       42e0+34e0\i 4_2e0+34e0\i 42e0+3_4e0\i
                     >,

              42-1i, < 42-i 42-1i 4_2-i >,
             42-34i, < 42-34i 42-34\i 4_2-34i 4_2-34\i 42-3_4i 42-3_4\i >,
           42e0-34i, < 42e0-34i  4_2e0-34i  42e0-3_4i
                       42e0-34\i 4_2e0-34\i 42e0-3_4\i
                     >,
           42-34e0i, < 42-34e0i  4_2-34e0i  42-3_4e0i
                       42-34e0\i 4_2-34e0\i 42-3_4e0\i
                     >,
         42e0-34e0i, < 42e0-34e0i  4_2e0-34e0i  42e0-3_4e0i
                       42e0-34e0\i 4_2e0-34e0\i 42e0-3_4e0\i
                     >,

              42-1i, < 42−i 42−1i 4_2−i >,
             42−34i, < 42−34i 42−34\i 4_2−34i 4_2−34\i 42−3_4i 42−3_4\i >,
           42e0−34i, < 42e0−34i  4_2e0−34i  42e0−3_4i
                       42e0−34\i 4_2e0−34\i 42e0−3_4\i
                     >,
           42−34e0i, < 42−34e0i  4_2−34e0i  42−3_4e0i
                       42−34e0\i 4_2−34e0\i 42−3_4e0\i
                     >,
         42e0−34e0i, < 42e0−34e0i  4_2e0−34e0i  42e0−3_4e0i
                       42e0−34e0\i 4_2e0−34e0\i 42e0−3_4e0\i
                     >,

           42+Inf\i, < 42+Inf\i 42+∞i 42+∞\i >,
             Inf+1i, < Inf+i Inf+1i ∞+i ∞+1i >,
             Inf-1i, < Inf-1i Inf−i Inf−1i >,
          Inf+Inf\i, < Inf+Inf\i Inf+∞i Inf+∞\i ∞+Inf\i ∞+∞i ∞+∞\i >,
          Inf−Inf\i, <           Inf-∞i Inf-∞\i ∞-Inf\i ∞-∞i ∞-∞\i
                       Inf−Inf\i Inf−∞i Inf−∞\i ∞−Inf\i ∞−∞i ∞−∞\i >,

    Blob.new(18,52), ( ':16{12 34}', ':10{ 18 52 }', ':8{22 64}',
                       ':2{ 10010 110100 }', ':2{ 00010010 00110100 }'
                     ),
;

sub ok-val(\value, @strings) is test-assertion {
    my \type      := value.WHAT;
    my \allo-type := %type2allo{type};

    # test all string values given
    for @strings -> $string {

        # handle most common before / after cases
        for (
           "$string",  value,
          "+$string",  value,
          " $string",  value,
          "$string ",  value,
         " $string ",  value,
          "-$string", -value,
          "−$string", -value,
        ) -> $string, \value {

            # cannot test negation of complex numbers
            next
              if type ~~ Complex | Blob
              && ($string.starts-with('-') || $string.starts-with('−'));

            subtest "Tested '$string'" => {
                my \allo := try val($string);    # should be $string.val
                if allo =:= Nil {
                    flunk "Execution error trying to get val('$string')";
                }
                elsif allo.^name eq 'Str' {
                    flunk "Value is of type '{allo.^name}' instead of '{type.^name}Str'";
                }
                elsif type.^name eq 'Blob' {
                    is-deeply allo.WHAT, type,
                      "Did we get a {type.^name} for val('$string')";
                    is-deeply allo, value,
                      "Did we get the right value for val('$string')";
                }
                else {
                    my \allo-type := %type2allo{type};
                    is-deeply allo.WHAT, allo-type,
                      "Did we get a {allo-type.^name} for val('$string')";
                    is-deeply allo, allo-type.new(allo, $string),
                      "Did we get the right value for val('$string')";
                }

                unless type.^name eq 'Blob' {
                    my \numeric := try $string.Numeric;
                    if numeric =:= Nil {
                        flunk "Execution error trying to get +'$string'";
                    }
                    else {
                        is-deeply numeric.WHAT, type,
                          "Did we get a {type.^name} for +'$string'";
                        is-deeply numeric, value,
                          "Did we get the right value for +'$string'";
                    }

                    my \evalled := try $string.subst(",.,", ",'.',").EVAL;  # handle :10[4,2,.,1,3]
                    if evalled =:= Nil {
                        diag "'$string' is not valid source code"; # should become a flunk
                    }
                    else {
                        is-deeply evalled.WHAT, numeric.WHAT,
                          "Did we get a {type.^name} for '$string'.EVAL";
                        is-deeply evalled, numeric,
                          "Did we get the right value for '$string'.EVAL";
                    }
                }

                done-testing;
            }
        }
    }
}

for @ok -> \value, @strings {
    ok-val(value, @strings);
}

done-testing;

# vim: expandtab shiftwidth=4
