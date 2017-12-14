use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;

# L<S32::IO/IO/=item print>
plan 15;

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

# RT #132549
is_run ｢
    note   (' note-1 ', ' note-2 ').all;
    put    (' put-1 ', ' put-2 ').any;
    print  (' print-1 ', ' print-2 ').none;
    printf (' printf-1 ', ' printf-2 printf-3 ').one;

    $*OUT.put:    (' me-put-1 ', ' me-put-2 ').any;
    $*OUT.print:  (' me-print-1 ', ' me-print-2 ').none;
    $*OUT.printf: (' me-printf-1 ', ' me-printf-2 ', ' me-printf-3 ').one;
｣, {
    :out{ .words.sort eq 'me-print-1 me-print-2 me-printf-1 me-printf-2'
      ~ ' me-printf-3 me-put-1 me-put-2 print-1 print-2 printf-1 printf-2'
      ~ ' printf-3 put-1 put-2'
    },
    :err{ .words.sort eq 'note-1 note-2' },
    :0status,
}, 'no hangs or crashes with Junctions in output routines';

# RT #132549
is_run ｢
    note   (' note-1 ', (' note-2 ').any).all;
    put    (' put-1 ', (' put-2 ').any).any;
    print  (' print-1 ', (' print-2 ').any).none;
    printf (' printf-1 ', (' printf-2 ', ' printf-3 ').any).one;

    $*OUT.put:    (' me-put-1 ', (' me-put-2 ').any).any;
    $*OUT.print:  (' me-print-1 ', (' me-print-2 ').any).none;
    $*OUT.printf: (' me-printf-1 ', (' me-printf-2 ', ' me-printf-3 ').any).one;
｣, {
    :out{ .words.sort eq 'me-print-1 me-print-2 me-printf-1 me-printf-2'
      ~ ' me-printf-3 me-put-1 me-put-2 print-1 print-2 printf-1 printf-2'
      ~ ' printf-3 put-1 put-2'
    },
    :err{ .words.sort eq 'note-1 note-2' },
    :0status,
}, 'no hangs or crashes with Junctions in output routines (nested Junctions)';

# vim: ft=perl6
