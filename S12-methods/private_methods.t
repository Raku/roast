use v6;
use Test;

plan 3;

# L<S12/Methods/"Private methods are declared using my">

class A {
    my method !private {
        12;
    }
    method public {
        self!private
    }
}

is A.new().public, 12, 'Can call private method from within the class';

# L<S12/Roles/"same, but &foo is aliased to &!foo">

# S12 says that 'my method foo' is the same as 'my method !foo', but
# also installs the &foo alias for &!foo
# but it's only stated for roles. Is that true for classes as well?


class B {
    my method private {
        24;
    }
    method public1 {
        self!private();
    }
    method public2 {
        self.private();
    }
}

my $b = B.new();

is $b.public1, 24, '"my method private" can be called as self!private';
is $b.public2, 24, '"my method private" can be called as self.private';

# vim: syn=perl6
