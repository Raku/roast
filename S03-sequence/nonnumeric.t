use v6;
use Test;
 
plan 35;

# L<S03/List infix precedence/'C<.succ> is assumed'>

#?rakudo skip 'hangs'
#?niecza skip 'Two definitions found for symbol ::GLOBAL::&infix:<cmp> (etc)'
{
    class Alternating {
        has Int $.val;
        method Str { 'A' ~ $.val }
        method succ { Alternating.new(val => -($.val + 1)) }
        method pred { Alternating.new(val => -($.val - 1)) }
    }
    multi infix:<cmp> (Alternating $x, Alternating $y) { abs($x.val) cmp abs($y.val) }
    multi infix:<cmp> (Alternating $x, Int $n)         { abs($x.val) cmp abs($n) }
    multi infix:<eqv> (Alternating $x, Alternating $y) { abs($x.val) eqv abs($y.val) }
    multi infix:<eqv> (Alternating $x, Int $n)         { abs($x.val) eqv abs($n) }
    my $f = { Alternating.new(val => $^v) };

    is ($f(0) ... $f(4)).join(' '), 'A0 A-1 A2 A-3 A4', 'finite increasing sequence with user class (1)';
    is ($f(0) ... 4).join(' '), 'A0 A-1 A2 A-3 A4', 'finite increasing sequence with user class (2)';
    is ($f(-9) ... 4).join(' '), 'A-9 A8 A-7 A6 A-5 A4', 'finite decreasing sequence with user class';
    is ($f(-9) ...^ 4).join(' '), 'A-9 A8 A-7 A6 A-5', 'finite decreasing exclusive sequence with user class (1)';
    is ($f(-9) ...^ -4).join(' '), 'A-9 A8 A-7 A6 A-5 A4', 'finite decreasing exclusive sequence with user class (2)';
    is ($f(2), { $_.succ.succ } ... 10).join(' '), 'A2 A4 A6 A8 A10', 'finite sequence with closure and user class (1)';
    is ($f(2), { $_.succ.succ } ... 9).join(' '), 'A2 A4 A6 A8', 'finite sequence with closure and user class (2)';
    is ($f(1), { $_.succ.succ } ... { $_.v**2 < 100 }).join(' '), 'A1 A3 A5 A7 A9', 'finite sequence with closure, termination function, and user class';
    is ($f(2) ... *)[^5].join(' '), 'A2 A-3 A4 A-5 A6', 'infinite increasing sequence with user class';
    is ($f(2), $f(1) ... *)[^5].join(' '), 'A2 A1 A0 A1 A-2', 'infinite decreasing sequence with user class';
    is ($f(0), $f(0) ... *)[^5].join(' '), 'A0 A0 A0 A0 A0', 'constant sequence with user class';
}

# L<S03/List infix precedence/that happen to represent single codepoints>
# character sequence

is ('a'  ... 'g').join(', '), 'a, b, c, d, e, f, g', 'finite sequence started with one letter';
is ('a'  ... *).[^7].join(', '), 'a, b, c, d, e, f, g', 'sequence started with one letter';
is ('a', 'b' ... *).[^10].join(', '), 'a, b, c, d, e, f, g, h, i, j', 'sequence started with two different letters';
is (<a b c> ... *).[^10].join(', '), "a, b, c, d, e, f, g, h, i, j", "character sequence started from array";
is ('z' ... 'a').[^10].join(', '), 'z, y, x, w, v, u, t, s, r, q', 'descending sequence started with one letter';
is (<z y> ... 'a').[^10].join(', '), 'z, y, x, w, v, u, t, s, r, q', 'descending sequence started with two different letters';
is (<z y m> ... 'a').[^10].join(', '), 'z, y, m, l, k, j, i, h, g, f', 'descending sequence started with three different letters';
is (<a b>, { .succ } ... *).[^7].join(', '), 'a, b, c, d, e, f, g', 'characters xand arity-1';
is ('x' ... 'z').join(', '), 'x, y, z', "sequence ending with 'z' don't cross to two-letter strings";
is ('A' ... 'z').elems, 'z'.ord - 'A'.ord + 1, "sequence from 'A' to 'z' is finite and of correct length";
is ('α' ... 'ω').elems, 'ω'.ord - 'α'.ord + 1, "sequence from 'α' to 'ω' is finite and of correct length";
is ('☀' ... '☕').join(''), '☀☁☂☃☄★☆☇☈☉☊☋☌☍☎☏☐☑☒☓☔☕', "sequence from '☀' to '☕'";
is ('☀' ...^ '☕').join(''), '☀☁☂☃☄★☆☇☈☉☊☋☌☍☎☏☐☑☒☓☔', "exclusive sequence from '☀' to '☕'";

# # L<S03/List infix precedence/doesn't terminate with a simple>
# the tricky termination test

#?niecza skip 'munch not implemented'
{
    ok ('A' ... 'ZZ').munch(1000).elems < 1000, "'A' ... 'ZZ' does not go on forever";
    #?rakudo 2 skip 'Decrement out of range'
    ok ('ZZ' ... 'A').munch(1000).elems < 1000, "'ZZ' ... 'A' does not go on forever";
    ok ('Z' ... 'AA').munch(1000).elems < 1000, "'Z' ... 'AA' does not go on forever";
}

is ('A' ...^ 'ZZ')[*-1], 'ZY', "'A' ...^ 'ZZ' omits last element";

# be sure the test works as specced even for user classes
#?rakudo skip 'lifting comparison ops'
#?niecza skip 'Two definitions found for symbol ::GLOBAL::&infix:<cmp> (etc)'
{
    class Periodic {
        has Int $.val;
        method Str { 'P' ~ $.val }
        method succ { Periodic.new(val => ($.val >= 2 ?? 0 !! $.val + 1)) }
        method pred { Periodic.new(val => ($.val <= 0 ?? 2 !! $.val - 1)) }
    }
    multi infix:<cmp> (Periodic $x, Periodic $y) { $x.val cmp $y.val }
    multi infix:<cmp> (Periodic $x, Int $n)      { $x.val cmp $n }
    multi infix:<eqv> (Periodic $x, Periodic $y) { $x.val eqv $y.val }
    multi infix:<eqv> (Periodic $x, Int $n)      { $x.val eqv $n }
    my $f = { Periodic.new(val => $^v) };
    
    is ($f(0) ... 5)[^7].join(' '), 'P0 P1 P2 P0 P1 P2 P0', 'increasing periodic sequence';
    is ($f(0) ... -1)[^7].join(' '), 'P0 P2 P1 P0 P2 P1 P0', 'decreasing periodic sequence';

    is ($f(0) ... 2).join(' '), 'P0 P1 P2', 'increasing not-quite-periodic sequence';
    is ($f(2) ... 0).join(' '), 'P2 P1 P0', 'decreasing not-quite-periodic sequence';
    is ($f(0) ...^ 2).join(' '), 'P0 P1', 'exclusive increasing not-quite-periodic sequence';
    is ($f(2) ...^ 0).join(' '), 'P2 P1', 'exclusive decreasing not-quite-periodic sequence';
}

is ('1a', '1b' ... '1e').Str, '1a 1b 1c 1d 1e', 'sequence with strings that starts with a digit but cannot convert to numbers';

done;

# vim: ft=perl6
