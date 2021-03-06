use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 413;

=begin pod

 Hyper operators L<S03/"Hyper operators">

=end pod

# L<S03/Hyper operators>
 # binary infix
my @r;
my @e;
{   # syntax checking, exhaustive tests in infix.t
    my $a      := (1,2,3);
    my $b      := (2,4,6);
    my $result := (3,6,9);

    is-deeply $a >>+<< $b, $result,   "ascii hyper >> <<";
    is-deeply $a  »+«  $b, $result, "unicode hyper >> <<";
    is-deeply $a >>+>> $b, $result,   "ascii hyper >> >>";
    is-deeply $a  »+»  $b, $result, "unicode hyper >> >>";
    is-deeply $a <<+>> $b, $result,   "ascii hyper << >>";
    is-deeply $a  «+»  $b, $result, "unicode hyper << >>";
    is-deeply $a <<+<< $b, $result,   "ascii hyper << <<";
    is-deeply $a  «+«  $b, $result, "unicode hyper << <<";

    is-deeply $a >>[&infix:<+>]<< $b, $result,   "ascii hyper >>[ ]<<";
    is-deeply $a  »[&infix:<+>]«  $b, $result, "unicode hyper >>[ ]<<";
    is-deeply $a >>[&infix:<+>]>> $b, $result,   "ascii hyper >>[ ]>>";
    is-deeply $a  »[&infix:<+>]»  $b, $result, "unicode hyper >>[ ]>>";
    is-deeply $a <<[&infix:<+>]>> $b, $result,   "ascii hyper <<[ ]>>";
    is-deeply $a  «[&infix:<+>]»  $b, $result, "unicode hyper <<[ ]>>";
    is-deeply $a <<[&infix:<+>]<< $b, $result,   "ascii hyper <<[ ]<<";
    is-deeply $a  «[&infix:<+>]«  $b, $result, "unicode hyper <<[ ]<<";

    @r = (1, 2, 3) »+« (10, 20, 30) »*« (2, 3, 4);
    @e = (21, 62, 123);
    is(~@r, ~@e, "precedence - »+« vs »*«");
}

{ # unary postfix
    my @r = (1, 2, 3);
    @r»++;
    my @e = (2, 3, 4);
    is(~@r, ~@e, "hyper auto increment an array");

    @r = (1, 2, 3);
    @r>>++;
    @e = (2, 3, 4);
    is(~@r, ~@e, "hyper auto increment an array ASCII notation");
};

{ # unary prefix
    my @r;
    @r = -« (3, 2, 1);
    my @e = (-3, -2, -1);
    is(~@r, ~@e, "hyper op on assignment/pipeline");

    @r = -<< (3, 2, 1);
    @e = (-3, -2, -1);
    is(~@r, ~@e, "hyper op on assignment/pipeline ASCII notation");
};

{ # dimension upgrade - ASCII
    my @r;
    @r = (1, 2, 3) >>+>> 1;
    my @e = (2, 3, 4);
    is(~@r, ~@e, "auto dimension upgrade on rhs ASCII notation");

    @r = 2 <<*<< (10, 20, 30);
    @e = (20, 40, 60);
    is(~@r, ~@e, "auto dimension upgrade on lhs ASCII notation");
}

{ # both-dwim and non-dwim sanity
    my @r = (1,2,3) <<~>> <A B C D E>;
    my @e = <1A 2B 3C 1D 2E>;
    is(~@r, ~@e, "both dwim short side lengthening on ASCII notation");

    throws-like {(1,2,3) >>~<< <A B C D E>}, X::HyperOp::NonDWIM,
        left-elems => 3, right-elems => 5,
        "both non-dwim dies correctly on ASCII notation";
}

{ # extension
    @r = (1,2,3,4) >>~>> <A B C D E>;
    @e = <1A 2B 3C 4D>;
    is(~@r, ~@e, "list-level element truncate on rhs ASCII notation");

    @r = (1,2,3,4,5) <<~<< <A B C D>;
    @e =  <1A 2B 3C 4D>;
    is(~@r, ~@e, "list-level element truncate on lhs ASCII notation");

    @r = (1,2,3,4) >>~>> <A B C>;
    @e = <1A 2B 3C 4A>;
    is(~@r, ~@e, "list-level element extension on rhs ASCII notation");

    @r = (1,2,3) <<~<< <A B C D>;
    @e =  <1A 2B 3C 1D>;
    is(~@r, ~@e, "list-level element extension on lhs ASCII notation");

    @r = (1,2,3,4) >>~>> <A B>;
    @e = <1A 2B 3A 4B>;
    is(~@r, ~@e, "list-level element extension on rhs ASCII notation");

    @r = (1,2) <<~<< <A B C D>;
    @e =  <1A 2B 1C 2D>;
    is(~@r, ~@e, "list-level element extension on lhs ASCII notation");

    @r = (1,2,3,4) >>~>> <A>;
    @e = <1A 2A 3A 4A>;
    is(~@r, ~@e, "list-level element extension on rhs ASCII notation");

    @r = (1,) <<~<< <A B C D>;
    @e = <1A 1B 1C 1D>;
    is(~@r, ~@e, "list-level element extension on lhs ASCII notation");

    @r = (1,2,3,4) >>~>> 'A';
    @e = <1A 2A 3A 4A>;
    is(~@r, ~@e, "scalar element extension on rhs ASCII notation");

    @r = 1 <<~<< <A B C D>;
    @e = <1A 1B 1C 1D>;
    is(~@r, ~@e, "scalar element extension on lhs ASCII notation");
};

{ # dimension upgrade - unicode
    @r = (1,2,3,4) »~» <A B C D E>;
    @e = <1A 2B 3C 4D>;
    is(~@r, ~@e, "list-level element truncate on rhs unicode notation");

    @r = (1,2,3,4,5) «~« <A B C D>;
    @e =  <1A 2B 3C 4D>;
    is(~@r, ~@e, "list-level element truncate on lhs unicode notation");

    @r = (1,2,3,4) »~» <A B C>;
    @e = <1A 2B 3C 4A>;
    is(~@r, ~@e, "list-level element extension on rhs unicode notation");

    @r = (1,2,3) «~« <A B C D>;
    @e =  <1A 2B 3C 1D>;
    is(~@r, ~@e, "list-level element extension on lhs unicode notation");

    @r = (1,2,3,4) »~» <A B>;
    @e = <1A 2B 3A 4B>;
    is(~@r, ~@e, "list-level element extension on rhs unicode notation");

    @r = (1,2) «~« <A B C D>;
    @e =  <1A 2B 1C 2D>;
    is(~@r, ~@e, "list-level element extension on lhs unicode notation");

    @r = (1,2,3,4) »~» <A>;
    @e = <1A 2A 3A 4A>;
    is(~@r, ~@e, "list-level element extension on rhs unicode notation");

    @r = (1,) «~« <A B C D>;
    @e = <1A 1B 1C 1D>;
    is(~@r, ~@e, "list-level element extension on lhs unicode notation");

    @r = (1,2,3,4) »~» 'A';
    @e = <1A 2A 3A 4A>;
    is(~@r, ~@e, "scalar element extension on rhs unicode notation");

    @r = 1 «~« <A B C D>;
    @e = <1A 1B 1C 1D>;
    is(~@r, ~@e, "scalar element extension on lhs unicode notation");
};

