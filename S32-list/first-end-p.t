use v6.c;
use Test;

# L<S32::Containers/"List"/"=item first">

plan 24;

my @list = (1 ... 10);

{
    my $result = first { $^a % 2 }, @list, :end, :p;
    ok $result ~~ Pair, "first(, :end, :p) returns an Pair";
    is $result, 8=>9, "returned value by first() is correct";
}

{
    my $result = first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :end, :p;
    ok $result ~~ Pair, "first(, :end, :p) returns an Pair";
    is $result, 6=>7, "returned value by first(, :end, :p) is correct";
}

{
    my $result = @list.first( { $^a == 4}, :end, :p );
    ok $result ~~ Pair, "method form of first, :end, :p returns an Pair";
    is $result, 3=>4, "method form of first, :end, :p returns expected item";
}

{
    ok @list.first( { $^a == 11 }, :end, :p ) =:= Nil, 'first, :end, :p returns Nil on unsuccessful match';
}

{
    my $count = 0;
    my $matcher = sub (Int $x) { $count++; $x % 2 };
    is @list.first($matcher, :end, :p), 8=>9,
      'first(, :end, :p) search for odd elements successful';
    is $count, 2,
      'Matching closure in first(, :end, :p) is only executed twice';
}

{
    is @list.first(4..6, :end, :p), 5=>6,
      "method form of first, :end, :p with range returns the expected item";
    is @list.first(4..^6, :end, :p), 4=>5,
      "method form of first, :end, :p with range returns the expected item";
}

{
    my @fancy_list = (1, 2, "Hello", 3/4, 4.Num);
    is @fancy_list.first(Str, :end, :p), 2=>"Hello", "first by type Str works";
    is @fancy_list.first(Int, :end, :p), 1=>2,       "first by type Int works";
    is @fancy_list.first(Rat, :end, :p), 3=>3/4,     "first by type Rat works";
}

{
    my @fancy_list = <Philosopher Goblet Prince>;
    is @fancy_list.first(/o/, :end, :p),    1=>'Goblet',
      "first by regex /o/";
    is @fancy_list.first(/ob/, :end, :p),   1=>'Goblet',
      "first by regex /ob/";
    is @fancy_list.first(/l.*o/, :end, :p), 0=>'Philosopher',
      "first by regex /l.*o/";
}

{
    is <a b c b a>.first('c' | 'b', :end, :p),
        3=>'b', '.first, :end, :p also takes a junction as matcher';

    is (first 'c'|'b', <a b c b a>, :end, :p),
        3=>'b', '.first, :end, :p also takes a junction as matcher (sub form)';
}

# Bool handling
{
    throws-like { first $_ == 1, 1,2,3, :end, :p }, X::Match::Bool;
    throws-like { (1,2,3).first: $_== 1, :end, :p }, X::Match::Bool;
    is first( Bool,True,False,Int, :end, :p ), 1=>False,
      'can we match on Bool as type';
    is (True,False,Int).first(Bool, :end, :p), 1=>False,
      'can we match on Bool as type';
}

# :!p handling
{
    is (^10).first(Int, :end, :!p), 9, 'is :!p the same as no attribute';
}

#vim: ft=perl6
