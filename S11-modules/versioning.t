use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

my $lib-path = $*PROGRAM.parent(2).add("packages/S11-modules/lib");

plan 9;

my @compiler-args = '-I', $lib-path.absolute;

for <c d e.PREVIEW> -> $from-rev {
    for <c d e> -> $mod-rev {
        subtest "6.$mod-rev from 6.$from-rev", {
            plan 8;
            for (:core-revision($mod-rev), :raku-version("6.$mod-rev")) -> (:key($routine), :value($response)) {
                for (:use(''), :require(" <\&$routine>")) -> (:key($statement), :value($starg)) {
                    is_run 'use v6.' ~$from-rev ~ '; ' ~ $statement ~ ' Module_6' ~ $mod-rev ~ $starg ~ '; print ' ~ $routine,
                        :@compiler-args,
                        {
                            :err(''), :exitcode, :out($response),
                        },
                        "$statement: $routine is $response";

                    is_run 'use v6.' ~ $from-rev ~ '; print EVAL("' ~ $statement ~ ' Module_6' ~ $mod-rev ~ $starg ~ '; ' ~ $routine ~ '")',
                        :@compiler-args,
                        {
                            :err(''), :exitcode, :out($response),
                        },
                        "$statement in EVAL: $routine is $response";
                }
            }
        }
    }
}

# vim: expandtab shiftwidth=4
