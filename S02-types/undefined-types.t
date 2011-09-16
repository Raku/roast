use v6;
use Test;
plan 23;

# L<S02/Names and Variables/The empty>

{
    # Nil is an empty container. As a container, it is defined.
    ok !Nil.defined, 'Nil is undefined';
    ok ().defined, '() is defined';
    my @a;
    @a.push: Nil;
    is @a.elems, 0, 'Nil in list context is empty list';
}

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
}

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

    is $obj.gist, 'Any()', '.gist on type object gives Any()';
    is $int.gist, 'Int()', '.gist on type object gives Int()';

    is 'a' ~ $obj, 'a', 'infix:<~> uses coercion to Stringy (Any)';
    is 'a' ~ $int, 'a', 'infix:<~> uses coercion to Stringy (Int)';
}

done;

# vim: ft=perl6
