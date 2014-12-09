use v6;

use Test;

plan 9;

# L<S06/Signatures>

# Nil is treated as definite value in return specifications
#?rakudo skip 'definite values as return specifications dont parse yet'
{
    my sub return-nil(--> Nil) {
        1
    }

    ok return-nil() =:= Nil, 'A function with a definite return value should ignore the result of its last statement';
}

#?rakudo skip 'definite values as return specifications dont parse yet'
{
    my sub return-two(--> 2) {
        3
    }

    is return-two(), 2, 'A function with a non-Nil definite return value should ignore the result of its last statement';
}

#?rakudo skip 'definite values as return specifications dont parse yet'
{
    my $code = q:to/PERL/;
    my sub return-nil(--> Nil) {
        return 1
    }
PERL
    eval_dies_ok($code, 'A function with a definite return value may not use return with a value')
}

#?rakudo skip 'definite values as return specifications dont parse yet'
{
    my $code = q:to/PERL/;
    my sub return-failure(--> Nil) {
        return Failure.new(X::Adhoc.new(4))
    }
PERL
    eval_dies_ok($code, 'A function with a definite return value may not use return with a value, even a Failure')
}

#?rakudo skip 'definite values as return specifications dont parse yet'
{
    my sub fail-five(--> 5) {
        fail 5
    }

    my $failure = fail-five();
    isnt $failure, 5, 'Failures bypass the return value of function with a definite return value in the signature';
    ok $failure === Failure, 'Failures bypass the return value of function with a definite return value in the signature';
}

#?rakudo skip 'definite values as return specifications dont parse yet'
{
    my sub return-six(--> 6) {
        return
    }

    is return-six(), 6, 'Value-less returns are allowed in functions with definite return value in their signatures';
}


#?rakudo skip 'definite values as return specifications dont parse yet'
{
    my sub return-seven(--> $result) {
        $result = 7;
        8
    }

    is return-seven(), 7, 'Functions using a mutable value as their return value use that value as their return value';
}


#?rakudo skip 'definite values as return specifications dont parse yet'
{
    my $result = 9;

    my sub return-eight(--> $result) {
        $result = 8;
        19
    }

    is eight(), 8, 'Variables used as return specifications *always* shadow existing variables with the same name';
}

# returns vs -->
# indefinite vs immutable vs mutable
# what are some wacky immutable values that we could return? (*)
# mutable: existing variable (can you put a type on this?)
# mutable: new variable (can you put a type on this?)
# mutable: default value (pre-existing vs new)
# mutable: non variable (think rw function or something)
# what other things can we do to variables/parameters that we could do to the return variable?
# anonymous subs, nested subs
# if !indefinite, final statement should be in sink (and not item/list) context
# S26 for return params...
# coerce Bool from Junction in return value?
# use of CALLER::/OUTER:: as return value (FROGGS' example)
# Should sub return-two(--> 2) { 3 } emit an error/warning?
# traits - how to distinguish a trait on the return value vs on the sub?
