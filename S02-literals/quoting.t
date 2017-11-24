use v6;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;
plan 191;

my $foo = "FOO";
my $bar = "BAR";

=begin description

Tests quoting constructs as defined in L<S02/Literals>

Note that non-ASCII tests are kept in quoting-unicode.t

=todo

* q:b and other interpolation levels (half-done)
* meaningful quotations (qx, rx, etc)
* interpolation of scalar, array, hash, function and closure syntaxes
* q : a d verb s // parsing

=end description

# L<S02/Bracketing Characters/bidirectional mirrorings>
{
    my $s = q{ foo bar };
    is $s, ' foo bar ', 'string using q{}';
}

{
    is q{ { foo } }, ' { foo } ',   'Can nest curlies in q{ .. }';
    is q{{ab}},      'ab',          'Unnested single curlies in q{{...}}';
    is q{{ fo} }},   ' fo} ',       'Unnested single curlies in q{{...}}';
    is q{{ {{ } }} }}, ' {{ } }} ', 'Can nest double curlies in q{{...}}';
}

{
    is q{\n},        '\n',          'q{..} do not interpolate \n';
    ok q{\n}.chars == 2,            'q{..} do not interpolate \n';
    is q{$x},        '$x',          'q{..} do not interpolate scalars';
    ok q{$x}.chars == 2,            'q{..} do not interpolate scalars';
}

{
    is Q{\n},        '\n',          'Q{..} do not interpolate \n';
    ok Q{\n}.chars == 2,            'Q{..} do not interpolate \n';
    is Q{$x},        '$x',          'Q{..} do not interpolate scalars';
    ok Q{$x}.chars == 2,            'Q{..} do not interpolate scalars';
    is Q {\\},       '\\\\',        'Q {..} quoting';
}

{
    ok Q{\\}.chars == 2,            'Q{..} do not interpolate backslashes';
}

# L<S02/Adverbs on quotes/":q" ":single" "Interpolate \\, \q and \'">
{
    my @q = ();
    @q = (q/$foo $bar/);
    is(+@q, 1, 'q// is singular');
    is(@q[0], '$foo $bar', 'single quotes are non interpolating');
};

{ # and its complement ;-)
    my @q = ();
    @q = '$foo $bar';
    is(+@q, 1, "'' is singular");
    is(@q[0], '$foo $bar', 'and did not interpolate either');
};

# L<S02/Delimiters of quoting forms/That is () have no special significance>
# non interpolating single quotes with nested parens
{
    my @q = ();
    @q = (q (($foo $bar)));
    is(+@q, 1, 'q (()) is singular');
    is(@q[0], '$foo $bar', 'and nests parens appropriately');
};

# L<S02/Delimiters of quoting forms/That is () have no special significance>
{ # non interpolating single quotes with nested parens
    my @q = ();
    @q = (q ( ($foo $bar)));
    is(+@q, 1, 'q () is singular');
    is(@q[0], ' ($foo $bar)', 'and nests parens appropriately');
};

# L<S02/Delimiters of quoting forms/Which is mandatory for parens>
{ # q() is bad
    my @q;
    sub q { @_ }
    @q = q($foo,$bar);
    is(+@q, 2, 'q() is always sub call');
};

# L<S02/C<Q> forms/:q>
{ # adverb variation
    my @q = ();
    @q = (Q:q/$foo $bar/);
    is(+@q, 1, "Q:q// is singular");
    is(@q[0], '$foo $bar', "and again, non interpolating");
};

{ # nested brackets
    my @q = ();
    @q = (q[ [$foo $bar]]);
    is(+@q, 1, 'q[] is singular');
    is(@q[0], ' [$foo $bar]', 'and nests brackets appropriately');
};

{ # nested brackets
    my @q = ();
    @q = (q[[$foo $bar]]);
    is(+@q, 1, 'q[[]] is singular');
    is(@q[0], '$foo $bar', 'and nests brackets appropriately');
};

# L<S02/C<Q> forms/qq:>
{ # interpolating quotes
    my @q = ();
        @q = qq/$foo $bar/;
    is(+@q, 1, 'qq// is singular');
    is(@q[0], 'FOO BAR', 'variables were interpolated');
};

