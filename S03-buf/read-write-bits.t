use v6;

#BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = 1;
use Test;

# initialize blobs
my @pattern = 0x12,0x34,0x56,0x78,0x9a,0xbc,0xde,0xf0,0x12;
my @testdata = (
  blob8.new(@pattern), buf8.new(@pattern), "pattern",
  blob8.new(  0 xx 9), buf8.new(  0 xx 9), "zeroes",
  blob8.new(255 xx 9), buf8.new(255 xx 9), "ones",
);
my @positions = 0..7;
my @bits      = 1..65;

plan (@testdata / 3) * (2 * 4 + 2 * 1 + @positions * @bits);

for @testdata -> \blob, \buf, $name {
    my $sbits = blob.list.fmt(q:c/%08b/,"");

    for <read-ubits read-bits> -> $method {
        dies-ok { blob."$method"(-1,24) }, "$method -1 on blob $name fails";
        dies-ok { buf."$method"(-1,24)  }, "$method -1 on buf $name fails";
        dies-ok { blob."$method"(72,1) },  "$method 72,1 on blob $name fails";
        dies-ok { buf."$method"(72,1)  },  "$method 72,1 on buf $name fails";
    }

    for <write-ubits write-bits> -> $method {
        dies-ok { buf."$method"(-1,1,1)  },  "$method -1 on buf $name fails";
    }

    for 0..7 -> int $from {
        for 1..65 -> Int $bits {
            my $rmask  := 1 +< $bits - 1;
            my $format := q:c/%0{$bits}b/;
            my $ebits  := substr($sbits,$from,$bits);

            subtest {
                plan 2 * 3 + 12;

                # basic reading tests
                for blob, buf -> \this {
                    my $type = this.^name;

                    my $unsigned := this.read-ubits($from, $bits);
                    is $unsigned.fmt($format), $ebits,
                      "did $type ubits $name $from $bits give correct result";

                    my $signed := this.read-bits($from, $bits);
                    is $signed < 0, substr($ebits,0,1) eq "1",
                      "was sign bit correct on $type bits $name $from $bits";

                    $unsigned := $signed +& $rmask if $signed < 0;
                    is $unsigned.fmt($format), $ebits,
                      "did $type bits $name $from $bits give correct result";
                }

                # basic roundtrip tests on existing buffer
                my $mutable  := buf8.new(buf);
                my $unsigned := $mutable.read-ubits($from, $bits);
                is-deeply $mutable.write-ubits($from, $bits, $unsigned),$mutable,
                  "write-ubits $unsigned mutable $from $bits returns \$mutable";
                is $mutable.read-ubits($from, $bits).fmt($format), $ebits,
                  "did ubits $name $from $bits roundtrip";

                my $signed := $mutable.read-bits($from, $bits);
                is-deeply $mutable.write-bits($from, $bits, $signed), $mutable,
                  "write-bits $signed mutable $from $bits returns \$mutable";
                is $signed < 0, substr($ebits,0,1) eq "1",
                  "was sign bit correct on buf bits $name $from $bits";
                is $unsigned, $signed +& $rmask,
                  "is $unsigned same as $signed masked $name $from $bits";
                is $unsigned.fmt($format), $ebits,
                  "did bits $name $from $bits roundtrip";

                # basic roundtrip tests on empty buffer
                $mutable := buf8.new;
                is $mutable.write-ubits($from, $bits, $unsigned), $mutable,
                  "write-ubits $unsigned new $from $bits returns \$mutable";
                is $mutable.read-ubits($from, $bits).fmt($format), $ebits,
                  "did ubits $name $from $bits roundtrip";

                $mutable := buf8.new;
                is $mutable.write-bits($from, $bits, $signed), $mutable,
                  "write-bits $signed new $from $bits returns \$mutable";
                is $signed < 0, substr($ebits,0,1) eq "1",
                  "was sign bit correct on buf bits $name $from $bits";
                is $unsigned, $signed +& $rmask,
                  "is $unsigned same as $signed masked $name $from $bits";
                is $unsigned.fmt($format), $ebits,
                  "did bits $name $from $bits roundtrip";

            }, "sanity test blob $name $from $bits";
        }
    }
}

# vim: expandtab shiftwidth=4
