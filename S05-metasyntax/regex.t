use v6;
use lib <t/spec/packages/>;
use Test;
use Test::Util;

plan 49;

throws-like 'qr/foo/', X::Obsolete, 'qr// is gone';

isa-ok(rx/oo/, Regex);
isa-ok(rx (o), Regex);
throws-like 'rx(o)', X::Undeclared::Symbols,
    'rx () requires whitespace if the delims are parens';
isa-ok(regex {oo}, Regex);

throws-like 'rx :foo:', Exception, 'colons are not allowed as rx delimiters';

lives-ok { my Regex $x = rx/foo/ }, 'Can store regexes in typed variables';

{
    my $var = /foo/;
    isa-ok($var, Regex, '$var = /foo/ returns a Regex object');
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

{
    $_ = 'foo';
    ok ?/foo/,     'does    ?/foo/      work';
    is ~$/, 'foo', 'did it set $/ (1)';

    $_ = 'goo';
    ok so /goo/,   'does  so /goo/      work';
    is ~$/, 'goo', 'did it set $/ (2)';

    $_ = 'hoo';
    nok !/hoo/,    'does    !/hoo/      work';
    is ~$/, 'hoo', 'did it set $/ (3)';

    $_ = 'ioo';
    nok not /ioo/, 'does not /ioo/      work';
    is ~$/, 'ioo', 'did it set $/ (4)';

    $_ = 'joo';
    ok /joo/.Bool, 'does     /joo/.Bool work';
    is ~$/, 'joo', 'did it set $/ (5)';
}

# we'll just check that this syntax is valid for now
{
    eval-lives-ok('token foo {bar}', 'token foo {...} is valid');
    eval-lives-ok('regex baz {qux}', 'regex foo {...} is valid');
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

throws-like q['x' ~~ m/RT (#)67612 /], X::Comp::Group, 'commented capture end = parse error';

# L<S05/Simplified lexical parsing of patterns/The semicolon character>

throws-like 'rx/;/', X::Syntax::Regex::UnrecognizedMetachar,
    'bare ";" in rx is not allowed';
throws-like q{';' ~~ /;/}, X::Syntax::Regex::UnrecognizedMetachar,
    'bare ";" in match is not allowed';
isa-ok rx/\;/, Regex,       'escaped ";" in rx// works';
ok ';' ~~ /\;/,             'escaped ";" in m// works';

# RT #64668
{
    try { EVAL '"RT #64668" ~~ /<nosuchrule>/' };
    ok  $!  ~~ Exception, 'use of missing named rule dies';
    ok "$!" ~~ /nosuchrule/, 'error message mentions the missing rule';
}

eval-lives-ok '/<[..b]>/', '/<[..b]>/ lives';

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

# RT #125302
throws-like 'Regex.new.perl', Exception, '"Regex.new.perl dies but does not segfault';

# RT #77524
ok 'a' ~~ /a:/, '/a:/ is a valid pattern and matches a';
ok 'a' ~~ /a: /, '/a: / is a valid pattern and matches a';

{ # RT #128986
    throws-like '/\b/', X::Obsolete, 'bare \b is no longer supported';
    throws-like '/\B/', X::Obsolete, 'bare \B is no longer supported';
    ok "\b" ~~ /"\b"/, '\b still works when quoted';
    ok "\b" ~~ /<[\b]>/, '\b still works in character class';
    is ("a\bc" ~~ m:g/<[\B]>/).join, 'ac', '\B still works in character class';
}

# RT #130911
# RT #130127
# RT #130125
# RT #130124
subtest '`**` quantifier' => {
    plan 6;

    #?DOES 1
    sub is-len (UInt $len, $quant) {
        $*frugal ?? cmp-ok "xxxxx".match(/x **? {$quant}/).chars,
                    '==', $len, "$quant.perl() matches $len chars (frugal)"
                 !! cmp-ok "xxxxx".match(/x **  {$quant}/).chars,
                    '==', $len, "$quant.perl() matches $len chars (greedy)";
    }

    #?DOES 1
    sub is-no-match ($quant) {
        $*frugal ?? cmp-ok "xxxxx".match(/x **? {$quant}/),
                    '===', Nil, "$quant.perl() does not match (frugal)"
                 !! cmp-ok "xxxxx".match(/x **  {$quant}/),
                    '===', Nil, "$quant.perl() does not match (greedy)";
    }

    #?DOES 1
    sub does-match-throw ($quant, |c) {
        $*frugal ?? throws-like { "xxxxx".match(/x **? {$quant}/) },
                    X::Syntax::Regex::QuantifierValue, |c,
                    "$quant.perl() throws (frugal)"
                 !! throws-like { "xxxxx".match(/x **  {$quant}/) },
                    X::Syntax::Regex::QuantifierValue, |c,
                    "$quant.perl() throws (greedy)";
    }

    subtest 'greedy' => {
        plan 28;

        is-len 3,     1 .. 3;          is-len 2,     1 ..^3;
        is-len 2,     1^..^3;          is-len 2,    -∞^..^3;
        is-len 0,    -∞^..^-∞;         is-len 0,    -4^..^-3;
        is-len 3,    -∞^..3;           is-len 5,     1^..^∞;
        is-len 5,     1^..∞;           is-len 5,    -∞^..^∞;
        is-len 1,      1..1;           is-len 2,    1.7..2.2;
        is-len 2,  1.7e0..2.0e0;       is-len 2, 1.7e0^..^3.0e0;
        is-len 5,      5..^∞;          is-len 0,    -10..-5;

        is-len 3, 3;                   is-len 0, -5;
        is-len 0, -∞;

        is-no-match  10..20;           is-no-match  10..^20;
        is-no-match 10^..20;           is-no-match 10^..^20;
        is-no-match  10..∞;            is-no-match  10..^∞;
        is-no-match 10^..∞;            is-no-match 10^..^∞;
        is-no-match 10;
    }

    subtest 'frugal' => {
        plan 28;

        my $*frugal = 1;
        is-len 1,     1 .. 3;          is-len 1,     1 ..^3;
        is-len 2,     1^..^3;          is-len 0,    -∞^..^3;
        is-len 0,    -∞^..^-∞;         is-len 0,    -4^..^-3;
        is-len 0,    -∞^..3;           is-len 2,     1^..^∞;
        is-len 2,     1^..∞;           is-len 0,    -∞^..^∞;
        is-len 1,      1..1;           is-len 1,    1.7..2.2;
        is-len 1,  1.7e0..2.0e0;       is-len 2, 1.7e0^..^3.0e0;
        is-len 5,      5..^∞;          is-len 0,    -10..-5;

        is-len 3, 3;                   is-len 0, -5;
        is-len 0, -∞;

        is-no-match  10..20;           is-no-match  10..^20;
        is-no-match 10^..20;           is-no-match 10^..^20;
        is-no-match  10..∞;            is-no-match  10..^∞;
        is-no-match 10^..∞;            is-no-match 10^..^∞;
        is-no-match 10;
    }


    for :!frugal, :frugal -> (:key($), :value($*frugal)) {
        subtest $*frugal ?? 'frugal' !! 'greedy' => {
            plan 14;

            does-match-throw "x".."y",     :non-numeric-range;
            does-match-throw  42..NaN,     :non-numeric-range;
            does-match-throw NaN..42,      :non-numeric-range;
            does-match-throw <0/0>..<0/0>, :non-numeric-range;

            does-match-throw 5..4,         :empty-range;
            does-match-throw 4^..^5,       :empty-range;
            does-match-throw 4^..4,        :empty-range;
            does-match-throw 5..^5,        :empty-range;

            does-match-throw Inf..<1/0>,   :inf;
            does-match-throw Inf,          :inf;
            does-match-throw <1/0>,        :inf;

            does-match-throw <0/0>,        :non-numeric;
            does-match-throw "meow",       :non-numeric;
            does-match-throw NaN,          :non-numeric;
        }
    }

    throws-like ｢"xxxxx" ~~ /x **? 2..1/｣,
          X::Syntax::Regex::QuantifierValue, :empty-range,
    'block-less empty range throws (frugal)';

    throws-like ｢"xxxxx" ~~ /x **  2..1/｣,
          X::Syntax::Regex::QuantifierValue, :empty-range,
    'block-less empty range throws (greedy)';
}

is_run ｢(try "" ~~ /. ** {NaN}/) for ^1000; print 'pass'｣,
    {:out('pass'), :err(''), :0status},
'wrong value for `**` quantifier does not leave behind unhandled Failures';

# vim: ft=perl6
