use v6;

use Test;

plan 5;

# L<S13/Syntax/This can easily be handled with Raku's aliasing>

# XXX When the two canary tests pass TODO it is time to remove them and unfudge the main test body.
#?rakudo todo "Canary test for &method"
eval-lives-ok 'my class Foo { method bar() {}; method bar_ref() { &bar } }', '&method is implemented, consider unfudging this test';

#?rakudo todo "Canary test for ::="
eval-lives-ok 'my $foo = 42; my $bar ::= $foo;', '::= is implemented, consider unfudging this test';

#?rakudo eval "Requires &method and ::= to be implemented"
{
    my class Foo {
      method bar()     { 42 }
      method bar_ref() { &bar }
    }

    {
      my $foo = Foo.new;
      lives-ok { $foo.bar_ref }, "returning a method reference works";
    }

    my class Baz {
        method bar() { 42 }
        our &baz ::= &bar;
    }

    {
      my $ret;
      lives-ok {
        my $baz = Baz.new;
        $ret    = $baz.baz();
      }, "calling an aliased method worked";
      is $ret, 42, "the aliased method returned the right thing";
    }
}

# vim: expandtab shiftwidth=4
