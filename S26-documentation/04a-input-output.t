use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 6;

my $r;

# Tests expected to fail:

my $p1 = Q:to<--END-->;
=begin code
say 1;
say 2;
=end
--END--

my $p2 = Q:to<--END-->;
=begin input
say 1;
say 2;
=end
--END--

my $p3 = Q:to<--END-->;
=begin output
say 1;
say 2;
=end
--END--

my $p4 = Q:to<--END-->;
=begin code
say 1;
say 2;
=end input
--END--

my $p5 = Q:to<--END-->;
=begin input
say 1;
say 2;
=end output
--END--

my $p6 = Q:to<--END-->;
=begin output
say 1;
say 2;
=end code
--END--

for $p1, $p2, $p3, $p4, $p5, $p6 -> $POD {
    is_run :compiler-args['--doc'], $POD, {
        # the %wanted hash
        status => 1,
    }, 'expected fail of basic --doc check';
}

# vim: expandtab shiftwidth=4