{ # "" variation
    my @q = ();
        @q = "$foo $bar";
    is(+@q, 1, '"" is singular');
    is(@q[0], "FOO BAR", '"" interpolates');
};

# L<S02/C<Q> forms/:qq>
{ # adverb variation
    my @q = ();
    @q = Q:qq/$foo $bar/;
    is(+@q, 1, "Q:qq// is singular");
    is(@q[0], "FOO BAR", "blah blah interp");
};

# L<S02/Interpolating into a single-quoted string/using the \qq>

{ # \qq[] constructs interpolate in q[]
    my ( @q1, @q2, @q3, @q4 ) = ();
    @q1 = q[$foo \qq[$bar]];
    is(+@q1, 1, "q[...\\qq[...]...] is singular");
    is(@q1[0], '$foo BAR', "and interpolates correctly");

    @q2 = '$foo \qq[$bar]';
    is(+@q2, 1, "'...\\qq[...]...' is singular");
    is(@q2[0], '$foo BAR', "and interpolates correctly");

    @q3 = q[$foo \q:s{$bar}];
    is(+@q3, 1, 'q[...\\q:s{...}...] is singular');
    is(@q3[0], '$foo BAR', "and interpolates correctly");

    @q4 = q{$foo \q/$bar/};
    is(+@q4, 1, 'q{...\\q/.../...} is singular');
    is(@q4[0], '$foo $bar', "and interpolates correctly");
}

# quote with \0 as delimiters
{
    is EVAL("(q\0foo bar\0)"), 'foo bar', 'OK';
}

{ # traditional quote word
    my @q = ();
    @q = (qw/$foo $bar/);
    is(+@q, 2, "qw// is plural");
    is(@q[0], '$foo', "and non interpolating");
    is(@q[1], '$bar', "...");
};

# L<S02/Quoting forms/quote operator now has a bracketed form>
{ # angle brackets
    my @q = ();
    @q = <$foo $bar>;
    is(+@q, 2, "<> behaves the same way");
    is(@q[0], '$foo', 'for interpolation too');
    is(@q[1], '$bar', '...');
};

{ # angle brackets
    my @q = ();
    @q = < $foo $bar >;
    is(+@q, 2, "<> behaves the same way, with leading (and trailing) whitespace");
    is(@q[0], '$foo', 'for interpolation too');
    is(@q[1], '$bar', '...');
};


{ # adverb variation
    my @q = ();
    @q = (q:w/$foo $bar/);
    is(+@q, 2, "q:w// is like <>");
    is(@q[0], '$foo', "...");
    is(@q[1], '$bar', "...");
};

{ # whitespace sep aration does not break quote constructor
  # L<S02/Whitespace before adverbs/Whitespace is allowed between the "q" and its adverb: q :w /.../.>
    my @q = ();
    @q = (q :w /$foo $bar/);
    is(+@q, 2, "q :w // is the same as q:w//");
    is(@q[0], '$foo', "...");
    is(@q[1], '$bar', "...");
};

{ # qq:w,Interpolating quote constructor with words adverb
  # L<S02/Adverbs on quotes/"Split result on words (no quote protection)">
    my (@q1, @q2) = ();
    @q1 = qq:w/$foo "gorch $bar"/;
    @q2 = qq:words/$foo "gorch $bar"/;

    is(+@q1, 3, 'qq:w// correct number of elements');
    is(+@q2, 3, 'qq:words correct number of elements');

    is(~@q1, 'FOO "gorch BAR"', "explicit quote word interpolates");
    is(~@q2, 'FOO "gorch BAR"', "long form output is the same as the short");
};

