use v6.c;
use Test;

plan 9;

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
