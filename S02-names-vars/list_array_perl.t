use v6;
use Test;
plan 25;

# L<S02/Names and Variables/so that Raku can evaluate the result
# back to the same object>

my @tests = (

    # References to aggregates
    [],
    [ 42 ],  # only one elem
    [< a b c>],
    [ 3..42 ],

    # XXX Actually skip these instead of commenting them out.
    # [ 3..Inf ],
    # [ -Inf..Inf ],
    # [ 3..42, 17..Inf, -Inf..5 ],

    # Nested arrays
    [      [1,2,3] ],  # only one elem
    [[2,3],4,[6,8]], # three elems
);

{
    for @tests -> $obj {
        my $s = (~$obj).subst(/\n/, '␤');
        ok EVAL($obj.raku) eq $obj,
            "($s.raku()).raku returned something whose EVAL()ed stringification is unchanged";
        is (EVAL($obj.raku).WHAT).gist, $obj.WHAT.gist,
            "($s.raku()).raku returned something whose EVAL()ed .WHAT is unchanged";
    }
}

# Recursive data structures
{
    my $foo = [ 42 ]; $foo[1] = $foo;
    is $foo[1][1][1][0], 42, "basic recursive arrayitem";

    ok $foo.raku,
        ".raku doesn't hang on a recursive arrayitem";
    ok $foo.raku.EVAL.raku,
        ".raku output parses on a recursive arrayitem";
}

{
    # test bug in .raku on result of hyperoperator
    # first the trivial case without hyperop
    my @foo = ([-1, -2], -3);
    is @foo.item.raku, '$[[-1, -2], -3]', ".raku on a nested list";

    my @hyp = -« ([1, 2], 3);
    # what it currently (r16460) gives
    isnt @hyp.item.raku, '[(-1, -2), -3]', "strange inner parens from .raku on result of hyperop";

    # what it should give
    is @hyp.item.raku, '$[[-1, -2], -3]', ".raku on a nested list result of hyper operator";
}

{
    my @list = (1, 2);
    append @list, EVAL (3, 4).raku;
    is +@list, 4, 'EVAL(@list.raku) gives a list, not a scalar';

    @list = (1,2);
    append @list, EVAL $(3, 4).raku;
    is +@list, 3, 'EVAL($@list.raku) gives a scalar list, not a list';
}

# https://github.com/Raku/old-issue-tracker/issues/757
{
    my @original      = (1,2,3);
    my $dehydrated    = @original.raku;
    my @reconstituted = @( EVAL $dehydrated );

    is @reconstituted, @original,
       "EVAL of .raku returns original for '$dehydrated'";

    @original      = (1,);
    $dehydrated    = @original.raku;
    @reconstituted = @( EVAL $dehydrated );

    is-deeply @reconstituted, @original,
       "EVAL of .raku returns original for '$dehydrated'";
}

# https://github.com/Raku/old-issue-tracker/issues/3792
{
    my $l := (1,);
    is-deeply (EVAL $l.raku), $l;
}

# https://github.com/Raku/old-issue-tracker/issues/1017
{
    my $rt65988 = (\(1,2), \(3,4));
    is-deeply EVAL( $rt65988.raku ), $rt65988, $rt65988.raku ~ '.raku';
}

# probably there is a better place for this test
# https://github.com/Raku/old-issue-tracker/issues/3074
{
    my %count;
    for ('/foo/bar/baz/' ~~ m/^ $<dirname>=(.* '/'+)? $<basename>=(<-[\/]>+) '/'* $ /).gist.lines {
        %count{$0}++ if / ^ \s+ (\w+) \s+ '=>' /;   ## extract key
    };
    is (%count<basename>, %count<dirname>), (1, 1),
        'no duplicate keys in .gist of Match of regex which backtracked';
}

# vim: expandtab shiftwidth=4