{ # binary infix with lazy or infinite lists
    my @r = (0 xx *) <<+<< (1..9);
    my @e = <1 2 3 4 5 6 7 8 9>;
    is(~@r, ~@e, "lazy list-level extension on lhs ascii notation");

    throws-like {(0 xx *) <<+>> (1..9)}, X::HyperOp::Infinite,
        side => <left>,
        "lazy list on left side with both dwim dies correctly";
    throws-like {(0 xx *) >>+>> (1..9)}, X::HyperOp::Infinite,
        side => <left>,
        "lazy list on left side with right dwim dies correctly";
    throws-like {(0 xx *) >>+<< (1..9)}, X::HyperOp::Infinite,
        side => <left>,
        "lazy list on left side with both non-dwim dies correctly";

    @r = (1..9) >>+>> (0 xx *);
    @e = <1 2 3 4 5 6 7 8 9>;
    is(~@r, ~@e, "lazy list-level extension on rhs ascii notation");

    throws-like {(1..9) <<+>> (0 xx *)}, X::HyperOp::Infinite,
        side => <right>,
        "lazy list on right side with both dwim dies correctly";
    throws-like {(1..9) <<+<< (0 xx *)}, X::HyperOp::Infinite,
        side => <right>,
        "lazy list on right side with left dwim dies correctly";
    throws-like {(1..9) >>+<< (0 xx *)}, X::HyperOp::Infinite,
        side => <right>,
        "lazy list on right side with both non-dwim dies correctly";

    throws-like {(1..Inf) >>+<< (1..Inf)}, X::HyperOp::Infinite,
        side => <both>,
        "lazy list on both sides with both non-dwim dies correctly";
    throws-like {(1..Inf) <<+>> (1..Inf)}, X::HyperOp::Infinite,
        side => <both>,
        "lazy list on both sides with both dwim dies correctly";
    throws-like {(1..Inf) <<+<< (1..Inf)}, X::HyperOp::Infinite,
        side => <both>,
        "lazy list on both sides with left dwim dies correctly";
    throws-like {(1..Inf) >>+>> (1..Inf)}, X::HyperOp::Infinite,
        side => <both>,
        "lazy list on both sides with right dwim dies correctly";
};

{ # unary postfix with integers
    my @r;
    @r = (1, 4, 9)».sqrt;
    my @e = (1, 2, 3);
    is(~@r, ~@e, "method call on integer list elements");

    @r = (1, 4, 9)>>.sqrt;
    @e = (1, 2, 3);
    is(~@r, ~@e, "method call on integer list elements (ASCII)");
}

{
    my (@r, @e);
    (@r = (1, 4, 9))»++;
    @e = (2, 5, 10);
    is(~@r, ~@e, "operator call on integer list elements");

    (@r = (1, 4, 9)).»++;
    is(~@r, ~@e, "operator call on integer list elements (Same thing, dot form)");
}

# https://github.com/Raku/old-issue-tracker/issues/3450
{
    my (@r, @e);
    @e = (2, 5, 10);

    (@r = (1, 4, 9)).».++;
    is(~@r, ~@e, "postfix operator (dotted form) on integer list elements after unary postfix hyper operator");

    (@r = (1, 4, 9)).>>.++;
    is(~@r, ~@e, "postfix operator (dotted form) on integer list elements after unary postfix hyper operator (ASCII)");

    (@r = (1, 4, 9))\  .»\  .++;
    @e = (2, 5, 10);
    is(~@r, ~@e, "postfix operator (dotted form) on integer list elements after unary postfix hyper operator (unspace form)");

    { # non-wordy postfix operator
        sub postfix:<???>($) {
            return 42;
        }
        my @a = 1 .. 3;
        is @a»???, (42, 42, 42), 'non-wordy postfix operator';
        is @a>>???, (42, 42, 42), 'non-wordy postfix operator, ASCII';
        is @a».???, (42, 42, 42), 'non-wordy postfix operator, dotted form';
        is @a>>.???, (42, 42, 42), 'non-wordy postfix operator, ASCII, dotted form';
    }

    { # wordy postfix operator
         sub postfix:<foo>($) {
             return 42;
         }
         my @a = 1 .. 3;
         is @a»foo, (42, 42, 42), 'wordy postfix operator';
         is @a>>foo, (42, 42, 42), 'wordy postfix operator, ASCII';
         throws-like { @a».foo }, X::Method::NotFound,
             message => "No such method 'foo' for invocant of type 'Int'",
             'wordy postfix operator: dotted form not allowed';
         throws-like { @a>>.foo }, X::Method::NotFound,
             message => "No such method 'foo' for invocant of type 'Int'",
             'wordy postfix operator, ASCII: dotted form not allowed';
    }

    { # no confusion with postfix:<i> (see S32-Numeric)
        my class D { method i { 42 } };
        is D.i, 42, 'manually defined method i is not confused with postfix:<i>';
        is D.i(), 42, 'manually defined method i is not confused with postfix:<i>';

        is 4i, Complex.new(0, 4), 'postfix:<i> still works';
        is 4\i, Complex.new(0, 4), 'postfix:<i> still works (2)';
        throws-like { 4.i }, X::Method::NotFound,
            message => *.starts-with("No such method 'i' for invocant of type 'Int'"),
            'dotted form of postfix:<i> fails';
        is (2,3)»i, (Complex.new(0, 2), Complex.new(0, 3)),
            'postfix:<i> works on list elements';
        is (2,3)>>i, (Complex.new(0, 2), Complex.new(0, 3)),
            'postfix:<i> works on list elements (ASCII form)';
    }

    {
        my @a = ( { 42 }, { 43 } );
        is @a».(), (42, 43), 'calling .() on list elements works';
        is @a>>.(), (42, 43), 'calling .() on list elements works, ASCII';
    }
};

# postfix forms
{ # unary postfix again, but with a twist
    my @r;
    my @e = (1, 2, 3);

    @r = ("f", "oo", "bar")».chars;
    is(~@r, ~@e, "method call on list elements");

    @r = ("f", "oo", "bar").».chars;
    is(~@r, ~@e, "method call on list elements (Same thing, dot form)");


    @r = ("f", "oo", "bar")>>.chars;
    is(~@r, ~@e, "method call on list elements (ASCII)");

    # https://github.com/Raku/old-issue-tracker/issues/2593
    @r = ("f", "oo", "bar").>>.chars;
    is(~@r, ~@e, "method call on list elements (ASCII, Same thing, dot form)");

    # https://github.com/Raku/old-issue-tracker/issues/3450
    @r = ("f", "oo", "bar")»."chars"();
    is(~@r, ~@e, "method call on list elements (quoted method name)");

    @r = ("f", "oo", "bar")>>."chars"();
    is(~@r, ~@e, "method call on list elements (ASCII, quoted method name)");
};

{ # unary postfix on a user-defined object
    my $t;
    class FooTest { method bar { 42 } }; $t = FooTest.new.bar;
    is($t, 42, 'plain method call works OK');

    my @r;
    class FooTest2 { method bar { 42 } }; @r = (FooTest2.new,)>>.bar;
    my @e = (42);
    is(~@r, ~@e, "hyper-method-call on list of user-defined objects");
};

{ # distribution for unary prefix
    my @r;
    @r = -«([1, 2], [3, [4, 5]]);
    my @e = ([-1, -2], [-3, [-4, -5]]);
    is(~@r, ~@e, "distribution for unary prefix");
    is-deeply(@r, @e, "distribution for unary prefix, deep comparison");
};

