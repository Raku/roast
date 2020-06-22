use v6;

use Test;

plan 13;

# L<S03/Argument List Interpolating/"interpolate">

# try to flatten the args for baz() to match

sub baz ($a, $b) { return "a: $a b: $b"}
sub invoke (*@args) { baz(|@args) }

my $val;
lives-ok {
    $val = invoke(1, 2);
}, '... slurpy args flattening and matching parameters';

is($val, 'a: 1 b: 2', '... slurpy args flattening and matching parameters');

# try to flatten the args for the anon sub to match

sub invoke2 ($f, *@args) { $f(|@args) };
is(invoke2(sub ($a, $b) { return "a: $a b: $b"}, 1, 2), 'a: 1 b: 2',
    '... slurpy args flattening and matching parameters');

dies-ok {
    invoke2(sub ($a, $b) { return "a: $a b: $b"}, 1, 2, 3);
}, '... slurpy args flattening and not matching because of too many parameters';

# https://github.com/Raku/old-issue-tracker/issues/650
# used to be a Rakudo regression, RT #62730

{
    sub f1(*%h) { %h.raku };
    sub f2(*%h) { f1(|%h) };
    lives-ok { f2( :a(1) ) },
            'Can interpolate hashes into slurpy named parameters';
    is EVAL(f2(:a(4))).<a>, 4,  '... with a sane return value';
}

# https://github.com/Raku/old-issue-tracker/issues/4886
{
    sub f(*%h) { %h.keys.sort };
    
    my %typedhash := :{ a => 1, b => 2 }; 
    
    is-deeply f(|%typedhash).List, <a b>,
        'Can interpolate typed hashes into slurpy named parameters';
}

# https://github.com/Raku/old-issue-tracker/issues/2796
is join('|', |(1..5)), '1|2|3|4|5', 'can interpolate ranges into arglists';

# https://github.com/Raku/old-issue-tracker/issues/4602
# Some implementations have limitations with regards to how many args can be
# flattened into a callsite. This test covers a case where we could SEGV when
# around that limit.
{
    sub foo(|c) { }
    for 65534..65538 {
        try foo 1, |(2 xx $_);
        pass "Survived trying to pass $_ flattened args";
    }
}

# vim: expandtab shiftwidth=4
