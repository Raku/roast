use v6.e.PREVIEW;

use Test;

plan 32;

# constant formats, at compile time
my $o1       := q:o/%5s/;
my $format1  := q:format/%5s/;
my $o2       := q:o/%5s:%5s/;
my $format2  := q:format/%5s:%5s/;

# same but with variable, so runtime
my $s5       := '5s';
my $o1v      := qq:o/%$s5/;
my $format1v := qq:format/%$s5/;
my $o2v      := qq:o/%5s:%5s/;
my $format2v := qq:format/%$s5:%$s5/;

for
  'o1',       $o1,
  'format1',  $format1,
  'o1v',      $o1v,
  'format1v', $format1v
-> $name, $quoted {
    isa-ok $quoted, Format;
    is $quoted,        '%5s',   "$name: stringifies ok";
    is $quoted("foo"), '  foo', "$name: 'foo' ok";
    is $quoted(42),    '   42', "$name: 42 ok";
}

for
  'o2',       $o2,
  'format2',  $format2,
  'o2v',      $o2v,
  'format2v', $format2v
-> $name, $quoted {
    isa-ok $quoted, Format;
    is $quoted, '%5s:%5s',   "$name: stringifies ok";
    is $quoted("foo","bar"), '  foo:  bar', "$name: 'foo','bar' ok";
    is $quoted(42,666),      '   42:  666', "$name: 42,666 ok";
}

# vim: expandtab shiftwidth=4
