use v6.c;
use Test;

# L<S32::Containers/"List"/"=item first">

plan 24;

my @list = (1 ... 10);

{
    my $result = first { $^a % 2 }, @list, :end;
    ok $result ~~ Int, "first(, :end) returns an Int";
    is $result, 9, "returned value by first() is correct";
}

{
    my $result = first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :end;
    ok $result ~~ Int, "first(, :end) returns an Int";
    is $result, 7, "returned value by first(, :end) is correct";
}

{
    my $result = @list.first( { $^a == 4}, :end );
    ok $result ~~ Int, "method form of first, :end returns an Int";
    is $result, 4, "method form of first, :end returns expected item";
}

{
    ok @list.first( { $^a == 11 }, :end ) =:= Nil, 'first, :end returns Nil on unsuccessful match';
}

{
    my $count = 0;
    my $matcher = sub (Int $x) { $count++; $x % 2 };
    is @list.first($matcher, :end), 9,
      'first(, :end) search for odd elements successful';
    is $count, 2,
      'Matching closure in first(, :end) is only executed twice';
}

{
    is @list.first(4..6, :end), 6,
      "method form of first, :end with range returns the expected item";
    is @list.first(4..^6, :end), 5,
      "method form of first, :end with range returns the expected item";
}

{
    my @fancy_list = (1, 2, "Hello", 3/4, 4.Num);
    is @fancy_list.first(Str, :end), "Hello", "first by type Str works";
    is @fancy_list.first(Int, :end), 2,       "first by type Int works";
    is @fancy_list.first(Rat, :end), 3/4,     "first by type Rat works";
}

{
    my @fancy_list = <Philosopher Goblet Prince>;
    is @fancy_list.first(/o/, :end),    'Goblet',
      "first by regex /o/";
    is @fancy_list.first(/ob/, :end),   'Goblet',
      "first by regex /ob/";
    is @fancy_list.first(/l.*o/, :end), 'Philosopher',
      "first by regex /l.*o/";
}

{
    is <a b c b a>.first('c' | 'b', :end),
        'b', '.first, :end also takes a junction as matcher';

    is (first 'c'|'b', <a b c b a>, :end),
        'b', '.first, :end also takes a junction as matcher (sub form)';
}

# Bool handling
{
    throws-like { first $_ == 1, 1,2,3, :end }, X::Match::Bool;
    throws-like { (1,2,3).first: $_== 1, :end }, X::Match::Bool;
    is first( Bool,True,False,Int, :end ), False,
      'can we match on Bool as type';
    is (True,False,Int).first(Bool, :end), False,
      'can we match on Bool as type';
}

# :!end handling
{
    is (^10).first(Int, :!end), 0, 'is :!end the same as no attribute';
}

#vim: ft=perl6
