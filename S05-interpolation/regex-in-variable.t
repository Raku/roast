use v6;

use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Util;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/patvar.t.

=end pod

plan 63;

# L<S05/Variable (non-)interpolation>


my $var = rx/a+b/;

my @var = (rx/a/, rx/b/, rx/c/, rx/\w/);

my %var = (a=>rx/ 4/, b=>rx/ cos/, c=>rx/ \d+/);

my $foo = "a+b";

my @foo = ("a+b", "b+c");

# SCALARS

ok(!( "a+b" ~~ m/<{$var}>/ ), 'Simple scalar match 1');
ok(!( "a+b" ~~ m/<$var>/ ),   'Simple scalar match 2');
ok("a+b" ~~ m/$foo/,          'Simple scalar match 3');
ok(!( "zzzzzza+bzzzzzz" ~~ m/<{$var}>/ ), 'Nested scalar match 1');
ok(!( "zzzzzza+bzzzzzz" ~~ m/<$var>/ ),   'Nested scalar match 2');
ok("zzzzzza+bzzzzzz" ~~ m/$foo/ ,         'Nested scalar match 3');
ok("aaaaab" ~~ m/<{$var}>/, 'Rulish scalar match 1');
ok("aaaaab" ~~ m/<$var>/,   'Rulish scalar match 2');
ok("aaaaab" ~~ m/$var/,     'Rulish scalar match 3');
ok("aaaaab" ~~ m/<{$foo}>/, 'Rulish scalar match 4');
ok("aaaaab" ~~ m/<$foo>/,   'Rulish scalar match 5');
ok(!("aaaaab" ~~ m/$foo/),  'Rulish scalar match 6');
ok(!('aaaaab' ~~ m/"$foo"/), 'Rulish scalar match 7');

{
    no MONKEY-SEE-NO-EVAL;
    # RT #61960
    {
	my $a = 'a';
	ok 'a' ~~ / $a /, 'match with string as rx works';
    }

    # RT #100232
    throws-like { my $x = '1} if say "pwnd"; #'; 'a' ~~ /<$x>/ }, X::SecurityPolicy, "particular garbage-in recognized as being garbage (see RT)";

    # RT #131079
    my $rt131079 = '<::(say "ZOWNED")>';
    throws-like { 'a' ~~ /<$rt131079>/ }, X::SecurityPolicy, "dynamic lookups are restricted regex syntax";
    $rt131079 = '<IO::(say "ZOWNED")>';
    # XXX these next 3 tests can tighten to X::SecurityPolicy later, currently X::NYI;
    throws-like { 'a' ~~ /<$rt131079>/ }, Exception, "dynamic longname lookups are restricted regex syntax";
    $rt131079 = '<::IO::(say "ZOWNED")>';
    throws-like { 'a' ~~ /<$rt131079>/ }, Exception, "dynamic longname lookups are restricted regex syntax (::)";
    $rt131079 = '<::(say "ZOWNED")::File>';
    throws-like { 'a' ~~ /<$rt131079>/ }, Exception, "dynamic longname lookups are restricted regex syntax (2)";
    # XXX This currently an X::Syntax::Reserved until spec clarified, but dynamics should still die.
    $rt131079 = '<::(say "ZOWNED")=bar>';
    throws-like { 'a' ~~ /<$rt131079>/ }, Exception, "dynamic regex aliases fail somehow";
    $rt131079 = '<::IO::(say "ZOWNED")=bar>';
    throws-like { 'a' ~~ /<$rt131079>/ }, X::Syntax::Regex::Alias::LongName, "dynamic regex longname aliases fail specifically";

    # because it broke these:
    {
	ok "foo" ~~ /<{' o ** 2 '}>/, 'returns true';
	isa-ok "foo" ~~ /<{' o ** 2 '}>/, Match, 'returns a valid Match';
	is ~("foo" ~~ /<{' o ** 2 '}>/), "oo", 'returns correct Match';
    }

    throws-like { 'a' ~~ /<{'$(say "trivially pwned")'}>/ }, X::SecurityPolicy, "should handle this too";
    throws-like { 'a' ~~ /<{' "{say q/pwnzered/}"    '}>/ }, X::SecurityPolicy, "should handle this too";
    throws-like { 'a' ~~ /<{' "foo $_ bar "          '}>/ }, X::SecurityPolicy, "should handle this too";
    throws-like { 'a' ~~ /<{' "foo @*ARGS[] bar "    '}>/ }, X::SecurityPolicy, "should handle this too";
    throws-like { 'a' ~~ /<{' "foo %*ENV{} bar "     '}>/ }, X::SecurityPolicy, "should handle this too";
    throws-like { 'a' ~~ /<{' "foo &infix:<+>() "    '}>/ }, X::SecurityPolicy, "should handle this too";
    throws-like { 'a' ~~ /<{' :my $x = {say q/hi!/}; '}>/ }, X::SecurityPolicy, "should handle this too";
    throws-like { 'a' ~~ /<{' {say q/gotcha/}        '}>/ }, X::SecurityPolicy, "should handle this too";
    throws-like { 'a' ~~ /<{' <{say q/gotcha/}>      '}>/ }, X::SecurityPolicy, "should handle this too";
    throws-like { 'a' ~~ /<{' <?{say q/gotcha/}>     '}>/ }, X::SecurityPolicy, "should handle this too";
    throws-like { 'a' ~~ /<{' <!{say q/gotcha/}>     '}>/ }, X::SecurityPolicy, "should handle this too";
    throws-like { 'a' ~~ /<{' <foo=!{say q/gotcha/}> '}>/ }, X::SecurityPolicy, "should handle this too";
    throws-like { 'a' ~~ /<{' <alpha(say q/gotcha/)> '}>/ }, X::SecurityPolicy, "should handle this too";
    throws-like { 'a' ~~ /<{' "$x:(say "busted")"    '}>/ }, X::SecurityPolicy, "should handle this too";
}

