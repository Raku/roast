use v6;
use Test;

plan 9;

# L<S12/Methods/"Private methods are declared using my">

class A {
    my method private {
        12;
    }
    method public {
        self!private
    }
}

is A.new().public, 12, 'Can call private method from within the class';

# indirect call syntax for public and private methods

class Indir {
    method a {
        'aa';
    }
    my method b {
        'bb';
    }
    method b_acc1 {
        self!"b";
    }
    method b_acc2 {
        self!'b';
    }
}

my $o = Indir.new();

is $o."a",    "aa", 'indirect call to public method (double quotes)';
is $o.'a',    "aa", 'indirect call to public method (single quotes)';
is $o.b_acc1, 'bb', 'indirect call to private method (double quotes)';
is $o.b_acc2, 'bb', 'indirect call to private method (single quotes)';
dies_ok {$o."b" },  'can not call private method via quotes from outside';

# L<S12/Roles/"same, but &foo is aliased to &!foo">

# S12 says that 'my method foo' is the same as 'my method !foo', but
# also installs the &foo alias for &!foo
# but it's only stated for roles. Is that true for classes as well?

{
    role C {
        my method role_shared {
            18;
        }
        my method !role_private {
            36;
        }
    }

    class B does C {
        my method private {
            24;
        }
        method public1 {
            self!private();
        }
        method public2 {
            self!role_shared();
        }
        method public3 {
            self!role_private();
        }
    }

    my $b = B.new();

    is $b.public1, 24, '"my method private" can be called as self!private';
    is $b.public2, 18, 'can call role shared private methods';
    dies_ok { $b.public3() }, 'can not call role privaate methods';
}

# vim: syn=perl6
