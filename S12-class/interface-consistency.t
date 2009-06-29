use v6;

use Test;

# L<S12/Interface Consistency>

plan 6;

class Foo {
    method m1($a) {
        1
    }
    method m2($a, *%foo) {
        %foo.keys.elems
    }
}

lives_ok { Foo.new.m1(1, :x<1>, :y<2>) }, 'implicit *%_ means we can pass extra nameds';
ok &Foo::m1.signature.perl ~~ /'*%_'/,    '*%_ shows up in .perl of the Signature';
lives_ok { Foo.new.m2(1, :x<1>, :y<2>) }, 'explicit *%_ means we can pass extra nameds';
ok &Foo::m2.signature.perl !~~ /'*%_'/,   'With explict one, *%_ not in .perl of the Signature';

class Bar is Foo is hidden {
    method m1($a) {
        2
    }
}

#?rakudo todo 'Parrot bug sees us not complaining about uncaptured named parameters'
dies_ok { Bar.new.m1(1, :x<1>, :y<2>) },  'is hidden means no implict *%_';
ok &Bar::m1.signature.perl !~~ /'*%_'/,   '*%_ does not show up in .perl of the Signature';

