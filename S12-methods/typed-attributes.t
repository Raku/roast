use v6;

use Test;

plan 7;

class Bar {
    method baz returns Str { 'Baz' }
}

class Foo {
    has Bar $.bar;
    
    method call_bar {
        return $.bar.baz();
    }

    method call_bar_indirectly {
        my $bar = $.bar;
        return $bar.baz();
    }
}

my $bar = Bar.new();
isa-ok($bar, Bar);

my $foo = Foo.new(:bar($bar));
isa-ok($foo, Foo);

# sanity test
is($bar.baz(), 'Baz', '... sanity test, this works as we expect');

my $val;
lives-ok { $val = $foo.call_bar() }, '... this should work';
is $val, 'Baz', '... this should be "Baz"';

my $val2;
lives-ok { $val2 = $foo.call_bar_indirectly() }, '... this should work';
is($val2, 'Baz', '... this should be "Baz"');

# vim: ft=perl6
