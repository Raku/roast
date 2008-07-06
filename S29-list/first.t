use v6;
use Test;

# L<S29/"List"/"=item first">

=begin pod

built-in "first" tests

=end pod

plan 9;

my @list = (1 .. 10);

{
    my $result = first { ($_ % 2) }, @list;
    ok($result ~~ Int, "first() returns an Int");
    is($result, 1, "returned value by first() is correct");
}

{
    my $result = @list.first( { ($_ == 4)});
    ok($result ~~ Int, "method form of first returns an Int");
    is($result, 4, "method form of first returns the expected item");
}

#?rakudo skip "adverbial block"
{
    my $result = @list.first():{ ($_ == 4) };
    ok($result ~~ Int, "first():<block> returns an Int");
    is($result, 4, "first() returned the expected value");
}

{
    is(@list.first( { ($_ == 11) }), undef, 'first returns undef unsuccessfull match');
}

#?rakudo skip "closures temporarily not working (RT #56612)"
{
    my $count = 0;
    my $matcher = sub (Int $x) { $count++; $x % 2 };
    is(@list.first($matcher), 1, 'first() search for odd elements successfull');
    is($count, 1, 'Matching closure in first() is only executed once');
}
