use v6;
use Test;

plan 13;

# L<S04/"The lift statement prefix">

# lift normal multi subs

{
    # the multi being lifted
    multi sub mt(Any $×) { 'Any' }

    multi sub lt1() { lift mt('String') }
    multi sub lt2() { lift mt(['Array']) }

    is lt1(), 'Any', 'lift basic sanity (String)';
    is lt2(), 'Any', 'lift basic sanity (Array)';

    # introduce a scope with another lexical multi 
    {
        my multi sub mt(Str $x) { 'Str' }
        is lt1(), 'Str', "lift picked up multis from caller's scope (Str)";
        is lt2(), 'Any', "lift still considers outer multis";
    }
}

# lift operators
{
    proto prefix:<``> (Any $x) { die "no multi" };
    multi sub lt3() { lift ``'String' };
    multi sub lt4() { lift ``4 };

    {
        my multi sub prefix:<``>(Str $x) { 'Str ``' };
        my multi sub prefix:<``>(Int $x) { 'Int ``' };
        is lt3(), 'Str ``',
           "lifted operator picked up multi from caller's scope (Str)";
        is lt4(), 'Int ``',
           "lifted operator picked up multi from caller's scope (Int)";
    }
    eval_dies_ok '``"foo"', "Dies when no callable multi is in scope";
}

# lift with user defined infix and prefix operators

{
    proto infix:<ceq>(Any $a, Any $b) is equiv(&infix:<eq>) {
        lift ~$a eq ~$b
    }
    multi infix:<ceq>(Str $a, Str $b) {$a eq $b}

    {
        my multi infix:<eq>(Str $a, Str $b) {
            $a.elems == $b.elems;
        }
        ok 'a' ceq 'b',     'infix:<ceq> picked up lifted infix:<eq> (+)';
        ok !('a' ceq 'aa'), 'infix:<ceq> picked up lifted infix:<eq> (-)';
    }

    {
        my multi sub prefix:<~>(Int $x where 0..4) {
            my @conf = <A B C D E>;
            @conf($x);
        }
        ok 'A' ceq 1,       'infix:<ceq> picked up lifted prefix:<~> (+)';
        ok !('A' ceq 2),    'infix:<ceq> picked up lifted prefix:<~> (-)';
    }

    # default operations: no user defined ~ and eq or ceq
    ok 'a' ceq 'a',     'basic operation (+)';
    ok !('a' ceq 'b'),  'basic operation (-)';
    # with coercion
    ok '1' ceq 1,       'basic operation with coercion (+)';
    ok !('1' ceq 2),    'basic operation with coercion (-)';
}

# vim: ft=perl6
