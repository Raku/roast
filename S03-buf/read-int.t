use v6;
use Test;

my @bufs = (
  blob8.new(1..19),                 'blob8-1234',
  blob8.new(255 xx 19),             'blob8-255',
  blob8.new((^256).roll(19)),       'blob8-random',
  Blob[uint8].new((^256).roll(19)), 'Blob[uint8]-random',
  buf8.new(1..19),                  'buf8-1234',
  buf8.new(255 xx 19),              'buf8-255',
  buf8.new((^256).roll(19)),        'buf8-random',
  Buf[uint8].new((^256).roll(19)),  'Buf[uint8]-random',
);

my constant my-NativeEndian = Kernel.endian;

plan @bufs * 125.5;

# first and last two of a range
sub outer2(Range:D \range) { (|range.head(2),|range.tail(2)) }

# create uint out of buffer from given indices, highest -> lowest
sub make-uint(\buffer,*@index --> UInt) {
    my UInt $result = buffer[@index.shift];
    $result = $result * 256 + buffer[@index.shift] while @index;
    $result;
}

# helper subs for creating uints out of a buffer
multi sub make-uint16(\buffer,int $i,LittleEndian) {
    make-uint(buffer, $i + 1, $i)
}
multi sub make-uint16(\buffer,int $i,BigEndian) {
    make-uint(buffer, $i, $i + 1)
}
multi sub make-uint32(\buffer,int $i,LittleEndian) {
    make-uint(buffer, [$i+3 ... $i] )   # not sure why the [] is needed
}
multi sub make-uint32(\buffer,int $i,BigEndian) {
    make-uint(buffer, $i .. $i+3)
}
multi sub make-uint64(\buffer,int $i,LittleEndian) {
    make-uint(buffer, [$i+7 ... $i] )   # not sure why the [] is needed
}
multi sub make-uint64(\buffer,int $i,BigEndian) {
    make-uint(buffer, $i .. $i+7)
}
multi sub make-uint128(\buffer,int $i,LittleEndian) {
    make-uint(buffer, [$i+15 ... $i] )   # not sure why the [] is needed
}
multi sub make-uint128(\buffer,int $i,BigEndian) {
    make-uint(buffer, $i .. $i+15)
}

# helper subs for creating ints out of a buffer
multi sub make-int16(\buffer,int $i,LittleEndian) {
    my \unsigned := make-uint16(buffer,$i,LittleEndian);
    unsigned >= 1 +< 15 ?? unsigned - 1 +< 16 !! unsigned
}
multi sub make-int16(\buffer,int $i,BigEndian) {
    my \unsigned := make-uint16(buffer,$i,BigEndian);
    unsigned >= 1 +< 15 ?? unsigned - 1 +< 16 !! unsigned
}
multi sub make-int32(\buffer,int $i,LittleEndian) {
    my \unsigned := make-uint32(buffer,$i,LittleEndian);
    unsigned >= 1 +< 31 ?? unsigned - 1 +< 32 !! unsigned
}
multi sub make-int32(\buffer,int $i,BigEndian) {
    my \unsigned := make-uint32(buffer,$i,BigEndian);
    unsigned >= 1 +< 31 ?? unsigned - 1 +< 32 !! unsigned
}
multi sub make-int64(\buffer,int $i,LittleEndian) {
    my \unsigned := make-uint64(buffer,$i,LittleEndian);
    unsigned >= 1 +< 63 ?? unsigned - 1 +< 64 !! unsigned
}
multi sub make-int64(\buffer,int $i,BigEndian) {
    my \unsigned := make-uint64(buffer,$i,BigEndian);
    unsigned >= 1 +< 63 ?? unsigned - 1 +< 64 !! unsigned
}
multi sub make-int128(\buffer,int $i,LittleEndian) {
    my \unsigned := make-uint128(buffer,$i,LittleEndian);
    unsigned >= 1 +< 127 ?? unsigned - 1 +< 128 !! unsigned
}
multi sub make-int128(\buffer,int $i,BigEndian) {
    my \unsigned := make-uint128(buffer,$i,BigEndian);
    unsigned >= 1 +< 127 ?? unsigned - 1 +< 128 !! unsigned
}

