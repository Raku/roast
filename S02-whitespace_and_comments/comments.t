use v6;

# Test various forms of comments

use Test;

plan 46;

# L<S02/"Embedded comments"/"Embedded comments"
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

    ok eval("2 * 3\n #`<<<\n comment>>>"), "multiline comment with <<<";

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
{

    ok !eval("3 * #` (invalid comment) 2"), "no space allowed between '#`' and '('";
    ok !eval("3 * #`\t[invalid comment] 2"), "no tab allowed between '#`' and '['";
    ok !eval("3 * #`  \{invalid comment\} 2"), "no spaces allowed between '#`' and '\{'";
    ok !eval("3 * #`\n<invalid comment> 2"), "no spaces allowed between '#`' and '<'";

}

# L<S02/"User-selected Brackets"/"closed by" "same number of"
#   "closing brackets">
{

    ok #`<<<
        Or this <also> works...
    >>> 1, '#`<<<...>>>';

    my $var = \#`((( comment ))) 12;
    is $var, 12, '#`(((...)))';

    is(5 * #`<< < >> 5, 25, '#`<< < >>');

    is(6 * #`<< > >> 6, 36, '#`<< > >>');
}

# L<S02/"Embedded Comments"/"Brackets may be nested">
#?rakudo skip 'nested brackets'
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
#?rakudo skip 'nested brackets'
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
    # ok eval(" #`{ comment }") fails with an error as it tries to execute
    # comment() before seeing that I meant #`{ comment within this string.

#?pugs todo 'bug'
    ok eval(" #`<<\n comment\n # >>\n >> 3"),
        'single line comment cannot correctly nested within multiline';
}

# L<S02/"User-selected Brackets"/"Counting of nested brackets"
#   "applies only to" "pairs of brackets of the same length">
#?rakudo skip 'nested parens and braces'
{
    is -1 #`<<<
        Even <this> <<< also >>> works...
    >>>, -1, 'nested brackets in embedded comment';

    is 'cat', #`{{
        This comment contains unmatched } and { { { {   (ignored)
        Plus a nested {{ ... }} pair                    (counted)
    }} 'cat', 'embedded comments with nested/unmatched bracket chars';
}

# L<S02/"Literals"/"# at beginning of line is always a line-end comment">
{
    eval_dies_ok "#<this is a comment\n'abc'",
        '#+bracket at start of line is an error';

    eval_dies_ok "2 * 3\n#<\n comment>",
        '#+bracket at start of line is an error';
}

# L<S02/Comments in Unspaces and vice versa/"comment may not contain an unspace">
{
    my $a;
    ok !eval '$a = #`\  (comment) 32', "comments can't contain unspace";
    ok !$a.defined, '$a remains undefined';
}

# L<S02/Single-line Comments/"# may not be used as" 
#   delimiter quoting>
{
    my $a;
    ok eval('$a = q{ 32 }'), 'sanity check';
    is $a, ' 32 ', 'sanity check';

    $a = Nil;
    eval_dies_ok '$a = q# 32 #;', 'misuse of # as quote delimiters';
    ok !$a.defined, "``#'' can't be used as quote delimiters";
}

# L<S02/Single-line Comments/"single-line comments"
{
    # ticket http://rt.perl.org/rt3/Ticket/Display.html?id=70752
    eval_lives_ok "#=======\n#=======\nuse v6;", "pragma use after single line comments";
}

# L<S02/Multiline Comments/POD sections may be>
=begin oppsFIXME
{
# needs to be wrapped in eval so it can be properly isolated
    my $a = eval q{
        my $var = 1;

=begin comment

This is a comment without
a "=cut".

=end comment

        "bar";
    };
    is $a, 'bar', '=begin comment without =cut works';
}

# L<S02/Multiline Comments/"single paragraph comments"
#   =for comment>

{
    is eval(q{
        my $var = 1;

=for comment TimToady is here!

        32;
    }), 32, '=for comment works';
}

{
    is eval(q{
        my $var = 1;

=for comment TimToady and audreyt
are both here, yay!

        17;
    }), 17, '=for comment works';
}

=end oppsFIXME

# vim: ft=perl6
