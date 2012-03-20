use v6;

use Test;
# Test of PRE and POST traits
#
# L<S04/Phasers/"assert precondition at every block ">
# L<S06/Subroutine traits/PRE/POST>

plan 22;

sub foo(Int $i) {
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

#?pugs todo
dies_ok { foo(10) }, 'Violated PRE  throws (catchable) exception';
dies_ok { bar(10) }, 'Violated POST throws (catchable) exception';

# multiple PREs und POSTs

sub baz (Int $i) {
	PRE {
		$i > 0
	}
	PRE {
		$i < 23
	}
	return 1;
}
lives_ok { baz(2) }, 'sub with two PREs compiles and runs';

#?pugs todo
dies_ok  { baz(-1)}, 'sub with two PREs fails when first is violated';
#?pugs todo
dies_ok  { baz(42)}, 'sub with two PREs fails when second is violated';


sub qox (Int $i) {
	return 1;
	POST {
		$i > 0
	}
	POST {
		$i < 42
	}
}

lives_ok({ qox(23) }, "sub with two POSTs compiles and runs");
#?pugs todo
dies_ok( { qox(-1) }, "sub with two POSTs fails if first POST is violated");
dies_ok( { qox(123)}, "sub with two POSTs fails if second POST is violated");


class Another {
    method test(Int $x) {
        return 3 * $x;
        POST {
            $_ > 4
        }
    }
}

my $pt = Another.new;
#?pugs todo
lives_ok { $pt.test(2) }, 'POST receives return value as $_ (succeess)';
dies_ok  { $pt.test(1) }, 'POST receives return value as $_ (failure)';

{
    my $str;
    {
        PRE  { $str ~= '('; 1 }
        POST { $str ~= ')'; 1 }
        $str ~= 'x';
    }
    #?pugs todo
    is $str, '(x)', 'PRE and POST run on ordinary blocks';
}

{
    my $str;
    {
        POST  { $str ~= ')'; 1 }
        LEAVE { $str ~= ']' }
        ENTER { $str ~= '[' }
        PRE   { $str ~= '('; 1 }
        $str ~= 'x';
    }
    #?pugs todo
    is $str, '([x])', 'PRE/POST run outside ENTER/LEAVE';
}

{
    my $str;
    try {
        {
            PRE     { $str ~= '('; 0 }
            PRE     { $str ~= '*'; 1 }
            ENTER   { $str ~= '[' }
            $str ~= 'x';
            LEAVE   { $str ~= ']' }
            POST    { $str ~= ')'; 1 }
        }
    }
    #?pugs todo
    is $str, '(', 'failing PRE runs nothing else';
}

#?niecza todo 'I think POST runs LIFO by spec?'
{
    my $str;
    try {
        {
            POST  { $str ~= 'z'; 1 }
            POST  { $str ~= 'x'; 0 }
            LEAVE { $str ~= 'y' }
        }
    }
    #?pugs todo
    is $str, 'yx', 'failing POST runs LEAVE but not more POSTs';
}

#?rakudo 3 todo 'POST and exceptions'
#?niecza skip 'unspecced'
{
    my $str;
    try {
        POST { $str ~= $! // '<undef>'; 1 }
        die 'foo';
    }
    #?pugs todo
    ok $str ~~ /foo/, 'POST runs on exception, with correct $!';
}

#?niecza skip 'unspecced'
{
    my $str;
    try {
        POST { $str ~= (defined $! ?? 'yes' !! 'no'); 1 }
        try { die 'foo' }
        $str ~= (defined $! ?? 'aye' !! 'nay');
    }
    #?pugs todo
    is $str, 'ayeno', 'POST has undefined $! on no exception';
}

#?niecza skip 'unspecced'
{
    try {
        POST { 0 }
        die 'foo';
    }
    #?pugs todo
    ok $! ~~ /foo/, 'failing POST on exception doesn\'t replace $!';
    # XXX
    # is $!.pending.[-1], 'a POST exception', 'does push onto $!.pending';
}

{
    my sub blockless($x) {
        PRE $x >= 0;
        POST $_ == 4;
        return $x;
    }
    lives_ok { blockless(4) }, 'blockless PRE/POST (+)';
    dies_ok  { blockless -4 }, 'blockless PRE/POST (-, 1)';
    dies_ok  { blockless 14 }, 'blockless PRE/POST (-, 2)';
}

# vim: ft=perl6
