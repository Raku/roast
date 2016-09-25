use v6;
use Test;

plan 28;

# Tests for categorize-list routine available on Baggy role and Hash class

###############################################################################
# on Hashes
###############################################################################

#------------------------------------------------------------------------------
# empty Hash
#------------------------------------------------------------------------------

subtest 'on empty Hash, basic' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %m  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @m  = Nil, 'cat1', 'cat2', 'cat2';
    my constant %ex = %(:cat2[2, 3], :cat1[1]);

    is-deeply % .categorize-list(&m, [1, 2, 3]), %ex, '&, Array';
    is-deeply % .categorize-list(%m, [1, 2, 3]), %ex, '%, Array';
    is-deeply % .categorize-list(@m, [1, 2, 3]), %ex, '@, Array';
    is-deeply % .categorize-list(&m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply % .categorize-list(%m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply % .categorize-list(@m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply % .categorize-list(&m,   ^3+1   ), %ex, '&, Range';
    is-deeply % .categorize-list(%m,   ^3+1   ), %ex, '%, Range';
    is-deeply % .categorize-list(@m,   ^3+1   ), %ex, '@, Range';
    is-deeply % .categorize-list(&m,   (1…3)  ), %ex, '&, Seq';
    is-deeply % .categorize-list(%m,   (1…3)  ), %ex, '%, Seq';
    is-deeply % .categorize-list(@m,   (1…3)  ), %ex, '@, Seq';
}

subtest 'on empty Hash, basic, with &as' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &m  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %m  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @m  = Nil, 'cat1', 'cat2', 'cat2';
    my constant %ex = %(:cat2['val 2', 'val 3'], :cat1['val 1']);

    is-deeply % .categorize-list(:&as, &m, [1, 2, 3]), %ex, '&, Array';
    is-deeply % .categorize-list(:&as, %m, [1, 2, 3]), %ex, '%, Array';
    is-deeply % .categorize-list(:&as, @m, [1, 2, 3]), %ex, '@, Array';
    is-deeply % .categorize-list(:&as, &m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply % .categorize-list(:&as, %m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply % .categorize-list(:&as, @m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply % .categorize-list(:&as, &m,   ^3+1   ), %ex, '&, Range';
    is-deeply % .categorize-list(:&as, %m,   ^3+1   ), %ex, '%, Range';
    is-deeply % .categorize-list(:&as, @m,   ^3+1   ), %ex, '@, Range';
    is-deeply % .categorize-list(:&as, &m,   (1…3)  ), %ex, '&, Seq';
    is-deeply % .categorize-list(:&as, %m,   (1…3)  ), %ex, '%, Seq';
    is-deeply % .categorize-list(:&as, @m,   (1…3)  ), %ex, '@, Seq';
}

subtest 'on empty Hash, multi-category' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? <cat1 cat3> !! <cat2 cat4> }
    my constant @m  = Nil,   <cat1 cat3>,      <cat2 cat4>,      <cat2 cat4>;
    my constant %m  = %(1 => <cat1 cat3>, 2 => <cat2 cat4>, 3 => <cat2 cat4>);
    my constant %ex = %(:cat2[2, 3], :cat4[2, 3], :cat1[1], :cat3[1]);

    is-deeply % .categorize-list(&m, [1, 2, 3]), %ex, '&, Array';
    is-deeply % .categorize-list(%m, [1, 2, 3]), %ex, '%, Array';
    is-deeply % .categorize-list(@m, [1, 2, 3]), %ex, '@, Array';
    is-deeply % .categorize-list(&m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply % .categorize-list(%m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply % .categorize-list(@m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply % .categorize-list(&m,   ^3+1   ), %ex, '&, Range';
    is-deeply % .categorize-list(%m,   ^3+1   ), %ex, '%, Range';
    is-deeply % .categorize-list(@m,   ^3+1   ), %ex, '@, Range';
    is-deeply % .categorize-list(&m,   (1…3)  ), %ex, '&, Seq';
    is-deeply % .categorize-list(%m,   (1…3)  ), %ex, '%, Seq';
    is-deeply % .categorize-list(@m,   (1…3)  ), %ex, '@, Seq';
}

subtest 'on empty Hash, multi-category, with &as' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &m  = { $^a == 1 ?? <cat1 cat3> !! <cat2 cat4> }
    my constant @m  = Nil,   <cat1 cat3>,      <cat2 cat4>,      <cat2 cat4>;
    my constant %m  = %(1 => <cat1 cat3>, 2 => <cat2 cat4>, 3 => <cat2 cat4>);
    my constant %ex = %(
        :cat2['val 2', 'val 3'],
        :cat4['val 2', 'val 3'],
        :cat1['val 1'],
        :cat3['val 1'],
    );

    is-deeply % .categorize-list(:&as, &m, [1, 2, 3]), %ex, '&, Array';
    is-deeply % .categorize-list(:&as, %m, [1, 2, 3]), %ex, '%, Array';
    is-deeply % .categorize-list(:&as, @m, [1, 2, 3]), %ex, '@, Array';
    is-deeply % .categorize-list(:&as, &m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply % .categorize-list(:&as, %m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply % .categorize-list(:&as, @m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply % .categorize-list(:&as, &m,   ^3+1   ), %ex, '&, Range';
    is-deeply % .categorize-list(:&as, %m,   ^3+1   ), %ex, '%, Range';
    is-deeply % .categorize-list(:&as, @m,   ^3+1   ), %ex, '@, Range';
    is-deeply % .categorize-list(:&as, &m,   (1…3)  ), %ex, '&, Seq';
    is-deeply % .categorize-list(:&as, %m,   (1…3)  ), %ex, '%, Seq';
    is-deeply % .categorize-list(:&as, @m,   (1…3)  ), %ex, '@, Seq';
}

subtest 'on empty Hash, multi-level' => {
    plan 12;
    my constant &m = {
        $^a == 1 ?? [<cat1 cat3>,] !!
            $^a == 2 ?? [<cat2 cat4>,] !! [<cat1 cat3>, <cat2 cat4>,];
    }
    my constant @m
        = Nil, [<cat1 cat3>,], [<cat2 cat4>,], [<cat1 cat3>, <cat2 cat4>,];
    my constant %m  = %(
        1 => [<cat1 cat3>,], 2 => [<cat2 cat4>,],
        3 => [<cat1 cat3>, <cat2 cat4>,]
    );
    my constant %ex = %(
        :cat1(${:cat3($[1, 3])}),
        :cat2(${:cat4($[2, 3])}),
    );

    is-deeply % .categorize-list(&m, [1, 2, 3]), %ex, '&, Array';
    is-deeply % .categorize-list(%m, [1, 2, 3]), %ex, '%, Array';
    is-deeply % .categorize-list(@m, [1, 2, 3]), %ex, '@, Array';
    is-deeply % .categorize-list(&m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply % .categorize-list(%m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply % .categorize-list(@m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply % .categorize-list(&m,   ^3+1   ), %ex, '&, Range';
    is-deeply % .categorize-list(%m,   ^3+1   ), %ex, '%, Range';
    is-deeply % .categorize-list(@m,   ^3+1   ), %ex, '@, Range';
    is-deeply % .categorize-list(&m,   (1…3)  ), %ex, '&, Seq';
    is-deeply % .categorize-list(%m,   (1…3)  ), %ex, '%, Seq';
    is-deeply % .categorize-list(@m,   (1…3)  ), %ex, '@, Seq';
}

subtest 'on empty Hash, multi-level, with &as' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &m = {
        $^a == 1 ?? [<cat1 cat3>,] !!
            $^a == 2 ?? [<cat2 cat4>,] !! [<cat1 cat3>, <cat2 cat4>,];
    }
    my constant @m
        = Nil, [<cat1 cat3>,], [<cat2 cat4>,], [<cat1 cat3>, <cat2 cat4>,];
    my constant %m  = %(
        1 => [<cat1 cat3>,], 2 => [<cat2 cat4>,],
        3 => [<cat1 cat3>, <cat2 cat4>,]
    );
    my constant %ex = %(
        :cat1(${:cat3($['val 1', 'val 3'])}),
        :cat2(${:cat4($['val 2', 'val 3'])}),
    );

    is-deeply % .categorize-list(:&as, &m, [1, 2, 3]), %ex, '&, Array';
    is-deeply % .categorize-list(:&as, %m, [1, 2, 3]), %ex, '%, Array';
    is-deeply % .categorize-list(:&as, @m, [1, 2, 3]), %ex, '@, Array';
    is-deeply % .categorize-list(:&as, &m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply % .categorize-list(:&as, %m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply % .categorize-list(:&as, @m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply % .categorize-list(:&as, &m,   ^3+1   ), %ex, '&, Range';
    is-deeply % .categorize-list(:&as, %m,   ^3+1   ), %ex, '%, Range';
    is-deeply % .categorize-list(:&as, @m,   ^3+1   ), %ex, '@, Range';
    is-deeply % .categorize-list(:&as, &m,   (1…3)  ), %ex, '&, Seq';
    is-deeply % .categorize-list(:&as, %m,   (1…3)  ), %ex, '%, Seq';
    is-deeply % .categorize-list(:&as, @m,   (1…3)  ), %ex, '@, Seq';
}

#------------------------------------------------------------------------------
# populated Hash
#------------------------------------------------------------------------------

subtest 'on populated Hash, basic' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %m  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @m  = Nil, 'cat1', 'cat2', 'cat2';
    my constant %ex = %(:a(42), :cat2[2, 3], :cat1[1]);

    is-deeply %(:42a).categorize-list(&m, [1, 2, 3]), %ex, '&, Array';
    is-deeply %(:42a).categorize-list(%m, [1, 2, 3]), %ex, '%, Array';
    is-deeply %(:42a).categorize-list(@m, [1, 2, 3]), %ex, '@, Array';
    is-deeply %(:42a).categorize-list(&m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply %(:42a).categorize-list(%m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply %(:42a).categorize-list(@m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply %(:42a).categorize-list(&m,   ^3+1   ), %ex, '&, Range';
    is-deeply %(:42a).categorize-list(%m,   ^3+1   ), %ex, '%, Range';
    is-deeply %(:42a).categorize-list(@m,   ^3+1   ), %ex, '@, Range';
    is-deeply %(:42a).categorize-list(&m,   (1…3)  ), %ex, '&, Seq';
    is-deeply %(:42a).categorize-list(%m,   (1…3)  ), %ex, '%, Seq';
    is-deeply %(:42a).categorize-list(@m,   (1…3)  ), %ex, '@, Seq';
}

subtest 'on populated Hash, basic, with &as' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &m  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %m  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @m  = Nil, 'cat1', 'cat2', 'cat2';
    my constant %ex = %(:a(42), :cat2['val 2', 'val 3'], :cat1['val 1']);

    is-deeply %(:42a).categorize-list(:&as, &m, [1, 2, 3]), %ex, '&, Array';
    is-deeply %(:42a).categorize-list(:&as, %m, [1, 2, 3]), %ex, '%, Array';
    is-deeply %(:42a).categorize-list(:&as, @m, [1, 2, 3]), %ex, '@, Array';
    is-deeply %(:42a).categorize-list(:&as, &m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply %(:42a).categorize-list(:&as, %m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply %(:42a).categorize-list(:&as, @m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply %(:42a).categorize-list(:&as, &m,   ^3+1   ), %ex, '&, Range';
    is-deeply %(:42a).categorize-list(:&as, %m,   ^3+1   ), %ex, '%, Range';
    is-deeply %(:42a).categorize-list(:&as, @m,   ^3+1   ), %ex, '@, Range';
    is-deeply %(:42a).categorize-list(:&as, &m,   (1…3)  ), %ex, '&, Seq';
    is-deeply %(:42a).categorize-list(:&as, %m,   (1…3)  ), %ex, '%, Seq';
    is-deeply %(:42a).categorize-list(:&as, @m,   (1…3)  ), %ex, '@, Seq';
}

subtest 'on populated Hash, multi-category' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? <cat1 cat3> !! <cat2 cat4> }
    my constant @m  = Nil,   <cat1 cat3>,      <cat2 cat4>,      <cat2 cat4>;
    my constant %m  = %(1 => <cat1 cat3>, 2 => <cat2 cat4>, 3 => <cat2 cat4>);
    my constant %ex = %(:a(42), :cat2[2, 3], :cat4[2, 3], :cat1[1], :cat3[1]);

    is-deeply %(:42a).categorize-list(&m, [1, 2, 3]), %ex, '&, Array';
    is-deeply %(:42a).categorize-list(%m, [1, 2, 3]), %ex, '%, Array';
    is-deeply %(:42a).categorize-list(@m, [1, 2, 3]), %ex, '@, Array';
    is-deeply %(:42a).categorize-list(&m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply %(:42a).categorize-list(%m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply %(:42a).categorize-list(@m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply %(:42a).categorize-list(&m,   ^3+1   ), %ex, '&, Range';
    is-deeply %(:42a).categorize-list(%m,   ^3+1   ), %ex, '%, Range';
    is-deeply %(:42a).categorize-list(@m,   ^3+1   ), %ex, '@, Range';
    is-deeply %(:42a).categorize-list(&m,   (1…3)  ), %ex, '&, Seq';
    is-deeply %(:42a).categorize-list(%m,   (1…3)  ), %ex, '%, Seq';
    is-deeply %(:42a).categorize-list(@m,   (1…3)  ), %ex, '@, Seq';
}

subtest 'on populated Hash, multi-category, with &as' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &m  = { $^a == 1 ?? <cat1 cat3> !! <cat2 cat4> }
    my constant @m  = Nil,   <cat1 cat3>,      <cat2 cat4>,      <cat2 cat4>;
    my constant %m  = %(1 => <cat1 cat3>, 2 => <cat2 cat4>, 3 => <cat2 cat4>);
    my constant %ex = %(
        :a(42),
        :cat2['val 2', 'val 3'], :cat4['val 2', 'val 3'],
        :cat1['val 1'], :cat3['val 1'],
    );

    is-deeply %(:42a).categorize-list(:&as, &m, [1, 2, 3]), %ex, '&, Array';
    is-deeply %(:42a).categorize-list(:&as, %m, [1, 2, 3]), %ex, '%, Array';
    is-deeply %(:42a).categorize-list(:&as, @m, [1, 2, 3]), %ex, '@, Array';
    is-deeply %(:42a).categorize-list(:&as, &m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply %(:42a).categorize-list(:&as, %m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply %(:42a).categorize-list(:&as, @m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply %(:42a).categorize-list(:&as, &m,   ^3+1   ), %ex, '&, Range';
    is-deeply %(:42a).categorize-list(:&as, %m,   ^3+1   ), %ex, '%, Range';
    is-deeply %(:42a).categorize-list(:&as, @m,   ^3+1   ), %ex, '@, Range';
    is-deeply %(:42a).categorize-list(:&as, &m,   (1…3)  ), %ex, '&, Seq';
    is-deeply %(:42a).categorize-list(:&as, %m,   (1…3)  ), %ex, '%, Seq';
    is-deeply %(:42a).categorize-list(:&as, @m,   (1…3)  ), %ex, '@, Seq';
}

subtest 'on populated Hash, multi-level' => {
    plan 12;
    my constant &m = {
        $^a == 1 ?? [<cat1 cat3>,] !!
            $^a == 2 ?? [<cat2 cat4>,] !! [<cat1 cat3>, <cat2 cat4>,];
    }
    my constant @m
        = Nil, [<cat1 cat3>,], [<cat2 cat4>,], [<cat1 cat3>, <cat2 cat4>,];
    my constant %m  = %(
        1 => [<cat1 cat3>,], 2 => [<cat2 cat4>,],
        3 => [<cat1 cat3>, <cat2 cat4>,]
    );
    my constant %ex = %(:a(42),
        :cat1(${:cat3($[1, 3])}),
        :cat2(${:cat4($[2, 3])}),
    );

    is-deeply %(:42a).categorize-list(&m, [1, 2, 3]), %ex, '&, Array';
    is-deeply %(:42a).categorize-list(%m, [1, 2, 3]), %ex, '%, Array';
    is-deeply %(:42a).categorize-list(@m, [1, 2, 3]), %ex, '@, Array';
    is-deeply %(:42a).categorize-list(&m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply %(:42a).categorize-list(%m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply %(:42a).categorize-list(@m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply %(:42a).categorize-list(&m,   ^3+1   ), %ex, '&, Range';
    is-deeply %(:42a).categorize-list(%m,   ^3+1   ), %ex, '%, Range';
    is-deeply %(:42a).categorize-list(@m,   ^3+1   ), %ex, '@, Range';
    is-deeply %(:42a).categorize-list(&m,   (1…3)  ), %ex, '&, Seq';
    is-deeply %(:42a).categorize-list(%m,   (1…3)  ), %ex, '%, Seq';
    is-deeply %(:42a).categorize-list(@m,   (1…3)  ), %ex, '@, Seq';
}

subtest 'on populated Hash, multi-level, with &as' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &m = {
        $^a == 1 ?? [<cat1 cat3>,] !!
            $^a == 2 ?? [<cat2 cat4>,] !! [<cat1 cat3>, <cat2 cat4>,];
    }
    my constant @m
        = Nil, [<cat1 cat3>,], [<cat2 cat4>,], [<cat1 cat3>, <cat2 cat4>,];
    my constant %m  = %(
        1 => [<cat1 cat3>,], 2 => [<cat2 cat4>,],
        3 => [<cat1 cat3>, <cat2 cat4>,]
    );
    my constant %ex = %(:a(42),
        :cat1(${:cat3($['val 1', 'val 3'])}),
        :cat2(${:cat4($['val 2', 'val 3'])}),
    );

    is-deeply %(:42a).categorize-list(:&as, &m, [1, 2, 3]), %ex, '&, Array';
    is-deeply %(:42a).categorize-list(:&as, %m, [1, 2, 3]), %ex, '%, Array';
    is-deeply %(:42a).categorize-list(:&as, @m, [1, 2, 3]), %ex, '@, Array';
    is-deeply %(:42a).categorize-list(:&as, &m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply %(:42a).categorize-list(:&as, %m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply %(:42a).categorize-list(:&as, @m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply %(:42a).categorize-list(:&as, &m,   ^3+1   ), %ex, '&, Range';
    is-deeply %(:42a).categorize-list(:&as, %m,   ^3+1   ), %ex, '%, Range';
    is-deeply %(:42a).categorize-list(:&as, @m,   ^3+1   ), %ex, '@, Range';
    is-deeply %(:42a).categorize-list(:&as, &m,   (1…3)  ), %ex, '&, Seq';
    is-deeply %(:42a).categorize-list(:&as, %m,   (1…3)  ), %ex, '%, Seq';
    is-deeply %(:42a).categorize-list(:&as, @m,   (1…3)  ), %ex, '@, Seq';
}

#------------------------------------------------------------------------------
# degenerate cases
#------------------------------------------------------------------------------

subtest 'on Hashes, degenerate cases, no items to loop over' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &m  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %m  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @m  = Nil, 'cat1', 'cat2', 'cat2';
    my constant %ex-empty = %();
    my constant %ex-poplt = %(:42a);

    is-deeply %      .categorize-list(      &m), %ex-empty, 'empty, &';
    is-deeply %      .categorize-list(      %m), %ex-empty, 'empty, %';
    is-deeply %      .categorize-list(      @m), %ex-empty, 'empty, @';
    is-deeply %      .categorize-list(:&as, &m), %ex-empty, 'empty, :&as, &';
    is-deeply %      .categorize-list(:&as, %m), %ex-empty, 'empty, :&as, %';
    is-deeply %      .categorize-list(:&as, @m), %ex-empty, 'empty, :&as, @';
    is-deeply %(:42a).categorize-list(      &m), %ex-poplt, 'populated, &';
    is-deeply %(:42a).categorize-list(      %m), %ex-poplt, 'populated, %';
    is-deeply %(:42a).categorize-list(      @m), %ex-poplt, 'populated, @';
    is-deeply %(:42a).categorize-list(:&as, &m), %ex-poplt, 'populatd, :&as, &';
    is-deeply %(:42a).categorize-list(:&as, %m), %ex-poplt, 'populatd, :&as, %';
    is-deeply %(:42a).categorize-list(:&as, @m), %ex-poplt, 'populatd, :&as, @';
}

subtest 'on Hashes, degenerate cases, 0-item, multi-level iterables' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &m  = { $^a == 0 ?? ((),) !! ((),) }
    my constant %m  = %(0 => ((),), 1 => ((),), 2 => ((),));
    my constant @m  = ((),), ((),), ((),);
    my constant %ex-e   = %();
    my constant %ex-p   = %(:42a);
    my constant %ex-eas = %();
    my constant %ex-pas = %(:42a);

    is-deeply %      .categorize-list(      &m, ^3), %ex-e,   'empty, &';
    is-deeply %      .categorize-list(      %m, ^3), %ex-e,   'empty, %';
    is-deeply %      .categorize-list(      @m, ^3), %ex-e,   'empty, @';
    is-deeply %      .categorize-list(:&as, &m, ^3), %ex-eas, 'empty, :&as, &';
    is-deeply %      .categorize-list(:&as, %m, ^3), %ex-eas, 'empty, :&as, %';
    is-deeply %      .categorize-list(:&as, @m, ^3), %ex-eas, 'empty, :&as, @';
    is-deeply %(:42a).categorize-list(      &m, ^3), %ex-p,   'poptd, &';
    is-deeply %(:42a).categorize-list(      %m, ^3), %ex-p,   'poptd, %';
    is-deeply %(:42a).categorize-list(      @m, ^3), %ex-p,   'poptd, @';
    is-deeply %(:42a).categorize-list(:&as, &m, ^3), %ex-pas, 'poptd, :&as, &';
    is-deeply %(:42a).categorize-list(:&as, %m, ^3), %ex-pas, 'poptd, :&as, %';
    is-deeply %(:42a).categorize-list(:&as, @m, ^3), %ex-pas, 'poptd, :&as, @';
}

subtest 'on Hashes, degenerate cases, mapper returns empty list' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &m  = { $^a == 0 ?? () !! 'cat2' }
    my constant %m  = %(0 => (), 1 => 'cat2', 2 => 'cat2');
    my constant @m  = (), 'cat2', 'cat2';
    my constant %ex-e   = %(:cat2[1, 2]);
    my constant %ex-p   = %(:42a, :cat2[1, 2]);
    my constant %ex-eas = %(:cat2['val 1', 'val 2']);
    my constant %ex-pas = %(:42a, :cat2['val 1', 'val 2']);

    is-deeply %      .categorize-list(      &m, ^3), %ex-e,   'empty, &';
    is-deeply %      .categorize-list(      %m, ^3), %ex-e,   'empty, %';
    is-deeply %      .categorize-list(      @m, ^3), %ex-e,   'empty, @';
    is-deeply %      .categorize-list(:&as, &m, ^3), %ex-eas, 'empty, :&as, &';
    is-deeply %      .categorize-list(:&as, %m, ^3), %ex-eas, 'empty, :&as, %';
    is-deeply %      .categorize-list(:&as, @m, ^3), %ex-eas, 'empty, :&as, @';
    is-deeply %(:42a).categorize-list(      &m, ^3), %ex-p,   'poptd, &';
    is-deeply %(:42a).categorize-list(      %m, ^3), %ex-p,   'poptd, %';
    is-deeply %(:42a).categorize-list(      @m, ^3), %ex-p,   'poptd, @';
    is-deeply %(:42a).categorize-list(:&as, &m, ^3), %ex-pas, 'poptd, :&as, &';
    is-deeply %(:42a).categorize-list(:&as, %m, ^3), %ex-pas, 'poptd, :&as, %';
    is-deeply %(:42a).categorize-list(:&as, @m, ^3), %ex-pas, 'poptd, :&as, @';
}

#------------------------------------------------------------------------------
# exceptions
#------------------------------------------------------------------------------

subtest ‘on Hashes, exceptions, can't classify lazy lists’ => {
    plan 12;
    my constant $l  = (−∞…∞);
    my constant &as = { "val $^a" }

    throws-like { % .categorize-list: {;}, $l }, X::Cannot::Lazy, 'empty hash, &';
    throws-like { % .categorize-list:  %,  $l }, X::Cannot::Lazy, 'empty hash, %';
    throws-like { % .categorize-list:  @,  $l }, X::Cannot::Lazy, 'empty hash, @';
    throws-like { % .categorize-list: :&as, {;}, $l }, X::Cannot::Lazy,
        'empty hash, :&as, &';
    throws-like { % .categorize-list: :&as,  %, $l }, X::Cannot::Lazy,
        'empty hash, :&as, %';
    throws-like { % .categorize-list: :&as,  @, $l }, X::Cannot::Lazy,
        'empty hash, :&as, @';

    throws-like { %(:42a).categorize-list: {;}, $l }, X::Cannot::Lazy,
        'populated hash, &';
    throws-like { %(:42a).categorize-list:  %, $l }, X::Cannot::Lazy,
        'populated hash, %';
    throws-like { %(:42a).categorize-list:  @, $l }, X::Cannot::Lazy,
        'populated hash, @';

    throws-like { %(:42a).categorize-list: :&as, {;}, $l }, X::Cannot::Lazy,
        'populated hash, :&as, &';
    throws-like { %(:42a).categorize-list: :&as,  %, $l }, X::Cannot::Lazy,
        'populated hash, :&as, %';
    throws-like { %(:42a).categorize-list: :&as,  @, $l }, X::Cannot::Lazy,
        'populated hash, :&as, @';
}

subtest ‘on Hashes, exceptions, can't do mixed-level classification’ => {
    plan 12;
    my constant &m1  = { $^a == 1 ?? [['cat1',],] !! <cat2 cat3> }
    my constant %m1  = %(1 => [['cat1',],], 2 => <cat2 cat3>, 3 => <cat2 cat3>);
    my constant @m1  = Nil, [['cat1',],], <cat2 cat3>, <cat2 cat3>;
    my constant &m2  = { $^a == 1 ?? <cat1 cat3> !! [['cat2',],] }
    my constant %m2
        = %(1 => <cat1 cat3>, 2 => [['cat2',],], 3 => [['cat2',],]);
    my constant @m2  = Nil, <cat1 cat3>, [['cat2',],], [['cat2',],];
    my constant &as  = { "val $^a" }

    throws-like { % .categorize-list: &m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '&, v1';
    throws-like { % .categorize-list: %m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '%, v1';
    throws-like { % .categorize-list: @m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '@, v1';
    throws-like { % .categorize-list: &m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '&, v2';
    throws-like { % .categorize-list: %m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '%, v2';
    throws-like { % .categorize-list: @m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '@, v2';

    throws-like { % .categorize-list: :&as, &m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, &, v1';
    throws-like { % .categorize-list: :&as, %m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, %, v1';
    throws-like { % .categorize-list: :&as, @m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, @, v1';
    throws-like { % .categorize-list: :&as, &m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, &, v2';
    throws-like { % .categorize-list: :&as, %m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, %, v2';
    throws-like { % .categorize-list: :&as, @m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, @, v2';
}

###############################################################################
# on Baggy
###############################################################################

#------------------------------------------------------------------------------
# empty Baggy
#------------------------------------------------------------------------------

subtest 'on empty BagHash, single category' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %m  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @m  = Nil, 'cat1', 'cat2', 'cat2';
    my constant $ex = BagHash.new: <cat1  cat2 cat2>;

    is-deeply BagHash.new.categorize-list(&m, [1, 2, 3]), $ex, '&, Array';
    is-deeply BagHash.new.categorize-list(%m, [1, 2, 3]), $ex, '%, Array';
    is-deeply BagHash.new.categorize-list(@m, [1, 2, 3]), $ex, '@, Array';
    is-deeply BagHash.new.categorize-list(&m,  1, 2, 3 ), $ex, '&, comma list';
    is-deeply BagHash.new.categorize-list(%m,  1, 2, 3 ), $ex, '%, comma list';
    is-deeply BagHash.new.categorize-list(@m,  1, 2, 3 ), $ex, '@, comma list';
    is-deeply BagHash.new.categorize-list(&m,   ^3+1   ), $ex, '&, Range';
    is-deeply BagHash.new.categorize-list(%m,   ^3+1   ), $ex, '%, Range';
    is-deeply BagHash.new.categorize-list(@m,   ^3+1   ), $ex, '@, Range';
    is-deeply BagHash.new.categorize-list(&m,   (1…3)  ), $ex, '&, Seq';
    is-deeply BagHash.new.categorize-list(%m,   (1…3)  ), $ex, '%, Seq';
    is-deeply BagHash.new.categorize-list(@m,   (1…3)  ), $ex, '@, Seq';
}

subtest 'on populated BagHash, single category' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %m  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @m  = Nil, 'cat1', 'cat2', 'cat2';
    my constant $ex = BagHash.new: <a b  cat1  cat2 cat2>;

    is-deeply BagHash.new(<a b>).categorize-list(&m, [1, 2, 3]), $ex, '&, Array';
    is-deeply BagHash.new(<a b>).categorize-list(%m, [1, 2, 3]), $ex, '%, Array';
    is-deeply BagHash.new(<a b>).categorize-list(@m, [1, 2, 3]), $ex, '@, Array';
    is-deeply BagHash.new(<a b>).categorize-list(&m,  1, 2, 3 ), $ex, '&, commas';
    is-deeply BagHash.new(<a b>).categorize-list(%m,  1, 2, 3 ), $ex, '%, commas';
    is-deeply BagHash.new(<a b>).categorize-list(@m,  1, 2, 3 ), $ex, '@, commas';
    is-deeply BagHash.new(<a b>).categorize-list(&m,   ^3+1   ), $ex, '&, Range';
    is-deeply BagHash.new(<a b>).categorize-list(%m,   ^3+1   ), $ex, '%, Range';
    is-deeply BagHash.new(<a b>).categorize-list(@m,   ^3+1   ), $ex, '@, Range';
    is-deeply BagHash.new(<a b>).categorize-list(&m,   (1…3)  ), $ex, '&, Seq';
    is-deeply BagHash.new(<a b>).categorize-list(%m,   (1…3)  ), $ex, '%, Seq';
    is-deeply BagHash.new(<a b>).categorize-list(@m,   (1…3)  ), $ex, '@, Seq';
}

subtest 'on populated MixHash, single category' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %m  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @m  = Nil, 'cat1', 'cat2', 'cat2';
    my constant $ex = MixHash.new: <a b  cat1  cat2 cat2>;

    is-deeply MixHash.new(<a b>).categorize-list(&m, [1, 2, 3]), $ex, '&, Array';
    is-deeply MixHash.new(<a b>).categorize-list(%m, [1, 2, 3]), $ex, '%, Array';
    is-deeply MixHash.new(<a b>).categorize-list(@m, [1, 2, 3]), $ex, '@, Array';
    is-deeply MixHash.new(<a b>).categorize-list(&m,  1, 2, 3 ), $ex, '&, commas';
    is-deeply MixHash.new(<a b>).categorize-list(%m,  1, 2, 3 ), $ex, '%, commas';
    is-deeply MixHash.new(<a b>).categorize-list(@m,  1, 2, 3 ), $ex, '@, commas';
    is-deeply MixHash.new(<a b>).categorize-list(&m,   ^3+1   ), $ex, '&, Range';
    is-deeply MixHash.new(<a b>).categorize-list(%m,   ^3+1   ), $ex, '%, Range';
    is-deeply MixHash.new(<a b>).categorize-list(@m,   ^3+1   ), $ex, '@, Range';
    is-deeply MixHash.new(<a b>).categorize-list(&m,   (1…3)  ), $ex, '&, Seq';
    is-deeply MixHash.new(<a b>).categorize-list(%m,   (1…3)  ), $ex, '%, Seq';
    is-deeply MixHash.new(<a b>).categorize-list(@m,   (1…3)  ), $ex, '@, Seq';
}

subtest 'on empty BagHash, multi-category' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? 'cat1' !! <cat2 cat3> }
    my constant %m  = %(1 => 'cat1', 2 => <cat2 cat3>, 3 => <cat2 cat3>);
    my constant @m  = Nil, 'cat1', <cat2 cat3>, <cat2 cat3>;
    my constant $ex = BagHash.new: <cat1  cat2 cat2  cat3 cat3>;

    is-deeply BagHash.new.categorize-list(&m, [1, 2, 3]), $ex, '&, Array';
    is-deeply BagHash.new.categorize-list(%m, [1, 2, 3]), $ex, '%, Array';
    is-deeply BagHash.new.categorize-list(@m, [1, 2, 3]), $ex, '@, Array';
    is-deeply BagHash.new.categorize-list(&m,  1, 2, 3 ), $ex, '&, comma list';
    is-deeply BagHash.new.categorize-list(%m,  1, 2, 3 ), $ex, '%, comma list';
    is-deeply BagHash.new.categorize-list(@m,  1, 2, 3 ), $ex, '@, comma list';
    is-deeply BagHash.new.categorize-list(&m,   ^3+1   ), $ex, '&, Range';
    is-deeply BagHash.new.categorize-list(%m,   ^3+1   ), $ex, '%, Range';
    is-deeply BagHash.new.categorize-list(@m,   ^3+1   ), $ex, '@, Range';
    is-deeply BagHash.new.categorize-list(&m,   (1…3)  ), $ex, '&, Seq';
    is-deeply BagHash.new.categorize-list(%m,   (1…3)  ), $ex, '%, Seq';
    is-deeply BagHash.new.categorize-list(@m,   (1…3)  ), $ex, '@, Seq';
}

subtest 'on populated BagHash, multi-category' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? 'cat1' !! <cat2 cat3> }
    my constant %m  = %(1 => 'cat1', 2 => <cat2 cat3>, 3 => <cat2 cat3>);
    my constant @m  = Nil, 'cat1', <cat2 cat3>, <cat2 cat3>;
    my constant $ex = BagHash.new: <a b  cat1  cat2 cat2  cat3 cat3>;

    is-deeply BagHash.new(<a b>).categorize-list(&m, [1, 2, 3]), $ex, '&, Array';
    is-deeply BagHash.new(<a b>).categorize-list(%m, [1, 2, 3]), $ex, '%, Array';
    is-deeply BagHash.new(<a b>).categorize-list(@m, [1, 2, 3]), $ex, '@, Array';
    is-deeply BagHash.new(<a b>).categorize-list(&m,  1, 2, 3 ), $ex, '&, commas';
    is-deeply BagHash.new(<a b>).categorize-list(%m,  1, 2, 3 ), $ex, '%, commas';
    is-deeply BagHash.new(<a b>).categorize-list(@m,  1, 2, 3 ), $ex, '@, commas';
    is-deeply BagHash.new(<a b>).categorize-list(&m,   ^3+1   ), $ex, '&, Range';
    is-deeply BagHash.new(<a b>).categorize-list(%m,   ^3+1   ), $ex, '%, Range';
    is-deeply BagHash.new(<a b>).categorize-list(@m,   ^3+1   ), $ex, '@, Range';
    is-deeply BagHash.new(<a b>).categorize-list(&m,   (1…3)  ), $ex, '&, Seq';
    is-deeply BagHash.new(<a b>).categorize-list(%m,   (1…3)  ), $ex, '%, Seq';
    is-deeply BagHash.new(<a b>).categorize-list(@m,   (1…3)  ), $ex, '@, Seq';
}

subtest 'on populated MixHash, multi-category' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? 'cat1' !! <cat2 cat3> }
    my constant %m  = %(1 => 'cat1', 2 => <cat2 cat3>, 3 => <cat2 cat3>);
    my constant @m  = Nil, 'cat1', <cat2 cat3>, <cat2 cat3>;
    my constant $ex = MixHash.new: <a b  cat1  cat2 cat2  cat3 cat3>;

    is-deeply MixHash.new(<a b>).categorize-list(&m, [1, 2, 3]), $ex, '&, Array';
    is-deeply MixHash.new(<a b>).categorize-list(%m, [1, 2, 3]), $ex, '%, Array';
    is-deeply MixHash.new(<a b>).categorize-list(@m, [1, 2, 3]), $ex, '@, Array';
    is-deeply MixHash.new(<a b>).categorize-list(&m,  1, 2, 3 ), $ex, '&, commas';
    is-deeply MixHash.new(<a b>).categorize-list(%m,  1, 2, 3 ), $ex, '%, commas';
    is-deeply MixHash.new(<a b>).categorize-list(@m,  1, 2, 3 ), $ex, '@, commas';
    is-deeply MixHash.new(<a b>).categorize-list(&m,   ^3+1   ), $ex, '&, Range';
    is-deeply MixHash.new(<a b>).categorize-list(%m,   ^3+1   ), $ex, '%, Range';
    is-deeply MixHash.new(<a b>).categorize-list(@m,   ^3+1   ), $ex, '@, Range';
    is-deeply MixHash.new(<a b>).categorize-list(&m,   (1…3)  ), $ex, '&, Seq';
    is-deeply MixHash.new(<a b>).categorize-list(%m,   (1…3)  ), $ex, '%, Seq';
    is-deeply MixHash.new(<a b>).categorize-list(@m,   (1…3)  ), $ex, '@, Seq';
}

#------------------------------------------------------------------------------
# degenerate cases
#------------------------------------------------------------------------------

subtest 'on Baggy, degenerate cases, no items to loop over' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %m  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @m  = Nil, 'cat1', 'cat2', 'cat2';
    my constant $ex-bag-empty = BagHash.new;
    my constant $ex-mix-empty = MixHash.new;
    my constant $ex-bag-poplt = BagHash.new: <a b>;
    my constant $ex-mix-poplt = MixHash.new: <a b>;

    is-deeply BagHash.new.categorize-list(&m), $ex-bag-empty, 'BagHash, empty, &';
    is-deeply BagHash.new.categorize-list(%m), $ex-bag-empty, 'BagHash, empty, %';
    is-deeply BagHash.new.categorize-list(@m), $ex-bag-empty, 'BagHash, empty, @';
    is-deeply MixHash.new.categorize-list(&m), $ex-mix-empty, 'MixHash, empty, &';
    is-deeply MixHash.new.categorize-list(%m), $ex-mix-empty, 'MixHash, empty, %';
    is-deeply MixHash.new.categorize-list(@m), $ex-mix-empty, 'MixHash, empty, @';
    is-deeply BagHash.new(<a b>).categorize-list(&m), $ex-bag-poplt,
        'BagHash, populated, &';
    is-deeply BagHash.new(<a b>).categorize-list(%m), $ex-bag-poplt,
        'BagHash, populated, %';
    is-deeply BagHash.new(<a b>).categorize-list(@m), $ex-bag-poplt,
        'BagHash, populated, @';
    is-deeply MixHash.new(<a b>).categorize-list(&m), $ex-mix-poplt,
        'MixHash, populated, &';
    is-deeply MixHash.new(<a b>).categorize-list(%m), $ex-mix-poplt,
        'MixHash, populated, %';
    is-deeply MixHash.new(<a b>).categorize-list(@m), $ex-mix-poplt,
        'MixHash, populated, @';
}

subtest 'on Hashes, degenerate cases, mapper returns empty list' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &m  = { $^a == 0 ?? () !! 'cat2' }
    my constant %m  = %(0 => (), 1 => 'cat2', 2 => 'cat2');
    my constant @m  = (), 'cat2', 'cat2';
    my constant %ex-be = BagHash.new: <cat2 cat2>;
    my constant %ex-me = MixHash.new: <cat2 cat2>;
    my constant %ex-bp = BagHash.new: <a b  cat2 cat2>;
    my constant %ex-mp = MixHash.new: <a b  cat2 cat2>;

    is-deeply BagHash.new.categorize-list(&m, ^3), %ex-be, 'BagHash, empty, &';
    is-deeply BagHash.new.categorize-list(%m, ^3), %ex-be, 'BagHash, empty, %';
    is-deeply BagHash.new.categorize-list(@m, ^3), %ex-be, 'BagHash, empty, @';
    is-deeply MixHash.new.categorize-list(&m, ^3), %ex-me, 'MixHash, empty, &';
    is-deeply MixHash.new.categorize-list(%m, ^3), %ex-me, 'MixHash, empty, %';
    is-deeply MixHash.new.categorize-list(@m, ^3), %ex-me, 'MixHash, empty, @';

    is-deeply BagHash.new(<a b>).categorize-list(&m, ^3), %ex-bp,
        'BagHash, populated, &';
    is-deeply BagHash.new(<a b>).categorize-list(%m, ^3), %ex-bp,
        'BagHash, populated, %';
    is-deeply BagHash.new(<a b>).categorize-list(@m, ^3), %ex-bp,
        'BagHash, populated, @';
    is-deeply MixHash.new(<a b>).categorize-list(&m, ^3), %ex-mp,
        'MixHash, populated, &';
    is-deeply MixHash.new(<a b>).categorize-list(%m, ^3), %ex-mp,
        'MixHash, populated, %';
    is-deeply MixHash.new(<a b>).categorize-list(@m, ^3), %ex-mp,
        'MixHash, populated, @';
}


#------------------------------------------------------------------------------
# exceptions
#------------------------------------------------------------------------------

subtest ‘on Baggy, exceptions, can't classify lazy lists’ => {
    plan 12;
    my constant $l = (−∞…∞);

    throws-like { BagHash.new.categorize-list: {;}, $l }, X::Cannot::Lazy,
        'empty BagHash, &';
    throws-like { BagHash.new.categorize-list:  %,  $l }, X::Cannot::Lazy,
        'empty BagHash, %';
    throws-like { BagHash.new.categorize-list:  @,  $l }, X::Cannot::Lazy,
        'empty BagHash, @';
    throws-like { MixHash.new.categorize-list: {;}, $l }, X::Cannot::Lazy,
        'empty MixHash, &';
    throws-like { MixHash.new.categorize-list:  %,  $l }, X::Cannot::Lazy,
        'empty MixHash, %';
    throws-like { MixHash.new.categorize-list:  @,  $l }, X::Cannot::Lazy,
        'empty MixHash, @';

    throws-like { BagHash.new(<a b>).categorize-list: {;}, $l }, X::Cannot::Lazy,
        'populated BagHash, &';
    throws-like { BagHash.new(<a b>).categorize-list:  %,  $l }, X::Cannot::Lazy,
        'populated BagHash, %';
    throws-like { BagHash.new(<a b>).categorize-list:  @,  $l }, X::Cannot::Lazy,
        'populated BagHash, @';
    throws-like { MixHash.new(<a b>).categorize-list: {;}, $l }, X::Cannot::Lazy,
        'populated MixHash, &';
    throws-like { MixHash.new(<a b>).categorize-list:  %,  $l }, X::Cannot::Lazy,
        'populated MixHash, %';
    throws-like { MixHash.new(<a b>).categorize-list:  @,  $l }, X::Cannot::Lazy,
        'populated MixHash, @';
}

subtest ‘on Baggy, exceptions, can't multi-level classify’ => {
    plan 6;
    my constant &m  = { $^a == 1 ?? [<a b>,] !! [<a b>,] }
    my constant @m  = Nil,   [<a b>,],      [<a b>,],      [<a b>,];
    my constant %m  = %(1 => [<a b>,], 2 => [<a b>,], 3 => [<a b>,]);

    throws-like { BagHash.new.categorize-list: &m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level categorization'/, 'BagHash, &';
    throws-like { BagHash.new.categorize-list: %m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level categorization'/, 'BagHash, %';
    throws-like { BagHash.new.categorize-list: @m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level categorization'/, 'BagHash, @';
    throws-like { MixHash.new.categorize-list: &m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level categorization'/, 'MixHash, &';
    throws-like { MixHash.new.categorize-list: %m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level categorization'/, 'MixHash, %';
    throws-like { MixHash.new.categorize-list: @m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level categorization'/, 'MixHash, @';
}

subtest ‘on Baggy, exceptions, can't classify on immutable Baggies’ => {
    plan 6;
    throws-like { Bag.new.categorize-list: {;}, ^2 }, X::Immutable, 'Bag, &';
    throws-like { Bag.new.categorize-list:  %,  ^2 }, X::Immutable, 'Bag, %';
    throws-like { Bag.new.categorize-list:  @,  ^2 }, X::Immutable, 'Bag, @';
    throws-like { Mix.new.categorize-list: {;}, ^2 }, X::Immutable, 'Mix, &';
    throws-like { Mix.new.categorize-list:  %,  ^2 }, X::Immutable, 'Mix, %';
    throws-like { Mix.new.categorize-list:  @,  ^2 }, X::Immutable, 'Mix, @';
}
