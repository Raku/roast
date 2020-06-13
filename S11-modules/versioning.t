use v6;
use Test;
use lib <t/packages>;
use Test::Helpers;

my $lib-path = $?FILE.IO.parent(2).add("packages/S11-modules/lib");

plan 9;

for <c d e.PREVIEW> -> $from-rev {
    for <c d e> -> $mod-rev {
        subtest "6.$mod-rev from 6.$from-rev", {
            plan 8;
            for (:core-revision($mod-rev), :perl-version("6.$mod-rev")) -> (:key($routine), :value($response)) {
                for (:use(''), :require(" <\&$routine>")) -> (:key($statement), :value($starg)) {
                    is-run 'use v6.' ~$from-rev ~ '; ' ~ $statement ~ ' Module_6' ~ $mod-rev ~ $starg ~ '; print ' ~ $routine,
                        "$statement: $routine is $response",
                        :compiler-args('-I', $lib-path),
                        :out($response), :err(""), :exitcode(0);
                    is-run 'use v6.' ~ $from-rev ~ '; print EVAL("' ~ $statement ~ ' Module_6' ~ $mod-rev ~ $starg ~ '; ' ~ $routine ~ '")',
                        "$statement in EVAL: $routine is $response",
                        :compiler-args('-I', $lib-path),
                        :out($response), :exitcode(0);
                }
            }
        }
    }
}

# vim: expandtab shiftwidth=4
