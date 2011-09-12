use v6;

use Test;

plan 6;

# L<S12/"Calling sets of methods"/"It is also possible to trim the candidate list so that the current call is considered the final candidate.">

class Foo {
    # $.tracker is used to determine the order of calls.
    has $.tracker is rw;
    multi method doit($foo) { $.tracker ~= 'foo,' }   #OK not used
    method show  {$.tracker}
    method clear {$.tracker = ''}
}

class BazLastCallNext is Foo {
    multi method doit($foo) { $.tracker ~= 'baz,'; nextsame; }   #OK not used
    multi method doit(Int $foo) {   #OK not used
        $.tracker ~= 'bazint,';
        if 1 { lastcall }
        nextsame;
        $.tracker ~= 'ret3,';
    }
}

{
    my $o = BazLastCallNext.new;
    $o.clear;
    $o.doit("");
    is($o.show, 'baz,foo,', 'no lastcall, so we defer up the inheritance tree');
    $o.clear;
    is($o.show, '', 'sanity test for clearing');
    $o.doit(5);
    is($o.show, 'bazint,ret3,', 'lastcall meant nextsame failed, no deferal happened');
}

class BarLastCallSame is Foo {
    multi method doit($foo) {$.tracker ~= 'bar,'; lastcall; callsame; $.tracker ~= 'ret1,'}   #OK not used
    multi method doit(Int $num) {$.tracker ~= 'barint,'; callsame; $.tracker ~= 'ret2,'}   #OK not used
}

{
    my $o = BarLastCallSame.new;
    $o.clear;
    $o.doit("");
    is($o.show, 'bar,ret1,', 'lastcall trims candidate list, so no call up inheritance tree');
    $o.clear;
    is($o.show, '', 'sanity test for clearing');
    $o.doit(5);
    is($o.show, 'barint,bar,ret1,ret2,', 'lastcall trimming does not affect stuff earlier in chain');
}

# vim: ft=perl6
