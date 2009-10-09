use v6;
use Test;
plan *;

# L<S06/Signature Introspection>

{
    my sub a($x, Int $y?, :$z) { };
    isa_ok &a.signature.params, List, '.params is a List';
    my @l = &a.signature.params;
    ok ?(all(@l) ~~ Parameter), 'And all items are Paramters';
    is +@l, 3, 'we have three of them';
    is ~(@l>>.name), '$x $y $z', 'can get the names with sigils';
    ok @l[0].type === Any, 'Could get first type';
    ok @l[1].type === Int, 'Could get second type';

    is ~(@l>>.readonly), '1 1 1', 'they are all read-only';
    is ~(@l>>.rw),       '0 0 0', '... none rw';
    is ~(@l>>.copy),     '0 0 0', '... none copy';
    is ~(@l>>.ref),      '0 0 0', '... none ref';
    is ~(@l>>.slurpy),   '0 0 0', '... none slurpy';
    is ~(@l>>.optional), '0 1 1', '... some optional';
    is ~(@l>>.invocant), '0 0 0', '... none invocant';

}


done_testing;

# vim: ft=perl6
