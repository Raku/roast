use v6;
use Test;

BEGIN plan 13;

# L<S06/Stub declarations>

BEGIN lives-ok({sub thunder {...}}, 'sub foo {...} works');

BEGIN throws-like 'sub foo;', X::UnitScope::Invalid,
    'old Perl "sub foo;" syntax is dead';

{
    sub lightning {...}
    # Maybe should be warns_ok
    BEGIN throws-like 'lightning()', X::StubCode, 'executing stub subroutine dies';
    sub lightning {42}
    BEGIN is(lightning(), 42, 'redefining stub subroutine works without extra syntax');

    sub hail {???}
    # Should be warns_ok
    BEGIN lives-ok({hail()}, 'executing stub subroutine lives (should warn here)');
    sub hail {47}
    BEGIN is(hail(), 47, 'redefining stub subroutine works without extra syntax');

    sub wind {!!!}
    BEGIN throws-like 'wind()', X::StubCode, 'executing stub subroutine dies';
    sub wind {17}
    BEGIN is(wind(), 17, 'redefining stub subroutine works without extra syntax');

}

{
    throws-like 'sub hail {26}; sub hail {10}', X::Redeclaration,
        'redefining existing subroutine dies';
}

#?rakudo skip "supersede NYI"
{
    use MONKEY-TYPING;
    sub hail {26}
    supersede sub hail {8}
    is(hail(), 8, 'redefining non-stub subroutine with supersede');
}

lives-ok { sub {...} }, 'not execued stub code is fine';
dies-ok { (sub {...}).() ~ '' }, 'execued stub code goes BOOM when used';
dies-ok { use fatal; (sub { ... }).() }, 'exeucted stub code goes BOOM under fatal';

# vim: ft=perl6
