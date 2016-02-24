use v6.c;
use Test;

# L<S32::Containers/"List"/"=item first">

plan 24;

my @list = (1 ... 10);

{
    my $result = first { $^a % 2 }, @list, :v;
    ok $result ~~ Int, "first() returns an Int";
    is $result, 1, "returned value by first() is correct";
}

{
    my $result = first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :v;
    ok $result ~~ Int, "first() returns an Int";
    is $result, 1, "returned value by first() is correct";
}

{
    my $result = @list.first( { $^a == 4}, :v );
    ok $result ~~ Int, "method form of first returns an Int";
    is $result, 4, "method form of first returns the expected item";
}

{
    ok @list.first( { $^a == 11 }, :v ) =:= Nil, 'first returns Nil on unsuccessful match';
}

{
    my $count = 0;
    my $matcher = sub (Int $x) { $count++; $x % 2 };
    is @list.first($matcher, :v), 1,
      'first() search for odd elements successful';
    is $count, 1, 'Matching closure in first() is only executed once';
}

{
    is @list.first(4..6, :v), 4,
      "method form of first with range returns the expected item";
    is @list.first(4^..6, :v), 5,
      "method form of first with range returns the expected item";
}

{
    my @fancy_list = (1, 2, "Hello", 3/4, 4.Num);
    is @fancy_list.first(Str, :v), "Hello", "first by type Str works";
    is @fancy_list.first(Int, :v), 1,       "first by type Int works";
    is @fancy_list.first(Rat, :v), 3/4,     "first by type Rat works";
}

{
    my @fancy_list = <Philosopher Goblet Prince>;
    is @fancy_list.first(/o/, :v),    'Philosopher', "first by regex /o/";
    is @fancy_list.first(/ob/, :v),   'Goblet', "first by regex /ob/";
    is @fancy_list.first(/l.*o/, :v), 'Philosopher', "first by regex /l.*o/";
}

{
    is <a b c b a>.first('c' | 'b', :v), 'b',
      '.first also takes a junction as matcher';

    is (first 'c'|'b', <a b c b a>, :v), 'b',
      '.first also takes a junction as matcher (sub form)';
}

# Bool handling
{
    throws-like { first $_ == 1, 1,2,3, :v }, X::Match::Bool;
    throws-like { (1,2,3).first: $_== 1, :v }, X::Match::Bool;
    is first( Bool,True,False,Int, :v ), True,
      'can we match on Bool as type';
    is (True,False,Int).first(Bool, :v), True,
      'can we match on Bool as type';
}

# :!v handling
{
    throws-like { (^10).first(Int, :!v) }, Exception;
}

#vim: ft=perl6
