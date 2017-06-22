use v6;

use Test;

plan 81;

# L<S32::Str/Str/=item comb>

# comb Str
is "".comb, (), 'comb on empty string';
is "a".comb, <a>, 'default matcher on single character';
is "abcd".comb, <a b c d>, 'default matcher and limit';

is "a\tb".comb, ('a', "\t", 'b'), 'comb on string with \t';
is "a\nb".comb, ('a', "\n", 'b'), 'comb on string with \n';

is "äbcd".comb, <ä b c d>, 'comb on string with non-ASCII letter';

#?rakudo.jvm 2 todo 'NFG on JVM RT #124737'
is "a\c[COMBINING DIAERESIS]b".comb, ("ä", "b",), 'comb on string with grapheme precomposed';
is( "a\c[COMBINING DOT ABOVE, COMBINING DOT BELOW]b".comb,
    ("a\c[COMBINING DOT BELOW, COMBINING DOT ABOVE]", "b", ),
    "comb on string with grapheme non-precomposed");


{
    my Str $hair = "Th3r3 4r3 s0m3 numb3rs 1n th1s str1ng";
    is $hair.comb(/\d+/), <3 3 4 3 0 3 3 1 1 1>, 'no limit returns all matches';
    is $hair.comb(/\d+/, -10).elems, 0, 'negative limit returns no matches';
    is $hair.comb(/\d+/, 0).elems, 0, 'limit of 0 returns no matches';
    is $hair.comb(/\d+/, 1), <3>, 'limit of 1 returns 1 match';
    is $hair.comb(/\d+/, 3), <3 3 4>, 'limit of 3 returns 3 matches';
    is $hair.comb(/\d+/, 1000000000), <3 3 4 3 0 3 3 1 1 1>, 'limit of 1 billion returns all matches quickly'; }

{
    is "a ab bc ad ba".comb(/«a\S*/), <a ab ad>,
        'match for any a* words';
    is "a ab bc ad ba".comb(/\S*a\S*/), <a ab ad ba>,
        'match for any *a* words';
}

{
    is "a ab bc ad ba".comb(/<< a\S*/), <a ab ad>,
        'match for any a* words';
    is "a ab bc ad ba".comb(/\S*a\S*/), <a ab ad ba>,
        'match for any *a* words';
}

is "a ab bc ad ba".comb(/\S*a\S*/, 2), <a ab>, 'matcher and limit';

is "forty-two".comb().join('|'), 'f|o|r|t|y|-|t|w|o', q{Str.comb(/./)};

ok("forty-two".comb() ~~ Iterable, '.comb() returns something Positional' );

# comb a list

#?rakudo skip 'cannot call match, no signature matches RT #124738'
is (<a ab>, <bc ad ba>).comb(m:Perl5/\S*a\S*/), <a ab ad ba>,
     'comb a list';

# needed: comb a filehandle

{
    my @l = 'a23 b c58'.comb(/\w(\d+)/);
    is @l.join('|'), 'a23|c58', 'basic comb-without-matches sanity';
    isa-ok(@l[0], Str, 'first item is a Str');
    isa-ok(@l[1], Str, 'second item is a Str');
}

{
    my @l = 'a23 b c58'.comb(/\w(\d+)/, :match);
    is @l.join('|'), 'a23|c58', 'basic comb-with-matches sanity';
    isa-ok(@l[0], Match, 'first item is a Match');
    isa-ok(@l[1], Match, 'second item is a Match');
    is @l[0].from, 0, '.from of the first item is correct';
    is @l[0].to, 3, '.to of the first item is correct';
    is @l[1].from, 6, '.from of the second item is correct';
    is @l[1].to, 9, '.to of the second item is correct';
}

# RT #66340
{
    my $expected_reason = rx:s/none of these signatures match/;

    my $calls = 0;
    try { 'RT #66340'.comb( { $calls++ } ) };
    is $calls, 0, 'code passed to .comb is not called';
    ok $! ~~ Exception, '.comb({...}) dies';
    ok "$!" ~~ $expected_reason, '.comb({...}) dies for the expected reason';
}

{
    is comb( /./ , "abcd"), <a b c d>, 'Subroutine form default limit';
    is comb(/./ , "abcd" , 2 ), <a b>, 'Subroutine form with supplied limit';
    is comb(/\d+/ , "Th3r3 4r3 s0m3 numb3rs 1n th1s str1ng"), <3 3 4 3 0 3 3 1 1 1>, 'Subroutine form with no limit returns all matches';
    is comb(/\d+/ , "Th3r3 4r3 s0m3 numb3rs 1n th1s str1ng" , 2), <3 3>, 'Subroutine form with limit';
}

