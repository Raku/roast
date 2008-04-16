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
    ok($result ~~ Item, "first() returns an Item");
    is($result, 1, "returned value by first() is correct");
}

{
    my $result = @list.first( { ($_ == 4)});
    ok($result ~~ Item, "method form of first returns an item");
    is($result, 4, "method form of first returns the expected item");
}

{
    my $result = @list.first():{ ($_ == 4) };
    ok($result ~~ Item, "first():<block> returns an Item");
    is($result, 4, "first() returned the expected value");
}

{
	is(@list.first( { ($_ == 11) }), undef, 'first returns undef unsuccessfull match');
}

{
	my $count = 0;
	my $matcher = sub (Num $x) { $count++; return $x % 2 };
	is(@list.first($matcher), 1, 'first() search for odd elements successfull');
	is($count, 1, 'Matching closure in first() is only executed once');

}
