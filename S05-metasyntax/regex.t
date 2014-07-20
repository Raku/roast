use v6;
use Test;

plan 29;

eval_dies_ok('qr/foo/', 'qr// is gone');

isa_ok(rx/oo/, Regex);
isa_ok(rx (o), Regex);
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
{
    $_ = "foo";
    my $mat_tern = /oo/ ?? "yes" !! "no"; 
    is($/, 'oo', 'matching should set match');
}

{
    $_ = 'foo';
    my $match = m{oo};
    is($match, 'oo', 'm{} always matches instead of making a Regex object');
}

{

    $_ = 'foo';
    my $match = m/oo/;
    is($match, 'oo', 'm{} always matches instead of making a Regex object');
}

# we'll just check that this syntax is valid for now
#?niecza todo 'invalid syntax'
{
    eval_lives_ok('token foo {bar}', 'token foo {...} is valid');
    eval_lives_ok('regex baz {qux}', 'regex foo {...} is valid');
}

{
    my regex alien { ET };
    my token archaeologist { Indiana };
    my rule food { pasta };

    ok 'ET phone home' ~~ m/<alien>/, 'named regex outside of a grammar works';
    ok 'Indiana has left the fridge' ~~ m/<archaeologist>/,
                                  'named token outside of a grammar works';
    ok 'mmm, pasta' ~~ m/<food>/, 'named rule outside of a grammar works';
}

ok Any !~~ / 'RT #67234' /, 'match against undefined does not match';

eval_dies_ok q['x' ~~ m/RT (#)67612 /], 'commented capture end = parse error';

# L<S05/Simplified lexical parsing of patterns/The semicolon character>

eval_dies_ok 'rx/;/',       'bare ";" in rx is not allowed';
eval_dies_ok q{';' ~~ /;/}, 'bare ";" in match is not allowed';
isa_ok rx/\;/, Regex,       'escaped ";" in rx// works';
ok ';' ~~ /\;/,             'escaped ";" in m// works';

# RT #64668
#?niecza skip 'Exception NYI'
{
    try { EVAL '"RT #64668" ~~ /<nosuchrule>/' };
    ok  $!  ~~ Exception, 'use of missing named rule dies';
    ok "$!" ~~ /nosuchrule/, 'error message mentions the missing rule';
}

#?niecza todo 'invalid syntax'
eval_lives_ok '/<[..b]>/', '/<[..b]>/ lives';

# RT #118985
{
    class HasSub {
        sub parse(Str $input) {
            my regex anything { . }
            42 if $input ~~ /<anything>/
        }
        method call-parse-sub(Str $input) {
            parse($input);
        }
    }

    class HasSubMethod {
        submethod parse(Str $input) {
            my regex anything { . }
            43 if $input ~~ /<anything>/
        }
    }

    class HasMethod {
        method parse(Str $input) {
            my regex anything { . }
            44 if $input ~~ /<anything>/
        }
    }

    is HasSub.call-parse-sub('foo'), 42, 'can have a lexical regex in a sub in a class';
    is HasSubMethod.parse('foo'),    43, 'can have a lexical regex in a submethod in a class';
    is HasMethod.parse('foo'),       44, 'can have a lexical regex in a method in a class';
}

# vim: ft=perl6
