use v6;
use Test;

plan 10;

# L<S06/Stub declarations>

lives-ok({sub thunder {...}}, 'sub foo {...} works');

throws-like 'sub foo;', X::UnitScope::Invalid,
    'old Perl 5 "sub foo;" syntax is dead';

{
    sub lightning {...}
    # Maybe should be warns_ok
    throws-like 'lightning()', X::StubCode, 'executing stub subroutine dies';
    sub lightning {42}
    is(lightning(), 42, 'redefining stub subroutine works without extra syntax');

    sub hail {???}
    # Should be warns_ok
    lives-ok({hail()}, 'executing stub subroutine lives (should warn here)');
    sub hail {47}
    is(hail(), 47, 'redefining stub subroutine works without extra syntax');

    sub wind {!!!}
    throws-like 'wind()', X::StubCode, 'executing stub subroutine dies';
    sub wind {17}
    is(wind(), 17, 'redefining stub subroutine works without extra syntax');

}

{
    use MONKEY-TYPING;
    sub hail {26}
    throws-like 'sub hail {10}', X::Redeclaration,
        'redefining existing subroutine dies');
    supersede sub hail {8}
    is(hail(), 8, 'redefining non-stub subroutine with supersede');
}

# vim: ft=perl6
