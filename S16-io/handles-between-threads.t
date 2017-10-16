use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;

plan 8;

my $filename = $*TMPDIR ~ '/tmp.' ~ $*PID ~ '-' ~ time;

my $fh = open($filename, :w);
lives-ok { await start $fh.say('abc') }, 'Can write to file in another thread (1)';
lives-ok { await start $fh.say('def') }, 'Can write to file in another thread (2)';
lives-ok { await start $fh.close }, 'Can close file on another thread';

my $rfh = await start { open($filename, :r) };
is $rfh.get, 'abc', 'Can read handle in main thread opened in another thread';
is (await start $rfh.get), 'def', 'Can read handle on thread pool';
lives-ok { $rfh.close }, 'Can close handle on main thread after opening on another thread';

is_run('await start { say $*IN.get.uc for ^3 }',
       "foo\nbar\nbaz\n",
       {
           status => 0,
           out    => "FOO\nBAR\nBAZ\n",
           err    => "",
       },
       'reading from $*IN from another thread works (file)');

# RT #124005
{
    my $temp-file = 'handle-between-threads-' ~ $*PID;
    spurt $temp-file, "foo";
    LEAVE unlink $temp-file;

    my $cat = $*DISTRO.is-win ?? 'type' !! 'cat';
    my $quote = $*DISTRO.is-win ?? '"' !! "'";
    my $proc = shell(
        Q:s"$cat $temp-file | $*EXECUTABLE -e $quote await start { say get().uc } $quote",
        :out);
    is $proc.out.get, "FOO", 'reading from $*IN from another thread works (pipe)';
    so $proc.out.close;
}
