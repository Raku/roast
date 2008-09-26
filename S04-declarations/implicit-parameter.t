use v6;
use Test;
plan 16;

# L<S04/The Relationship of Blocks and Declarations/"A bare closure without
# placeholder arguments that uses $_">

{
    # test with explicit $_
    my $f1 = { 2*$_ };
    is $f1(2), 4, 'Block with explit $_ has one formal paramter';
}

{
    # test with implicit $_
    my $f2 = { .sqrt };
    is_approx $f2(4), 2, 'Block with implict $_ has one formal parameter';
}

{
    # { } has implicit signature ($_ is rw = $OUTER::_)
    
    $_ = 'Hello';
    #?pugs todo 'feature'
    #?rakudo skip 'dispatch error (non-catchable)'
    is(try { { $_ }.() }, 'Hello',              '$_ in bare block defaults to outer');
    is({ $_ }.('Goodbye'), 'Goodbye',   'but it is only a default');
    is({ 42 }.(), 42,                   'no implicit $_ usage checking');
    is({ 42 }.('Goodbye'), 42,          '$_ gets assigned but isn\'t used');

    #?rakudo 2 todo 'arity of blocks with $_'
    is(({ $_ }.arity), 1,                 '{$_} is arity 1, of course');
    is(({ .say }.arity), 1,               'Blocks that uses $_ implicitly have arity 1');
}

#?rakudo skip 'pointy blocks'
{
    dies_ok(sub () { -> { "Boo!" }.(42) },     '-> {} is arity 0', :todo<feature>);
    dies_ok(sub () { -> { $_ }.(42) },         'Even when we use $_', :todo<feature>);
    
    is(try { $_ = "Ack"; -> { $_ }.() }, 'Ack!',     '$_ is lexical here', :todo<feature>);
    is(-> $a { $_ }.(42), 'Ack!',       'Even with parameters (?)', :todo<feature>);
    is(-> $_ { $_ }.(42), 42,           'But not when the parameter is $_');

    dies_ok( sub () { -> { $^a }.() },  'Placeholders not allowed in ->');

    is(-> { }.arity, 0,                 '->{} is arity 0, again');
}

{
    #?rakudo skip 'parse failure'
    dies_ok(sub () { sub { $^foo }.(42) },  'Placeholders not allowed in sub()');
}
