use v6;
use Test;

# L<S32::Containers/"List"/"=item first">

plan 26;

my @list = (1 ... 10);

{
    my $result = first { $^a % 2 }, |@list, :end, :k;
    ok($result ~~ Int, "first(, :end, :k) returns an Int");
    is($result, 8, "returned value by first() is correct");
}

{
    my $result = first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :end, :k;
    ok($result ~~ Int, "first(, :end, :k) returns an Int");
    is($result, 6, "returned value by first(, :end, :k) is correct");
}


{
    my $result = @list.first( { $^a == 4}, :end, :k );
    ok($result ~~ Int, "method form of first, :end, :k returns an Int");
    is($result, 3, "method form of first, :end, :k returns the expected item");
}

#?rakudo skip "adverbial block RT #124754"
#?niecza skip 'No value for parameter Mu $filter in CORE Any.first'
{
    my $result = @list.first():{ $^a == 4 }, :end, :k;
    ok($result ~~ Int, "first(, :end, :k):<block> returns an Int");
    is($result, 3, "first(, :end, :k) returned the expected value");
}

{
    ok @list.first( { $^a == 11 }, :end, :k ) =:= Nil, 'first, :end, :k returns Nil on unsuccessful match';
}

{
    my $count = 0;
    my $matcher = sub (Int $x) { $count++; $x % 2 };
    is @list.first($matcher, :end, :k), 8, 'first(, :end, :k) search for odd elements successful';
    is $count, 2, 'Matching closure in first(, :end, :k) is only executed twice';
}

{
    is(@list.first(4..6, :end, :k), 5, "method form of first, :end, :k with range returns the expected item");
    is(@list.first(4..^6, :end, :k), 4, "method form of first, :end, :k with range returns the expected item");
}

{
    my @fancy_list = (1, 2, "Hello", 3/4, 4.Num);
    is @fancy_list.first(Str, :end, :k), 2, "first by type Str works";
    is @fancy_list.first(Int, :end, :k), 1, "first by type Int works";
    is @fancy_list.first(Rat, :end, :k), 3, "first by type Rat works";
}

{
    my @fancy_list = <Philosopher Goblet Prince>;
    is @fancy_list.first(/o/, :end, :k),    1, "first by regex /o/";
    is @fancy_list.first(/ob/, :end, :k),   1, "first by regex /ob/";
    is @fancy_list.first(/l.*o/, :end, :k), 0, "first by regex /l.*o/";
}

{
    is <a b c b a>.first('c' | 'b', :end, :k),
        3, '.first, :end, :k also takes a junction as matcher';

    is (first 'c'|'b', <a b c b a>, :end, :k),
        3, '.first, :end, :k also takes a junction as matcher (sub form)';
}

# Bool handling
{
    throws-like { first $_ == 1, 1,2,3, :end, :k }, X::Match::Bool;
    throws-like { (1,2,3).first: $_== 1, :end, :k }, X::Match::Bool;
    is first( Bool,True,False,Int, :end, :k ), 1, 'can we match on Bool as type';
    is (True,False,Int).first(Bool, :end, :k), 1, 'can we match on Bool as type';
}

# :!k handling
{
    is (^10).first(Int, :!k), 0, 'is :!k the same as no attribute';
}

#vim: ft=perl6