{ # distribution for unary postfix autoincrement
    my @r;
    @r = [1, 2], [3, [4, 5]];
    @r»++;
    my @e = [2, 3], [4, [5, 6]];
    is(~@r, ~@e, "distribution for unary postfix autoincr");
    is-deeply(@r, @e, "distribution for unary postfix autoincr, deep comparison");

    is @e»[1], '3 5 6', "nodal postcircumfixes do not distribute";
    is @e».elems, '2 2', "nodal methods do not distribute (elems)";
    is @e».reverse, '3 2 5 6 4', "nodal methods do not distribute (reverse)";

    is [[2, 3], [4, [5, 6]]]».all.gist, "(all(2, 3) all(4, [5 6]))", ".all is nodal";
    is [[2, 3], [4, [5, 6]]]».antipairs.gist, "((2 => 0 3 => 1) (4 => 0 [5 6] => 1))", ".antipairs is nodal";
    is [[2, 3], [4, [5, 6]]]».any.gist, "(any(2, 3) any(4, [5 6]))", ".any is nodal";
    is [[2, 3], [4, [5, 6]]]».Array.gist, "([2 3] [4 [5 6]])", ".Array is nodal";
    is [[2, 3], [4, [5, 6]]]».BagHash».keys».sort.gist, "((2 3) (4 [5 6]))", ".BagHash is nodal";
    is [[2, 3], [4, [5, 6]]]».Bag».keys».sort.gist, "((2 3) (4 [5 6]))", ".Bag is nodal";
    is [[2, 3], [4, [5, 6]]]».categorize(*.[0]).gist, '({2 => [2], 3 => [3]} {4 => [4], 5 => [[5 6]]})', ".categorize is nodal";
    is [[2, 3], [4, [5, 6]]]».classify(*.[0]).gist, '({2 => [2], 3 => [3]} {4 => [4], 5 => [[5 6]]})', ".classify is nodal";
    is [[2, 3], [4, [5, 6]]]».combinations.gist, "((() (2) (3) (2 3)) (() (4) ([5 6]) (4 [5 6])))", ".combinations is nodal";
    is [[2, 3], [4, [5, 6]]]».deepmap(*+1).gist, "([3 4] [5 [6 7]])", ".deepmap is nodal";
    is [[2, 3], [4, [5, 6]]]».duckmap(*+1).gist, "([3 4] [5 3])", ".duckmap is nodal";
    is [[2, 3], [4, [5, 6]]]».eager.gist, "[[(2) (3)] [(4) [(5) (6)]]]", ".eager is nodal";
    is [[2, 3], [4, [5, 6]]]».elems.gist, "(2 2)", ".elems is nodal";
    is [[2, 3], [4, [5, 6]]]».end.gist, "(1 1)", ".end is nodal";
    is [[2, 3], [4, [5, 6]]]».first(* > 2).gist, "(3 4)", ".first is nodal";
    is [[2, 3], [4, [5, 6]]]».flat.gist, "[[(2) (3)] [(4) [(5) (6)]]]", ".flat is nodal";
    is [[2, 3], [4, [5, 6]]]».flatmap(*+1).gist, "((3 4) (5 3))", ".flatmap is nodal";
    is [[2, 3], [4, [5, 6]]]».grep(* > 2).gist, "((3) (4))", ".grep is nodal";
    is [[2, 3], [4, [5, 6]]]».hash.gist, '({2 => 3} {4 => [5 6]})', ".hash is nodal";
    is [[2, 3], [4, [5, 6]]]».Hash.gist, '({2 => 3} {4 => [5 6]})', ".Hash is nodal";
    is [[2, 3], [4, [5, 6]]]».join(":").gist, "(2:3 4:5 6)", ".join is nodal";
    is [[2, 3], [4, [5, 6]]]».keys.gist, "((0 1) (0 1))", ".keys is nodal";
    is [[2, 3], [4, [5, 6]]]».kv.gist, "((0 2 1 3) (0 4 1 [5 6]))", ".kv is nodal";
    is [[2, 3], [4, [5, 6]]]».list.gist, "([2 3] [4 [5 6]])", ".list is nodal";
    is [[2, 3], [4, [5, 6]]]».List.gist, "((2 3) (4 [5 6]))", ".List is nodal";
    is [[2, 3], [4, [5, 6]]]».map(* + 1).gist, "((3 4) (5 3))", ".map is nodal";
    is [[2, 3], [4, [5, 6]]]».max.gist, "(3 [5 6])", ".max is nodal";
    is [[2, 3], [4, [5, 6]]]».min.gist, "(2 4)", ".min is nodal";
    is [[2, 3], [4, [5, 6]]]».minmax.gist, "(2..3 4..6)", ".minmax is nodal";
    is [[2, 3], [4, [5, 6]]]».MixHash».keys».sort.gist, "((2 3) (4 [5 6]))", ".MixHash is nodal";
    is [[2, 3], [4, [5, 6]]]».Mix».keys».sort.gist, "((2 3) (4 [5 6]))", ".Mix is nodal";
    is [[2, 3], [4, [5, 6]]]».nodemap(*+1).gist, "((3 4) (5 3))", ".nodemap is nodal";
    is [[2, 3], [4, [5, 6]]]».none.gist, "(none(2, 3) none(4, [5 6]))", ".none is nodal";
    is [[2, 3], [4, [5, 6]]]».one.gist, "(one(2, 3) one(4, [5 6]))", ".one is nodal";
    is [[2, 3], [4, [5, 6]]]».pairs.gist, "((0 => 2 1 => 3) (0 => 4 1 => [5 6]))", ".pairs is nodal";
    is [[2, 3], [4, [5, 6]]]».pairup.gist, "((2 => 3) (4 => [5 6]))", ".pairup is nodal";
    is [[2, 3], [4, [5, 6]]]».permutations.gist, "(((2 3) (3 2)) ((4 [5 6]) ([5 6] 4)))", ".permutations is nodal";
    is [[2, 3], [4, [5, 6]]]».pick(*)».sort.gist, "((2 3) (4 [5 6]))", ".pick is nodal";
    is [[2, 3], [4, [5, 6]]]».[1].gist, "(3 [5 6])", ".postcircumfix:<[ ]> is nodal";
    is [[2, [3,4]], [4, [5, 6]]]».[1;1].gist, "(4 6)", ".postcircumfix:<[; ]> is nodal";
    is [[2, 3], [4, [5, 6]]]».produce(&[+]).gist, "((2 5) (4 6))", ".produce is nodal";
    is [[2, 3], [4, [5, 6]]]».reduce(&[+]).gist, "(5 6)", ".reduce is nodal";
    is [[2, 3], [4, [5, 6]]]».repeated.gist, "(() ())", ".repeated is nodal";
    is [[2, 3], [4, [5, 6]]]».reverse.gist, "((3 2) ([5 6] 4))", ".reverse is nodal";
    is [[2, 3], [4, [5, 6]]]».roll(*).gist, "((...) (...))", ".roll is nodal";
    is [[2, 3], [4, [5, 6]]]».rotate(1).gist, "((3 2) ([5 6] 4))", ".rotate is nodal";
    is [[2, 3], [4, [5, 6]]]».rotor(2).gist, "(((2 3)) ((4 [5 6])))", ".rotor is nodal";
    is [[2, 3], [4, [5, 6]]]».Seq.gist, "((2 3) (4 [5 6]))", ".Seq is nodal";
    is [[2, 3], [4, [5, 6]]]».SetHash».keys».sort.gist, "((2 3) (4 [5 6]))", ".SetHash is nodal";
    is [[2, 3], [4, [5, 6]]]».Set».keys».sort.gist, "((2 3) (4 [5 6]))", ".Set is nodal";
    is [[2, 3], [4, [5, 6]]]».Slip.gist, "((2 3) (4 [5 6]))", ".Slip is nodal";
    is [[2, 3], [4, [5, 6]]]».sort.gist, "((2 3) (4 [5 6]))", ".sort is nodal";
    is [[2, 3], [4, [5, 6]]]».squish.gist, "((2 3) (4 [5 6]))", ".squish is nodal";
    is [[2, 3], [4, [5, 6]]]».Supply.elems, 2, ".Supply is nodal";
    is [[2, 3], [4, [5, 6]]]».tree(*.reverse,*.reverse).gist, "((3 2) ((6 5) 4))", ".tree is nodal";
    is ((2, 3), (2,3), (4, (5, (6, 7), (6, 7)), (5, (6, 7), (6, 7))))».unique(:with(&[eqv])).gist, "((2 3) (2 3) (4 (5 (6 7) (6 7))))", ".unique is nodal";
    is [[2, 3], [4, [5, 6]]]».values.gist, "((2 3) (4 [5 6]))", ".values is nodal";

    # handle mutators specially
    is [[2, 3], [4, [5, 6]]]».push((42,43)).gist, "([2 3 (42 43)] [4 [5 6] (42 43)])", ".push is nodal";
    is [[2, 3], [4, [5, 6]]]».pop.gist, "(3 [5 6])", ".pop is nodal";
    is [[2, 3], [4, [5, 6]]]».append(42,43).gist, "([2 3 42 43] [4 [5 6] 42 43])", ".append is nodal";
    is [[2, 3], [4, [5, 6]]]».unshift((42,43)).gist, "([(42 43) 2 3] [(42 43) 4 [5 6]])", ".unshift is nodal";
    is [[2, 3], [4, [5, 6]]]».shift.gist, "(2 4)", ".shift is nodal";
    is [[2, 3], [4, [5, 6]]]».prepend((42,43)).gist, "([42 43 2 3] [42 43 4 [5 6]])", ".prepend is nodal";
#?rakudo todo "doesn't seem to see the nodal"
    is [[2, 3], [4, [5, 6]]]».splice(0,1).gist, "", ".splice is nodal";

# XXX What about these?
#    is @e».HYPER.gist, '', ".HYPER is nodal";
#    is @e».ASSIGN-POS.gist, '', ".POS is nodal";
#    is @e».AT-POS.gist, '', ".POS is nodal";
#    is @e».DELETE-POS.gist, '', ".POS is nodal";
#    is @e».EXISTS-POS.gist, '', ".POS is nodal";

#    is @e».FLATTENABLE_HASH.gist, '', ".FLATTENABLE_HASH is nodal";
#    is @e».FLATTENABLE_LIST.gist, '', ".FLATTENABLE_LIST is nodal";

#    is @e».ASSIGN-KEY.gist, '', ".KEY is nodal";
#    is @e».AT-KEY.gist, '', ".KEY is nodal";
#    is @e».BIND-KEY.gist, '', ".KEY is nodal";
#    is @e».EXISTS-KEY.gist, '', ".KEY is nodal";
#    is @e».DELETE-KEY.gist, '', ".KEY is nodal";
#    is @e».<a>.gist, '', ".postcircumfix:<{ }> is nodal";
#    is @e».{'a';'a'}.gist, '', ".postcircumfix:<{; }> is nodal";
#    is [[2, 3], [4, [5, 6]]]».invert.gist, "", ".invert is nodal";
};

