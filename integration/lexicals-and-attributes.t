use v6;
use Test;

plan 8;

# this was an issue with rakudo that some some assignment
# to attributes worked more like binding:
# RT #58818

class Foo {
    has $.a is rw;
    has $.b is rw;
    method clone_Foo {
        my $newval = self.b;
        return self.new(a => self.a, b => $newval);
    }
};

my $first = Foo.new(a => 1, b => 2);
is $first.a, 1, 'Initialization worked (1)';
is $first.b, 2, 'Initialization worked (2)';

my $second = $first.clone_Foo;
is $second.a, 1, 'Initialization of clone worked (1)';
is $second.b, 2, 'Initialization of clone worked (2)';

$second.a = 4;
$second.b = 8;

is $second.a, 4, 'assignment to attributes in clone worked (1)';
is $second.b, 8, 'assignment to attributes in clone worked (2)';

is $first.a, 1, 'assignment to clone left original copy unchanged (1)';
is $first.b, 2, 'assignment to clone left original copy unchanged (2)';

# vim: ft=perl6
