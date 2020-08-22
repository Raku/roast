use v6;

use Test;

plan 3;

=begin pod

Tests for WALK, defined in L<S12/Calling sets of methods>

=end pod

#L<S12/Calling sets of methods>

subtest "Basics" => {
    plan 28;
    my class A {
        method m { 'A' }
        submethod sm { 'a' }
        submethod constrained(Str:D $v) {
            "[$v]"
        }
    }
    my class B {
        method m { 'B' }
        submethod sm { 'b' }
        method mmix(|c) { 'B::mmix(' ~ c.raku ~ ')' }
        method few { |(1, 2, 3) }
    }
    my class C is A is B {
        method m { 'C' }
        submethod sm { 'c' }
        method n { 'OH NOES' }
        submethod sn { 'oh noes' }
    }
    my class D is A {
        method m { 'D' }
        submethod sm { 'd' }
        submethod mmix(|c) { 'D::mmix(' ~ c.raku ~ ')' }
        method few { ('a', 'b', 'c') }
    }
    my class E is C is D {
        method m { 'E' }
        submethod sm { 'e' }
        submethod constrained(Int:D $v) {
            $v * 2
        }
    }

    sub cand_order(@cands, $instance) {
        my $result = '';
        for @cands -> $cand {
            $result ~= $cand($instance);
        }
        $result
    }

    # :canonical
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :canonical);
        is cand_order(@cands, $x), 'ECDAB', ':canonical (explicit) works';
        @cands = $x.WALK(:name<m>);
        is cand_order(@cands, $x), 'ECDAB', ':canonical (as default) works';
        @cands = $x.WALK(:name<sm>);
        is cand_order(@cands, $x), 'ecdab', ':canonical works with submethods';
    }

    # :super
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :super);
        is cand_order(@cands, $x), 'CD', ':super works';
    }

    # :breadth
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :breadth);
        is cand_order(@cands, $x), 'ECDAB', ':breadth works';
    }

    # :descendant
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :descendant);
        is cand_order(@cands, $x), 'ABCDE', ':descendant works';
    }

    # :ascendant
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :ascendant);
        is cand_order(@cands, $x), 'ECABD', ':ascendant works';
    }

    # :preorder
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :preorder);
        is cand_order(@cands, $x), 'ECABD', ':preorder works';
    }

    # :omit
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :omit({ .^can('n') }));
        is cand_order(@cands, $x), 'DAB', ':omit works';
    }

    # :include
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :include({ $^c.gist ~~ regex { <[CDE]> } }));
        is cand_order(@cands, $x), 'ECD', ':include works';
    }

    # :include and :omit
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :include({ $^c.gist ~~ regex { <[CDE]> } }), :omit({ .^can('n') }));
        is cand_order(@cands, $x), 'D', ':include and :omit together work';
    }

    # Should work for when
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<n>);
        is @cands.elems, 1, "just one method found";
        is cand_order(@cands, $x), 'OH NOES', "it is the method we're looking for";
        @cands = $x.WALK(:name<sn>);
        is @cands.elems, 1, "just one submethod found";
        is cand_order(@cands, $x), 'oh noes', "it is the submethod we're looking for";
    }

    # Grammar.WALK had issues once
    {
        my ($meth) = Grammar.WALK(:name<parse>);
        is $meth.name, 'parse', 'Grammar.WALK works';
    }

    # Method returns WalkList which allows batch-invoke of found methods.
    {
        my $x = E.new;
        isa-ok $x.WALK(:name<m>), WalkList, "we get WalkList from WALK";
        is-deeply $x.WALK(:name<m>).invoke.List, <E C D A B>, "got the list of return values for methods";
        is-deeply $x.WALK(:name<sm>).invoke.List, <e c d a b>, "got the list of return values for submethods";
        is-deeply $x.WALK(:name<m>)().List, <E C D A B>, "got the list of return values with direct invocation for methods";
        is-deeply $x.WALK(:name<sm>)().List, <e c d a b>, "got the list of return values with direct invocation for submethods";
        is-deeply $x.WALK(:name<sm>).reverse.invoke.List, <b a d c e>, "got reversed list of return values";
        is-deeply $x.WALK("mmix")(42, "the answer").List, ('D::mmix(\(42, "the answer"))', 'B::mmix(\(42, "the answer"))'), "invocation with parameters on mix of methods and submethods";
    }

    # Normally exceptions are rethrown except when quiet mode is set.
    {
        my $x = E.new;
        throws-like { $x.WALK("constrained")(42).raku.say }, X::TypeCheck::Binding, "throws errors by default";
        my @rv;
        lives-ok { @rv = $x.WALK("constrained").quiet.invoke(42) }, "lives in quiet mode";
        isa-ok @rv[1], Failure, "Failure is the return value of thrown method";
        isa-ok @rv[1].exception, X::TypeCheck::Binding, "Failure contains the expected exception";
    }

    # If a method returns Slip it's disrespected and returned as a List.
    # This is required to make it possible to distinguish returns from different methods.
    {
        my $x = E.new;
        isa-ok $x.WALK("few")()[1], Slip, "Slips are returned as-is";
    }
}

subtest "With Roles" => {
    my role R1 {
        submethod sm { $?PACKAGE.^name }
        method m { $?PACKAGE.^name.lc }
    }
    my role R2 {
        submethod sm { $?PACKAGE.^name }
        method m { $?PACKAGE.^name.lc }
    }
    my class C1 does R1 {
        submethod sm { $?PACKAGE.^name }
        method m { $?PACKAGE.^name.lc }
    }
    my class C2 does R2 is C1 {
        submethod sm { $?PACKAGE.^name }
        method m { $?PACKAGE.^name.lc }
    }

    my $x = C2.new;
    my @rv = $x.WALK("sm", :roles)();
    is-deeply @rv, ['C2', 'R2', 'C1', 'R1'], "WALKed over submethods in roles";
    @rv = $x.WALK("m", :roles)();
    is-deeply @rv, ['c2', 'c1'], "WALK doesn't use methods in roles";
}

subtest "Lazyness" => {
    plan 3;
    my class C1 {
        has $.call-count is rw = 0;
        has @.call-order;
        method foo {
            ++$.call-count;
            @.call-order.push: ::?CLASS.^name;
        }
    }
    my class C2 is C1 {
        method foo {
            ++$.call-count;
            @.call-order.push: ::?CLASS.^name;
        }
    }
    my class C3 is C2 {
        method foo {
            ++$.call-count;
            @.call-order.push: ::?CLASS.^name;
        }
    }
    my $obj = C3.new;
    my @full-order = <C3 C2 C1>;
    my $expect-count = 0;
    my @expect-order;
    for $obj.WALK("foo")() {
        @expect-order.push: @full-order.shift;
        ++$expect-count;
        subtest "Step $expect-count" => {
            plan 2;
            is $obj.call-count, $expect-count, "counter equalts to the step number";
            is-deeply $obj.call-order, @expect-order, "order of calls ";
        }
    }
}

done-testing;
# vim: expandtab shiftwidth=4
