use Test;

=begin pod

This file was derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/charset.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 90;

# Broken:
# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading [ ">

ok("zyxaxyz" ~~ m/(<[aeiou]>)/, 'Simple set');
is($0, 'a', 'Simple set capture');

# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading - indicates">
ok(!( "a" ~~ m/<-[aeiou]>/ ), 'Simple neg set failure');
ok("f" ~~ m/(<-[aeiou]>)/, 'Simple neg set match');
is($0, 'f', 'Simple neg set capture');

# https://github.com/Raku/old-issue-tracker/issues/4791
{
    ok "a" ~~ m/<![a]>/, "zerowidth negated character class can match at end of string";
}

# L<S05/Extensible metasyntax (C<< <...> >>)/Character classes can be combined>
ok(!( "a" ~~ m/(<[a..z]-[aeiou]>)/ ), 'Difference set failure');
ok("y" ~~ m/(<[a..z]-[aeiou]>)/, 'Difference set match');
is($0, 'y', 'Difference set capture');

# https://github.com/Raku/old-issue-tracker/issues/2978
ok(  "abc" ~~ m/<[\w]-[\n]>/,  'Difference set match 1');
ok(!("abc" ~~ m/<[\w]-[\N]>/), 'Difference set match 2');
is(("abc123" ~~ m/<[\w]-[a\d]>+/), 'bc', 'Difference set match 3');
is(("abc123" ~~ m/<[\w]-[1\D]>+/), '23', 'Difference set match 4');
is(("abc123def" ~~ m/<[\w]-[\D\n]>+/), '123', 'Difference set match 5');
is(("abc123def" ~~ m/<[\w]-[\D\h]>+/), '123', 'Difference set match 6');
is(("abc" ~~ /<-["\\\t\n]>+/), 'abc', 'Difference set match 7');

ok(!( "a" ~~ m/(<+alpha-[aeiou]>)/ ), 'Named difference set failure');
ok("y" ~~ m/(<+alpha-[aeiou]>)/, 'Named difference set match');
is($0, 'y', 'Named difference set capture');
ok(!( "y" ~~ m/(<[a..z]-[aeiou]-[y]>)/ ), 'Multi-difference set failure');
ok("f" ~~ m/(<[a..z]-[aeiou]-[y]>)/, 'Multi-difference set match');
is($0, 'f', 'Multi-difference set capture');

ok(']' ~~ m/(<[\]]>)/, 'quoted close LSB match');
is($0, ']', 'quoted close LSB capture');
ok('[' ~~ m/(<[\[]>)/, 'quoted open LSB match');
is($0, '[', 'quoted open LSB capture');
ok('{' ~~ m/(<[\{]>)/, 'quoted open LCB match');
is($0, '{', 'quoted open LCB capture');
ok('}' ~~ m/(<[\}]>)/, 'quoted close LCB match');
is($0, '}', 'quoted close LCB capture');

# https://github.com/Raku/old-issue-tracker/issues/1113
eval-lives-ok( '"foo" ~~ /<[f] #`[comment] + [o]>/',
               'comment embedded in charset can be parsed' );
ok( "foo" ~~ /<[f] #`[comment] + [o]>/, 'comment embedded in charset works' );

# https://github.com/Raku/old-issue-tracker/issues/1112
ok "\x[FFEF]" ~~ /<[\x0..\xFFEF]>/, 'large \\x char spec';

# https://github.com/Raku/old-issue-tracker/issues/1458
throws-like "'RT #71702' ~~ /<[d..b]>? RT/", Exception,
    'reverse range in charset is lethal';

throws-like "'x' ~~ /<[abc] [def]>? RT/", Exception,
    'missing + or - is fatal 1';

throws-like "'x' ~~ /<:Kata :Hira]>? RT/", Exception,
    'missing + or - is fatal 2';

throws-like "'x' ~~ /<+alpha digit]>? RT/", Exception,
    'missing + or - is fatal 3';

# https://github.com/Raku/old-issue-tracker/issues/839
ok 'b' ~~ /<[. .. b]>/, 'weird char class matches at least its end point';

# https://github.com/Raku/old-issue-tracker/issues/1354
{
try { EVAL "/<[a-z]>/"; }
# TODO Replace when the actual error message is changed.
ok ~$! ~~ / 'Unsupported use of - as character range'/,
    "STD error message for - as character range";
}

# https://github.com/Raku/old-issue-tracker/issues/2500
ok 'ab' ~~ /^(.*) b/, 'Quantifiers in capture groups work';

# https://github.com/Raku/old-issue-tracker/issues/1652
# backslashed characters in char classes
ok '[]\\' ~~ /^ <[ \[ .. \] ]>+ $ /, 'backslashed chars in char classes';
nok '^'   ~~ /  <[ \[ .. \] ]>    /, '... does not match outside its range';

# https://github.com/Raku/old-issue-tracker/issues/2416
{
    nok  '' ~~ / <[a..z]-[x]> /, 'Can match empty string against char class';
    nok 'x' ~~ / <[a..z]-[x]> /, 'char excluded from class';
     ok 'z' ~~ / <[a..z]-[x]> /, '... but others are fine';
}

# https://github.com/Raku/old-issue-tracker/issues/3271
{
    is "\r\na" ~~ /<?[\n]>"\r\na"/, "\r\na",
        'look-ahead with windows newline does not advance cursor position';
}

# https://github.com/rakudo/rakudo/issues/4512
{
    grammar G4512 { token TOP { [<?[\s a]> .]+ } }
    grammar G4512LTM { token TOP { <a> | <b> }; token a { <?[a] - [b]> . b }; token b { . bb } }
    is 'aa' ~~ /<?[\s a]> ./, 'a',
        'lookahead of a class mixing a backslash sequence and a character does not consume';
    is 'ab' ~~ /<?[\N a]>/, '',
        'lookahead of a class mixing a negated backslash sequence and a character is zero width';
    is 'bb' ~~ /<![\s a]> ./, 'b',
        'negated lookahead of a mixed class matches when neither part does';
    nok 'aa' ~~ /<![\s a]> ./,
        'negated lookahead of a mixed class fails on the character part';
    nok ' a' ~~ /<![\s a]> ./,
        'negated lookahead of a mixed class fails on the backslash part';
    ok '' ~~ /<![\s a]>/,
        'negated lookahead of a mixed class matches at the end of the string';
    is 'aa' ~~ /<?[a] - [b]> ./, 'a',
        'lookahead of a class subtraction does not consume';
    is 'bb' ~~ /<![a] - [b]> ./, 'b',
        'negated lookahead of a class subtraction matches a subtracted character';
    nok 'aa' ~~ /<![a] - [b]> ./,
        'negated lookahead of a class subtraction fails on a remaining character';
    is 'bb' ~~ /<?-[\s a]> ./, 'b',
        'lookahead of a negated mixed class does not consume';
    is 'aa' ~~ /<!-[\s a]> ./, 'a',
        'negated lookahead of a negated mixed class matches an excluded character';
    is ('ab' ~~ /<![a \s]> ./).from, 1,
        'negated lookahead of a mixed class whose first part matches moves on';
    nok 'aa' ~~ /<![a \s]> ./,
        'negated lookahead of a mixed class fails on its first part';
    is 'aa' ~~ /<?[a] - [\s b]> ./, 'a',
        'lookahead of a subtraction of a mixed class does not consume';
    is '  ' ~~ /<![\w] - [\d _]> ./, ' ',
        'negated lookahead of a subtraction of a mixed class matches an excluded character';
    is 'aa' ~~ /<?[a 1] - digit> ./, 'a',
        'lookahead of a subtraction of a named class does not consume';
    is 'Aa' ~~ /:i <?[\s a]> ./, 'A',
        'lookahead of a mixed class under :i does not consume';
    nok 'Aa' ~~ /:i <![\s a]> ./,
        'negated lookahead of a mixed class under :i fails on a case variant';
    is 'xyz a' ~~ /[<![\s a]> .]+/, 'xyz',
        'negated lookahead of a mixed class inside a quantifier';
    is 'xyz' ~~ /[<![\s a]> .] ** 2/, 'xy',
        'negated lookahead of a mixed class inside a bounded quantifier';
    is +('aaa' ~~ /[<?[\s a]> (.)]+ a/)[0], 2,
        'quantified lookahead of a mixed class backtracks by whole iterations';
    is 'ab' ~~ /[<?[\s a]> b | a]/, 'a',
        'failing atom after a lookahead of a mixed class backtracks into the next alternative';
    is 'ab' ~~ /[<?[\s a]> b || a]/, 'a',
        'failing atom after a lookahead of a mixed class backtracks into the next sequential alternative';
    is 'aab' ~~ /a [<![\s a]> . | a]/, 'aa',
        'failing negated lookahead of a mixed class backtracks into the next alternative';
    is ('ab' ~~ / $<x>=[<?[\s a]> .] | $<y>=[..] /)<y>, 'ab',
        'longest token matching counts a lookahead of a mixed class as one character';
    is ('aa' ~~ /(<?[\s a]>) (.)/)[0], '',
        'capture around a lookahead of a mixed class is empty';
    is G4512.parse('aaa'), 'aaa',
        'quantified lookahead of a mixed class inside a token';
    ok 'b' ~~ /<[a] + [\S]>/,
        'plus sign keeps a negated backslash sequence as a union';
    ok 'a' ~~ /<[a] - []>/,
        'subtracting an empty enumeration leaves the class alone';
    is 'a' ~~ /<?[a] - []> a/, 'a',
        'lookahead of a class subtracting an empty enumeration leaves the class alone';
    is 'bb' ~~ /<![a] - []> ./, 'b',
        'negated lookahead of a class subtracting an empty enumeration matches an excluded character';
    nok 'a' ~~ /<?[]>/,
        'lookahead of an empty enumeration never matches';
    ok 'a' ~~ /<![]> a/,
        'negated lookahead of an empty enumeration always matches';
    is ('ab' ~~ / $<x>=[<?[a] - [b]> . b] | $<y>=[. bb] /)<x>, 'ab',
        'longest token matching falls through to a lookahead of a class subtraction';
    is G4512LTM.parse('ab')<a>, 'ab',
        'longest token matching falls through to a token starting with a lookahead of a class subtraction';
}

{
    grammar G { token TOP { <+ kebab-case> }; token kebab-case { 'a' } };
    is G.subparse('aaa').Str, 'a', "kebab-case allowed in character classes";
    dies-ok { 'a' ~~ / <+xdigit-digit> / }, "accidental kebabs disallowed";
}

# https://github.com/Raku/old-issue-tracker/issues/4454
#?rakudo.jvm 2 todo 'ignorecase and character ranges RT #125753'
dies-ok { EVAL '/<[Ḍ̇..\x2FFF]>/' }, 'Cannot use NFG synthetic as range endpoint';

# https://github.com/Raku/old-issue-tracker/issues/4454
is "Aa1" ~~ /:i <[a..z0..9]>+/, "Aa1", ':i with cclass with multiple ranges works';

# https://github.com/Raku/old-issue-tracker/issues/4454
#?rakudo.jvm 3 todo 'ignorecase and character ranges'
is '%E3%81%82' ~~ /:ignorecase ['%' (<[a..f0..9]>|x)**2]+/, '%E3%81%82',
    ':ignorecase in combination with charclass ranges works with LTM';
is 'Ä' ~~ /:ignoremark (<[A..F]>|x)/, 'Ä',
    ':ignoremark in combination with charclass ranges works with LTM';
is 'Ä' ~~ /:ignoremark :ignorecase (<[a..f]>|x)/, 'Ä',
    ':ignoremark :ignorecase in combination with charclass ranges works with LTM';

{
    is ("\0\0\0" ~~ /<[\0]>+/).Str, "\0\0\0", '\0 works inside character classes and matches null';
}

# https://github.com/Raku/old-issue-tracker/issues/5341
ok "a" ~~ m:g:ignoremark/<[á]>/, ':g, :ignoremark, and cclass interaction ok';

# vim: expandtab shiftwidth=4
