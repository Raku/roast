use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;


plan 64;

# old: L<S05/Return values from matches/"A match always returns a Match object" >
# L<S05/Match objects/"A match always returns a " >
{
  my $match = 'abd' ~~ m/ (a) (b) c || (\w) b d /;
  isa-ok $match, Match, 'Match object returned';
  isa-ok $/, Match, 'Match object assigned to $/';
  ok( $/ === $match, 'Same match objects');
}

{
  my $match = 'xyz' ~~ / abc /;
  isa-ok( $/, Nil, 'Failed match returns Nil' );
}

# old: L<S05/Return values from matches/"The array elements of a C<Match> object are referred to" >
# L<S05/Accessing captured subpatterns/"The array elements of a " >
{
  'abd' ~~ m/ (a) (b) c || (\w) b d /;
  ok( $/[0] eq 'a', 'positional capture accessible');
  ok( @($/).[0] eq 'a', 'array context - correct number of positional captures');
  ok( @($/).elems == 1, 'array context - correct number of positional captures');
  ok( $/.list.elems == 1, 'the .list methods returns a list object');
}

# old: L<S05/Return values from matches/"When used as a hash, a C<Match> object" >
# L<S05/Match objects/"When used as a hash" >
{
  'abd' ~~ m/ <alpha> <alpha> c || <alpha> b d /;
  ok( $/<alpha> eq 'a', 'named capture accessible');
  ok( %($/).keys == 1, 'hash context - correct number of named captures');
  ok( %($/).<alpha> eq 'a', 'hash context - named capture accessible');
  ok( $/.hash.keys[0] eq 'alpha', 'the .hash method returns a hash object');
}

# https://github.com/Raku/old-issue-tracker/issues/640
{
  use MONKEY-TYPING;
  augment class Match { method beys () {return %(self).keys }; };
  my rule a {H};
  "Hello" ~~ /<a=&a>/;
  is $/.beys, 'a', 'get rule result';
  my $x = $/;
  is $x.beys, 'a', 'match copy should be same as match';
}

# https://github.com/Raku/old-issue-tracker/issues/932
{
    my regex o { o };
    "foo" ~~ /f<o=&o>+/;

    is ~$<o>, 'o o', 'match list stringifies like a normal list';
    ok $<o> ~~ Positional, '... and it is Positional';
    # I don't know what difference 'isa' makes, but it does.
    # Note that calling .WHAT (as in the original ticket) does not have
    # the same effect.
    is ~$<o>, 'o o', 'match list stringifies like a normal list AFTER "isa"';
}

# https://github.com/Raku/old-issue-tracker/issues/935
{
    'ab' ~~ /(.)+/;
    is $/[0][0], 'a', 'match element [0][0] from /(.)+/';
    is $/[0][1], 'b', 'match element [0][1] from /(.)+/';

    my @match = @( 'ab' ~~ /(.)+/ );
    is @match[0][0], 'a', 'match element [0][0] from /(.)+/ coerced';
    is @match[0][1], 'b', 'match element [0][1] from /(.)+/ coerced';
}

# https://github.com/Raku/old-issue-tracker/issues/933
{
    ok %( 'foo' ~~ /<alpha> oo/ )<alpha>:exists,
       'Match coerced to Hash says match exists';
}

# https://github.com/Raku/old-issue-tracker/issues/1378
{
    # undefined captures should fail to match
    # note the use of $1 (and not $0)
    # This is similar to a test in S05-interpolation/regex-in-variable.t
    nok 'aa' ~~ /(.)$1/, 'undefined capture does not match';

    # This looks superfluous as there is a test for warning when interpolating
    # undefined into a regex in S05-interpolation/regex-in-variable.t
    #?rakudo todo 'referring to non-existing capture'
    is_run( q{'aa' ~~ /(.)$1/},
        {
            status => 0,
            out    => '',
            err    => rx/undef/,
        },
        'match with undefined capture emits a warning' );
}

# https://github.com/Raku/old-issue-tracker/issues/1032
{
    $_ = 'Regex match';
    m/(R.)/;
    isa-ok $/, 'Match', 'Match object in $/ after match in void context';
    is $/, 'Re', 'Matched as intended in void context';
}

