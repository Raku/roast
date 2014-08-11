use v6;
use Test;

# L<S32::Containers/"List"/"=item first">

plan 27;

my @list = (1 ... 10);

{
    my $result = first { ($^a % 2) }, |@list;
    ok($result ~~ Int, "first() returns an Int");
    is($result, 1, "returned value by first() is correct");
}

{
    my $result = first { ($^a % 2) }, 1, 2, 3, 4, 5, 6, 7, 8;
    ok($result ~~ Int, "first() returns an Int");
    is($result, 1, "returned value by first() is correct");
}


{
    my $result = @list.first( { ($^a == 4)});
    ok($result ~~ Int, "method form of first returns an Int");
    is($result, 4, "method form of first returns the expected item");
}

#?rakudo skip "adverbial block"
#?niecza skip 'No value for parameter Mu $filter in CORE Any.first'
{
    my $result = @list.first():{ ($^a == 4) };
    ok($result ~~ Int, "first():<block> returns an Int");
    is($result, 4, "first() returned the expected value");
}

{
    nok(@list.first( { ($^a == 11) }).defined, 'first returns undefined unsuccessful match');
}

{
    my $count = 0;
    my $matcher = sub (Int $x) { $count++; $x % 2 };
    is(@list.first($matcher), 1, 'first() search for odd elements successful');
    is($count, 1, 'Matching closure in first() is only executed once');
}

{
    is(@list.first(4..6), 4, "method form of first with range returns the expected item");
    is(@list.first(4^..6), 5, "method form of first with range returns the expected item");
}

{
    my @fancy_list = (1, 2, "Hello", 3/4, 4.Num);
    is(@fancy_list.first(Str), "Hello", "Looking up first by type Str works");
    is(@fancy_list.first(Int), 1, "Looking up first by type Int works");
    is(@fancy_list.first(Rat), 3/4, "Looking up first by type Rat works");
}

{
    my @fancy_list = <Philosopher Goblet Prince>;
    is(@fancy_list.first(/o/), "Philosopher", "Looking up first by regex /o/");
    is(@fancy_list.first(/ob/), "Goblet", "Looking up first by regex /ob/");
    is(@fancy_list.first(/l.*o/), "Philosopher", "Looking up first by regex /l.*o/");
}

{
    is <a b c b a>.first('c' | 'b').join('|'),
        'b', '.first also takes a junction as matcher';

    is (first 'c'| 'b', <a b c b a>).join('|'),
        'b', '.first also takes a junction as matcher (sub form)';
}

# RT #118141
#?niecza skip 'https://github.com/sorear/niecza/issues/183'
{
    isa_ok (first * > 20, @list), Nil, "first() returns Nil when no values match";
    isa_ok @list.first(* < 0 ), Nil, ".first returns Nil when no values match"
}

# Bool handling
{
    throws_like { first $_ == 1, 1,2,3 }, X::Match::Bool;
    throws_like { (1,2,3).first: $_== 1 }, X::Match::Bool;
    is first( Bool,True,False,Int ), True, 'can we match on Bool as type';
    is (True,False,Int).first(Bool), True, 'can we match on Bool as type';
}

#vim: ft=perl6
