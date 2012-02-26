use v6;

use Test;

# L<S03/Item assignment precedence>

plan 47;

# Binding of array elements.
# See thread "Binding of array elements" on p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22915">

{
  my @array  = <a b c>;
  my $var    = "d";

  try { @array[1] := $var };
  is @array[1], "d", "basic binding of an array element (1)";
  unless @array[1] eq "d" {
    skip_rest "Skipping binding of array elements tests (not yet implemented in the normal runcore)";
    exit;
  }

  $var = "e";
  is @array[1], "e", "basic binding of an array element (2)";

  @array[1] = "f";
  is $var,      "f", "basic binding of an array element (3)";
}

{
  my @array  = <a b c>;
  my $var    = "d";

  @array[1] := $var;
  $var       = "e";
  is @array[1], "e",  "binding of array elements works with .delete (1)";

  @array.delete(1);
  # $var unchanged, but assigning to $var doesn't modify @array any
  # longer; similarily, changing @array[1] doesn't modify $var now
  #?rakudo todo 'array binding, delete'
  #?niecza todo 'array binding, delete'
  is $var,    "e",    "binding of array elements works with .delete (2)";
  is ~@array, "a  c", "binding of array elements works with .delete (3)";

  $var      = "f";
  @array[1] = "g";
  #?niecza todo 'array binding, delete'
  #?rakudo todo 'array binding, delete'
  is $var,      "f",  "binding of array elements works with .delete (4)";
  is @array[1], "g",  "binding of array elements works with .delete (5)";
}

{
  my @array  = <a b c>;
  my $var    = "d";

  @array[1] := $var;
  $var       = "e";
  is @array[1], "e", "binding of array elements works with resetting the array (1)";

  @array = ();
  # $var unchanged, but assigning to $var doesn't modify @array any
  # longer; similarily, changing @array[1] doesn't modify $var now
  is $var,    "e",   "binding of array elements works with resetting the array (2)";
  is ~@array, "",    "binding of array elements works with resetting the array (3)";

  $var      = "f";
  @array[1] = "g";
  is $var,      "f", "binding of array elements works with resetting the array (4)";
  is @array[1], "g", "binding of array elements works with resetting the array (5)";
}

{
  my @array  = <a b c>;
  my $var    = "d";

  @array[1] := $var;
  $var       = "e";
  is @array[1], "e",   "binding of array elements works with rebinding the array (1)";

  my @other_array = <x y z>;
  @array := @other_array;
  # $var unchanged, but assigning to $var doesn't modify @array any
  # longer; similarily, changing @array[1] doesn't modify $var now
  is $var,    "e",     "binding of array elements works with rebinding the array (2)";
  is ~@array, "x y z", "binding of array elements works with rebinding the array (3)";

  $var      = "f";
  @array[1] = "g";
  is $var,      "f",   "binding of array elements works with rebinding the array (4)";
  is @array[1], "g",   "binding of array elements works with rebinding the array (5)";
}

{
  my sub foo (@arr) { @arr[1] = "new_value" }

  my @array  = <a b c>;
  my $var    = "d";
  @array[1] := $var;

  foo @array;
  is $var,    "new_value",     "passing an array to a sub expecting an array behaves correctly (1)";
  is ~@array, "a new_value c", "passing an array to a sub expecting an array behaves correctly (2)";
}

{
  my sub foo (Array $arr) { $arr[1] = "new_value" }

  my @array  = <a b c>;
  my $var    = "d";
  @array[1] := $var;

  foo @array;
  is $var,    "new_value",     "passing an array to a sub expecting an arrayref behaves correctly (1)";
  is ~@array, "a new_value c", "passing an array to a sub expecting an arrayref behaves correctly (2)";
}

{
  my sub foo (@args) { @args[1] = "new_value" }

  my @array  = <a b c>;
  my $var    = "d";
  @array[1] := $var;

  foo @array;
  is $var,    "new_value",     "passing an array to a slurpying sub behaves correctly (1)";
  is ~@array, "a new_value c", "passing an array to a slurpying sub behaves correctly (2)";
}

#?pugs skip "Can't modify constant item: VUndef"
{
  my sub foo (*@args) { push @args, "new_value" }

  my @array  = <a b c>;
  my $var    = "d";
  @array[1] := $var;

  foo @array;
  is $var,    "d",     "passing an array to a slurpying sub behaves correctly (3)";
  is ~@array, "a d c", "passing an array to a slurpying sub behaves correctly (4)";
}

# Binding of not yet existing elements should autovivify
{
  my @array;
  my $var    = "d";

  lives_ok { @array[1] := $var },
                     "binding of not yet existing elements should autovivify (1)";
  is @array[1], "d", "binding of not yet existing elements should autovivify (2)";

  $var = "e";
  is @array[1], "e", "binding of not yet existing elements should autovivify (3)";
  is $var,      "e", "binding of not yet existing elements should autovivify (4)";
}

# Binding with .splice
{
  my @array  = <a b c>;
  my $var    = "d";

  @array[1] := $var;
  $var       = "e";
  is @array[1], "e",  "binding of array elements works with splice (1)";

  splice @array, 1, 1, ();
  # $var unchanged, but assigning to $var doesn't modify @array any
  # longer; similarily, changing @array[1] doesn't modify $var now
  #?niecza todo "binding of array elements works with splice (2)"
  is $var,    "e",    "binding of array elements works with splice (2)";
  is ~@array, "a c",  "binding of array elements works with splice (3)";

  $var      = "f";
  @array[1] = "g";
  is $var,      "f",  "binding of array elements works with splice (4)";
  is @array[1], "g",  "binding of array elements works with splice (5)";
}

# Assignment (not binding) creates new containers
{
  my @array  = <a b c>;
  my $var    = "d";

  @array[1] := $var;
  $var       = "e";
  is @array[1], "e",       "array assignment creates new containers (1)";

  my @new_array = @array;
  $var          = "f";
  # @array[$idx] and $var are now "f", but @new_array is unchanged.
  is $var,        "f",     "array assignment creates new containers (2)";
  is ~@array,     "a f c", "array assignment creates new containers (3)";
  is ~@new_array, "a e c", "array assignment creates new containers (4)";
}

# Binding does not create new containers
{
  my @array  = <a b c>;
  my $var    = "d";

  @array[1] := $var;
  $var       = "e";
  is @array[1], "e",       "array binding does not create new containers (1)";

  my @new_array := @array;
  $var           = "f";
  # @array[$idx] and $var are now "f", but @new_array is unchanged.
  is $var,        "f",     "array binding does not create new containers (2)";
  is ~@array,     "a f c", "array binding does not create new containers (3)";
  is ~@new_array, "a f c", "array binding does not create new containers (4)";
}

# Binding @array := $arrayref.
# See
# http://colabti.de/irclogger/irclogger_log/perl6?date=2005-11-06,Sun&sel=388#l564
# and consider the magic behind parameter binding (which is really normal
# binding).
{
  my $arrayref  = [<a b c>];
  my @array    := $arrayref;

  is +@array, 3,          'binding @array := $arrayref works (1)';

  @array[1] = "B";
  is ~$arrayref, "a B c", 'binding @array := $arrayref works (2)';
  is ~@array,    "a B c", 'binding @array := $arrayref works (3)';
}

# RT #61566
#?niecza todo
#?pugs todo
{
    eval_dies_ok 'my @rt61566 := 1', 'can only bind Positional stuff to @a';
    # TODO: check that the error is the right one
    # <pmichaud> you should get a "Int does not do Positional role"
    #            exception or something like that.
}

# vim: ft=perl6
