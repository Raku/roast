use v6;
use Test;

plan 5;

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

# vim: ft=perl6
