use v6;
use Test;

plan 59;

sub showkh($h) {
    $h.keys.sort.map({ $^k ~ ':' ~ $h{$k} }).join(' ')
}

# L<S02/Mutable types/"The QuantHash role differs from a normal Associative hash">

# untyped QuantHash
{
    my %h is QuantHash = a => 1, b => 3, c => -1, d => 7;
    is showkh(%h), 'a:1 b:3 c:-1 d:7', 'Inititalization worked';
    is %h.elems, 10, '.elems';
    is +%h, 10, 'prefix:<+> calls .elems, not .keys';

    lives_ok { %h<d> = 0 }, 'Can set an item to 0';
    is +%h.keys, 3, '... and an item is gone';
    is showkh(%h), 'a:1 b:3 c:-1', '... and the right one is gone';
    nok %h<d>:exists, '... also according to exists';

    %h<c>++;
    is showkh(%h), 'a:1 b:3', '++ on an item with -1 deletes it';
    %h<a>--;
    is showkh(%h), 'b:3', '-- also removes items when they go to zero';
    %h<b>--;
    is showkh(%h), 'b:2', '... but only when they go to zero';

    %h<c> = 'abc';
    is showkh(%h), 'b:2 c:abc', 'Can store a string as well';
    %h<c> = '';
    is +%h.keys, 1, 'Setting a value to the null string also removes it';

    %h<b> = Nil;
    is +%h.keys, 0, 'Setting a value to Nil also removes it';
    nok %h, 'An empty QuantHash is false';

    %h<foo bar baz> = "", 5, False;
    is showkh(%h), 'bar:5', 'Assignment to multiple keys';

    (%h<foo> = 0) = 7;
    is showkh(%h), 'bar:5 foo:7', '(%keyhash<foo> = 0) = 7';
    (%h<foo> = 15) = '';
    is showkh(%h), 'bar:5', '(%keyhash<foo> = 15) = \'\'';
}

{
    my %h is QuantHash = a => 5, b => 0, c => 1, d => '', e => Any;
    is showkh(%h), 'a:5 c:1', 'Pairs with false values are ignored in assignment';

    %h = foo => 1, bar => 2, foo => 1;
    is showkh(%h), 'bar:2 foo:1', "Duplicate keys aren't stored";

    %h = foo => 1, bar => 5, foo => 0,
         bar => '', bar => 3, baz => 0, baz => 'narwhal';
    is showkh(%h), 'bar:3 baz:narwhal', 'When pairs conflict, the last is preferred';

    %h = 'foo', 2, 'bar', 6, 'foo', 0,
         'bar', '', 'bar', 4, 'baz', 0, 'baz', 'unicorn';
    is showkh(%h), 'bar:4 baz:unicorn', 'Assignment of a flat list';
}

#?rakudo skip 'Non-string QuantHash keys NYI'
{
    my %h is QuantHash = 2 => 1, a => 2, (False) => 3;

    my @ks = %h.keys;
    is @ks.grep(Int)[0], 2, 'Int keys are left as Ints';
    is @ks.grep(* eqv False).elems, 1, 'Bool keys are left as Bools';
    is @ks.grep(Str)[0], 'a', 'And Str keys are permitted in the same set';
    is %h{2, 'a', False}.sort.join(' '), '1 2 3', 'All keys have the right values';
}

# QuantHash of Ints
{
    #?rakudo emit   role R1284381704 does QuantHash[Int] {}; my %h is R1284381704; # 'my SomeType %h' NYI
    my Int %h is QuantHash;
    %h = a => 1, b => 3, c => -1, d => 7, e => 0;
    is +%h.keys, 4, 'Initializing QuantHash of Ints worked';

    is %h<camelia>, 0, 'Correct default value';
    is %h.elems, 10, '.elems';

    lives_ok { %h<d> = 0 }, 'Can set an item to 0';
    is +%h.keys, 3, '... and an item is gone';
    is showkh(%h), 'a:1 b:3 c:-1', '... and the right one is gone';

    %h<c>++;
    is showkh(%h), 'a:1 b:3', '++ on an item with -1 deletes it';

    %h<a>--;
    is showkh(%h), 'b:3', '-- also removes items when they go to zero';
    %h<b>--;
    is showkh(%h), 'b:2', '... but only when they go to zero';
}

# QuantHash of Strs
{
    #?rakudo emit   role R1284382935 does QuantHash[Str] {}; my %h is R1284382935; # 'my SomeType %h' NYI
    my Str %h is QuantHash;
    %h = a => 'foo', b => 'bar', c => 'baz', d => 'boor', e => '';
    is +%h.keys, 4, 'Initializing QuantHash of Strs works';

    is %h<camelia>, '', 'Correct default value';

    lives_ok { %h<d> = '' }, 'Can set an item to the null string';
    is +%h.keys, 3, '... and an item is gone';
    is showkh(%h), 'a:foo b:bar c:baz', '... and the right one is gone';

    %h<c> ~~ s/baz//;
    is showkh(%h), 'a:foo b:bar', 'Changing a value to the null string deletes it';
    %h<b> ~~ s/bar/b/;
    is showkh(%h), 'a:foo b:b', '... but not changing it to a one-character string';
}

# QuantHash with a custom default value
{
    #?rakudo emit   role R1284381677 does QuantHash[Any, 42] {}; my %h is R1284381677; # 'my %h is SomeType[WithParams]' NYI
    my %h is QuantHash[Any, 42];
    %h = a => 1, b => 2, c => 0, x1 => 42;
    is showkh(%h), 'a:1 b:2 c:0', 'Initializing a QuantHash with a custom default';

    is %h<answer>, 42, 'QuantHash with custom default returns the default for an unassigned key';
    is showkh(%h), 'a:1 b:2 c:0', '...without changing the QuantHash';

    %h<a> = '';
    is showkh(%h), 'a: b:2 c:0', "Setting a key to the empty string doesn't remove it";
    %h<a> = 42;
    is showkh(%h), 'b:2 c:0', 'But setting a key to the default does remove it';
}

# L<S32::Containers/QuantHash/"=item grab">

# Weighted .pick
{
    my %h is QuantHash = a => 1, b => 1, c => 1, d => 20;

    my @a = %h.pick: *;
    is +@a, 23, '.pick(*) returns the right number of items';
    is @a.grep(* eq 'a').elems, 1, '.pick (1)';
    is @a.grep(* eq 'b').elems, 1, '.pick (2)';
    is @a.grep(* eq 'c').elems, 1, '.pick (3)';
    is @a.grep(* eq 'd').elems, 20, '.pick (4)';
    isnt @a[^3].join, 'abc', '.pick (5)';
}

# Weighted .roll
{
    my %h is QuantHash = a => 1, b => 2;

    my @a = %h.roll: 100;
    is +@a, 100, '.roll(100) returns 100 items';
    ok 2 < @a.grep(* eq 'a') < 75, '.roll (1)';
    ok @a.grep(* eq 'a') + 2 < @a.grep(* eq 'b'), '.roll (2)';
}

# .grab
{
    my %h is QuantHash = a => 40, b => 80;

    my @a = %h.grab: 30;
    is +%h, 90, '.grab(30) removes 30 elements';
    is +@a, 30, '.grab(30) yields 30 items';
    ok 1 < @a.grep(* eq 'a') < 30, '.grab (1)';
    ok @a.grep(* eq 'a') < @a.grep(* eq 'b'), '.grab (2)';
}

# vim: ft=perl6
