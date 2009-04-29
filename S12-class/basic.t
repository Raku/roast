use v6;

use Test;

plan 31;

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

{
    my $foo_clone = $foo.clone();
    ok($foo_clone ~~ Foo, '... smartmatch our $foo_clone to the Foo class');
}

# Definedness of proto-objects and objects.
ok(!Foo.defined,    'proto-objects are undefined');
my Foo $ut1;
ok(!$ut1.defined,   'proto-objects are undefined');
ok(Foo.new.defined, 'instances of the object are defined');

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

# test that lcfirst class names and ucfirst method names are allowed

{
    class lowerCase {
        method UPPERcase {
            return 'works';
        }
    }
    is lowerCase.new.UPPERcase, 'works',
       'type distinguishing is not done by case of first letter';
}

eval_dies_ok 'my $x; $x ~~ NonExistingClassName',
             'die on non-existing class names';

# you can declare classes over vivified namespaces, but not over other classes

class One::Two::Three { }  # auto-vivifies package One::Two
class One::Two { }
ok(One::Two.new, 'created One::Two after One::Two::Three');
eval_dies_ok 'class One::Two { }', 'cannot redeclare an existing class';
eval_lives_ok q[BEGIN {class Level1::Level2::Level3 {};}; class Level1::Level2 {};], 'RT#62898';

#?rakudo 2 todo 'RT 61354'
{
eval_lives_ok 'class A61354 { eval q/method x { "OH HAI" }/ }',
    'define method with eval in class lives';
# switch comment lines below to fudge success
# is eval('class A61354_1 { method x { "OH HAI" } }; A61354_1.x'),
is  eval('class A61354_1 { eval q/method x { "OH HAI" }/ }; A61354_1.x'),
    'OH HAI',
    'define method with eval in class';
}

