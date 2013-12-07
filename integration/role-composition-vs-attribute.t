use v6;

use Test;

plan 7;

{
    role B { method x { 3; } }

    class T does B { }

    class S does B {
        has $.t is rw;
        method x { $.t.x }
        submethod BUILD(*@_) { $!t = T.new }
    }

    is S.new.x, 3, "Test class inherited from the same role caused infinite loop bug";
}

{
    role A {
        has Int $!a;
    }
    class Foo does A {
        method foo { $!a++ }
    }
    my $foo = Foo.new;
    is $foo.foo, 0, 'did we see the Int private attribute from the role';
    is $foo.foo, 1, 'did we update the Int private attribute from the role';
}

#?rakudo skip 'alas, no visibility of native private attributes yet'
{
    role C {
        has int $!c;
    }
    class Bar does A {
        method bar { $!c++ }
    }
    my $bar = Bar.new;
    is $bar.bar, 0, 'did we see the int private attribute from the role';
    is $bar.bar, 1, 'did we update the int private attribute from the role';
}

{
    role AA {
        has Int $!aa;
    }
    role BB does AA {}
    class Baz does BB {
        method baz { $!aa++ }
    }
    my $baz = Baz.new;
    is $baz.baz, 0, 'did we see the Int private attribute from the embedded role';
    is $baz.baz, 1, 'did we update the Int private attribute from the embedded role';
}

# vim: ft=perl6
