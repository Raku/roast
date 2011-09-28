use v6;
use Test;
plan 6;

#L<S03/Smart matching/Any Array lists are comparable>
{
    class TestArraySmartmatch {
        has @!obj;
        multi method list() { @!obj };
    }

    my $o = TestArraySmartmatch.new(obj => (1, 2, 4));

    #?rakudo todo 'nom regression'
    #?niecza skip 'TODO'
    ok  ($o ~~ [1, 2, 4]),      'Any ~~ Array (basic, +)';
    ok !($o ~~ [1, 5, 4]),      'Any ~~ Array (basic, -)';
    #?rakudo todo 'nom regression'
    #?niecza skip 'TODO'
    ok  ($o ~~ [1, *]),         'Any ~~ Array (dwim, +)';
    ok !($o ~~ [8, *]),         'Any ~~ Array (dwim, -)';
    ok  (1  ~~ [1]),            'Any ~~ Array (Int, +)';
    ok !(1  ~~ [1, 2]),         'Any ~~ Array (Int, -, it is not any())';
}

done;

# vim: ft=perl6
