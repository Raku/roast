use v6;
use Test;
use soft;
plan 6;

#?rakudo todo "This is canary test. If this TODO passes then it's probably the time to unfudge the main tests"
# This block is to be removed when time comes.
{
    my class Foo {
        method foo($v) {
            $v * 2
        }
    }

    my class Bar is Foo {
        multi method foo(Int $v) {
            nextsame
        }
        multi method foo(Str $v) {
            nextwith $v.Int
        }
    }

    my $obj = Bar.new;
    is $obj.foo(21), 42, "Int is dispatched";
    is $obj.foo("11"), 22, "Str is dispatched";
}

#?rakudo skip 'Until 2020 dispatcher proposal is implemented'
#?DOES 4
{
    subtest "Dispatcher Chain" => {
        plan 13;
        my @order;
        my class C1 {
            method foo(|) { @order.push: ::?CLASS.^name }
        }

        my class C2  is C1 {
            proto method foo(|) {*}
            multi method foo(Str $s) {
                @order.push: ::?CLASS.^name ~ "(Str)";
                nextsame;
            }
            multi method foo(Int $s) {
                @order.push: ::?CLASS.^name ~ "(Int)";
                nextsame;
            }
            multi method foo(Num) {
                @order.push: ::?CLASS.^name ~ "(Num)";
                nextsame
            }
        }

        my class C3 is C2 {
            method foo(|) {
                @order.push: ::?CLASS.^name;
                nextsame
            }
        }

        my class C4 is C3 {
            proto method foo(|) {*}
            multi method foo(Int:D $v) {
                @order.push: ::?CLASS.^name ~ "(Int:D)";
                nextwith ~$v
            }
            multi method foo(Any) {
                @order.push: ::?CLASS.^name ~ "(Any)";
                callsame
            }
        }

        my $inst;

        $inst = C3.new;
        $inst.foo("bar");
        is-deeply @order.List, <C3 C2(Str) C1>, "a multi-method doesn't break MRO dispatching";
        @order = [];
        $inst.foo(42);
        is-deeply @order.List, <C3 C2(Int) C1>, "a multi-method dispatching works correctly";

        $inst = C4.new;
        @order = [];
        $inst.foo("baz");
        is-deeply @order.List, <C4(Any) C3 C2(Str) C1>, "multi being the first method in MRO still works";
        @order = [];
        $inst.foo(13);
        is-deeply @order.List, <C4(Int:D) C4(Any) C3 C2(Str) C1>, "nextwith does what's expected";

        my \proto := C2.^find_method('foo', :local, :no_fallback);

        nok proto.is_wrapped, "proto is not wrapped yet";
        my $wh1 = proto.wrap(my method foo-wrap(|) { @order.push: "foo-proto"; nextsame });
        ok proto.is_wrapped, "proto is wrapped now";

        @order = [];
        $inst.foo("");
        is-deeply @order.List, <C4(Any) C3 foo-proto C2(Str) C1>, "proto can be wrapped";

        proto.unwrap($wh1);
        @order = [];
        $inst.foo("");
        is-deeply @order.List, <C4(Any) C3 C2(Str) C1>, "proto can be unwrapped";

        # This should be foo(Num) candidate
        my \cand = proto.candidates[2];
        # Note that next* can't be used with blocks.
        $wh1 = cand.wrap(-> *@ { @order.push('foo-num-wrap'); callsame });
        @order = [];
        $inst.foo(pi);
        is-deeply @order.List, <C4(Any) C3 foo-num-wrap C2(Num) C1>, "we can wrap a candidate";

        # We can even wrap a candidate with another multi. It works!
        proto multi-wrap(|) {*}
        multi multi-wrap(\SELF, Num) {
            @order.push: "multi-wrap(Num)";
            nextsame
        }
        multi multi-wrap(\SELF, Any) {
            @order.push: "multi-wrap(Any)";
            nextsame
        }

        my $wh2 = cand.wrap(&multi-wrap);
        @order = [];
        $inst.foo(pi);
        is-deeply @order.List, <C4(Any) C3 multi-wrap(Num) multi-wrap(Any) foo-num-wrap C2(Num) C1>, "we can use a multi as a wrapper of a candidate";

        cand.unwrap($wh1);
        @order = [];
        $inst.foo(pi);
        is-deeply @order.List, <C4(Any) C3 multi-wrap(Num) multi-wrap(Any) C2(Num) C1>, "we can unwrap a multi";

        # Even nastier thing: wrap a candidate of our wrapper!
        my $wwh = &multi-wrap.candidates[1].wrap(sub wrap-wrapper(|) { @order.push: 'cand-wrap'; nextsame });
        @order = [];
        $inst.foo(pi);
        is-deeply @order.List, <C4(Any) C3 multi-wrap(Num) cand-wrap multi-wrap(Any) C2(Num) C1>, "we can use a multi as a wrapper of a candidate";

        # Unwrap the method candidate from the second wrapper. We then get the original behavior.
        cand.unwrap($wh2);
        @order = [];
        $inst.foo(pi);
        is-deeply @order.List, <C4(Any) C3  C2(Num) C1>, "we can use a multi as a wrapper of a candidate";
    }

    subtest "Regression: nextcallee" => {
        plan 2;
        my @order;
        my class C1 {
            method foo(|) {
                @order.push: ::?CLASS.^name
            }
        }
        my class C2 is C1 {
            method foo(|args) {
                @order.push: ::?CLASS.^name;
                my &callee = nextcallee;
                self.&callee(|args)
            }
        }
        my class C3 is C2 {
            method foo(|args) {
                @order.push: ::?CLASS.^name;
                nextsame
            }
        }
        my $inst = C3.new;
        @order = [];
        $inst.foo;
        is-deeply @order.List, <C3 C2 C1>, "checkpoint";

        C2.^find_method('foo', :no_fallback, :local)
            .wrap(
                sub (|args) {
                    @order.push: 'C2::foo::wrapper';
                    my &callee = nextcallee;
                    &callee(|args)
                });
        @order = [];
        $inst.foo;
        is-deeply @order.List, <C3 C2::foo::wrapper C2 C1>, "nextcallee doesn't break the dispatcher chain";
    }

    subtest "Regression: broken chain" => {
        plan 2;
        # A stray $*NEXT-DISPATCHER could wrongfully be picked up by a dispatcher vivified by a nested routine invocation.
        my @order;
        my class C1 {
            multi method foo {
                @order.push: "C1::foo";
                $.bar;
            }

            proto method bar(|) {*}
            multi method bar {
                @order.push: "C1::bar";
                nextsame
            }
        }

        my class C2 is C1 {
            proto method bar(|) {*}
            multi method bar {
                @order.push: "C2::bar";
                nextsame
            }

            method foo {
                @order.push: "C2::foo";
                nextsame;
            }
        }

        my $inst = C2.new;
        $inst.bar;
        is-deeply @order.List, <C2::bar C1::bar>, "control: multi dispatches as expected";
        @order = [];
        $inst.foo;
        is-deeply @order.List, <C2::foo C1::foo C2::bar C1::bar>, "multi-dispatch is not broken";
    }

    # GH Raku/problem-solving#170
    subtest "Wrap parent's first multi-candidate" => {
        plan 3;
        my @order;
        my $inst;

        my class C1 {
            method foo(|) {
                @order.push: 'C1::foo'
            }
        }

        my class C2 is C1 {
            proto method foo(|) {*}
            multi method foo(Int) {
                @order.push: 'C2::foo(Int)';
                nextsame;
            }
            multi method foo(Any) {
                @order.push: 'C2::foo(Any)';
                nextsame;
            }
        }

        my class C3 is C2 {
            method foo(|) {
                @order.push: 'C3::foo';
                nextsame
            }
        }

        my @orig-order = <C3::foo C2::foo(Int) C2::foo(Any) C1::foo>;
        $inst = C3.new;
        $inst.foo(42);
        is-deeply @order, @orig-order, "control: multi-dispatch as expected";

        my $wh = C2.^lookup('foo').candidates[0].wrap(
            -> | {
                @order.push: "C2::foo::wrapper";
                callsame
            }
        );

        @order = [];
        $inst.foo(42);
        is-deeply
            @order.List,
            <C3::foo C2::foo::wrapper C2::foo(Int) C2::foo(Any) C1::foo>,
            "wrapping of the first candidate doesn't break the chain";

        $wh.restore;

        @order = [];
        $inst.foo(42);
        is-deeply @order, @orig-order, "unwrapping of the candidate restores the order";
    }
}

done-testing;

# vim: expandtab shiftwidth=4
