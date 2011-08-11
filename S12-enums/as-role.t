use v6;
use Test;

plan 9;

#L<S12/Anonymous Mixin Roles using C<but> or C<does>/they may be used to name a desired property>

enum Maybe <No Yes Dunno>;
class Bar            { }

{
    class Foo does Maybe { }

    my $x = Foo.new(Maybe => No);

    ok($x.No,     'Can test for enum members set by .new()');
    ok(!$x.Yes,   'Can test for enum members set by .new()');
    ok(!$x.Dunno, 'Can test for enum members set by .new()');
}

{
    my $y = Bar.new() does Maybe(Yes);

    ok(!$y.No,    'Can test for enum members set by does Maybe(Yes)');
    ok($y.Yes,    'Can test for enum members set by does Maybe(Yes)');
    ok(!$y.Dunno, 'Can test for enum members set by does Maybe(Yes)');
}

{
    my $z = Bar.new() but Maybe(Dunno);

    ok(!$z.No,    'Can test for enum members set by but Maybe(Dunno)');
    ok(!$z.Yes,   'Can test for enum members set by but Maybe(Dunno)');
    ok($z.Dunno,  'Can test for enum members set by but Maybe(Dunno)');
}


# vim: ft=perl6
