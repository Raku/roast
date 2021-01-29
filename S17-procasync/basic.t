use v6;

use Test;

plan 47;

my $pc = $*DISTRO.is-win
    ?? Proc::Async.new( 'cmd', </c echo Hello World> )
    !! Proc::Async.new( 'echo', <Hello World> );
isa-ok $pc, Proc::Async;

my $so = $pc.stdout;
cmp-ok $so, '~~', Supply;
my $se = $pc.stderr;
cmp-ok $se, '~~', Supply;

my $stdout = "";
my $stderr = "";
$so.act: { $stdout ~= $_ };
$se.act: { $stderr ~= $_ };

nok $pc.started, 'program not yet started';
nok $pc.w, 'Not opened for writing';

my $pm = $pc.start;
isa-ok $pm, Promise;

ok $pc.started, 'program has been started';

throws-like { $pc.start }, X::Proc::Async::AlreadyStarted;

throws-like { $pc.print("foo")      }, X::Proc::Async::OpenForWriting, :method<print>;
throws-like { $pc.say("foo")        }, X::Proc::Async::OpenForWriting, :method<say>;
throws-like { $pc.write(Buf.new(0)) }, X::Proc::Async::OpenForWriting, :method<write>;

throws-like { $pc.stdout.tap(&say)  }, X::Proc::Async::TapBeforeSpawn, :handle<stdout>;
throws-like { $pc.stderr.tap(&say)  }, X::Proc::Async::TapBeforeSpawn, :handle<stderr>;

my $pid = $pc.pid;
isa-ok $pid, Promise, 'pid method returns a Promise';
ok await($pid) > 0, 'Can get the process ID';

my $ps = await $pm;
cmp-ok $pc.ready.status, '~~', Kept, "was ready kept after succesful execution";
isa-ok $ps, Proc;
ok $ps, 'was execution successful';
is $ps.?exitcode, 0, 'is the status ok';

is $stdout, "Hello World\n", 'did we get STDOUT';
is $stderr, "",              'did we get STDERR';

# now test one for writing

$pc = $*DISTRO.is-win
    ?? Proc::Async.new( :w, 'cmd', </c type con> )
    !! Proc::Async.new( :w, 'cat', );

ok $pc.w, 'opened for writing';

throws-like { $pc.close-stdin }, X::Proc::Async::MustBeStarted, :method<close-stdin>;
throws-like { $pc.kill },        X::Proc::Async::MustBeStarted, :method<kill>;
throws-like { $pc.say(42) },     X::Proc::Async::MustBeStarted, :method<say>;
throws-like { $pc.print(42) },   X::Proc::Async::MustBeStarted, :method<print>;
throws-like { $pc.write(Buf.new(0)) }, X::Proc::Async::MustBeStarted, :method<write>;

$stdout = '';
$stderr = '';
$pc.stdout.act: { $stdout ~= $_ };
$pc.stderr.act: { $stderr ~= $_ };

throws-like { $pc.stdout(:bin) }, X::Proc::Async::CharsOrBytes, :handle<stdout>;

my $start-promise := $pc.start;

# "Raku" as hex:
my $write-promise = $pc.write(Buf.new(0x52, 0x61, 0x6B, 0x75));
isa-ok $write-promise, Promise, '.write returned a promise';
await $write-promise;
my $print-promise = $pc.print(' 6');
isa-ok $print-promise, Promise, '.print returned a promise';
await $print-promise;

is $start-promise.status, Planned, 'external program still running (stdin still open)';
$pc.close-stdin;

# https://github.com/Raku/old-issue-tracker/issues/4181
#?rakudo 3 skip 'returns Nil (flapping tests)'
isa-ok $start-promise.result, Proc, 'Can finish, return Proc';

is $stdout, 'Raku 6', 'got correct STDOUT';
is $stderr, '',       'got correct STDERR';

# https://github.com/Raku/old-issue-tracker/issues/5695
{
    my @args := $*EXECUTABLE.absolute, "-e", "exit";
    is-deeply (await (my $p := Proc::Async.new: @args).start).command, @args,
        'Proc returned from .start has correct .command';
    # https://github.com/rakudo/rakudo/issues/2444
    is-deeply $p.command, @args, 'Proc::Async.command has correct args';
}

# Check we don't have races if you tap the stdout supply after starting.
{
    my $pc = $*DISTRO.is-win
        ?? Proc::Async.new( 'cmd', </c echo Hello World> )
        !! Proc::Async.new( 'echo', <Hello World> );
    my $stdout = $pc.stdout;
    my $done = $pc.start;
    sleep 0.1; # Enough to make the test flap if we're doing things wrong
    my $captured = '';
    $stdout.tap({ $captured ~= $_ });
    await $done;
    is $captured, "Hello World\n",
        "Tapping stdout supply after start of process does not lose data";
}

