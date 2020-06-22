use v6;

#BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = 1;
use Test;

# bit/byte widths tested
my @endians = NativeEndian, LittleEndian, BigEndian;
my @byte-widths = 1,2,4,8,16;
my @bit-widths  = @byte-widths.map: * * 8;

# set up some patterns
my @filled-with-sign    = @bit-widths.map: 1 +< * - 1;     # ff ffff ...
my @filled-without-sign = @bit-widths.map: 1 +< (*-1) - 1; # 7f 7fff ...
my @increasing-per-byte = @byte-widths.map: {              # 01 0102 ...
  blob8.new(1..$_)."read-int{8*$_}"(0,BigEndian)
}
my @decreasing-per-byte = @byte-widths.map: {              # 01 0201 ...
  blob8.new(1..$_)."read-int{8*$_}"(0,LittleEndian)
}

# set up method data: byte-width, mask, write-uintX, read-uintX
my @umethods = @bit-widths.map: {
    |($_ / 8, 1 +< $_ - 1, "write-uint$_","read-uint$_")
}

# set up method data: byte-width, mask, write-intX, read-intX
my @imethods = @bit-widths.map: {
    |($_ / 8, 1 +< $_ - 1, "write-int$_","read-int$_")
}

# values that have specific patterns
my @patterns = (
  |@increasing-per-byte,
  |@decreasing-per-byte,
);

# values that should always yield a positive result with read-intX()
my @positive = (
  0, 1, 42,
  |@filled-without-sign,
  |(@filled-without-sign.map( (^*).roll )),
);

# values that may yield a negative result with read-intX()
my @may-be-negative = (
   0 , 1, -1, 42, -42, 666, -666,
  |@filled-with-sign,
  |(@filled-with-sign.map( (^*).roll )),
);

plan (@umethods / 4)
   + @byte-widths * (@positive + @patterns) * 8
   + (@imethods / 4)
   + @byte-widths * (@may-be-negative + @positive + @patterns) * 8
;

# run for all possible methods setting / returning unsigned values
for @umethods -> $bytes, $mask, $write, $read {

  subtest {
    plan 3 + @endians * 3;

    dies-ok { buf8."$write"(-1,42) },
      "does $write -1 42 die on type object";
    dies-ok { buf8.new."$write"(-1,42) },
      "does $write -1 42 die on uninited";
    dies-ok { buf8.new(255)."$write"(-1,42) },
      "does $write -1 42 die on inited";

    for @endians -> $endian {
      dies-ok { buf8."$write"(-1,42,$endian) },
        "does $write -1 42 $endian die on type object";
      dies-ok { buf8.new."$write"(-1,42,$endian) },
        "does $write -1 42 $endian die on uninited";
      dies-ok { buf8.new(255)."$write"(-1,42,$endian) },
        "does $write -1 42 $endian die";
    }
  }, "did all possible negative offsets die";

  # run for a set or predetermined and random values
  for |@positive, |@patterns -> $value is copy {

    # make sure we never exceed 64 int values for 8,16,32,64 bit read/write
    $value +&= 1 +< 63 - 1 if $bytes != 16;
    
    # values to test against
    my \existing := buf8.new(0 xx (@byte-widths[*-1] + 8));
    my $elems    := existing.elems;
    my $returned := $value +& $mask;

    # run for all possible offsets wrt 64-bit alignments
    for ^8 -> $offset {

      subtest {
        plan 3 * (3 + @endians * 3);

        # tests on existing buf
        is-deeply existing."$write"($offset,$value), existing,
          "does existing $write $offset $value return existing";
        is existing.elems, $elems,
          "did existing $write $offset $value not change size";
        is existing."$read"($offset), $returned,
          "did existing $read $offset give $returned";

        for @endians -> $endian {
          is-deeply existing."$write"($offset,$value,$endian), existing,
            "does existing $write $offset $value $endian return existing";
          is existing.elems, $elems,
            "did existing $write $offset $value $endian not change size";
          is existing."$read"($offset,$endian), $returned,
            "did existing $read $offset $endian give $returned";
        }

        # tests on type object
        my $fromtype := buf8."$write"($offset,$value);
        ok $fromtype ~~ buf8, 'did we get a buf8?';
        is $fromtype.elems, $offset + $bytes,
          "did type $write $offset $value set size {$offset + $bytes}";
        is $fromtype."$read"($offset), $returned,
          "did type $read $offset give $returned";

        for @endians -> $endian {
          my $fromtype := buf8."$write"($offset,$value,$endian);
          ok $fromtype ~~ buf8, 'did we get a buf8?';
          is $fromtype.elems, $offset + $bytes,
            "did type $write $offset $value $endian set size {$offset + $bytes}";
          is $fromtype."$read"($offset,$endian), $returned,
            "did type $read $offset $endian give $returned";
        }

        # tests on new buf
        is-deeply (my $buf := buf8.new)."$write"($offset,$value), $buf,
          "does new $write $offset $value return \$buf";
        is $buf.elems, $offset + $bytes,
          "did new $write $offset $value set size {$offset + $bytes}";
        is $buf."$read"($offset), $returned,
          "did new $read $offset give $returned";

        for @endians -> $endian {
          is-deeply (my $buf := buf8.new)."$write"($offset,$value,$endian),$buf,
            "does new $write $offset $value $endian return \$buf";
          is $buf.elems, $offset + $bytes,
            "did new $write $offset $value $endian set size {$offset + $bytes}";
          is $buf."$read"($offset,$endian), $returned,
            "did new $read $offset $endian give $returned";
        }
      }, "did all tests pass for $write $offset $value";
    }
  }
}

