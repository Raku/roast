use v6;
use Test;
plan *;

{
    my $ro_call = 0;
    my $rw_call = 0;
    sub uno_mas( Int $ro       ) { $ro_call++; return 1 + $ro }
    sub uno_mas( Int $rw is rw ) { $rw_call++; return ++$rw }
    
    is uno_mas(42), 43, 'multi works with constant';
    is $ro_call, 1, 'read-only multi was called';

    my $x = 99;
    is uno_mas( $x ), 100, 'multi works with variable';
    #?rakudo 2 todo 'RT 66588: multi dispatch by trait'
    is $x, 100, 'variable was modified';
    is $rw_call, 1, 'read-write multi was called';
}

done_testing;

# vim: ft=perl6