#?DOES 3
{ # distribution for binary infix - ASCII
    my @r;
    @r = (1, 2, [3, 4]) >>+<< (4, 5, [6, 7]);
    my @e = (5, 7, [9, 11]);
    is(~@r, ~@e, "distribution for binary infix, same shape, ASCII");
    is-deeply(@r, @e, "distribution for binary infix, same shape, ASCII, deep comparison");

    @r = (1, 2, [3, 4]) >>+>> (5, 6, 7);
    @e = (6, 8, [10, 11]);
    is(~@r, ~@e, "distribution for binary infix, dimension upgrade, ASCII");
    is-deeply(@r, @e, "distribution for binary infix, dimension upgrade, ASCII, deep comparison");

    @r = ([1, 2], 3) <<+>> (4, [5, 6]);
    @e = ([5, 6], [8, 9]);
    is(~@r, ~@e, "distribution for binary infix, S03 cross-upgrade, ASCII");
    is-deeply(@r, @e, "distribution for binary infix, S03 cross-upgrade, ASCII, deep comparison");
};

#?DOES 3
{ # distribution for binary infix - unicode
    my @r;
    @r = (1, 2, [3, 4]) »+« (4, 5, [6, 7]);
    my @e = (5, 7, [9, 11]);
    is(~@r, ~@e, "distribution for binary infix, same shape");
    is-deeply(@r, @e, "distribution for binary infix, same shape, deep comparison");

    @r = (1, 2, [3, 4]) »+» (5, 6, 7);
    @e = (6, 8, [10, 11]);
    is(~@r, ~@e, "distribution for binary infix, dimension upgrade");
    is-deeply(@r, @e, "distribution for binary infix, dimension upgrade, deep comparison");

    @r = ([1, 2], 3) «+» (4, [5, 6]);
    @e = ([5, 6], [8, 9]);
    is(~@r, ~@e, "distribution for binary infix, S03 cross-upgrade");
    is-deeply(@r, @e, "distribution for binary infix, S03 cross-upgrade, deep comparison");
};

{ # regression test, ensure that hyper works on arrays
    my @r1;
    my @r2;
    my @e1 = (2, 4, 6);
    my @a = (1, 2, 3);
    @r1 = @a >>+<< @a;
    is(~@r1, ~@e1, "hyper op works on variables, too.");
}
{
    my @a = (1, 2, 3);
    my @e2 = (2, 3, 4);
    my @r2 = @a >>+>> 1;
    is(~@r2, ~@e2, "hyper op and correctly promotes scalars");
};


# mixed hyper and reduce metaops -
# this unveils a spec bug as << recurses into arrays and [+] never gets applied,
# so we disable the entire chunk for now.
=begin todo_unspecced

    is ~([+]<< ([1,2,3], [4,5,6])), "6 15", "mixed hyper and reduce metaop ([+]<<) works";
    ## XXX: Test for [+]<<<< - This is unspecced, commenting it out
    #is ~([+]<<<< ([[1,2],[3,4]],[[5,6],[7,8]])), "3 7 11 15",
    #  "mixed double hyper and reduce metaop ([+]<<<<) works";

    is ~([+]« [1,2,3], [4,5,6]), "6 15",
      "mixed Unicode hyper and reduce metaop ([+]«) works";

=end todo_unspecced

#?DOES 2
{ # hyper dereferencing
    my @array = (
    { key => 'val' },
    { key => 'val' },
    { key => 'val' }
    );

    my $full = join '', EVAL '@array>>.<key>';
    is($full, 'valvalval', 'hyper-dereference an array');

    my $part = join '', EVAL '@array[0,1]>>.<key>';
    is($part, 'valval', 'hyper-dereference an array slice');
}

#?DOES 4
{ # junction hyper -- regression?
    my @a = 1..3;
    my @b = 4..6;
    ok ?(@a »|« @b), '»|« hyperjunction evals';
    ok ?(@a >>|<< @b), '>>|<< hyperjunction evals, ASCII';
    ok ?(@a »&« @b), '»&« hyperjunction evals';
    ok ?(@a >>&<< @b), '>>&<< hyperjunction evals, ASCII';
}

