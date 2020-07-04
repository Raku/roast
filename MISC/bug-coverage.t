use v6.c;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

# This file is for random bugs that don't really fit well in other places.
# Feel free to move the tests to more appropriate places.

plan 17;

# https://github.com/rakudo/rakudo/issues/2280
is-deeply (11**5, */-2 … 0)[31], <-161051/2147483648>,
    'thou shall not coredump';

subtest '.count-only/.bool-only for iterated content' => {
    plan 25;

    test-iter-opt  <a b c>.iterator,         3, 'List.iterator';
    test-iter-opt  <a b c>.reverse.iterator, 3, 'List.reverse.iterator';
    test-iter-opt [<a b c>].iterator,        3, 'Array.iterator';
    test-iter-opt Buf.new(1, 2, 3).iterator, 3, 'Buf.iterator';

    test-iter-opt     combinations(4,1).iterator, 4, '&combinations';
    test-iter-opt     permutations(2)  .iterator, 2, '&permutations';
    test-iter-opt ^4 .combinations(1)  .iterator, 4, '.combinations';
    test-iter-opt ^2 .permutations.iterator,      2, '.permutations';

    test-iter-opt :42foo.iterator,     1, 'Pair.iterator';
    test-iter-opt :42foo.kv.iterator,  2, 'Pair.kv.iterator';
    test-iter-opt %(:42foo, :70bar).kv.iterator, 4, 'Hash.kv.iterator';
    test-iter-opt %(:42foo, :70bar, :2meow).keys.iterator, 3, 'Hash.keys.iterator';

    test-iter-opt "a\nb\nc".lines.iterator, 3, 'Str.lines.iterator';
    test-iter-opt (my @a[5]).iterator,      5, '1 dim shaped array';
    test-iter-opt 'abc'.comb.iterator,      3, 'Str.comb';
    test-iter-opt 'abc'.comb(/./).iterator, 3, 'Str.comb(Regex)';
    test-iter-opt 'abc'.comb(2).iterator,   2, 'Str.comb(Int)';
    test-iter-opt 'aba'.comb('a').iterator, 2, 'Str.comb(Str)';
    test-iter-opt ^3 .iterator,         (0, 1, 2), 'Range';
    test-iter-opt ^3 .reverse.iterator, (2, 1, 0), 'Range.reverse';

    (my @l := (1, 2, 3)).elems; # reify
    test-iter-opt @l.iterator,         (1, 2, 3), 'reified list';
    test-iter-opt @l.reverse.iterator, (3, 2, 1), 'reified list reverse';

    (my int @l-n = 1, 2, 3);
    test-iter-opt @l-n.iterator,         (1, 2, 3), 'reified list';
    test-iter-opt @l-n.reverse.iterator, (3, 2, 1), 'reified list reverse';

    test-iter-opt Bag.new(<a b c>).pick(2).iterator, 2, 'baggy .pick(n)';
}

# https://github.com/rakudo/rakudo/issues/1407
subtest 'enums with names of core types do not blow things up unexpectedly' => {
    plan 3;
    my enum Foo «:Map<foo> :Positional<ber> :Callable<meow>»;
    my %h = :42foo, :70bar;
    my &foo = *.self;
    my @a = <a b c>;
    is-deeply %h,      %(:42foo, :70bar), 'Hash works';
    is-deeply foo(42), 42,                'Callable works';
    is-deeply @a,      [<a b c>],         'Array works';
}

