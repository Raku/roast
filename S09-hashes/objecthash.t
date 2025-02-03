use Test;

plan 62;

{
    class A { method Str() { 'foo' } };
    my $a = A.new;

    my %h{Any};
    %h{$a} = 'blubb';
    is  %h{$a}, 'blubb', 'Any-typed hash access (+)';
    nok %h{A.new},       'and the hash really uses ===-semantics';
    dies-ok { %h{Mu.new} = 3 }, 'Any-typed hash does not like Mu keys';
    ok %h.keys.list[0] === $a, 'returned key is correct';
} #4

{
    my %h{Int};
    %h{2} = 3;
    is %h{1 + 1}, 3, 'value-type semantics';
    dies-ok { %h{'foo'} }, 'non-conformant type dies';
} #2

# combinations of typed and objecthash
{
    my Int %h{Rat};
    %h{0.5} = 1;
    %h{0.3} = 2;
    dies-ok { %h{2} = 3 },     'key type mismatch';
    dies-ok { %h{0.5} = 0.2 }, 'value type mismatch';
    dies-ok { %h{2} = 0.5 },   'key and value type mismatch';
    is %h.keys.sort.join(','), '0.3,0.5', '.keys';
    is ~%h.values.sort,        '1 2',     '.values';
    isa-ok %h.kv.list[0],           Rat,  '.kv types (1)';
    isa-ok %h.kv.list[1],           Int,  '.kv types (2)';
    isa-ok %h.pairs.list[0].key,    Rat,  '.pairs.key type';
    isa-ok %h.pairs.list[0].value,  Int,  '.pairs.value type';
    is %h.elems,               2,         '.elems';
    lives-ok { %h{0.2} := 3 }, 'binding to typed objecthash elements';
    is %h.elems,               3,         'updated .elems';
    dies-ok  { %h{ 3 } := 3 }, 'binding key type check failure';
    dies-ok  { %h{0.2} := 'a' }, 'binding value type check failure';
    dies-ok  { %h.push: 0.5 => 2 },
             'Hash.push fails when the resulting array conflicts with the type check';
    lives-ok { %h.push: 0.9 => 3 }, 'Hash.push without array creation is OK';
    dies-ok  { %h.push: 1 => 3 },   'Hash.push key type check failure';
    dies-ok  { %h.push: 1.1 => 0.2 }, 'Hash.push value type check failure';
} #18

{
    my %h{Any};
    %h = 1, 2;
    ok %h.keys.list[0] === 1, 'list assignment + object hashes';
} #1

{
    my %h{Mu};
    %h{Mu} = 2;
    is %h{Mu}, 2, 'using Mu as a key';
    %h{Any} = 3;
    is %h{Any}, 3, 'using Any as a key';
    #?rakudo skip 'oh noes, it dies'
    is %h{ Mu, Any }.join(","), "2,3", 'check slice access on Mu';
    is %h{*}.sort.join(","), "2,3", 'check whatever access with Mu as key';
} #6

# https://github.com/Raku/old-issue-tracker/issues/3139
{
    my %h{Any};
    %h{Any}=1;
    ok %h{Any}:exists, '.exists returns True on a %h{Any} in a TypedHash';
}

# https://github.com/Raku/old-issue-tracker/issues/4264
{
    lives-ok { my %h = my %x{Date}; },
        'declaring empty object hash on rhs of assignment to hash does not die with "Cannot look up attributes in a type object"';
}

# https://github.com/Raku/old-issue-tracker/issues/4307
{
    is (my %h1).list.elems, 0, 'empty hash listifies to empty list';
    is (my %h2{Any}).list.elems, 0, 'empty object hash listifies to empty list';
}

# https://github.com/Raku/old-issue-tracker/issues/3138
{
    my %h{Any};
    my %i:=%h.new;
    is %h.WHAT, %i.WHAT, "New on an object hash instance produces an object hash";

    my %j:=%h.new;
    is %h.WHAT, %j.WHAT, "Clone of an object hash instance is an object hash";
}

# https://github.com/Raku/old-issue-tracker/issues/2660
{
    my $r1 = role { method foo() { 5 } };
    my $r2 = role { method foo() { 7 } };
    my %hash{Any};
    %hash{"quux" but $r1} = 9;
    %hash{"quux" but $r2} = 11;

    is %hash.keys>>.foo.sort, (5, 7), 'Can use mixin objects as keys';
}

# https://github.com/rakudo/rakudo/issues/5165
{
    my %input = foo => True, bar => True;
    my %input-typed{Any} = %input;
    my %copy = (%input-typed,);
    is-deeply %copy, %input, 'Assigning a list with an object hash to another Hash gives the content back';
    is-deeply %(%input-typed,), %input, 'Enforcing hash context on a list of an object hash gives the content back';
}

{
    my %a = 1 => {2 => {3 => 42}};

    is-deeply %a{1;2}:exists,         True;
    is-deeply %a{1;2;3}:exists,       True;
    is-deeply %a{1;2;3;4}:exists,     False;

    is-deeply %a{-99;2;3}:exists,     False;
    is-deeply %a{1;-99;3}:exists,     False;
    is-deeply %a{1;2;-99}:exists,     False;

    is-deeply %a{1,1;2;3}:exists,     (True, True);
    is-deeply %a{1;2,2;3}:exists,     (True, True);
    is-deeply %a{1;2;3,3}:exists,     (True, True);

    is-deeply %a{1,-99;2;3}:exists,   (True, False);
    is-deeply %a{1;2,-99;3}:exists,   (True, False);
    is-deeply %a{1;2;3,-99}:exists,   (True, False);

    is-deeply %a{1,1;2,2;3}:exists,   (True, True, True, True);
    is-deeply %a{1,1;2;3,3}:exists,   (True, True, True, True);
    is-deeply %a{1;2,2;3,3}:exists,   (True, True, True, True);

    is-deeply %a{1,1;2,2;3,3}:exists, (True, True, True, True, True, True, True, True);

    is-deeply %a{1;1..3}:exists,      (False, True, False);
}

{
    eval-lives-ok 'my %*a{Int}', "Accept dynamic object hash"
}

# https://github.com/rakudo/rakudo/issues/4678
my %oh{Any};
%oh<a> = %oh;
for <Str gist raku> -> $method {
    lives-ok { %oh."$method"() },
      "self referencing object hash doesn't loop on '$method'";
}

# https://github.com/rakudo/rakudo/issues/1997
{
    my %a{Mu} = :42a, :666b, :137c;
    my %b := %a.clone;
    %b<c> = 256;
    is-deeply %a,  (my %{Mu} = :42a, :666b, :137c), 'is original unchanged';
    is-deeply %b,  (my %{Mu} = :42a, :666b, :256c), 'is clone updated';
}

# https://github.com/rakudo/rakudo/issues/4301
{
    throws-like { my %h{Int(Str)}; %h<a> = 42 }, X::Str::Numeric,
      'did the coercion failure throw in time';
}

# vim: expandtab shiftwidth=4
