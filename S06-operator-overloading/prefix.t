use v6;
use Test;

plan 9;

{
    sub prefix:<X> ($thing) { return "ROUGHLY$thing"; };

    is(X "fish", "ROUGHLYfish",
       'prefix operator overloading for new operator');
}

{
    sub prefix:<±> ($thing) { return "AROUND$thing"; };
    is ± "fish", "AROUNDfish", 'prefix operator overloading for new operator (unicode, latin-1 range)';
    sub prefix:<(+-)> ($thing) { return "ABOUT$thing"; };
    is EVAL(q[ (+-) "fish" ]), "ABOUTfish", 'prefix operator overloading for new operator (nasty)';
}

{
    sub prefix:<∔> ($thing) { return "AROUND$thing"; };
    is ∔ "fish", "AROUNDfish", 'prefix operator overloading for new operator (unicode, U+2214 DOT PLUS)';
}

#?rakudo skip 'prefix:[] form NYI RT #124974'
{
    sub prefix:['Z'] ($thing) { return "ROUGHLY$thing"; };

    is(Z "fish", "ROUGHLYfish",
       'prefix operator overloading for new operator Z');
}

#?rakudo skip 'prefix:[] form NYI RT #124975'
{
    sub prefix:["∓"] ($thing) { return "AROUND$thing"; };
    is ∓ "fish", "AROUNDfish", 'prefix operator overloading for new operator (unicode, U+2213 MINUS-OR-PLUS SIGN)';
}

#?rakudo skip 'prefix:[] form NYI RT #124976'
{
    sub prefix:["\x[2213]"] ($thing) { return "AROUND$thing"; };
    is ∓ "fish", "AROUNDfish", 'prefix operator overloading for new operator (unicode, \x[2213] MINUS-OR-PLUS SIGN)';
}

#?rakudo skip 'prefix:[] form NYI RT #124977'
{
    sub prefix:["\c[MINUS-OR-PLUS SIGN]"] ($thing) { return "AROUND$thing"; };
    is ∓ "fish", "AROUNDfish", 'prefix operator overloading for new operator (unicode, \c[MINUS-OR-PLUS SIGN])';
}

{
    my sub prefix:<->($thing) { return "CROSS$thing"; };
    is(-"fish", "CROSSfish",
        'prefix operator overloading for existing operator (but only lexically so we don\'t mess up runtime internals (needed at least for PIL2JS, probably for PIL-Run, too)');
}
