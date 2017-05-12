use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;

plan 2;

subtest 'is-deeply with Seqs does not claim `Seq.new-consumed` expected/got' => {
    plan 4;

    is-deeply (1, 2).Seq, (1, 2).Seq, 'two Seqs, passing';
    is_run ｢use Test; is-deeply (1, 2).Seq, (1, 3).Seq｣, %(
        :err{ not $^s.contains: 'Seq.new-consumed' }
        :out{ not $^s.contains: 'Seq.new-consumed' }
    ), 'two Seqs, failing';
    is_run ｢use Test; is-deeply (1, 2).Seq, [1, 3]｣, %(
        :err{ not $^s.contains: 'Seq.new-consumed' }
        :out{ not $^s.contains: 'Seq.new-consumed' }
    ), '`got` Seq, failing';
    is_run ｢use Test; is-deeply [1, 2], (1, 3).Seq｣, %(
        :err{ not $^s.contains: 'Seq.new-consumed' }
        :out{ not $^s.contains: 'Seq.new-consumed' }
    ), '`expected` Seq, failing';
}

subtest 'Junctions do not cause multiple tests to run' => {
    plan 2;
    is-deeply any(1, 2, 3), none(4, 5, 6), 'passing test';
    is_run ｢use Test; is-deeply 2, none(1, 2, 3)｣, %(
        :err{ $^s.contains: 'none' }
        :out{ $^s.contains: 'not ok' }
    ), 'failing test';
}
