use v6;
use Test;
plan 5;

# originally for RT #66588, which was closed
# RT #74414 is related, and works on moar, but
# likely not on jvm
#?rakudo.jvm skip 'Ambiguous dispatch for &uno_mas'
{
    my $ro_call = 0;
    my $rw_call = 0;
    multi sub uno_mas( Int $ro       ) { $ro_call++; return 1 + $ro }
    multi sub uno_mas( Int $rw is rw ) { $rw_call++; return ++$rw }

    is uno_mas(42), 43, 'multi works with constant';
    is $ro_call, 1, 'read-only multi was called';

    my $x = 99;
    #?niecza skip 'Ambiguous dispatch for &uno_mas'
    is uno_mas( $x ), 100, 'multi works with variable';
    #?niecza todo
    is $x, 100, 'variable was modified';
    #?niecza todo
    is $rw_call, 1, 'read-write multi was called';
}

# vim: ft=perl6
