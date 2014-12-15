use v6;

use Test;

plan 5;

# L<S12/"FALLBACK methods"/"special name FALLBACK">

class A {
    method omg() { 'a method!' }
    method FALLBACK($name, |c) { "$name, cannot {c[0]} with {c<meat>}" }
}

is A.omg, 'a method!', 'FALLBACK does not break normal dispatch';
is A.wtf('bbq', meat => 'sausage'), 'wtf, cannot bbq with sausage',
    'FALLBACK fires on missing method, passing name and args';

class B is A { }
is B.wtf('bbq', meat => 'BLUTWURST'), 'wtf, cannot bbq with BLUTWURST',
    'FALLBACK inherited';

class D {
    method in-the-madness() { 'win!' }
}
class C {
    has D $!delegate-stuff-to-me handles *;
    method FALLBACK($name, |c) {
        'comes last'
    }
}

my $c = C.new;
is $c.in-the-madness, 'win!', 'delegation beats FALLBACK';
is $c.the-light, 'comes last', 'FALLBACK catches what delegation does not';

# vim: ft=perl6
