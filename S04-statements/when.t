use Test;

plan 24;

#?rakudo skip 'exception type X::Syntax::OutsideOfTopicalizer NYI RT #125132'
{
throws-like 'when 1 { }', X::Syntax::OutsideOfTopicalizer, keyword => 'when',
    'when block in mainline complains about missing topicalizer';
throws-like 'default { }', X::Syntax::OutsideOfTopicalizer, keyword => 'default',
    'default block in mainline complains about missing topicalizer';

throws-like '-> { when 1 { } }', X::Syntax::OutsideOfTopicalizer, keyword => 'when',
    'when block in pointy not declaring $_ complains about missing topicalizer';
throws-like '-> { default { } }', X::Syntax::OutsideOfTopicalizer, keyword => 'default',
    'default block in pointy not declaring $_ complains about missing topicalizer';

throws-like 'given 42 -> $a { when 1 { } }', X::Syntax::OutsideOfTopicalizer, keyword => 'when',
    'when block in pointy on given not declaring $_ complains about missing topicalizer';
throws-like 'given 42 -> $a { default { } }', X::Syntax::OutsideOfTopicalizer, keyword => 'default',
    'default block in pointy on given not declaring $_ complains about missing topicalizer';

throws-like 'for 1, 2, 3 -> $a { when 1 { } }', X::Syntax::OutsideOfTopicalizer, keyword => 'when',
    'when block in pointy on for loop not declaring $_ complains about missing topicalizer';
throws-like 'for 1, 2, 3 -> $a { default { } }', X::Syntax::OutsideOfTopicalizer, keyword => 'default',
    'default block in pointy on for loop not declaring $_ complains about missing topicalizer';

throws-like 'sub foo() { when 1 { } }', X::Syntax::OutsideOfTopicalizer, keyword => 'when',
    'when block in sub not declaring $_ complains about missing topicalizer';
throws-like 'sub foo() { default { } }', X::Syntax::OutsideOfTopicalizer, keyword => 'default',
    'default block in sub not declaring $_ complains about missing topicalizer';

throws-like 'my class C { method foo() { when 1 { } } }', X::Syntax::OutsideOfTopicalizer, keyword => 'when',
    'when block in method not declaring $_ complains about missing topicalizer';
throws-like 'my class C { method foo() { default { } } }', X::Syntax::OutsideOfTopicalizer, keyword => 'default',
    'default block in method not declaring $_ complains about missing topicalizer';
}

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
