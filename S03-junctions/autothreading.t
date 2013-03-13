use v6;
use Test;

plan 89;

{
    # Solves the equation A + B = A * C for integers
    # by autothreading over all interesting values

    my $n = 0;
    sub is_it($a, $b, $c) {
        $n++;
        if ($a != $b && $b != $c && $a != $c &&
        $a * 10 + $c == $a + $b ) {
            return "$a + $b = $a$c";
        } else {
            return ();
        }
    }

    # note that since the junction is not evaluated in boolean context,
    # it's not collapsed, and the auto-threading may not abort prematurely
    # when a result is found.
    my Mu $answer = is_it(any(1..2), any(7..9), any(0..6));
    is($n, 42, "called lots of times :-)");
    ok( ?($answer eq "1 + 9 = 10"), "found right answer");
}

{
    # Checks auto-threading works on method calls too, and that we get the
    # right result.
    class Foo {
        has $.count = 0;
        method test($x) { $!count++; return $x }
    }

    my $x;
    my Mu $r;
    my Mu $ok;
    $x = Foo.new;
    $r = $x.test(1|2);
    is($x.count, 2, 'method called right number of times');
    $ok = $r.perl.subst(/\D/, '', :g) eq '12' | '21';
    ok(?$ok,        'right values passed to method');

    $x = Foo.new;
    $r = $x.test(1 & 2 | 3);
    is($x.count, 3, 'method called right number of times');
    $ok = $r.perl.subst(/\D/, '', :g) eq '123' | '213' | '312' | '321'; # e.g. & values together
    ok(?$ok,        'junction structure maintained');
}

{
    # Check auto-threding works right on multi-subs.
    my $calls_a = 0;
    my $calls_b = 0;
    my $calls_c = 0;
    my ($r, $ok);
    multi mstest(Int $x) { $calls_a++; return $x }
    multi mstest(Str $x, Str $y) { $calls_b++ }    #OK not used
    multi mstest(Str $x) { $calls_c++ }    #OK not used
    $r = mstest(1&2 | 3);
    is($calls_a, 3, 'correct multi-sub called right number of times');
    is($calls_b, 0, 'incorrect multi-sub not called');
    is($calls_c, 0, 'incorrect multi-sub not called');
    $ok = $r.perl.subst(/\D/, '', :g) eq '123' | '213' | '312' | '321'; # e.g. & values together
    ok(?$ok,        'junction structure maintained');

    $calls_a = 0;
    $calls_b = 0;
    $calls_c = 0;
    mstest("a" | "b", "c" & "d");
    is($calls_b, 4, 'correct multi-sub called right number of times');
    is($calls_a, 0, 'incorrect multi-sub not called');
    is($calls_c, 0, 'incorrect multi-sub not called');
    
    $calls_a = 0;
    $calls_b = 0;
    $calls_c = 0;
    mstest('a' | 1 & 'b');
    is($calls_a, 1, 'correct multi-sub called right number of times (junction of many types)');
    is($calls_c, 2, 'correct multi-sub called right number of times (junction of many types)');
    is($calls_b, 0, 'incorrect multi-sub not called');

    # Extra sanity, in case some multi-dispatch caching issues existed.
    $calls_a = 0;
    $calls_b = 0;
    $calls_c = 0;
    mstest('a' | 1 & 'b');
    is($calls_a, 1, 'correct multi-sub called again right number of times (junction of many types)');
    is($calls_c, 2, 'correct multi-sub called again right number of times (junction of many types)');
    is($calls_b, 0, 'incorrect multi-sub again not called');
    
    $calls_a = 0;
    $calls_b = 0;
    $calls_c = 0;
    mstest('a');
    is($calls_a, 0, 'non-junctional dispatch still works');
    is($calls_b, 0, 'non-junctional dispatch still works');
    is($calls_c, 1, 'non-junctional dispatch still works');
}

