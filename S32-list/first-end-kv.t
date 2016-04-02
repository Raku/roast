use v6;
use Test;

# L<S32::Containers/"List"/"=item first">

plan 24;

my @list = (1 ... 10);

{
    my $result = first { $^a % 2 }, @list, :end, :kv;
    ok $result ~~ List, "first(, :end, :kv) returns a List";
    is $result, (8, 9), "returned value by first() is correct";
}

{
    my $result = first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :end, :kv;
    ok $result ~~ List, "first(, :end, :kv) returns an List";
    is $result, (6, 7), "returned value by first(, :end, :kv) is correct";
}

{
    my $result = @list.first( { $^a == 4}, :end, :kv );
    ok $result ~~ List, "method form of first, :end, :kv returns a List";
    is $result, (3, 4), "method form of first, :end, :kv returns expected item";
}

{
    ok @list.first( { $^a == 11 }, :end, :kv ) =:= Nil, 'first, :end, :kv returns Nil on unsuccessful match';
}

{
    my $count = 0;
    my $matcher = sub (Int $x) { $count++; $x % 2 };
    is @list.first($matcher, :end, :kv), (8, 9),
      'first(, :end, :kv) search for odd elements successful';
    is $count, 2,
      'Matching closure in first(, :end, :kv) is only executed twice';
}

{
    is @list.first(4..6, :end, :kv), (5, 6),
      "method form of first, :end, :kv with range returns the expected item";
    is @list.first(4..^6, :end, :kv), (4, 5),
      "method form of first, :end, :kv with range returns the expected item";
}

{
    my @fancy_list = (1, 2, "Hello", 3/4, 4.Num);
    is @fancy_list.first(Str, :end, :kv), (2, "Hello"), "first by type Str works";
    is @fancy_list.first(Int, :end, :kv), (1, 2),       "first by type Int works";
    is @fancy_list.first(Rat, :end, :kv), (3, 3/4),     "first by type Rat works";
}

{
    my @fancy_list = <Philosopher Goblet Prince>;
    is @fancy_list.first(/o/, :end, :kv),    (1, 'Goblet'),
      "first by regex /o/";
    is @fancy_list.first(/ob/, :end, :kv),   (1, 'Goblet'),
      "first by regex /ob/";
    is @fancy_list.first(/l.*o/, :end, :kv), (0, 'Philosopher'),
      "first by regex /l.*o/";
}

{
    is <a b c b a>.first('c' | 'b', :end, :kv),
        (3, 'b'), '.first, :end, :kv also takes a junction as matcher';

    is (first 'c'|'b', <a b c b a>, :end, :kv),
        (3, 'b'), '.first, :end, :kv also takes a junction as matcher (sub form)';
}

# Bool handling
{
    throws-like { first $_ == 1, 1,2,3, :end, :kv }, X::Match::Bool;
    throws-like { (1,2,3).first: $_== 1, :end, :kv }, X::Match::Bool;
    is first( Bool,True,False,Int, :end, :kv ), (1, False),
      'can we match on Bool as type';
    is (True,False,Int).first(Bool, :end, :kv), (1, False),
      'can we match on Bool as type';
}

# :!v handling
{
    is @list.first(Int, :end, :!kv), 10, 'is :!kv the same as no attribute';
}

#vim: ft=perl6
