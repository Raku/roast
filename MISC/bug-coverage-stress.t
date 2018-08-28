use v6.c;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;

# This file is for random bugs that don't really fit well in other places
# or ones that need to be only part of strestest and not spectest.
# Feel free to move the tests to more appropriate places.

plan 12;

# RT #132042
doesn't-hang ｢
    my $fh = ｣ ~ make-temp-file.perl ~ ｢.open: :w;
    await ^20 .map: -> $t {
        start {
            for ^500 -> $i {
                my $current = %( 1 => %( 2 => %( 3 => %() ) ));
                my $index = 1;
                while $current{$index}:exists {
                    $fh.say: "$t $i $index";
                    $current = $current{$index};
                    ++$index;
                }
            }
        }
    }
    print 'pass';
｣, :5wait, :out<pass>, 'no deadlock while acquiring mutex';


# RT #132016
#?rakudo.jvm skip "The spawned command './perl6-j' exited unsuccessfully (exit code: 1)"
#?DOES 1
if $*DISTRO.is-win {
  skip 'Test hangs on Windows: https://github.com/rakudo/rakudo/issues/1975';
}
else {
  with Proc::Async.new: $*EXECUTABLE, '-e',
    ｢react whenever signal(SIGTERM).merge(signal SIGINT) { print ‘pass’; exit 0 }｣
  -> $proc {
    my $out = ''; $proc.Supply.tap: { $out ~= $_ };
    my $p = $proc.start;
    await $proc.ready;
    Promise.in(
        # Currently JVM backend takes longer to start the proc, so
        # let's wait longer before killing
        ($*VM.name eq 'jvm' ?? 20/3 !! 1) * (%*ENV<ROAST_TIMING_SCALE>//1)
    ).then: {$proc.kill: SIGINT}; # give it a chance to boot up, then kill it
    await $p;
    #?rakudo.jvm todo 'Died with the exception: Cannot unbox a type object'
    is-deeply $out, 'pass', 'Supply.merge on signals does not crash';
  }
}

# RT #129845
with make-temp-dir() -> $dir {
    $dir.add("$_$_$_").spurt("") for "a".."z";

    ## Read the folder from multiple threads, and sanity-check each IO::Path.
    ## The sanity check should never fail, but at some point it does.
    is_run q:to/♥/,
        await do for ^200 {
            start {
                for \qq[$dir.perl()].dir -> $path {
                    die "FAILED!" if $path.absolute ne $path.Str
                }
            }
        }
        print 'pass';
    ♥
    {:out<pass>, :err(''), :0status},
    'dir() does not produce wrong results under concurrent load';
}

# RT #129291
# "invalid free" bug is present on Rakudo 2016.07. Running something with
# slower startup, like $*EXECUTABLE, does not exercise the bug, so we use `echo`
#?rakudo.jvm skip 'hangs'
{
  if run :!out, :!err, «echo 42» {
    for ^50 {
        my $p = run :out, :bin, «echo 42»;
        run :in($p.out), :!out, :!err, «echo 42»;
    }
    pass "no issues when piping one Proc's STDOUT to another's STDIN";
  }
  else {
    skip 'need `echo` to run this test';
  }
}

# https://github.com/tokuhirom/p6-WebSocket/issues/15#issuecomment-339120879
# RT #132343
is_run ｢
    # fire up a few socks first to fill up affinity workers to make
    # the bug more prevalent
    IO::Socket::Async.listen: '127.0.0.1', 15556 + $_ for ^10;

    start react whenever IO::Socket::Async.listen: '127.0.0.1', 15555 {
        supply {
            whenever $_ {
                print 'pass';
                exit;
            }
        }.Seq
    }
    sleep .2;
    .print: "x\n" with IO::Socket::INET.new: :host<127.0.0.1>, :15555port;
    sleep 2;
｣, {:out<pass>, :err(''), :0status}, 'supply inside sock does not hang';

# RT #127959
given make-temp-dir() {
    .child('myclass.pm6').spurt: ｢
        unit class myclass;
        use mytraitmodule;

        has $!bar is mytrait;
    ｣;

    .child('mytraitmodule.pm6').spurt: ｢
        unit module mytraitmodule;
        my role rrHOW {
            method compose(Mu \type) {
                type.^add_method('nn', method (Mu:D:) { return 'nn' ; } );
                callsame;
            }
        }

        multi trait_mod:<is>(Attribute:D $attr, :$mytrait! ) is export {
            $attr.package.HOW does rrHOW;
        }
    ｣;

    is_run ｢use myclass; print 'pass'｣, :compiler-args['-I', .absolute],
        {:err(''), :out<pass>, :0status},
    'no serialization crashes with roles and traits';
}

# https://github.com/rakudo/rakudo/issues/1413
#?rakudo.jvm todo 'IllegalArgumentException: bad parameter count 850; https://github.com/rakudo/rakudo/issues/1413'
my $package-lib-prefix = $?FILE.IO.parent(2).IO.add('packages').absolute;
is_run ｢use RAKUDO1413; print 'pass'｣,
    :compiler-args['-I', $package-lib-prefix],
    {:out<pass>, :err(''), :0status},
'no crashes with giant enums in packages';

# https://github.com/rakudo/rakudo/issues/1483
{
    for ^5 { sub meow ($) {}; for ^300 {$^i %% $_ && meow "$_ " for ^$i} }
    pass 'no segfault in a `for` loop + some ops';
}

{ # https://github.com/rakudo/rakudo/issues/1550
    my &f = *.self;
    $_».self    given map 1/*.&f, ^550+1;
    .eager.self for   map 1/*.&f, ^550+1;
    pass 'no crashes with Whatever curries in topics of for/given statement modifiers';
}

#?rakudo.jvm skip 'atomicint NYI'
{ # https://github.com/rakudo/rakudo/issues/1535
    my class R1535Log::Async {
        has $.supplier = Supplier.new;
        has $.supply = $!supplier.Supply;

        my $instance = R1535Log::Async.new;
        method instance {
            return $instance
        }
    }

    sub foo() {
        R1535Log::Async.instance.supplier.emit: ‘AAAAAAA!!!’
    }

    my atomicint $x;
    R1535Log::Async.instance.supply.act: { $x ⚛+= .chars };
    Promise.at(now).then(&foo).then(&foo).then(&foo).then: &foo for ^100;
    sleep 1;
    #?rakudo todo 'https://github.com/rakudo/rakudo/issues/1535'
    is $x, 4000, 'collected right amount of characters (with &foo)';
}

#?rakudo.jvm skip 'atomicint NYI'
{ # https://github.com/rakudo/rakudo/issues/1535
    my class R1535Log::Async {
        has $.supplier = Supplier.new;
        has $.supply = $!supplier.Supply;

        my $instance = R1535Log::Async.new;
        method instance {
            return $instance
        }
    }

    sub foo() {
        R1535Log::Async.instance.supplier.emit: ‘AAAAAAA!!!’
    }

    my atomicint $x;
    R1535Log::Async.instance.supply.act: { $x ⚛+= .chars };
    for ^100 {
        Promise.at(now).then({ foo }).then({ foo }).then({ foo }).then({ foo })
    }
    sleep 1;
    is $x, 4000, 'collected right amount of characters (with { foo })';
}

# https://github.com/rakudo/rakudo/issues/2120
is-deeply ((1..10)[2.polymod($_ xx 1000).map($_ ** *) »%» *] with 1),
    2 xx 1001, "no SEGV in curries + with";

# vim: expandtab shiftwidth=4 ft=perl6
