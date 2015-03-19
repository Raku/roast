use v6;

use Test;

plan 30;

my $pc = $*DISTRO.is-win
    ?? Proc::Async.new( 'cmd', </c echo Hello World> )
    !! Proc::Async.new( 'echo', <Hello World> );
isa_ok $pc, Proc::Async;

my $so = $pc.stdout;
cmp_ok $so, '~~', Supply;
my $se = $pc.stderr;
cmp_ok $se, '~~', Supply;

my $stdout = "";
my $stderr = "";
$so.act: { $stdout ~= $_.subst("\r", "", :g) };
$se.act: { $stderr ~= $_.subst("\r", "", :g) };

nok $pc.started, 'program not yet started';
nok $pc.w, 'Not opened for writing';

my $pm = $pc.start;
isa_ok $pm, Promise;

ok $pc.started, 'program has been started';

throws_like { $pc.start }, X::Proc::Async::AlreadyStarted;

throws_like { $pc.print("foo")      }, X::Proc::Async::OpenForWriting, :method<print>;
throws_like { $pc.say("foo")        }, X::Proc::Async::OpenForWriting, :method<say>;
throws_like { $pc.write(Buf.new(0)) }, X::Proc::Async::OpenForWriting, :method<write>;

throws_like { $pc.stdout.tap(&say)  }, X::Proc::Async::TapBeforeSpawn, :handle<stdout>;

my $ps = await $pm;
isa_ok $ps, Proc::Status;
ok $ps, 'was execution successful';
is $ps.?exit, 0, 'is the status ok';

is $stdout, "Hello World\n", 'did we get STDOUT';
is $stderr, "",              'did we get STDERR';

# now test one for writing

$pc = $*DISTRO.is-win
    ?? Proc::Async.new( :w, 'cmd', </c type con> )
    !! Proc::Async.new( :w, 'cat', );

ok $pc.w, 'opened for writing';

throws_like { $pc.close-stdin }, X::Proc::Async::MustBeStarted, :method<close-stdin>;
throws_like { $pc.kill },        X::Proc::Async::MustBeStarted, :method<kill>;
throws_like { $pc.say(42) },     X::Proc::Async::MustBeStarted, :method<say>;
throws_like { $pc.print(42) },   X::Proc::Async::MustBeStarted, :method<print>;
throws_like { $pc.write(Buf.new(0)) }, X::Proc::Async::MustBeStarted, :method<write>;

$stdout = '';
$stderr = '';
$pc.stdout.act: { $stdout ~= $_.subst("\r", "", :g) };
$pc.stderr.act: { $stderr ~= $_.subst("\r", "", :g) };

throws_like { $pc.stdout(:bin) }, X::Proc::Async::CharsOrBytes, :handle<stdout>;

my $start-promise := $pc.start;

# "Perl" as hex:
my $write-promise = $pc.write(Buf.new(0x50, 0x65, 0x72, 0x6c));
isa_ok $write-promise, Promise, '.write returned a promise';
await $write-promise;
my $print-promise = $pc.print(' 6');
isa_ok $print-promise, Promise, '.print returned a promise';

is $start-promise.status, Planned, 'external program still running (stdin still open)';

$pc.close-stdin;

#?rakudo skip 'returns Nil (flapping tests)'
isa_ok $start-promise.result, Proc::Status, 'Can finish, return Proc::Status';

is $stdout, 'Perl 6', 'got correct STDOUT';
is $stderr, '',       'got correct STDERR';
