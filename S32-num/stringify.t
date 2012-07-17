use v6;
use Test;
plan 76;

# L<S32::Numeric/Complex/"=item gist">

#?DOES 4
sub Complex_str_test($value, $str_nucleus) {
    #?pugs todo
    is ~$value, $str_nucleus, "~<$str_nucleus>";
    #?pugs skip 'coercion'
    is $value.Str, $str_nucleus, "<$str_nucleus>.Str";
    #?pugs skip '.gist'
    is $value.gist, $str_nucleus, "<$str_nucleus>.gist";
    #?rakudo todo 'Complex.perl'
    #?pugs todo
    is $value.perl, "<$str_nucleus>", "<$str_nucleus>.perl";
}

# basic syntactic correctness - sign flags, lack of space
Complex_str_test (3 + 4i), '3+4i';
Complex_str_test (3 - 4i), '3-4i';
Complex_str_test (-3 + 4i), '-3+4i';
# use proper Num formatting - fractionalComplex_str_testm
Complex_str_test (3.5 + 4i), '3.5+4i';
Complex_str_test (3 + 4.5i), '3+4.5i';
# infinities
Complex_str_test (Inf + 3i), 'Inf+3i';
#?pugs skip 'parsefail'
Complex_str_test (0 + Inf\i), '0+Inf\i';
Complex_str_test (-Inf + 3i), '-Inf+3i';
#?pugs skip 'parsefail'
Complex_str_test (0 - Inf\i), '0-Inf\i';
Complex_str_test (NaN + 3i), 'NaN+3i';
#?pugs skip 'parsefail'
Complex_str_test (0 + NaN\i), '0+NaN\i';

# quick check that type objects stringify correctly - this has been a problem
# for Niecza in the past

#?pugs skip 'gist'
is Complex.gist, 'Complex()', 'Complex.gist';
#?pugs todo
is Complex.perl, 'Complex', 'Complex.perl';
# XXX Should ~Complex and Complex.Str return something specific?  For now
# just make sure they don't die
lives_ok { ~Complex }, '~Complex does not die';
#?pugs skip 'coercion'
lives_ok { Complex.Str }, 'Complex.Str does not die';

# L<S32::Numeric/Rat/"=item gist">

# we check against $value.Num because Num stringification isn't precisely
# nailed down (and probably shouldn't be, to allow the use of platform
# converters)
#?DOES 4
sub Rat_str_test($value, $str_nucleus) {
    #?pugs 2 skip 'coercion'
    is ~$value, ~$value.Num, "~<$str_nucleus>";
    is $value.Str, ~$value.Num, "<$str_nucleus>.Str";
    #?pugs skip '.gist'
    is $value.gist, ~$value.Num, "<$str_nucleus>.gist";
    #?rakudo todo 'Rat.perl'
    #?pugs todo
    is $value.perl, "<$str_nucleus>", "<$str_nucleus>.perl";
}

# basic format test
Rat_str_test 1/2, '1/2';
Rat_str_test -1/2, '-1/2';
Rat_str_test 0/2, '0/1';
# 1/1 is a Rat too!
Rat_str_test 1/1, '1/1';
# Return as-if normalized
#?rakudo skip 'formatting precision'
Rat_str_test 13/39, '1/3';
# Bignum sanity
#?rakudo skip 'formatting precision'
Rat_str_test (4.5 ** 60), '1797010299914431210413179829509605039731475627537851106401/1152921504606846976';

#?pugs skip '.gist'
is Rat.gist, 'Rat()', 'Rat.gist';
#?pugs todo
is Rat.perl, 'Rat', 'Rat.perl';
lives_ok { ~Rat }, '~Rat does not die';
lives_ok { Rat.Str }, 'Rat.Str does not die';

# TODO: FatRat, Num (once better specced), Int (maybe, but hard to mess up)

# vim: ft=perl6
