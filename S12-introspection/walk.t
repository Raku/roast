use v6;

use Test;

plan 11;

=begin pod

Tests for WALK, defined in L<S12/Calling sets of methods>

=end pod

#L<S12/Calling sets of methods>

class A {
    method m { 'A' }
}
class B {
    method m { 'B' }
}
class C is A is B {
    method m { 'C' }
    method n { 'OH NOES' }
}
class D is A {
    method m { 'D' }
}
class E is C is D {
    method m { 'E' }
}

sub cand_order(@cands, $instance) {
    my $result = '';
    for @cands -> $cand {
        $result ~= $cand($instance);
    }
    $result
}

# :canonical
{
    my $x = E.new;
    my @cands = $x.WALK(:name<m>, :canonical);
    is cand_order(@cands, $x), 'ECDAB', ':canonical (explicit) works';
    @cands = $x.WALK(:name<m>);
    is cand_order(@cands, $x), 'ECDAB', ':canonical (as default) works';
}

# :super
{
    my $x = E.new;
    my @cands = $x.WALK(:name<m>, :super);
    is cand_order(@cands, $x), 'CD', ':super works';
}

# :breadth
{
    my $x = E.new;
    my @cands = $x.WALK(:name<m>, :breadth);
    is cand_order(@cands, $x), 'ECDAB', ':breadth works';
}

# :descendant
{
    my $x = E.new;
    my @cands = $x.WALK(:name<m>, :descendant);
    is cand_order(@cands, $x), 'ABCDE', ':descendant works';
}

# :ascendant
{
    my $x = E.new;
    my @cands = $x.WALK(:name<m>, :ascendant);
    is cand_order(@cands, $x), 'ECABD', ':ascendant works';
}

# :preorder
{
    my $x = E.new;
    my @cands = $x.WALK(:name<m>, :preorder);
    is cand_order(@cands, $x), 'ECABD', ':preorder works';
}

# :omit
{
    my $x = E.new;
    my @cands = $x.WALK(:name<m>, :omit({ .^can('n') }));
    is cand_order(@cands, $x), 'DAB', ':omit works';
}

# :include
{
    my $x = E.new;
    my @cands = $x.WALK(:name<m>, :include({ $^c.gist ~~ regex { <[CDE]> } }));
    is cand_order(@cands, $x), 'ECD', ':include works';
}

# :include and :omit
{
    my $x = E.new;
    my @cands = $x.WALK(:name<m>, :include({ $^c.gist ~~ regex { <[CDE]> } }), :omit({ .^can('n') }));
    is cand_order(@cands, $x), 'D', ':include and :omit together work';
}

# Grammar.WALK had issues once
{
    my ($meth) = Grammar.WALK(:name<parse>);
    is $meth.name, 'parse', 'Grammar.WALK works';
}

# vim: ft=perl6
