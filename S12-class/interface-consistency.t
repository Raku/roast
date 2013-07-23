use v6;

use Test;

# L<S12/Interface Consistency>

plan 8;

class Foo {
    our &m1 = method m1($a) {   #OK not used
        1
    }
    our &m2 = method m2($a, *%foo) {   #OK not used
        %foo.keys.elems
    }
}

lives_ok { Foo.new.m1(1, :x<1>, :y<2>) }, 'implicit *%_ means we can pass extra nameds';
ok &Foo::m1.signature.perl ~~ /'*%_'/,    '*%_ shows up in .perl of the Signature';
lives_ok { Foo.new.m2(1, :x<1>, :y<2>) }, 'explicit *%_ means we can pass extra nameds';
ok &Foo::m2.signature.perl !~~ /'*%_'/,   'With explicit one, *%_ not in .perl of the Signature';

class Bar is Foo is hidden {
    our &m1 = method m1($a) {   #OK not used
        2
    }
}

dies_ok { Bar.new.m1(1, :x<1>, :y<2>) },  'is hidden means no implicit *%_';
ok &Bar::m1.signature.perl !~~ /'*%_'/,   '*%_ does not show up in .perl of the Signature';


class Baz is Bar {
    method m1($a) {   #OK not used
        nextsame;
    }
}

is Baz.new.m1(42), 1, 'is hidden on Bar means we skip over it in deferal';


class Fiz is Foo {
    method m1($a) {   #OK not used
        4
    }
}
class Faz hides Fiz {
    method m1($a) {   #OK not used
        nextsame;
    }
}

is Faz.new.m1(42), 1, 'hides Fiz means we skip over Fiz in deferal';

# vim: ft=perl6
