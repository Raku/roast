use v6;

use Test;

plan 21;

=begin pod

Very basic class tests from L<S12/Classes>

=end pod

# L<S12/Classes>
class Foo {}

my $foo = Foo.new();
ok($foo ~~ Foo, '... smartmatch our $foo to the Foo class');

# note that S12 says that .isa() should be called on metaclasses.
# However, making it an object .isa() means that classes are free to
# override the behaviour without playing with the metamodel via traits
ok($foo.isa(Foo), '.isa(Foo)');
ok($foo.isa(::Foo), '.isa(::Foo)');
ok($foo.isa("Foo"), '.isa("Foo")');
ok(!$foo.isa("Bar"), '!.isa("Bar")');

#?rakudo skip 'clone not yet implemetned'
{
    my $foo_clone = $foo.clone();
    ok($foo_clone ~~ Foo, '... smartmatch our $foo_clone to the Foo class');
}

class Foo::Bar {}

my $foo_bar = Foo::Bar.new();
ok($foo_bar ~~ Foo::Bar, '... smartmatch our $foo_bar to the Foo::Bar class');

ok($foo_bar.isa(Foo::Bar), '.isa(Foo::Bar)');
ok(!$foo_bar.isa(::Foo), '!Foo::Bar.new.isa(::Foo)');


# L<S12/Classes/An isa is just a trait that happens to be another class>
class Bar is Foo {}

ok(Bar ~~ Foo, '... smartmatch our Bar to the Foo class');

my $bar = Bar.new();
ok($bar ~~ Bar, '... smartmatch our $bar to the Bar class');
ok($bar.isa(Bar), "... .isa(Bar)");
ok($bar ~~ Foo, '... smartmatch our $bar to the Foo class');
ok($bar.isa(Foo), "new Bar .isa(Foo)");

#?rakudo skip 'clone not yet implemetned'
#?DOES 4
{
    my $bar_clone = $bar.clone();
    ok($bar_clone ~~ Bar, '... smartmatch our $bar_clone to the Bar class');
    ok($bar_clone.isa(Bar), "... .isa(Bar)");
    ok($bar_clone ~~ Foo, '... smartmatch our $bar_clone to the Foo class');
    ok($bar_clone.isa(Foo), "... .isa(Foo)");
}

# Same, but with the "is Foo" declaration inlined
#?rakudo skip 'not parsing is inside class yet'
#?DOES 3
{
    class Baz { is Foo }
    ok(Baz ~~ Foo, '... smartmatch our Baz to the Foo class');
    my $baz = Baz.new();
    ok($baz ~~ Baz, '... smartmatch our $baz to the Baz class');
    ok($baz.isa(Baz), "... .isa(Baz)");
}
