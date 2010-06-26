use v6;
use Test;
plan *;

# L<S02/Names and Variables/The empty>

{
    # Nil is an empty container. As a container, it is defined.
    #?rakudo 2 todo 'definedness of Nil'
    ok Nil.defined, 'Nil is defined';
    ok ().defined, '() is defined';
    my @a;
    @a.push: Nil;
    is @a.elems, 0, 'Nil in list context is empty list';
}

{
    my @a;
    @a.push: Nil(1);
    is @a.elems, 0, 'Coercion to Nil in list context';
    ok Nil(1).defined, 'Coercion to Nil in item context';
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
    ok defined(sink $i = 5 ), 'sink in scalar context (statement)';
    is $i, 5, '... statement executed';
    ok defined(sink {$i = 8} ), 'sink in scalar context (block)';
    is $i, 8, '... block executed';
}

#?rakudo skip 'Stringy'
{
    my $obj;
    my Int $int;

    is ~$obj, '', 'prefix:<~> on type object gives empty string (Mu)';
    is ~$int, '', 'prefix:<~> on type object gives empty string (Int)';
    is $obj.Stringy, '', '.Stringy on type object gives empty string (Mu)';
    is $int.Stringy, '', '.Stringy on type object gives empty string (Int)';

    ok (~$obj) ~~ Stringy, 'prefix:<~> returns a Stringy (Mu)';
    ok (~$int) ~~ Stringy, 'prefix:<~> returns a Stringy (Int)';

    ok $obj.Stringy ~~ Stringy, '.Stringy returns a Stringy (Mu)';
    ok $int.Stringy ~~ Stringy, '.Stringy returns a Stringy (Int)';

    is $obj.Str, 'Mu()', '.Str on type object gives Mu()';
    is $int.Str, 'Int()',    '.Str on type object gives Int()';

    is 'a' ~ $obj, 'a', 'infix:<~> uses coercion to Stringy (Mu)';
    is 'a' ~ $int, 'a', 'infix:<~> uses coercion to Stringy (Int)';
}

done_testing;

# vim: ft=perl6
