use v6;
use Test;

my @bufs = (
  blob8.new(1..9),                 'blob8-1234',
  Blob[uint8].new((^256).roll(9)), 'Blob[uint8]-random',
  buf8.new(1..9),                  'buf8-1234',
  Buf[uint8].new((^256).roll(9)),  'Buf[uint8]-random',
);

my constant my-native-endian =
  blob8.new(1,0).read-int16(0) == 1 ?? little-endian !! big-endian;

plan @bufs * 24;

# run read tests for all blob8/buf8's
for @bufs -> \buffer, $name {
    my int $elems = buffer.elems;

    # read32
    # use "try" until MoarVM #1020 is fixed
    for ^($elems - 3) -> int $i {
        ok try buffer.read-num32($i), "is $name $i num32 not 0";
        ok try buffer.read-num32($i,native-endian),
          "is $name $i num32 native-endian not 0";

        for little-endian, big-endian -> $endian {
            ok try buffer.read-num32($i,$endian),
              "is $name $i num32 $endian not 0";
        }
    }
    dies-ok { buffer.read-num32(-1) },  "does $name num32 -1 die";
    dies-ok { buffer.read-num32($elems - 3) },
      "does $name num32 {$elems - 3} die";
    for native-endian, little-endian, big-endian -> $endian {
        dies-ok { buffer.read-num32(-1,$endian) },
          "does $name num32 -1 $endian die";
        dies-ok { buffer.read-num32(-1,$endian) },
          "does $name num32 -1 $endian die";
    }

    # read64
    for ^($elems - 7) -> int $i {
        ok buffer.read-num64($i), "is $name $i num64 not 0";
        ok buffer.read-num64($i,native-endian),
          "is $name $i num64 native-endian not 0";

        for little-endian, big-endian -> $endian {
            ok buffer.read-num64($i,$endian),
              "is $name $i num64 $endian not 0";
        }
    }
    dies-ok { buffer.read-num64(-1) }, "does $name num64 -1 die";
    dies-ok { buffer.read-num64($elems - 7) },
      "does $name num64 {$elems - 7} die";
    for native-endian, little-endian, big-endian -> $endian {
        dies-ok { buffer.read-num64(-1,$endian) },
          "does $name num64 -1 $endian die";
        dies-ok { buffer.read-num64($elems - 7,$endian) },
          "does $name num64 {$elems - 7} $endian die";
    }
}

# vim: ft=perl6 expandtab sw=4
