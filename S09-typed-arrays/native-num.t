use Test;

plan 107;

# Basic native num array tests.
{
    ok array[num] ~~ Positional, 'Native num array type is Positional';
    ok array[num] ~~ Positional[num], 'Native num array type is Positional[num]';
    ok array[num].of === num, 'Native num array type .of is num';
    ok array[num].new ~~ Positional, 'Native num array is Positional';
    ok array[num].new ~~ Positional[num], 'Native num array is Positional[num]';
    ok array[num].new.of === num, 'Native num array .of is num';

    my @arr := array[num].new;
    is @arr.elems, 0, 'New native num array has no elems';
    is @arr.end, -1, 'New native num array has end of -1';
    is @arr.Int, 0, 'New native num arrray Int-ifies to 0';
    is +@arr, 0, 'New native num arrray numifies to 0';
    nok @arr, 'New native num array is falsey';
    nok @arr.infinite, 'Empty native num array is not infinite';

    is @arr[5], 0e0, 'Accessing non-existing element gives 0e0';
    is @arr.elems, 0, 'The elems do not grow just from an access';

    lives_ok { @arr[0] = 4.2e0 }, 'Can store floating point number in a num array';
    is @arr[0], 4.2e0, 'Can get value from num array';
    is @arr.elems, 1, 'The elems grew as expected';
    ok @arr, 'Array becomes truthy when it has an element';

    lives_ok { @arr[1, 2] = 6.9e0, 7.0e0 }, 'Can slice-assign to an num array';
    is @arr[1], 6.9e0, 'Can get slice-assigned value from num array (1)';
    is @arr[2], 7.0e0, 'Can get slice-assigned value from num array (2)';
    is @arr.elems, 3, 'The elems grew as expected';
    is @arr.end, 2, 'The end value matches grown elems';
    is @arr.Int, 3, 'Int-ifies to grown number of elems';
    is +@arr, 3, 'Numifies to grown number of elems';
    nok @arr.infinite, 'Native num array with values is not infinite';

    lives_ok { @arr[10] = 10.0e0 }, 'Can assign non-contiguously';
    is @arr[9], 0, 'Elements behind non-contiguous assignment are 0e0';
    is @arr[10], 10.0e0, 'Non-contiguous assignment works';

    lives_ok { @arr = () }, 'Can clear array by assigning empty list';
    is @arr.elems, 0, 'Cleared native num array has no elems';
    is @arr.end, -1, 'Cleared native num array has end of -1';
    is @arr.Int, 0, 'Cleared native num arrray Int-ifies to 0';
    is +@arr, 0, 'Cleared native num arrray numifies to 0';
    nok @arr, 'Cleared native num array is falsey';

    lives_ok { @arr = 1e0..50e0 }, 'Can assign number range to num array';
    is @arr.elems, 50, 'Got correct number of elems from range assign';
    is @arr[0], 1e0, 'Got a correct element from range assign (1)';
    is @arr[49], 50e0, 'Got a correct element from range assign (2)';

    ok @arr[0]:exists, ':exists works on native num array (1)';
    ok @arr[49]:exists, ':exists works on native num array (2)';
    nok @arr[50]:exists, ':exists works on native num array (3)';

    lives_ok { @arr := array[num].new(1.0e0, 1.5e0, 1.2e0) },
        'Can call native num array constructor with values';
    is @arr.elems, 3, 'Correct number of elements set in constructor';
    is @arr[0], 1.0e0, 'Correct element value set by constructor (1)';
    is @arr[1], 1.5e0, 'Correct element value set by constructor (2)';
    is @arr[2], 1.2e0, 'Correct element value set by constructor (3)';

    ok @arr.flat === @arr, 'Native num array .flat returns identity';
    ok @arr.list === @arr, 'Native num array .list returns identity';
    ok @arr.eager === @arr, 'Native num array .eager returns identity';

    my num $total = 0e0;
    for @arr {
        $total += $_;
    }
    is_approx $total, 3.7e0, 'Can iterate over native num array';

    $_++ for @arr;
    is_approx @arr[0], 2.0e0, 'Mutating for loop on native num array works (1)';
    is_approx @arr[1], 2.5e0, 'Mutating for loop on native num array works (2)';
    is_approx @arr[2], 2.2e0, 'Mutating for loop on native num array works (3)';

    @arr.map(* *= 2);
    is_approx @arr[0], 4.0e0, 'Mutating map on native num array works (1)';
    is_approx @arr[1], 5.0e0, 'Mutating map on native num array works (2)';
    is_approx @arr[2], 4.4e0, 'Mutating map on native num array works (3)';

    is @arr.grep(* < 4.5e0).elems, 2, 'Can grep a native num array';
    is_approx ([+] @arr), 13.4e0, 'Can use reduce meta-op on a native num array';

    @arr = ();
    dies_ok { @arr.pop }, 'Trying to pop an empty native num array dies';
    dies_ok { @arr.shift }, 'Trying to shift an empty native num array dies';

    @arr.push(4.2e0);
    is @arr.elems, 1, 'push to native num array works (1)';
    is @arr[0], 4.2e0, 'push to native num array works (2)';
    dies_ok { @arr.push('it real good') },
        'Cannot push non-num/Num to num native array';

    @arr.push(10.1e0, 10.5e0);
    is @arr.elems, 3, 'push multiple to native num array works (1)';
    is @arr[1], 10.1e0, 'push multiple to native num array works (2)';
    is @arr[2], 10.5e0, 'push multiple to native num array works (3)';
    dies_ok { @arr.push('omg', 'wtf') },
        'Cannot push non-num/Num to num native array (multiple push)';

    is @arr.pop, 10.5e0, 'pop from native num array works (1)';
    is @arr.elems, 2, 'pop from native num array works (2)';

    @arr.unshift(-1e0);
    is @arr.elems, 3, 'unshift to native num array works (1)';
    is @arr[0], -1e0, 'unshift to native num array works (2)';
    is @arr[1], 4.2e0, 'unshift to native num array works (3)';
    dies_ok { @arr.unshift('the part of the day you are not working') },
        'Cannot unshift non-num/Num to num native array';

    @arr.unshift(-3e0, -2e0);
    is @arr.elems, 5, 'unshift multiple to native num array works (1)';
    is @arr[0], -3e0, 'unshift multiple to native num array works (2)';
    is @arr[1], -2e0, 'unshift multiple to native num array works (3)';
    is @arr[2], -1e0, 'unshift multiple to native num array works (4)';
    is @arr[3], 4.2e0, 'unshift multiple to native num array works (5)';
    dies_ok { @arr.unshift('wtf', 'bbq') },
        'Cannot unshift non-num/Num to num native array (multiple unshift)';

    is @arr.shift, -3e0, 'shift from native num array works (1)';
    is @arr.elems, 4, 'shift from native num array works (2)';

    @arr = 1e0..10e0;
    my @replaced = @arr.splice(3, 2, 98e0, 99e0, 100e0);
    is @arr.elems, 11, 'Correct number of elems after splice native num array';
    is @arr[2], 3e0, 'Splice did the right thing (1)';
    is @arr[3], 98e0, 'Splice did the right thing (2)';
    is @arr[4], 99e0, 'Splice did the right thing (3)';
    is @arr[5], 100e0, 'Splice did the right thing (4)';
    is @arr[6], 6e0, 'Splice did the right thing (5)';
    is @replaced.elems, 2, 'Correct number of returned spliced values';
    is @replaced[0], 4e0, 'Correct value in splice returned array (1)';
    is @replaced[1], 5e0, 'Correct value in splice returned array (2)';

    @arr = 1e0..5e0;
    is @arr.Str, '1 2 3 4 5', '.Str space-separates';
    is @arr.gist, '1 2 3 4 5', '.gist space-separates';
    is @arr.perl, 'array[num].new(1e0, 2e0, 3e0, 4e0, 5e0)', '.perl includes type and num values';

    sub ftest(num $a, $b) {
        $a + $b
    }
    @arr = 3.9e0, 0.3e0;
    is_approx ftest(|@arr), 4.2e0, 'Flattening native num array in call works';
}

