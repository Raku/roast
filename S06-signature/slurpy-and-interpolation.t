use v6;

use Test;

plan 7;

# L<S03/Argument List Interpolating/"interpolate">

# try to flatten the args for baz() to match

sub baz ($a, $b) { return "a: $a b: $b"}
sub invoke (*@args) { baz(|@args) }

my $val;
lives_ok {
    $val = invoke(1, 2);
}, '... slurpy args flattening and matching parameters';

is($val, 'a: 1 b: 2', '... slurpy args flattening and matching parameters');

# try to flatten the args for the anon sub to match

sub invoke2 ($f, *@args) { $f(|@args) }; 
is(invoke2(sub ($a, $b) { return "a: $a b: $b"}, 1, 2), 'a: 1 b: 2', 
    '... slurpy args flattening and matching parameters');

dies_ok {
    invoke2(sub ($a, $b) { return "a: $a b: $b"}, 1, 2, 3);
}, '... slurpy args flattening and not matching because of too many parameters';  

# used to be a Rakudo regression, RT #62730

{
    sub f1(*%h) { %h.perl }; 
    sub f2(*%h) { f1(|%h) };
    lives_ok { f2( :a(1) ) },
            'Can interpolate hashes into slurpy named parameters';
    is EVAL(f2(:a(4))).<a>, 4,  '... with a sane return value';
}

# RT #113804
#?niecza skip "Unable to resolve method Capture in type Range"
is join('|', |(1..5)), '1|2|3|4|5', 'can interpolate ranges into arglists';

# vim: ft=perl6
