use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/patvar.t.

=end pod

plan 33;

# L<S05/Variable (non-)interpolation>


my $var = rx/a+b/;

my @var = (rx/a/, rx/b/, rx/c/, rx/\w/);

my %var = (a=>rx/ 4/, b=>rx/ cos/, c=>rx/ \d+/);

my $foo = "a+b";

my @foo = ("a+b", "b+c");

# SCALARS

ok(!( "a+b" ~~ m/<{$var}>/ ), 'Simple scalar match 1');
ok(!( "a+b" ~~ m/<$var>/ ),   'Simple scalar match 2');
#?pugs todo
ok("a+b" ~~ m/$foo/,          'Simple scalar match 3');
ok(!( "zzzzzza+bzzzzzz" ~~ m/<{$var}>/ ), 'Nested scalar match 1');
ok(!( "zzzzzza+bzzzzzz" ~~ m/<$var>/ ),   'Nested scalar match 2');
#?pugs todo
ok("zzzzzza+bzzzzzz" ~~ m/$foo/ ,         'Nested scalar match 3');
#?pugs todo
ok("aaaaab" ~~ m/<{$var}>/, 'Rulish scalar match 1');
#?pugs todo
ok("aaaaab" ~~ m/<$var>/,   'Rulish scalar match 2');
#?pugs todo
ok("aaaaab" ~~ m/$var/,     'Rulish scalar match 3');
#?pugs todo
ok("aaaaab" ~~ m/<{$foo}>/, 'Rulish scalar match 4');
#?pugs todo
ok("aaaaab" ~~ m/<$foo>/,   'Rulish scalar match 5');
ok(!("aaaaab" ~~ m/$foo/),  'Rulish scalar match 6');
#?rakudo todo 'double quote interpolation'
#?niecza todo
#?pugs todo
ok('aaaaab' ~~ m/"$foo"/, 'Rulish scalar match 7');

# RT #61960
#?pugs todo
{
    my $a = 'a';
    ok 'a' ~~ / $a /, 'match with string as rx works';
}

# Arrays

#?rakudo 4 todo 'array of regexes'
#?pugs todo
ok("a" ~~ m/@var/, 'Simple array match (a)');
#?pugs todo
ok("b" ~~ m/@var/, 'Simple array match (b)');
#?pugs todo
ok("c" ~~ m/@var/, 'Simple array match (c)');
#?pugs todo
ok("d" ~~ m/@var/, 'Simple array match (d)');
ok(!( "!" ~~ m/@var/ ), 'Simple array match (!)');
#?rakudo 3 todo 'array variable interpolation'
#?pugs todo
ok("!!!!a!!!!!" ~~ m/@var/, 'Nested array match (a)');
#?pugs todo
ok("!!!!e!!!!!" ~~ m/@var/, 'Nested array match (e)');

#?pugs todo
ok("abca" ~~ m/^@var+$/, 'Multiple array matching');
#?niecza skip 'Cannot cast from source type to destination type.'
ok(!( "abca!" ~~ m/^@var+$/ ), 'Multiple array non-matching');

#?rakudo todo 'array variable interpolation'
#?pugs todo
ok("a+bb+ca+b" ~~ /^@foo+$/, 'Multiple array non-compiling');
ok(!("a+bb+ca+b" ~~ /^<@foo>+$/), 'Multiple array compiling');
ok(!("aaaabbbbbcaaab" ~~ /^@foo+$/), 'Multiple array non-compiling');
#?pugs todo
#?rakudo todo 'nom regression'
ok("aaaabbbbbcaaab" ~~ /^<@foo>+$/, 'Multiple array compiling');

# L<S05/Variable (non-)interpolation/The use of a hash variable in patterns is reserved>
#?pugs todo
eval_dies_ok 'm/%var/', 'cannot interpolate hashes into regexes';

# L<S05/Variable (non-)interpolation/If $var is undefined>
# This is similar to a test in S05-match/capturing-contexts.t
#?niecza skip 'Object reference not set to an instance of an object'
#?pugs skip 'boom'
{
    my $u;
    ok 'a' !~~ /$u/, 'undefined variable does not match';
    BEGIN { @*INC.push: 't/spec/packages/' }
    use Test::Util;
    #?rakudo todo 'warn on undef'
    is_run(
            q{my $u; 'a' ~~ /$u/},
            {
                status  => 0,
                out     => '',
                err     => rx/undef/,
            },
            'interpolating undefined into a regex warns'
          );
}

#?rakudo 3 skip 'instance member interpolation'
#?niecza skip "Representation P6cursor does not support attributes"
#?pugs todo
{
    my class InterpolationTest {
        has $!pattern = 'a+b';

        method run {
            ok('aaab' ~~ / $!pattern /, 'Interpolation of instance member');
            ok('aaab' ~~ / <$!pattern> /, 'Interpolation of instance member');
            ok('aaab' ~~ / "$!pattern" /, 'Interpolation of instance member');
        }
    }

    InterpolationTest.new.run;
}

# vim: ft=perl6
