use v6;

use Test;

plan 48;

# L<S06/"Parameter traits"/"=item is rw">

{
    sub with-rw-int(int $x is rw) {
        is $x, 1, 'Native int is rw arg in sub got value';
        $x = 42
    }
    sub with-rw-num(num $x is rw) {
        is $x, 1e0, 'Native num is rw arg in sub got value';
        $x = 4.2e0
    }
    sub with-rw-str(str $x is rw) {
        is $x, 'pelmeni', 'Native str is rw arg in sub got value';
        $x = 'the answer'
    }
    
    my int $iv = 1;
    with-rw-int($iv);
    is $iv, 42, 'Native int is rw arg works in sub';
    
    my num $nv = 1e0;
    with-rw-num($nv);
    is $nv, 4.2e0, 'Native num is rw arg works in sub';
    
    my str $sv = 'pelmeni';
    with-rw-str($sv);
    is $sv, 'the answer', 'Native str is rw arg works in sub';
    
    dies_ok { EVAL 'with-rw-int(1)' }, 'Cannot pass non-container to native int is rw in sub';
    dies_ok { EVAL 'with-rw-num(1e0)' }, 'Cannot pass non-container to native num is rw in sub';
    dies_ok { EVAL 'with-rw-str("draniki")' }, 'Cannot pass non-container to native str is rw in sub';

    dies_ok { EVAL 'with-rw-int(my num $x)' }, 'Cannot pass wrong container to native int is rw in sub';
    dies_ok { EVAL 'with-rw-int(my str $x)' }, 'Cannot pass wrong container to native int is rw in sub';
    dies_ok { EVAL 'with-rw-num(my int $x)' }, 'Cannot pass wrong container to native num is rw in sub';
    dies_ok { EVAL 'with-rw-num(my str $x)' }, 'Cannot pass wrong container to native num is rw in sub';
    dies_ok { EVAL 'with-rw-str(my int $x)' }, 'Cannot pass wrong container to native str is rw in sub';
    dies_ok { EVAL 'with-rw-str(my num $x)' }, 'Cannot pass wrong container to native str is rw in sub';
}

{
    my $with-rw-int = -> int $x is rw {
        is $x, 1, 'Native int is rw arg in pointy block got value';
        $x = 42
    }
    my $with-rw-num = -> num $x is rw {
        is $x, 1e0, 'Native num is rw arg in pointy block got value';
        $x = 4.2e0
    }
    my $with-rw-str = -> str $x is rw {
        is $x, 'pelmeni', 'Native str is rw arg in pointy block got value';
        $x = 'the answer'
    }
    
    my int $iv = 1;
    $with-rw-int($iv);
    is $iv, 42, 'Native int is rw arg works in pointy block';
    
    my num $nv = 1e0;
    $with-rw-num($nv);
    is $nv, 4.2e0, 'Native num is rw arg works in pointy block';
    
    my str $sv = 'pelmeni';
    $with-rw-str($sv);
    is $sv, 'the answer', 'Native str is rw arg works in pointy block';
    
    dies_ok { EVAL '$with-rw-int(1)' }, 'Cannot pass non-container to native int is rw in pointy block';
    dies_ok { EVAL '$with-rw-num(1e0)' }, 'Cannot pass non-container to native num is rw in pointy block';
    dies_ok { EVAL '$with-rw-str("draniki")' }, 'Cannot pass non-container to native str is rw in pointy block';

    dies_ok { EVAL '$with-rw-int(my num $x)' }, 'Cannot pass wrong container to native int is rw in pointy block';
    dies_ok { EVAL '$with-rw-int(my str $x)' }, 'Cannot pass wrong container to native int is rw in pointy block';
    dies_ok { EVAL '$with-rw-num(my int $x)' }, 'Cannot pass wrong container to native num is rw in pointy block';
    dies_ok { EVAL '$with-rw-num(my str $x)' }, 'Cannot pass wrong container to native num is rw in pointy block';
    dies_ok { EVAL '$with-rw-str(my int $x)' }, 'Cannot pass wrong container to native str is rw in pointy block';
    dies_ok { EVAL '$with-rw-str(my num $x)' }, 'Cannot pass wrong container to native str is rw in pointy block';
}

{
    my class C {
        method with-rw-int(int $x is rw) {
            is $x, 1, 'Native int is rw arg in method got value';
            $x = 42
        }
        method with-rw-num(num $x is rw) {
            is $x, 1e0, 'Native num is rw arg in method got value';
            $x = 4.2e0
        }
        method with-rw-str(str $x is rw) {
            is $x, 'pelmeni', 'Native str is rw arg in method got value';
            $x = 'the answer'
        }
    }
    
    my int $iv = 1;
    C.with-rw-int($iv);
    is $iv, 42, 'Native int is rw arg works in method';
    
    my num $nv = 1e0;
    C.with-rw-num($nv);
    is $nv, 4.2e0, 'Native num is rw arg works in method';
    
    my str $sv = 'pelmeni';
    C.with-rw-str($sv);
    is $sv, 'the answer', 'Native str is rw arg works in method';

    dies_ok { EVAL 'C.with-rw-int(1)' }, 'Cannot pass non-container to native int is rw in method';
    dies_ok { EVAL 'C.with-rw-num(1e0)' }, 'Cannot pass non-container to native num is rw in method';
    dies_ok { EVAL 'C.with-rw-str("draniki")' }, 'Cannot pass non-container to native str is rw in method';

    dies_ok { EVAL 'C.with-rw-int(my num $x)' }, 'Cannot pass wrong container to native int is rw in method';
    dies_ok { EVAL 'C.with-rw-int(my str $x)' }, 'Cannot pass wrong container to native int is rw in method';
    dies_ok { EVAL 'C.with-rw-num(my int $x)' }, 'Cannot pass wrong container to native num is rw in method';
    dies_ok { EVAL 'C.with-rw-num(my str $x)' }, 'Cannot pass wrong container to native num is rw in method';
    dies_ok { EVAL 'C.with-rw-str(my int $x)' }, 'Cannot pass wrong container to native str is rw in method';
    dies_ok { EVAL 'C.with-rw-str(my num $x)' }, 'Cannot pass wrong container to native str is rw in method';
}

throws_like { EVAL('sub foo(int $x) { $x = 42 }') },
    X::Assignment::RO::Comp,
    variable => '$x',
    'Assignment to sub native read-only arg caught at compile time';

throws_like { EVAL('class C { method foo(int $x) { $x = 42 } }') },
    X::Assignment::RO::Comp,
    variable => '$x',
    'Assignment to method native read-only arg caught at compile time';

throws_like { EVAL('-> int $x { $x = 42 }') },
    X::Assignment::RO::Comp,
    variable => '$x',
    'Assignment to pointy block native read-only arg caught at compile time';
