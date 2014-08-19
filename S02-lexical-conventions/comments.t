use v6;

# Test various forms of comments

use Test;
plan 51;

# L<S02/"Embedded Comments"/"Embedded comments"
#  "#" plus any bracket>
{

    ok #`[
        Multiline
        comments
        is fine
    ] 1, 'multiline embedded comment with #`[]';

    ok #`(
        Parens works also
    ) 1, 'multiline embedded comment with #`()';

    # RT #115762
    eval_lives_ok "#`( foo )", "comment as first and only statement";

    eval_lives_ok "2 * 3\n #`<<<\n comment>>>", "multiline comment with <<<";

    my $var = #`{ foo bar } 32;
    is $var, 32, 'embedded comment with #`{}';

    $var = 3 + #`「 this is a comment 」 56;
    is $var, 59, 'embedded comment with LEFT/RIGHT CORNER BRACKET';

    is 2 #`『 blah blah blah 』 * 3, 6, 'embedded comment with LEFT/RIGHT WHITE CORNER BRACKET';

    my @list = 'a'..'c';

    is @list[ #`（注释）2 ], 'c', 'embedded comment with FULLWIDTH LEFT/RIGHT PARENTHESIS';

    is @list[ 0 #`《注释》], 'a', 'embedded comment with LEFT/RIGHT DOUBLE ANGLE BRACKET';

    is @list[#`〈注释〉1], 'b', 'embedded comment with LEFT/RIGHT ANGLE BRACKET';

    # Note that 'LEFT/RIGHT SINGLE QUOTATION MARK' (i.e. ‘’) and
    # LEFT/RIGHT DOUBLE QUOTATION MARK (i.e. “”) are not valid delimiter
    # characters.

    #test some 13 more lucky unicode bracketing pairs
    is(1 #`᚛ pa ᚜ +1, 2, 'embedded comment with #`᚛᚜');
    is(1 #`⁅ re ⁆ +2, 3, 'embedded comment with #`⁅⁆');
    is(2 #`⁽ ci ⁾ +3, 5, 'embedded comment with #`⁽⁾');
    is(3 #`❨ vo ❩ +5, 8, 'embedded comment with #`❨ vo ❩');
    is(5 #`❮ mu ❯   +8, 13, 'embedded comment with #`❮❯');
    is(8 #`❰ xa ❱   +13, 21, 'embedded comment with #`❰❱');
    is(13 #`❲ ze ❳   +21, 34, 'embedded comment with #`❲❳');
    is(21 #`⟦ bi ⟧   +34, 55, 'embedded comment with #`⟦⟧');
    is(34 #`⦅ so ⦆ +55, 89, 'embedded comment with #`⦅⦆');
    is(55 #`⦓ pano ⦔   +89, 144, 'embedded comment with #⦓`⦔');
    is(144 #`⦕ papa ⦖   +233, 377, 'embedded comment with #`⦕⦖');
    is(377 #`『 pare 』   +610, 987, 'embedded comment with #`『』');
    is(610 #`﴾ paci ﴿   +987, 1597, 'embedded comment with #`﴾﴿');
}

# L<S02/"Embedded Comments"/"no space" between "#" and bracket>
#?niecza skip 'Opening bracket is required for #` comment'
{

    throws_like { EVAL "3 * #` (invalid comment) 2" },
      X::Comp::AdHoc,  # no exception type yet
      "no space allowed between '#`' and '('";
    throws_like { EVAL "3 * #`\t[invalid comment] 2" },
      X::Comp::AdHoc,  # no exception type yet
      "no tab allowed between '#`' and '['";
    throws_like { EVAL "3 * #`  \{invalid comment\} 2" },
      X::Comp::AdHoc,  # no exception type yet
      "no spaces allowed between '#`' and '\{'";
    throws_like { EVAL "3 * #`\n<invalid comment> 2" },
      X::Syntax::Confused,
      "no spaces allowed between '#`' and '<'";

}

# L<S02/"User-selected Brackets"/"closed by" "same number of"
#   "closing brackets">
{

    ok #`<<<
        Or this <also> works...
    >>> 1, '#`<<<...>>>';
}

# RT #121305
{
    eval_lives_ok( q{{
        my $var = \#`((( comment ))) 12;
        is $var, 12, '#`(((...)))';
    }}, 'Unspaced bracketed comment throws no error' );
}

{
    is(5 * #`<< < >> 5, 25, '#`<< < >>');

    is(6 * #`<< > >> 6, 36, '#`<< > >>');
}

# L<S02/"Embedded Comments"/"Brackets may be nested">
{
    is 3, #`(
        (Nested parens) works also
    ) 3, 'nested parens #`(...(...)...)';

    is 3, #`{
        {Nested braces} works also {}
    } 3, 'nested braces #`{...{...}...}';
}

# I am not sure if this is speced somewhere:
# comments can be nested
#?niecza skip 'Possible runaway string'
{
    is 3, #`(
            comment
            #`{
              internal comment
            }
            more comment
        ) 3, 'comments can be nested with different brackets';
    is 3, #`(
            comment
            #`(
                internal comment
            )
            more
            ) 3, 'comments can be nested with same brackets';

    # TODO:
    # ok EVAL(" #`{ comment }") fails with an error as it tries to execute
    # comment() before seeing that I meant #`{ comment within this string.

#?rakudo todo 'NYI'
    eval_lives_ok " #`<<\n comment\n # >>\n >> 3",
        'single line comment cannot correctly nested within multiline';
}

# L<S02/"User-selected Brackets"/"Counting of nested brackets"
#   "applies only to" "pairs of brackets of the same length">
{
    is -1 #`<<<
        Even <this> <<< also >>> works...
    >>>, -1, 'nested brackets in embedded comment';

    is 'cat', #`{{
        This comment contains unmatched } and { { { {   (ignored)
        Plus a nested {{ ... }} pair                    (counted)
    }} 'cat', 'embedded comments with nested/unmatched bracket chars';
}

# L<S02/Comments in Unspaces and vice versa/"comment may not contain an unspace">
#?niecza skip 'Excess arguments to CORE eval'
{
    throws_like { EVAL '$a = #`\  (comment) 32' },
      X::Undeclared,
      "comments can't contain unspace";
}

# L<S02/Single-line Comments/"# may not be used as" 
#   delimiter quoting>
{
    my $a;
    lives_ok { EVAL '$a = q{ 32 }' }, 'sanity check';
    is $a, ' 32 ', 'sanity check';
}

#?rakudo todo 'NYI'
{
    my $a = Nil;
    throws_like { EVAL '$a = q# 32 #;' },
      X::Comp::AdHoc,
      'misuse of # as quote delimiters';
    ok !$a.defined, "``#'' can't be used as quote delimiters";
}

# L<S02/Single-line Comments/"single-line comments">
#?niecza todo
{
    # RT #70752
    lives_ok { EVAL "#=======\n#=======\nuse v6;" }, 
      "pragma use after single line comments";
}

# L<S02/Multiline Comments/POD sections may be>
lives_ok { EVAL q{{

my $outerVal = EVAL(
    q{my $var = 1;

=begin comment

This is a comment without
a "=cut".

=end comment

        "bar";}
);
is $outerVal, "bar", '=begin comment without =cut parses to whitespace in code';

}} }, '=begin comment without =cut eval throws no error';


# L<S02/Multiline Comments/"single paragraph comments">
lives_ok { EVAL q{{

my $outerVal = EVAL(
    q{10 +

=comment TimToady is here!

    1;}
);
is $outerVal, 11, 'Single paragraph Pod parses to whitespace in code';

}} }, 'Single paragraph Pod eval throws no error';

#?niecza todo
lives_ok { EVAL q{{

my $outerVal = EVAL(
    q{20 +

=comment TimToady and audreyt
are both here, yay!

    2;}
);
is $outerVal, 22, 'Single paragraph Pod, multiple lines parses to whitespace in code';

}} }, 'Single paragraph Pod, multiple lines eval throws no error';

# vim: ft=perl6