# RT #123760
{
    #?rakudo.jvm 6 skip 'weird error, looks like wrong multi is used, RT #128580'
    is comb("o","ooo"), <o o o>, "comb(Str,Str)";
    is "qqq".comb("q"), <q q q>, "Str.comb(Str)";
    is "asdf".comb("z"), (), "Str.comb(Str) with no match";
    is "Bacon ipsum dolor amet t-bone cupim pastrami flank".comb("on"), <on on>, "Str.comb - partial match";
    is "Bacon ipsum dolor amet t-bone cupim pastrami flank".comb("on", 1), <on>, "Str.comb - partial match with a limit";
    is 3.14159265358979323.comb("3"), 3 xx 4 , "Cool.comb";
    is 3.14159265358979323.comb("3", 2), 3 xx 2 , "Cool.comb with a limit";
}

{
    sub test($str,$size,$result) {
        subtest {
            plan 2;
            is comb($size,$str), $result, "comb($size,$str)";
            is $str.comb($size),  $result, "$str\.comb($size)";
        }, "comb with \"$str\", size $size";
    }

    test( "foobarbaz", 10, <foobarbaz> );
    test( "foobarbaz",  9, <foobarbaz> );
    test( "foobarbaz",  8, <foobarba z> );
    test( "foobarbaz",  3, <foo bar baz> );
    test( "foobarbaz",  2, <fo ob ar ba z> );
    test( "foobarbaz",  1, <f o o b a r b a z> );
    test( "foobarbaz",  0, <f o o b a r b a z> );
    test( "foobarbaz", -1, <f o o b a r b a z> );
}

{
    sub test($str,$size,$result,$limit) {
        subtest {
            plan 2;
            is comb($size,$str), $result, "comb($size,$str)";
            is $str.comb($size),  $result, "$str\.comb($size)";
        }, "comb with \"$str\", size $size, limit $limit.perl()";
    }

    for *, Inf, 20 -> $times {
        test( "foobarbaz", 10, <foobarbaz>,         $times );
        test( "foobarbaz",  9, <foobarbaz>,         $times );
        test( "foobarbaz",  8, <foobarba z>,        $times );
        test( "foobarbaz",  3, <foo bar baz>,       $times );
        test( "foobarbaz",  2, <fo ob ar ba z>,     $times );
        test( "foobarbaz",  1, <f o o b a r b a z>, $times );
        test( "foobarbaz",  0, <f o o b a r b a z>, $times );
        test( "foobarbaz", -1, <f o o b a r b a z>, $times );
    }
}

# RT #127215
#?rakudo.jvm skip 'ordbaseat NYI'
eval-lives-ok ｢"hello".comb(/:m <[o]>/)｣,
    '.comb(/:m <[o]>/) construct does not die';

# https://github.com/rakudo/rakudo/commit/a08e953018
is-deeply 1337.comb(2), ('13', '37'), 'Cool.comb(Int)';

subtest 'edge-case combers' => {
    my @tests = gather {
        .take for
            ("abc", <a b c>.Seq, "",  ),
            ("abc", <a b c>.Seq, "", ∞),
            ("abc", <a b c>.Seq, "", 4),
            ("abc", <a b  >.Seq, "", 2),

            ("",         ().Seq, "",  ),
            ("",         ().Seq, "", ∞),
            ("",         ().Seq, "", 4),
            ("",         ().Seq, "", 2),

            ("abc", <a b c>.Seq, 0,   ),
            ("abc", <a b c>.Seq, 0,  ∞),
            ("abc", <a b c>.Seq, 0,  4),
            ("abc", <a b  >.Seq, 0,  2),

            ("",         ().Seq, 0,   ),
            ("",         ().Seq, 0,  ∞),
            ("",         ().Seq, 0,  4),
            ("",         ().Seq, 0,  2),
    }
    plan +@tests;
    for @tests -> ($str, $expected, |args) {
        #?rakudo.jvm skip 'Type check failed in binding to parameter "$pattern"; expected Regex but got Str ("")'
        is-deeply $str.comb(|args), $expected, "$str.perl() with {args.perl}";
    }
}

# vim: ft=perl6
