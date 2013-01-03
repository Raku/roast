use v6;
use Test;
plan 155;

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

#?pugs skip 'parsefail'
{
    is Q{\n},        '\n',          'Q{..} do not interpolate \n';
    ok Q{\n}.chars == 2,            'Q{..} do not interpolate \n';
    is Q{$x},        '$x',          'Q{..} do not interpolate scalars';
    ok Q{$x}.chars == 2,            'Q{..} do not interpolate scalars';
    is Q {\\},       '\\\\',        'Q {..} quoting';
}

#?pugs skip 'parsefail'
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
#?pugs skip 'parsefail'
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
#?pugs skip 'parsefail'
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

# quote with \0 as delimiters, forbidden by STD
# but see L<news:20050101220112.GF25432@plum.flirble.org>
#?rakudo todo 'retriage'
#?pugs todo
{
    eval_dies_ok "(q\0foo bar\0)";
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

#?niecza todo
{ # qq:ww, interpolating L<S02/Literals/double angles do interpolate>
  # L<S02/Forcing item context/"implicit split" "shell-like fashion">
    my (@q1, @q2, @q3, @q4) = ();
    @q1 = qq:ww/$foo "gorch $bar"/;
    @q2 = «$foo "gorch $bar"»; # french
    @q3 = <<$foo "gorch $bar">>; # texas
    @q4 = qq:quotewords/$foo "gorch $bar"/; # long

    is(+@q1, 2, 'qq:ww// correct number of elements');
    is(+@q2, 2, 'french double angle');
    is(+@q3, 2, 'texas double angle');
    is(+@q4, 2, 'long form');

    is(~@q1, 'FOO gorch BAR', "explicit quote word interpolates");
    is(~@q2, 'FOO gorch BAR', "output is the same as french");

    # L<S02/Adverbs on quotes/"the built-in «...» quoter automatically does interpolation equivalent to qq:ww/.../">
    is(~@q3, 'FOO gorch BAR', ", texas quotes");
    is(~@q4, 'FOO gorch BAR', ", and long form");
};

{
    my $rt65654 = 'two words';
    is «a $rt65654 z».elems,   4, 'interpolate variable with spaces (French)';
    is <<a $rt65654 z>>.elems, 4, 'interpolate variable with spaces (Texas)';
}

#?rakudo todo '«...»'
#?niecza todo
{
    #L<S02/Forcing item context/"relationship" "single quotes" "double angles">
    # Pugs was having trouble with this.  Fixed in r12785.
    my ($x, $y) = <a b>;
    ok(«$x $y» === <a b>, "«$x $y» interpolation works correctly");
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
    #?niecza 3 todo
    is(+@q2, 3, "3 elementes in sub quoted «» list");
    is(@q2[1], $gorch, 'second element is both parts of $gorch, interpolated');
    is(@q2[2], '$bar', 'single quoted $bar was not interpolated');
};

# L<S02/Heredocs/Heredocs are no longer written>
{ # qq:to
    my @q = ();

    @q = qq:to/FOO/;
blah
$bar
blah
$foo
FOO

    is(+@q, 1, "q:to// is singular");
    is(@q[0].subst(/\r/, '', :g), "blah\nBAR\nblah\nFOO\n", "here doc interpolated");
};

{ # qq:to
    my @q = ();

    @q = qq:to/FOO/;
        blah
        $bar
        blah
        $foo
        FOO

    is(@q[0].subst(/\r/, '', :g), "blah\nBAR\nblah\nFOO\n", "here doc interpolating with indentation");
};

# L<S02/Optional whitespace/Heredocs allow optional whitespace>
{ # q:to indented
    my @q = ();

    @q = q:to/FOO/;
        blah blah
        $foo
        FOO

    is(+@q, 1, "q:to// is singular, also when indented");
    is(@q[0].subst(/\r/, '', :g), "blah blah\n\$foo\n", "indentation stripped");
};

{ # q:heredoc backslash bug
        my @q = q:heredoc/FOO/
yoink\n
splort\\n
FOO
;
        is(+@q, 1, "q:heredoc// is singular");
        is(@q[0].subst(/\r/, '', :g), "yoink\\n\nsplort\\n\n", "backslashes");
}

#?pugs skip 'parsefail'
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
    #?niecza todo
    #?pugs todo
    is(@q[0].perl, (:p(1)).perl, "pair inside <<>>-quotes - simple");

    @q = <<:p(1) junk>>;
    #?niecza todo
    #?pugs todo
    is(@q[0].perl, (:p(1)).perl, "pair inside <<>>-quotes - with some junk");
    is(@q[1], 'junk', "pair inside <<>>-quotes - junk preserved");

    @q = <<:def>>;
    #?niecza todo
    #?pugs todo
    is(@q[0].perl, (:def).perl, ":pair in <<>>-quotes with no explicit value");

    @q = "(eval failed)";
    try { eval '@q = <<:p<moose>>>;' };
    #?niecza todo
    #?pugs todo
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
    
    #?rakudo 3 skip '\c@ etc'
    is("\c@", "\0", 'Unicode code point "@" converts correctly to "\0"');
    is("\cA", chr(1), 'Unicode "A" is #1!');
    is("\cZ", chr(26), 'Unicode "Z" is chr 26 (or \c26)');
}