# https://github.com/Raku/old-issue-tracker/issues/6664
subtest 'no crashes with native types in conditionals' => {;
    plan 6;
    subtest 'if' => {
        plan 12;
        ->        $x { pass 'HLL obj' if $x }(now);
        -> int8   $x { pass 'int8'    if $x }(2);
        -> int16  $x { pass 'int16'   if $x }(2);
        -> int32  $x { pass 'int32'   if $x }(2);
        -> int64  $x { pass 'int64'   if $x }(2);

        -> uint8  $x { pass 'uint8'  if $x }(2);
        -> uint16 $x { pass 'uint16' if $x }(2);
        -> uint32 $x { pass 'uint32' if $x }(2);
        -> uint64 $x { pass 'uint64' if $x }(2);

        -> num32  $x { pass 'num32'  if $x }(2e0);
        -> num64  $x { pass 'num64'  if $x }(2e0);
        -> str    $x { pass 'str'    if $x }('meow');
    }

    subtest 'unless' => {
        plan 12;
        sub (       $x) { return unless $x; pass 'HLL obj' }(now);
        sub (int8   $x) { return unless $x; pass 'int8'    }(2);
        sub (int16  $x) { return unless $x; pass 'int16'   }(2);
        sub (int32  $x) { return unless $x; pass 'int32'   }(2);
        sub (int64  $x) { return unless $x; pass 'int64'   }(2);

        sub (uint8  $x) { return unless $x; pass 'uint8'   }(2);
        sub (uint16 $x) { return unless $x; pass 'uint16'  }(2);
        sub (uint32 $x) { return unless $x; pass 'uint32'  }(2);
        sub (uint64 $x) { return unless $x; pass 'uint64'  }(2);

        sub (num32  $x) { return unless $x; pass 'num32'   }(2e0);
        sub (num64  $x) { return unless $x; pass 'num64'   }(2e0);
        sub (str    $x) { return unless $x; pass 'str'     }('meow');
    }

    subtest 'repeat while' => {
        plan 12;
        sub (       $x) { while $x { pass 'HLL obj'; return } }(now);
        sub (int8   $x) { while $x { pass 'int8';    return } }(2);
        sub (int16  $x) { while $x { pass 'int16';   return } }(2);
        sub (int32  $x) { while $x { pass 'int32';   return } }(2);
        sub (int64  $x) { while $x { pass 'int64';   return } }(2);

        sub (uint8  $x) { while $x { pass 'uint8';   return } }(2);
        sub (uint16 $x) { while $x { pass 'uint16';  return } }(2);
        sub (uint32 $x) { while $x { pass 'uint32';  return } }(2);
        sub (uint64 $x) { while $x { pass 'uint64';  return } }(2);

        sub (num32  $x) { while $x { pass 'num32';   return } }(2e0);
        sub (num64  $x) { while $x { pass 'num64';   return } }(2e0);
        sub (str    $x) { while $x { pass 'str';     return } }('meow');
    }

    subtest 'repeat until' => {
        plan 12;
        sub (       $x) { Nil until $x; pass 'HLL obj' }(now);
        sub (int8   $x) { Nil until $x; pass 'int8'    }(2);
        sub (int16  $x) { Nil until $x; pass 'int16'   }(2);
        sub (int32  $x) { Nil until $x; pass 'int32'   }(2);
        sub (int64  $x) { Nil until $x; pass 'int64'   }(2);

        sub (uint8  $x) { Nil until $x; pass 'uint8'   }(2);
        sub (uint16 $x) { Nil until $x; pass 'uint16'  }(2);
        sub (uint32 $x) { Nil until $x; pass 'uint32'  }(2);
        sub (uint64 $x) { Nil until $x; pass 'uint64'  }(2);

        sub (num32  $x) { Nil until $x; pass 'num32'   }(2e0);
        sub (num64  $x) { Nil until $x; pass 'num64'   }(2e0);
        sub (str    $x) { Nil until $x; pass 'str'     }('meow');
    }

    subtest 'repeat while' => {
        plan 12;
        sub (       $x) { repeat { pass 'HLL obj'; return } while $x }(now);
        sub (int8   $x) { repeat { pass 'int8';    return } while $x }(2);
        sub (int16  $x) { repeat { pass 'int16';   return } while $x }(2);
        sub (int32  $x) { repeat { pass 'int32';   return } while $x }(2);
        sub (int64  $x) { repeat { pass 'int64';   return } while $x }(2);

        sub (uint8  $x) { repeat { pass 'uint8';   return } while $x }(2);
        sub (uint16 $x) { repeat { pass 'uint16';  return } while $x }(2);
        sub (uint32 $x) { repeat { pass 'uint32';  return } while $x }(2);
        sub (uint64 $x) { repeat { pass 'uint64';  return } while $x }(2);

        sub (num32  $x) { repeat { pass 'num32';   return } while $x }(2e0);
        sub (num64  $x) { repeat { pass 'num64';   return } while $x }(2e0);
        sub (str    $x) { repeat { pass 'str';     return } while $x }('meow');
    }

    subtest 'repeat until' => {
        plan 12;
        sub (       $x) { repeat {} until $x; pass 'HLL obj' }(now);
        sub (int8   $x) { repeat {} until $x; pass 'int8'    }(2);
        sub (int16  $x) { repeat {} until $x; pass 'int16'   }(2);
        sub (int32  $x) { repeat {} until $x; pass 'int32'   }(2);
        sub (int64  $x) { repeat {} until $x; pass 'int64'   }(2);

        sub (uint8  $x) { repeat {} until $x; pass 'uint8'   }(2);
        sub (uint16 $x) { repeat {} until $x; pass 'uint16'  }(2);
        sub (uint32 $x) { repeat {} until $x; pass 'uint32'  }(2);
        sub (uint64 $x) { repeat {} until $x; pass 'uint64'  }(2);

        sub (num32  $x) { repeat {} until $x; pass 'num32'   }(2e0);
        sub (num64  $x) { repeat {} until $x; pass 'num64'   }(2e0);
        sub (str    $x) { repeat {} until $x; pass 'str'     }('meow');
    }
}

