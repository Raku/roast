use v6;

use Test;

plan 5;

class Parent {
    method me {
        self;
    }
}

class Child is Parent {
    method myself {
        self.Parent::me();
    }
}

role R {
    method me {
        self;
    }
}

class Consumer does R {
    method myself {
        self.R::me();
    }
}

my $child = Child.new;
is( $child.myself, $child, 'Qualified method calls should use the original self' );

my $consumer = Consumer.new;
is( $consumer.myself, $consumer, 'Qualified method calls should use the original self' );

is (-42).::Int::abs, 42, 'qualified method call with starting colons';
throws-like { (42).::Str::abs }, X::Method::InvalidQualifier, 'InvalidQualifier thrown with starting colons';

# RT #130181
{
    throws-like { EVAL '.::' }, X::Syntax::Malformed, 'empty name in qualified method call';
}

# vim: ft=perl6
