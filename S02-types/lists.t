use v6.d;

use MONKEY-TYPING;

use Test;

# L<S02/Lists>

plan 30;

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
  throws-like q/sub foo { @_[-1] }/, X::Obsolete,
    "indexing lists by explicit negative index is parsefail (compact)";
  throws-like q/sub foo { @_[ -42 ] }/, X::Obsolete,
    "indexing lists by explicit negative index is parsefail (spaced)";
  throws-like q/sub foo { @_[0..-1] }/, X::Obsolete,
    "indexing lists by range ending with negative index is parsefail (compact)";
  throws-like q/sub foo { @_[ 0 .. -42 ] }/, X::Obsolete,
    "indexing lists by range ending with negative index is parsefail (spaced)";
  throws-like { EVAL q/my @a = <one two>; @a[*-3] = 'zero'/ },
    X::OutOfRange,
 	"indexing lists by an effective negative index with * dies";
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
  
  lives-ok { ($foo, *) = (23, 24) },
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

  dies-ok { ($foo, 42, $bar, 19)[1, 3] = (23, 24) },
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

{
  my @array    = (1,2,3);
  my $capture = \(@array);

  is +$capture,    1, '\(@array) creates a capture (1)';
  is +$capture[0], 3, '\(@array) creates a capture (2)';
}

{
    sub List::rt62836 { 62836 }

    throws-like { <1 2 3>.rt62836 },
      X::Method::NotFound,
      'call to user-declared sub in List:: class dies';
    try { EVAL '<1 2 3>.rt62836' };
    ok "$!" ~~ /rt62836/,       'error message contains name of sub';
    ok "$!" ~~ /List/,          'error message contains name of class';

    augment class List { method rt62836_x { 62836 } };
    is <1 2 3>.rt62836_x, 62836, 'call user-declared method in List:: class';
}

# RT #66304
{
    my $rt66304 = (1, 2, 4);
    isa-ok $rt66304, List, 'List assigned to scalar is-a List';
    is( $rt66304.WHAT.perl, (1, 2, 4).WHAT.perl,
        'List.WHAT is the same as .WHAT of list assigned to scalar' );
    throws-like { $rt66304[1] = 'ro' },
      X::Assignment::RO,
      'literal List element is immutable';
    is $rt66304, (1, 2, 4), 'List is not changed by attempted assignment';
}

{
    my $x = List.new('bacon');
    my $y = $x.Str;
    my $z = $x.Str;
    is $y, 'bacon', "3rd-party reification of List doesn't duplicate rest";
    is $z, 'bacon', "3rd-party reification of List doesn't duplicate rest";
}

# https://github.com/Raku/old-issue-tracker/issues/2695
# https://github.com/rakudo/rakudo/issues/3658
throws-like { 'foo'[2..3] }, X::OutOfRange,
  got => 2,
  'obtaining values from out-of-range indices in a lazy slice throws'
;
throws-like { 'foo'[2..*] }, X::OutOfRange,
  got => 2,
  'obtaining values from out-of-range indices in a lazy slice throws'
;

# vim: ft=perl6