# test hypers on hashes
{
    my %a = a => 1, b => 2, c => 3;
    my %b = a => 5, b => 6, c => 7;
    my %c = a => 1, b => 2;
    my %d = a => 5, b => 6;

    my %r;
    %r = %a >>+<< %b;
    is +%r,   3,  'hash - >>+<< result has right number of keys (same keys)';
    is %r<a>, 6,  'hash - correct result from >>+<< (same keys)';
    is %r<b>, 8,  'hash - correct result from >>+<< (same keys)';
    is %r<c>, 10, 'hash - correct result from >>+<< (same keys)';

    %r = %a »+« %d;
    is +%r,   3, 'hash - »+« result has right number of keys (union test)';
    is %r<a>, 6, 'hash - correct result from »+« (union test)';
    is %r<b>, 8, 'hash - correct result from »+« (union test)';
    is %r<c>, 3, 'hash - correct result from »+« (union test)';

    %r = %c >>+<< %b;
    is +%r,   3, 'hash - >>+<< result has right number of keys (union test)';
    is %r<a>, 6, 'hash - correct result from >>+<< (union test)';
    is %r<b>, 8, 'hash - correct result from >>+<< (union test)';
    is %r<c>, 7, 'hash - correct result from >>+<< (union test)';

    %r = %a <<+>> %b;
    is +%r,   3,  'hash - <<+>> result has right number of keys (same keys)';
    is %r<a>, 6,  'hash - correct result from <<+>> (same keys)';
    is %r<b>, 8,  'hash - correct result from <<+>> (same keys)';
    is %r<c>, 10, 'hash - correct result from <<+>> (same keys)';

    %r = %a <<+>> %d;
    is +%r,   2, 'hash - <<+>> result has right number of keys (intersection test)';
    is %r<a>, 6, 'hash - correct result from <<+>> (intersection test)';
    is %r<b>, 8, 'hash - correct result from <<+>> (intersection test)';

    %r = %c <<+>> %b;
    is +%r,   2, 'hash - <<+>> result has right number of keys (intersection test)';
    is %r<a>, 6, 'hash - correct result from <<+>> (intersection test)';
    is %r<b>, 8, 'hash - correct result from <<+>> (intersection test)';

    %r = %a >>+>> %c;
    is +%r,   3, 'hash - >>+>> result has right number of keys';
    is %r<a>, 2, 'hash - correct result from >>+>>';
    is %r<b>, 4, 'hash - correct result from >>+>>';
    is %r<c>, 3, 'hash - correct result from >>+>>';

    %r = %c >>+>> %b;
    is +%r,   2, 'hash - >>+>> result has right number of keys';
    is %r<a>, 6, 'hash - correct result from >>+>>';
    is %r<b>, 8, 'hash - correct result from >>+>>';

    %r = %c <<+<< %a;
    is +%r,   3, 'hash - <<+<< result has right number of keys';
    is %r<a>, 2, 'hash - correct result from <<+<<';
    is %r<b>, 4, 'hash - correct result from <<+<<';
    is %r<c>, 3, 'hash - correct result from <<+<<';

    %r = %b <<+<< %c;
    is +%r,   2, 'hash - <<+<< result has right number of keys';
    is %r<a>, 6, 'hash - correct result from <<+<<';
    is %r<b>, 8, 'hash - correct result from <<+<<';
}

{
    my %a = a => 1, b => 2, c => 3;
    my %r = -<<%a;
    is +%r,   3, 'hash - -<< result has right number of keys';
    is %r<a>, -1, 'hash - correct result from -<<';
    is %r<b>, -2, 'hash - correct result from -<<';
    is %r<c>, -3, 'hash - correct result from -<<';

    %r = --<<%a;
    is +%r,   3, 'hash - --<< result has right number of keys';
    is %r<a>, 0, 'hash - correct result from --<<';
    is %r<b>, 1, 'hash - correct result from --<<';
    is %r<c>, 2, 'hash - correct result from --<<';
    is +%a,   3, 'hash - --<< result has right number of keys';
    is %a<a>, 0, 'hash - correct result from --<<';
    is %a<b>, 1, 'hash - correct result from --<<';
    is %a<c>, 2, 'hash - correct result from --<<';

    %r = %a>>++;
    is +%r,   3, 'hash - >>++ result has right number of keys';
    is %r<a>, 0, 'hash - correct result from >>++';
    is %r<b>, 1, 'hash - correct result from >>++';
    is %r<c>, 2, 'hash - correct result from >>++';
    is +%a,   3, 'hash - >>++ result has right number of keys';
    is %a<a>, 1, 'hash - correct result from >>++';
    is %a<b>, 2, 'hash - correct result from >>++';
    is %a<c>, 3, 'hash - correct result from >>++';
}

#?DOES 4
{
    our sub postfix:<!>($a) {
    [*] 1..$a;
    }

    my %a = a => 1, b => 2, c => 3;
    my %r = %a>>!;
    is +%r,   3, 'hash - >>! result has right number of keys';
    is %r<a>, 1, 'hash - correct result from >>!';
    is %r<b>, 2, 'hash - correct result from >>!';
    is %r<c>, 6, 'hash - correct result from >>!';
}

{
    my %a = a => 1, b => 2, c => 3;

    my %r = %a >>*>> 4;
    is +%r,   3, 'hash - >>*>> result has right number of keys';
    is %r<a>, 4, 'hash - correct result from >>*>>';
    is %r<b>, 8, 'hash - correct result from >>*>>';
    is %r<c>, 12, 'hash - correct result from >>*>>';

    %r = 2 <<**<< %a ;
    is +%r,   3, 'hash - <<**<< result has right number of keys';
    is %r<a>, 2, 'hash - correct result from <<**<<';
    is %r<b>, 4, 'hash - correct result from <<**<<';
    is %r<c>, 8, 'hash - correct result from <<**<<';

    %r = %a <<*>> 4;
    is +%r,   3, 'hash - <<*>> result has right number of keys';
    is %r<a>, 4, 'hash - correct result from <<*>>';
    is %r<b>, 8, 'hash - correct result from <<*>>';
    is %r<c>, 12, 'hash - correct result from <<*>>';

    %r = 2 <<**>> %a ;
    is +%r,   3, 'hash - <<**>> result has right number of keys';
    is %r<a>, 2, 'hash - correct result from <<**>>';
    is %r<b>, 4, 'hash - correct result from <<**>>';
    is %r<c>, 8, 'hash - correct result from <<**>>';
}

{
    my %a = a => 1, b => -2, c => 3;
    my %r = %a>>.abs;
    is +%r,   3, 'hash - >>.abs result has right number of keys';
    is %r<a>, 1, 'hash - correct result from >>.abs';
    is %r<b>, 2, 'hash - correct result from >>.abs';
    is %r<c>, 3, 'hash - correct result from >>.abs';
}