subtest 'thunking closure scoping' => {
    plan 11;

    # some canary tests to cover regressions when fixing other bugs in subtest
    is-deeply (42 andthen $_), 42, 'basic andthen';
    is-deeply gather {
        for ^2 -> \c { Nil for first { take c; 0 }, ^2; }
    }, (0, 0, 1, 1).Seq, 'nested `for`s with thunk in statement modifier';

    # https://github.com/rakudo/rakudo/issues/1212
    is-deeply <a b c>[$_ xx 2], <b b>.Seq, 'xx inside `with`' with 1;

    # https://github.com/Raku/old-issue-tracker/issues/6008
    is-deeply gather {
        sub itcavuc ($c) { try {take $c} andthen 42 };
        itcavuc $_ for 2, 4, 6;
    }, (2, 4, 6).Seq, 'try with block and andthen';

    # https://github.com/Raku/old-issue-tracker/issues/6625
    is-deeply gather {
        sub foo ($str) { { take $str }() orelse Nil }
        foo "cc"; foo "dd";
    }, <cc dd>.Seq, 'block in a sub with orelse';

    # https://github.com/Raku/old-issue-tracker/issues/6340
    is-deeply gather for ^7 {
        my $x = 1;
        1 andthen $x.take andthen $x = 2 andthen $x = 3 andthen $x = 4;
    }, 1 xx 7, 'loop + lexical variable plus chain of andthens';

    # https://github.com/Raku/old-issue-tracker/issues/6554
    is-deeply gather for <a b c> { $^v.uc andthen $v.take orelse .say },
        <a b c>.Seq, 'loop + andthen + orelse';

    # https://github.com/Raku/old-issue-tracker/issues/4731
    is-deeply gather { (.take xx 10) given 42 }, 42 xx 10,
        'parentheses + xx + given';

    # https://github.com/Raku/old-issue-tracker/issues/5291
    is-deeply gather { take ("{$_}") for <aa bb> }, <aa bb>.Seq,
        'postfix for + take + block in a string';

    # https://github.com/Raku/old-issue-tracker/issues/4663
    is-deeply gather { take (* + $_)(32) given 10 }, 42.Seq,
        'given + whatever code closure execution';

    # https://github.com/Raku/old-issue-tracker/issues/4901
    is-deeply gather {
        sub foo($x) { (* ~ $x)($_).take given $x }; foo(1); foo(2)
    }, ("11", "22").Seq, 'sub + given + whatevercode closure execution';

}

