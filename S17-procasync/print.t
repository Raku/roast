use v6;

use Test;

plan 14;

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

my $pc = Proc::Async.new( :path($*EXECUTABLE), :args($program), :w );
isa_ok $pc, Proc::Async;

my $so = $pc.stdout_chars;
cmp_ok $so, '~~', Supply;
my $se = $pc.stderr_chars;
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
ok $pc.close_stdin, 'did the close of STDIN work';
my $ps = await $pm;

#?rakudo todo "not getting a Proc::Status back, but Any"
isa_ok $ps, Proc::Status;

is $stdout, "Started\nHello World\nDone\n", 'did we get STDOUT'; # seems to flap
is $stderr, "Oops!\n",                      'did we get STDERR';

END {
    unlink $program;
}
