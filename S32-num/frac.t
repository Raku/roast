use v6;
use Test;

plan 159;

# L<S32::Numeric/Real/"=item frac">

=begin pod

Basic tests for the frac() builtin

=end pod

throws-like { frac(Inf) }, Exception, "frac(Inf) throws";
throws-like { frac(-Inf) }, Exception, "frac(-Inf) throws";
throws-like { frac(NaN) }, Exception, "frac(NaN) throws";

my %n =
    '-100' => 0,
    '-5.9' => 0.9,
    '-5.499' => 0.499,
    '-2' => 0, 
    '-3/2' => 0.5,
    '-1.5e0' => 0.5,
    '-1.4999' => 0.4999,
    '-1.23456' => 0.23456,
    '-1' => 0, 
    '-0.5' => 0.5, 
    '-0.499' => 0.499, 
    '-0.1' => 0.1, 
    '0' => 0,
;

for %n.kv -> $tgt is copy, $exp {
    is $tgt.frac, $exp, "$tgt.frac";
    is frac($tgt), $exp, "frac($tgt)";
    is (frac $tgt), $exp, "(frac $tgt)";
    isa-ok $tgt.frac, Real, "$tgt.frac is type Real";
    isa-ok frac($tgt), Real, "frac($tgt) is type Real";
    isa-ok (frac $tgt), Real, "(frac $tgt) is type Real";

    $tgt .= abs;
    is $tgt.frac, $exp, "$tgt.frac";
    is frac($tgt), $exp, "frac($tgt)";
    is (frac $tgt), $exp, "(frac $tgt)";
    isa-ok $tgt.frac, Real, "$tgt.frac is type Real";
    isa-ok frac($tgt), Real, "frac($tgt) is type Real";
    isa-ok (frac $tgt), Real, "(frac $tgt) is type Real";
}

# vim: expandtab shiftwidth=4