## test was moved from previous subtest 'thunking closure scoping' in order
## to make it fudgeable
# https://github.com/Raku/old-issue-tracker/issues/6553
#?rakudo.jvm skip 'UnwindException in thread "main"'
#?DOES 1
{
  subtest 'thunking closure scoping (2)' => {
    plan 1;

    is-deeply gather { sub {
        my $ver =.lines.uc with "totally-not-there".IO.open
            orelse "meow {$_ ~~ Failure}".take and return 42;
    }() }, 'meow True'.Seq, 'sub with `with` + orelse + block interpolation';
  }
}

# https://github.com/rakudo/rakudo/issues/1538
subtest 'block in string in parentheses in `for` statement mod' => {
    plan 4;
    sub foo($z) {
        my $x = ‘HERE: ’;
        $x ~= $_ for (« bar {$z} », 99);
        $x;
    }

    is-deeply (foo 111), 'HERE: bar 11199', 'first run';
    is-deeply (foo 222), 'HERE: bar 22299', 'second run';
    is-deeply (foo 333), 'HERE: bar 33399', 'third run';
    is-deeply (foo 444), 'HERE: bar 44499', 'fourth run';
}

{ # https://github.com/rakudo/rakudo/issues/1645
    sub f { 4 ?? 8 !! 15 }; f for ^10000;
    pass 'no segfaults in sub call with ternary';
}

{
    # https://github.com/Raku/old-issue-tracker/issues/5228
    my $failed = 0;

    sub match ($str, $flip) {
        return False if $flip eq "no";
        return $str ~~ rx/foo/;
    }

    for 0..104 {
        for "no", "yes" -> $flip {
            if my $match = match("something", $flip) {
                $failed++ unless $match;
            }
        }
    }

    is $failed, 0, '$match should not be true and false';
}

# https://github.com/rakudo/rakudo/issues/1695
subtest '$_ and with/andthen/for combinations are not buggy' => {
    plan 4;

    $_ = 42;
    is-deeply $_, ('24',), 'with (for -> ... { $_ })'
        with (for 1 -> $a { .flip });

    (for 1 -> $a { .flip }) andthen is-deeply $_, ('24',),
        'andthen (for -> ... { $_ })';

    is-deeply $_, '24', 'with (with -> ... { $_ })'
        with (with 1 -> $a { .flip });

    (with 1 -> $a { .flip }) andthen is-deeply $_, '24',
        'andthen (with -> ... { $_ })';
}

# https://github.com/MoarVM/MoarVM/issues/838
is_run ｢
    my @x = do for ^20 { [do for ^5 { ("a".."z").roll(3).join }] }
    print @x.elems
｣, {:out<20>, :err(''), :0status}, 'no "Illegal Instruction" crashes';

# https://github.com/rakudo/rakudo/issues/2222
throws-like ｢my $ = 5 »*» (2..4)｣, X::HyperOp::NonDWIM,
    'non DWIM hyper throws good error';