{
    my @a = (1, { a => 2, b => 3 }, 4);
    my @b = <a b c>;
    my @c = ('z', { a => 'y', b => 'x' }, 'w');
    my @d = 'a'..'f';

    my @r = @a <<~>> @b;
    is +@r, 3, 'hash in array - result array is the correct length';
    is @r[0], "1a", 'hash in array - correct result from <<~>>';
    is @r[1]<a>, "2b", 'hash in array - correct result from <<~>>';
    is @r[1]<b>, "3b", 'hash in array - correct result from <<~>>';
    is @r[2], "4c", 'hash in array - correct result from <<~>>';

    @r = @a >>~<< @c;
    is +@r, 3, 'hash in array - result array is the correct length';
    is @r[0], "1z", 'hash in array - correct result from >>~<<';
    is @r[1]<a>, "2y", 'hash in array - correct result from >>~<<';
    is @r[1]<b>, "3x", 'hash in array - correct result from >>~<<';
    is @r[2], "4w", 'hash in array - correct result from >>~<<';

    @r = @a >>~>> @d;
    is +@r, 3, 'hash in array - result array is the correct length';
    is @r[0], "1a", 'hash in array - correct result from >>~>>';
    is @r[1]<a>, "2b", 'hash in array - correct result from >>~>>';
    is @r[1]<b>, "3b", 'hash in array - correct result from >>~>>';
    is @r[2], "4c", 'hash in array - correct result from >>~>>';

    @r = @d <<R~<< @a;
    is +@r, 3, 'hash in array - result array is the correct length';
    is @r[0], "1a", 'hash in array - correct result from <<R~<<';
    is @r[1]<a>, "2b", 'hash in array - correct result from <<R~<<';
    is @r[1]<b>, "3b", 'hash in array - correct result from <<R~<<';
    is @r[2], "4c", 'hash in array - correct result from <<R~<<';

    @r = @a <<~>> @d;
    is +@r, 6, 'hash in array - result array is the correct length';
    is @r[0], "1a", 'hash in array - correct result from <<~>>';
    is @r[1]<a>, "2b", 'hash in array - correct result from <<~>>';
    is @r[1]<b>, "3b", 'hash in array - correct result from <<~>>';
    is @r[2], "4c", 'hash in array - correct result from <<~>>';
    is @r[3], "1d", 'hash in array - correct result from <<~>>';
    is @r[4]<a>, "2e", 'hash in array - correct result from <<~>>';
    is @r[4]<b>, "3e", 'hash in array - correct result from <<~>>';
    is @r[5], "4f", 'hash in array - correct result from <<~>>';
}

{
    my @a = (1, { a => 2, b => 3 }, 4);
    my @b = <a b c>;
    my @c = ('z', { a => 'y', b => 'x' }, 'w');
    my @d = 'a'..'f';

    my @r = @a «~» @b;
    is +@r, 3, 'hash in array - result array is the correct length';
    is @r[0], "1a", 'hash in array - correct result from «~»';
    is @r[1]<a>, "2b", 'hash in array - correct result from «~»';
    is @r[1]<b>, "3b", 'hash in array - correct result from «~»';
    is @r[2], "4c", 'hash in array - correct result from «~»';

    @r = @a »~« @c;
    is +@r, 3, 'hash in array - result array is the correct length';
    is @r[0], "1z", 'hash in array - correct result from »~«';
    is @r[1]<a>, "2y", 'hash in array - correct result from »~«';
    is @r[1]<b>, "3x", 'hash in array - correct result from »~«';
    is @r[2], "4w", 'hash in array - correct result from »~«';

    @r = @a »~» @d;
    is +@r, 3, 'hash in array - result array is the correct length';
    is @r[0], "1a", 'hash in array - correct result from »~»';
    is @r[1]<a>, "2b", 'hash in array - correct result from »~»';
    is @r[1]<b>, "3b", 'hash in array - correct result from »~»';
    is @r[2], "4c", 'hash in array - correct result from »~»';

    @r = @d «R~« @a;
    is +@r, 3, 'hash in array - result array is the correct length';
    is @r[0], "1a", 'hash in array - correct result from «R~«';
    is @r[1]<a>, "2b", 'hash in array - correct result from «R~«';
    is @r[1]<b>, "3b", 'hash in array - correct result from «R~«';
    is @r[2], "4c", 'hash in array - correct result from «R~«';

    @r = @a «~» @d;
    is +@r, 6, 'hash in array - result array is the correct length';
    is @r[0], "1a", 'hash in array - correct result from «~»';
    is @r[1]<a>, "2b", 'hash in array - correct result from «~»';
    is @r[1]<b>, "3b", 'hash in array - correct result from «~»';
    is @r[2], "4c", 'hash in array - correct result from «~»';
    is @r[3], "1d", 'hash in array - correct result from «~»';
    is @r[4]<a>, "2e", 'hash in array - correct result from «~»';
    is @r[4]<b>, "3e", 'hash in array - correct result from «~»';
    is @r[5], "4f", 'hash in array - correct result from «~»';
}

{
    my @a = (1, { a => 2, b => 3 }, 4);
    my @r = @a.deepmap(-*);
    is +@r, 3, 'hash in array - result array is the correct length';
    is @r[0], -1, 'hash in array - correct result from -<<';
    is @r[1]<a>, -2, 'hash in array - correct result from -<<';
    is @r[1]<b>, -3, 'hash in array - correct result from -<<';
    is @r[2], -4, 'hash in array - correct result from -<<';

    @r = @a.deepmap(++*);
    is +@r, 3, 'hash in array - result array is the correct length';
    is @r[0], 2, 'hash in array - correct result from ++<<';
    is @r[1]<a>, 3, 'hash in array - correct result from ++<<';
    is @r[1]<b>, 4, 'hash in array - correct result from ++<<';
    is @r[2], 5, 'hash in array - correct result from ++<<';

    @r = @a.deepmap(*--);
    is +@r, 3, 'hash in array - result array is the correct length';
    is @r[0], 2, 'hash in array - correct result from ++<<';
    is @r[1]<a>, 3, 'hash in array - correct result from ++<<';
    is @r[1]<b>, 4, 'hash in array - correct result from ++<<';
    is @r[2], 5, 'hash in array - correct result from ++<<';
    is +@a, 3, 'hash in array - result array is the correct length';
    is @a[0], 1, 'hash in array - correct result from ++<<';
    is @a[1]<a>, 2, 'hash in array - correct result from ++<<';
    is @a[1]<b>, 3, 'hash in array - correct result from ++<<';
    is @a[2], 4, 'hash in array - correct result from ++<<';
}

# test non-UTF-8 input
# https://github.com/Raku/old-issue-tracker/issues/3432
#?rakudo skip 'EVAL(Buf) RT #122256'
#?DOES 1
{
    my $t = '(1, 2, 3) »+« (4, 3, 2)';
    ok !EVAL($t.encode('ISO-8859-1')),
       'Latin-1 »+« without pre-declaration is an error';
}

# Test for 'my @a = <a b c> »~» "z";' wrongly
# setting @a to [['az', 'bz', 'cz']].
{
    my @a = <a b c> »~» 'z';
    is "{@a[0]}, {@a[1]}, {@a[2]}", 'az, bz, cz', "dwimmy hyper doesn't return an itemized list";
}

# L<S03/"Hyper operators"/is assumed to be infinitely extensible>
# https://github.com/Raku/old-issue-tracker/issues/2593
{
    @r = <A B C D E> »~» (1, 2, 3, *);
    @e = <A1 B2 C3 D3 E3>;
    is ~@r, ~@e, 'dwimmy hyper extends lists ending with * by copying the last element';

    @r = <A B C D E> «~» (1, 2, 3, *);
    @e = <A1 B2 C3 D3 E3>;
    is ~@r, ~@e, 'dwimmy hyper extends lists ending with * by copying the last element';

    @r = (1, 2, 3, *) «~« <A B C D E>;
    @e = <1A 2B 3C 3D 3E>;
    is ~@r, ~@e, 'dwimmy hyper extends lists ending with * by copying the last element';

    @r = (1, 2, 3, *) «~» <A B C D E>;
    @e = <1A 2B 3C 3D 3E>;
    is ~@r, ~@e, 'dwimmy hyper extends lists ending with * by copying the last element';

    @r = (1, 2, *) «~» (4, 5, *);
    @e = <14 25>;
    is ~@r, ~@e, 'dwimmy hyper omits * when both arguments of same length have one';

    @r = (1, 2, *) «~» (4, 5, 6, *);
    @e = <14 25 26>;
    is ~@r, ~@e, 'dwimmy hyper takes longer length given two arguments ending with *';
}

