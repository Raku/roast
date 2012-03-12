use v6;
use Test;

plan 25;

{
    class A { method Str() { 'foo' } };
    my $a = A.new;

    my %h{Any};
    %h{$a} = 'blubb';
    is  %h{$a}, 'blubb', 'Any-typed hash access (+)';
    nok %h{A.new},       'and the hash really uses ===-semantics';
    dies_ok { %h{Mu.new} = 3 }, 'Any-typed hash does not like Mu keys';
    ok %h.keys[0] === $a, 'returned key is correct';
}

{
    my %h{Int};
    %h{2} = 3;
    is %h{1 + 1}, 3, 'value-type semantics';
    dies_ok { %h{'foo'} }, 'non-conformant type dies';
}

# combinations of typed and objecthash
{ 
    my Int %h{Rat};
    %h{0.5} = 1;
    %h{0.3} = 2;
    dies_ok { %h{2} = 3 },     'key type mismatch';
    dies_ok { %h{0.5} = 0.2 }, 'value type mismatch';
    dies_ok { %h{2} = 0.5 },   'key and value type mismatch';
    is %h.keys.sort.join(','), '0.3,0.5', '.keys';
    is ~%h.values.sort,        '1 2',     '.values';
    isa_ok %h.kv.flat[0],      Rat,       '.kv types (1)';
    isa_ok %h.kv.flat[1],      Int,       '.kv types (2)';
    isa_ok %h.pairs[0].key,    Rat,       '.pairs.key type';
    isa_ok %h.pairs[0].value,  Int,       '.pairs.value type';
    is %h.elems,               2,         '.elems';
    lives_ok { %h{0.2} := 3 }, 'binding to typed objecthash elements';
    is %h.elems,               3,         'updated .elems';
    dies_ok  { %h{ 3 } := 3 }, 'binding key type check failure';
    dies_ok  { %h{0.2} := 'a' }, 'binding value type check failure';
    #?rakudo todo '%h.push on typed hashes'
    dies_ok  { %h.push: 0.5 => 2 },
             'Hash.push fails when the resulting array conflicts with the type check';
    lives_ok { %h.push: 0.9 => 3 }, 'Hash.push without array creation is OK';
    dies_ok  { %h.push: 1 => 3 },   'Hash.push key type check failure';
    dies_ok  { %h.push: 1.1 => 0.2 }, 'Hash.push value type check failure';
}

{
    my %h{Any};
    %h = 1, 2;
    ok %h.keys[0] === 1, 'list assignment + object hashes';
}
