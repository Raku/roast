use v6;
use Test;

plan 4;

sub opt1($p?) { defined($p) ?? $p !! 'undef'; }

is opt1('abc'), 'abc',      'Can pass optional param';
is opt1(),      'undef',    'Can leave out optional param';

sub opt_typed(Int $p?) { defined($p) ?? $p !! 'undef' };

is opt_typed(2), 2,        'can pass optional typed param';
#?rakudo skip 'optional typed params, RT #61528'
is opt_typed() , 'undef',  'can leave out optional typed param';

# vim: ft=perl6
