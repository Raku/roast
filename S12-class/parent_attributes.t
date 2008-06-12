use v6;

use Test;

plan 3;

=begin description

=head1 Initialization of parent attributes

These are some tests for "Construction and Initialization" section of Synopsis
12, based on example code from Jonathan Worthington's Rakudo tests for
parent attribute initialization

=end description

class Foo {
    has $.x;
    method boo { $.x }
}

class Bar is Foo {
    method set($v) { $!x = $v }
}

my Foo $u .= new(x => 5);
is($u.boo, 5, 'set attribute');

$u= Bar.new(Foo{ x => 12 });
is($u.boo, 12, 'set parent attribute');
$u.set(9);
is($u.boo, 9,  'reset parent attribute');
