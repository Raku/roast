use v6;
use Test;

# L<S32::Containers/"List"/"=item first-index">

plan 21;

my @list = (1 ... 10);

{
    my $result = first-index { $^a % 2 }, |@list;
    ok($result ~~ Int, "first-index() returns an Int");
    is($result, 0, "returned value by first-index() is correct");
}

{
    my $result = first-index { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8;
    ok($result ~~ Int, "first-index() returns an Int");
    is($result, 0, "returned value by first-index() is correct");
}


{
    my $result = @list.first-index( { $^a == 4} );
    ok($result ~~ Int, "method form of first-index returns an Int");
    is($result, 3, "method form of first-index returns the expected item");
}

#?rakudo skip "adverbial block"
#?niecza skip 'No value for parameter Mu $filter in CORE Any.first'
{
    my $result = @list.first-index():{ $^a == 4 };
    ok($result ~~ Int, "first-index():<block> returns an Int");
    is($result, 3, "first-index() returned the expected value");
}

{
    ok @list.first-index( { $^a == 11 } ) =:= Nil, 'first-index returns Nil on unsuccessful match';
}

{
    my $count = 0;
    my $matcher = sub (Int $x) { $count++; $x % 2 };
    is(@list.first-index($matcher), 0, 'first-index() search for odd elements successful');
    is($count, 1, 'Matching closure in first-index() is only executed once');
}

{
    is(@list.first-index(4..6), 3, "method form of first-index with range returns the expected item");
    is(@list.first-index(4^..6), 4, "method form of first-index with range returns the expected item");
}

{
    my @fancy_list = (1, 2, "Hello", 3/4, 4.Num);
    is @fancy_list.first-index(Str), 2, "first-index by type Str works";
    is @fancy_list.first-index(Int), 0, "first-index by type Int works";
    is @fancy_list.first-index(Rat), 3, "first-index by type Rat works";
}

{
    my @fancy_list = <Philosopher Goblet Prince>;
    is @fancy_list.first-index(/o/),    0, "first-index by regex /o/";
    is @fancy_list.first-index(/ob/),   1, "first-index by regex /ob/";
    is @fancy_list.first-index(/l.*o/), 0, "first-index by regex /l.*o/";
}

{
    is <a b c b a>.first-index('c' | 'b'),
        1, '.first-index also takes a junction as matcher';

    is (first-index 'c'|'b', <a b c b a>),
        1, '.first-index also takes a junction as matcher (sub form)';
}

#vim: ft=perl6
