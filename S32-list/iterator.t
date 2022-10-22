use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;
use Test::Iterator;

plan 1 + 9*6;

# Test iterators coming from Lists

for
    { ("a".."z").List.eager },           "list",
    { ("a".."z").List },                 "lazy list",
    { ("a"..."z").List },                "lazy sequence",
    { (my @ = "a".."z") },               "array",
    { (my @[26] = "a".."z") },           "shaped array",
    { (my Str @ = "a".."z") },           "Str array",
    { (my Str @[26] = "a".."z") },       "shaped Str array",
    { (my str @ = "a".."z") },           "str array",
    { (my str @[26] = "a".."z") },       "shaped str array"

-> $l, $case {

    my @pairs = $l().pairs;
    iterator-ok( { $l().iterator },
      "$case", @pairs.map: { .value } );
    iterator-ok( { $l().kv.iterator },
      "$case.kv", @pairs.map: { |(.key,.value) } );
    iterator-ok( { $l().keys.iterator },
      "$case.keys", @pairs.map: { .key } );
    iterator-ok( { $l().values.iterator },
      "$case.values", @pairs.map: { .value } );
    iterator-ok( { $l().pairs.iterator },
      "$case.pairs", @pairs );
    iterator-ok( { $l().antipairs.iterator },
      "$case.antipairs", @pairs.map: { .antipair });
}

group-of 6 => 'Mu.iterator' => {
    my $i := Mu.iterator;
    does-ok $i,                 Iterator,     'returns Iterator (:U)';
    cmp-ok  $i.pull-one, '=:=', Mu,           'first   value    (:U)';
    cmp-ok  $i.pull-one, '=:=', IterationEnd, 'no more values   (:U)';

    my \Munew := Mu.new;
    $i := Munew.iterator;
    does-ok $i,                 Iterator,     'returns Iterator (:D)';
    cmp-ok  $i.pull-one, '=:=', Munew,        'first   value    (:D)';
    cmp-ok  $i.pull-one, '=:=', IterationEnd, 'no more values   (:D)';
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
