use v6;
use Test;

# L<S32::Containers/Hash/invert>

plan 5;

{
    my %h = a => 'b', c => 'd';
    isa-ok %h.invert, Seq, 'Hash.invert returns a Seq';
    #?niecza todo 'Cannot use value like Pair as a number'
    is-deeply %h.invert.sort.list, (b => 'a', d => 'c'), 'simple Hash.invert works';
    is-deeply %h, { a => 'b', c => 'd' }, 'original remains unchanged';
}

{
    # with lists
    my %h = a => <b c>, d => 'e';
    #?niecza todo 'Cannot use value like Pair as a number'
    is-deeply %h.invert.sort.list, (b => 'a', c => 'a', e => 'd'),
              'Hash.invert flattens list values';
    is-deeply %h, {a => <b c>, d => 'e'}, 'original remains unchanged';
}

# vim: ft=perl6
