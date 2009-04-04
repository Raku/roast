use v6;

use Test;

=begin pod

The parser won't do right thing when two(or more) class-es get
attributes whose name are the same.

hmm, It's conflicted with class name and attribute name.

***** These two examples below will fail to parse. *****

##### this example below will cause pugs hang.
class a {has $.a; method update { $.a; } }; class b { has $.a; submethod BUILD { a.new( a => $.a ).update; } };class c { has $.b; submethod BUILD { b.new( a => $.b ); } };c.new( b => 30 );

##### this example will say sub isn't found.
class a { has $.a; method update { $.a; } };class b { has $.a; submethod BUILD { a.new( a => $.a ).update; }; }; b.new( a => 20 );

Problems with this test:
* The classes "a", "b", and "c" are redefined several times.
  { class Foo {...} }; say Foo.new;
  # works, even though Foo was declared in a different lexical scope
  Proposal: Change the class names to "a1", "b1", "a2", "b2", etc.

* This also causes some infloops, as some classes' BUILD call itself
  (indirectly) (this is a consequence of the first problem).

* *Most importantly*: Because the classes are redefined -- especially because
  .update is redefined -- only the $var of subtest #3 gets updated, *not* the
  $var of subtest #1 or #2!

  { my $var; class Foo { method update { $var = 42 }; Foo.new.update; say $var }
  { my $var; class Foo { method update { $var = 42 } }
  # This will output "" instead of "42", as the $var of the second scope is
  # changed, not the $var of the first line.
  # &Foo::update changes the $var of its scope. This $var is not the $var of
  # the first line.

  I see to solutions to this problem:

  * Write "my class" instead of "class" -- but lexical classes are not yet
    implemented.
  * Change the class names -- there may only be one class "a", one class "b",
    etc. in the file. (Note again that {} scopes don't have an effect on global
    (OUR::) classes).

  [A similar example:
    { my $var; sub update { $var = 42 }; update(); say $var }
    { my $var; sub update { $var = 42 } }
    # This outputs "".

    { my $var; my sub update { $var = 42 }; update(); say $var }
    { my $var; my sub update { $var = 42 } }
    # This outputs "42".]

* The last subtest calls c.new(...).update, but there is no &c::update and c
  doesn't inherit from a class providing an "update" method, either.

=end pod

plan 3;


{
    my $var = 100;
    # XXX This definition doesn't have any effect, as it is overridden by the
    # definition at the end of this file. This $var is not captured.
    # All calls to &a::update will really call the &a::update as defined by
    # subtest #3, which will update the $var of subtest #3's scope (not this
    # $var).
    class a {
        has $.a;
        has $.c;
        method update { $var -= $.a; }
    };
    a.new( a => 10 ).update;
    is $var, 90, "Testing suite 1.", :todo<bug>;
}



{
    my $var = 100;
    # XXX This definition doesn't have any effect, as it is overridden by the
    # definition at the end of this file. This $var is not captured.
    # All calls to &a::update will really call the &a::update as defined by
    # subtest #3, which will update the $var of subtest #3's scope (not this
    # $var).
    class a {
        has $.a;
        method update { $var -= $.a; }
    };
    class b {
        has $.a;
        submethod BUILD { a.new( a => $.a ).update; };
    };

=begin pod
  pugs> class a { has $.a; method update { $var -= $.a; } };class b { has $.a; submethod BUILD { a.new( a => $.a ).update; };};b.new( a => 20 );
  *** No compatible subroutine found: "&update"
      at <interactive> line 1, column 90-114
      <interactive> line 1, column 120-136
      <interactive> line 1, column 120-136
  pugs>

=end pod

##### will cause pugs hang if uncomment it
#    b.new( a => 20 );
    is $var, 80, "Testing suite 2.", :todo<bug>;
}



{
    my $var = 100;
    # XXX This definition *does* have an effect. This $var *is* captured.
    # All calls to &a::update will update this $var, not the $var of subtest #1
    # or #2.
    class a {
        has $.a;
        method update { $var -= $.a; }
    };
    class b {
        has $.a;
        submethod BUILD { a.new( a => $.a ); }
    };
    class c {
        has $.b;
        submethod BUILD { b.new( a => $.b ); }
    };

##### cause pugs hang.
#    c.new( b => 30 ).update;
    is $var, 70, "Testing suite 3.", :todo<bug>;
}

