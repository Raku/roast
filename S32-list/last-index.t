use v6;
use Test;

# L<S32::Containers/"List"/"=item last-index">

plan 25;

my @list = (1 ... 10);

{
    my $result = last-index { $^a % 2 }, |@list;
    ok($result ~~ Int, "last-index() returns an Int");
    is($result, 8, "returned value by last-index() is correct");
}

{
    my $result = last-index { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8;
    ok($result ~~ Int, "last-index() returns an Int");
    is($result, 6, "returned value by last-index() is correct");
}


{
    my $result = @list.last-index( { $^a == 4} );
    ok($result ~~ Int, "method form of last-index returns an Int");
    is($result, 3, "method form of last-index returns the expected item");
}

#?rakudo skip "adverbial block"
#?niecza skip 'No value for parameter Mu $filter in CORE Any.first'
{
    my $result = @list.last-index():{ $^a == 4 };
    ok($result ~~ Int, "last-index():<block> returns an Int");
    is($result, 3, "last-index() returned the expected value");
}

{
    ok @list.last-index( { $^a == 11 } ) =:= Nil, 'last-index returns Nil on unsuccessful match';
}

{
    my $count = 0;
    my $matcher = sub (Int $x) { $count++; $x % 2 };
    is @list.last-index($matcher), 8, 'last-index() search for odd elements successful';
    is $count, 2, 'Matching closure in last-index() is only executed twice';
}

{
    is(@list.last-index(4..6), 5, "method form of last-index with range returns the expected item");
    is(@list.last-index(4..^6), 4, "method form of last-index with range returns the expected item");
}

{
    my @fancy_list = (1, 2, "Hello", 3/4, 4.Num);
    is @fancy_list.last-index(Str), 2, "last-index by type Str works";
    is @fancy_list.last-index(Int), 1, "last-index by type Int works";
    is @fancy_list.last-index(Rat), 3, "last-index by type Rat works";
}

{
    my @fancy_list = <Philosopher Goblet Prince>;
    is @fancy_list.last-index(/o/),    1, "last-index by regex /o/";
    is @fancy_list.last-index(/ob/),   1, "last-index by regex /ob/";
    is @fancy_list.last-index(/l.*o/), 0, "last-index by regex /l.*o/";
}

{
    is <a b c b a>.last-index('c' | 'b'),
        3, '.last-index also takes a junction as matcher';

    is (last-index 'c'|'b', <a b c b a>),
        3, '.last-index also takes a junction as matcher (sub form)';
}

# Bool handling
{
    throws_like { last-index $_ == 1, 1,2,3 }, X::Match::Bool;
    throws_like { (1,2,3).last-index: $_== 1 }, X::Match::Bool;
    is last-index( Bool,True,False,Int ), 1, 'can we match on Bool as type';
    is (True,False,Int).last-index(Bool), 1, 'can we match on Bool as type';
}

#vim: ft=perl6
