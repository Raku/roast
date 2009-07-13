use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/patvar.t.

=end pod

plan 21;

if !eval('("a" ~~ /a/)') {
  skip_rest "skipped tests - rules support appears to be missing";
} else {

#?pugs emit force_todo(3,4,5,6,7,9,10,11,13,14,15,17,19);

my $var = rx/a+b/;

my @var = (rx/a/, rx/b/, rx/c/, rx/\w/);

my %var = (a=>rx:s/ 4/, b=>rx:s/ cos/, c=>rx:s/ \d+/);


# SCALARS

ok(!( "a+b" ~~ m/<{$var}>/ ), 'Simple scalar match');
ok(!( "zzzzzza+bzzzzzz" ~~ m/<{$var}>/ ), 'Nested scalar match');
ok("aaaaab" ~~ m/<{$var}>/, 'Rulish scalar match');

# RT #61960
{
    my $a = 'a';
    #?rakudo todo 'Null PMC access in get_string()'
    lives_ok { 'a' ~~ / $a / }, 'can match with a string as a rx';
    #?rakudo skip 'Null PMC access in get_string()'
    ok 'a' ~~ / $a /, 'match with string as rx works';
}

# ArrayS

ok("a" ~~ m/@var/, 'Simple array match (a)');
ok("b" ~~ m/@var/, 'Simple array match (b)');
ok("c" ~~ m/@var/, 'Simple array match (c)');
ok("d" ~~ m/@var/, 'Simple array match (d)');
ok(!( "!" ~~ m/@var/ ), 'Simple array match (!)');
ok("!!!!a!!!!!" ~~ m/@var/, 'Nested array match (a)');
ok("!!!!e!!!!!" ~~ m/@var/, 'Nested array match (e)');

ok("abca" ~~ m/^@var+$/, 'Multiple array matching');
ok(!( "abca!" ~~ m/^@var+$/ ), 'Multiple array non-matching');


# HASHES

ok("a 4" ~~ m/%var/, 'Simple hash interpolation (a)');
ok("b cos" ~~ m/%var/, 'Simple hash interpolation (b)');
ok("c 1234" ~~ m/%var/, 'Simple hash interpolation (c)');
ok(!( "d" ~~ m/%var/ ), 'Simple hash interpolation (d)');
ok("====a 4=====" ~~ m/%var/, 'Nested hash interpolation (a)');
ok(!( "abca" ~~ m/^%var$/ ), 'Simple hash non-matching');


ok("a 4 b cos c 99  a 4" ~~ m:s/^[ %var]+$/, 'Simple hash repeated matching');

}

