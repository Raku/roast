use v6;
use Test;
plan 9;

my @values = (5, 2, 10, 3);
{
    my @sorted = sort { $^a <=> $^b }, @values;
    is_deeply @sorted, [2, 3, 5, 10];
}
{
    my @sorted = sort * <=> *, @values;
    is_deeply @sorted, [2, 3, 5, 10];
}
{
    my @sorted = sort &infix:«<=>», @values;
    is_deeply @sorted, [2, 3, 5, 10];
}

my %rank = a => 5, b => 2, c => 10, d => 3;
is do {sort { %rank{$^a} <=> %rank{$^b} }, 'a'..'d'}, qw<b d a c>;

my @words = qw<d B c a>;
is do { sort { $^a.lc cmp $^b.lc }, @words }, qw<a B c d>;

is do { sort { %rank{$_} }, 'a'..'d' }, qw<b d a c>, 'unary sort - hash';
is do { sort { .lc }, @words }, qw<a B c d>, 'unary sort - case insensitive';

my @sorted-numerically = sort +*, @values;
is @sorted-numerically, [2, 3, 5, 10], 'numeric sort';
is do { sort -*, @values }, [10, 5, 3, 2], 'numeric sort - descending';
