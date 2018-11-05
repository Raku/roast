use v6.d;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;

# Tests for ensuring NUL byte is rejected from paths
constant @nuls = ("\0foobar", "foo\0bar", "foobar\0", "\0foo\0bar\0");

plan 7*@nuls;

{
    temp $*CWD = make-temp-dir;
    for @nuls -> $nul {
        my $d = "with {$nul.perl}";
        throws-like { spurt $nul, "foo"   }, Exception, "&spurt $d";
        throws-like { slurp $nul          }, Exception, "&slurp $d";
        throws-like { chdir $nul          }, Exception, "&chdir $d";
        throws-like { open  $nul          }, Exception, "&open $d";
        throws-like { $nul.IO             }, Exception, ".IO $d";
        throws-like { IO::Path.new: $nul  }, Exception, "IO::Path.new $d";
        throws-like { $*CWD.child: $nul   }, Exception, ".child $d";
    }
}

# vim: ft=perl6
