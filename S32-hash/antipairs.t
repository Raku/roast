use v6;
use Test;

# L<S32::Containers/Hash/antipairs>

plan 5;

{
    my %h = a => 'b', c => 'd';
    isa-ok %h.antipairs, Seq, 'Hash.antipairs returns a Seq';
    is-deeply %h.antipairs.sort.list, (b => 'a', d => 'c'), 'simple Hash.antipairs works';
    is-deeply %h, { a => 'b', c => 'd' }, 'original remains unchanged';
}

{
    # with lists
    my %h = a => <b c>, d => 'e';
    is-deeply %h.antipairs.sort.list, (<b c> => 'a', e => 'd'),
              'Hash.antipairs does not flatten list values';
    is-deeply %h, {a => <b c>, d => 'e'}, 'original remains unchanged';
}

# vim: ft=perl6
