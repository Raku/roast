use v6;

use Test;

plan 18;

# L<S06/"Lvalue subroutines">

{
    my int $i = 1;
    my num $n = 0.1e0;
    my str $s = 'korma';

    sub returns-native-int-rw-untyped() is rw { $i }
    sub returns-native-num-rw-untyped() is rw { $n }
    sub returns-native-str-rw-untyped() is rw { $s }

    returns-native-int-rw-untyped() = 2;
    is $i, 2, 'Native int var returned from untyped is rw can be assigned to';

    returns-native-num-rw-untyped() = 0.2e0;
    is $n, 0.2e0, 'Native num var returned from untyped is rw can be assigned to';

    returns-native-str-rw-untyped() = 'jalfrezi';
    is $s, 'jalfrezi', 'Native str var returned from untyped is rw can be assigned to';
}

{
    my int $i = 1;
    my num $n = 0.1e0;
    my str $s = 'korma';

    sub returns-native-int-rw-typed() returns int is rw { $i }
    sub returns-native-num-rw-typed() returns num is rw { $n }
    sub returns-native-str-rw-typed() returns str is rw { $s }

    returns-native-int-rw-typed() = 2;
    is $i, 2, 'Native int var returned from typed is rw can be assigned to';

    returns-native-num-rw-typed() = 0.2e0;
    is $n, 0.2e0, 'Native num var returned from typed is rw can be assigned to';

    returns-native-str-rw-typed() = 'jalfrezi';
    is $s, 'jalfrezi', 'Native str var returned from typed is rw can be assigned to';
}

{
    my int $i = 1;
    my num $n = 0.1e0;
    my str $s = 'korma';

    sub returns-native-int-ro-untyped() { $i }
    sub returns-native-num-ro-untyped() { $n }
    sub returns-native-str-ro-untyped() { $s }

    dies_ok { EVAL 'returns-native-int-ro-untyped() = 2' },
        'Non-rw untyped returning native int not an l-value';
    is $i, 1, 'Really did not modify int';
    
    dies_ok { EVAL 'returns-native-num-ro-untyped() = 0.2e0' },
        'Non-rw untyped returning native num not an l-value';
    is $n, 0.1e0, 'Really did not modify num';
    
    dies_ok { EVAL 'returns-native-str-ro-untyped() = "jalfrezi"' },
        'Non-rw untyped returning native str not an l-value';
    is $s, 'korma', 'Really did not modify str';
}

{
    my int $i = 1;
    my num $n = 0.1e0;
    my str $s = 'korma';

    sub returns-native-int-ro-typed() returns int { $i }
    sub returns-native-num-ro-typed() returns num { $n }
    sub returns-native-str-ro-typed() returns str { $s }

    dies_ok { EVAL 'returns-native-int-ro-typed() = 2' },
        'Non-rw typed returning native int not an l-value';
    is $i, 1, 'Really did not modify int';
    
    dies_ok { EVAL 'returns-native-num-ro-typed() = 0.2e0' },
        'Non-rw typed returning native num not an l-value';
    is $n, 0.1e0, 'Really did not modify num';
    
    dies_ok { EVAL 'returns-native-str-ro-typed() = "jalfrezi"' },
        'Non-rw typed returning native str not an l-value';
    is $s, 'korma', 'Really did not modify str';
}

# vim: ft=perl6
