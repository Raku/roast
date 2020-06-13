use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 3;

subtest 'is-deeply with Seqs does not claim `Seq.new` expected/got' => {
    plan 4;

    is-deeply (1, 2).Seq, (1, 2).Seq, 'two Seqs, passing';
    is_run ｢use Test; is-deeply (1, 2).Seq, (1, 3).Seq｣, %(
        :err{ not $^s.contains: 'Seq.new()' }
        :out{ not $^s.contains: 'Seq.new()' }
        :status(1)
    ), 'two Seqs, failing';
    is_run ｢use Test; is-deeply (1, 2).Seq, [1, 3]｣, %(
        :err{ not $^s.contains: 'Seq.new()' }
        :out{ not $^s.contains: 'Seq.new()' }
        :status(1)
    ), '`got` Seq, failing';
    is_run ｢use Test; is-deeply [1, 2], (1, 3).Seq｣, %(
        :err{ not $^s.contains: 'Seq.new()' }
        :out{ not $^s.contains: 'Seq.new()' }
        :status(1)
    ), '`expected` Seq, failing';
}

subtest 'Junctions do not cause multiple tests to run' => {
    plan 2;
    is-deeply any(1, 2, 3), none(4, 5, 6), 'passing test';
    is_run ｢use Test; is-deeply 2, none(1, 2, 3)｣, %(
        :err{ $^s.contains: 'none' }
        :out{ $^s.contains: 'not ok' }
        :status(1)
    ), 'failing test';
}

subtest 'can test Seq type objects' => {
    plan 3;
    is-deeply Seq, Seq, 'Seq, Seq';
    is_run ｢use Test; is-deeply Seq, 42｣,
        {:out(*.contains: 'not ok'), :status(1)}, 'Seq, 42';
    is_run ｢use Test; is-deeply 42, Seq｣,
        {:out(*.contains: 'not ok'), :status(1)}, '42, Seq';
}

# vim: expandtab shiftwidth=4
