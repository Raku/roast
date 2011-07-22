use v6;

use Test;

plan 36;

# See L<http://www.nntp.perl.org/group/perl.perl6.language/22858> --
# previously, "my $a; say $::("a")" died (you had to s/my/our/). Now, it was
# re-specced to work.

# L<S02/Names/Most symbolic references are done with this notation:>
{
  my $a_var = 42;
  my $b_var = "a_var";

  is $::($b_var), 42, 'basic symbolic scalar dereferentiation works';
  lives_ok { $::($b_var) = 23 }, 'can use $::(...) as lvalue';
  is $a_var, 23, 'and the assignment worked';
  $::($b_var) = 'a', 'b', 'c';
  is $a_var, 'a', '... and it is item assignment';
}

{
  my @a_var = <a b c>;
  my $b_var = "a_var";

  is @::($b_var)[1], "b", 'basic symbolic array dereferentiation works';
  @::($b_var) = ('X', 'Y', 'Z');
  is @a_var.join(' '), 'X Y Z', 'can assign to symbolic deref';
  @::($b_var) = 'u', 'v', 'w';
  is @a_var.join(' '), 'u v w', '... and it is list assignment when the sigil is @';
}

{
  my %a_var = (a => 42);
  my $b_var = "a_var";

  is %::($b_var)<a>, 42, 'basic symbolic hash dereferentiation works';
}

{
  my &a_var := { 42 };
  my $b_var = "a_var";

  is &::($b_var)(), 42, 'basic symbolic code dereferentiation works';
}

my $outer = 'outside';
{
    my $inner = 'inside';

    ok ::('Int') === Int,    'can look up a type object with ::()';
    is ::('$inner'), $inner, 'can look up lexical from same block';
    is ::('$outer'), $outer, 'can look up lexical from outer block';

    lives_ok { ::('$outer') = 'new' }, 'Can use ::() as lvalue';
    is $outer, 'new', 'and the assignment worked';
    sub c { 'sub c' };
    is ::('&c').(), 'sub c', 'can look up lexical sub';

    is ::('e'), e,  'Can look up numerical constants';
}

{
    package Outer {
        class Inner { }
    }

    class A::B { };

    is ::('Outer::Inner').perl, Outer::Inner.perl, 'can look up name with :: (1)';
    #?rakudo skip 'A::B lookup'
    is ::('A::B').perl, A::B.perl, 'can look up name with :: (1)';
}


#?rakudo skip 'NYI'
{
  $pugs::is::cool = 42;
  my $cool = "cool";
  my $pugsis = 'pugs::is';

  is $::("pugs")::is::($cool), 42, 'not so basic symbolic dereferentiation works';
  is $::($pugsis)::($cool),    42, 'symbolic derefertiation with multiple packages in one variable works';
  eval_dies_ok('$::($pugsis)cool', '$::($foo)bar is illegal');
}

#?rakudo skip 'NYI'
{
  my $result;

  try {
    my $a_var is context = 42;
    my $sub   = sub { $::("CALLER")::("a_var") };
    $result = $sub();
  };

  is $result, 42, "symbolic dereferentation works with ::CALLER, too";
}

# Symbolic dereferentiation of Unicode vars (test primarily aimed at PIL2JS)
{
  my $äöü = 42;
  is $::("äöü"), 42, "symbolic dereferentiation of Unicode vars works";
}

# Symbolic dereferentiation of globals
#?rakudo skip 'NYI'
{
  sub GLOBAL::a_global_sub () { 42 }
  is &::("*::a_global_sub")(), 42,
    "symbolic dereferentiation of globals works (1)";

  $*a_global_var = 42;
  is $::("*::a_global_var"),   42,
    "symbolic dereferentiation of globals works (2)";
}

# Symbolic dereferentiation of globals *without the star*
#?rakudo skip 'NYI'
{
  cmp_ok $::("*IN"), &infix:<===>, $*IN,
    "symbolic dereferentiation of globals works (3)";
  cmp_ok $::("IN"),  &infix:<===>, $*IN,
    "symbolic dereferentiation of globals without the star works";

  # XXX - should be =:= rather than ~~, but &say =:= &say is currently false.:(
  #cmp_ok &::("*say"), &infix:<=:=>, &say,
  cmp_ok &::("*say"), &infix:<~~>, &say,
    "symbolic dereferentiation of global subs works";
  #cmp_ok &::("say"),  &infix:<=:=>, &say,
  cmp_ok &::("say"),  &infix:<~~>, &say,
    "symbolic dereferentiation of global subs without the star works (1)";

  ok &::("true")(42),
    "symbolic dereferentiation of global subs without the star works (2)";
  is &::("truncate")(3.1), 3,
    "symbolic dereferentiation of global subs without the star works (3)";
}

# Symbolic dereferentiation of type vars
#?rakudo skip 'NYI'
{
  cmp_ok ::Array, &infix:<===>, ::("Array"),
    "symbolic dereferentiation of type vars works (1)";
}

#?rakudo skip 'NYI'
{
  class A::B::C {};
  my $ok = ::A::B::C === ::A::("B")::C;
  ok $ok, "symbolic dereferentiation of (own) type vars works (2)";
}

# Symbolic dereferentiation syntax should work with $?SPECIAL etc. too.
# Note: I'm not 100% sure this is legal syntax. If it turns out it isn't, we'll
# have to s/ok/dies_ok/.
#?rakudo skip 'NYI'
{
  try { this_will_die_and_therefore_set_dollar_exclamation_mark };
  ok $::("!"),    "symbolic dereferentiation works with special chars (1)";
#  ok $::!,        "symbolic dereferentiation works with special chars (2)";
  ok %::("*ENV"), "symbolic dereferentiation works with special chars (3)";
#  ok %::*ENV,     "symbolic dereferentiation works with special chars (4)";
}

# Symdereffing should find package vars as well:
{
  our $symderef_test_var = 42;

  is $::("symderef_test_var"), 42, "symbolic dereferentiation works with package vars";
}

# vim: ft=perl6