{ # simple test for nested-bracket quoting, per S02
    my $hi = q<<hi>>;
    is($hi, "hi", 'q<<hi>> is "hi"');
}

is( q<< <<woot>> >>, ' <<woot>> ', 'nested <<texas>> quotes (RT #66888)' );

# L<S02/Adverbs on quotes/"for user-defined quotes">
# q:to
{
    my $t;
    $t = q:to /STREAM/;
Hello, World
STREAM

    is $t.subst(/\r/, '', :g), "Hello, World\n", "Testing for q:to operator.";

$t = q:to /结束/;
Hello, World
结束

    is $t.subst(/\r/, '', :g), "Hello, World\n", "Testing for q:to operator. (utf8)";
}

# Q
#?pugs skip 'Q'
{
    my $s1 = "hello"; #OK not used
    my $t1 = Q /$s1, world/;
    is $t1, '$s1, world', "Testing for Q operator.";

    my $s2 = "你好"; #OK not used
    my $t2 = Q /$s2, 世界/;
    is $t2, '$s2, 世界', "Testing for Q operator. (utf8)";
}

# q:b
#?pugs skip 'parsefail'
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
    my $result = $*OS ~~ /:i win32/ ?? "hello\r\n" !! "hello\n";
    is q:x/echo hello/, $result, "Testing for q:x operator.";
}
# utf8

{
    # 一 means "One" in Chinese.
    is q:x/echo 一/, "一\n", "Testing for q:x operator. (utf8)";
}

{
    my $world = 'world';
    ok qq:x/echo hello $world/ ~~ /^'hello world'\n$/, 'Testing qq:x operator';
}

#?rakudo todo 'q:x assigned to array'
#?niecza todo ':x'
#?pugs todo
{
    my @two_lines = q:x/echo hello ; echo world/;
    is @two_lines, ("hello\n", "world\n"), 'testing q:x assigned to array';
}

#?rakudo todo 'q:x assigned to array'
#?niecza todo ':x'
#?pugs todo
{
    my $hello = 'howdy';
    my @two_lines = qq:x/echo $hello ; echo world/;
    is @two_lines, ("$hello\n", "world\n"), 'testing qq:x assigned to array';
}


# L<S02/Adverbs on quotes/"Interpolate % vars">
# q:h
#?niecza todo
{
    # Pugs can't parse q:h currently.
    my %t = (a => "perl", b => "rocks");
    my $s;
    $s = q:h /%t<>/;
    is $s, ~%t, "Testing for q:h operator.";
}

# q:f
#?niecza skip '& escape'
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
#?rakudo skip 'quoting adverbs'
#?niecza skip '& escape, zen slices'
#?pugs skip 'parsefail'
{
    my $alpha = 'foo';
    my $beta  = 'bar';
    my @delta = <baz qux>;
    my %gamma = (abc => 123);
    sub zeta {42};

    is(qw[a b], <a b>, 'qw');
    is(qww[$alpha $beta], <foo bar>, 'qww');
    is(qq[$alpha $beta], 'foo bar', 'qq');
    is(Qs[$alpha @delta[] %gamma<>], 'foo @delta %gamma', 'Qs');
    is(Qa[$alpha @delta[] %gamma<>], '$alpha ' ~ @delta ~ ' %gamma', 'Qa');
    is(Qh[$alpha @delta[] %gamma<>], '$alpha @delta ' ~ %gamma, 'Qh');
    is(Qf[$alpha &zeta()], '$alpha 42', 'Qf');
    is(Qb[$alpha\t$beta], '$alpha	$beta', 'Qb');
    is(Qc[{1+1}], 2, 'Qc');
}

# L<S02/Backslashing/All other quoting forms (including standard single quotes)>
{
    is('test\\', "test\\", "backslashes at end of single quoted string");
    is 'a\\b\''.chars, 4, 'backslash and single quote';
}

{
    isa_ok rx/foo/, Regex, 'rx/.../';
    isa_ok rx{foo}, Regex, 'rx{...}';
    isa_ok rx:i{foo}, Regex, 'rx:i{...}';
    isa_ok rx:ignorecase{foo}, Regex, 'rx:i{...}';
    isa_ok rx:s{foo}, Regex, 'rx:i{...}';
    isa_ok rx:sigspace{foo}, Regex, 'rx:i{...}';
    #?pugs todo
    eval_dies_ok 'rx:unknown{foo}', 'rx:unknown dies';
    #?pugs todo
    eval_dies_ok 'rx:g{foo}', 'g does not make sense on rx//';
}

{
    my $var = 'world';
    is  qx/echo world/.chomp, "world", 'qx';
    #?pugs skip 'multi ok'
    is qqx/echo $var/.chomp,  "world", 'qqx';
    # RT #78874
    is qx/echo world/.trans('wd' => 'WD').chomp, "WorlD", "qx doesn't return a Parrot string";
}

# RT #75320
{
    is "$foo >>", "FOO >>", 'quoting and >> (RT 75320, 1)';
    is "$foo>>",  "FOO>>",  'quoting and >> (RT 75320, 2)';
}

done;

# vim: ft=perl6
