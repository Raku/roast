use v6;

use MONKEY_TYPING;

use Test;

# L<S02/Lists>
# XXX -- Lists are not real datatypes, but I haven't found a better location
# for this test. See
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22924">

plan 28;

# Indexing lists

# RT #105368
{
  my $foo = 42;

  try { ($foo, "does_not_matter")[0] = 23 };
  is $foo, 23, "assigning a list element changed the original variable";
}

{
  my $foo = 42;

  is ($foo, "does_not_matter")[*-2], 42,
    "indexing lists by a negative index works correctly";
  eval_dies_ok(q/my @a = <one two>; @a[-1] = 'zero'; @a.perl/,
 	"indexing lists by a negative index without the * dies");
}

# List construction does not create new containers
{
  my $foo = 42;

  ok ($foo, "does_not_matter")[0] =:= $foo,
    "list construction should not create new containers";
}

{
  my $foo = 42;
  ok ($foo, "does_not_matter", 17)[0,1][0] =:= $foo,
    "list construction and list slicing should not create new containers";
}

# Lists as lvalues
{
  my $foo = 42;
  my $bar = 43;

  ($foo, $bar) = (23, 24);
  ok $foo == 23 && $bar eq 24,
    "using lists as lvalues works";
}

{
  my $foo = 42;
  
  lives_ok { ($foo, *) = (23, 24) },
    "using lists with embedded Whatevers as lvalues works (1)";
  ok $foo == 23,
    "using lists with embedded Whatevers as lvalues works (2)";
}

# List slices as lvalues
{
  my $foo = 42;
  my $bar = 43;

  try { ($foo, 42, $bar, 19)[0, 2] = (23, 24) };
  ok $foo == 23 && $bar == 24,
    "using list slices as lvalues works (1)";

  dies_ok { ($foo, 42, $bar, 19)[1, 3] = (23, 24) },
    "using list slices as lvalues works (2)";
}

# Lists as lvalues used to swap variables
{
  my $foo = 42;
  my $bar = 23;

  ($foo, $bar) = ($bar, $foo);
  ok $foo == 23 && $bar == 42,
    "using lists as lvalues to swap two variables works";
}

{
  my $foo = 1;
  my $bar = 2;
  my $baz = 3;

  ($foo, $bar, $baz) = ($baz, $foo, $bar);
  ok $foo == 3 && $bar == 1 && $baz == 2,
    "using lists as lvalues to swap three variables works";
}

# Lists as lvalues to swap, this time we use binding instead of assignment
#?rakudo skip 'list binding'
#?niecza skip 'Cannot use bind operator with this LHS'
{
  my $foo = 42;
  my $bar = 23;

  ($foo, $bar) := ($bar, $foo);
  ok $foo == 23 && $bar == 42,
    "using lists as lvalues in a binding operation to swap two variables works";

  $foo = "some_new_value";
  is $foo, "some_new_value",
    "the vars didn't lose the readwrite-ness";
}

#?rakudo skip 'list binding'
#?niecza skip 'Cannot use bind operator with this LHS'
{
  my $foo = 1;
  my $bar = 2;
  my $baz = 3;

  ($foo, $bar, $baz) := ($baz, $foo, $bar);
  ok $foo == 3 && $bar == 1 && $baz == 2,
    "using lists as lvalues in a binding operation to swap three variables works";
}

#?niecza skip 'Cannot use value like Capture as a number'
{
  my @array    = (1,2,3);
  my $capture = \@array;

  is +$capture,    1, '\@array creates a capture (1)';
  is +$capture[0], 3, '\@array creates a capture (2)';
}

{
    sub Parcel::rt62836 { 62836 }

    dies_ok { <1 2 3>.rt62836 },
            'call to user-declared sub in Parcel:: class dies';
    try { EVAL '<1 2 3>.rt62836' };
    ok "$!" ~~ /rt62836/,       'error message contains name of sub';
    ok "$!" ~~ /Parcel/,    'error message contains name of class';

    augment class Parcel { method rt62836_x { 62836 } };
    is <1 2 3>.rt62836_x, 62836, 'call user-declared method in Parcel:: class';
}

# RT #66304
{
    my $rt66304 = (1, 2, 4);
    isa_ok $rt66304, Parcel, 'List assigned to scalar is-a Parcel';
    is( $rt66304.WHAT, (1, 2, 4).WHAT,
        'List.WHAT is the same as .WHAT of list assigned to scalar' );
    dies_ok { $rt66304[1] = 'ro' }, 'literal List element is immutable';
    is $rt66304, (1, 2, 4), 'List is not changed by attempted assignment';
}

#?niecza skip 'Excess arguments to CORE List.new'
{
    my $x = List.new('bacon');
    my $y = $x.Str;
    my $z = $x.Str;
    is $y, 'bacon', "3rd-party reification of List doesn't duplicate rest";
    is $z, 'bacon', "3rd-party reification of List doesn't duplicate rest";
}

# RT #112216
#?niecza skip 'loops'
is 'foo'[2..*].elems, 0, 'can range-index a Str with infinite range';

done;

# vim: ft=perl6
