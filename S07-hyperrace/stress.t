use v6;
use Test;

plan 10;

{
    my @seq = (^20000).grep(*.is-prime);

    my @race = (^20000).race.grep(*.is-prime);
    is @race.elems, @seq.elems, 'Correct number of elements from race grep';
    is @race.sort, @seq, 'Correct results from race grep (sorted to compare)';

    my @hyper = (^20000).hyper.grep(*.is-prime);
    is @hyper.elems, @seq.elems, 'Correct number of elements from hyper grep';
    is @hyper, @seq, 'Correct results from hyper grep (order preseved, no sorting)';
}

{
    my @seq = (^20000).map(10 * * + 2);

    my @race = (^20000).race.map(10 * * + 2);
    is @race.elems, @seq.elems, 'Correct number of elements from race map';
    is @race.sort, @seq, 'Correct results from race map (sorted to compare)';

    my @hyper = (^20000).hyper.map(10 * * + 2);
    is @hyper.elems, @seq.elems, 'Correct number of elements from hyper map';
    is @hyper, @seq, 'Correct results from hyper map (order preseved, no sorting)';
}

{
    my @seq = (^1000).map({ slip('x' xx $_) }).map(*.item);

    my @race = (^1000).race.map({ slip('x' xx $_) }).map(*.item);
    is @race.elems, @seq.elems, 'Correct number of elements from race map with slip';

    my @hyper = (^1000).hyper.map({ slip('x' xx $_) }).map(*.item);
    is @hyper.elems, @seq.elems, 'Correct number of elements from hyper map with slip';
}

# vim: expandtab shiftwidth=4
