use v6;
use Test;

# see L<here|https://gist.github.com/Juerd/ae574b87d40a66649692>

plan 13;

{
    my $blob = Blob.new(3, 1);
    is $blob.decode(uint16), 259, "decoding into uint16 works";
}

subtest {
    my $blob = Blob.new(9, 9, 9, 9, 9, 9, 9, 9, 65, 66, 67);
    my ($n, $s) = $blob.decode([num64, "latin1"]);
    my $expected-n = 3.8820982865540609356454541948e-265;
    is-approx $n, $expected-n, "Correct num";
    is $s, "ABC", "Correct string";
}, 'decoding into [num64, "latin1"] works';

{
    my $blob = Blob.new(65, 66, 67, 9, 9, 9, 9, 9, 9, 9, 9);
    dies-ok { $blob.decode(["latin1", num64]) },
      'decoding into ["latin1", num64] doesn\'t work';
}

{
    my $blob = Blob.new(1, 2, 3, 4);
    is $blob.decode([:big(uint32)]), 0x01020304,
      "decoding into uint32 in big-endian works";
}

{
    my $blob = Blob.new(1, 2, 3, 4, 5, 6, 7);
    my @i = $blob.decode([:big, uint32, uint16, uint8]);
    is-deeply @i, (0x01020304, 0x0506, 0x07),
      "setting default endianness works";
}

subtest {
    my $orig1 = "Reimu".encode;
    my $orig2 = "Marisa".encode;
    my $blob =
      Blob.new(5, 0, 0, 0) ~ $orig1 ~
      Blob.new(6, 0, 0, 0) ~ $orig2;
    my ($blob1, $blob2) = $blob.decode([::uint32 => Blob, ::uint32 => Blob]);
    is $blob1, $orig1, "getting first blob";
    is $blob2, $orig2, "getting second blob";
}, "extracting two length-prefixed blobs";

subtest {
    my $orig1 = "Reimu".encode;
    my $orig2 = "Marisa".encode;
    my $blob =
      Blob.new(5, 0, 0, 0) ~ $orig1 ~
      Blob.new(6, 0, 0, 0) ~ $orig2;
    my ($blob1, $blob2) = $blob.decode([(::uint32 => Blob) xx 2]);
    is $blob1, $orig1, "getting first blob";
    is $blob2, $orig2, "getting second blob";
}, "alternate method of extracting two length-prefixed blobs";

{
    my @origs = <Reimu Marisa Sakuya Youmu Sanae Reisen>.map({Blob.new($_)});
    my $blob = [~] @origs.map: -> $b {
      return Blob.new($b.bytes, 0, 0, 0) ~ $b;
    }
    my @blobs = $blob.decode([::Inf => [::uint32 => Blob]]);
    is-deeply @blobs, @origs,
      "extracting any number of length-prefixed blobs";
}

{
    my @origs = <Reimu Marisa Sakuya Youmu Sanae Reisen>;
    my $blob = [~] @origs.map: -> $name {
      my $b = $name.encode("Windows-1252");
      return Blob.new($b.bytes, 0, 0, 0) ~ $b;
    }
    my @strings = $blob.decode([::Inf => [::uint32 => "Windows-1252"]]);
    is-deeply @strings, @origs,
      "extracting any number of length-prefixed strings";
}

{
    my $blob = Blob.new(
      3,
      0xCB, 0x16, 0, 0,
      0x23, 0x29, 0, 0,
      0x40, 0x42, 0x0F, 0
    );
    my @i = $blob.decode([:elems(uint8) => uint32]);
    is-deeply @i, (5835, 9001, 1_000_000),
      "extracting equityped things with a counter prefix";
}

{
    my $blob = Blob.new(
      8, 0, 0, 0,
      1, 0, 0, 0,
      2, 0,
      65, 66,
      9, 0, 0, 0,
      3, 1, 0, 0,
      2, 2,
      67, 68, 69
    );
    my @i = $blob.decode([::uint32 => [int32, uint16, "latin1"]]);
    my @expected = (
      (1, 2, "AB"),
      (259, 514, "CDE")
    );
    is-deeply @i, @expected,
        "extracting a sub-template with a byte length prefix";
}

{
    my $blob = Blob.new(
      12, 0, 0, 0,
      0xCB, 0x16, 0, 0,
      0x23, 0x29, 0, 0,
      0x40, 0x42, 0x0F, 0
    );
    my @i = $blob.decode([::uint32 => uint32]);
    is-deeply @i, (5835, 9001, 1_000_000),
      "extracting equityped things with a byte length prefix";
}

{
    my $blob = Blob.new(1, 2, 3, 4, 5, 6);
    my @i = $blob.decode([uint8, uint8, uint8, Nil, uint8, uint8]);
    is-deeply @i, (1, 2, 3, 5, 6),
      "Nil skips over a byte";
}
