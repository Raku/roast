use v6;

use Test;

plan 2;

# The difference between test1 and test2 is that "my $var = Bar.new"
# is basically "my Any $var = Bar.new", so the Scalar container knows no
# constraint, and will not attempt to do any validation.
# "my Bar $var .= new" on the other hand, is really "my Bar $var = $var.new",
# so Bar acts both as the initial value of $var, and as the constraint that
# the variable($var) Scalar object holds on.

class Bar {
	method value { "1" }
}

class Foo {
	method test1 {
		my $var = Bar.new;
		return $var.value;
	}
	method test2 {
		my Bar $var .= new;
		return $var.value;
	}
}

my Foo $baz .= new;
lives_ok { $baz.test1; $baz.test1 },
"Multiple method calls can be made in the same instance, to the same method. (1)";
my Foo $bar .= new;
lives_ok { $bar.test2; $bar.test2 },
"Multiple method calls can be made in the same instance, to the same method. (2)";

# vim: ft=perl6
