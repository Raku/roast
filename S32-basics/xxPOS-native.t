use v6;

use Test;

plan 10 * 15;

for int, int8, int16, int32, int64, uint, uint8, uint16, uint32, uint64 -> \T {
    my $t = T.^name;

    my @a := array[T].new( 42, 666 );

    is @a.elems,             2, "array[$t].elems (original)";
    is @a.AT-POS(0),        42, "array[$t].AT-POS";
    is (@a.AT-POS(0) = 65), 65, "array[$t].AT-POS =";
    is @a.AT-POS(0),        65, "array[$t].AT-POS (changed)";

    ok @a.EXISTS-POS(0),  "array[$t].EXISTS-POS (existing)";
    ok !@a.EXISTS-POS(2), "!array[$t].EXISTS-POS (non-existing)";

    is @a.ASSIGN-POS(0,33), 33, "array[$t].ASSIGN-POS (existing)";
    is @a.AT-POS(0),        33, "array[$t].AT-POS (existing ASSIGN-POS)";
    is @a.ASSIGN-POS(2,65), 65, "array[$t].ASSIGN-POS (non-existing)";
    is @a.AT-POS(2),        65, "array[$t].AT-POS (non-existing ASSIGN-POS)";
    is @a.elems,             3, "array[$t].elens (one added)";

    my $a = 45;
    throws_like { @a.BIND-POS(0,$a) }, X::AdHoc,
      message => 'Cannot bind to a natively typed array',
      "array[$t].BIND-POS (existing)";
    throws_like { @a.BIND-POS(3,$a) }, X::AdHoc,
      message => 'Cannot bind to a natively typed array',
      "array[$t].BIND-POS (non-existing)";

    throws_like { @a.DELETE-POS(0) }, X::AdHoc,
      message => 'Cannot delete from a natively typed array',
      "array[$t].DELETE-POS (existing)";
    throws_like { @a.DELETE-POS(3) }, X::AdHoc,
      message => 'Cannot delete from a natively typed array',
      "array[$t].DELETE-POS (non-existing)";
}
