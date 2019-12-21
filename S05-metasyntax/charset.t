use v6;

use Test;

=begin pod

This file was derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/charset.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 55;

# Broken:
# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading [ ">

ok("zyxaxyz" ~~ m/(<[aeiou]>)/, 'Simple set');
is($0, 'a', 'Simple set capture');

# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading - indicates">
ok(!( "a" ~~ m/<-[aeiou]>/ ), 'Simple neg set failure');
ok("f" ~~ m/(<-[aeiou]>)/, 'Simple neg set match');
is($0, 'f', 'Simple neg set capture');

# RT #126746
{
    ok "a" ~~ m/<![a]>/, "zerowidth negated character class can match at end of string";
}

# L<S05/Extensible metasyntax (C<< <...> >>)/Character classes can be combined>
ok(!( "a" ~~ m/(<[a..z]-[aeiou]>)/ ), 'Difference set failure');
ok("y" ~~ m/(<[a..z]-[aeiou]>)/, 'Difference set match');
is($0, 'y', 'Difference set capture');

# RT #115802
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

# RT #67124
eval-lives-ok( '"foo" ~~ /<[f] #`[comment] + [o]>/',
               'comment embedded in charset can be parsed' );
ok( "foo" ~~ /<[f] #`[comment] + [o]>/, 'comment embedded in charset works' );

# RT #67122
ok "\x[FFEF]" ~~ /<[\x0..\xFFEF]>/, 'large \\x char spec';

throws-like "'RT #71702' ~~ /<[d..b]>? RT/", Exception,
    'reverse range in charset is lethal (RT #71702)';

throws-like "'x' ~~ /<[abc] [def]>? RT/", Exception,
    'missing + or - is fatal 1';

throws-like "'x' ~~ /<:Kata :Hira]>? RT/", Exception,
    'missing + or - is fatal 2';

throws-like "'x' ~~ /<+alpha digit]>? RT/", Exception,
    'missing + or - is fatal 3';

# RT #64220
ok 'b' ~~ /<[. .. b]>/, 'weird char class matches at least its end point';

# RT #69682
{
try { EVAL "/<[a-z]>/"; }
# TODO Replace when the actual error message is changed.
ok ~$! ~~ / 'Unsupported use of - as character range; in Perl 6 please use ..'/,
    "STD error message for - as character range";
}

ok 'ab' ~~ /^(.*) b/,
    'Quantifiers in capture groups work (RT #100650)';

# RT #74012
# backslashed characters in char classes
ok '[]\\' ~~ /^ <[ \[ .. \] ]>+ $ /, 'backslashed chars in char classes';
nok '^'   ~~ /  <[ \[ .. \] ]>    /, '... does not match outside its range';

# RT #89470
{
    nok  '' ~~ / <[a..z]-[x]> /, 'Can match empty string against char class';
    nok 'x' ~~ / <[a..z]-[x]> /, 'char excluded from class';
     ok 'z' ~~ / <[a..z]-[x]> /, '... but others are fine';
}

# RT #120511
{
    is "\r\na" ~~ /<?[\n]>"\r\na"/, "\r\na",
        'look-ahead with windows newline does not advance cursor position';
}

{
    grammar G { token TOP { <+ kebab-case> }; token kebab-case { 'a' } };
    is G.subparse('aaa').Str, 'a', "kebab-case allowed in character classes";
    dies-ok { 'a' ~~ / <+xdigit-digit> / }, "accidental kebabs disallowed";
}

#?rakudo.jvm 2 todo 'ignorecase and character ranges RT #125753'
dies-ok { EVAL '/<[Ḍ̇..\x2FFF]>/' }, 'Cannot use NFG synthetic as range endpoint';

# RT #125753
is "Aa1" ~~ /:i <[a..z0..9]>+/, "Aa1", ':i with cclass with multiple ranges works';
#?rakudo.jvm 3 todo 'ignorecase and character ranges RT #125753'
is '%E3%81%82' ~~ /:ignorecase ['%' (<[a..f0..9]>|x)**2]+/, '%E3%81%82',
    ':ignorecase in combination with charclass ranges works with LTM';
is 'Ä' ~~ /:ignoremark (<[A..F]>|x)/, 'Ä',
    ':ignoremark in combination with charclass ranges works with LTM';
is 'Ä' ~~ /:ignoremark :ignorecase (<[a..f]>|x)/, 'Ä',
    ':ignoremark :ignorecase in combination with charclass ranges works with LTM';

{
    is ("\0\0\0" ~~ /<[\0]>+/).Str, "\0\0\0", '\0 works inside character classes and matches null';
}

# RT #128270
ok "a" ~~ m:g:ignoremark/<[á]>/, ':g, :ignoremark, and cclass interaction ok';

# vim: ft=perl6