{ # qq:ww, interpolating L<S02/Literals/double angles do interpolate>
  # L<S02/Forcing item context/"implicit split" "shell-like fashion">
    my (@q1, @q2, @q3, @q4) = ();
    @q1 = qq:ww/$foo "gorch $bar"/;
    @q2 = «$foo "gorch $bar"»; # french
    @q3 = <<$foo "gorch $bar">>; # ASCII
    @q4 = qq:quotewords/$foo "gorch $bar"/; # long

    is(+@q1, 2, 'qq:ww// correct number of elements');
    is(+@q2, 2, 'french double angle');
    is(+@q3, 2, 'ASCII double angle');
    is(+@q4, 2, 'long form');

    is(~@q1, 'FOO gorch BAR', "explicit quote word interpolates");
    is(~@q2, 'FOO gorch BAR', "output is the same as french");

    # L<S02/Adverbs on quotes/"the built-in «...» quoter automatically does interpolation equivalent to qq:ww/.../">
    is(~@q3, 'FOO gorch BAR', ", ASCII quotes");
    is(~@q4, 'FOO gorch BAR', ", and long form");
}

{
    is (try EVAL "« one #`[[[comment]]] two »"), "one two", "«» handles embedded comments";
    is (try EVAL "« one #`«comment» two »"), "one two", "«» handles embedded comments containing french quotes";
    is (try EVAL "<< one #`<<comment>> two >>"), "one two", "<<>> handles embedded comments containing ASCII quotes";
    is (try EVAL "« one #comment\n two »"), "one two", "«» handles line-end comments";
}

{
    my $rt65654 = 'two words';
    is «a $rt65654 z».flat.elems,   4, 'interpolate variable with spaces (French)';
    is <<a $rt65654 z>>.flat.elems, 4, 'interpolate variable with spaces (ASCII)';
}

{
    #L<S02/Forcing item context/"relationship" "single quotes" "double angles">
    my ($x, $y) = <a b>;
    ok(«$x $y» eq <a b>, "«$x $y» interpolation works correctly");
};


# L<S02/Forcing item context/respects quotes in a shell-like fashion>
{ # qw, interpolating, shell quoting
    my (@q1, @q2) = ();
    my $gorch = "foo bar";

    @q1 = «$foo $gorch $bar»;
    is(+@q1, 4, "4 elements in unquoted «» list");
    is(@q1[2], "bar", '$gorch was exploded');
    is(@q1[3], "BAR", '$bar was interpolated');

    @q2 = «$foo "$gorch" '$bar'»;
    is(+@q2, 3, "3 elements in sub quoted «» list");
    is(@q2[1], $gorch, 'second element is both parts of $gorch, interpolated');
    is(@q2[2], '$bar', 'single quoted $bar was not interpolated');
};

{
    my $gorch = "foo bar";
    my @q := «a b c "$foo" f g $gorch m n '$bar' x y z»;
    is(+@q, 14, "14 elements in mixed quoted/unquoted «» list, non-flattened");
    is(@q[0], 'a', 'unquoted words are split correctly in the presence of quotes');
    is(@q[3], $foo, 'first interpolation is $foo');
    is(@q[4], 'f', 'unquoted between quotes is split correctly');
    is(@q[6], "foo", 'Unquoted variable\'s first word interpolated correctly');
    is(@q[7], "bar", 'Unquoted variable\'s second word interpolated correctly');
    is(@q[9], 'n', 'unquoted between quotes is split correctly');
    is(@q[10], '$bar', 'single quoted $bar was not interpolated');
    is(@q[13], 'z', 'trailing unquoted words are split correctly in the presence of quotes');
};

{ # Q L<S02/Literals/No escapes at all>
    my @q = ();

    @q = (Q/foo\\bar$foo/);

    is(+@q, 1, "Q// is singular");
    is(@q[0], "foo\\\\bar\$foo", "special chars are meaningless"); # double quoting is to be more explicit
};

# L<S02/Forcing item context/"Pair" notation is also recognized inside>
{
  # <<:Pair>>
    my @q = <<:p(1)>>;
    is(@q[0].perl, (:p(1)).perl, "pair inside <<>>-quotes - simple");

    @q = <<:p(1) junk>>;
    is(@q[0].perl, (:p(1)).perl, "pair inside <<>>-quotes - with some junk");
    is(@q[1], 'junk', "pair inside <<>>-quotes - junk preserved");

    @q = <<:def>>;
    is(@q[0].perl, (:def).perl, ":pair in <<>>-quotes with no explicit value");

    @q = "(EVAL failed)";
    try { EVAL '@q = <<:p<moose>>>;' };
    is(@q[0].perl, (p => "moose").perl, ":pair<anglequoted>");
};

