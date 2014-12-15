use v6;

use Test;

plan 13;

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

class E {
    multi method FALLBACK($name where /^a/) {
        'starts with a';
    }
    multi method FALLBACK($) {
        'not with a';
    }
}

is E.agenda, 'starts with a', 'Can multi-dispatch on method name (more specific match)';
is E.blerg,  'not with a',    'Can multi-dispatch on method name (fallback)';

class F {
    multi method FALLBACK($name, Int) { 'Int' }
    multi method FALLBACK($name, Str) { 'Str' }
}
is F.something(42), 'Int', 'Can multi-dispatch on regular arguments (1)';
is F.something(''), 'Str', 'Can multi-dispatch on regular arguments (2)';
is F.new.something(''), 'Str', 'Can multi-dispatch on regular arguments (also on an instance)';

dies_ok { F.something() }, 'Error when none of the candidates match';

class I {
    method postcircumfix:<( )>(|) { 'invaught' }
    method FALLBACK($name, |c) { 'yes, I work' }
}
my $i = I.new;
is $i.spy, 'yes, I work', 'FALLBACK is effective with a postcircumfix:<( )>';
is $i(), 'invaught', 'postcircumfix:<( )> beats FALLBACK';

# vim: ft=perl6