# run for all possible methods setting / returning possibly signed values
for @imethods -> $bytes, $mask, $write, $read {

  subtest {
    plan 3 + @endians * 3;

    dies-ok { buf8."$write"(-1,-42) },
      "does $write -1 -42 die on type object";
    dies-ok { buf8.new."$write"(-1,-42) },
      "does $write -1 -42 die on uninited";
    dies-ok { buf8.new(255)."$write"(-1,-42) },
      "does $write -1 -42 die on inited";

    for @endians -> $endian {
      dies-ok { buf8."$write"(-1,-42,$endian) },
        "does $write -1 -42 $endian die on type object";
      dies-ok { buf8.new."$write"(-1,-42,$endian) },
        "does $write -1 -42 $endian die on uninited";
      dies-ok { buf8.new(255)."$write"(-1,-42,$endian) },
        "does $write -1 -42 $endian die";
    }
  }, "did all possible negative offsets die";

  # run for a set or predetermined and random values
  for |@may-be-negative, |@positive, |@patterns -> $value is copy {

    # make sure we never exceed 64 int values for 8,16,32,64 bit read/write
    $value +&= 1 +< 63 - 1 if $bytes != 16;
    
    # values to test against
    my \existing := buf8.new(0 xx (@byte-widths[*-1] + 8));
    my $elems    := existing.elems;
    my $returned := $value +& $mask;

    # convert expected result to negative version if top bit set
    $returned := $returned - $mask - 1 if $returned > $mask +> 1;

    # run for all possible offsets wrt 64-bit alignments
    for ^8 -> $offset {

      subtest {
        plan 3 * (3 + @endians * 3);

        # tests on existing buf
        is-deeply existing."$write"($offset,$value), existing,
          "does existing $write $offset $value return existing";
        is existing.elems, $elems,
          "did existing $write $offset $value not change size";
        is existing."$read"($offset), $returned,
          "did existing $read $offset give $returned";

        for @endians -> $endian {
          is-deeply existing."$write"($offset,$value,$endian), existing,
            "does existing $write $offset $value $endian return existing";
          is existing.elems, $elems,
            "did existing $write $offset $value $endian not change size";
          is existing."$read"($offset,$endian), $returned,
            "did existing $read $offset $endian give $returned";
        }

        # tests on type object
        my $fromtype := buf8."$write"($offset,$value);
        ok $fromtype ~~ buf8, 'did we get a buf8?';
        is $fromtype.elems, $offset + $bytes,
          "did type $write $offset $value set size {$offset + $bytes}";
        is $fromtype."$read"($offset), $returned,
          "did type $read $offset give $returned";

        for @endians -> $endian {
          my $fromtype := buf8."$write"($offset,$value,$endian);
          ok $fromtype ~~ buf8, "did we get a buf8 with $endian?";
          is $fromtype.elems, $offset + $bytes,
            "did type $write $offset $value $endian set size {$offset + $bytes}";
          is $fromtype."$read"($offset,$endian), $returned,
            "did type $read $offset $endian give $returned";
        }

        # tests on new buf
        is-deeply (my $buf := buf8.new)."$write"($offset,$value), $buf,
          "does new $write $offset $value return \$buf";
        is $buf.elems, $offset + $bytes,
          "did new $write $offset $value set size {$offset + $bytes}";
        is $buf."$read"($offset), $returned,
          "did new $read $offset give $returned";

        for @endians -> $endian {
          is-deeply (my $buf := buf8.new)."$write"($offset,$value,$endian),$buf,
            "does new $write $offset $value $endian return \$buf";
          is $buf.elems, $offset + $bytes,
            "did new $write $offset $value $endian set size {$offset + $bytes}";
          is $buf."$read"($offset,$endian), $returned,
            "did new $read $offset $endian give $returned";
        }
      }, "did all tests pass for $write $offset $value";
    }
  }
}

# vim: expandtab shiftwidth=4
