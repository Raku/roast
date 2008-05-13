use v6;

use Test;

plan 3;

=begin description

=head1 Initialization of parent attributes

These tests are the testing for "Method" section of Synopsis 12

L<S12/Methods/Indirect object notation now requires a colon after the invocant if there are no arguments>

=end description

class Foo {
    has $.x;
    method boo { say $.x }
}

class Bar is Foo {
    method set($v) { $.x = $v }
}

my Foo $u .= new(x => 5);
is($u.boo, 5, 'set attribute');

$u= Bar.new(Foo{ x => 12 });
is($u.boo, 'set parent attribute');
$u.set(9);
is($u.boo, 'reset parent attribute');