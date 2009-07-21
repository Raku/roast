use v6;
use Test;

plan 3;

# L<S02/Names/Symbols in the current package>

{
    eval 'sub eval_born { 5 }';
    ok $! !~~ Exception, 'can define a sub in eval';
    #?rakudo todo 'sub defined in eval treated the same as multi'
    dies_ok { eval_born() }, 'call to eval-born sub as multi dies';
    #?rakudo skip 'Null PMC access in invoke()'
    is OUR::eval_born(), 5, 'call to eval-born sub works';
}
