use v6;
use Test;

# this file should become the test for systematically testing
# Match objects. Exception: .caps and .chunks are tested in caps.t

plan 21;

#?pugs todo
ok 'ab12de' ~~ /\d+/,           'match successful';
is $/.WHAT.gist, Match.gist,    'got right type';
#?pugs todo
ok $/.Bool,                     '.Bool';
ok $/.defined,                  '.defined';
#?pugs todo 'Match.Str'
is $/.Str,         '12',        '.Str';
#?pugs todo
is $/.from,           2,        '.from';
#?pugs todo
is $/.to,             4,        '.to';
#?pugs skip 'Match.prematch'
is $/.prematch,    'ab',        '.prematch';
#?pugs skip 'Match.postmatch'
is $/.postmatch,   'de',        '.postmatch';
#?pugs todo
is $/.list.elems,     0,        '.list (empty)';
#?pugs skip 'Unimplemented unaryOp: hash'
is $/.hash.elems,     0,        '.hash (empty)';
#?pugs skip 'Not a keyed value'
is $/.keys.elems,     0,        '.keys (empty)';
#?pugs skip 'Not a keyed value'
is $/.values.elems,   0,        '.values (empty)';
#?pugs skip 'Not a keyed value'
is $/.pairs.elems,    0,        '.pairs (empty)';
#?pugs skip 'Not a keyed value'
is $/.kv.elems,       0,        '.kv (empty)';

nok 'abde' ~~ /\d/,             'no match';
nok $/.Bool,                    'failed match is False';
is  $/.Str,          '',        'false match stringifies to empty string';

my $c;
#?rakudo 3 skip 'Non-declarative sigil is missing its name at line 1, near "$\x{a2} }/\n"'
#?pugs todo
ok 'abc' ~~ /.{ $c = $¢ }/,     'current match state';
#?pugs skip 'Cursor'
is $c.WHAT.gist, Cursor.gist,   'got right type';
#?pugs skip 'Scalar.pos'
ok defined($c.pos),             '.pos';
