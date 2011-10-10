use v6;
use Test;

plan 2;

{
    class A      {
        has $.tracker is rw = '';
        method x { $.tracker ~= 'A' }
    };
    class B is A      { method x { $.tracker ~= 'B'; nextsame } };
    class C is A      { method x { $.tracker ~= "C"; nextsame } };
    class D is B is C { method x { $.tracker ~= "D"; nextsame } }
    class E is C      { method x { $.tracker ~= "E"; nextsame } };
    class F is D is E { method x { $.tracker ~= "F"; nextsame } };
    my $x = F.new;
    $x.x;
    is $x.tracker, 'FDBECA', 'got the right MRO for 6 classes';
    # not really spec yet
    #?niecza skip '.^mro'
    is $x.^mro.gist, 'F() D() B() E() C() A() Any() Mu()',
       '.^mro';
}
