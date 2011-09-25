use v6;
use Test;

plan 17;

ok (~^"foo".encode eqv Buf.new(0x99, 0x90, 0x90)), 'prefix:<~^>';

ok ("foo".encode ~& "bar".encode eqv "bab".encode), 'infix:<~&>';
ok ("ber".encode ~| "baz".encode eqv "bez".encode), 'infix:<~|>';
ok ("foo".encode ~^ "bar".encode eqv Buf.new(4, 14, 29)), 'infix:<~^>';

ok ("aaaaa".encode ~& "aa".encode eqv "aa\0\0\0".encode),
    '~& extends rightwards';
ok ("aaaaa".encode ~| "aa".encode eqv "aaaaa".encode),
    '~| extends rightwards';
ok ("aaaaa".encode ~^ "aa".encode eqv "\0\0aaa".encode),
    '~^ extends rightwards';

my $a = Buf.new(1, 2, 3);
my $b = Buf.new(1, 2, 3, 4);

 ok $a eq $a,    'eq +';
nok $a eq $b,    'eq -';
 ok $a ne $b,    'ne +';
nok $a ne $a,    'ne -';
 ok $a lt $b,    'lt +';
nok $a lt $a,    'lt -';
nok $b lt $a,    'lt -';
 ok $b gt $a,    'gt +';
nok $b gt $b,    'gt -';
nok $a gt $b,    'gt -';
