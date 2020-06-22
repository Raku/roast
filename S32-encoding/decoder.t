use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;
plan 2;


# https://github.com/rakudo/rakudo/issues/2158
#?rakudo.jvm skip "Unknown encoding 'utf8-c8'"
{
    my $str = 'I ❤ Raku!';
    my $buf = $str.encode('utf8-c8');

    my $decoder = Encoding::Registry.find('utf8-c8').decoder(:translate-nl);

    $decoder.add-bytes($buf.subbuf(0, 8));
    $decoder.add-bytes($buf.subbuf(8));

    ok $decoder.consume-all-chars().chars == $str.chars
        && $decoder.bytes-available == 0,
        'utf8-c8 decoder processes all bytes of all buffers';

    # cover SEGV from the same Issue
    my $content := Blob[uint8].new:
      60,47,116,105,116,108,101,62,60,115,99,114,105,112,116,32,
      110,111,110,99,101,61,34,99,87,116,51,68,79,109,89,119,120,79,57,75,97,
      121,100,83,57,112,102,80,65,61,61,34,62,40,102,117,110,99,116,105,111,
      110,40,41,123,119,105,110,100,111,119,46,103,111,111,103,108,101,61,
      123,107,69,73,58,39,110,69,57,113,87,56,105,122,66,101,95,77,53,103,
      76,106,108,97,68,81,68,103,39,44,107,69,88,80,73,58,39,48,44,49,51,
      53,51,55,52,54,44,53,56,44,49,57,53,55,44,49,48,49,56;

    my $temp-file := make-temp-file :$content;
    my $prog := $*DISTRO.is-win ?? 'type' !! 'cat';
    ok (shell "$prog $temp-file", :enc<utf8-c8>, :out).out.slurp(:close).chars,
        'no SEGV when using utf8-c8 in Proc';
}
# vim: expandtab shiftwidth=4
