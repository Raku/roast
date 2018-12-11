use v6;
use Test;

my @uintbufs =
  Blob.new(1,2,3,4),                    'Blob1234',
  Blob[uint8].new(1,2,3,4),             'Blobuint1234',
  Blob.new((^256).roll(4)),             'Blobrandom',
  Blob[uint8].new((^256).roll(4)),      'Blobuintrandom',
  Blob[uint8].new((-128..127).roll(4)), 'Blobuintnegrandom',
;
my @intbufs =
  Blob[int8].new(1,2,3,4),             'Blobint1234',
  Blob[int8].new(-1,-2,-3,-4),         'Blobint-1-2-3-4',
  Blob[int8].new((^256).roll(4)),      'Blobintposrandom',
  Blob[int8].new((-128..127).roll(4)), 'Blobintnegrandom',
;

my $uintcells = @uintbufs.map( -> \buf, \name { buf.elems }).sum;
my  $intcells =  @intbufs.map( -> \buf, \name { buf.elems }).sum;
plan ($uintcells + $intcells) * 4;

for @uintbufs -> \buffer, $name {
    for ^buffer.elems {
        is buffer.read-uint8($_), buffer[$_], "is $name $_ correct";

        # endianness doesn't matter for byte sized reads
        for native-endian, little-endian, big-endian -> $endian {
            is buffer.read-uint8($_,$endian), buffer[$_],
              "is $name $_ $endian correct";
        }
    }
}

for @intbufs -> \buffer, $name {
    for ^buffer.elems {
        is buffer.read-int8($_), buffer[$_], "is $name $_ correct";

        # endianness doesn't matter for byte sized reads
        for native-endian, little-endian, big-endian -> $endian {
            is buffer.read-int8($_,$endian), buffer[$_],
              "is $name $_ $endian correct";
        }
    }
}

# vim: ft=perl6 expandtab sw=4
