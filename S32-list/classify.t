use v6;
use Test;

# L<S32::Containers/"List"/"=item classify">

plan 16;

{
    my @list = 1, 2, 3, 4;
    my @results = @list.classify: { $_ % 2 ?? 'odd' !! 'even' };
    ok @results[0] ~~ Pair, 'got Pairs back from classify';
    is +@results, 2,  'got two values back from classify';

    @results = @results.sort({ .key });
    is @results[0].key, 'even', 'got correct "first" key';
    is @results[1].key, 'odd',  'got correct "second" key';

    is @results[0].value.join(','), '2,4', 'correct values from "even" key';
    is @results[1].value.join(','), '1,3', 'correct values from "odd" key';
}

#?pugs todo 'feature'
#?rakudo skip 'binding'
#?niecza skip 'Cannot use bind operator with this LHS'
{ 
    my   @list = (1, 2, 3, 4);
    my (@even,@odd);
    lives_ok { (:@even, :@odd) := classify { $_ % 2 ?? 'odd' !! 'even' }, 1,2,3,4}, 'Can bind result list of classify';
    is_deeply(@even, [2,4], "got expected evens");
    is_deeply(@odd,  [1,3], "got expected odds");
}

#?pugs todo 'feature'
{
    my %by_five;
    lives_ok { %by_five = classify { $_ * 5 }, 1, 2, 3, 4},
        'can classify by numbers';

    is( %by_five{5},  1);
    is( %by_five{10}, 2);
    is( %by_five{15}, 3);
    is( %by_five{20}, 4);
}

# .classify should work on non-arrays
#?niecza todo "Not sure what these should do"
{
  lives_ok { 42.classify: { $_ } },      "method form of classify should not work on numbers";
  lives_ok { "str".classify: { $_ } },   "method form of classify should not work on strings";
}

# vim: ft=perl6
