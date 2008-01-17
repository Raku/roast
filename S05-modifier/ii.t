use v6-alpha;
use Test;

plan 9;

#?pugs skip_rest "todo"
#?rakudo skip_rest "todo"
#?kp6 skip_rest "todo"

#    target,      substution,   result
my @tests = (
	['Hello',    'foo',         'Foo'],
    ['hEllo',    'foo',         'fOo'],
    ['A',        'foo',         'FOO'],
    ['AA',       'foo',         'FOO'],
    ['a b',      'FOO',         'fOo'],
    ['a b',      'FOOB',        'fOob'],
    ['Ab ',      'ABCDE',       'AbCDE'],
# someone with more spec-fu please check the next two tests:
    ['aB ',      'abcde',       'aBcde'],
    ['aB ',      'ABCDE',       'aBCDE'],

);

for @tests -> $t {
    my $test_str = $t[0];
    $test_str ~~ s:ii/ .* /$t[1];
    is $test_str, $t[2], ":ii modifier: {$t[0]} ~~ s/.*/{$t[1]}/ => {$t[2]}";
}
