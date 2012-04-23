use v6;
use Test;
plan 32;

# L<S32::Containers/"List"/"=item sort">

{
    my @a = (4, 5, 3, 2, 5, 1);
    my @e = (1 .. 5, 5);

    my @s = sort(@a);
    is(@s, @e, 'array of numbers was sorted');
}

{
    my @a = (4, 5, 3, 2, 5, 1);
    my @e = (1 .. 5, 5);

    my @s = sort @a;
    is(@s, @e, 'array of numbers was sorted (w/out parens)');
}

{
    # This test used to have NaN in it, but that is nonsensical.
    #                                          --colomon
    
    my @a = (1.1,2,-3.05,0.1,Inf,42,-1e-07,-Inf).sort;
    my @e = (-Inf,-3.05,-1e-07,0.1,1.1,2,42,Inf);
    my @s = sort @a;
    is(@s, @e, 'array of mixed numbers including Inf');
}

{
    my @a = (4, 5, 3, 2, 5, 1);
    my @e = (1 .. 5, 5);

    my @s = @a.sort;
    is(@s, @e, 'array of numbers was sorted (using invocant form)');
}

#?pugs todo
{
    my @a = (2, 45, 6, 1, 3);
    my @e = (1, 2, 3, 6, 45);

    my @s = sort { $^a <=> $^b }, @a;
    is(@s, @e, '... with explicit spaceship');
}

#?rakudo skip "closure as non-final argument"
#?niecza skip 'Invocant handling is NYI'
#?pugs todo
{
    my @a = (2, 45, 6, 1, 3);
    my @e = (1, 2, 3, 6, 45);

    my @s = sort { $^a <=> $^b }: @a;
    is(@s, @e, '... with closure as indirect invocant');
}

#?rakudo skip "method fallback to sub unimpl"
#?niecza skip 'err, what?'
#?pugs todo
{
    my @a = (2, 45, 6, 1, 3);
    my @e = (1, 2, 3, 6, 45);

    my @s = { $^a <=> $^b }.sort: @a;
    is(@s, @e, '... with closure as direct invocant');
}

#?pugs todo
{
    my @a = (2, 45, 6, 1, 3);
    my @e = (1, 2, 3, 6, 45);

    my @s = @a.sort: { $^a <=> $^b };
    is(@s, @e, '... with explicit spaceship (using invocant form)');
}

#?pugs todo
{
    my @a = (2, 45, 6, 1, 3);
    my @e = (45, 6, 3, 2, 1);

    my @s = sort { $^b <=> $^a }, @a;
    is(@s, @e, '... reverse sort with explicit spaceship');
}

#?pugs todo
{
    my @a = (2, 45, 6, 1, 3);
    my @e = (45, 6, 3, 2, 1);

    my @s = @a.sort: { $^b <=> $^a };
    is(@s, @e, '... reverse sort with explicit spaceship (using invocant form)');
}

{
    my @a = <foo bar gorch baz>;
    my @e = <bar baz foo gorch>;

    my @s = sort(@a);
    is(@s, @e, 'array of strings was sorted');
}

{
    my @a = <foo bar gorch baz>;
    my @e = <bar baz foo gorch>;

    my @s = sort @a;
    is(@s, @e, 'array of strings was sorted (w/out parens)');
}

{
    my @a = <foo bar gorch baz>;
    my @e = <bar baz foo gorch>;

    my @s = @a.sort;
    is(@s, @e, 'array of strings was sorted (using invocant form)');
}

#?pugs todo
{
    my @a = <daa boo gaa aaa>;
    my @e = <aaa boo daa gaa>;

    my @s = sort { $^a cmp $^b }, @a;
    is(@s, @e, '... with explicit cmp');
}

#?pugs todo
{
    my @a = <daa boo gaa aaa>;
    my @e = <aaa boo daa gaa>;

    my @s = @a.sort: { $^a cmp $^b };
    is(@s, @e, '... with explicit cmp (using invocant form)');
}


#?pugs todo
{
    my %a = (4 => 'a', 1 => 'b', 2 => 'c', 5 => 'd', 3 => 'e');
    my @e = (4, 1, 2, 5, 3);

    my @s = sort { %a{$^a} cmp %a{$^b} }, %a.keys;
    is(@s, @e, '... sort keys by string value');
}

