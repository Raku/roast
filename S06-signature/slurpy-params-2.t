use v6;

use Test;

=begin pod

=head1 List parameter test

These tests are the testing for "List paameters" section of Synopsis 06

L<<S06/List parameters/Slurpy parameters follow any required>>

You might also be interested in the thread Calling positionals by name in
presence of a slurpy hash" on p6l started by Ingo
Blechschmidt L<http://www.nntp.perl.org/group/perl.perl6.language/22883>

=end pod

plan 26;

{
# Positional with slurpy *%h and slurpy *@a
my sub foo($n, *%h, *@a) { };
my sub foo1($n, *%h, *@a) { $n }
my sub foo2($n, *%h, *@a) { %h<x> + %h<y> + %h<n> }
my sub foo3($n, *%h, *@a) { @a.sum }

## all pairs will be slurped into hash, except the key which has the same name
## as positional parameter
diag('Testing with positional arguments');
lives_ok { foo 1, x => 20, y => 300, 4000 },
  'Testing: `sub foo($n, *%h, *@a){ }; foo 1, x => 20, y => 300, 4000`';
is (foo1 1, x => 20, y => 300, 4000), 1,
  'Testing the value for positional';
is (foo2 1, x => 20, y => 300, 4000), 320,
  'Testing the value for slurpy *%h';
is (foo3 1, x => 20, y => 300, 4000), 4000,
  'Testing the value for slurpy *@a';

dies_ok { foo 1, n => 20, y => 300, 4000 },
  'Testing: `sub foo($n, *%h, *@a){ }; foo 1, n => 20, y => 300, 4000`', :todo<bug>;

## We *can* pass positional arguments as a 'named' pair with slurpy *%h.
## Only *remaining* pairs are slurped into the *%h
# Note: with slurpy *@a, you can pass positional params, But will be slurped into *@a
diag('Testing without positional arguments');
lives_ok { foo n => 20, y => 300, 4000 },
  'Testing: `sub foo($n, *%h, *@a){ }; foo n => 20, y => 300, 4000`';
is (foo1 n => 20, y => 300, 4000), 20,
  'Testing the value for positional';
is (foo2 n => 20, y => 300, 4000), 300,
  'Testing the value for slurpy *%h';
is (foo3 n => 20, y => 300, 4000), 4000,
  'Testing the value for slurpy *@a';
}


{
my sub foo ($n, *%h) { };
## NOTE: *NOT* sub foo ($n, *%h, *@a)
dies_ok { foo 1, n => 20, y => 300 },
  'Testing: `sub foo($n, *%h) { }; foo 1, n => 20, y => 300`', :todo<bug>;
}

{
my sub foo ($n, *%h) { };
## NOTE: *NOT* sub foo ($n, *%h, *@a)
dies_ok { foo 1, x => 20, y => 300, 4000 },
  'Testing: `sub foo($n, *%h) { }; foo 1, x => 20, y => 300, 4000`';
}


# Named with slurpy *%h and slurpy *@a
# named arguments aren't required in tests below
{
my sub foo(:$n, *%h, *@a) { };
my sub foo1(:$n, *%h, *@a) { $n };
my sub foo2(:$n, *%h, *@a) { %h<x> + %h<y> + %h<n> };
my sub foo3(:$n, *%h, *@a) { return @a.sum };

diag("Testing with named arguments (named param isn't required)");
lives_ok { foo 1, x => 20, y => 300, 4000 },
  'Testing: `sub foo(:$n, *%h, *@a){ }; foo 1, x => 20, y => 300, 4000`';
is (foo1 1, x => 20, y => 300, 4000), undef,
  'Testing value for named argument';
is (foo2 1, x => 20, y => 300, 4000), 320,
  'Testing value for slurpy *%h';
is (foo3 1, x => 20, y => 300, 4000), 4001,
  'Testing the value for slurpy *@a';

### named parameter pair will always have a higher "priority" while passing
### so %h<n> will always be undef
lives_ok { foo1 1, n => 20, y => 300, 4000 },
  'Testing: `sub foo(:$n, *%h, *@a){ }; foo 1, n => 20, y => 300, 4000`';
is (foo1 1, n => 20, y => 300, 4000), 20,
  'Testing the named argument';
is (foo2 1, n => 20, y => 300, 4000), 300,
  'Testing value for slurpy *%h';
is (foo3 1, n => 20, y => 300, 4000), 4001,
  'Testing the value for slurpy *@a';
}


# named with slurpy *%h and slurpy *@a
## Named arguments **ARE** required in tests below

#### ++ version
{
my sub foo(:$n!, *%h, *@a){ };
diag('Testing with named arguments (named param is required) (++ version)');
lives_ok { foo 1, n => 20, y => 300, 4000 },
  'Testing: `my sub foo(+:$n, *%h, *@a){ }; foo 1, n => 20, y => 300, 4000 }`';
dies_ok { foo 1, x => 20, y => 300, 4000 }, :todo<bug>;
}

#### "trait" version
{
my sub foo(:$n is required, *%h, *@a) { };
diag('Testing with named arguments (named param is required) (trait version)');
lives_ok { foo 1, n => 20, y => 300, 4000 },
  'Testing: `my sub foo(:$n is required, *%h, *@a){ }; foo 1, n => 20, y => 300, 4000 }`';
dies_ok { foo 1, x => 20, y => 300, 4000 },
  'Testing: `my sub foo(:$n is required, *%h, *@a){ }; foo 1, x => 20, y => 300, 4000 }`', :todo<bug>;
}

##### Now slurpy scalar tests here.
=begin desc

=head1 List parameter test

These tests are the testing for "List paameters" section of Synopsis 06

L<<S06/List parameters/Slurpy scalar parameters capture what would otherwise be the first elements of the variadic array:>>

=end desc

sub first(*$f, *$s, *@r){ return $f };
sub second(*$f, *$s, *@r){ return $s };
sub rest(*$f, *$s, *@r){ return @r.sum };
diag 'Testing with slurpy scalar';
is first(1, 2, 3, 4, 5), 1,
  'Testing the first slurpy scalar...';
is second(1, 2, 3, 4, 5), 2,
  'Testing the second slurpy scalar...';
is rest(1, 2, 3, 4, 5), 12,
  'Testing the rest slurpy *@r';

# vim: ft=perl6
