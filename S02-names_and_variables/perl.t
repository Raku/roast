use v6;

use Test;

# L<S02/Names and Variables/To get a Perlish representation of any object>

my @tests = (
    # Basic scalar values
    42, 42/10, 4.2, sqrt(2),
    #?rakudo emit # 3e5 is converted to a Str when re-evaled
    3e5,
    #?rakudo emit # Failure objects have no .perl method and +/-Inf/NaN fail
    Inf, -Inf, NaN,

    "a string", "", "\0", "\t", "\n", "\r\n", "\o7",
    '{', # "\d123",	# XXX there is no \d escape!!!
    '}',
    '$a @string %with &sigils()',

    ?1, ?0,
    undef,
    #?rakudo emit # parse error
    rx:P5/foo/, rx:P5//, rx:P5/^.*$/,

    # References to scalars
    #?rakudo emit #
    \42, \Inf, \-Inf, \NaN, \"string", \"", \?1, \?0, \undef,

    (a => 1),
    :b(2),

    # References to aggregates
    [],      # empty array
    [ 42 ],  # only one elem
    [< a b c>],
    {},           # empty hash
    { a => 42 },  # only one elem
    { :a(1), :b(2), :c(3) },

    [ 3..42 ],
    # Infinite arrays, commented because they take infram and inftime in
    # current Pugs
    #?pugs emit # 
    [ 3..Inf ],
    #?pugs emit # 
    [ -Inf..Inf ],
    #?pugs emit # 
    [ 3..42, 17..Inf, -Inf..5 ],

    # Nested things
    { a => [1,2,3] },  # only one elem
    [      [1,2,3] ],  # only one elem
    { a => [1,2,3], b => [4,5,6] },
    [ { :a(1) }, { :b(2), :c(3) } ],
);

plan 11 + 2*@tests;
#?pugs emit force_todo 8, 45..50, 94, 96;

#?pugs emit unless $?PUGS_BACKEND eq "BACKEND_PUGS" {
#?pugs emit   skip_rest "eval() not yet implemented in $?PUGS_BACKEND.";
#?pugs emit   exit;
#?pugs emit }


# L<S02/Names and Variables/To get a Perlish representation of any object>
# Quoting S02 (emphasis added):
#   To get a Perlish representation of any data value, use the .perl method.
#   This will put quotes around strings, square brackets around list values,
#   curlies around hash values, etc., **such that standard Perl could reparse
#   the result**.
{
    for @tests -> $obj {
        #?rakudo skip 'eqv not implemented'
        ok eval($obj.perl) eqv $obj,
            "($obj.perl()).perl returned something whose eval()ed stringification is unchanged";
        is ~WHAT(eval($obj.perl)), ~$obj.WHAT,
            "($obj.perl()).perl returned something whose eval()ed .WHAT is unchanged";
    }
}

# Recursive data structures
#?rakudo skip 'recursive data structure'
{
    my $foo = [ 42 ]; $foo[1] = $foo;
    is $foo[1][1][1][0], 42, "basic recursive arrayref";

    #?pugs skip 'hanging test'
    is ~$foo.perl.eval, ~$foo,
        ".perl worked correctly on a recursive arrayref";
}

#?rakudo skip 'recursive data structure'
{
    my $foo = { a => 42 }; $foo<b> = $foo;
    is $foo<b><b><b><a>, 42, "basic recursive hashref";

    #?pugs skip 'hanging test'
    is ~$foo.perl.eval, ~$foo,
        ".perl worked correctly on a recursive hashref";
}

#?rakudo skip '{...}.perl does not work'
{
    my $foo = [ 42 ];
    my $bar = { a => 23 };
    $foo[1] = $bar;
    $bar<b> = $foo;

    is $foo[1]<b>[1]<b>[0], 42, "mixed arrayref/hashref recursive structure";

    #?pugs skip 'hanging test'
    is ~$foo.perl.eval, ~$foo,
        ".perl worked correctly on a mixed arrayref/hashref recursive structure";
}

{
    # test a bug reported by Chewie[] - apparently this is from S03
    is(eval((("f","oo","bar").keys).perl), <0 1 2>, ".perl on a .keys list");
}

{
    # test bug in .perl on result of hyperoperator
    # first the trivial case without hyperop
    my @foo = ([-1, -2], -3);
    is @foo.perl, '[[-1, -2], -3]', ".perl on a nested list";

    #?rakudo emit # parsefail on hyper operator
    my @hyp = -« ([1, 2], 3);
    # what it currently (r16460) gives
    #?rakudo 2 skip 'parsefail on hyper operator'
    isnt @hyp.perl, '[(-1, -2), -3]', "strange inner parens from .perl on result of hyperop", :todo<bug>;

    # what it should give
    is @hyp.perl, '[[-1, -2], -3]', ".perl on a nested list result of hyper operator", :todo<bug>;
}

{
    # test for a rakudo (r29667) bug:

    my @list = (1, 2);
    push @list, eval @list.perl;
    #?rakudo todo "List.perl bug"
    is +@list, 4, 'eval(@list.perl) gives a list, not an array ref';
}
