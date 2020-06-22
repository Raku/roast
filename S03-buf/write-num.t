use v6;

#BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = 1;
use Test;

# bit/byte widths tested
my @endians = NativeEndian, LittleEndian, BigEndian;
my @byte-widths = 4,8;
my @bit-widths  = @byte-widths.map: * * 8;

# set up method data: byte-width, mask, write-uintX, read-uintX
my @methods = @bit-widths.map: {
    |($_ / 8, 1 +< $_ - 1, "write-num$_","read-num$_")
}

# values that should always yield a positive result with read-intX()
my @values = (
  0e0, 1e0, -1e0, 42e0, -42e0
);

plan (@methods / 4)
   + @byte-widths * @values * 8
;

# run for all possible methods setting / returning unsigned values
for @methods -> $bytes, $mask, $write, $read {

  subtest {
    plan 3 + @endians * 3;

    dies-ok { buf8."$write"(-1,42e0) },
      "does $write -1 42e0 die on type object";
    dies-ok { buf8.new."$write"(-1,42e0) },
      "does $write -1 42e0 die on uninited";
    dies-ok { buf8.new(255)."$write"(-1,42e0) },
      "does $write -1 42e0 die on inited";

    for @endians -> $endian {
      dies-ok { buf8."$write"(-1,42e0,$endian) },
        "does $write -1 42e0 $endian die on type object";
      dies-ok { buf8.new."$write"(-1,42e0,$endian) },
        "does $write -1 42e0 $endian die on uninited";
      dies-ok { buf8.new(255)."$write"(-1,42e0,$endian) },
        "does $write -1 42e0 $endian die";
    }
  }, "did all possible negative offsets die";

  # run for a set or predetermined and random values
  for @values -> $value {
    
    # values to test against
    my \existing := buf8.new(0 xx (@byte-widths[*-1] + 8));
    my $elems    := existing.elems;

    # run for all possible offsets wrt 64-bit alignments
    for ^8 -> $offset {

      subtest {
        plan 3 * (3 + @endians * 3);

        # tests on existing buf
        is-deeply existing."$write"($offset,$value), existing,
          "does existing $write $offset $value return existing";
        is existing.elems, $elems,
          "did existing $write $offset $value not change size";
        is existing."$read"($offset), $value,
          "did existing $read $offset give $value";

        for @endians -> $endian {
          is-deeply existing."$write"($offset,$value,$endian), existing,
            "does existing $write $offset $value $endian return existing";
          is existing.elems, $elems,
            "did existing $write $offset $value $endian not change size";
          is existing."$read"($offset,$endian), $value,
            "did existing $read $offset $endian give $value";
        }

        # tests on type object
        my $fromtype := buf8."$write"($offset,$value);
        ok $fromtype ~~ buf8, 'did we get a buf8?';
        is $fromtype.elems, $offset + $bytes,
          "did type $write $offset $value set size {$offset + $bytes}";
        is $fromtype."$read"($offset), $value,
          "did type $read $offset give $value";

        for @endians -> $endian {
          my $fromtype := buf8."$write"($offset,$value,$endian);
          ok $fromtype ~~ buf8, "did we get a buf8 for $endian?";
          is $fromtype.elems, $offset + $bytes,
            "did new $write $offset $value $endian set size {$offset + $bytes}";
          is $fromtype."$read"($offset,$endian), $value,
            "did new $read $offset $endian give $value";
        }

        # tests on new buf
        is-deeply (my $buf := buf8.new)."$write"($offset,$value), $buf,
          "does new $write $offset $value return \$buf";
        is $buf.elems, $offset + $bytes,
          "did new $write $offset $value set size {$offset + $bytes}";
        is $buf."$read"($offset), $value,
          "did new $read $offset give $value";

        for @endians -> $endian {
          is-deeply (my $buf := buf8.new)."$write"($offset,$value,$endian),$buf,
            "does new $write $offset $value $endian return \$buf";
          is $buf.elems, $offset + $bytes,
            "did new $write $offset $value $endian set size {$offset + $bytes}";
          is $buf."$read"($offset,$endian), $value,
            "did new $read $offset $endian give $value";
        }
      }, "did all tests pass for $write $offset $value";
    }
  }
}

# vim: expandtab shiftwidth=4
