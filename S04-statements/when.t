use v6;
use Test;

plan 24;

my $c = { when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } };
is $c(1), 'one', 'when works in a circumfix:<{ }> (1)';
is $c(2), 'two!', 'when works in a circumfix:<{ }> (2)';
is $c(3), 'many', 'default works in a circumfix:<{ }>';

my $p = -> $_ { when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } };
is $p(1), 'one', 'when works in a pointy block declaring $_ (1)';
is $p(2), 'two!', 'when works in a pointy block declaring $_ (2)';
is $p(3), 'many', 'default works in a pointy block declaring $_';

my $pi = -> { $_ = 4; when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } };
is $pi(), 'many', 'when works in a pointy block using its implicit $_';

sub foo($_) { when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } }
is foo(1), 'one', 'when works in a sub declaring $_ (1)';
is foo(2), 'two!', 'when works in a sub declaring $_ (2)';
is foo(3), 'many', 'default works in a sub declaring $_';

sub bar() { $_ = 2; when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } }
is bar(), 'two!', 'when works in sub using its implicit $_';

class C {
    method m($_) { when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } }
    method i() { $_ = 1; when 1 { 'one' }; when 2 { 'two!' }; default { 'many' } }
}
is C.m(1), 'one', 'when works in a method declaring $_ (1)';
is C.m(2), 'two!', 'when works in a method declaring $_ (2)';
is C.m(3), 'many', 'default works in a method declaring $_';
is C.i, 'one', 'when works in a method using its implicit $_';

my $nest = sub ($n) {
    $_ = $n * 2;
    when * > 2 {
        when 4 { 'four!' }
        default { 'huge' }
    }
    default {
        'little'
    }
}
is $nest(1), 'little', 'nested when in a sub works (1)';
is $nest(2), 'four!', 'nested when in a sub works (2)';
is $nest(3), 'huge', 'nested when in a sub works (3)';

# RT #115384
{
    my $iters = 0;
    $iters++ for do given 1 { when True { { a => 1, b => 2 } } };
    is $iters, 2, 'when does not force itemization';
}
{
    my $iters = 0;
    $iters++ for do given 1 { when True { ${ a => 1, b => 2 } } };
    is $iters, 1, 'when does not strip itemization';
}
{
    my $a = 41;
    .++ for do given 1 { when True { $a } };
    is $a, 42, 'when does not strip Scalar containers';
}
{
    my $iters = 0;
    $iters++ for do given 1 { default { { a => 1, b => 2 } } };
    is $iters, 2, 'default does not force itemization';
}
{
    my $iters = 0;
    $iters++ for do given 1 { default { ${ a => 1, b => 2 } } };
    is $iters, 1, 'default does not strip itemization';
}
{
    my $a = 41;
    .++ for do given 1 { default { $a } };
    is $a, 42, 'default does not strip Scalar containers';
}
