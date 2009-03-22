use v6;
use Test;
plan 3;

# test that classes and roles declared in modules get into the correct
# namespace

# Used to be a Rakudo bug, RT #63956

BEGIN { @*INC.push('t/spec/packages/') };

eval_lives_ok 'use A::A', 'Can load classes from nested modules';
eval_lives_ok 'use A::A; A::B::D ~~ A::B::B or die()', 
              '... and the composition worked';
eval_lives_ok 'use A::A; A::B::D.new()',
              '... and instantiation works';

# vim: ft=perl6
