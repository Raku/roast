use v6;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;

plan 23;

# RT #125515
{
    constant $read-file = $?FILE.IO.parent(2).add("packages/README");
    $read-file.IO.r or bail-out "Missing $read-file that is needed to run a test";

    my @got;
    for ^400 {
        my $p = $*DISTRO.is-win
            ?? Proc::Async.new( | «cmd /c type $read-file» )
            !! Proc::Async.new( | «/bin/cat    $read-file» );
        my $output = '';
        $p.stdout.tap: -> $s { $output ~= $s; };
        await $p.start;
        @got.push: $output;
    }
    is @got.unique.elems, 1, 'Proc::Async consistently reads data';
}

# RT #129834
for ^10 {
    my $code = q:to'--END--';
		for ^4 {
			my @cmd = < df -li >;
			Supply.interval( 1 ).act: {
				my $proc = Proc::Async.new: |@cmd;
				$proc.stdout.act: -> $ {}, done => -> {}
			}
		}
		sleep 0.2;
        --END--
    is_run $code, { status => 0 }, "No race/crash in concurrent setup of Proc::Async objects ($_)";
}

# RT #122709
for 1..10 {
    my $code = q:to/CODE/;
        my $waiter = $*DISTRO.is-win
            ?? Proc::Async.new(<< cmd "/c" echo Hello >>).start
            !! Proc::Async.new(<< echo Hello >>).start;
        await start { await $waiter }
        CODE
    is_run $code, { status => 0 },
        'No hang with await start { await $proc-promise } construct ' ~ "($_)";
}

# We need something that's pretty fast to run; trying to use $*EXECUTABLE instead failed
# to repro the bug this is covering (bug present in 2017 commit ce12e480316
# RT #131763
if run :!out, :!err, «echo test» {
  doesn't-hang ｢
      for ^100 {
          my $proc = Proc::Async.new: «echo test»;
          react {
              whenever $proc       { }
              whenever $proc.start { }
          }
      }
      print 'pass';
  ｣, :5wait, :out<pass>, ".Supply on multiple Proc::Async's does not deadlock";
}
else {
    skip 'Need `echo` for this test'
}

# RT #130107
# Here, we start a proc that rapidly produces output. Theoretically,
# using $*EXECUTABLE here should be possible, but currently in rakudo it
# produces output too slowly to trigger the bug (bug is present in 2016.10
# rakudo release). So we use `perl` here for that.
if run :!out, :!err, «perl -e 'print 42'» {
    is_run ｢
        react {
            my $null = $*SPEC.devnull.&open: :w;
            my $find = Proc::Async.new: 'perl', '-e',
                'print "x" x 1000 for 1..2000';
            whenever $find.stdout(:bin) -> $line {
                QUIT { say .^name, .Str; }
                $null.print: $line.decode('utf8-c8');
            }
            whenever $find.start { print 'pass'; done }
        }
    ｣, {:out<pass>, :err(''), :0status}, 'no "unknown errors" on reads';
}
else {
    skip 'need `perl` to run this test';
}
