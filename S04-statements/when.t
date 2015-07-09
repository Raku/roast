use Test;

plan 12;

my $c = { when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } };
is $c(1), 'one', 'when works in a circumfix:<{ }> (1)';
is $c(2), 'two!', 'when works in a circumfix:<{ }> (2)';
is $c(3), 'many', 'default works in a circumfix:<{ }>';

my $p = -> $_ { when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } };
is $p(1), 'one', 'when works in a pointy block declaring $_ (1)';
is $p(2), 'two!', 'when works in a pointy block declaring $_ (2)';
is $p(3), 'many', 'default works in a pointy block declaring $_';

sub foo($_) { when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } }
is foo(1), 'one', 'when works in a sub declaring $_ (1)';
is foo(2), 'two!', 'when works in a sub declaring $_ (2)';
is foo(3), 'many', 'default works in a sub declaring $_';

class C {
    method m($_) { when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } }
}
is C.m(1), 'one', 'when works in a sub declaring $_ (1)';
is C.m(2), 'two!', 'when works in a sub declaring $_ (2)';
is C.m(3), 'many', 'default works in a sub declaring $_';
