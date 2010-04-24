use v6;
use Test;

plan 8;

=begin pod

Tests for lexical classes delcared with 'my class'

=end pod

# L<S12/Classes>

# A few basic tests.
eval_lives_ok 'my class A {}', 'my class parses OK';
eval_lives_ok '{ my class B {} }; { my class B {} }',
              'declare classes with the same name in two scopes.';
eval_lives_ok '{ my class B {}; B.new; }',
              'can instantiate lexical class';
eval_dies_ok  '{ my class B {}; B.new; }; B.new',
              'scope is correctly restricted';

{
    my class WeissBier {
        has $.name;
        method describe() { 'outstanding flavour' }
    }
    my $pint = WeissBier.new(name => 'Erdinger');
    ok $pint ~~ WeissBier,                    'can smart-match against lexical class';
    is $pint.name, 'Erdinger',                'attribute in lexical class works';
    is $pint.describe, 'outstanding flavour', 'method call on lexical class works';
    is WeissBier, 'WeissBier()',              'lexical type object stringifies correct';
}

# vim: ft=perl6
