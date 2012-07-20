use v6;
use Test;
plan 12;

# L<S05/Modifiers/"causes certain whitespace sequences to be considered">
# L<S05/Modifiers/"any grammar is free to override the rule">

# test that implicit and explicit <.ws> rules are overridable
grammar T1 {
    token   ws { 'x' };
    rule    r1 {'a' 'b'};
    regex   r2 { 'a' <.ws> 'b' };
    regex   r3 { 'a' <ws> 'b' };
}

ok 'x'   ~~ m/^<T1::ws>$/, 'basic sanity with custom <ws> rules';
is $/, 'x',                'correct text captured';
ok 'axb' ~~ m/^<T1::r1>$/, 'implicit <.ws> is overridden';
nok $<T1::r1><ws>.defined,   'implicit <.ws> did not capture';
ok 'axb' ~~ m/^<T1::r2>$/, 'explicit <.ws> is overridden';
nok $<T1::r2><ws>.defined,   'explicit <.ws> did not capture';
ok 'axb' ~~ m/^<T1::r3>$/, 'explicit  <ws> is overridden';
is $<T1::r3><ws>, 'x',     'explicit  <ws> did capture';

# RT #64094
{
    ok '' ~~ / <ws>  /, 'match <ws>  against empty string';
    ok '' ~~ / <ws>? /, 'match <ws>? against empty string';
    #?rakudo 2 skip 'infinite loop: RT #64094 (noauto)'
    ok '' ~~ / <ws>+ /, 'match <ws>+ against empty string';
    ok '' ~~ / <ws>* /, 'match <ws>* against empty string';
}

# vim: ft=perl6