#?pugs todo
{
    my %a = (4 => 'a', 1 => 'b', 2 => 'c', 5 => 'd', 3 => 'e');
    my @e = (4, 1, 2, 5, 3);

    my @s = %a.keys.sort: { %a{$^a} cmp %a{$^b} };
    is(@s, @e, '... sort keys by string value (using invocant form)');
}

#?pugs todo
{
    my %a = ('a' => 4, 'b' => 1, 'c' => 2, 'd' => 5, 'e' => 3);
    my @e = <b c e a d>;

    my @s = sort { %a{$^a} <=> %a{$^b} }, %a.keys;
    is(@s, @e, '... sort keys by numeric value');
}

#?pugs todo
{
    my %a = ('a' => 4, 'b' => 1, 'c' => 2, 'd' => 5, 'e' => 3);
    my @e = <b c e a d>;

    my @s = %a.keys.sort: { %a{$^a} <=> %a{$^b} };
    is(@s, @e, '... sort keys by numeric value (using invocant form)');
}


#?pugs skip '.key'
{
    my %map = (p => 1, e => 2, r => 3, l => 4);

    is <r e p l>.sort({ %map{$_} }).join, 'perl',
            'can sort with automated Schwartzian Transform';

    my @s = %map.sort: { .value };
    isa_ok(@s[0], Pair, '%hash.sort returns a List of Pairs');
    is (@s.map: { .key }).join, 'perl', 'sort with unary sub'
}


#?niecza todo "Niecza's sort is not stable"
#?pugs skip 'Cannot cast into Array: VRef'
{
    is (<P e r l 6>.sort: { 0; }).join, 'Perl6',
    'sort with arity 0 closure is stable';

    my @a = ([5, 4], [5, 5], [5, 6], [0, 0], [1, 2], [1, 3], [0, 1], [5, 7]);

    {
        my @s = @a.sort: { .[0] };

        ok ([<] @s.map({.[1]})), 'sort with arity 1 closure is stable';
    }

    {
        my @s = @a.sort: { $^a.[0] <=> $^b.[0] };

        ok ([<] @s.map({.[1]})), 'sort with arity 2 closure is stable';
    }
}

##  XXX pmichaud, 2008-07-01:  .sort should work on non-list values
{
    is ~42.sort, "42", "method form of sort should work on numbers";
    is ~"str".sort, "str", "method form of sort should work on strings";
    is ~(42,).sort, "42",  "method form of sort should work on parcels";
}

# RT #67010
#?pugs todo
{
    my @list = 1, 2, Code;
    lives_ok { @list.sort: { $^a cmp $^b } },
        'sort by class name';
}

# RT #68112
#?rakudo skip "determine behavior of 0-arity methods passed to sort"
#?niecza skip "determine behavior of 0-arity methods passed to sort"
{
    sub foo () { 0 }   #OK not used
    lives_ok { (1..10).sort(&foo) },
        'sort accepts 0-arity method';
    # errr... is there even supposed to be a rand sub?
    lives_ok { (1..10).sort(&rand) },
        'sort accepts rand method';
}

# RT #71258
{
    class RT71258_1 { };

    my @sorted;

    #?niecza todo 'Is this test actually testing for correct behavior?'
    lives_ok { @sorted = (RT71258_1.new, RT71258_1.new).sort },
        'sorting by stringified class instance (name and memory address)';

    class RT71258_2 {
        has $.x;
        method Str { $.x }
    };

    # Following tests removed because you cannot 
    # affect the behavior of sort by defining 
    # sub cmp.  As far as I understand things, you
    # couldn't even affect it by defined 
    # a new sub infix:<cmp>. --colomon

    # multi sub cmp(RT71258_2 $a, RT71258_2 $b) {
    #     $a.x <=> $b.x;
    # }
    # 
    # #?rakudo todo 'nom regression'
    # lives_ok {
    #     @sorted = (
    #         RT71258_2.new(x => 2),
    #         RT71258_2.new(x => 3),
    #         RT71258_2.new(x => 1)
    #     ).sort
    # }, 'sorting stringified class instance with custom cmp';
    # 
    # #?rakudo todo 'nom regression'
    # is ~@sorted, '1 2 3',
    #     'checking sort order with custom cmp';
}

# vim: ft=perl6
