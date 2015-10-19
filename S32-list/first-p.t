use v6;
use Test;

# L<S32::Containers/"List"/"=item first">

plan 24;

my @list = (1 ... 10);

{
    my $result = first { $^a % 2 }, @list, :p;
    ok $result ~~ Pair, "first() returns an Pair";
    is $result, 0=>1, "returned value by first() is correct";
}

{
    my $result = first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :p;
    ok $result ~~ Pair, "first() returns an Pair";
    is $result, 0=>1, "returned value by first() is correct";
}

{
    my $result = @list.first( { $^a == 4}, :p );
    ok $result ~~ Pair, "method form of first returns an Pair";
    is $result, 3=>4, "method form of first returns the expected item";
}

{
    ok @list.first( { $^a == 11 }, :p ) =:= Nil, 'first returns Nil on unsuccessful match';
}

{
    my $count = 0;
    my $matcher = sub (Int $x) { $count++; $x % 2 };
    is @list.first($matcher, :p), 0=>1,
      'first() search for odd elements successful';
    is $count, 1, 'Matching closure in first() is only executed once';
}

{
    is @list.first(4..6, :p), 3=>4,
      "method form of first with range returns the expected item";
    is @list.first(4^..6, :p), 4=>5,
      "method form of first with range returns the expected item";
}

{
    my @fancy_list = (1, 2, "Hello", 3/4, 4.Num);
    is @fancy_list.first(Str, :p), 2=>"Hello", "first by type Str works";
    is @fancy_list.first(Int, :p), 0=>1,       "first by type Int works";
    is @fancy_list.first(Rat, :p), 3=>3/4,     "first by type Rat works";
}

{
    my @fancy_list = <Philosopher Goblet Prince>;
    is @fancy_list.first(/o/, :p),    0=>'Philosopher', "first by regex /o/";
    is @fancy_list.first(/ob/, :p),   1=>'Goblet', "first by regex /ob/";
    is @fancy_list.first(/l.*o/, :p), 0=>'Philosopher', "first by regex /l.*o/";
}

{
    is <a b c b a>.first('c' | 'b', :p), 1=>'b',
      '.first also takes a junction as matcher';

    is (first 'c'|'b', <a b c b a>, :p), 1=>'b',
      '.first also takes a junction as matcher (sub form)';
}

# Bool handling
{
    throws-like { first $_ == 1, 1,2,3, :p }, X::Match::Bool;
    throws-like { (1,2,3).first: $_== 1, :p }, X::Match::Bool;
    is first( Bool,True,False,Int, :p ), 0=>True,
      'can we match on Bool as type';
    is (True,False,Int).first(Bool, :p), 0=>True,
      'can we match on Bool as type';
}

# :!p handling
{
    is (^10).first(Int, :!p), 0, 'is :!p the same as no attribute';
}

#vim: ft=perl6