# https://github.com/Raku/old-issue-tracker/issues/2017

{
    # niecza doesn't propagate slangs into &EVAL yet
    eval-lives-ok 'sub infix:<+++>($a, $b) { ($a + $b) div 2 }; 10 >>+++<< 14', 'can use hypers with local scoped user-defined operators';
}

# https://github.com/Raku/old-issue-tracker/issues/1709
{
    is ~(-<<(1..3)), '-1 -2 -3', 'ranges and hyper ops mix';
}

# https://github.com/Raku/old-issue-tracker/issues/2158
# Parsing hyper-subtraction
{
    is ((9, 8) <<-<< (1, 2, 3, 4)), (8, 6, 6, 4), '<<-<<';
    is ((9, 8, 10, 12) >>->> (1, 2)), (8, 6, 9, 10), '>>->>';
    is ((9, 8) >>-<< (1, 2)), (8, 6), '>>-<<';
    is ((9, 8) <<->> (1, 2, 5)), (8, 6, 4), '<<->>';
}

# https://github.com/Raku/old-issue-tracker/issues/2169
# L<S03/Hyper operators/'@array »+=»'>
# Hyper assignment operators
{
    my @array = 3, 8, 2, 9, 3, 8;
    @r = @array »+=« (1, 2, 3, 4, 5, 6);
    @e = 4, 10, 5, 13, 8, 14;
    is @r, @e, '»+=« returns the right value';
    is @array, @e, '»+=« changes its lvalue';

    @array = 3, 8, 2, 9, 3, 8;
    @r = @array »*=» (1, 2, 3);
    @e = 3, 16, 6, 9, 6, 24;
    is @r, @e, '»*=» returns the right value';
    is @array, @e, '»*=» changes its lvalue';

    my $a = 'apple';
    my $b = 'blueberry';
    my $c = 'cherry';
    @r = ($a, $b, $c) »~=» <pie tart>;
    @e = <applepie blueberrytart cherrypie>;
    is @r, @e, '»~=» with list of scalars on the left returns the right value';
    my $e = 'applepie, blueberrytart, cherrypie';
    is "$a, $b, $c", $e, '»~=» changes each scalar';
}

# https://github.com/Raku/old-issue-tracker/issues/2353
is ((1, 2) >>[+]<< (100, 200)).join(','), '101,202',
    '>>[+]<< works';

# https://github.com/Raku/old-issue-tracker/issues/2139
{
    is ( { 1 + 1 }, { 2 + 2 } ).>>.(),
       (2, 4),
       '.>> works with .()';
    is ( { 1 + 1 }, { 2 + 2 } ).>>.(),
       ( { 1 + 1 }, { 2 + 2 } )>>.(),
       '.>>.() means the same as >>.()';
}

# https://github.com/Raku/old-issue-tracker/issues/2138
{
    sub infix:<+-*/>($a, $b) {
        ( { $a + $b }, { $a - $b }, { $a * $b }, { $a / $b } )>>.()
    };

    is 5+-*/2, (7, 3, 10, 2.5),
        'can call Callable objects in a list in parallel using >>.()';
}

# https://github.com/Raku/old-issue-tracker/issues/2044
{
    #?rakudo todo "can_meta check for meta operators NYI"
    throws-like 'my @a >>[=]>> (1,2,3)', Exception, "hypering assignment dies correctly";
}

# https://github.com/Raku/old-issue-tracker/issues/3581
{
    is 42 «~~« (Array, List, Seq), (False, False, False), "hyper against an undefined Iterable doesn't hang";
    is 42 «~~« (Hash, Bag, Pair), (False, False, False), "hyper against an undefined Associative doesn't hang";
}

# https://github.com/Raku/old-issue-tracker/issues/3287
{
    # <empty list> <hyper> <empty list>
    is () »+« (), (), "no-dwim hyper between empty lists doesn't hang";
    is () «+« (), (), "left-dwim hyper between empty lists doesn't hang";
    is () »+» (), (), "right-dwim hyper between empty lists doesn't hang";
    is () «+» (), (), "both-dwim hyper between empty lists doesn't hang";
    # <item> <hyper> <empty list>
    is True «+« (), (), "left-dwim hyper against empty RHS doesn't hang";
    is True »+» (), (), "right-dwim hyper against empty RHS doesn't hang";
    is True «+» (), (), "both-dwim hyper against empty RHS doesn't hang";
    throws-like {True »+« ()}, X::HyperOp::NonDWIM,
        left-elems => 1, right-elems => 0,
        "non-dwim hyper against empty RHS dies";
    # <empty list> <hyper> <item>
    is () «+« True, (), "left-dwim hyper against empty LHS doesn't hang";
    is () «+» True, (), "right-dwim hyper against empty LHS doesn't hang";
    is () «+» True, (), "both-dwim hyper against empty LHS doesn't hang";
    throws-like {() »+« True}, X::HyperOp::NonDWIM,
        left-elems => 0, right-elems => 1,
        "non-dwim hyper against empty RHS dies";
    my @a = «"Furthermore, Subhuti," "the basic nature" "of the five" "aggregates" "is emptiness."»;
    # <list> <hyper> <empty list>
    is @a «+« (), (), "left-dwim hyper against empty RHS doesn't hang";
    is @a »+» (), (), "right-dwim hyper against empty RHS doesn't hang";
    is @a «+» (), (), "both-dwim hyper against empty RHS doesn't hang";
    throws-like {@a »+« ()}, X::HyperOp::NonDWIM,
        left-elems => 5, right-elems => 0,
        "non-dwim hyper against empty RHS dies";
    # <empty list> <hyper> <list>
    is () «+« @a, (), "left-dwim hyper against empty LHS doesn't hang";
    is () »+» @a, (), "right-dwim hyper against empty LHS doesn't hang";
    is () «+» @a, (), "both-dwim hyper against empty LHS doesn't hang";
    throws-like {() »+« @a}, X::HyperOp::NonDWIM,
        left-elems => 0, right-elems => 5,
        "non-dwim hyper against empty RHS dies";
}

throws-like '3 «.» foo', Exception, "«.» can't be hypered";

# https://github.com/Raku/old-issue-tracker/issues/4272
{
    is 10 <<*<< (1 .. 4), <10 20 30 40>,
        'hyper op works with range on non-magical side (1)';
    is 10 <<**<< (1 .. 4), <10 100 1000 10000>,
        'hyper op works with range on non-magical side (2)';
    my $base = 10;
    my %bases = <K M G T> Z=> ( $base <<**<< (1 .. 4) );
    is %bases, { K=>10, M=>100, G=>1000, T=>10000 },
        'hyper op works with (finite) range on non-magical side (3)';
}

my &pre = &prefix:<-«>;
is pre((2,3,4)).gist, '(-2 -3 -4)', "Hyper prefix can autogen with &";
is prefix:<-«>((2,3,4)).gist, '(-2 -3 -4)', "Hyper prefix can autogen without &";