# run read tests for all blob8/buf8's
for @bufs -> \buffer, $name {
    my int $elems = buffer.elems;

    # read8
    for outer2(^$elems) -> int $i {
        my $unsigned = buffer[$i];
        my $signed = $unsigned > 127 ?? $unsigned - 256 !! $unsigned;

        is buffer.read-uint8($i), $unsigned, "is $name uint8 $i correct";
        is buffer.read-int8($i),  $signed,   "is $name int8 $i correct";

        # endianness doesn't matter for byte sized reads
        for NativeEndian, LittleEndian, BigEndian -> $endian {
            is buffer.read-uint8($i,$endian), $unsigned,
              "is $name uint8 $i $endian correct";
            is buffer.read-int8($i,$endian), $signed,
              "is $name int8 $i $endian correct";
        }
    }
    dies-ok { buffer.WHAT.read-int8(0) },  "does {buffer.WHAT} int8 0 die";
    dies-ok { buffer.WHAT.read-uint8(0) }, "does {buffer.WHAT} uint8 0 die";
    dies-ok { buffer.read-int8(-1) },  "does $name int8 -1 die";
    dies-ok { buffer.read-uint8(-1) }, "does $name uint8 -1 die";
    dies-ok { buffer.read-int8(-1) },  "does $name int8 -1 die";
    dies-ok { buffer.read-uint8($elems) }, "does $name uint8 $elems die";
    dies-ok { buffer.read-int8($elems) },  "does $name int8 $elems die";
    for NativeEndian, LittleEndian, BigEndian -> $endian {
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
    for outer2(^($elems - 1)) -> int $i {
        my $unative := make-uint16(buffer,$i,my-NativeEndian);
        is buffer.read-uint16($i), $unative,
          "is $name $i uint16 correct";
        is buffer.read-uint16($i,NativeEndian), $unative,
          "is $name $i uint16 NativeEndian correct";

        my $native := make-int16(buffer,$i,my-NativeEndian);
        is buffer.read-int16($i), $native,
          "is $name $i int16 correct";
        is buffer.read-int16($i,NativeEndian), $native,
          "is $name $i int16 NativeEndian correct";

        for LittleEndian, BigEndian -> $endian {
            is buffer.read-uint16($i,$endian), make-uint16(buffer,$i,$endian),
              "is $name $i uint16 $endian correct";
            is buffer.read-int16($i,$endian), make-int16(buffer,$i,$endian),
              "is $name $i int16 $endian correct";
        }
    }
    dies-ok { buffer.WHAT.read-int16(0) },  "does {buffer.^name} int16 0 die";
    dies-ok { buffer.WHAT.read-uint16(0) }, "does {buffer.^name} uint16 0 die";
    dies-ok { buffer.read-uint16(-1) }, "does $name uint16 -1 die";
    dies-ok { buffer.read-int16(-1) },  "does $name int16 -1 die";
    dies-ok { buffer.read-uint16($elems - 1) },
      "does $name uint16 {$elems - 1} die";
    dies-ok { buffer.read-int16($elems - 1) },
      "does $name int16 {$elems - 1} die";
    for NativeEndian, LittleEndian, BigEndian -> $endian {
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
    for outer2(^($elems - 3)) -> int $i {
        my $unative := make-uint32(buffer,$i,my-NativeEndian);
        is buffer.read-uint32($i), $unative,
          "is $name $i uint32 correct";
        is buffer.read-uint32($i,NativeEndian), $unative,
          "is $name $i uint32 NativeEndian correct";

        my $native := make-int32(buffer,$i,my-NativeEndian);
        is buffer.read-int32($i), $native,
          "is $name $i int32 correct";
        is buffer.read-int32($i,NativeEndian), $native,
          "is $name $i int32 NativeEndian correct";

        for LittleEndian, BigEndian -> $endian {
            is buffer.read-uint32($i,$endian), make-uint32(buffer,$i,$endian),
              "is $name $i uint32 $endian correct";
            is buffer.read-int32($i,$endian), make-int32(buffer,$i,$endian),
              "is $name $i int32 $endian correct";
        }
    }
    dies-ok { buffer.WHAT.read-int32(0) },  "does {buffer.^name} int32 0 die";
    dies-ok { buffer.WHAT.read-uint32(0) }, "does {buffer.^name} uint32 0 die";
    dies-ok { buffer.read-uint32(-1) }, "does $name uint32 -1 die";
    dies-ok { buffer.read-int32(-1) },  "does $name int32 -1 die";
    dies-ok { buffer.read-uint32($elems - 3) },
      "does $name uint32 {$elems - 3} die";
    dies-ok { buffer.read-int32($elems - 3) },
      "does $name int32 {$elems - 3} die";
    for NativeEndian, LittleEndian, BigEndian -> $endian {
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
    for outer2(^($elems - 7)) -> int $i {
        my $unative := make-uint64(buffer,$i,my-NativeEndian);
        is buffer.read-uint64($i), $unative,
          "is $name $i uint64 correct";
        is buffer.read-uint64($i,NativeEndian), $unative,
          "is $name $i uint64 NativeEndian correct";

        my $native := make-int64(buffer,$i,my-NativeEndian);
        is buffer.read-int64($i), $native,
          "is $name $i int64 correct";
        is buffer.read-int64($i,NativeEndian), $native,
          "is $name $i int64 NativeEndian correct";

        for LittleEndian, BigEndian -> $endian {
            is buffer.read-uint64($i,$endian), make-uint64(buffer,$i,$endian),
              "is $name $i uint64 $endian correct";
            is buffer.read-int64($i,$endian), make-int64(buffer,$i,$endian),
              "is $name $i int64 $endian correct";
        }
    }
    dies-ok { buffer.WHAT.read-int64(0) },  "does {buffer.^name} int64 0 die";
    dies-ok { buffer.WHAT.read-uint64(0) }, "does {buffer.^name} uint64 0 die";
    dies-ok { buffer.read-uint64(-1) }, "does $name uint64 -1 die";
    dies-ok { buffer.read-int64(-1) },  "does $name int64 -1 die";
    dies-ok { buffer.read-uint64($elems - 7) },
      "does $name uint64 {$elems - 7} die";
    dies-ok { buffer.read-int64($elems - 7) },
      "does $name int64 {$elems - 7} die";
    for NativeEndian, LittleEndian, BigEndian -> $endian {
        dies-ok { buffer.read-uint64(-1,$endian) },
          "does $name uint64 -1 $endian die";
        dies-ok { buffer.read-int64(-1,$endian) },
          "does $name int64 -1 $endian die";
        dies-ok { buffer.read-uint64($elems - 7,$endian) },
          "does $name uint64 {$elems - 7} $endian die";
        dies-ok { buffer.read-int64($elems - 7,$endian) },
          "does $name int64 {$elems - 7} $endian die";
    }

    # read128
    for outer2(^($elems - 15)) -> int $i {
        my $unative := make-uint128(buffer,$i,my-NativeEndian);
        is buffer.read-uint128($i), $unative,
          "is $name $i uint128 correct";
        is buffer.read-uint128($i,NativeEndian), $unative,
          "is $name $i uint128 NativeEndian correct";

        my $native := make-int128(buffer,$i,my-NativeEndian);
        is buffer.read-int128($i), $native,
          "is $name $i int128 correct";
        is buffer.read-int128($i,NativeEndian), $native,
          "is $name $i int128 NativeEndian correct";

        for LittleEndian, BigEndian -> $endian {
            is buffer.read-uint128($i,$endian), make-uint128(buffer,$i,$endian),
              "is $name $i uint128 $endian correct";
            is buffer.read-int128($i,$endian), make-int128(buffer,$i,$endian),
              "is $name $i int128 $endian correct";
        }
    }
    dies-ok { buffer.WHAT.read-int128(0) },
      "does {buffer.^name} int128 -1 die";
    dies-ok { buffer.WHAT.read-uint128(0) },
      "does {buffer.^name} uint128 -1 die";
    dies-ok { buffer.read-uint128(-1) }, "does $name uint128 -1 die";
    dies-ok { buffer.read-int128(-1) },  "does $name int128 -1 die";
    dies-ok { buffer.read-uint128($elems - 15) },
      "does $name uint128 {$elems - 15} die";
    dies-ok { buffer.read-int128($elems - 15) },
      "does $name int128 {$elems - 15} die";
    for NativeEndian, LittleEndian, BigEndian -> $endian {
        dies-ok { buffer.read-uint128(-1,$endian) },
          "does $name uint128 -1 $endian die";
        dies-ok { buffer.read-int128(-1,$endian) },
          "does $name int128 -1 $endian die";
        dies-ok { buffer.read-uint128($elems - 15,$endian) },
          "does $name uint128 {$elems - 15} $endian die";
        dies-ok { buffer.read-int128($elems - 15,$endian) },
          "does $name int128 {$elems - 15} $endian die";
    }
}

# vim: expandtab shiftwidth=4