{
    # Check auto-threading with multi-methods. Basically a re-hash of the
    # above, but in a class.
    class MMTest {
        has $.calls_a = 0;
        has $.calls_b = 0;
        has $.calls_c = 0;
        multi method mmtest(Int $x) { $!calls_a++; return $x }
        multi method mmtest(Str $x, Str $y) { $!calls_b++ }    #OK not used
        multi method mmtest(Str $x) { $!calls_c++ }    #OK not used
    }
    my ($obj, $r, $ok);
    $obj = MMTest.new();
    $r = $obj.mmtest(1&2 | 3);
    is($obj.calls_a, 3, 'correct multi-method called right number of times');
    is($obj.calls_b, 0, 'incorrect multi-method not called');
    is($obj.calls_c, 0, 'incorrect multi-method not called');
    $ok = $r.perl.subst(/\D/, '', :g) eq '123' | '213' | '312' | '321'; # e.g. & values together
    ok(?$ok,            'junction structure maintained');

    $obj = MMTest.new();
    $obj.mmtest("a" | "b", "c" & "d");
    is($obj.calls_b, 4, 'correct multi-method called right number of times');
    is($obj.calls_a, 0, 'incorrect multi-method not called');
    is($obj.calls_c, 0, 'incorrect multi-method not called');
    
    $obj = MMTest.new();
    $obj.mmtest('a' | 1 & 'b');
    is($obj.calls_a, 1, 'correct multi-method called right number of times (junction of many types)');
    is($obj.calls_c, 2, 'correct multi-method called right number of times (junction of many types)');
    is($obj.calls_b, 0, 'incorrect multi-method not called');
}

{
    # Ensure named params in single dispatch auto-thread.
    my $count = 0;
    my @got;
    sub nptest($a, :$b, :$c) { $count++; @got.push($a ~ $b ~ $c) }
    my Mu $r = nptest(1, c => 4|5, b => 2|3);
    is($count, 4,      'auto-threaded over named parameters to call sub enough times');
    @got .= sort;
    is(@got.elems, 4,  'got array of right size to check what was called');
    is(@got[0], '124', 'called with correct parameters');
    is(@got[1], '125', 'called with correct parameters');
    is(@got[2], '134', 'called with correct parameters');
    is(@got[3], '135', 'called with correct parameters');
}

{
    # Ensure named params in multi dispatch auto-thread.
    my $count_a = 0;
    my $count_b = 0;
    my @got;
    multi npmstest(Int $a, :$b, :$c) { $count_a++; @got.push($a ~ $b ~ $c) }
    multi npmstest(Str $a, :$b, :$c) { $count_b++; @got.push($a ~ $b ~ $c) }
    my $r = npmstest(1&'a', c => 2|3, b => 1);
    is($count_a, 2,    'auto-threaded over named parameters to call multi-sub variant enough times');
    is($count_b, 2,    'auto-threaded over named parameters to call multi-sub variant enough times');
    @got .= sort;
    is(@got.elems, 4,  'got array of right size to check what was called');
    is(@got[0], '112', 'called with correct parameters');
    is(@got[1], '113', 'called with correct parameters');
    is(@got[2], 'a12', 'called with correct parameters');
    is(@got[3], 'a13', 'called with correct parameters');
}

{
    # Auto-threading over an invocant.
    our $cnt1 = 0;
    class JuncInvTest1 {
        method a { $cnt1++; }
        has $.n;
        method d { 2 * $.n }
    }
    our $cnt2 = 0;
    class JuncInvTest2 {
        method a { $cnt2++; }
        method b($x) { $cnt2++ }    #OK not used
    }

    my Mu $x = JuncInvTest1.new | JuncInvTest1.new | JuncInvTest2.new;
    $x.a;
    is $cnt1, 2, 'basic auto-threading over invocant works';
    is $cnt2, 1, 'basic auto-threading over invocant works';

    $cnt1 = $cnt2 = 0;
    $x = JuncInvTest1.new | JuncInvTest2.new & JuncInvTest2.new;
    $x.a;
    is $cnt1, 1, 'auto-threading over invocant of nested junctions works';
    is $cnt2, 2, 'auto-threading over invocant of nested junctions works';

    $x = JuncInvTest1.new(n => 1) | JuncInvTest1.new(n => 2) & JuncInvTest1.new(n => 4);
    my Mu $r = $x.d;
    my $ok = ?($r.perl.subst(/\D/, '', :g) eq '248' | '284' | '482' | '842');
    ok($ok, 'auto-threading over invocant produced correct junctional result');

    $cnt2 = 0;
    $x = JuncInvTest2.new | JuncInvTest2.new;
    $x.b('a' | 'b' | 'c');
    is $cnt2, 6, 'auto-threading over invocant and parameters works';
}

# test that various things autothread

{
    my Mu $j = [1, 2] | 5;

    ok ?( +$j == 5 ), 'prefix:<+> autothreads (1)';
    ok ?( +$j == 2 ), 'prefix:<+> autothreads (2)';
    ok !( +$j == 3 ), 'prefix:<+> autothreads (3)';
}