is-deeply &infix:<»+«>((1,2,3),(4,5,6)), (5, 7, 9), "Hyper >><< can autogen with &";
is-deeply &infix:<»+»>((1,2,3),1), (2, 3, 4), "Hyper >>>> can autogen with &";
is-deeply &infix:<«+«>(1,(4,5,6)), (5, 6, 7), "Hyper <<<< can autogen with &";
is-deeply &infix:<«+»>((1,2),(4,5,6)), (5, 7, 7), "Hyper <<>> can autogen with &";

is-deeply infix:<»+«>((1,2,3),(4,5,6)), (5, 7, 9), "Hyper >><< can autogen without &";
is-deeply infix:<»+»>((1,2,3),1), (2, 3, 4), "Hyper >>>> can autogen without &";
is-deeply infix:<«+«>(1,(4,5,6)), (5, 6, 7), "Hyper <<<< can autogen without &";
is-deeply infix:<«+»>((1,2),(4,5,6)), (5, 7, 7), "Hyper <<>> can autogen without &";

is-deeply &[»+«]((1,2,3),(4,5,6)), (5, 7, 9), "Hyper >><< can autogen with &[]";
is-deeply &[»+»]((1,2,3),1), (2, 3, 4), "Hyper >>>> can autogen with &[]";
is-deeply &[«+«](1,(4,5,6)), (5, 6, 7), "Hyper <<<< can autogen with &[]";
is-deeply &[«+»]((1,2),(4,5,6)), (5, 7, 7), "Hyper <<>> can autogen with &[]";

my &post = &postfix:<»i>;
is post((2,3,4)).gist, '(0+2i 0+3i 0+4i)', "Hyper postfix can autogen with &";
is &postfix:<»i>((2,3,4)).gist, '(0+2i 0+3i 0+4i)', "Hyper postfix can autogen without &";

# https://github.com/Raku/old-issue-tracker/issues/3148
is_run # shouldn't warn about unitialized values of type Any in Numeric context
    ｢my %l = foo => 1, bar => 2; my %r = bar => 3, baz => 4; say %l >>+<< %r｣,
    {:out{.contains: all <bar baz foo>}, :err(''), :0status},
    "union hyperoperator on a hash shouldn't warn about missing keys";

# https://github.com/Raku/old-issue-tracker/issues/6058
subtest 'method call variants respect nodality' => {
    plan 20;

    my @a := <a b>, <c d e>;
    my $var = ().^lookup: 'elems';

    is-deeply @a».elems,      (2, 3), '».';
    is-deeply @a»."elems"(),  (2, 3), '».""()';
    is-deeply @a».&elems,     (2, 3), '».&';
    is-deeply @a».$var,       (2, 3), '».$';
    is-deeply @a».Any::elems, (2, 3), '».::';
    # With ».:: dispatch, nodality is controled by the method being nodal, but
    # only if List type .^can that method.

    is-deeply @a».?elems,      (2, 3), '».?';
    is-deeply @a».?"elems"(),  (2, 3), '».?""()';
    is-deeply @a».?&elems,     (2, 3), '».?&';
    is-deeply @a».?$var,       (2, 3), '».?$';
    is-deeply @a».?Any::elems, (2, 3), '».?::';

    is-deeply @a».+elems,      ((2, 2), (3, 3)), '».+';
    is-deeply @a».+"elems"(),  ((2, 2), (3, 3)), '».+""()';
    is-deeply @a».+&elems,     ((2,  ), (3,  )), '».+&';
    is-deeply @a».+$var,       ((2,  ), (3,  )), '».+$';
    is-deeply @a».+Any::elems, ((2,  ), (3,  )), '».+::';

    is-deeply @a».*elems,      ((2, 2), (3, 3)), '».*';
    is-deeply @a».*"elems"(),  ((2, 2), (3, 3)), '».*""()';
    is-deeply @a».*&elems,     ((2,  ), (3,  )), '».*&';
    is-deeply @a».*$var,       ((2,  ), (3,  )), '».*$';
    is-deeply @a».*Any::elems, ((2,  ), (3,  )), '».*::';
}

#?rakudo.jvm skip 'atomicint NYI'
#?DOES 1
{
  subtest 'hyper method calls string/var method names' => {
    plan 8;

    subtest '».""() evaluates given value only once' => {
        plan 2;
        my atomicint $runs = 0;
        is-deeply (<a b>, <c d e>)»."{$runs⚛++; "elems"}"(), (2, 3),
            'right result';
        is $runs, 1, 'producing method name ran only once';
    }
    subtest '».?""() evaluates given value only once' => {
        plan 2;
        my atomicint $runs = 0;
        is-deeply (<a b>, <c d e>)».?"{$runs⚛++; "elems"}"(), (2, 3),
            'right result';
        is $runs, 1, 'producing method name ran only once';
    }
    subtest '».+""() evaluates given value only once' => {
        plan 2;
        my atomicint $runs = 0;
        is-deeply (<a b>, <c d e>)».+"{$runs⚛++; "elems"}"(), ((2, 2), (3, 3)),
            'right result';
        is $runs, 1, 'producing method name ran only once';
    }
    subtest '».*""() evaluates given value only once' => {
        plan 2;
        my atomicint $runs = 0;
        is-deeply (<a b>, <c d e>)».*"{$runs⚛++; "elems"}"(), ((2, 2), (3, 3)),
            'right result';
        is $runs, 1, 'producing method name ran only once';
    }

    {
        my atomicint $runs = 0;
        sub elems is nodal { $runs⚛++; $^thing.elems }

        subtest '».& sub calls' => {
            plan 2;
            is-deeply (<a b>, <c d e>)».&elems, (2, 3), 'right result';
            is $runs, 2, 'sub ran expected number of times';
            $runs = 0;
        }
        subtest '».?& sub calls' => {
            plan 2;
            is-deeply (<a b>, <c d e>)».?&elems, (2, 3), 'right result';
            is $runs, 2, 'sub ran expected number of times';
            $runs = 0;
        }
        subtest '».+& sub calls' => {
            plan 2;
            is-deeply (<a b>, <c d e>)».+&elems, ((2,), (3,)), 'right result';
            is $runs, 2, 'sub ran expected number of times';
            $runs = 0;
        }
        subtest '».*& sub calls' => {
            plan 2;
            is-deeply (<a b>, <c d e>)».*&elems, ((2,), (3,)), 'right result';
            is $runs, 2, 'sub ran expected number of times';
            $runs = 0;
        }
    }
  }
}

# https://github.com/rakudo/rakudo/issues/2674
is-deeply { a => (1,2,3) }.map({ .key <<=>>> .value }).list, ((:1a, :2a, :3a),),
    'No crash when RHS to be expanded is an itemized list';

# https://github.com/rakudo/rakudo/issues/2480
lives-ok {
    my @GH2480 = [[1], [2, 3]];
    my @GH2480-m = @GH2480 »*» 0;
    @GH2480-m[0][0] = 42;
}, 'An array built with a hyperoperator is mutable';

# https://github.com/rakudo/rakudo/issues/2482
lives-ok {
    my @t2482 = |<1 2> >>xx>> 2;
    is-deeply @t2482, [<1 1>.Seq, <2 2>.Seq], 'Hyper on slip values is correct';
}, 'Values created with a hyperoperator can be wrapped in a slip';

# https://github.com/rakudo/rakudo/issues/4237
is-deeply (:42a, :666b).Map>>.Str, (a => "42", b => "666").Map,
  'does hypering a Map give a Map without issues';

# vim: expandtab shiftwidth=4
