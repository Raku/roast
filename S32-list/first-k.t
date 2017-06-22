use v6;
use Test;

# L<S32::Containers/"List"/"=item first">

plan 25;

my @list = (1 ... 10);

{
    my $result = first { $^a % 2 }, |@list, :k;
    ok($result ~~ Int, "first() returns an Int");
    is($result, 0, "returned value by first() is correct");
}

{
    my $result = first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :k;
    ok($result ~~ Int, "first() returns an Int");
    is($result, 0, "returned value by first() is correct");
}


{
    my $result = @list.first( { $^a == 4}, :k );
    ok($result ~~ Int, "method form of first returns an Int");
    is($result, 3, "method form of first returns the expected item");
}

#?rakudo skip "adverbial block RT #124758"
{
    my $result = @list.first():{ $^a == 4 }, :k;
    ok($result ~~ Int, "first():<block> returns an Int");
    is($result, 3, "first() returned the expected value");
}

{
    ok @list.first( { $^a == 11 } ) =:= Nil, 'first returns Nil on unsuccessful match';
}

{
    my $count = 0;
    my $matcher = sub (Int $x) { $count++; $x % 2 };
    is(@list.first($matcher, :k), 0, 'first() search for odd elements successful');
    is($count, 1, 'Matching closure in first() is only executed once');
}

{
    is(@list.first(4..6, :k), 3, "method form of first with range returns the expected item");
    is(@list.first(4^..6, :k), 4, "method form of first with range returns the expected item");
}

{
    my @fancy_list = (1, 2, "Hello", 3/4, 4.Num);
    is @fancy_list.first(Str, :k), 2, "first by type Str works";
    is @fancy_list.first(Int, :k), 0, "first by type Int works";
    is @fancy_list.first(Rat, :k), 3, "first by type Rat works";
}

{
    my @fancy_list = <Philosopher Goblet Prince>;
    is @fancy_list.first(/o/, :k),    0, "first by regex /o/";
    is @fancy_list.first(/ob/, :k),   1, "first by regex /ob/";
    is @fancy_list.first(/l.*o/, :k), 0, "first by regex /l.*o/";
}

{
    is <a b c b a>.first('c' | 'b', :k),
        1, '.first also takes a junction as matcher';

    is (first 'c'|'b', <a b c b a>, :k),
        1, '.first also takes a junction as matcher (sub form)';
}

# Bool handling
{
    throws-like { first $_ == 1, 1,2,3, :k }, X::Match::Bool;
    throws-like { (1,2,3).first: $_== 1, :k }, X::Match::Bool;
    is first( Bool,True,False,Int, :k ), 0, 'can we match on Bool as type';
    is (True,False,Int).first(Bool, :k), 0, 'can we match on Bool as type';
}

#vim: ft=perl6
