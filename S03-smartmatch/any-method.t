use v6;
use Test;
plan 4;

{
    nok 'ab' ~~ .uc, 'smart-match happens after method calls on $_ 1';
     ok 'AA' ~~ .uc, 'smart-match happens after method calls on $_ 2';
}

{
    nok 'ab' ~~ .substr(1), 'method call with args 1';
     ok 'ab' ~~ .substr(0), 'method call with args 2';
}

done;

# vim: ft=perl6
