use v6;
use Test;
plan 3;

# boolification of roles

sub b($x) { $x ?? 'aye' !! 'nay' }

my Stringy $s;
is b($s), 'nay', 'boolification of role type object';

my Stringy $t = '';
is b($t), 'nay', 'boolification of role-typed container (false)';

my Stringy $u = 'moin';
is b($u), 'aye', 'boolification of role-typed container (true)';
