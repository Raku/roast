use v6;
use Test;

# this file should become the test for systematically testing
# Match objects. Exception: .caps and .chunks are tested in caps.t

plan 31;

ok 'ab12de' ~~ /\d+/,           'match successful';
is $/.WHAT, Match.WHAT,         'got right type';
ok $/.Bool,                     '.Bool';
ok $/.defined,                  '.defined';
is $/.Str,         '12',        '.Str';
is $/.from,           2,        '.from';
is $/.to,             4,        '.to';
is $/.prematch,    'ab',        '.prematch';
is $/.postmatch,   'de',        '.postmatch';
is $/.list.elems,     0,        '.list (empty)';
is $/.hash.elems,     0,        '.hash (empty)';
is $/.keys.elems,     0,        '.keys (empty)';
is $/.values.elems,   0,        '.values (empty)';
is $/.pairs.elems,    0,        '.pairs (empty)';
is $/.kv.elems,       0,        '.kv (empty)';

nok 'abde' ~~ /\d/,             'no match';
nok $/.Bool,                    'failed match is False';
is  $/.Str,          '',        'false match stringifies to empty string';

# Equality checks
is ('hey' ~~ /(.+)/) === ('foo' ~~ /(.+)/), False, '=== of different match objects';
is ('foo' ~~ /(.+)/) === ('foo' ~~ /(.+)/), False, '=== of different but similar match objects';
is $_ === $_, True, '=== of one and the same match object' with 'foo' ~~ /(.+)/;
is ('hey' ~~ /(.+)/) eqv ('foo' ~~ /(.+)/), False, 'eqv of different match objects';
is ('foo' ~~ /(.+)/) eqv ('foo' ~~ /(.+)/), True, 'eqv of different but similar match objects';

# RT #76998, cmp. http://perl6advent.wordpress.com/2013/12/17/
{
    my $res = do { 'abc' ~~ /a $<foo>=[\w+]/; :$<foo> };
    ok $res ~~ Pair, ':$<foo> returns a pair';
    ok $res.key eq 'foo', 'its key is "foo"';
    ok $res.value ~~ Match:D, 'the pairs value is a defined match object';
}

my $c;
ok 'abc' ~~ /.{ $c = $¢ }/,     'current match state';
#?rakudo todo 'Type of $¢ is Any instead of Cursor - RT #124998'
is $c.WHAT, Cursor.WHAT,        'got right type';
#?rakudo skip "No such method pos for invocant of type Any RT #124999"
ok defined($c.pos),             '.pos';

# RT #77146
{
    my token RT77146_rx { 77146 };

    "RT77146" ~~ /(RT)<RT77146_rx>/;
    is $/.keys, (0, "RT77146_rx"), "\$/.keys returns both positional and associative captures";
}

# https://github.com/rakudo/rakudo/commit/5ac593e
subtest 'can smartmatch against regexes stored in variables' => {
    plan 2;

    my $re = rx/a/;
    my $res = 'a' ~~ $re;
    isa-ok $res, Match, 'return value is a Match object';
    is $res, "a", 'return value contains right result';
}
