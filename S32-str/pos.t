use v6.c;

use Test;

# L<S29/Obsolete Functions/=item pos>

plan 2;

my $str = 'moose';
$str ~~ /oo/;
throws-like '$str.pos', X::Method::NotFound, 'Str.pos superseeded by $/.to';

is($/.to, 3, '$/.to works');

# vim: ft=perl6
