use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;
plan 9;

# L<S32::Str/Str/ords>

is ords('').elems, 0, 'ords(empty string)';
is ''.ords.elems,  0, '<empty string>.ords';
is ords('Cool()').join(', '), '67, 111, 111, 108, 40, 41',
   'ords(normal string)';
is 'Cool()'.ords.join(', '), '67, 111, 111, 108, 40, 41',
   '<normal string>.ords';
is ords(42).join(', '), '52, 50', 'ords() on integers';
is 42.ords.join(', '), '52, 50', '.ords on integers';

is ords(".\x[301]"), (46, 769), 'ords does not lose NFG synthetics (function)';
is ".\x[301]".ords, (46, 769), 'ords does not lose NFG synthetics (method)';

# https://github.com/rakudo/rakudo/commit/8b7385d810
subtest 'optimization coverage' => {
    plan 4;
    my $s := "e\x[308]abc";
    my @ords := 235, 97, 98, 99;

    my @target-s = $s.ords;
    my @target-e = "".ords;
    #?rakudo.jvm todo '"e\x[308]abc".ords returns (101 776 97 98 99).Seq'
    is-deeply @target-s, [@ords], '.push-all (has chars)';
    is-deeply @target-e, [],      '.push-all (no chars)';

    #?rakudo.jvm skip 'fails due to above failure'
    #?DOES 1
    test-iter-opt $s.ords.iterator, @ords, 'has chars';
    test-iter-opt "".ords.iterator, (),    'no  chars';
}

# vim: expandtab shiftwidth=4