{ # weird char escape sequences
    is("\c97", "a", '\c97 is "a"');
    is("\c102oo", "foo", '\c102 is "f", works next to other letters');

    is("\c123", chr(123), '"\cXXX" and chr XXX are equivalent');
    is("\c[12]3", chr(12) ~ "3", '\c[12]3 is the same as chr(12) concatenated with "3"');
    is("\c[12] 3", chr(12) ~ " 3", 'respects spaces when interpolating a space character');
    is("\c[13,10]", chr(13) ~ chr(10), 'allows multiple chars');

    is("\x41", "A", 'hex interpolation - \x41 is "A"');
    is("\o101", "A", 'octal interpolation - \o101 is also "A"' );

    is("\c@", "\0", 'Unicode code point "@" converts correctly to "\0"');
    is("\cA", chr(1), 'Unicode "A" is #1!');
    is("\cZ", chr(26), 'Unicode "Z" is chr 26 (or \c26)');
}

{ # simple test for nested-bracket quoting, per S02
    my $hi = q<<hi>>;
    is($hi, "hi", 'q<<hi>> is "hi"');
}

is( q<< <<woot>> >>, ' <<woot>> ', 'nested <<ASCII>> quotes (RT #66888)' );

# L<S02/Adverbs on quotes/"for user-defined quotes">
# q:to
{
    my $t;
    $t = q:to /STREAM/;
Hello, World
STREAM

    is $t.subst("\r\n", "\n", :g), "Hello, World\n", "Testing for q:to operator.";

$t = q:to /结束/;
Hello, World
结束

    is $t.subst("\r\n", "\n", :g), "Hello, World\n", "Testing for q:to operator. (utf8)";
}

# Q
{
    my $s1 = "hello"; #OK not used
    my $t1 = Q /$s1, world/;
    is $t1, '$s1, world', "Testing for Q operator.";

    my $s2 = "你好"; #OK not used
    my $t2 = Q /$s2, 世界/;
    is $t2, '$s2, 世界', "Testing for Q operator. (utf8)";
}

# q:b
{
    my $t = q:b /\n\n\n/;
    is $t, "\n\n\n", "Testing for q:b operator.";
    is q:b'\n\n', "\n\n", "Testing q:b'\\n'";
    ok qb"\n\t".chars == 2, 'qb';
    is Qb{a\nb},  "a\nb", 'Qb';
    is Q:b{a\nb}, "a\nb", 'Q:b';
    is Qs:b{\n},  "\n",   'Qs:b';
}

# q:x
{
    # due to automatic newline translation, no need to check for \r\n on win32
    my $result = "hello\n";
    is q:x/echo hello/, $result, "Testing for q:x operator.";
}
# utf8

{
    # 一 means "One" in Chinese.
    $*DISTRO.is-win and q:x/chcp 65001/; # set utf8 on cmd.exe
    is q:x/echo 一/, "一\n", "Testing for q:x operator. (utf8)";
}

{
    my $world = 'world';
    ok qq:x/echo hello $world/ ~~ /^'hello world'\n$/, 'Testing qq:x operator';
}

{
    my $output = $*DISTRO.is-win
        ?? q:x/echo hello& echo world/
        !! q:x/echo hello; echo world/;
    my @two_lines = $output.trim-trailing.lines;
    is @two_lines, ["hello", "world"], 'testing q:x assigned to array';
}

{
    my $hello = 'howdy';
    my $sep = $*DISTRO.is-win ?? '&' !! ';';
    my @two_lines = qq:x/echo $hello$sep echo world/.trim-trailing.lines;
    is @two_lines, ["$hello", "world"], 'testing qq:x assigned to array';
}


# L<S02/Adverbs on quotes/"Interpolate % vars">
# q:h
{
    my %t = (a => "perl", b => "rocks");
    my $s;
    $s = q:h /%t<>/;
    is $s, ~%t, "Testing for q:h operator.";
}

# q:f
{
    my sub f { "hello" };
    my $t = q:f /&f(), world/;
    is $t, f() ~ ", world", "Testing for q:f operator.";

    sub f_utf8 { "你好" };
    $t = q:f /&f_utf8(), 世界/;
    is $t, f_utf8() ~ ", 世界", "Testing for q:f operator. (utf8)";
}

