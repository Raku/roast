use v6;
use Test;

# L<S09/"Autovivification">

plan 44;

{
  my %hash;
  %hash<a>;
  ok %hash<a>:!exists, 'just mentioning a hash value should not autovivify it';
}

{
  my %hash;

  %hash<key>[42] = 17;
  is %hash<key>[42], 17, "autovivification of a hash element to an arrayitem worked";
  is +%hash.keys, 1, 'Created one hash item';
}

# https://github.com/Raku/old-issue-tracker/issues/538
{
  my %hash;

  %hash<key><innerkey> = 17;
  is %hash<key><innerkey>, 17, "autovivification of a hash element to a hashitem worked";
  isa-ok %hash<key>, Hash, 'Inner hash item is really a Hash';
}

# Autovification by push, unshift, etc.
# XXX I understand that @array[0].push(...) should autovivify an Array
# in @array[0], but is that also true for a normal scalar?
{
  my $arrayitem;

  push $arrayitem, 1,2,3;
  is ~$arrayitem, "1 2 3", "autovivification to an array by &push";
  isa-ok $arrayitem, Array, 'autovivified to Array';
}

{
  my $arrayitem;

  unshift $arrayitem, 1,2,3;
  is ~$arrayitem, "1 2 3", "autovivification to an array by &unshift";
}

# Autovification by push, unshift, etc. of an array/hash element
# L<S09/Autovivification/"push, unshift, .[]">
{
  my @array;

  push @array[2], 1,2,3;
  is ~@array, "  1 2 3", "autovivification of an array element to an array by &push";
}

# https://github.com/Raku/old-issue-tracker/issues/2367
{
  my %hash;

  push %hash<key>, 1,2,3;
  is ~%hash, "key\t1 2 3", "autovivification of an hash element to an array by &push";
}

# Simple hash autovivification
{
  my $hashitem;
  ok $hashitem !~~ Hash, "uninitialized variable is not a Hash (1)";

  $hashitem<key> = 23;
  is $hashitem<key>,  23, "hash element assignment worked";
  #?rakudo skip 'isa multi variant'
  ok $hashitem.isa !~~ Hash, "uninitialized variable was autovivified to a hash (1)";
}

{
  my $hashitem;
  ok $hashitem !~~ Hash, "uninitialized variable is not a Hash (2)";

# Note that 
#    Autovivification will only happen if the *vivifiable* *path* is used as a container
#    ... value extraction does not autovivify.
  lives-ok { my $elem = $hashitem<key> },
    "accessing a not existing hash element of an uninitialized variable works";
  ok $hashitem !~~ Hash, "uninitialized variable is not autovivified to a hash (2)";

  my $hashitem2;
  lives-ok { my $elem2 = $hashitem2<key2><a><b><c><d><e><f> },
    "accessing a not existing hash element of an uninitialized variable works (2)";
  ok $hashitem2 !~~ Hash, "uninitialized variable is not autovivified to a hash (3)";
  ok $hashitem2<key2><a><b><c><d><e> !~~ Hash, "uninitialized variable is not autovivified to a hash (4)";
}

{
  my $hashitem;
  ok $hashitem !~~ Hash, "uninitialized variable is not a Hash (3)";

  lives-ok { my $elem := $hashitem<key> },
    "binding a not existing hash element of an uninitialized variable works";
  #?rakudo todo 'autoviv, binding'
  ok $hashitem ~~ Hash, "uninitialized variable is autovivified to a hash (4)";

  lives-ok { my $elem2 := $hashitem<key2><a><b><c><d><e><f> },
    "binding a not existing hash element of an uninitialized variable works (2)";
  #?rakudo todo 'autoviv, binding'
  ok $hashitem<key2><a><b><c><d><e> ~~ Hash, "uninitialized variable is autovivified to a hash (5)";
}

# Simple array autovivification
{
  my $arrayitem;
  ok !$arrayitem.isa(Array), "uninitialized variable is not an Array (1)";

  $arrayitem[42] = 23;
  ok $arrayitem.isa(Array), "uninitialized variable was autovivified to an array (1)";
  is $arrayitem[42],    23, "array element assignment worked";
}

{
  my $arrayitem;
  ok !$arrayitem.isa(Array), "uninitialized variable is not an Array (2)";

# Note that 
#    Autovivification will only happen if the *vivifiable* *path* is used as a container
#    ... value extraction does not autovivify.
  lives-ok { my $elem = $arrayitem[42] },
    "accessing a not existing array element of an uninitialized variable works";
  ok !$arrayitem.isa(Array), "uninitialized variable was not autovivified to an array (2)";

  my $arrayitem2;
  lives-ok { my $elem = $arrayitem2[1][2][3][4][5][6] },
    "accessing a not existing array element of an uninitialized variable works";
  ok !$arrayitem2.isa(Array), "uninitialized variable was not autovivified to an array (3)";
  ok !$arrayitem2[1][2][3][4][5].isa(Array), "uninitialized variable was not autovivified to an array (4)";
}

{
  my $arrayitem;
  ok !$arrayitem.isa(Array), "uninitialized variable is not an Array (3)";

  lives-ok { my $elem := $arrayitem[42] },
    "binding a not existing array element of an uninitialized variable works (1)";
  #?rakudo todo 'unknown'
  ok $arrayitem.isa(Array), "uninitialized variable is autovivified to an array (1)";

  lives-ok { my $elem2 := $arrayitem[1][2][3][4][5][6] },
    "binding a not existing array element of an uninitialized variable works (2)";
  #?rakudo todo 'unknown'
  ok $arrayitem[1][2][3][4][5].isa(Array), "uninitialized variable is autovivified to an array (2)";
}


# Autovivification of an array/hash element
{
  my @array;

  @array[42][23] = 17;
  is @array[42][23], 17, "autovivification of an array element to an arrayitem worked";
}

{
  my @array;

  @array[42]<key> = 17;
  is @array[42]<key>, 17, "autovivification of an array element to a hashitem worked";
}


lives-ok {
  &New::Package::foo;
  # this is ok, as you don't have to predeclare globally qualified variables
}, "using an undeclared globaly qualified code variable in void context is ok";

dies-ok {
  &New::Package::foo();
}, "...but invoking undeclared globally qualifed code variable should die";

{
    my @array;

    @array[42;23] = 17;
    is @array[42][23], 17, "autovivificaion of arrays works via multidim syntax";
}

{
  my %hash;

  %hash{'key';'innerkey'} = 17;
  is %hash<key><innerkey>, 17, "autovivification of hashes works via multidim syntax";
}

# vim: expandtab shiftwidth=4
