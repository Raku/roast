use v6;

use Test;
# Test of PRE and POST traits
#
# L<S04/Closure traits/"assert precondition at every block ">
# L<S06/Subroutine traits/"Mark blocks that are to be unconditionally executed">
#
# TODO: 
#  * Multiple inheritance + PRE/POST blocks
#  * check that the POST block receives the return value as topic ($_)

plan 16;

my $foo = '
sub foo(Num $i) {
    PRE {
        $i < 5
    }
    return 1;
}
';

sub bar(int $i) {
    return 1;
    POST {
        $i < 5;
    }
}

ok eval($foo ~ 'foo(2);'), 'sub with PRE compiles and runs';
ok eval(bar(3)), 'sub with POST compiles';

try {
    eval($foo ~ 'foo(10)');
}

ok defined($!), 'Violated PRE fails OK';

try {
    bar(10);
}
ok defined($!), 'violated POST fails OK';

# multiple PREs und POSTs

my $baz = '
sub baz (Num $i) {
	PRE {
		$i > 0
	}
	PRE {
		$i < 23
	}
	return 1;
}
';
ok($baz ~ 'baz(2)', 'sub with two PREs compiles and runs');

eval( $baz ~ 'baz(-1)');
ok(defined($!), 'sub with two PREs fails when first is violated');

eval( $baz ~ 'baz(42)');
ok(defined($!), 'sub with two PREs fails when second is violated');

sub qox (Num $i) {
	return 1;
	POST {
		$i > 0
	}
	POST {
		$i < 42
	}
}

ok(qox(23), "sub with two POSTs compiles and runs");

try {
	qox(-1);
}

ok(defined($!), "sub with two POSTs fails if first POST is violated");

try {
	qox(123);
}

ok(defined($!), "sub with two POSTs fails if second POST is violated");

# inheritance

my $ih_pre = 
' class Foo {
    method test(Num $i) {
        PRE {
	    $i > 23
        }
		
        return 1;
    }
}

class Bar is Foo {
    method test(Num $i){
        PRE {
            $i < -23
        }
        return 1;
    }
}
my $foo = Bar.new; ';

ok(eval($ih_pre ~ '$foo.test(-42)'), "PRE in methods compiles and runs");
ok(eval($ih_pre ~ '$foo.test(42)'), "inherited PRE in compiles and runs");

try {
    eval($ih_pre ~ '$foo.test(0)');
}

ok(defined($!), "violated PRE in methods fails OK");


class Foo {
    method test(Num $i) {
        return 1;
        POST {
	    $i < 23
        }
    }
}

class Bar is Foo {
    method test(Num $i){
        return 1;
        POST {
            $i > -23
        }
    }
}
my $foo_post = Bar.new;

ok(eval('$foo_post.test(0)'), "Inherited POST compiles and runs");

try {
    $foo_post.test(42);
}
ok(defined($!), "Inherited POST fails ok");

try {
    $foo_post.test(-42);
}
ok(defined($!), "Own POST fails ok");
