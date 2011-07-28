use v6;
use Test;

plan 10;

# L<S02/Names/Symbols in the current package>

{
    eval 'sub eval_born { 5 }';
    ok $! !~~ Exception, 'can define a sub in eval';
    dies_ok { eval_born() }, 'call to eval-born sub as multi dies';
    #?rakudo skip 'Null PMC access in invoke()'
    is OUR::eval_born(), 5, 'call to eval-born sub works';
}

# RT #63882
{
    enum A <a b c>;
    #?rakudo todo 'nom regression'
    is c, 2, 'c is 2 from enum';
    eval 'sub c { "sub c" }';
    ok  $!  !~~ Exception, 'can define sub c in eval after c defined in enum';
    #?rakudo todo 'nom regression'
    is c, 2, 'c is still 2 from enum';
    #?rakudo skip 'OUR::subname() does not work'
    is OUR::c(), 'sub c', 'sub c called with OUR:: works';
}

# RT #69460
{
    our $rt69460 = 1;
    #?rakudo todo 'RT 69460'
    eval_lives_ok 'class RT69460 { $rt69460++ }',
                  'can compile a class that modifies our variable';
    #?rakudo skip 'RT 69460'
    ok T.new ~~ RT69460, 'can instantiate class that modifies our variable';
    #?rakudo todo 'RT 69460'
    is $rt69460, 2, 'class can modify our variable';
}

# vim: ft=perl6
