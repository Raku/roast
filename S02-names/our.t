use v6;
use Test;

plan 10;

# L<S02/Names/Symbols in the current package>

{
    eval_lives_ok 'our sub eval_born { 5 }', 'can define a sub in eval';
    eval_dies_ok 'eval_born()', 'call to eval-born sub outside eval dies';
    #?rakudo skip 'Null PMC access in invoke()'
    is OUR::eval_born(), 5, 'call to eval-born our sub via OUR works';
}

# RT #63882
{
    my enum A <a b c>;
    is +c, 2, 'c is 2 from enum';
    eval_lives_ok 'our sub c { "sub c" }',
        'can define my sub c in eval after c defined in enum';
    is +c, 2, 'c is still 2 from enum';
    #?rakudo skip 'OUR::subname() does not work'
    is OUR::c(), 'sub c', 'sub c called with OUR:: works';
}

# RT #69460
{
    our $rt69460 = 1;
    eval_lives_ok 'class RT69460 { $GLOBAL::rt69460++ }',
                  'can compile a class that modifies our variable';
    #?rakudo skip 'RT 69460'
    ok ::OUR::RT69460.new ~~ ::OUR::RT69460, 'can instantiate class that modifies our variable';
    #?rakudo todo 'RT 69460'
    is $rt69460, 2, 'class can modify our variable';
}

# vim: ft=perl6
