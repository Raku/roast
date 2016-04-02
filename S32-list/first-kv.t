use Test;

# L<S32::Containers/"List"/"=item first">

plan 24;

my @list = (1 ... 10);

{
    my $result = first { $^a % 2 }, @list, :kv;
    ok $result ~~ List, "first() returns an List";
    is $result, (0, 1), "returned value by first() is correct";
}

{
    my $result = first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :kv;
    ok $result ~~ List, "first() returns an List";
    is $result, (0,1), "returned value by first() is correct";
}

{
    my $result = @list.first( { $^a == 4}, :kv );
    ok $result ~~ List, "method form of first returns an List";
    is $result, (3, 4), "method form of first returns the expected item";
}

{
    ok @list.first( { $^a == 11 }, :kv ) =:= Nil, 'first returns Nil on unsuccessful match';
}

{
    my $count = 0;
    my $matcher = sub (Int $x) { $count++; $x % 2 };
    is @list.first($matcher, :kv), (0, 1),
      'first() search for odd elements successful';
    is $count, 1, 'Matching closure in first() is only executed once';
}

{
    is @list.first(4..6, :kv), (3, 4),
      "method form of first with range returns the expected item";
    is @list.first(4^..6, :kv), (4, 5),
      "method form of first with range returns the expected item";
}

{
    my @fancy_list = (1, 2, "Hello", 3/4, 4.Num);
    is @fancy_list.first(Str, :kv), (2, "Hello"), "first by type Str works";
    is @fancy_list.first(Int, :kv), (0, 1),       "first by type Int works";
    is @fancy_list.first(Rat, :kv), (3, 3/4),     "first by type Rat works";
}

{
    my @fancy_list = <Philosopher Goblet Prince>;
    is @fancy_list.first(/o/, :kv),    (0, 'Philosopher'), "first by regex /o/";
    is @fancy_list.first(/ob/, :kv),   (1, 'Goblet'), "first by regex /ob/";
    is @fancy_list.first(/l.*o/, :kv), (0, 'Philosopher'), "first by regex /l.*o/";
}

{
    is <a b c b a>.first('c' | 'b', :kv), (1, 'b'),
      '.first also takes a junction as matcher';

    is (first 'c'|'b', <a b c b a>, :kv), (1, 'b'),
      '.first also takes a junction as matcher (sub form)';
}

# Bool handling
{
    throws-like { first $_ == 1, 1,2,3, :kv }, X::Match::Bool;
    throws-like { (1,2,3).first: $_== 1, :kv }, X::Match::Bool;
    is first( Bool,True,False,Int, :kv ), (0, True),
      'can we match on Bool as type';
    is (True,False,Int).first(Bool, :kv), (0, True),
      'can we match on Bool as type';
}

# :!kv handling
{
    is @list.first(Int, :!kv), 1, 'is :!kv the same as no attribute';
}

#vim: ft=perl6
