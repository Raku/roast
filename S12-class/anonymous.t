use v6;

use Test;

# L<S12/Classes/"Perl 6 supports multiple inheritance, anonymous classes">
plan 10;

# Create and instantiate empty class; check .WHAT works and stringifies to
# empty string.
my $c1 = class { };
my $t1 = $c1.new();
ok(defined($t1),     'instantiated the class');
ok($t1 ~~ $c1,       'isa check works');
is(~$c1.WHAT(), '',  '.WHAT stringifies to empty string');

# Anonymous classes with methods.
my $c2 = class { method foo { 42 }; method bar { 28 } };
my $t2 = $c2.new();
is($t2.foo, 42,      'can call methods on anonymous classes');
is($t2.bar, 28,      'can call methods on anonymous classes');

# Anonymous classes with attributes.
my $c3 = class { has $.x };
my $t3 = $c3.new(x => 42);
is($t3.x, 42,        'anonymous classes can have attributes');

{
    my $class;
    lives_ok { $class = class { method meth() { return 42 } }} ,
    "anonymous class creation";

    my $a;
    ok ($a = $class.new), "instantiation of anonymous class";
    #?rakudo skip '"No execption handler and no message"'
    is $a.meth, 42, "calling a method on an instance of an anonymous class (1)";

# And the same w/o using a $class variable:
    #?rakudo skip 'anonymous classes without temp variable'
    is (class { method meth() { return 42 } }).new.meth, 42,
    "calling a method on an instance of an anonymous class (2)";

}
