use v6;

use Test;

plan 21;

# L<S12/"Calling sets of methods"/"Any method can defer to the next candidate method in the list">

# Simple test, making sure nextwith passes on parameters properly.
class A {
    method a(*@A) {
        (self.perl, @A)
    }
}
class B is A {
    method a() {
        nextwith("FIRST ARG", "SECOND ARG")
    }
}
{
    my $instance = B.new;
    my @result = $instance.a();
    is @result.elems, 3, 'nextwith passed on right number of parameters';
    is @result[0], $instance.perl, 'invocant passed on correctly';
    is @result[1], "FIRST ARG", 'first argument correct';
    is @result[2], "SECOND ARG", 'second argument correct';
}

class Foo {
    # $.tracker is used to determine the order of calls.
    has $.tracker is rw;
    multi method doit()  {$.tracker ~= 'foo,'}
    multi method doit(Int $num) {$.tracker ~= 'fooint,'}   #OK not used
    method show  {$.tracker}
    method clear {$.tracker = ''}
}

class BarNextSame is Foo {
    multi method doit() {$.tracker ~= 'bar,'; nextsame; $.tracker ~= 'ret1,'}
    multi method doit(Int $num) {$.tracker ~= 'barint,'; nextsame; $.tracker ~= 'ret2,'}   #OK not used
}

{
    my $o = BarNextSame.new;
    $o.clear;
    $o.doit;
    is($o.show, 'bar,foo,', 'nextsame inheritance test');
    $o.clear;
    is($o.show, '', 'sanity test for clearing');
    $o.doit(5);
    is($o.show, 'barint,fooint,', 'nextsame multimethod/inheritance test');
}

class BarNextWithEmpty is Foo {
    multi method doit() {$.tracker ~= 'bar,'; nextwith(); $.tracker ~= 'ret1,'}
    multi method doit(Int $num) {$.tracker ~= 'barint,'; nextwith($num); $.tracker ~= 'ret2,'}   #OK not used
}
{
    my $o = BarNextWithEmpty.new;
    $o.clear;
    $o.doit;
    is($o.show, 'bar,foo,', 'nextwith() inheritance test');
    $o.clear;
    is($o.show, '', 'sanity test for clearing');
    $o.doit(5);
    is($o.show, 'barint,fooint,', 'nextwith() multimethod/inheritance test');
}

class BarNextWithInt is Foo {
    multi method doit() {$.tracker ~= 'bar,'; nextwith(); $.tracker ~= 'ret1,'}
    multi method doit(Int $num) {$.tracker ~= 'barint,'; nextwith(42); $.tracker ~= 'ret2,'}   #OK not used
}
{
    my $o = BarNextWithInt.new;
    $o.clear;
    $o.doit;
    is($o.show, 'bar,foo,', 'nextwith(42) inheritance test');
    $o.clear;
    is($o.show, '', 'sanity test for clearing');
    $o.doit(5);
    is($o.show, 'barint,fooint,', 'nextwith(42) multimethod/inheritance test');
}

{
    my $called = 0;
    class DeferWithoutCandidate {
        multi method a($x) {   #OK not used
            $called = 1;
            nextwith();
        }
    }
    #?rakudo todo 'variant of RT 69608'
    dies_ok { DeferWithoutCandidate.new.a(1) },
        'Dies when nextwith() does not find a candidate to dispatch to';
    is $called, 1, 'but was in the correct method before death';
}

{
    my $r;
    class AA {
        proto method l (|) { * }
        multi method l ( &t, *@list ) {
            $r ~= '&';
            $r ~= @list.join;
            $r;
        }
        multi method l ( %t, *@list ) {
            $r ~= '%';
            $r ~= @list.join;
            nextwith( { %t{$^a} }, @list );
        }
        multi method l ( @t, *@list ) {
            $r ~= '@';
            $r ~= @list.join;
            nextwith( { @t[$^a] }, @list );
        }
    }

    my $a = AA.new;
    is $a.l( {$_}, 1,2,3 ), '&123', 'return direct call to code ref candidate';
    is $r, '&123', "direct call to code ref candidate";

    $r='';
    #?rakudo 2 todo "oh noes, it doesnt work"
    is $a.l( my %a, 4,5,6 ), '%456&456', 'return from hash candidate';
    is $r, '%456&456', "call to hash candidate";

    $r='';
    #?rakudo 2 todo "oh noes, it doesnt work"
    is $a.l( my @a, 7,8,9 ), '@789&789', 'return from array candidate';
    is $r, '@789&789', "call to array candidate";
}

# vim: ft=perl6