# https://github.com/Raku/old-issue-tracker/issues/1377
{
    'abc' ~~ /a/;
    is ($/.orig).rindex('a'), 0, 'rindex() works on $/.orig';
    is ($/.orig).rindex('a', 2), 0, 'rindex() works on $/.orig';
}

# https://github.com/Raku/old-issue-tracker/issues/2887
{
    lives-ok { my $/ := 42 }, 'can bind $/';
}

# https://github.com/Raku/old-issue-tracker/issues/1441
{
    my $/ := 'foobar';
    is $0, 'foobar', '$0 works like $/[0], even for non-Match objects';
    nok $1.defined, '$1 is not defined';
}

# https://github.com/Raku/old-issue-tracker/issues/1527
{
    my $/ := Any;
    lives-ok { $0 },
        '$0 accessible when $/ is undefined';
    ok $0 === Any,
        '$0 is Any when $/ is undefined';
    nok $0.defined, '$0 is undefined';
}

# https://github.com/Raku/old-issue-tracker/issues/2057
{
    ok 'abc' ~~ /(.)+/, 'regex sanity';
    my $x = 0;
    $x++ for $/.list;
    is $x, 1, '$/.list does not flatten quantified subcaptures';

    ok 'abc' ~~ /(.)**2 (.)/, 'regex sanity';
    $x = 0;
    $x++ for $/.list;
    is $x, 2, '$/.list does not flattens subcaptures';
}

# https://github.com/Raku/old-issue-tracker/issues/1657
{
    my $s;
    try { $s = EVAL '"foo" ~~ /(foo)/; "$0a"' };
    ok not $!, 'alphabetic characters can follow digits in $0 variable in interpolation';
    is $s, 'fooa', 'alphabetic characters follows $0 interpolated value';
}

# L<S32::Rules/Match>

# https://github.com/Raku/old-issue-tracker/issues/3097
{
    ok "a \n \b \n c \n d" ~~ /a .* c/, "match multiple lines with '.'";
    ok $/.can('lines'), "Match has a .lines method";
    is +$/.lines, 3, "Correct number of lines";
    isa-ok $/, Cool, "Match is Cool";
}

# https://github.com/Raku/old-issue-tracker/issues/2352
{
    'x' ~~ /(y)? (z)*/;
    is-deeply $0, Nil, 'quantifier ? matching 0 values returns Nil';
    ok $1 ~~ Positional && $1.elems == 0,
      'quantifier * matching 0 values returns empty list';
}

# https://github.com/Raku/old-issue-tracker/issues/4304
{
    my $*guard = 0;
    grammar Foo1 { regex TOP { [a | [ "[" <R> b? "]" ]]+ % b { die if $*guard++ > 500 } }; regex b { b }; regex R { <TOP>+ % [ <.b>? "/" ] } };
    is Foo1.parse("[aba]").gist,  "｢[aba]｣\n R => ｢aba｣\n  TOP => ｢aba｣",  '(non-)capturing subrules advance cursor position (1)';
    is Foo1.parse("[abab]").gist, "｢[abab]｣\n R => ｢aba｣\n  TOP => ｢aba｣", '(non-)capturing subrules advance cursor position (2)';

    $*guard = 0;
    grammar Foo2 { regex TOP { [a | [ "[" <R> b? "]" ]]+ % b { die if $*guard++ > 500 } }; regex b { b }; regex R { <TOP>+ % [ <b>? "/" ] } };
    is Foo2.parse("[aba]").gist,  "｢[aba]｣\n R => ｢aba｣\n  TOP => ｢aba｣",  '(non-)capturing subrules advance cursor position (3)';
    is Foo2.parse("[abab]").gist, "｢[abab]｣\n R => ｢aba｣\n  TOP => ｢aba｣", '(non-)capturing subrules advance cursor position (4)';
}

# https://github.com/Raku/old-issue-tracker/issues/4530
{
    my $a = '<4';
    $a = $a ~~ /\<(\d+)/;
    is ~$a, '<4', 'result of match assigned to variable matched against works';
}

