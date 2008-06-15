use v6;

use Test;

plan 3;

# L<S12/"Calling sets of methods"/"It is also possible to trim the candidate list so that the current call is considered the final candidate.">

class Foo {
    # $.tracker is used to determine the order of calls.
    has $.tracker;
    method doit()  {$.tracker ~= 'foo,'}
    method doit(Int $num) {$.tracker ~= 'fooint,'}
    method show  {$.tracker}
    method clear {$.tracker = ''}
}

class BarLastCallSame is Foo {
    method doit() {$.tracker ~= 'bar,'; lastcall; $.tracker ~= 'ret1,'}
    method doit(Int $num) {$.tracker ~= 'barint,'; callsame; $.tracker ~= 'ret2,'}
}

{
    my $o = BarLastCallSame.new;
    $o.clear;
    $o.doit;
    is($o.show, 'bar,ret1,', 'lastcall inheritance test');
    $o.clear;
    is($o.show, '', 'sanity test for clearing');
    $o.doit(5);
    is($o.show, 'barint,bar,ret1,ret2,', 'lastcall multimethod/inheritance test');
}
