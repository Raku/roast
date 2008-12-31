use v6;
use Test;

# L<S09/"Autovivification">

plan 39;

{
  my %hash;
  %hash<a>;
  ok !%hash.exists('a'), 'just mentioning a hash value should not autovivify it';
}

{
  my %hash;

  %hash<key>[42] = 17;
  is %hash<key>[42], 17, "autovivification of a hash element to an arrayref worked";
}

{
  my %hash;

  %hash<key><innerkey> = 17;
  is %hash<key><innerkey>, 17, "autovivification of a hash element to a hashref worked";
}

# Autovification by push, unshift, etc.
{
  my $arrayref;

  push $arrayref, 1,2,3;
  is ~$arrayref, "1 2 3", "autovivification to an array by &push";
}

{
  my $arrayref;

  unshift $arrayref, 1,2,3;
  is ~$arrayref, "1 2 3", "autovivification to an array by &unshift";
}

# Autovification by push, unshift, etc. of an array/hash element
{
  my @array;

  push @array[2], 1,2,3;
  is ~@array, "  1 2 3", "autovivification of an array element to an array by &push";
}

{
  my %hash;

  push %hash<key>, 1,2,3;
  is ~%hash, "key\t1 2 3\n", "autovivification of an hash element to an array by &push";
}
# Simple hash autovivification
{
  my $hashref;
  ok !$hashref.isa(Hash), "uninitialized variable is not a Hash (1)";

  $hashref<key> = 23;
  ok $hashref.isa(Hash), "uninitialized variable was autovivified to a hash (1)";
  is $hashref<key>,  23, "hash element assignment worked";
}

{
  my $hashref;
  ok !$hashref.isa(Hash), "uninitialized variable is not a Hash (2)";

# Note that 
#    Autovivification will only happen if the *vivifiable* *path* is used as a container
#    ... value extraction does not autovivify.
  lives_ok { my $elem = $hashref<key> },
    "accessing a not existing hash element of an uninitialized variable works";
  ok !$hashref.isa(Hash), "uninitialized variable is not autovivified to a hash (2)";

  my $hashref2;
  lives_ok { my $elem2 = $hashref2<key2><a><b><c><d><e><f> },
    "accessing a not existing hash element of an uninitialized variable works (2)";
  ok !$hashref2.isa(Hash), "uninitialized variable is not autovivified to a hash (3)";
  ok !$hashref2<key2><a><b><c><d><e>.isa(Hash), "uninitialized variable is not autovivified to a hash (4)";
  
}

{
  my $hashref;
  ok !$hashref.isa(Hash), "uninitialized variable is not a Hash (3)";

  lives_ok { my $elem := $hashref<key> },
    "binding a not existing hash element of an uninitialized variable works";
  ok $hashref.isa(Hash), "uninitialized variable is autovivified to a hash (4)";

  lives_ok { my $elem2 := $hashref<key2><a><b><c><d><e><f> },
    "binding a not existing hash element of an uninitialized variable works (2)";
  ok $hashref<key2><a><b><c><d><e>.isa(Hash), "uninitialized variable is autovivified to a hash (5)";
}

# Simple array autovivification
{
  my $arrayref;
  ok !$arrayref.isa(Array), "uninitialized variable is not an Array (1)";

  $arrayref[42] = 23;
  ok $arrayref.isa(Array), "uninitialized variable was autovivified to an array (1)";
  is $arrayref[42],    23, "array element assignment worked";
}

{
  my $arrayref;
  ok !$arrayref.isa(Array), "uninitialized variable is not an Array (2)";

# Note that 
#    Autovivification will only happen if the *vivifiable* *path* is used as a container
#    ... value extraction does not autovivify.
  lives_ok { my $elem = $arrayref[42] },
    "accessing a not existing array element of an uninitialized variable works";
  ok !$arrayref.isa(Array), "uninitialized variable was not autovivified to an array (2)";

  my $arrayref2;
  lives_ok { my $elem = $arrayref2[1][2][3][4][5][6] },
    "accessing a not existing array element of an uninitialized variable works";
  ok !$arrayref2.isa(Array), "uninitialized variable was not autovivified to an array (3)";
  ok !$arrayref2[1][2][3][4][5].isa(Array), "uninitialized variable was not autovivified to an array (4)";
}

{
  my $arrayref;
  ok !$arrayref.isa(Array), "uninitialized variable is not an Array (3)";

  lives_ok { my $elem := $arrayref[42] },
    "binding a not existing array element of an uninitialized variable works (1)";
  ok $arrayref.isa(Array), "uninitialized variable is autovivified to an array (1)";

  lives_ok { my $elem2 := $arrayref[1][2][3][4][5][6] },
    "binding a not existing array element of an uninitialized variable works (2)";
  ok $arrayref[1][2][3][4][5].isa(Array), "uninitialized variable is autovivified to an array (2)";
}


# Autovivification of an array/hash element
{
  my @array;

  @array[42][23] = 17;
  is @array[42][23], 17, "autovivification of an array element to an arrayref worked";
}

{
  my @array;

  @array[42]<key> = 17;
  is @array[42]<key>, 17, "autovivification of an array element to a hashref worked";
}


lives_ok {
  &New::Package::foo;
  # this is ok, as you don't have to predeclare globally qualified variables
}, "using an undeclared globaly qualified code variable in void context is ok";

dies_ok {
  &New::Package::foo();
}, "...but invoking undeclared globally qualifed code variable should die";
