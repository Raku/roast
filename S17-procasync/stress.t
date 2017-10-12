use v6;
use lib <packages/>;
use lib <t/spec/packages/>;
use Test;
use Test::Util;

plan 23;

# RT #125515
{
    constant $read-file = "t/spec/packages/README".IO.f ?? "t/spec/packages/README".IO !! "packages/README".IO;
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

# RT #129291
{
    if $*DISTRO.is-win {
        skip 1, 'not sure how to test input redirection on Windows';
    } else {
        lives-ok
            { for ^400 { my $p = run(:out, :bin, 'ls'); run(:in($p.out), 'true') } },
            "run()ning two procs and passing the :out of one to the :in of the other doesn't segfault";
    }
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
