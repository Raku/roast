use v6;

use Test;
# Test of PRE and POST traits
#
# L<S04/Closure traits/"assert precondition at every block ">
# L<S06/Subroutine traits/"Mark blocks that are to be unconditionally executed">
#
# TODO: 
#  * Multiple inheritance + PRE/POST blocks

plan 18;

sub foo(Num $i) {
    PRE {
        $i < 5
    }
    return 1;
}

sub bar(Int $i) {
    return 1;
    POST {
        $i < 5;
    }
}

lives_ok { foo(2) }, 'sub with PRE  compiles and runs';
lives_ok { bar(3) }, 'sub with POST compiles and runs';

dies_ok { foo(10) }, 'Violated PRE  throws (catchable) exception';
dies_ok { bar(10) }, 'Violated POST throws (catchable) exception';

# multiple PREs und POSTs

sub baz (Num $i) {
	PRE {
		$i > 0
	}
	PRE {
		$i < 23
	}
	return 1;
}
lives_ok { baz(2) }, 'sub with two PREs compiles and runs';

dies_ok  { baz(-1)}, 'sub with two PREs fails when first is violated';
dies_ok  { baz(42)}, 'sub with two PREs fails when second is violated');


sub qox (Num $i) {
	return 1;
	POST {
		$i > 0
	}
	POST {
		$i < 42
	}
}

lives_ok({ qox(23) }, "sub with two POSTs compiles and runs");
dies_ok( { qox(-1) }, "sub with two POSTs fails if first POST is violated");
dies_ok( { qox(123)}, "sub with two POSTs fails if second POST is violated");

# inheritance

class PRE_Parent {
    method test(Num $i) {
        PRE {
            $i < 23
        }
        return 1;
    }
}

class PRE_Child is PRE_Parent {
    method test(Num $i){
        PRE {
            $i > 0;
        }
        return 1;
    }
}

my $foo = PRE_Child.new;

lives_ok { $foo.test(5)    }, 'PRE in methods compiles and runs';
dies_ok  { $foo.test(-42)  }, 'PRE in child throws';
dies_ok  { $foo.test(78)   }, 'PRE in parent throws';


class POST_Parent {
    method test(Num $i) {
        return 1;
        POST {
            $i > 23
        }
    }
}

class POST_Child is POST_Parent {
    method test(Num $i){
        return 1;
        POST {
            $i < -23
        }
    }
}
my $mp = POST_Child.new;

lives_ok  { $mp.test(-42) }, "It's enough if we satisfy one of the POST blocks (Child)";
lives_ok  { $mp.test(42)  }, "It's enough if we satisfy one of the POST blocks (Parent)";
dies_ok   { $tmp.test(12) }, 'Violating poth POST blocks throws an error';

class Another {
    method test(Num $x) {
        return 3 * $x;
        POST {
            $_ > 4
        }
    }
}

my $pt = Another.new;
lives_ok { $pt.test(2) }, 'POST receives return value as $_ (succeess)';
dies_ok  { $pt.test(1) }, 'POST receives return value as $_ (failure)';
