use v6;
use Test;

plan 10;

# L<S02/Names/Symbols in the current package>

{
    lives_ok { EVAL 'our sub eval_born { 5 }'},
      'can define a sub in eval';
    throws_like { EVAL 'eval_born()' },
      X::AdHoc,
      'call to eval-born sub outside eval dies';
    is &OUR::eval_born(), 5, 'call to eval-born our sub via OUR works';
}

# RT #63882
{
    my enum A <a b c>;
    is +c, 2, 'c is 2 from enum';
    lives_ok { EVAL 'our sub c { "sub c" }' },
      'can define my sub c in eval after c defined in enum';
    is +c, 2, 'c is still 2 from enum';
    #?rakudo skip 'OUR::subname() does not work'
    is OUR::c(), 'sub c', 'sub c called with OUR:: works';
}

# RT #69460
{
    our $rt69460 = 1;
    lives_ok { EVAL 'class RT69460 { $GLOBAL::rt69460++ }' },
      'can compile a class that modifies our variable';
    ok ::OUR::RT69460.new ~~ ::OUR::RT69460, 'can instantiate class that modifies our variable';
    is $rt69460, 2, 'class can modify our variable';
}

# vim: ft=perl6
