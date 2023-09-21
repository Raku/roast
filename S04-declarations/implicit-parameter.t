use v6.c;
use Test;
plan 20;

# L<S04/The Relationship of Blocks and Declarations/A bare closure
# (except the block associated with a conditional statement)>

{
    # test with explicit $_
    my $f1 = { 2*$_ };
    is $f1(2), 4, 'Block with explicit $_ has one formal parameter';
}

{
    # test with implicit $_
    my $f2 = { .sqrt };
    is-approx $f2(4), 2, 'Block with implicit $_ has one formal parameter';
}

{
    # { } has implicit signature ($_ is rw = $OUTER::_)

    $_ = 'Hello';
    is(try { { $_ }.() }, 'Hello',              '$_ in bare block defaults to outer');
    is({ $_ }.('Goodbye'), 'Goodbye',   'but it is only a default');
    is({ 42 }.(), 42,                   'no implicit $_ usage checking');
    is({ 42 }.('Goodbye'), 42,          '$_ gets assigned but is not used');

    is(({ $_ }.arity), 0,                 '{$_} is arity 0, of course');
    is(({ .say }.arity), 0,               'Blocks that uses $_ implicitly have arity 0');
    is(({ $_ }.count), 1,                 '{$_} is count 1');
    is(({ .say }.count), 1,               'Blocks that uses $_ implicitly have count 1');
}

{
    $_ = 'Ack!';
    dies-ok({ (-> { "Boo!" }).(42) },     '-> {} is arity 0');
    dies-ok({ (-> { $_ }).(42) },         'Even when we use $_>');

    #?niecza todo
    is((-> { $_ }).(),      'Ack!',       '$_ is lexical here');
    #?niecza todo
    is(-> $a { $_ }.(42),   'Ack!',       'Even with parameters');
    is(-> $_ { $_ }.(42),   42,           'But not when the parameter is $_');

    throws-like 'sub () { -> { $^a }.() }', X::Signature::Placeholder,
        'Placeholders not allowed in ->';

    is(-> { }.arity, 0,                 '->{} is arity 0, again');
}

{
    throws-like 'sub () { $^foo }.(42)', X::Signature::Placeholder,
        'Placeholders not allowed in sub()';
}

# RT #114696
{
    my $string;
    $_ = 'Moo';
    for .chars ... 1 -> $len {
        $string ~= $_;
        { $string ~= $_; }
    }
    is $string, 'MooMooMooMooMooMoo', 'outer $_ is seen within nested blocks';
}

# RT #125767
{
    is (1.map: { .sqrt => .sqrt }), (1 => 1), 'hash like block with implicit parameter'
}

# vim: ft=perl6
