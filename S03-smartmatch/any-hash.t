use v6;
use Test;

plan 6;
#L<S03/Smart matching/hash value slice truth>

{
    my %h = (a => 0, b => 0, c => 1, d => 2);
    sub notautoquoted_a { 'a' };
    sub notautoquoted_c { 'c' };

    #?niecza todo
    ok  (%h ~~ .{'c'}),     '%hash ~~ .{true"}';
    ok !(%h ~~ .{'b'}),     '%hash ~~ .{false"}';
    ok !(%h ~~ .{notautoquoted_a}), '~~. {notautoquoted_a}';
    #?niecza todo
    ok  (%h ~~ .{notautoquoted_c}), '~~. {notautoquoted_c}';
    #?niecza todo
    ok  (%h ~~ .<c>),     '%hash ~~ .<true"}';
    ok !(%h ~~ .<b>),     '%hash ~~ .<false"}';
}

# vim: ft=perl6
