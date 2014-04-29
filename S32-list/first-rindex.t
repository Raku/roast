use v6;
use Test;

# L<S32::Containers/"List"/"=item first-rindex">

plan 21;

my @list = (1 ... 10);

{
    my $result = first-rindex { $^a % 2 }, |@list;
    ok($result ~~ Int, "first-rindex() returns an Int");
    is($result, 8, "returned value by first-rindex() is correct");
}

{
    my $result = first-rindex { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8;
    ok($result ~~ Int, "first-rindex() returns an Int");
    is($result, 6, "returned value by first-rindex() is correct");
}


{
    my $result = @list.first-rindex( { $^a == 4} );
    ok($result ~~ Int, "method form of first-rindex returns an Int");
    is($result, 3, "method form of first-rindex returns the expected item");
}

#?rakudo skip "adverbial block"
#?niecza skip 'No value for parameter Mu $filter in CORE Any.first'
{
    my $result = @list.first-rindex():{ $^a == 4 };
    ok($result ~~ Int, "first-rindex():<block> returns an Int");
    is($result, 3, "first-rindex() returned the expected value");
}

{
    ok @list.first-rindex( { $^a == 11 } ) =:= Nil, 'first-rindex returns Nil on unsuccessful match';
}

{
    my $count = 0;
    my $matcher = sub (Int $x) { $count++; $x % 2 };
    is @list.first-rindex($matcher), 8, 'first-rindex() search for odd elements successful';
    is $count, 2, 'Matching closure in first-rindex() is only executed twice';
}

{
    is(@list.first-rindex(4..6), 5, "method form of first-rindex with range returns the expected item");
    is(@list.first-rindex(4..^6), 4, "method form of first-rindex with range returns the expected item");
}

{
    my @fancy_list = (1, 2, "Hello", 3/4, 4.Num);
    is @fancy_list.first-rindex(Str), 2, "first-rindex by type Str works";
    is @fancy_list.first-rindex(Int), 1, "first-rindex by type Int works";
    is @fancy_list.first-rindex(Rat), 3, "first-rindex by type Rat works";
}

{
    my @fancy_list = <Philosopher Goblet Prince>;
    is @fancy_list.first-rindex(/o/),    1, "first-rindex by regex /o/";
    is @fancy_list.first-rindex(/ob/),   1, "first-rindex by regex /ob/";
    is @fancy_list.first-rindex(/l.*o/), 0, "first-rindex by regex /l.*o/";
}

{
    is <a b c b a>.first-rindex('c' | 'b'),
        3, '.first-rindex also takes a junction as matcher';

    is (first-rindex 'c'|'b', <a b c b a>),
        3, '.first-rindex also takes a junction as matcher (sub form)';
}

#vim: ft=perl6
