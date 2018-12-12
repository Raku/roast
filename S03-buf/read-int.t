use v6;
use Test;

my @blobs = (
  blob8.new(1..9),           'blob8-1234',
  blob8.new(255 xx 9),       'blob8-255',
  blob8.new((^256).roll(9)), 'blob8-random',
);
my @bufs = (
  buf8.new(1..9),           'buf8-1234',
  buf8.new(255 xx 9),       'buf8-255',
  buf8.new((^256).roll(9)), 'buf8-random',
);
my @blobbufs = |@blobs, |@bufs;

my constant my-native-endian =
  blob8.new(1,0).read-int16(0) == 1 ?? little-endian !! big-endian;

plan @blobbufs * 132;

# create uint out of buffer from given indices, highest -> lowest
sub make-uint(\buffer,*@index --> UInt) {
    my UInt $result = buffer[@index.shift];
    $result = $result * 256 + buffer[@index.shift] while @index;
    $result;
}

# helper subs for creating uints out of a buffer
multi sub make-uint16(\buffer,int $i,little-endian) {
    make-uint(buffer, $i + 1, $i)
}
multi sub make-uint16(\buffer,int $i,big-endian) {
    make-uint(buffer, $i, $i + 1)
}
multi sub make-uint32(\buffer,int $i,little-endian) {
    make-uint(buffer, [$i+3 ... $i] )   # not sure why the [] is needed
}
multi sub make-uint32(\buffer,int $i,big-endian) {
    make-uint(buffer, $i .. $i+3)
}
multi sub make-uint64(\buffer,int $i,little-endian) {
    make-uint(buffer, [$i+7 ... $i] )   # not sure why the [] is needed
}
multi sub make-uint64(\buffer,int $i,big-endian) {
    make-uint(buffer, $i .. $i+7)
}

# helper subs for creating ints out of a buffer
multi sub make-int16(\buffer,int $i,little-endian) {
    my \unsigned := make-uint16(buffer,$i,little-endian);
    unsigned > 0x7fff ?? unsigned - 0x10000 !! unsigned
}
multi sub make-int16(\buffer,int $i,big-endian) {
    my \unsigned := make-uint16(buffer,$i,big-endian);
    unsigned > 0x7fff ?? unsigned - 0x10000 !! unsigned
}
multi sub make-int32(\buffer,int $i,little-endian) {
    my \unsigned := make-uint32(buffer,$i,little-endian);
    unsigned > 0x7fff_ffff ?? unsigned - 0x1_0000_0000 !! unsigned
}
multi sub make-int32(\buffer,int $i,big-endian) {
    my \unsigned := make-uint32(buffer,$i,big-endian);
    unsigned > 0x7fff_ffff ?? unsigned - 0x1_0000_0000 !! unsigned
}
multi sub make-int64(\buffer,int $i,little-endian) {
    my \unsigned := make-uint64(buffer,$i,little-endian);
    unsigned > 0x7fff_ffff_ffff_ffff
      ?? unsigned - 0x1_0000_0000_0000_0000 !! unsigned
}
multi sub make-int64(\buffer,int $i,big-endian) {
    my \unsigned := make-uint64(buffer,$i,big-endian);
    unsigned > 0x7fff_ffff_ffff_ffff
      ?? unsigned - 0x1_0000_0000_0000_0000 !! unsigned
}

