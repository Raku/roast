use v6;
use Test;

plan 5;

{
    my %h = a => 'b', c => 'd';
    isa_ok %h.reverse, List, 'Hash.reverse returns a List';
    is_deeply %h.reverse, (b => 'a', d => 'c'), 'simple Hash.reverse works';
    is_deeply %h, { a => 'b', c => 'd' }, 'original remains unchanged';
}

{
    # with lists
    my %h = a => <b c>, d => 'e';
    is_deeply %h.reverse.sort, (b => 'a', c => 'a', e => 'd'),
              'Hash.reverse flattens list values';
    is_deeply %h, {a => <b c>, d => 'e'}, 'original remains unchanged';
}

# vim: ft=perl6
