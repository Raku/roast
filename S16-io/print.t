use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;

# L<S32::IO/IO/=item print>
plan 13;

# Tests for print
is_run 'print "ok\n"', { out => "ok\n" }, 'basic form of print';
is_run 'print "o", "k", "k"', { out => "okk" },
    'print with multiple parameters(1)';

is_run 'my @array = ("o", "k"); print @array', { out => "o k" }, 'print array';
is_run 'my @array = ("o", "k"); @array.print', { out => "o k" }, 'array.print';
is_run 'my $array-ref = ("o", "k"); print $array-ref', { out => "o k" },
    'print stringifies its args';

is_run '"ok".print', { out => "ok" }, 'method form of print';
is_run 'print "o"; print "k";', { out => "ok" }, 'print doesn\'t add newlines';
is_run 'print $*OUT: \'ok\'', { out => 'ok' },
    'print with $*OUT: as filehandle';

is_run 'say $*OUT: \'ok\'', { out => "ok\n" }, 'say with $*OUT: as filehandle';
is_run '$*OUT.print: \'o\' ~ "k\n"', { out => "ok\n" }, '$*OUT.print: list';
is_run '$*OUT.say: \'o\' ~ "k\n"', { out => "ok\n\n" }, '$*OUT.say: list';
is_run 'my @array = <o k k>; $*OUT.print: @array', { out => "o k k" },
    '$*OUT.print: Array';

is_run 'my $a = (\'o\', \'k\', \'k\'); $*OUT.print: $a', { out => "o k k" },
    '$*OUT.print: containerized Array';

# vim: ft=perl6
