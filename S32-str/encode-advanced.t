use v6;
use Test;

# see L<here|https://gist.github.com/Juerd/ae574b87d40a66649692>

plan 11;

{
    my $blob = encode(uint16, 259);
    is $blob, Blob.new(3, 1), "encoding from uint16 works";
}

{
    my $blob = encode([num64, "latin1"],
      [3.8820982865540609356454541948e-265, "ABC"]);
    is $blob, Blob.new(9, 9, 9, 9, 9, 9, 9, 9, 65, 66, 67),
      'encoding from [num64, "latin1"] works';
}

{
    my $blob = encode([:big(uint32)], 0x01020304;);
    is $blob, Blob.new(1, 2, 3, 4), "encoding from uint32 in big-endian works";
}

{
    my $blob = encode([:big, uint32, uint16, uint8],
      (0x01020304, 0x0506, 0x07));
    is $blob, Blob.new(1, 2, 3, 4, 5, 6, 7),
      "setting default endianness works";
}

{
    my $orig1 = "Reimu".encode;
    my $orig2 = "Marisa".encode;
    my $expected-blob =
      Blob.new(5, 0, 0, 0) ~ $orig1 ~
      Blob.new(6, 0, 0, 0) ~ $orig2;
    my $actual-blob = encode([::uint32 => Blob, ::uint32 => Blob],
      ($orig1, $orig2));
    is $actual-blob, $expected-blob, "encoding into length-prefixed blobs";
}

{
    my $orig1 = "Reimu".encode;
    my $orig2 = "Marisa".encode;
    my $expected-blob =
      Blob.new(5, 0, 0, 0) ~ $orig1 ~
      Blob.new(6, 0, 0, 0) ~ $orig2;
    my $actual-blob = encode([(::uint32 => Blob) xx 2], ($orig1, $orig2));
    is $actual-blob, $expected-blob,
      "alternate method of encoding into length-prefixed blobs";
}

{
    my @origs = <Reimu Marisa Sakuya Youmu Sanae Reisen>.map({Blob.new($_)});
    my $expected-blob = [~] @origs.map: -> $b {
      return Blob.new($b.bytes, 0, 0, 0) ~ $b;
    }
    my $actual-blob = encode([::Inf => [::uint32 => Blob]], @origs);
    is $actual-blob, $expected-blob,
      "extracting any number of length-prefixed blobs";
}

{
    my @origs = <Reimu Marisa Sakuya Youmu Sanae Reisen>;
    my $expected-blob = [~] @origs.map: -> $name {
      my $b = $name.encode("Windows-1252");
      return Blob.new($b.bytes, 0, 0, 0) ~ $b;
    }
    my $actual-blob = encode([::Inf => [::uint32 => "Windows-1252"]], @origs);
    is $actual-blob, $expected-blob,
      "extracting any number of length-prefixed strings";
}

{
    my $expected-blob = Blob.new(
      3,
      0xCB, 0x16, 0, 0,
      0x23, 0x29, 0, 0,
      0x40, 0x42, 0x0F, 0
    );
    my $actual-blob = encode([:elems(uint8) => uint32],
      (5835, 9001, 1_000_000));
    is $actual-blob, $expected-blob,
      "extracting a count-prefixed list of uint32's";
}

{
    my $expected-blob = Blob.new(
      8, 0, 0, 0,
      1, 0, 0, 0,
      2, 0,
      65, 66,
      9, 0, 0, 0,
      3, 1, 0, 0,
      2, 2,
      67, 68, 69
    );
    my @i = (
      (1, 2, "AB"),
      (259, 514, "CDE")
    );
    my $actual-blob = encode([::uint32 => [int32, uint16, "latin1"]], @i);
    is $actual-blob, $expected-blob,
        "encoding a list of sub-templates with a byte length prefix";
}

{
    my $expected-blob = Blob.new(
      12, 0, 0, 0
      0xCB, 0x16, 0, 0,
      0x23, 0x29, 0, 0,
      0x40, 0x42, 0x0F, 0
    );
    my $actual-blob = encode([uint32 => uint32],
      (5835, 9001, 1_000_000));
    is $actual-blob, $expected-blob,
      "extracting a byte-length-prefixed list of uint32's";
}
