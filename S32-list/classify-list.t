use v6;
use Test;

plan 18;

# Tests for classify-list routine available on Baggy role and Hash class

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

    is-deeply % .classify-list(&m, [1, 2, 3]), %ex, '&, Array';
    is-deeply % .classify-list(%m, [1, 2, 3]), %ex, '%, Array';
    is-deeply % .classify-list(@m, [1, 2, 3]), %ex, '@, Array';
    is-deeply % .classify-list(&m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply % .classify-list(%m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply % .classify-list(@m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply % .classify-list(&m,   ^3+1   ), %ex, '&, Range';
    is-deeply % .classify-list(%m,   ^3+1   ), %ex, '%, Range';
    is-deeply % .classify-list(@m,   ^3+1   ), %ex, '@, Range';
    is-deeply % .classify-list(&m,   (1…3)  ), %ex, '&, Seq';
    is-deeply % .classify-list(%m,   (1…3)  ), %ex, '%, Seq';
    is-deeply % .classify-list(@m,   (1…3)  ), %ex, '@, Seq';
}

subtest 'on empty Hash, basic, with &as' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &m  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %m  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @m  = Nil, 'cat1', 'cat2', 'cat2';
    my constant %ex = %(:cat2['val 2', 'val 3'], :cat1['val 1']);

    is-deeply % .classify-list(:&as, &m, [1, 2, 3]), %ex, '&, Array';
    is-deeply % .classify-list(:&as, %m, [1, 2, 3]), %ex, '%, Array';
    is-deeply % .classify-list(:&as, @m, [1, 2, 3]), %ex, '@, Array';
    is-deeply % .classify-list(:&as, &m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply % .classify-list(:&as, %m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply % .classify-list(:&as, @m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply % .classify-list(:&as, &m,   ^3+1   ), %ex, '&, Range';
    is-deeply % .classify-list(:&as, %m,   ^3+1   ), %ex, '%, Range';
    is-deeply % .classify-list(:&as, @m,   ^3+1   ), %ex, '@, Range';
    is-deeply % .classify-list(:&as, &m,   (1…3)  ), %ex, '&, Seq';
    is-deeply % .classify-list(:&as, %m,   (1…3)  ), %ex, '%, Seq';
    is-deeply % .classify-list(:&as, @m,   (1…3)  ), %ex, '@, Seq';
}

subtest 'on empty Hash, multi-level' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? <cat1 sub1> !! <cat2 sub2> }
    my constant @m  = Nil,   <cat1 sub1>,      <cat2 sub2>,      <cat2 sub2>;
    my constant %m  = %(1 => <cat1 sub1>, 2 => <cat2 sub2>, 3 => <cat2 sub2>);
    my constant %ex = %(:cat2{:sub2[2, 3]}, :cat1{:sub1[1]});

    is-deeply % .classify-list(&m, [1, 2, 3]), %ex, '&, Array';
    is-deeply % .classify-list(%m, [1, 2, 3]), %ex, '%, Array';
    is-deeply % .classify-list(@m, [1, 2, 3]), %ex, '@, Array';
    is-deeply % .classify-list(&m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply % .classify-list(%m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply % .classify-list(@m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply % .classify-list(&m,   ^3+1   ), %ex, '&, Range';
    is-deeply % .classify-list(%m,   ^3+1   ), %ex, '%, Range';
    is-deeply % .classify-list(@m,   ^3+1   ), %ex, '@, Range';
    is-deeply % .classify-list(&m,   (1…3)  ), %ex, '&, Seq';
    is-deeply % .classify-list(%m,   (1…3)  ), %ex, '%, Seq';
    is-deeply % .classify-list(@m,   (1…3)  ), %ex, '@, Seq';
}

subtest 'on empty Hash, multi-level, with &as' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &m  = { $^a == 1 ?? <cat1 sub1> !! <cat2 sub2> }
    my constant @m  = Nil,   <cat1 sub1>,      <cat2 sub2>,      <cat2 sub2>;
    my constant %m  = %(1 => <cat1 sub1>, 2 => <cat2 sub2>, 3 => <cat2 sub2>);
    my constant %ex = %(:cat2{:sub2['val 2', 'val 3']}, :cat1{:sub1['val 1']});

    is-deeply % .classify-list(:&as, &m, [1, 2, 3]), %ex, '&, Array';
    is-deeply % .classify-list(:&as, %m, [1, 2, 3]), %ex, '%, Array';
    is-deeply % .classify-list(:&as, @m, [1, 2, 3]), %ex, '@, Array';
    is-deeply % .classify-list(:&as, &m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply % .classify-list(:&as, %m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply % .classify-list(:&as, @m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply % .classify-list(:&as, &m,   ^3+1   ), %ex, '&, Range';
    is-deeply % .classify-list(:&as, %m,   ^3+1   ), %ex, '%, Range';
    is-deeply % .classify-list(:&as, @m,   ^3+1   ), %ex, '@, Range';
    is-deeply % .classify-list(:&as, &m,   (1…3)  ), %ex, '&, Seq';
    is-deeply % .classify-list(:&as, %m,   (1…3)  ), %ex, '%, Seq';
    is-deeply % .classify-list(:&as, @m,   (1…3)  ), %ex, '@, Seq';
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

    is-deeply %(:42a).classify-list(&m, [1, 2, 3]), %ex, '&, Array';
    is-deeply %(:42a).classify-list(%m, [1, 2, 3]), %ex, '%, Array';
    is-deeply %(:42a).classify-list(@m, [1, 2, 3]), %ex, '@, Array';
    is-deeply %(:42a).classify-list(&m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply %(:42a).classify-list(%m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply %(:42a).classify-list(@m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply %(:42a).classify-list(&m,   ^3+1   ), %ex, '&, Range';
    is-deeply %(:42a).classify-list(%m,   ^3+1   ), %ex, '%, Range';
    is-deeply %(:42a).classify-list(@m,   ^3+1   ), %ex, '@, Range';
    is-deeply %(:42a).classify-list(&m,   (1…3)  ), %ex, '&, Seq';
    is-deeply %(:42a).classify-list(%m,   (1…3)  ), %ex, '%, Seq';
    is-deeply %(:42a).classify-list(@m,   (1…3)  ), %ex, '@, Seq';
}

subtest 'on populated Hash, basic, with &as' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &m  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %m  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @m  = Nil, 'cat1', 'cat2', 'cat2';
    my constant %ex = %(:a(42), :cat2['val 2', 'val 3'], :cat1['val 1']);

    is-deeply %(:42a).classify-list(:&as, &m, [1, 2, 3]), %ex, '&, Array';
    is-deeply %(:42a).classify-list(:&as, %m, [1, 2, 3]), %ex, '%, Array';
    is-deeply %(:42a).classify-list(:&as, @m, [1, 2, 3]), %ex, '@, Array';
    is-deeply %(:42a).classify-list(:&as, &m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply %(:42a).classify-list(:&as, %m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply %(:42a).classify-list(:&as, @m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply %(:42a).classify-list(:&as, &m,   ^3+1   ), %ex, '&, Range';
    is-deeply %(:42a).classify-list(:&as, %m,   ^3+1   ), %ex, '%, Range';
    is-deeply %(:42a).classify-list(:&as, @m,   ^3+1   ), %ex, '@, Range';
    is-deeply %(:42a).classify-list(:&as, &m,   (1…3)  ), %ex, '&, Seq';
    is-deeply %(:42a).classify-list(:&as, %m,   (1…3)  ), %ex, '%, Seq';
    is-deeply %(:42a).classify-list(:&as, @m,   (1…3)  ), %ex, '@, Seq';
}

subtest 'on populated Hash, multi-level' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? <cat1 sub1> !! <cat2 sub2> }
    my constant @m  = Nil,   <cat1 sub1>,      <cat2 sub2>,      <cat2 sub2>;
    my constant %m  = %(1 => <cat1 sub1>, 2 => <cat2 sub2>, 3 => <cat2 sub2>);
    my constant %ex = %(:a(42), :cat2{:sub2[2, 3]}, :cat1{:sub1[1]});

    is-deeply %(:42a).classify-list(&m, [1, 2, 3]), %ex, '&, Array';
    is-deeply %(:42a).classify-list(%m, [1, 2, 3]), %ex, '%, Array';
    is-deeply %(:42a).classify-list(@m, [1, 2, 3]), %ex, '@, Array';
    is-deeply %(:42a).classify-list(&m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply %(:42a).classify-list(%m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply %(:42a).classify-list(@m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply %(:42a).classify-list(&m,   ^3+1   ), %ex, '&, Range';
    is-deeply %(:42a).classify-list(%m,   ^3+1   ), %ex, '%, Range';
    is-deeply %(:42a).classify-list(@m,   ^3+1   ), %ex, '@, Range';
    is-deeply %(:42a).classify-list(&m,   (1…3)  ), %ex, '&, Seq';
    is-deeply %(:42a).classify-list(%m,   (1…3)  ), %ex, '%, Seq';
    is-deeply %(:42a).classify-list(@m,   (1…3)  ), %ex, '@, Seq';
}

subtest 'on populated Hash, multi-level, with &as' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &m  = { $^a == 1 ?? <cat1 sub1> !! <cat2 sub2> }
    my constant @m  = Nil,   <cat1 sub1>,      <cat2 sub2>,      <cat2 sub2>;
    my constant %m  = %(1 => <cat1 sub1>, 2 => <cat2 sub2>, 3 => <cat2 sub2>);
    my constant %ex
    = %(:a(42), :cat2{:sub2['val 2', 'val 3']}, :cat1{:sub1['val 1']});

    is-deeply %(:42a).classify-list(:&as, &m, [1, 2, 3]), %ex, '&, Array';
    is-deeply %(:42a).classify-list(:&as, %m, [1, 2, 3]), %ex, '%, Array';
    is-deeply %(:42a).classify-list(:&as, @m, [1, 2, 3]), %ex, '@, Array';
    is-deeply %(:42a).classify-list(:&as, &m,  1, 2, 3 ), %ex, '&, comma list';
    is-deeply %(:42a).classify-list(:&as, %m,  1, 2, 3 ), %ex, '%, comma list';
    is-deeply %(:42a).classify-list(:&as, @m,  1, 2, 3 ), %ex, '@, comma list';
    is-deeply %(:42a).classify-list(:&as, &m,   ^3+1   ), %ex, '&, Range';
    is-deeply %(:42a).classify-list(:&as, %m,   ^3+1   ), %ex, '%, Range';
    is-deeply %(:42a).classify-list(:&as, @m,   ^3+1   ), %ex, '@, Range';
    is-deeply %(:42a).classify-list(:&as, &m,   (1…3)  ), %ex, '&, Seq';
    is-deeply %(:42a).classify-list(:&as, %m,   (1…3)  ), %ex, '%, Seq';
    is-deeply %(:42a).classify-list(:&as, @m,   (1…3)  ), %ex, '@, Seq';
}

#------------------------------------------------------------------------------
# degenerate cases
#------------------------------------------------------------------------------

subtest 'on Hashes, degenerate cases' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &m  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %m  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @m  = Nil, 'cat1', 'cat2', 'cat2';
    my constant %ex-empty = %();
    my constant %ex-poplt = %(:42a);

    is-deeply %      .classify-list(      &m), %ex-empty, 'empty, &';
    is-deeply %      .classify-list(      %m), %ex-empty, 'empty, %';
    is-deeply %      .classify-list(      @m), %ex-empty, 'empty, @';
    is-deeply %      .classify-list(:&as, &m), %ex-empty, 'empty, :&as, &';
    is-deeply %      .classify-list(:&as, %m), %ex-empty, 'empty, :&as, %';
    is-deeply %      .classify-list(:&as, @m), %ex-empty, 'empty, :&as, @';
    is-deeply %(:42a).classify-list(      &m), %ex-poplt, 'populated, &';
    is-deeply %(:42a).classify-list(      %m), %ex-poplt, 'populated, %';
    is-deeply %(:42a).classify-list(      @m), %ex-poplt, 'populated, @';
    is-deeply %(:42a).classify-list(:&as, &m), %ex-poplt, 'populated, :&as, &';
    is-deeply %(:42a).classify-list(:&as, %m), %ex-poplt, 'populated, :&as, %';
    is-deeply %(:42a).classify-list(:&as, @m), %ex-poplt, 'populated, :&as, @';
}

#------------------------------------------------------------------------------
# exceptions
#------------------------------------------------------------------------------

subtest ‘on Hashes, exceptions, can't classify lazy lists’ => {
    plan 12;
    my constant $l  = (−∞…∞);
    my constant &as = { "val $^a" }

    throws-like { % .classify-list: {;}, $l }, X::Cannot::Lazy, 'empty hash, &';
    throws-like { % .classify-list:  %,  $l }, X::Cannot::Lazy, 'empty hash, %';
    throws-like { % .classify-list:  @,  $l }, X::Cannot::Lazy, 'empty hash, @';
    throws-like { % .classify-list: :&as, {;}, $l }, X::Cannot::Lazy,
        'empty hash, :&as, &';
    throws-like { % .classify-list: :&as,  %, $l }, X::Cannot::Lazy,
        'empty hash, :&as, %';
    throws-like { % .classify-list: :&as,  @, $l }, X::Cannot::Lazy,
        'empty hash, :&as, @';

    throws-like { %(:42a).classify-list: {;}, $l }, X::Cannot::Lazy,
        'populated hash, &';
    throws-like { %(:42a).classify-list:  %, $l }, X::Cannot::Lazy,
        'populated hash, %';
    throws-like { %(:42a).classify-list:  @, $l }, X::Cannot::Lazy,
        'populated hash, @';

    throws-like { %(:42a).classify-list: :&as, {;}, $l }, X::Cannot::Lazy,
        'populated hash, :&as, &';
    throws-like { %(:42a).classify-list: :&as,  %, $l }, X::Cannot::Lazy,
        'populated hash, :&as, %';
    throws-like { %(:42a).classify-list: :&as,  @, $l }, X::Cannot::Lazy,
        'populated hash, :&as, @';
}

subtest ‘on Hashes, exceptions, can't do mixed-level classification’ => {
    plan 12;
    my constant &m1  = { $^a == 1 ?? 'cat1' !! <cat2 cat3> }
    my constant %m1  = %(1 => 'cat1', 2 => <cat2 cat3>, 3 => <cat2 cat3>);
    my constant @m1  = Nil, 'cat1', <cat2 cat3>, <cat2 cat3>;
    my constant &m2  = { $^a == 1 ?? <cat1 cat3> !! 'cat2' }
    my constant %m2  = %(1 => <cat1 cat3>, 2 => 'cat2', 3 => 'cat2');
    my constant @m2  = Nil, <cat1 cat3>, 'cat2', 'cat2';
    my constant &as = { "val $^a" }

    throws-like { % .classify-list: &m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '&, v1';
    throws-like { % .classify-list: %m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '%, v1';
    throws-like { % .classify-list: @m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '@, v1';
    throws-like { % .classify-list: &m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '&, v2';
    throws-like { % .classify-list: %m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '%, v2';
    throws-like { % .classify-list: @m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '@, v2';

    throws-like { % .classify-list: :&as, &m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, &, v1';
    throws-like { % .classify-list: :&as, %m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, %, v1';
    throws-like { % .classify-list: :&as, @m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, @, v1';
    throws-like { % .classify-list: :&as, &m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, &, v2';
    throws-like { % .classify-list: :&as, %m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, %, v2';
    throws-like { % .classify-list: :&as, @m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, @, v2';
}

###############################################################################
# on Baggy
###############################################################################

#------------------------------------------------------------------------------
# empty Baggy
#------------------------------------------------------------------------------

subtest 'on empty BagHash' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %m  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @m  = Nil, 'cat1', 'cat2', 'cat2';
    my constant $ex = BagHash.new: <cat1  cat2 cat2>;

    is-deeply BagHash.new.classify-list(&m, [1, 2, 3]), $ex, '&, Array';
    is-deeply BagHash.new.classify-list(%m, [1, 2, 3]), $ex, '%, Array';
    is-deeply BagHash.new.classify-list(@m, [1, 2, 3]), $ex, '@, Array';
    is-deeply BagHash.new.classify-list(&m,  1, 2, 3 ), $ex, '&, comma list';
    is-deeply BagHash.new.classify-list(%m,  1, 2, 3 ), $ex, '%, comma list';
    is-deeply BagHash.new.classify-list(@m,  1, 2, 3 ), $ex, '@, comma list';
    is-deeply BagHash.new.classify-list(&m,   ^3+1   ), $ex, '&, Range';
    is-deeply BagHash.new.classify-list(%m,   ^3+1   ), $ex, '%, Range';
    is-deeply BagHash.new.classify-list(@m,   ^3+1   ), $ex, '@, Range';
    is-deeply BagHash.new.classify-list(&m,   (1…3)  ), $ex, '&, Seq';
    is-deeply BagHash.new.classify-list(%m,   (1…3)  ), $ex, '%, Seq';
    is-deeply BagHash.new.classify-list(@m,   (1…3)  ), $ex, '@, Seq';
}

subtest 'on populated BagHash' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %m  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @m  = Nil, 'cat1', 'cat2', 'cat2';
    my constant $ex = BagHash.new: <a b  cat1  cat2 cat2>;

    is-deeply BagHash.new(<a b>).classify-list(&m, [1, 2, 3]), $ex, '&, Array';
    is-deeply BagHash.new(<a b>).classify-list(%m, [1, 2, 3]), $ex, '%, Array';
    is-deeply BagHash.new(<a b>).classify-list(@m, [1, 2, 3]), $ex, '@, Array';
    is-deeply BagHash.new(<a b>).classify-list(&m,  1, 2, 3 ), $ex, '&, commas';
    is-deeply BagHash.new(<a b>).classify-list(%m,  1, 2, 3 ), $ex, '%, commas';
    is-deeply BagHash.new(<a b>).classify-list(@m,  1, 2, 3 ), $ex, '@, commas';
    is-deeply BagHash.new(<a b>).classify-list(&m,   ^3+1   ), $ex, '&, Range';
    is-deeply BagHash.new(<a b>).classify-list(%m,   ^3+1   ), $ex, '%, Range';
    is-deeply BagHash.new(<a b>).classify-list(@m,   ^3+1   ), $ex, '@, Range';
    is-deeply BagHash.new(<a b>).classify-list(&m,   (1…3)  ), $ex, '&, Seq';
    is-deeply BagHash.new(<a b>).classify-list(%m,   (1…3)  ), $ex, '%, Seq';
    is-deeply BagHash.new(<a b>).classify-list(@m,   (1…3)  ), $ex, '@, Seq';
}

subtest 'on populated MixHash' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %m  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @m  = Nil, 'cat1', 'cat2', 'cat2';
    my constant $ex = MixHash.new: <a b  cat1  cat2 cat2>;

    is-deeply MixHash.new(<a b>).classify-list(&m, [1, 2, 3]), $ex, '&, Array';
    is-deeply MixHash.new(<a b>).classify-list(%m, [1, 2, 3]), $ex, '%, Array';
    is-deeply MixHash.new(<a b>).classify-list(@m, [1, 2, 3]), $ex, '@, Array';
    is-deeply MixHash.new(<a b>).classify-list(&m,  1, 2, 3 ), $ex, '&, commas';
    is-deeply MixHash.new(<a b>).classify-list(%m,  1, 2, 3 ), $ex, '%, commas';
    is-deeply MixHash.new(<a b>).classify-list(@m,  1, 2, 3 ), $ex, '@, commas';
    is-deeply MixHash.new(<a b>).classify-list(&m,   ^3+1   ), $ex, '&, Range';
    is-deeply MixHash.new(<a b>).classify-list(%m,   ^3+1   ), $ex, '%, Range';
    is-deeply MixHash.new(<a b>).classify-list(@m,   ^3+1   ), $ex, '@, Range';
    is-deeply MixHash.new(<a b>).classify-list(&m,   (1…3)  ), $ex, '&, Seq';
    is-deeply MixHash.new(<a b>).classify-list(%m,   (1…3)  ), $ex, '%, Seq';
    is-deeply MixHash.new(<a b>).classify-list(@m,   (1…3)  ), $ex, '@, Seq';
}

#------------------------------------------------------------------------------
# degenerate cases
#------------------------------------------------------------------------------

subtest 'degenerate cases, on Baggy' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %m  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @m  = Nil, 'cat1', 'cat2', 'cat2';
    my constant $ex-bag-empty = BagHash.new;
    my constant $ex-mix-empty = MixHash.new;
    my constant $ex-bag-poplt = BagHash.new: <a b>;
    my constant $ex-mix-poplt = MixHash.new: <a b>;

    is-deeply BagHash.new.classify-list(&m), $ex-bag-empty, 'BagHash, empty, &';
    is-deeply BagHash.new.classify-list(%m), $ex-bag-empty, 'BagHash, empty, %';
    is-deeply BagHash.new.classify-list(@m), $ex-bag-empty, 'BagHash, empty, @';
    is-deeply MixHash.new.classify-list(&m), $ex-mix-empty, 'MixHash, empty, &';
    is-deeply MixHash.new.classify-list(%m), $ex-mix-empty, 'MixHash, empty, %';
    is-deeply MixHash.new.classify-list(@m), $ex-mix-empty, 'MixHash, empty, @';
    is-deeply BagHash.new(<a b>).classify-list(&m), $ex-bag-poplt,
        'BagHash, populated, &';
    is-deeply BagHash.new(<a b>).classify-list(%m), $ex-bag-poplt,
        'BagHash, populated, %';
    is-deeply BagHash.new(<a b>).classify-list(@m), $ex-bag-poplt,
        'BagHash, populated, @';
    is-deeply MixHash.new(<a b>).classify-list(&m), $ex-mix-poplt,
        'MixHash, populated, &';
    is-deeply MixHash.new(<a b>).classify-list(%m), $ex-mix-poplt,
        'MixHash, populated, %';
    is-deeply MixHash.new(<a b>).classify-list(@m), $ex-mix-poplt,
        'MixHash, populated, @';
}


#------------------------------------------------------------------------------
# exceptions
#------------------------------------------------------------------------------

subtest ‘on Baggy, exceptions, can't classify lazy lists’ => {
    plan 12;
    my constant $l = (−∞…∞);

    throws-like { BagHash.new.classify-list: {;}, $l }, X::Cannot::Lazy,
        'empty BagHash, &';
    throws-like { BagHash.new.classify-list:  %,  $l }, X::Cannot::Lazy,
        'empty BagHash, %';
    throws-like { BagHash.new.classify-list:  @,  $l }, X::Cannot::Lazy,
        'empty BagHash, @';
    throws-like { MixHash.new.classify-list: {;}, $l }, X::Cannot::Lazy,
        'empty MixHash, &';
    throws-like { MixHash.new.classify-list:  %,  $l }, X::Cannot::Lazy,
        'empty MixHash, %';
    throws-like { MixHash.new.classify-list:  @,  $l }, X::Cannot::Lazy,
        'empty MixHash, @';

    throws-like { BagHash.new(<a b>).classify-list: {;}, $l }, X::Cannot::Lazy,
        'populated BagHash, &';
    throws-like { BagHash.new(<a b>).classify-list:  %,  $l }, X::Cannot::Lazy,
        'populated BagHash, %';
    throws-like { BagHash.new(<a b>).classify-list:  @,  $l }, X::Cannot::Lazy,
        'populated BagHash, @';
    throws-like { MixHash.new(<a b>).classify-list: {;}, $l }, X::Cannot::Lazy,
        'populated MixHash, &';
    throws-like { MixHash.new(<a b>).classify-list:  %,  $l }, X::Cannot::Lazy,
        'populated MixHash, %';
    throws-like { MixHash.new(<a b>).classify-list:  @,  $l }, X::Cannot::Lazy,
        'populated MixHash, @';
}

subtest ‘on Baggy, exceptions, can't multi-level classify’ => {
    plan 6;
    my constant &m  = { $^a == 1 ?? <cat1 sub1> !! <cat2 sub2> }
    my constant @m  = Nil,   <cat1 sub1>,      <cat2 sub2>,      <cat2 sub2>;
    my constant %m  = %(1 => <cat1 sub1>, 2 => <cat2 sub2>, 3 => <cat2 sub2>);

    throws-like { BagHash.new.classify-list: &m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level classification'/, 'BagHash, &';
    throws-like { BagHash.new.classify-list: %m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level classification'/, 'BagHash, %';
    throws-like { BagHash.new.classify-list: @m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level classification'/, 'BagHash, @';
    throws-like { MixHash.new.classify-list: &m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level classification'/, 'MixHash, &';
    throws-like { MixHash.new.classify-list: %m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level classification'/, 'MixHash, %';
    throws-like { MixHash.new.classify-list: @m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level classification'/, 'MixHash, @';
}

subtest ‘on Baggy, exceptions, can't classify on immutable Baggies’ => {
    plan 6;
    throws-like { Bag.new.classify-list: {;}, ^2 }, X::Immutable, 'Bag, &';
    throws-like { Bag.new.classify-list:  %,  ^2 }, X::Immutable, 'Bag, %';
    throws-like { Bag.new.classify-list:  @,  ^2 }, X::Immutable, 'Bag, @';
    throws-like { Mix.new.classify-list: {;}, ^2 }, X::Immutable, 'Mix, &';
    throws-like { Mix.new.classify-list:  %,  ^2 }, X::Immutable, 'Mix, %';
    throws-like { Mix.new.classify-list:  @,  ^2 }, X::Immutable, 'Mix, @';
}
