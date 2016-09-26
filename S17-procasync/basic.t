use v6;

use Test;

plan 31;

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
$so.act: { $stdout ~= $_.subst("\r\n", "\n", :g) };
$se.act: { $stderr ~= $_.subst("\r\n", "\n", :g) };

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

my $ps = await $pm;
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
$pc.stdout.act: { $stdout ~= $_.subst("\r\n", "\n", :g) };
$pc.stderr.act: { $stderr ~= $_.subst("\r\n", "\n", :g) };

throws-like { $pc.stdout(:bin) }, X::Proc::Async::CharsOrBytes, :handle<stdout>;

my $start-promise := $pc.start;

# "Perl" as hex:
my $write-promise = $pc.write(Buf.new(0x50, 0x65, 0x72, 0x6c));
isa-ok $write-promise, Promise, '.write returned a promise';
await $write-promise;
my $print-promise = $pc.print(' 6');
isa-ok $print-promise, Promise, '.print returned a promise';

is $start-promise.status, Planned, 'external program still running (stdin still open)';

$pc.close-stdin;

#?rakudo 3 skip 'returns Nil (flapping tests) RT #125047'
isa-ok $start-promise.result, Proc, 'Can finish, return Proc';

is $stdout, 'Perl 6', 'got correct STDOUT';
is $stderr, '',       'got correct STDERR';

{ # RT #129362
    is-deeply (await Proc::Async.new($*EXECUTABLE, "-e", "exit").start).command,
        [$*EXECUTABLE, "-e", "exit"],
        'Proc returned from .start has correct .command';
}
