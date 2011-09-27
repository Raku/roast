use v6;

use Test;

plan 48;

=begin pod

Tests the given block, as defined in L<S04/"Switch statements">

=end pod

{
    # basic sanity
    my ($t, $f);

    try { given 1 { when 1 { $t = 1 } } };
    ok($t, "given when true ...");

    try { given 1 { when 2 { $f = 1 } } };;
    ok(!$f, "given when false");
};

{
    # simple case, with fall through
    # L<S04/Switch statements/If the smart match fails, control proceeds the
    # next statement>
    my ($two, $five, $int, $unreached);

    given 5 {
        when 2 { $two = 1 }
        when 5 { $five = 1; proceed }
        when Int { $int = 1 }
        when 5 { $unreached = 1 }
    }

    ok(!$two, "5 is not two");
    ok($five, "5 is five");
    ok($int, "short fell-through to next true when using 'proceed'");
    ok(!$unreached, "but didn't do so normally");
};

{
    my $foo;
    given "foo" {
        when "foo" {
            when /^f/ {
                $foo = 1
            }
        }
    }

    ok($foo, "foo was found in nested when");
};


# from apocalypse 4
#?rakudo skip 'parsefail on each(... ; ...)'
#?niecza skip 'each'
{
    # simple example L<S04/"Switch statements" /You don't have to use an explicit default/>
    for each(("T", "E", 5) ; (10, 11, 5)) -> $digit, $expected {
        my $result_a = do given $digit {
            when "T" { 10 }
            when "E" { 11 }
            $digit
        };

        my $result_b = do given $digit {
            when "T" { 10 }
            when "E" { 11 }
            default  { $digit }
        };

        is($result_a, $expected, "result of $digit using implicit default {} is $expected");
        is($result_b, $expected, "result of $digit using explicit default {} is $expected");
    }
}

{
    # interleaved code L<S04/"Switch statements" /which may or may not be a when statement/>
    my ($b_one, $b_two, $b_three, $panic);
    given 2 {
        $b_one = 1;
        when 1 { }
        $b_two = 1;
        when 2 { }
        $b_three = 1;
        default { }
        $panic = 1;
    }

    ok($b_one, "interleaved 1");
    ok($b_two, "interleaved 2 is the last one");
    ok(!$b_three, "inteleraved 3 not executed");
    ok(!$panic, 'never ever execute something after a default {}');
};

{
    # topic not given by 'given' L<S04/"Switch statements" /including a for loop/>
    my ($b_one, $b_two, $b_three,$panic) = (0,0,0,0);
    for <1 2 3> {
        when 1 {$b_one = 1}
        when 2 {$b_two = 1}
        when 3 {$b_three = 1}
        default {$panic =1}
    }
        ok($b_one, "first iteration");
        ok($b_two, "second iteration");
        ok($b_three, "third iteration");
        ok(!$panic,"should not fall into default in this case");
}

{
    my ($foo, $bar) = (1, 0);
    given 1 {
        when 1 { $foo = 2; proceed; $foo = 3; }
        when 2 { $foo = 4; }
        default { $bar = 1; }
        $foo = 5;
    };
    is($foo, 2, 'proceed aborts when block');
    ok($bar, 'proceed does not prevent default');
}

{
    my ($foo, $bar) = (1, 0);
    given 1 {
        when 1 { $foo = 2; succeed; $foo = 3; }
        when 2 { $foo = 4; }
        default { $bar = 1 }
        $foo = 5;
    };
    is($foo, 2, 'succeed aborts when');
    ok(!$bar, 'succeed prevents default');
}

{
    my ($foo, $bar, $baz, $bad) = (0, 0, -1, 0);
    my $quux = 0;
    for 0, 1, 2 {
        when 0 { $foo++; proceed }
        when 1 { $bar++; succeed }
        when 2 { $quux++; }
        default { $baz = $_ }
        $bad = 1;
    };
    is($foo, 1, 'first iteration');
    is($bar, 1, 'second iteration');
    is($baz, 0, 'proceed worked');
    is($quux, 1, "succeed didn't abort loop");
    ok(!$bad, "default didn't fall through");
}


