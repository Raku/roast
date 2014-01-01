use v6;

use Test;

plan 9;

=begin pod

Basic traits tests, see L<S14/Traits>.

=end pod

# L<S14/Traits>
# Basic definition
my $was_in_any_sub   = 0;
my $was_in_class_sub = 0;
role cool {
  has $.is_cool = 42;

  multi sub trait_auxiliary:<is>(cool $trait, Any $container:) {   #OK not used
    $was_in_any_sub++;
    $container does cool;
  }

  multi sub trait_auxiliary:<is>(cool $trait, Class $container:) {   #OK not used
    $was_in_class_sub++;
    $container does cool;
  }
}
ok(::cool.HOW, "role definition worked");

eval_lives_ok 'my $a is cool; 1', 'mixing in our role into a scalar via "is" worked';
#?pugs 2 todo 'traits'
is $was_in_any_sub, 1, 'trait_auxiliary:is was called on container';
is EVAL('my $a is cool; $a.is_cool'), 42,  'our var "inherited" an attribute';

my $b;
class B is cool {}
ok(::B.HOW, 'mixing in our role into a class via "is" worked');
#?pugs todo
is $was_in_class_sub, 1, 'trait_auxiliary:is was called on class';
$b = B.new;
ok($b, 'creating an instance worked');
is($b.is_cool,    42,  'our class "inherited" an attribute');

eval_dies_ok(' %!P = 1; 1',
        'calling a trait outside of a class should be a syntax error');

# vim: ft=perl6
