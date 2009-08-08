use v6;
use Test;

plan 7;

# L<S02/Names/Symbols in the current package>

{
    eval 'sub eval_born { 5 }';
    ok $! !~~ Exception, 'can define a sub in eval';
    #?rakudo todo 'sub defined in eval treated the same as multi'
    dies_ok { eval_born() }, 'call to eval-born sub as multi dies';
    #?rakudo skip 'Null PMC access in invoke()'
    is OUR::eval_born(), 5, 'call to eval-born sub works';
}

# RT #63882
{
    enum A <a b c>;
    is c, 2, 'c is 2 from enum';
    eval 'sub c { "sub c" }';
    ok  $!  !~~ Exception, 'can define sub c in eval after c defined in enum';
    #?rakudo todo 'sub in eval shadows enum'
    is c, 2, 'c is still 2 from enum';
    #?rakudo skip 'OUR::subname() does not work'
    is OUR::c(), 'sub c', 'sub c called with OUR:: works';
}

# vim: ft=perl6
