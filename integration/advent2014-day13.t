use Test;

plan 13;

my $said;
sub say(*@a) { $said = @a>>.gist.join }   # don't care about the new line

{
    my $a = 42;
    say 'value = $a';
    is $said, q/value = $a/;
    say "value = $a";
    is $said, q/value = 42/
}

{
    my @a = ^10;
    say 'value = @a';
    is $said, q/value = @a/;
    say "value = @a";
    is $said, q/value = @a/;
}

{
    my @a = ^10;
    say "value = @a[]";
    is $said, q/value = 0 1 2 3 4 5 6 7 8 9/;
}

{
    my %h = a => 42, b => 666;
    say "value = %h{}";
    ok $said eq q/value = a	42 b	666/|q/value = b	666 a42/;
}

{
    my @a;
    my %h = a => 42, b => 666;
    # a slice, but not a Zen slice:
    say "value = %h{@a}";
    is $said, q/value = /;
}

{
    my %h = a => 42, b => 666;
    say "value = %h{*}";
    ok $said eq q/value = 42 666/|q/value = 666 42/;
}

{
    sub a { 42 }
    say "value = &a()";
    is $said, q/value = 42/;
}

{
    my %h = a => 42, b => 666;
    say "value = %h.keys()";
    ok $said eq q/value = a b/|q/value = b a/;
}

{
    say "6 * 7 = { 6 * 7 }";
    is $said, q/6 * 7 = 42/;
}

{
    class A {
        method Str { "foo" }
        method gist { "bar" }
    }
    say "value = { A }";
    is $said, q/value = foo/;
    say "value = ", A;
    is $said, q/value = bar/;
}
