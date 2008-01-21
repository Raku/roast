use v6-alpha;
use Test;
plan 21;

# L<S29/"List"/"=item sort">

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
    is(@s, @e, 'array of numbers was sorted (w/out parans)');
}

{
    my @a = (4, 5, 3, 2, 5, 1);
    my @e = (1 .. 5, 5);

    my @s = @a.sort;
    is(@s, @e, 'array of numbers was sorted (using invocant form)');
}

{
    my @a = (2, 45, 6, 1, 3);
    my @e = (1, 2, 3, 6, 45);

    my @s = sort { $^a <=> $^b }, @a;
    is(@s, @e, '... with explicit spaceship'); 
}

{
    my @a = (2, 45, 6, 1, 3);
    my @e = (1, 2, 3, 6, 45);

    my @s = sort { $^a <=> $^b }: @a;
    is(@s, @e, '... with closure as indirect invocant'); 
}

{
    my @a = (2, 45, 6, 1, 3);
    my @e = (1, 2, 3, 6, 45);

    my @s = { $^a <=> $^b }.sort: @a;
    is(@s, @e, '... with closure as direct invocant'); 
}

{
    my @a = (2, 45, 6, 1, 3);
    my @e = (1, 2, 3, 6, 45);

    my @s = @a.sort:{ $^a <=> $^b };
    is(@s, @e, '... with explicit spaceship (using invocant form)'); 
}

{
    my @a = (2, 45, 6, 1, 3);
    my @e = (45, 6, 3, 2, 1);

    my @s = sort { $^b <=> $^a }, @a;
    is(@s, @e, '... reverse sort with explicit spaceship'); 
}

{
    my @a = (2, 45, 6, 1, 3);
    my @e = (45, 6, 3, 2, 1);

    my @s = @a.sort:{ $^b <=> $^a };
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
    is(@s, @e, 'array of strings was sorted (w/out parans)');
}

{
    my @a = <foo bar gorch baz>;
    my @e = <bar baz foo gorch>;

    my @s = @a.sort;
    is(@s, @e, 'array of strings was sorted (using invocant form)');
}

{
    my @a = <daa boo gaa aaa>;
    my @e = <aaa boo daa gaa>;

    my @s = sort { $^a cmp $^b }, @a;
    is(@s, @e, '... with explicit cmp'); 
}

{
    my @a = <daa boo gaa aaa>;
    my @e = <aaa boo daa gaa>;

    my @s = @a.sort:{ $^a cmp $^b };
    is(@s, @e, '... with explicit cmp (using invocant form)'); 
}

{
    my %a = (4 => 'a', 1 => 'b', 2 => 'c', 5 => 'd', 3 => 'e');
    my @e = (4, 1, 2, 5, 3);

    my @s = sort { %a{$^a} cmp %a{$^b} }, %a.keys;
    is(@s, @e, '... sort keys by string value'); 
}

{
    my %a = (4 => 'a', 1 => 'b', 2 => 'c', 5 => 'd', 3 => 'e');
    my @e = (4, 1, 2, 5, 3);

    my @s = %a.keys.sort:{ %a{$^a} cmp %a{$^b} };
    is(@s, @e, '... sort keys by string value (using invocant form)');
}

{
    my %a = ('a' => 4, 'b' => 1, 'c' => 2, 'd' => 5, 'e' => 3);
    my @e = <b c e a d>;

    my @s = sort { %a{$^a} <=> %a{$^b} }, %a.keys;
    is(@s, @e, '... sort keys by numeric value');
}

{
    my %a = ('a' => 4, 'b' => 1, 'c' => 2, 'd' => 5, 'e' => 3);
    my @e = <b c e a d>;

    my @s = %a.keys.sort:{ %a{$^a} <=> %a{$^b} };
    is(@s, @e, '... sort keys by numeric value (using invocant form)');
}

# .sort shouldn't work on non-arrays
{
    dies_ok { 42.sort:{ 0 } },    "method form of sort should not work on numbers", :todo<bug>;
    dies_ok { "str".sort:{ 0 } }, "method form of sort should not work on strings", :todo<bug>;
    is ~(42,).sort:{ 0 }, "42",   "method form of sort should work on arrays";
}
