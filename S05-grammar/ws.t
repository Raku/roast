use v6;
use Test;
plan 8;

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
ok $<ws> ~~ undef,         'implicit <.ws> did not capture';
ok 'axb' ~~ m/^<T1::r2>$/, 'explicit <.ws> is overridden';
ok $<ws> ~~ undef,         'explicit <.ws> did not capture';
ok 'axb' ~~ m/^<T1::r3>$/, 'explicit  <ws> is overridden';
is $<T1::r3><ws>, 'x',     'explicit  <ws> did capture';


# vim: ft=perl6
