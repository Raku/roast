use v6;

use Test;

plan 8;

# test the unless statement modifier

{
    my $a = 1;
    $a = 4 without 'a' eq 'a';
    is($a, 1, "post without True");
}

{
    my $a = 1;
    $a = 5 without Nil;
    is($a, 5, "post without Nil");
}

{
    my $a = 1;
    $a = $_ without Int;
    is($a, Int, "post without type object");
}

{
        my $answer = 1;
        my @x = 41, (42 without $answer), 43;
        my @z = 41, 43;
        #?niecza todo "empty list as element not flattened - https://github.com/sorear/niecza/issues/180"
        is @x, @z, "without expr on true cond";
}

{
        my $answer = Failure.new;
        my @x = 41, (42 without $answer), 43;
        my @y = 41, (!$answer ?? 42 !! ()), 43;
        my @z = 41, 42, 43;
        is @y, @z, "sanity check";
        is @x, @y, "without expr on false cond";
}

{
    my $a = 'oops';
    { $a = 'ok' } without Nil;
    is $a, 'ok', 'Statement-modifier without runs bare block';
}

{
    my $a = 'oops';
    { $a = $^x } without Failure.new;
    is $a.WHAT, Failure, 'Statement-modifier without runs block with placeholder';
}

# vim: ft=perl6
