use v6;

use Test;

plan 9;

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

my $pm = $pc.start;
isa_ok $pm, Promise;

my $ps = await $pm;
isa_ok $ps, Proc::Status;
ok $ps, 'was execution successful';
is $ps.?exit, 0, 'is the status ok';

is $stdout, "Hello World\n", 'did we get STDOUT';
is $stderr, "",              'did we get STDERR';
