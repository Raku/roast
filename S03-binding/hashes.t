use v6;

use Test;

# L<S03/Item assignment precedence>

plan 39;

# Binding of hash elements.
# See thread "Binding of array elements" on p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22915">
{
  my %hash  = (:a<x>, :b<y>, :c<z>);
  my $var   = "d";

  try { %hash<b> := $var };
  is %hash<b>, "d", "basic binding of a hash element (1)";
  unless %hash<b> eq "d" {
    skip_rest "Skipping binding of hash elements tests (not yet implemented in the normal runcore)";
    exit;
  }

  $var = "e";
  is %hash<b>, "e", "basic binding of a hash element (2)";

  %hash<b> = "f";
  is $var,     "f", "basic binding of a hash element (3)";
}

{
  my %hash  = (:a<x>, :b<y>, :c<z>);
  my $var   = "d";

  %hash<b> := $var;
  $var      = "e";
  is %hash<b>, "e",             "binding of hash elements works with delete (1)";

  %hash<b>:delete;
  # $var unchanged, but assigning to $var doesn't modify @hash any
  # longer; similarily, changing @hash[1] doesn't modify $var now
  is $var,   "e",               "binding of hash elements works with delete (2)";
  is ~%hash.values.sort, "x z", "binding of hash elements works with delete (3)";

  $var     = "f";
  %hash<b> = "g";
  is $var,     "f",             "binding of hash elements works with delete (4)";
  is %hash<b>, "g",             "binding of hash elements works with delete (5)";
}

{
  my %hash  = (:a<x>, :b<y>, :c<z>);
  my $var   = "d";

  %hash<b> := $var;
  $var      = "e";
  is %hash<b>, "e", "binding of hash elements works with resetting the hash (1)";

  %hash = ();
  # $var unchanged, but assigning to $var doesn't modify @hash any
  # longer; similarily, changing @hash[1] doesn't modify $var now
  is $var,   "e",   "binding of hash elements works with resetting the hash (2)";
  is ~%hash, "",    "binding of hash elements works with resetting the hash (3)";

  $var     = "f";
  %hash<b> = "g";
  is $var,     "f", "binding of hash elements works with resetting the hash (4)";
  is %hash<b>, "g", "binding of hash elements works with resetting the hash (5)";
}

{
  my %hash  = (:a<x>, :b<y>, :c<z>);
  my $var   = "d";

  %hash<b> := $var;
  $var      = "e";
  is %hash<b>, "e", "binding of hash elements works with rebinding the hash (1)";

  my %other_hash = (:p<q>, :r<s>, :t<u>);
  %hash := %other_hash;
  # $var unchanged, but assigning to $var doesn't modify @hash any
  # longer; similarily, changing @hash[1] doesn't modify $var now
  is $var,    "e",  "binding of hash elements works with rebinding the hash (2)";
  is ~%hash.values.sort, "q s u",
    "binding of hash elements works with rebinding the hash (3)";

  $var     = "f";
  %hash<b> = "g";
  is $var,     "f", "binding of hash elements works with rebinding the hash (4)";
  is %hash<b>, "g", "binding of hash elements works with rebinding the hash (5)";
}

{
  my sub foo (%h) { %h<b> = "new_value" }

  my %hash  = (:a<x>, :b<y>, :c<z>);
  my $var   = "d";
  %hash<b> := $var;

  foo %hash;
  is $var,    "new_value",     "passing a hash to a sub expecting a hash behaves correctly (1)";
  is ~%hash.values.sort, "new_value x z",
    "passing a hash to a sub expecting a hash behaves correctly (2)";
}

{
  my sub foo (Hash $h) { $h<b> = "new_value" }

  my %hash  = (:a<x>, :b<y>, :c<z>);
  my $var   = "d";
  %hash<b> := $var;

  foo %hash;
  is $var, "new_value",
    "passing a hash to a sub expecting a hashref behaves correctly (1)";
  is ~%hash.values.sort, "new_value x z",
    "passing a hash to a sub expecting a hashref behaves correctly (2)";
}

# Binding of not yet existing elements should autovivify
{
  my %hash;
  my $var = "d";

  lives_ok { %hash<b> := $var },
                    "binding of not yet existing elements should autovivify (1)";
  is %hash<b>, "d", "binding of not yet existing elements should autovivify (2)";

  $var = "e";
  is %hash<b>, "e", "binding of not yet existing elements should autovivify (3)";
  is $var,     "e", "binding of not yet existing elements should autovivify (4)";
}

# Assignment (not binding) creates new containers
{
  my %hash  = (:a<x>, :b<y>, :c<z>);
  my $var   = "d";

  %hash<b> := $var;
  $var      = "e";
  is %hash<b>, "e",                   "hash assignment creates new containers (1)";

  my %new_hash = %hash;
  $var         = "f";
  # %hash<b> and $var are now "f", but %new_hash is unchanged.
  is $var,                   "f",     "hash assignment creates new containers (2)";
  is ~%hash\   .values.sort, "f x z", "hash assignment creates new containers (3)";
  is ~%new_hash.values.sort, "e x z", "hash assignment creates new containers (4)";
}

# Binding does not create new containers
{
  my %hash  = (:a<x>, :b<y>, :c<z>);
  my $var   = "d";

  %hash<b> := $var;
  $var      = "e";
  is %hash<b>, "e",                   "hash binding does not create new containers (1)";

  my %new_hash := %hash;
  $var          = "f";
  # %hash<b> and $var are now "f", but %new_hash is unchanged.
  is $var,        "f",                "hash binding does not create new containers (2)";
  is ~%hash\   .values.sort, "f x z", "hash binding does not create new containers (3)";
  is ~%new_hash.values.sort, "f x z", "hash binding does not create new containers (4)";
}

# Binding %hash := $hashref.
# See
# http://colabti.de/irclogger/irclogger_log/perl6?date=2005-11-06,Sun&sel=388#l564
# and consider the magic behind parameter binding (which is really normal
# binding).
{
  my $hashref = { a => "a", b => "b" };
  my %hash   := $hashref;

  is +%hash, 2,                    'binding %hash := $hashref works (1)';

  %hash<b> = "c";
  is ~$hashref.values.sort, "a c", 'binding %hash := $hashref works (2)';
  is ~%hash\  .values.sort, "a c", 'binding %hash := $hashref works (3)';
}

eval_dies_ok 'my %h = a => 1, b => 2; %h<a b> := (4, 5)',
    'Cannot bind to hash slices';
is 1,1, 'dummy';

# vim: ft=perl6
