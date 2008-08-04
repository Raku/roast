use v6;
use Test;

plan 30;

#L<S04/The Relationship of Blocks and Declarations/"declarations, all
# lexically scoped declarations are visible"> 
{

    #?rakudo todo 'lexicals bug'
    eval_dies_ok('$x; my $x = 42', 'my() variable not yet visible prior to declartation');
    is(eval('my $x = 42; $x'), 42, 'my() variable is visible now (2)');
}


{
    my $ret = 42;
    eval_dies_ok '$ret = $x ~ my $x;', 'my() variable not yet visible (1)';
    is $ret, 42,                       'my() variable not yet visible (2)';
}

#?rakudo todo 'scoping bug'
{
    my $ret = 42;
    lives_ok { $ret = my($x) ~ $x }, 'my() variable is visible (1)';
    is $ret, "",                     'my() variable is visible (2)';
}

#?rakudo skip 'pointy subs'
{
  my $was_in_sub;
  my &foo := -> $arg { $was_in_sub = $arg };
  foo(42);
  is $was_in_sub, 42, 'calling a lexically defined my()-code var worked';
}

eval_dies_ok 'foo(42)', 'my &foo is lexically scoped';

#?rakudo todo 'do { } and lexicals'
{
  is(do{my $a = 3; $a}, 3, 'do{my $a = 3; $a} works');
  is(do{1; my $a = 3; $a}, 3, 'do{1; my $a = 3; $a} works');
}

eval_lives_ok 'my $x = my $y = 0;', '"my $x = my $y = 0" parses';

{
    my $test = "value should still be set for arg, even if there's a later my";
    sub foo (*%p) {
        is(%p<a>, 'b', $test);
        my %p;
    }
    foo(a => 'b');
}

my $a = 1;
ok($a, '$a is available in this scope');

if (1) { # create a new lexical scope
    ok($a, '$a is available in this scope');
    my $b = 1;
    ok($b, '$b is available in this scope');
}
eval_dies_ok '$b', '$b is not available in this scope';

# changing a lexical within a block retains the changed value
my $c = 1;
if (1) { # create a new lexical scope
    is($c, 1, '$c is still the same outer value');
    $c = 2;
}
is($c, 2, '$c is available, and the outer value has been changed');

# L<S04/The Relationship of Blocks and Declarations/prior to the first declaration>

my $d = 1;
{ # create a new lexical scope
    is($d, 1, '$d is still the outer $d');
    { # create another new lexical scope
        my $d = 2;
        is($d, 2, '$d is now the lexical (inner) $d');    
    }
}
is($d, 1, '$d has not changed');

# eval() introduces new lexical scope
is( eval('
my $d = 1;
{ 
    my $d = 3 
}
$d;
'), 1, '$d is available, and the outer value has not changed' );

#?rakudo skip 'Closures, undef++'
{
    # check closures with functions
    my $func;
    my $func2;
    if (1) { # create a new lexical scope
        my $e = 0;
        $func = sub { $e++ }; # one to inc
        $func2 = sub { $e };  # one to access it
    }

    eval_dies_ok '$e', '$e is not available in this scope';
    is($func2(), 0, '$func2() just returns the $e lexical which is held by the closure');
    $func();
    is($func2(), 1, '$func() increments the $e lexical which is held by the closure');
    $func();
    is($func2(), 2, '... and one more time just to be sure');
}

# check my as simultaneous lvalue and rvalue

#?rakudo 4 skip 'my $var as lvalue and rvalue'
is(eval('my $e1 = my $e2 = 42'), 42, 'can parse squinting my value');
is(eval('my $e1 = my $e2 = 42; $e1'), 42, 'can capture squinting my value');
is(eval('my $e1 = my $e2 = 42; $e2'), 42, 'can set squinting my variable');
is(eval('my $x = 1, my $y = 2; $y'), 2, 'precedence of my wrt = and ,');


# vim: ft=perl6