# run read tests for all blob8/buf8's
for @blobbufs -> \buffer, $name {
    my int $elems = buffer.elems;

    # read8
    for ^$elems -> int $i {
        my $unsigned = buffer[$i];
        my $signed = $unsigned > 127 ?? $unsigned - 256 !! $unsigned;

        is buffer.read-uint8($i), $unsigned, "is $name uint8 $i correct";
        is buffer.read-int8($i),  $signed,   "is $name int8 $i correct";

        # endianness doesn't matter for byte sized reads
        for native-endian, little-endian, big-endian -> $endian {
            is buffer.read-uint8($i,$endian), $unsigned,
              "is $name uint8 $i $endian correct";
            is buffer.read-int8($i,$endian), $signed,
              "is $name int8 $i $endian correct";
        }
    }
    dies-ok { buffer.read-uint8(-1) }, "does $name uint8 -1 die";
    dies-ok { buffer.read-int8(-1) },  "does $name int8 -1 die";
    dies-ok { buffer.read-uint8($elems) }, "does $name uint8 $elems die";
    dies-ok { buffer.read-int8($elems) },  "does $name int8 $elems die";
    for native-endian, little-endian, big-endian -> $endian {
        dies-ok { buffer.read-uint8(-1,$endian) },
          "does $name uint8 -1 $endian die";
        dies-ok { buffer.read-int8(-1,$endian) },
          "does $name int8 -1 $endian die";
        dies-ok { buffer.read-uint8($elems,$endian) },
          "does $name uint8 $elems $endian die";
        dies-ok { buffer.read-int8($elems,$endian) },
          "does $name int8 $elems $endian die";
    }

    # read16
    for ^($elems - 1) -> int $i {
        my $unative := make-uint16(buffer,$i,my-native-endian);
        is buffer.read-uint16($i), $unative,
          "is $name $i uint16 correct";
        is buffer.read-uint16($i,native-endian), $unative,
          "is $name $i uint16 native-endian correct";

        my $native := make-int16(buffer,$i,my-native-endian);
        is buffer.read-int16($i), $native,
          "is $name $i int16 correct";
        is buffer.read-int16($i,native-endian), $native,
          "is $name $i int16 native-endian correct";

        for little-endian, big-endian -> $endian {
            is buffer.read-uint16($i,$endian), make-uint16(buffer,$i,$endian),
              "is $name $i uint16 $endian correct";
            is buffer.read-int16($i,$endian), make-int16(buffer,$i,$endian),
              "is $name $i int16 $endian correct";
        }
    }
    dies-ok { buffer.read-uint16(-1) }, "does $name uint16 -1 die";
    dies-ok { buffer.read-int16(-1) },  "does $name int16 -1 die";
    dies-ok { buffer.read-uint16($elems - 1) },
      "does $name uint16 {$elems - 1} die";
    dies-ok { buffer.read-int16($elems - 1) },
      "does $name int16 {$elems - 1} die";
    for native-endian, little-endian, big-endian -> $endian {
        dies-ok { buffer.read-uint16(-1,$endian) },
          "does $name uint16 -1 $endian die";
        dies-ok { buffer.read-int16(-1,$endian) },
          "does $name int16 -1 $endian die";
        dies-ok { buffer.read-uint16($elems - 1,$endian) },
          "does $name uint16 {$elems - 1} $endian die";
        dies-ok { buffer.read-int16($elems - 1,$endian) },
          "does $name int16 {$elems - 1} $endian die";
    }

    # read32
    for ^($elems - 3) -> int $i {
        my $unative := make-uint32(buffer,$i,my-native-endian);
        is buffer.read-uint32($i), $unative,
          "is $name $i uint32 correct";
        is buffer.read-uint32($i,native-endian), $unative,
          "is $name $i uint32 native-endian correct";

        my $native := make-int32(buffer,$i,my-native-endian);
        is buffer.read-int32($i), $native,
          "is $name $i int32 correct";
        is buffer.read-int32($i,native-endian), $native,
          "is $name $i int32 native-endian correct";

        for little-endian, big-endian -> $endian {
            is buffer.read-uint32($i,$endian), make-uint32(buffer,$i,$endian),
              "is $name $i uint32 $endian correct";
            is buffer.read-int32($i,$endian), make-int32(buffer,$i,$endian),
              "is $name $i int32 $endian correct";
        }
    }
    dies-ok { buffer.read-uint32(-1) }, "does $name uint32 -1 die";
    dies-ok { buffer.read-int32(-1) },  "does $name int32 -1 die";
    dies-ok { buffer.read-uint32($elems - 3) },
      "does $name uint32 {$elems - 3} die";
    dies-ok { buffer.read-int32($elems - 3) },
      "does $name int32 {$elems - 3} die";
    for native-endian, little-endian, big-endian -> $endian {
        dies-ok { buffer.read-uint32(-1,$endian) },
          "does $name uint32 -1 $endian die";
        dies-ok { buffer.read-int32(-1,$endian) },
          "does $name int32 -1 $endian die";
        dies-ok { buffer.read-uint32($elems - 3,$endian) },
          "does $name uint32 {$elems - 3} $endian die";
        dies-ok { buffer.read-int32($elems - 3,$endian) },
          "does $name int32 {$elems - 3} $endian die";
    }

    # read64
    for ^($elems - 7) -> int $i {
        my $unative := make-uint64(buffer,$i,my-native-endian);
        is buffer.read-uint64($i), $unative,
          "is $name $i uint64 correct";
        is buffer.read-uint64($i,native-endian), $unative,
          "is $name $i uint64 native-endian correct";

        my $native := make-int64(buffer,$i,my-native-endian);
        is buffer.read-int64($i), $native,
          "is $name $i int64 correct";
        is buffer.read-int64($i,native-endian), $native,
          "is $name $i int64 native-endian correct";

        for little-endian, big-endian -> $endian {
            is buffer.read-uint64($i,$endian), make-uint64(buffer,$i,$endian),
              "is $name $i uint64 $endian correct";
            is buffer.read-int64($i,$endian), make-int64(buffer,$i,$endian),
              "is $name $i int64 $endian correct";
        }
    }
    dies-ok { buffer.read-uint64(-1) }, "does $name uint64 -1 die";
    dies-ok { buffer.read-int64(-1) },  "does $name int64 -1 die";
    dies-ok { buffer.read-uint64($elems - 7) },
      "does $name uint64 {$elems - 7} die";
    dies-ok { buffer.read-int64($elems - 7) },
      "does $name int64 {$elems - 7} die";
    for native-endian, little-endian, big-endian -> $endian {
        dies-ok { buffer.read-uint64(-1,$endian) },
          "does $name uint64 -1 $endian die";
        dies-ok { buffer.read-int64(-1,$endian) },
          "does $name int64 -1 $endian die";
        dies-ok { buffer.read-uint64($elems - 7,$endian) },
          "does $name uint64 {$elems - 7} $endian die";
        dies-ok { buffer.read-int64($elems - 7,$endian) },
          "does $name int64 {$elems - 7} $endian die";
    }
}

# vim: ft=perl6 expandtab sw=4
