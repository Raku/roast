use v6;

use Test;

plan 16;

my $program = 'async-print-tester';
my $source = '
say "Started";
while my $line = $*IN.get {
    $line.substr(0,1) eq "2"
      ?? note $line.substr(1)
      !! say $line
};
say "Done";
';
ok $program.IO.spurt($source),   'could we write the tester';
is $program.IO.s, $source.chars, 'did the tester arrive ok';

my $pc = Proc::Async.new( $*EXECUTABLE, $program, :w );
isa_ok $pc, Proc::Async;

my $so = $pc.stdout;
cmp_ok $so, '~~', Supply;
my $se = $pc.stderr;
cmp_ok $se, '~~', Supply;

my $stdout = "";;
my $stderr = "";;
$so.act: { $stdout ~= $_ };
$se.act: { $stderr ~= $_ };

is $stdout, "", 'STDOUT should be empty';
is $stderr, "", 'STDERR should be empty';

my $pm = $pc.start;
isa_ok $pm, Promise;

my $ppr = $pc.print( "Hello World\n" );
isa_ok $ppr, Promise;
await $ppr;
my $psa = $pc.say( "2Oops!" );
isa_ok $psa, Promise;
await $psa;

# done processing
ok $pc.close-stdin, 'did the close of STDIN work';
my $ps = await $pm;

#?rakudo 5 skip "Flapping tests"
isa_ok $ps, Proc::Status;
ok $ps, 'was execution successful';
is $ps.?exit, 0, 'is the status ok';

is $stdout, "Started\nHello World\nDone\n", 'did we get STDOUT'; # seems to flap
is $stderr, "Oops!\n",                      'did we get STDERR';

END {
    unlink $program;
}