# given returns the correct value:
{
     sub ret_test($arg) {
       given $arg {
         when "a" { "A" }
         when "b" { "B" }
       }
     }

    is( ret_test("a"), "A", "given returns the correct value (1)" ); 
    is( ret_test("b"), "B", "given returns the correct value (2)" ); 
}

# given/succeed returns the correct value:
{
     sub ret_test($arg) {
       given $arg {
         when "a" { succeed "A"; 'X'; }
         when "b" { succeed "B"; 'X'; }
       }
     }

    is( ret_test("a"), "A", "given returns the correct value (1)" ); 
    is( ret_test("b"), "B", "given returns the correct value (2)" ); 
}

# given/when and junctions
{
    my $any = 0;
    my $all = 0;
    my $one = 0;
    given 1 {
          when any(1 .. 3) { $any = 1; }
    }
    given 1 {
          when all(1)      { $all = 1; }
    }
    given 1 {
          when one(1)      { $one = 1; }          
    }
    is($any, 1, 'when any');
    is($all, 1, 'when all');
    is($one, 1, 'when one');
}

# given + objects
{
    class TestIt { method passit { 1; }; has %.testing is rw; };
    my $passed = 0;
    ok( eval('given TestIt.new { $_.passit; };'), '$_. method calls' );
    #?niecza skip 'System.IndexOutOfRangeException: Array index is out of range.'
    ok( eval('given TestIt.new { .passit; };'), '. method calls' );
    #?niecza skip 'System.IndexOutOfRangeException: Array index is out of range.'
    ok( eval('given TestIt.new { $_.testing<a> = 1; };'),'$_. attribute access' );
    #?niecza skip 'System.IndexOutOfRangeException: Array index is out of range.'
    ok( eval('given TestIt.new { .testing<a> = 1; };'),  '. attribute access' );
    my $t = TestIt.new;
    given $t { when TestIt { $passed = 1;} };
    is($passed, 1,'when Type {}');
{
    $passed = 0;
    given $t { when .isa(TestIt) { $passed = 1;}};
    is($passed, 1,'when .isa(Type) {}');
}
    $passed = 0;
    given $t { when TestIt { $passed = 1; }};
    is($passed, 1,'when Type {}');
}

{
    # given + true
    # L<S04/"Switch statements" /"is exactly equivalent to">
    my @input = (0, 1);
    my @got;

    for @input -> $x {
        given $x {
            when .so { push @got, "true" }
            default { push @got, "false" }
        }
    }

    is(@got.join(","), "false,true", 'given { when .so { } }');
}

# given + hash deref
{
    my %h;
    given %h { .{'key'} = 'value'; }
    ok(%h{'key'} eq 'value', 'given and hash deref using .{}');
    given %h { .<key> = "value"; }
    ok(%h{'key'} eq 'value', 'given and hash deref using .<>');
}

# given + 0-arg closure
{
    my $x = 0;
    given 41 {
        when { $_ == 49 } { diag "this really shouldn't happen"; $x = 49 }
        when { $_ == 41 } { $x++ }
    }
    ok $x, 'given tests 0-arg closures for truth';
}

# given + 1-arg closure
{
    my $x;
    given 41 {
        when -> $t { $t == 49 } { diag "this really shouldn't happen"; $x = 49 }
        when -> $t { $t == 41 } { $x++ }
    }
    ok $x, 'given tests 1-arg closures for truth';
}

# given + n>1-arg closure (should fail)
{
    dies_ok {
        given 41 {
            when -> $t, $r { $t == $r } { ... }
        }
    }, 'fail on arities > 1';
}

# given + 0-arg sub
{
    my $x = 41;
    sub always_true { Bool::True }
    given 1 {
        when &always_true { $x++ }
    }
    is $x, 42, 'given tests 0-arg subs for truth';
}

# given + 1-arg sub
{
    my $x = 41;
    sub maybe_true ($value) { $value eq "mytopic" }
    given "mytopic" {
        when &maybe_true { $x++ }
    }
    is $x, 42, 'given tests 1-arg subs for truth';
}


# vim: ft=perl6
