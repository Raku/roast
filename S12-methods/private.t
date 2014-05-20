use v6;
use Test;

plan 12;

# L<S12/Private methods/"Private methods are declared using">

class A {
    method !private {
        12;
    }
    method public {
        self!private
    }
}

is A.new().public, 12, 'Can call private method from within the class';
dies_ok {EVAL('A.new!private')}, 'Can not call private method from outside';

# indirect call syntax for public and private methods

class Indir {
    method a {
        'aa';
    }
    method !b {
        'bb';
    }
    method b_acc1 {
        self!"b"();   #OK use of quotes
    }
    method b_acc2 {
        self!'b'();   #OK use of quotes
    }
}

my $o = Indir.new();

is $o."a"(),    "aa", 'indirect call to public method (double quotes)';   #OK use of quotes
is $o.'a'(),    "aa", 'indirect call to public method (single quotes)';   #OK use of quotes
is $o.b_acc1, 'bb', 'indirect call to private method (double quotes)';
is $o.b_acc2, 'bb', 'indirect call to private method (single quotes)';
dies_ok {$o."b"() },  'can not call private method via quotes from outside';   #OK use of quotes

# L<S14/Roles/"same, but &foo is aliased to &!foo">

# method !foo in a role gets composed in as a private method and is callable
# as one. XXX Role Private Methods? my method !foo() { ... } different?

{
    role C {
        method !role_shared {
            18;
        }
        my method !role_private {
            36;
        }
    }

    class B does C {
        method !private {
            24;
        }
        method public1 {
            self!private();
        }
        method public2 {
            self!role_shared();
        }
        method public3 {
            EVAL 'self!role_private();';
        }
    }

    my $b = B.new();

    is $b.public1, 24, '"my method private" can be called as self!private';
    is $b.public2, 18, 'can call role shared private methods';
    #?niecza todo 'role private methods - spec?'
    throws_like { $b.public3() }, X::Method::NotFound, 
        typename => { m/'B'/ }, method => { m/'role_private'/ }; #'can not call role private methods scoped with my';
}

# RT #101964
{
    class RT101964 {
        has @!c;
        method foo { self!bar(@!c) }
        method !bar(@r) {  #OK not used
            'OH HAI';
        }
    }
    is RT101964.new.foo, 'OH HAI', 'can pass private array attribute to private method param';
}

#RT #115308
#?niecza skip "throws_like NYI"
#?DOES 2
throws_like '$_!X::a', X::Method::Private::Permission;

done;

# vim: syn=perl6