# Interaction of native num arrays and untyped arrays.
{
    my @native := array[num].new(1e0..10e0);

    my @untyped = @native;
    is @untyped.elems, 10, 'List-assigning native num array to untyped works (1)';
    is @untyped[0], 1e0, 'List-assigning native num array to untyped works (2)';
    is @untyped[9], 10e0, 'List-assigning native num array to untyped works (3)';

    @untyped = 0e0, @native, 11e0;
    is @untyped.elems, 12, 'List-assigning native num array surrounded by literals works (1)';
    is @untyped[0], 0e0, 'List-assigning native num array surrounded by literals works (2)';
    is @untyped[5], 5e0, 'List-assigning native num array surrounded by literals works (3)';
    is @untyped[10], 10e0, 'List-assigning native num array surrounded by literals works (4)';
    is @untyped[11], 11e0, 'List-assigning native num array surrounded by literals works (5)';

    my @untyped2 = 21e0..30e0;
    my @native2 := array[num].new;
    @native2 = @untyped2;
    is @native2.elems, 10, 'List-assigning untyped array of Int to native num array works (1)';
    is @native2[0], 21e0, 'List-assigning untyped array of Int to native num array works (2)';
    is @native2[9], 30e0, 'List-assigning untyped array of Int to native num array works (3)';

    @untyped2.push('C-C-C-C-Combo Breaker!');
    dies_ok { @native2 = @untyped2 },
        'List-assigning incompatible untyped array to native num array dies';
}
