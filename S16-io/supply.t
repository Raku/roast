use v6;
use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Tap;

my $filename = $?FILE.IO.parent.child('supply.testing');

plan 7;

dies-ok { IO::Handle.Supply(1000) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    unlink $filename;
    ok spurt($filename,"abcde"),'did we write the filename';

    {
        my $handle = open($filename);
        tap-ok $handle.Supply(:size(1)),
          [<a b c d e>],
          :!live,
          "we can get chars from a supply";
        $handle.close;
    }

    {
        my $handle = open($filename, :bin);
        #?rakudo.jvm todo 'RT #128041'
        tap-ok $handle.Supply(:size(1)),
          [<a b c d e>.map: { Buf[uint8].new(ord $_) }],
          :!live,
          "we can get bytes from a supply";
        $handle.close;
    }
}

# cleanup
unlink $filename;

# vim: ft=perl6
