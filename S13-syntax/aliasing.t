use v6;

use Test;

plan 3;

# L<S13/Syntax/This can easily be handled with Perl 6's aliasing>

class Foo {
  method bar()     { 42 }
  method bar_ref() { &bar }
}

{
  my $foo = Foo.new;
  lives_ok { $foo.bar_ref }, "returning a method reference works";
}

class Baz {
    method bar() { 42 }
    our &baz ::= &bar;
}

{
  my $ret;
  lives_ok {
    my $baz = Baz.new;
    $ret    = $baz.baz();
  }, "calling an aliased method worked";
  is $ret, 42, "the aliased method returned the right thing";
}
