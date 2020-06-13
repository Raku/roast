use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
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

# https://github.com/Raku/old-issue-tracker/issues/3719
{
    my $temp-file = 'handle-between-threads-' ~ $*PID;
    spurt $temp-file, "foo";
    LEAVE unlink $temp-file;

    my $cat = $*DISTRO.is-win ?? 'type' !! 'cat';
    my $cmd = $*DISTRO.is-win
      ?? Q:s|$*EXECUTABLE -e await(Promise.start({get().uc.say}))|
      !! Q:s|$*EXECUTABLE -e 'await(Promise.start({get().uc.say}))'|;
    my $proc = shell("$cat $temp-file | $cmd", :out);
    is $proc.out.get, "FOO", 'reading from $*IN from another thread works (pipe)';
    so $proc.out.close;
}

# vim: expandtab shiftwidth=4
