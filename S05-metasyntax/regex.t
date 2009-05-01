use v6;
use Test;

plan 17;

# L<S05/Regexes are now first-class language, not strings>

eval_dies_ok('qr/foo/', 'qr// is gone');

isa_ok(rx/oo/, Regex);
isa_ok(rx (o), Regex);
#?rakudo skip 'rx() not detected'
eval_dies_ok('rx(o)', 'rx () whitespace if the delims are parens');
isa_ok(regex {oo}, Regex);

eval_dies_ok('rx :foo:', 'colons are not allowed as rx delimiters');

lives_ok { my Regex $x = rx/foo/ }, 'Can store regexes in typed variables';

{
    my $var = /foo/;
    isa_ok($var, Regex, '$var = /foo/ returns a Regex object');
}

# fairly directly from RT #61662
{
    $_ = "a";
    my $mat_tern_y = /a/ ?? "yes" !! "no";
    my $mat_tern_n = /b/ ?? "yes" !! "no";
    ok  $mat_tern_y eq 'yes' && $mat_tern_n eq 'no',
        'basic implicit topic match test';
}

# Note for RT - change to $_ ~~ /oo/ to fudge ok
#?rakudo todo 'RT #61662'
{
    $_ = "foo";
    my $mat_tern = /oo/ ?? "yes" !! "no"; 
    is($/, 'oo', 'matching should set match');
}

#?rakudo todo 'my $match = m{oo} does not match on $_'
{
    $_ = 'foo';
    my $match = m{oo};
    is($match, 'oo', 'm{} always matches instead of making a Regex object');
}

#?rakudo todo 'my $match = m/oo/ parsefail'
{

    $_ = 'foo';
    my $match = m/oo/;
    is($match, 'oo', 'm{} always matches instead of making a Regex object');
}

# we'll just check that this syntax is valid for now
{
    eval_lives_ok('token foo {bar}', 'token foo {...} is valid');
    eval_lives_ok('regex baz {qux}', 'regex foo {...} is valid');
}

{
    regex alien { ET };
    token archaeologist { Indiana };
    rule food { pasta };

    ok 'ET phone home' ~~ m/<alien>/, 'named regex outside of a grammar works';
    ok 'Indiana has left the fridge' ~~ m/<archaeologist>/,
                                  'named token outside of a grammar works';
    ok 'mmm, pasta' ~~ m/<food>/, 'named rule outside of a grammar works';
}
