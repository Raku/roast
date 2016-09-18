use v6;
use Test;

plan 33;

# Degenerate and Transformative Any methods
# -----
# This file covers methods on Any that are normally provided by other types
# and the Any version simply translates the object to that type, throws,
# or returns a degenerate result

{ # coverage; 2016-09-18
    throws-like { 42.classify      }, Exception, '.classify()    on Any throws';
    throws-like { 42.classify:   * }, Exception, '.classify(*)   on Any throws';
    throws-like { 42.categorize    }, Exception, '.categorize()  on Any throws';
    throws-like { 42.categorize: * }, Exception, '.categorize(*) on Any throws';

    throws-like { 42.Map }, X::Hash::Store::OddNumber, '.Map [odd  num of els]';
    is-deeply (42, 'a').Map, Map.new(("42" => "a")),   '.Map [even num of els]';

    is-deeply Any.kv,        (), 'Any:U.kv returns empty list';
    is-deeply Any.pairs,     (), 'Any:U.pairs returns empty list';
    is-deeply Any.antipairs, (), 'Any:U.antipairs returns empty list';

    my @exp = 1, 2, "foo";
    my class AnyU {
        method append  (*@got) { is-deeply @got, @exp, 'append called' ; 1; }
        method prepend (*@got) { is-deeply @got, @exp, 'prepend called'; 1; }
        method unshift (*@got) { is-deeply @got, @exp, 'unshift called'; 1; }
        method push    (*@got) { is-deeply @got, @exp, 'push called'   ; 1; }
    }
    my class AnyUPos is AnyU does Positional {}

    for <append  prepend  unshift  push> -> $m {
        is AnyU."$m"(   @exp), 1, ".$m on custom Any:U";
        is AnyUPos."$m"(@exp), 1, ".$m on custom Any:U does Positonal";
    }

    is-deeply $ .unshift(@exp), [@exp,], '.unshift on Any:U';
    is-deeply $ .prepend(@exp),  @exp,   '.prepend on Any:U';
    is-deeply $ .append( @exp),  @exp,   '.append  on Any:U';
    is-deeply $ .push(   @exp), [@exp,], '.push    on Any:U';
    is-deeply @ .prepend(@exp),  @exp,   '.prepend on Any:U [Positional]';
    is-deeply @ .append( @exp),  @exp,   '.append  on Any:U [Positional]';
    is-deeply @ .unshift(@exp), [@exp,], '.unshift on Any:U [Positional]';
    is-deeply @ .push(   @exp), [@exp,], '.push    on Any:U [Positional]';
}