# this is nothing new, but it's such a cool example for 
# autothreading that I want it to be in the test suite nonetheless ;-)
{
    sub primetest(Int $n) {
        ?(none(2..$n) * any(2..$n) == $n);
    };

    #               2  3  4  5  6  7  8  9  10  11  12  13  14  15
    my @is_prime = (1, 1, 0, 1, 0, 1, 0, 0,  0,  1,  0,  1,  0,  0);

    for @is_prime.kv -> $idx, $ref {
        is +primetest($idx + 2), $ref, "primality test for { $idx + 2 } works";
    }
}


#?pugs skip 'autothreading over array indexing'
{
    my Mu $junc = 0|1|2;
    my @a = (0,1,2);
    my $bool = Bool::False;
    ok ?(@a[$junc] == $junc), 'can autothread over array indexes';
}

# Tests former autothreading junction example from Synopsis 09
{
    my $c = 0;

    is(substr("camel", 0, 2),  "ca", "substr()");

    $c = 0;
    sub my_substr ($str, $i, $j) {
        $c++;
        my @c = split "", $str;
        join("", @c[$i..($i+$j-1)]);
    }

    my $j = my_substr("camel", 0|1, 2&3);

    is($c, 4, "substr() called 4 times");
}

# test autothreading while passing arrays:
{
    sub my_elems(@a) {
        @a.elems;
    }
    ok !(my_elems([2, 3]|[4, 5, 6]) == 1),
       'autothreading over array parameters (0)';
    ok ?(my_elems([2, 3]|[4, 5, 6]) == 2),
       'autothreading over array parameters (1)';
    ok ?(my_elems([2, 3]|[4, 5, 6]) == 3),
       'autothreading over array parameters (2)';
    ok !(my_elems([2, 3]|[4, 5, 6]) == 4),
       'autothreading over array parameters (3)';
}

# L<S02/Undefined types/"default block parameter type">

# block parameters default to Mu, so test that they don't autothread:
{
    my $c = 0;
    for 1|2, 3|4, 5|6 -> $x {
        $c++;
    }
    is $c, 3, 'do not autothread over blocks by default';
}
#?niecza skip 'interferes hard with inlining'
{
    my $c = 0;
    for 1|2, 3|4, 5|6 -> Any $x {
        $c++;
    }
    is $c, 6, 'do autothread over blocks with explicit Any';
}

# used to be RT #75368
# L<S03/Junctive operators/Use of negative operators with junctions>
{
    my Mu $x = 'a' ne ('a'|'b'|'c');
    ok $x ~~ Bool, 'infix:<ne> collapses the junction (1)';
    ok $x !~~ Junction, 'infix:<ne> collapses the junction (2)';
    nok $x, '... and the result is False';

    my Mu $y = 'a' !eq ('a'|'b'|'c');
    ok $y ~~ Bool, 'infix:<!eq> collapses the junction (1)';
    ok $y !~~ Junction, 'infix:<!eq> collapses the junction (2)';
    nok $y, '... and the result is False';

    my Mu $z = any(1, 2, 3);
    ok  4 != $z, '!= autothreads like not == (1)';
    nok 3 != $z, '!= autothreads like not == (2)';
}

# RT #69863
# autothreading over named-only params
{
    sub foo(Int :$n) { $n }
    ok foo(n => 1|2) ~~ Junction, 'named-only params autothread correctly';
}

# test that junctions doen't flatten ranges
# RT #76422
{
    ok ((1..42) | (8..35)).max == 42, 'infix | does not flatten ranges';
}

# test that the order of junction autothreading is:
# the leftmost all or none junction (if any), then
# the leftmost one or any junction.

{
    sub tp($a, $b, $c) { "$a $b $c" };

    my Mu $res = tp("dog", 1|2, 10&20);
    # should turn into:
    #     all( tp("dog", 1|2, 10),
    #          tp("dog", 1|2, 20))
    #
    # into:
    #     all( any( tp("dog", 1, 10), tp("dog", 2, 10),
    #          any( tp("dog", 1, 20), tp("dog", 2, 20)))
    is $res.Str, q{all(any("dog 1 10", "dog 2 10"), any("dog 1 20", "dog 2 20"))}, "an & junction right of a | junction will be autothreaded first";

    $res = tp("foo"&"bar", 1|2, 0);
    # should turn into:
    #     all( tp("foo", 1|2, 0),
    #          tp("bar", 1|2, 0))
    #
    # into:
    #     all( any( tp("foo", 1, 0), tp("foo", 2, 0)),
    #          any( tp("bar", 1, 0), tp("bar", 2, 0)))
    is $res.Str, q{all(any("foo 1 0", "foo 2 0"), any("bar 1 0", "bar 2 0"))}, "an & junction left of a | junction will be autothreaded first";
}

# vim: ft=perl6
