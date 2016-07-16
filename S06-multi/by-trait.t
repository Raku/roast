use v6;
use Test;
plan 13;

# originally for RT #66588, which was closed
# RT #74414 is related, and works on moar, but
# likely not on jvm
{
    my $ro_call     = 0;
    my $rw_call     = 0;
    my $primrw_call = 0;
    multi sub uno_mas( Int $ro       ) { $ro_call++; return 1 + $ro }
    multi sub uno_mas( int $rw is rw ) { $primrw_call++; return $rw * 2 }
    multi sub uno_mas( Int $rw is rw ) { $rw_call++; return ++$rw }

    #?rakudo.jvm skip 'Ambiguous dispatch for &uno_mas'
    is uno_mas(42), 43, 'multi works with constant';
    #?rakudo.jvm todo 'fails due to above skipped test'
    is $ro_call, 1, 'read-only multi was called';

    my $x = 99;
    #?niecza skip 'Ambiguous dispatch for &uno_mas'
    is uno_mas( $x ), 100, 'multi works with variable';
    #?niecza todo
    is $x, 100, 'variable was modified';
    #?niecza todo
    is $rw_call, 1, 'read-write multi was called';
    #?rakudo.jvm todo 'fails due to above skipped test'
    is $ro_call, 1, 'read-only multi was not called';
    my int $y = 50;
    is uno_mas( $y ), 100, 'multi works with primitive';
    is $rw_call, 1, 'read-write multi was not called';
    #?rakudo.jvm todo 'fails due to above skipped test'
    is $ro_call, 1, 'read-only multi was not called';
    is $primrw_call, 1, 'native rw multi was called';
}

{
    # Makes sure dynamic optimization copes with the rw vs. ro distinction
    # also (early patches to the MoarVM multi cache didn't handle this, so
    # we could end up inlining the wrong thing; other backends are likely
    # to intensively optimize multi calls too, and could hit the same kind
    # of trap).
    multi foo($x is rw) { 1 };
    multi foo($x) { 2 };
    foo [];
    my $got;
    for ^500 { $got = foo $ = []; }
    #?rakudo.jvm todo 'expected 1, got 2'
    is $got, 1, 'Optimization respects is rw';
}

{
    multi x(int $x is rw) { 1 }
    multi x(Int $x) { 2 }
    is x(my int $x = 42), 1, 'rw native container hits correct candidate';
    is x(1), 2, 'non-rw literal does not reach is rw candidate';
}

# vim: ft=perl6