{
    $pc = Proc::Async.new: $*EXECUTABLE, '-e', '';
    my $no-output = True;
    $pc.stderr.tap: { $no-output = False }
    $pc.stdout.tap: { $no-output = False }
    await $pc.start;
    ok $no-output, "Process that doesn't output anything does not emit";
}

# https://github.com/Raku/old-issue-tracker/issues/6078
{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*OUT.write(Blob.new(65, 66, 67, 13, 10))');
    my $result = '';
    $proc.stdout.tap({ $result ~= $_ });
    await $proc.start;
    #?rakudo.jvm todo 'wrong handling of \r\n'
    is $result, "ABC\n", '\r\n is translated in character mode to \n';
}

# Note: it's crucial for the test below that the first positional
# argument is a list of items. Do not refactor it out!
with Proc::Async.new: :out, ($*EXECUTABLE, '-e'), 'say "pass"' {
    my $res = '';
    .stdout.tap: { $res ~= $_ }
    await .start;
    is-deeply $res, "pass\n", '.new slurps all args, including command';
}

# Merged stdout/stderr (buffering means we should not over-commit on the exact
# ordering of output), at least not unless we find a way to more robustly do so.
{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', 'say "boo"; note "boo";');
    my $merged = '';
    $proc.Supply.tap({ $merged ~= $_ });
    await $proc.start;
    is $merged, "boo\nboo\n", '.Supply gives merged stdout/stderr';
}

throws-like { my $proc = Proc::Async.new($*EXECUTABLE); $ = $proc.Supply; $= $proc.stdout },
    X::Proc::Async::SupplyOrStd,
    'Cannot do .stdout after .Supply';
throws-like { my $proc = Proc::Async.new($*EXECUTABLE); $ = $proc.Supply; $= $proc.stderr },
    X::Proc::Async::SupplyOrStd,
    'Cannot do .stderr after .Supply';
throws-like { my $proc = Proc::Async.new($*EXECUTABLE); $= $proc.stdout; $ = $proc.Supply },
    X::Proc::Async::SupplyOrStd,
    'Cannot do .Supply after stdout';
throws-like { my $proc = Proc::Async.new($*EXECUTABLE); $= $proc.stderr; $ = $proc.Supply },
    X::Proc::Async::SupplyOrStd,
    'Cannot do .Supply after stderr';

subtest '.new accepts command + args via a single Iterable arg' => {
    plan 3;
    with Proc::Async.new: «"$*EXECUTABLE" -e "print 'test passed'"» {
        my $stdout = ''; my $stderr = '';
        .stdout.tap: {$stdout ~= $_};
        .stderr.tap: {$stderr ~= $_};
        my $proc = await .start;
        is-deeply $stdout, 'test passed', 'stdout is good';
        is-deeply $stderr, '',            'stderr is empty';
        cmp-ok $proc.exitcode, '==', 0,   'exit code successful';
    }
}

subtest 'Specifying ARG0 via separate arg works.' => {
    plan 4;
    if $*DISTRO.is-win {
        sub test-run($arg0, $expected) is test-assertion {
            my $proc = run($*EXECUTABLE,
                $?FILE.IO.parent.child('windows-print-raw-args.p6'),
                :$arg0, 'some-other-arg', :out);
            my $out = $proc.out.slurp(:close).trim-trailing();
            ok $out ~~ / ^ $expected ' ' \S /, "\"$out\" has \"$expected\" as first arg";
        }
        test-run 'some-name', 'some-name';
        test-run 'some name', '"some name"';
        test-run ' ', '" "';
        test-run '', '';
    }
    else {
# There is no simple way to access arg0 from either a Raku script
# or a sh script on unixes. So this can't be tested on *nix for now.
         skip("No way to portably determine arg0 on *nix.", 4);
#        sub test-run($arg0, @args, $expected) is test-assertion {
#            my $proc = run('sh',
#                $?FILE.IO.parent.child('unix-print-args.sh'),
#                :$arg0, |@args, :out);
#            my $out = $proc.out.slurp(:close).trim-trailing();
#            is $out, $expected, $expected;
#        }
#        test-run 'some-name', ('a',), 'some-name:a';
#        test-run 'some name', ('a',), 'some name:a';
#        test-run ' ', ('a',), ' :a';
#        test-run '', ('a',), ':a';
    }
}

# vim: expandtab shiftwidth=4
