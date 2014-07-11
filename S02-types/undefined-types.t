use v6;
use Test;
plan 49;

# L<S02/Names and Variables/The empty>

# Nil is an empty container. As a container, it is defined.
{
    ok !Nil.defined, 'Nil is undefined';
    ok ().defined, '() is defined';
    my @a= 1, Nil, 3;
    is @a.elems, 2, 'Nil as part of list, is empty list';
    ok (@a.push: Nil) =:= @a, "Pushing Nil returns same array";
    is @a.elems, 2, 'Pushing Nil in list context is empty list';
    ok (@a.unshift: Nil) =:= @a, "Unshifting Nil returns same array";
    is @a.elems, 2, 'Unshifting Nil in list context is empty list';
    is (@a = Nil), Nil, "Setting to Nil returns Nil";
    is @a.elems, 0, 'Setting to Nil restores original state';
} #7

# typed scalar
#?niecza skip "doesn't know typed stuff"
{
    my Int $a = 1;
    is ($a = Nil), Nil, "assigning Nil to Int should work";
    ok !$a.defined,  "Nil makes undefined here";
} #2

# typed array
#?niecza skip "doesn't know typed stuff"
{
    my Int @a = 1, Nil, 3;
    #?rakudo todo ".clone doesn't copy typedness"
    is @a.of, '(Int)', "Check that we have an 'Int' array";
    is @a.elems, 2,  'Nil as part of Int list, is empty list';
    ok ( @a.push: Nil ) =:= @a, "assigning Nil returns same array";
    is @a.elems, 2, 'Pushing Nil in Int list context is empty list';
    ok ( @a.unshift: Nil ) =:= @a, "assigning Nil returns same array";
    is @a.elems, 2, 'Unshifting Nil in Int list context is empty list';
    ok !defined(@a[1] = Nil), "assigning Nil to Int should work";
    ok !@a[1].defined,  "Nil makes undefined here";
    is ( @a = Nil ), Nil, "setting to Nil returns Nil";
    #?rakudo todo ".clone doesn't copy typedness"
    is @a.of, '(Int)', "Check that we still have an 'Int' array";
    is @a.elems, 0, 'Setting to Nil restores original state';
} #11

# typed hash
#?niecza skip "doesn't know typed stuff"
{
    my Int %a = a => 1, Nil, c => 3;
    #?rakudo todo ".clone doesn't copy typedness"
    is %a.of, '(Int)', "Check that we have an 'Int' hash";
    is %a.elems, 2,  'Nil as part of Int list, is empty pair';
    is ( %a<b> = Nil ), Nil, "assigning Nil to hash element should work";
    ok !%a<b>.defined,  "Nil makes undefined here";
    is ( %a = Nil ), Nil, "setting to Nil returns Nil";
    #?rakudo todo ".clone doesn't copy typedness"
    is %a.of, '(Int)', "Check that we still have an 'Int' hash";
    is %a.elems, 0, 'Setting to Nil restores original state';
} #7

# sink context returns Nil
{
    my @a;
    my $i = 0;
    @a.push: 1, sink $i++;
    is @a.elems, 1, 'sink statement prefix returns Nil (list context)';
    is $i, 1, 'sink execucted the statement';

    @a = ();
    @a.push: 2, sink { $i = 2 };
    is @a.elems, 1, 'sink block prefix returns Nil (list context)';
    is $i, 2, 'the block was executed';
    ok !defined(sink $i = 5 ), 'sink in scalar context (statement)';
    is $i, 5, '... statement executed';
    ok !defined(sink {$i = 8} ), 'sink in scalar context (block)';
    is $i, 8, '... block executed';
} #8

# undefined objects
{
    my $obj;
    my Int $int;

    is ~$obj, '', 'prefix:<~> on type object gives empty string (Any)';
    is ~$int, '', 'prefix:<~> on type object gives empty string (Int)';
    is $obj.Stringy, '', '.Stringy on type object gives empty string (Any)';
    is $int.Stringy, '', '.Stringy on type object gives empty string (Int)';

    ok (~$obj) ~~ Stringy, 'prefix:<~> returns a Stringy (Any)';
    ok (~$int) ~~ Stringy, 'prefix:<~> returns a Stringy (Int)';

    ok $obj.Stringy ~~ Stringy, '.Stringy returns a Stringy (Any)';
    ok $int.Stringy ~~ Stringy, '.Stringy returns a Stringy (Int)';

    is $obj.gist, '(Any)', '.gist on type object gives (Any)';
    is $int.gist, '(Int)', '.gist on type object gives (Int)';

    is 'a' ~ $obj, 'a', 'infix:<~> uses coercion to Stringy (Any)';
    is 'a' ~ $int, 'a', 'infix:<~> uses coercion to Stringy (Int)';
} #12

# vim: ft=perl6