group-of 11 => 'cover potential bugs in possible optimization of `for ...`' => {
    my @a; for 0.1, 0.2 ... 1 -> $a { @a.push: $a };
    is-deeply @a, [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0], 'Rat, Rat ... Int';

    @a = (); for 0.1, 2 ... 3 -> $a { @a.push: $a };
    is-deeply @a, [0.1, 2.0], 'Rat, Int ... Int';

    @a = (); for 0.1, 0.2 ... 1.0 -> $a { @a.push: $a };
    is-deeply @a, [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0], 'Rat, Rat ... Rat';

    @a = (); for 1, 2 ... 3.0 -> $a { @a.push: $a };
    is-deeply @a, [1, 2, 3], 'Int, Int ... Rat';

    @a = (); for 1 ... 3.0 -> $a { @a.push: $a };
    is-deeply @a, [1, 2, 3], 'Int ... Rat';

    @a = (); for 1.0 ... 3 -> $a { @a.push: $a };
    is-deeply @a, [1.0, 2.0, 3.0], 'Rat ... Int';

    @a = (); for 1.0 ... 3.0 -> $a { @a.push: $a };
    is-deeply @a, [1.0, 2.0, 3.0], 'Rat ... Rat';

    for ^9223372036854775809 {last}
    pass 'no crashes with endpoint > 64-bit int (^)';
    for 0^..^9223372036854775809 {last}
    pass 'no crashes with endpoint > 64-bit int (^)';
    for 0^..9223372036854775809 {last}
    pass 'no crashes with endpoint > 64-bit int (^..)';
    for 0..^9223372036854775809 {last}
    pass 'no crashes with endpoint > 64-bit int (..^)';
}

group-of 2 => 'negative offset in JIT lables errors' => {
    # https://github.com/rakudo/rakudo/issues/2347
    is_run ｢my $a = ("a" x 200).comb; $a ~~ s:g/<ws>// for ^20; print 'pass'｣,
        {:out<pass>, :err(''), :0status}, '.comb';

    # https://github.com/rakudo/rakudo/issues/2346
    is_run ｢
        my token octet   { (\d+) }
        my regex address { <octet> ** 4 % '.' }
        my subset IPv4 of Str where / ^ <address> $ /;

        sub dec-to-ip(\d) {
            join('.', d +> 0x18 % 0x100, d +> 0x10 % 0x100, d +> 0x08 % 0x100, d % 0x100)
        }

        (0..32).roll(100).map: -> $bits {
            my IPv4 $x = dec-to-ip((2 ** $bits - 1) +< (32 - $bits))
        }
        print 'pass';
    ｣, {:out<pass>, :err(''), :0status}, 'tokens and subs';
}

{ # https://github.com/rakudo/rakudo/issues/2345
    (my $lib := make-temp-dir).add('Foo.pm6').spurt: ｢$ = IO::Path:D｣;
    is_run ｢use Foo; -> --> IO::Path:D {".".IO}(); print 'pass'｣,
        :compiler-args['-I', $lib.absolute], {:out<pass>, :err(''), :0status},
    'no weird type check issues with modules';
}

#?rakudo.jvm todo 'dies for unknown reason'
{ # https://github.com/rakudo/rakudo/issues/1207
    (my $lib := make-temp-dir).add('Foo.pm6').spurt:
        ｢our sub module-transform { my Int:D % = :1a }｣;
    is_run ｢
        use Foo;
        sub here-transform { my Int:D % = :1a }
        my Int:D %exp = :1a;
        module-transform() eqv %exp or die;
        here-transform()   eqv %exp or die;
        print 'pass';
    ｣, :compiler-args['-I', $lib.absolute], {:out<pass>, :err(''), :0status},
    'use of :D in a module does not mess up parametarization of a Hash';
}

{ # https://github.com/rakudo/rakudo/issues/2400
    my $lib := make-temp-dir;
    $lib.add('Bar.pm6').spurt: ｢my $ = Hash[Any:D,List:D]｣;
    $lib.add('Foo.pm6').spurt: ｢
        use Bar;
        our sub foo(--> Hash[Any:D,List:D]) { my Any:D %tree{List:D} }
    ｣;

    is_run ｢use Foo; foo; print 'pass'｣, :compiler-args['-I', $lib.absolute],
      {:out<pass>, :err(''), :0status},
    'use of Hash[…:D, …:D] in a module does not explode';
}

# vim: expandtab shiftwidth=4