# Check some cases that should also die in unrestricted code
throws-like { EVAL '"a" ~~ /<::IO::File=bar>/ '}, X::Syntax::Regex::Alias::LongName, "longname aliases fail specifically (unrestricted ::)";
# Currently an X::Syntax::Reserved ... but should always die with longname.
throws-like { EVAL '"a" ~~ /<::IO::("File")=bar>/ '}, X::Syntax::Regex::Alias::LongName, "dynamic longname aliases fail specifically (unrestricted ::)";
# Check a couple cases that should also die in unrestricted code
throws-like { EVAL '"a" ~~ /<IO::File=bar>/ '}, X::Syntax::Regex::Alias::LongName, "longname aliases fail specifically (unrestricted)";
# Currently an X::Syntax::Reserved ... but should always die with longname.
throws-like { EVAL '"a" ~~ /<IO::("File")=bar>/ '}, X::Syntax::Regex::Alias::LongName, "dynamic longname aliases fail specifically (unrestricted)";


# Arrays

ok("a" ~~ m/@var/, 'Simple array match (a)');
ok("b" ~~ m/@var/, 'Simple array match (b)');
ok("c" ~~ m/@var/, 'Simple array match (c)');
ok("d" ~~ m/@var/, 'Simple array match (d)');
ok(!( "!" ~~ m/@var/ ), 'Simple array match (!)');
ok("!!!!a!!!!!" ~~ m/@var/, 'Nested array match (a)');
ok("!!!!e!!!!!" ~~ m/@var/, 'Nested array match (e)');
is("foo123bar" ~~ /@( rx/\d+/ )/, '123', 'Match from correct position');

ok("abca" ~~ m/^@var+$/, 'Multiple array matching');
ok(!( "abca!" ~~ m/^@var+$/ ), 'Multiple array non-matching');

ok("a+bb+ca+b" ~~ /^@foo+$/, 'Multiple array non-compiling');
ok(!("a+bb+ca+b" ~~ /^<@foo>+$/), 'Multiple array compiling');
ok(!("aaaabbbbbcaaab" ~~ /^@foo+$/), 'Multiple array non-compiling');
ok("aaaabbbbbcaaab" ~~ /^<@foo>+$/, 'Multiple array compiling');

# L<S05/Variable (non-)interpolation/The use of a hash variable in patterns is reserved>
#?rakudo 2 todo "we are not checking for %hashes yet"
throws-like  '/%var/', Exception, 'cannot interpolate hashes into regexes';
throws-like 'm/%var/', Exception, 'cannot interpolate hashes into regexes';

# L<S05/Variable (non-)interpolation/If $var is undefined>
# This is similar to a test in S05-match/capturing-contexts.t
{
    my $u;
    ok 'a' !~~ /$u/, 'undefined variable does not match';
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

# RT #122253
{
    throws-like { EVAL 'my class InterpolationTest { has $!a; method m() { /$!a/ } }' },
        X::Attribute::Regex, :symbol<$!a>,
        'Cannot interpolate attribute in a regex';
    throws-like { EVAL 'my class InterpolationTest { has $!b; method m() { /<$!b>/ } }' },
        X::Attribute::Regex, :symbol<$!b>,
        'Cannot interpolate attribute in a regex in angle construct';
    throws-like { EVAL 'my class InterpolationTest { has $!c; method m() { /<?> { $!c }/ } }' },
        X::Attribute::Regex, :symbol<$!c>,
        'Cannot interpolate attribute in a closure in a regex';
}

# vim: ft=perl6
