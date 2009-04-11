use v6;
use Test;

plan 5;

{
    my %h = a => 'b', c => 'd';
    isa_ok %h.invert, List, 'Hash.invert returns a List';
    is_deeply %h.invert, (b => 'a', d => 'c'), 'simple Hash.invert works';
    is_deeply %h, { a => 'b', c => 'd' }, 'original remains unchanged';
}

{
    # with lists
    my %h = a => <b c>, d => 'e';
    is_deeply %h.invert.sort, (b => 'a', c => 'a', e => 'd'),
              'Hash.invert flattens list values';
    is_deeply %h, {a => <b c>, d => 'e'}, 'original remains unchanged';
}

# vim: ft=perl6
