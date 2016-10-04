use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;

plan 1;

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

