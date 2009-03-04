use v6;
use Test;

# L<S29/"List"/"=item classify">

plan 10;

#?pugs todo 'feature'
{ 
    my   @list = (1, 2, 3, 4);
    my (@even,@odd);
    ok(eval(q"(:@even, :@odd) := classify { $_ % 2 ?? 'odd' !! 'even' } 1,2,3,4; ") );
    is_deeply(@even, [2,4], "got expected evens");
    is_deeply(@odd,  [1,3], "got expected odds");
}

#?pugs todo 'feature'
{
    my %by_five;
    ok(eval(q" %by_five = classify { $_ * 5 } 1,2,3,4 "));

    is( %by_five{5},  1);
    is( %by_five{10}, 2);
    is( %by_five{15}, 3);
    is( %by_five{20}, 4);
}

# .classify should work on non-arrays
{
  lives_ok { 42.classify: { $_ } },      "method form of classify should not work on numbers";
  lives_ok { "str".classify: { $_ } },   "method form of classify should not work on strings";
}
