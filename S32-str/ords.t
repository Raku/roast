use v6;
use Test;
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
    plan 7;
    my $s := "e\x[308]abc";
    my @ords := 235, 97, 98, 99;

    my @target-s = $s.ords;
    my @target-e = "".ords;
    is-deeply @target-s, [@ords], '.push-all (has chars)';
    is-deeply @target-e, [],      '.push-all (no chars)';

    is-deeply +$s.ords, 4,     '.count-only (has chars)';
    is-deeply +"".ords, 0,     '.count-only (no chars)';
    is-deeply ?$s.ords, True,  '.bool-only (has chars)';
    is-deeply ?"".ords, False, '.bool-only (no chars)';

    with $s.ords.iterator -> \iter {
        subtest 'partially-iterated iterator' => {
            plan 17;

            is-deeply iter.count-only, 4,        'count (1)';
            is-deeply iter.bool-only,  True,     'bool  (1)';

            is-deeply iter.pull-one,   @ords[0], 'char (2)';
            is-deeply iter.count-only, 3,        'count (2)';
            is-deeply iter.bool-only,  True,     'bool  (2)';

            is-deeply iter.pull-one,   @ords[1], 'char (3)';
            is-deeply iter.count-only, 2,        'count (3)';
            is-deeply iter.bool-only,  True,     'bool  (3)';

            is-deeply iter.pull-one,   @ords[2], 'char (4)';
            is-deeply iter.count-only, 1,        'count (4)';
            is-deeply iter.bool-only,  True,     'bool  (4)';

            is-deeply iter.pull-one,   @ords[3], 'char (5)';
            is-deeply iter.count-only, 0,        'count (5)';
            is-deeply iter.bool-only,  False,    'bool  (5)';

            ok iter.pull-one =:= IterationEnd,   'char (6)';
            is-deeply iter.count-only, 0,        'count (6)';
            is-deeply iter.bool-only,  False,    'bool  (6)';
        }
    }
}
