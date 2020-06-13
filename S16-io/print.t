use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S32::IO/IO/=item print>
plan 14;

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

# https://github.com/Raku/old-issue-tracker/issues/6647
#?rakudo.jvm skip 'atomicint NYI'
#?DOES 1
{
  subtest 'printing routines with Junctions' => {
    plan 2;
    subtest 'gist-using routines do not thread Junctions' => {
        # https://irclog.perlgeek.de/perl6-dev/2018-02-27#i_15864766
        plan 3;
        my (@out-lines, @err-lines);
        is_run ｢
            my $ns := class { has atomicint $.n; method gist { 'note-sub-'   ~ $!n⚛++ } }.new;
            my $nm := class { has atomicint $.n; method gist { 'note-meth-'  ~ $!n⚛++ } }.new;
            my $ss := class { has atomicint $.n; method gist { 'say-sub-'    ~ $!n⚛++ } }.new;
            my $sm := class { has atomicint $.n; method gist { 'say-meth-'   ~ $!n⚛++ } }.new;
            my $sh := class { has atomicint $.n; method gist { 'say-handle-' ~ $!n⚛++ } }.new;
            note ($ns, ($ns,).any).all;
            ($nm, ($nm,).any).all.note;
            say ($ss, ($ss,).any).all;
            ($sm, ($sm,).any).all.say;
            $*OUT.say: ($sh, ($sh,).any).all
        ｣, {:out{@out-lines = .lines; True}, :err{@err-lines = .lines; True}, :0status},
        'no crashes or exit code anomalies';

        subtest 'stdout' => {
            plan 1+@out-lines;
            is-deeply +@out-lines, 3, 'number of lines of output';
            cmp-ok @out-lines[0], '~~', *.contains(all <all( say-sub-0    say-sub-1>   ), 'line 1';
            cmp-ok @out-lines[1], '~~', *.contains(all <all( say-meth-0   say-meth-1>  ), 'line 2';
            cmp-ok @out-lines[2], '~~', *.contains(all <all( say-handle-0 say-handle-1>), 'line 3';
        }
        subtest 'stderr' => {
            plan 1+@err-lines;
            is-deeply +@err-lines, 2, 'number of lines of output';
            cmp-ok @err-lines[0], '~~', *.contains(all <all( note-sub-0   note-sub-1> ), 'line 1';
            cmp-ok @err-lines[1], '~~', *.contains(all <all( note-meth-0  note-meth-1>), 'line 2';
        }
    }

    subtest 'Str-using routines do not thread Junctions' => {
        # https://irclog.perlgeek.de/perl6-dev/2018-02-27#i_15864766
        plan 3;
        my (@out-lines, @err-lines);
        is_run ｢
            my $prs := class { has atomicint $.n; method Str { " print-sub-{$!n⚛++}\n" } }.new;
            my $prm := class { has atomicint $.n; method Str { " print-meth-{$!n⚛++}\n" } }.new;
            my $prh := class { has atomicint $.n; method Str { " print-handle-{$!n⚛++}\n" } }.new;

            my $pfs := class :: is Cool {
              has atomicint $.n; method Str { " printf-sub-{$!n⚛++}\n" } }.new;
            my $pfm := class :: is Cool {
              has atomicint $.n; method Str { " printf-meth-{$!n⚛++}\n" } }.new;
            my $pfh := class :: is Cool {
              has atomicint $.n; method Str { " printf-handle-{$!n⚛++}\n" } }.new;

            my $sfs := class :: is Cool {
              has atomicint $.n; method Str { " sprintf-sub-{$!n⚛++}\n" } }.new;
            my $sfm := class :: is Cool {
              has atomicint $.n; method Str { " sprintf-meth-{$!n⚛++}\n" } }.new;

            print ($prs, ($prs,).any).all;
            ($prm, ($prm,).any).all.print;
            $*OUT.print: ($prh, ($prh,).any).all;

            printf ($pfs, ($pfs,).any).all;
            ($pfm, ($pfm,).any).all.printf;
            $*OUT.printf: ($pfh, ($pfh,).any).all;

            print sprintf ($sfs, ($sfs,).any).all;
            print ($sfm, ($sfm,).any).all.sprintf;
        ｣, {:out{@out-lines = .lines; True}, :err{@err-lines = .lines; True}, :0status},
        'no crashes or exit code anomalies';

        subtest 'stdout' => {
            plan 1+@out-lines;
            is-deeply +@out-lines, 16, 'number of lines of output';
            cmp-ok @out-lines[0 ], '~~', *.contains(any <print-sub-0     print-sub-1>      ), 'l1';
            cmp-ok @out-lines[1 ], '~~', *.contains(any <print-sub-0     print-sub-1>      ), 'l2';
            cmp-ok @out-lines[2 ], '~~', *.contains(any <print-meth-0    print-meth-1>     ), 'l3';
            cmp-ok @out-lines[3 ], '~~', *.contains(any <print-meth-0    print-meth-1>     ), 'l4';
            cmp-ok @out-lines[4 ], '~~', *.contains(any <print-handle-0  print-handle-1>   ), 'l5';
            cmp-ok @out-lines[5 ], '~~', *.contains(any <print-handle-0  print-handle-1>   ), 'l6';

            cmp-ok @out-lines[6 ], '~~', *.contains(any <printf-sub-0     printf-sub-1>    ), 'l7';
            cmp-ok @out-lines[7 ], '~~', *.contains(any <printf-sub-0     printf-sub-1>    ), 'l8';
            cmp-ok @out-lines[8 ], '~~', *.contains(any <printf-meth-0    printf-meth-1>   ), 'l9';
            cmp-ok @out-lines[9 ], '~~', *.contains(any <printf-meth-0    printf-meth-1>   ), 'l10';
            cmp-ok @out-lines[10], '~~', *.contains(any <printf-handle-0  printf-handle-1> ), 'l11';
            cmp-ok @out-lines[11], '~~', *.contains(any <printf-handle-0  printf-handle-1> ), 'l12';

            cmp-ok @out-lines[12], '~~', *.contains(any <sprintf-sub-0    sprintf-sub-1>   ), 'l13';
            cmp-ok @out-lines[13], '~~', *.contains(any <sprintf-sub-0    sprintf-sub-1>   ), 'l14';
            cmp-ok @out-lines[14], '~~', *.contains(any <sprintf-meth-0   sprintf-meth-1>  ), 'l15';
            cmp-ok @out-lines[15], '~~', *.contains(any <sprintf-meth-0   sprintf-meth-1>  ), 'l16';
        }
        is-deeply +@err-lines, 0, 'nothing on stderr' or diag join "\n", @err-lines;
    }
  }
}

# vim: expandtab shiftwidth=4
