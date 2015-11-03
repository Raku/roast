use v6;
use Test;

plan 6;

my $filename = $*TMPDIR ~ '/tmp.' ~ $*PID ~ '-' ~ time;

my $fh = open($filename, :w);
lives-ok { await start $fh.say('abc') }, 'Can write to file in another thread (1)';
lives-ok { await start $fh.say('def') }, 'Can write to file in another thread (2)';
lives-ok { await start $fh.close }, 'Can close file on another thread';

my $rfh = await start { open($filename, :r) };
is $rfh.get, 'abc', 'Can read handle in main thread opened in another thread';
is (await start $rfh.get), 'def', 'Can read handle on thread pool';
lives-ok { $rfh.close }, 'Can close handle on main thread after opening on another thread';
