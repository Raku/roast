use v6;
use Test;

plan 18;

# Degenerate and Transformative Any methods
# -----
# This file covers methods on Any that are normally provided by other types
# and the Any version simply translates the object to that type, throws,
# or returns a degenerate result

{ # coverage; 2016-09-18
    throws-like { 42.Map }, X::Hash::Store::OddNumber, '.Map [odd  num of els]';
    is-deeply (42, 'a').Map, Map.new(("42" => "a")),   '.Map [even num of els]';

    is-deeply Any.kv,        (), 'Any:U.kv returns empty list';
    is-deeply Any.pairs,     (), 'Any:U.pairs returns empty list';
    is-deeply Any.antipairs, (), 'Any:U.antipairs returns empty list';

    my @exp = 1, 2, "foo";

    is-deeply $ .unshift(@exp), [@exp,], '.unshift on Any:U';
    is-deeply $ .prepend(@exp),  @exp,   '.prepend on Any:U';
    is-deeply $ .append( @exp),  @exp,   '.append  on Any:U';
    is-deeply $ .push(   @exp), [@exp,], '.push    on Any:U';
    is-deeply @ .prepend(@exp),  @exp,   '.prepend on Any:U [Positional]';
    is-deeply @ .append( @exp),  @exp,   '.append  on Any:U [Positional]';
    is-deeply @ .unshift(@exp), [@exp,], '.unshift on Any:U [Positional]';
    is-deeply @ .push(   @exp), [@exp,], '.push    on Any:U [Positional]';
}

{ # coverage; 2016-09-19
    is sum(),        0, 'sum() without args gives 0';
    is sum(1, 2, 3), 6, 'sum() with several args gives .sum';

    my Mu $x;
    cmp-ok (item $x).WHICH, '===', $x.WHICH, 'item(Mu) is identity';

    is Any.nl-out, "\n", 'default .nl-out is a "\n"';
    is class {
        method print (*@a) { "`@a[]`" }; method nl-out {42, 72}
    }.print-nl, ｢`42 72`｣, 'Any.print-nl calls self.print(self.nl-out)';
}

# vim: expandtab shiftwidth=4