# q:c
{
    my sub f { "hello" };
    my $t = q:c /{f}, world/;
    is $t, f() ~ ", world", "Testing for q:c operator.";
}

# q:a
{
    my @t = qw/a b c/;
    my $s = q:a /@t[]/;
    is $s, ~@t, "Testing for q:a operator.";
}

# q:s
{
    my $s = "someone is laughing";
    my $t = q:s /$s/;
    is $t, $s, "Testing for q:s operator.";

    $s = "有人在笑";
    $t = q:s /$s/;
    is $t, $s, "Testing for q:s operator. (utf8)";
}

# multiple quoting modes
{
    my $s = 'string';
    my @a = <arr1 arr2>;
    my %h = (foo => 'bar'); #OK not used
    is(q:s:a'$s@a[]%h', $s ~ @a ~ '%h', 'multiple modifiers interpolate only what is expected');
}

# shorthands:
{
    my $alpha = 'foo';
    my $beta  = 'bar';
    my @delta = <baz qux>;
    my %gamma = (abc => 123);
    sub zeta {42};

    is(qw[a b], <a b>, 'qw');
    is(qqww[$alpha $beta], <foo bar>, 'qqww');
    is(qq[$alpha $beta], 'foo bar', 'qq');
    is(Qs[$alpha @delta[] %gamma<>], 'foo @delta[] %gamma<>', 'Qs');
    is(Qa[$alpha @delta[] %gamma<>], '$alpha ' ~ @delta ~ ' %gamma<>', 'Qa');
    is(Qh[$alpha @delta[] %gamma<>], '$alpha @delta[] ' ~ %gamma, 'Qh');
    is(Qf[$alpha &zeta()], '$alpha 42', 'Qf');
    is(Qb[$alpha\t$beta], '$alpha	$beta', 'Qb');
    is(Qc[{1+1}], 2, 'Qc');
    is(Qw["a b" \ {1+1}], ('"a', 'b"', '\\', '{1+1}'), 'Qw');
    is(Q:w[a b \ {1+1}], ('a', 'b', '\\', '{1+1}'), 'Q:w');
    is(Qww["a b" \ {1+1}], ( 'a b', '\\', '{1+1}'), 'Qww');
}

# L<S02/Backslashing/All other quoting forms (including standard single quotes)>
{
    is('test\\', "test\\", "backslashes at end of single quoted string");
    is 'a\\b\''.chars, 4, 'backslash and single quote';
}

{
    isa-ok rx/foo/, Regex, 'rx/.../';
    isa-ok rx{foo}, Regex, 'rx{...}';
    isa-ok rx:i{foo}, Regex, 'rx:i{...}';
    isa-ok rx:ignorecase{foo}, Regex, 'rx:i{...}';
    isa-ok rx:s{foo}, Regex, 'rx:i{...}';
    isa-ok rx:sigspace{foo}, Regex, 'rx:i{...}';
    throws-like { EVAL 'rx:unknown{foo}' },
      X::Syntax::Regex::Adverb,
      'rx:unknown dies';
    throws-like { EVAL 'rx:g{foo}' },
      X::Syntax::Regex::Adverb,
      'g does not make sense on rx//';
}

{
    my $var = 'world';
    is  qx/echo world/.chomp, "world", 'qx';
    is qqx/echo $var/.chomp,  "world", 'qqx';
    is  Qx[echo '\\\\'] cmp qx[echo '\\\\\\\\'], Same, 'Qx treats backslash literally, qx treats \\ as one backslash';

    # RT #78874
    is qx/echo world/.trans('wd' => 'WD').chomp, "WorlD", "qx doesn't return a Parrot string";
}

# RT #120529
{
    %*ENV<ENV_P6_SPECTEST_120529>='foo';
    my $check = $*DISTRO.is-win ?? qx/set/ !! qx/env/;
    ok $check ~~ /ENV_P6_SPECTEST_120529/, 'qx passes environmental variables';
}

