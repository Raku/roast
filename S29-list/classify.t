use v6-alpha;
use Test;

# L<S29/"List"/"=item classify">

plan 11;

my   @list = (1, 2, 3, 4);
my (@even,@odd);
ok(eval(q"(:@even, :@odd) := classify { $_ % 2 ?? 'odd' !! 'even' } 1,2,3,4; "), :todo<feature> );
is_deeply(@even, [2,4], "got expected evens", :todo<feature>);
is_deeply(@even, [1,3], "got expected odds",  :todo<feature>);

my %by_five;
ok(eval(q" %by_five = classify { $_ * 5 } 1,2,3,4 "), :todo<feature>);

is( %by_five{5},  1, :todo<feature>);
is( %by_five{10}, 2, :todo<feature>);
is( %by_five{15}, 3, :todo<feature>);
is( %by_five{20}, 4, :todo<feature> );


# .classify shouldn't work on non-arrays
{
  dies_ok { 42.classify:{ $_ } },      "method form of classify should not work on numbers";
  dies_ok { "str".classify:{ $_ } },   "method form of classify should not work on strings";
  is eval(q<<< ~(42,).classify:{ 1 } >>>), "42", "method form of classify should work on arrays", :todo<feature>;
}
