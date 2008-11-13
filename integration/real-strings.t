use v6;
use Test;
plan 3;

# Rakudo had a regression that
# string returned from regexes were Parrot strings, not Perl 6 strings.
# Basic stuff like interpolation and .uc, .lc still worked, but other things
# did not. We test it here by calling .trans on the string, which dies
# because parrot's .trans has a different calling syntax

{
    my $x = 'a';
    is $x.trans(['a'] => ['b']), 'b', 
       'basic sanity: .trans works with native Perl 6 strings';
}

{
    my $x = 'abc'.split(m/b/).[0];
    lives_ok {$x.trans(['a'] => ['b']) }, 
       'Still works with strings returned from split() (lives)';
    is $x.trans(['a'] => ['b']), 'b',
       'Still works with strings returned from split() (result)';
}




# vim: ft=perl6