# RT #75320
{
    is "$foo >>", "FOO >>", 'quoting and >> (RT #75320, 1)';
    is "$foo>>",  "FOO>>",  'quoting and >> (RT #75320, 2)';
}

# RT #85506
{
    my $a = 42;
    is "$a [<file>]", '42 [<file>]', 'can handle [ after whitespace after var interpolation';
}

# RT #90124
throws-like { EVAL q["@a<"] },
  X::Comp,
  'unclosed quote after array variable is an error';

# RT #114090
is "foo $( my $x = 3 + 4; "bar" ) baz", 'foo bar baz', 'declaration in interpolation';

#115272
is <<<\>'n'>>.join('|'), '<>|n', 'ASCII quotes edge case';

{
    $_ = 'abc';
    /a./;
    is $/, 'ab', '/.../ literals match in void context';
    # rx does the same: http://irclog.perlgeek.de/perl8/2013-02-20#i_6479200
    rx/b./;
    is $/, 'bc', 'rx/.../ literals match in void context';
}

# RT #75320
{
    my $x = 42;
    is "$x >> ", "42 >> ", '>> in interpolation is not shift operator';
}

# (RT #83952 is wrong about \cI being an error)
is "\cIa", "\ta", '\cI is a TAB';
is "\c?a", "\x[7f]a", '\c? is a DEL';
is "\c@a", "\0a", '\c@ is a NUL';

{
    throws-like { EVAL 'q< < >' },
      X::Comp,
      "Unmatched openers and closers fails to parse";
    is q< \> >, " > ", "Escaped closer produces the opener unescaped";
    is q< \< >, " < ", "Escaped opener produces the opener unescaped";
}

# RT #125995
{
    sub a(**@a) { @a.elems }
    my $res = a << a b >>;
    is $res, 1, '<< a b >> does not accidentally flatten into arg list';
}

# RT #120788
is q :heredoc :c "EOF", "2+3=5\n", ':c applied after :heredoc has effect';
    2+3={2+3}
    EOF
is q :heredoc :w "EOF", <omg wtf bbq amazing cat>, ':w applied after :heredoc has effect';
    omg wtf bbq
    amazing cat
    EOF

# RT #125543
{
    my $warned = 0;
    EVAL Q:to/CODE_END/;
        my $here = qq:to/END_TEXT/;
        foo\nbar
        END_TEXT
    CODE_END
    CONTROL {
        when CX::Warn {
            $warned = 1;
            .resume;
        }
    }
    nok $warned, '\n in a heredoc does not factor into dedenting';
}
{
    my $warned = 0;
    EVAL Q:to/CODE_END/;
        my $here = qq:to/END_TEXT/;
        foo\r\nbar
        END_TEXT
    CODE_END
    CONTROL {
        when CX::Warn {
            $warned = 1;
            .resume;
        }
    }
    nok $warned, '\r\n in a heredoc does not factor dedenting';
}

# RT #120895
ok qq:to/EOF/ ~~ /\t/, '\t in heredoc does not turn into spaces';
    \thello
    EOF

# RT #123808
{
    my $a = 42;
    for (<<$a b c>>, qqww{$a b c}, qqw{$a b c}).kv -> $i, $_ {
        ok .WHAT === List, "word-split qouting constructs return List ($i)";
    }
}

# RT #128304
{
    is-deeply qww<a a ‘b b’ ‚b b’ ’b b‘ ’b b‘ ’b b’ ‚b b‘ ‚b b’ “b b” „b b”
            ”b b“ ”b b“ ”b b” „b b“ „b b” ｢b b｣ ｢b b｣>,
        ('a', 'a', |('b b' xx 16)),
    'fancy quotes in qww work just like regular quotes';
}

{
    is_run 'qx=' ~ $*EXECUTABLE ~  ' -e 42.note=',
        {:err("42\n"), :out(''), :0status}, 'qx passes STDERR through';
}

# https://irclog.perlgeek.de/perl6-dev/2017-06-16#i_14744333
{
    diag 'The following test might STDERR about unfound command';
    lives-ok { qx/the-cake-is-a-lie-badfsadsadsadasdsadasdsadsadasdsadas/ },
      'qx// with a non-existent command does not die';
}

# vim: ft=perl6
