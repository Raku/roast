use v6;
use Test;

plan 9;

#L<S12/Enums/"An enum is a low-level class that can function as a role 
# or property">

enum Maybe <No Yes Dunno>;
class Bar            { }

{
    class Foo does Maybe { }

    my $x = Foo.new(Maybe => 0);

    ok($x.No,     'Can test for enum members set by .new()');
    ok(!$x.Yes,   'Can test for enum members set by .new()');
    ok(!$x.Dunno, 'Can test for enum members set by .new()');
}

{
    my $y = Bar.new() does Maybe(1);

    ok(!$y.No,    'Can test for enum members set by does Maybe(1)');
    ok($y.Yes,    'Can test for enum members set by does Maybe(1)');
    ok(!$y.Dunno, 'Can test for enum members set by does Maybe(1)');
}

{
    my $z = Bar.new() does Maybe(Dunno);

    ok(!$z.No,    'Can test for enum members set by does Maybe(dunno)');
    ok(!$z.Yes,   'Can test for enum members set by does Maybe(dunno)');
    ok($z.Dunno,  'Can test for enum members set by does Maybe(dunno)');
}


# vim: ft=perl6
