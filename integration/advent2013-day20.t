use v6;
use Test;
plan 22;

{
    my $a = 42;
    is_deeply $a, 42, 'scalar assignment sanity';
    $a = Nil;
    is_deeply $a, Any, 'scalar reset sanity';
}

{
    my $a is default(42);
    is_deeply $a, 42, 'scalar default value';
    ok $a.defined, 'scalar with default - defined';
}

{
    my $a is default(42) = 69;
    is_deeply $a, 69, 'assigned scalar';
    $a = Nil;
    is_deeply $a, 42, 'assigned scalar reset';
}

{
    my Bool @b is default(True);
    is_deeply @b[1000], True, 'array default';
    @b[1000]=False;
    is_deeply @b[1000], False, 'array default';
}

throws_like { EVAL 'my Bool $a is default(42)' }, X::TypeCheck::Assignment;
lives_ok { EVAL 'my Bool $a is default(True)' }, 'eval type check';

{
    my @a is default(42);
    is_deeply @a[0], 42, 'array default has value';
    ok @a[0].defined, 'array default is defined';
    is_deeply @a[0]:exists, False, '...but does not exist';  
}

lives_ok { EVAL 'my $a is default(Int) = "foo"' }, "default doesn't set type";
throws_like { EVAL 'my Int $a = "foo"' }, X::TypeCheck::Assignment;

{
    my @a is default(42) = 69;
    @a[0]:delete;
    is_deeply @a[0], 42, 'deleted value';
    is_deeply @a[0]:exists, False, 'deleted !exists'; 
}

{
    my $a is default(Nil) = 42;
    is_deeply $a, 42, 'Nil as default';
    $a = Nil;
    is_deeply $a, Nil, 'Nil as default';
}

{
    my @a is default(42);
    is_deeply @a.VAR.default, 42, 'VAR introspection (default)';
    is_deeply $/.VAR.default, Nil, 'VAR introspection (default)';
    is_deeply $/.VAR.dynamic, True, 'VAR introspection (dynamic)';
}
