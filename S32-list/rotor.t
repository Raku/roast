use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 19;

#?DOES 1
sub r(\pos, $expected, $descr? is copy, *%named) {
    $descr //= "rotor({pos.join(', ')}{ ', :partial' if %named<partial>}) (range)";
    subtest( sub {
        plan 2;
        my $got = ('a'..'h').rotor(|pos.list, |%named).join('|');
        is $got, $expected, "range";

        $got = ('a'..'h').list.rotor(|pos.list, |%named).join('|');
        is $got, $expected, "list";
    }, $descr);
}

r(3, 'a b c|d e f');
r(3, :partial, 'a b c|d e f|g h');
r(2 => 1, 'a b|d e|g h');
r(3 => -1, 'a b c|c d e|e f g');
r((2, 3), 'a b|c d e|f g');
r((1 => 1, 3), 'a|c d e|f');
r((1 => 1, 3), :partial, 'a|c d e|f|h');
r((1 => 1, 3 => -1), :partial, 'a|c d e|e|g h');

is (1..*).rotor((1..*))[^4].join('|'),
   '1|2 3|4 5 6|7 8 9 10', '.rotor on infinite list';

# RT #127437
throws-like { <a b c>.rotor: 1 => -2 }, X::OutOfRange,
    ’using negative gap that lands past the list's head throws‘;

# RT #127424
subtest 'non-Int numerals as arguments to rotor get coersed to Int' => {
    plan 4;
    is-deeply (^9 .rotor: 2.5       ), (^9 .rotor: 2     ), 'one-arg';
    is-deeply (^9 .rotor: 2.5 => 1  ), (^9 .rotor: 2 => 1), 'pair(Rat,Int)';
    is-deeply (^9 .rotor: 2   => 2.5), (^9 .rotor: 2 => 2), 'pair(Int,Rat)';
    is-deeply (^9 .rotor: 2.5 => 2.5), (^9 .rotor: 2 => 2), 'pair(Rat,Rat)';
}

# RT #130283
is-eqv ().rotor(1), ().Seq, '.rotor on empty list gives empty Seq';
is-eqv ().rotor(1, :partial), ().Seq,
    '.rotor(:partial) on empty list gives empty Seq';

# RT #130725
is-eqv (gather do for ^2 { "x".take }).rotor(3, :partial), (<x x>,).Seq,
    ".rotor(:partial) works with gather/take";

# RT #129175
is-eqv <a b c d e f>.rotor(1...*),
    (("a",), ("b", "c"), ("d", "e", "f")).Seq,
    '.rotor does not hang when given infinite iterable as cycle';

# RT #131018
is-eqv <a b c d e f>.rotor(2 => -2, 1),
    (("a", "b"), ("a",), ("b", "c"), ("b",), ("c", "d"), ("c",), ("d", "e"),
      ("d",), ("e", "f"), ("e",)).Seq,
    ".rotor works as expected with negative gap";

# [Github Issue 1397](https://github.com/rakudo/rakudo/issues/1397)
subtest '.rotor: 2 => -1, :partial obeys Iterator protocol' => {
    plan 2;

    my $iterends = 0;
    my $s := Seq.new: class :: does Iterator {
        method pull-one {
            return $++ if $++ < 3;
            $iterends++;
            IterationEnd
        }
    }.new;
    is-eqv $s.rotor(2 => -1, :partial), ((0, 1), (1, 2), (2,)).Seq,
        'got right result';
    is $iterends, 1, 'stopped pulling after receiving IterationEnd';
}

is-eqv <a b c d e f g h>.rotor((1,2,3,*)),
    (("a",), ("b", "c",), ("d", "e", "f",), ("g", "h",)).Seq,
    '.rotor with Whatever consumes everything';

is-eqv <a b c d e f g h>.rotor((1,2,3,Inf)),
    (("a",), ("b", "c",), ("d", "e", "f",), ("g", "h",)).Seq,
    '.rotor with Inf consumes everything';
