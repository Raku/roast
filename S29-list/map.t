use v6;
use Test;
plan 60;

# L<S29/"List"/"=item map">

=begin pod

 built-in map tests

=end pod


my @list = (1 .. 5);

{
    my @result = map { $_ * 2 }, @list;
    is(+@result, 5, 'we got a list back');
    is(@result[0], 2, 'got the value we expected');
    is(@result[1], 4, 'got the value we expected');
    is(@result[2], 6, 'got the value we expected');
    is(@result[3], 8, 'got the value we expected');
    is(@result[4], 10, 'got the value we expected');
}

#?rakudo skip "adverbial block"
{
    my @result = @list.map():{ $_ * 2 };
    is(+@result, 5, 'we got a list back');
    is(@result[0], 2, 'got the value we expected');
    is(@result[1], 4, 'got the value we expected');
    is(@result[2], 6, 'got the value we expected');
    is(@result[3], 8, 'got the value we expected');
    is(@result[4], 10, 'got the value we expected');
}

{
    my @result = @list.map: { $_ * 2 };
    is(+@result, 5, 'we got a list back');
    is(@result[0], 2, 'got the value we expected');
    is(@result[1], 4, 'got the value we expected');
    is(@result[2], 6, 'got the value we expected');
    is(@result[3], 8, 'got the value we expected');
    is(@result[4], 10, 'got the value we expected');
}

#?rakudo skip "closure as non-final argument"
{
    my @result = map { $_ * 2 }: @list;
    is(+@result, 5, 'we got a list back');
    is(@result[0], 2, 'got the value we expected');
    is(@result[1], 4, 'got the value we expected');
    is(@result[2], 6, 'got the value we expected');
    is(@result[3], 8, 'got the value we expected');
    is(@result[4], 10, 'got the value we expected');
}

# Testing map that returns an array
{
    my @result = map { ($_, $_ * 2) }, @list;
    is(+@result, 10, 'we got a list back');
    is(@result[0], 1, 'got the value we expected');
    is(@result[1], 2, 'got the value we expected');
    is(@result[2], 2, 'got the value we expected');
    is(@result[3], 4, 'got the value we expected');
    is(@result[4], 3, 'got the value we expected');
    is(@result[5], 6, 'got the value we expected');
    is(@result[6], 4, 'got the value we expected');
    is(@result[7], 8, 'got the value we expected');
    is(@result[8], 5, 'got the value we expected');
    is(@result[9], 10, 'got the value we expected');
}

# Testing multiple statements in the closure
{
    my @result = map {
         my $fullpath = "fish/$_";
         $fullpath;
    }, @list;
    is(+@result, 5, 'we got a list back');
    is(@result[0], "fish/1", 'got the value we expected');
    is(@result[1], "fish/2", 'got the value we expected');
    is(@result[2], "fish/3", 'got the value we expected');
    is(@result[3], "fish/4", 'got the value we expected');
    is(@result[4], "fish/5", 'got the value we expected');
}

{
    my @list = 1 .. 5;
    is +(map {;$_ => 1 }, @list), 5,
            'heuristic for block - looks like a closure';

    my %result = map {; $_ => ($_*2) }, @list;
    isa_ok(%result, 'Hash');
    is(%result<1>, 2,  'got the value we expected');
    is(%result<2>, 4,  'got the value we expected');
    is(%result<3>, 6,  'got the value we expected');
    is(%result<4>, 8,  'got the value we expected');
    is(%result<5>, 10, 'got the value we expected');
}

# map with n-ary functions
#?rakudo skip "adverbial block"
{
  is ~(1,2,3,4).map:{ $^a + $^b             }, "3 7", "map() works with 2-ary functions";
  is ~(1,2,3,4).map:{ $^a + $^b + $^c       }, "6 4", "map() works with 3-ary functions";
  is ~(1,2,3,4).map:{ $^a + $^b + $^c + $^d }, "10",  "map() works with 4-ary functions";
  is ~(1,2,3,4).map:{ $^a+$^b+$^c+$^d+$^e   }, "10",  "map() works with 5-ary functions";
}

# .map shouldn't work on non-arrays
## XXX pmichaud, 2008-07-01:  .map should work on non-list values
{
  #?pugs 2 todo 'bug'
  dies_ok { 42.map: { $_ } },    "method form of map should not work on numbers";
  dies_ok { "str".map: { $_ } }, "method form of map should not work on strings";
  #?rakudo skip "adverbial block"
  is ~(42,).map:{ $_ }, "42",   "method form of map should work on arrays";
};

=begin pod

Test that a constant list can have C<map> applied to it.

  ("foo","bar").map: { $_.substr(1,1) }

should be equivalent to

  my @val = ("foo","bar");
  @val = map { substr($_,1,1) }, @val;

=end pod

##  XXX pmichaud, 2008-07-01:   As the test is written below, the
##    @expected and "map of ..." arguments are arguments of .map(...)
##    and not of is(...).  See S12:406.
#?rakudo skip "syntax error in test"
{
  my @expected = ("foo","bar");
  @expected = map { substr($_,1,1) }: @expected;

  is(("foo","bar").map: { $_.substr(1,1) }, @expected, "map of constant list works");
}


#?rakudo skip '{} hash composer not implemented'
{
  my @a = (1, 2, 3); 
  # XXX is hash { ... } legal?
  my @b = map { hash {"v"=>$_, "d" => $_*2} }, @a; 
  is(+@b,3, "should be 3 elemens");

  my @c = map { {"v"=>$_, "d" => $_*2} }, @a;
#?pugs todo 'unimpl'
  is(+@c,3, "should be 3 elemens without the hash keyword as well");
}

# Map with mutating block
# L<S02/Names/"$_, $!, and $/ are context<rw> by default">

{
  my @array = <a b c d>;
  is ~(try { @array.map: { $_ ~= "c"; $_ ~ "d" } }), "acd bcd ccd dcd",
    'mutating $_ in map works (1)';
  is ~@array, "ac bc cc dc",
    'mutating $_ in map works (2)';
}

# vim: ft=perl6
