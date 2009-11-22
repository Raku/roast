use v6;
use Test;
plan *;

# L<S02/Undefined types>

{
    ok !Nil.defined, 'Nil is undefined';
    my @a;
    @a.push: Nil;
    is @a.elems, 0, 'Nil in list context is empty list';
}

{
    my @a;
    @a.push: Nil(1);
    is @a.elems, 0, 'Coercion to Nil in list context';
    ok !Nil(1).defined, 'Coercion to Nil in item context';
}

{
    my @a;
    my $i = 0;
    @a.push: 1, sink $i++;
    is @a.elems, 1, 'sink statement prefix returns Nil (list context)';
    is $i, 1, 'sink execucted the statement';

    @a = ();
    @a.push: 2, sink { $i = 2 };
    is @a.elems, 2, 'sink block prefix returns Nil (list context)';
    is $i, 2, 'the block was executed';
    ok !defined(sink $i = 5 ), 'sink in scalar context (statement)';
    is $i, 5, '... statement executed';
    ok !defined(sink {$i = 8} ), 'sink in scalar context (block)';
    is $i, 8, '... block executed';
}

done_testing;

# vim: ft=perl6
