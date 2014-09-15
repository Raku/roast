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

my $pc = Proc::Async.new( :path($*EXECUTABLE), :args($program) );
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

isa_ok $pc.print( "Hello World" ), Promise;
isa_ok $pc.say( "2Oops!" ),        Promise;

# done processing
ok $pc.close_stdin, 'did the close of STDIN work';

#my $ps = await $pm;  # alas, hangs, so we have to make do with this:
my $ps = await Promise.anyof( $pm, Promise.in(5) );

#?rakudo 3 todo "apparently .print/.say don't work yet"
isa_ok $ps, Proc::Status;
is $stdout, "Started\nHello World\nDone\n", 'did we get STDOUT';
is $stderr, "Oops!\n",                      'did we get STDERR';

END {
    unlink $program;
}
