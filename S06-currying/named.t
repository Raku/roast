use v6;
use Test;

# L<S06/Currying/>
plan 4;

sub tester(:$a, :$b, :$c) {
    "a$a b$b c$c";
}

{
    my $w = &tester.assuming(b => 'x');
    is $w(a => 'w', c => 'y'), 'aw bx cy', 'currying one named param';
}

{
    my $w = &tester.assuming(b => 'b');
    my $v =  $w.assuming(c => 'c');
    is $v(a => 'x'), 'ax bb cc', 'can curry on an already curried sub';
    is $w(a => 'x', c => 'd'), 'ax bb cd', '... and the old one still works';
}

#?rakudo.moar todo 'RT 123498'
dies_ok { sub {}.assuming(named => True)() },
    'cannot assume unknown named params';

# vim: ft=perl6