# https://github.com/Raku/old-issue-tracker/issues/3163
{
    my $rt118453 = 'pre x post';
    $rt118453 ~~ /^ (<-[x]>+) 'x' (\N+) $/;
    $rt118453 = ~$0;
    is ~$1, ' post', 'Reassigning to matched-against string and then accessing submatches works';
}

# https://github.com/Raku/old-issue-tracker/issues/4279
{
    my $m = 'rule1 foo rule2 bar' ~~ /^ ( 'rule1' || 'rule2' )* %% (.+?) $/;
    is $m[0].elems, 2, 'Correct number of captures when backtracking (1)';
    is $m[1].elems, 2, 'Correct number of captures when backtracking (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/3056
{
    my $m = "abcde" ~~ / (a | b | bc | cde)+»/;
    is $m[0].elems, 3, 'LTM alternation does not capture the wrong stuff when backtracking (1)';
    is join(" ", $m[0]), 'a b cde', 'LTM alternation does not capture the wrong stuff when backtracking (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/5174
{
    subtest 'postfix operators do not interfere with interpolation of $/[0]', {
        plan 3;
        '5x3' ~~ /(.)x(.)/;

        # fudge reviewed; OK to go into 6.d spec
        #?rakudo 3 todo 'parse error with --'
        is "$/[0]--", '5--', 'postfix --';
        is "$/[0]++", '5++', 'postfix ++';

        my sub postfix:<foo> { 42 }
        is "$/[0]foo", '5foo', 'custom postfix `foo`';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4957
{
    lives-ok
        { grammar { token TOP { <número>+ }; token número {<< \d+ >>} } },
        'non-ascii tokens in a grammar work';
    lives-ok
        { "abc 123" ~~ /$<número>=\d+/ },
        'non-ascii token in a subcapture work';
}

# https://github.com/Raku/old-issue-tracker/issues/5676
{
    lives-ok
        { "a b" ~~ /(\w) \s (\w)/; my $a = $١ },
        'Unicode digit match variables work';
}

{
    is-deeply ('foo'.match(/bar/)).Bool, False,
        '.Bool on failed Match returns False';
    is-deeply ('foo'.match(/foo/)).Bool, True,
        '.Bool on succesful Match returns True';
    is-deeply Match.Bool, False, '.Bool on Match:U is False';
}

subtest 'capture markers work correctly' => {
    plan 12;

    constant $s = '1234567890foobarMEOW';
    is-deeply ~($s ~~ /foo <(bar  /), 'bar', '1';
    is-deeply ~($s ~~ /foo )>bar  /), 'foo', '2';
    is-deeply ~($s ~~ /fo<(oba)>r /), 'oba', '3';

    is-deeply ~($s ~~ /<:lower>**3 <(<:lower>+   /), 'bar', '4';
    is-deeply ~($s ~~ /<:lower>**3 )> .+         /), 'foo', '5';
    is-deeply ~($s ~~ /<:lower>**2 <( .**3 )> .+ /), 'oba', '6';

    my $r = my grammar {
        token TOP { <foo><bar><ber> }
        token foo { 12345 <( 67890 }
        token bar { foo   )> bar   }
        token ber { M <(EO)>  W    }
    }.parse: $s;
    is-deeply ~$r<foo>, '67890', '<foo> (grammar 1)';
    is-deeply ~$r<bar>, 'foo',   '<bar> (grammar 1)';
    is-deeply ~$r<ber>, 'EO',    '<ber> (grammar 1)';

    my $r2 = my grammar {
        token TOP { <foo><bar><ber> }
        token foo { \d**5 <( \d+ }
        token bar { <:lower>**3 )> <:lower>+ }
        token ber { <:upper> <(.**2)> .+  }
    }.parse: $s;
    is-deeply ~$r2<foo>, '67890', '<foo> (grammar 2)';
    is-deeply ~$r2<bar>, 'foo',   '<bar> (grammar 2)';
    is-deeply ~$r2<ber>, 'EO',    '<ber> (grammar 2)';
}

# vim: expandtab shiftwidth=4
