use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

my $filename = $?FILE.IO.parent.child('supply.testing');

plan 7;

dies-ok { IO::Handle.Supply(1000) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

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
        # https://github.com/Raku/old-issue-tracker/issues/5283
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

# vim: expandtab shiftwidth=4
