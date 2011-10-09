use v6;

use Test;

# L<S32::Str/Str/=item trim>

plan 36;

=begin pod

Basic tests for the trim() builtin

=end pod

# Currently this is unspecced, but active discussion on mailing lists is
# occurring, with Larry agreeing that this should be here.

{
    my $foo = "foo  \n";
    trim($foo);
    is($foo, "foo  \n", 'our variable was not yet trimmed');
    $foo .= trim;
    is($foo, 'foo', 'our variable is trimmed correctly');
    $foo =  "\t   \t  \tfoo   \t\t  \t \n";
    $foo .= trim;
    is($foo, 'foo', 'our variable is trimmed again with no effect');
}

{
    is(''.trim, '', 'trimming an empty string gives an empty string');
}

{
    is('a'.trim, 'a', 'trimming one character string, no spaces, works');
    is(' a'.trim, 'a', 'trimming one character string preceded by space works');
    is('a '.trim, 'a', 'trimming one character string followed by space works');
    is(' a '.trim, 'a', 'trimming one character string surrounded by spaces works');
}

{
    my $foo = " foo bar ";
    $foo .= trim;
    is($foo, "foo bar", 'our variable is trimmed correctly');
    $foo .= trim;
    is($foo, "foo bar", 'our variable is trimmed again with no effect');
}

{
    my $foo = "foo\n ";
    $foo .= trim;
    $foo .= trim;
    $foo .= trim;
    is($foo, "foo", 'our variable can be trimmed multiple times');
}

{
    my $foo = "foo\n\n";
    my $trimmed = $foo.trim;
    is($foo, "foo\n\n", ".trim has no effect on the original string");
    is($trimmed, "foo", ".trim returns correctly trimmed value");

    $trimmed = $trimmed.trim;
    is($trimmed, "foo", ".trim returns correctly trimmed value again");
}

#
# trim-leading
#

#?pugs todo 'waiting for patch to be accepted'
{
    my $foo = "   foo  \n";
    trim-leading($foo);
    is($foo, "   foo  \n", 'trim-leading does not trim a variable in-place');
    $foo .= trim-leading;
    is($foo, "foo  \n", 'trim-leading works correctly');
    $foo =  "\t   \t  \tfoo   \t\t  \t \n";
    $foo .= trim-leading;
    is($foo, "foo   \t\t  \t \n", 'our variable is trimmed again with no effect');
}

#?pugs todo 'waiting for patch to be accepted'
{
    is(''.trim-leading, '', 'trim-leading on an empty string gives an empty string');
    is(' '.trim-leading, '', 'trim-leading on an one-space string gives an empty string');
    is("\n".trim-leading, '', 'trim-leading on newline string gives an empty string');
    is('  '.trim-leading, '', 'trim-leading on a two-space string gives an empty string');
}

#?pugs todo 'waiting for patch to be accepted'
{
    my $foo = " foo bar ";
    $foo .= trim-leading;
    is($foo, "foo bar ", 'our variable is trimmed correctly');
    $foo .= trim-leading;
    is($foo, "foo bar ", 'our variable is trimmed again with no effect');
}

#?pugs todo 'waiting for patch to be accepted'
{
    my $foo = "\n foo\n ";
    $foo .= trim-leading;
    $foo .= trim-leading;
    $foo .= trim-leading;
    is($foo, "foo\n ", 'our variable can be trimmed multiple times');
}

#
# trim-trailing
#

#?pugs todo 'waiting for patch to be accepted'
{
    my $foo = "   foo  \n";
    trim-trailing($foo);
    is($foo, "   foo  \n", 'trim-trailing does not trim a variable in-place');
    $foo .= trim-trailing;
    is($foo, "   foo", 'trim-trailing works correctly');
    $foo =  "\t   \t  \tfoo   \t\t  \t \n";
    $foo .= trim-trailing;
    is($foo, "\t   \t  \tfoo", 'our variable is trimmed again with no effect');
}

#?pugs todo 'waiting for patch to be accepted'
{
    is(''.trim-trailing, '', 'trim-trailing on an empty string gives an empty string');
    is(' '.trim-trailing, '', 'trim-trailing on an one-space string gives an empty string');
    is("\n".trim-trailing, '', 'trim-trailing on newline string gives an empty string');
    is('  '.trim-trailing, '', 'trim-trailing on a two-space string gives an empty string');
}

#?pugs todo 'waiting for patch to be accepted'
{
    my $foo = " foo bar ";
    $foo .= trim-trailing;
    is($foo, " foo bar", 'our variable is trimmed correctly');
    $foo .= trim-trailing;
    is($foo, " foo bar", 'our variable is trimmed again with no effect');
}

#?pugs todo 'waiting for patch to be accepted'
{
    my $foo = "\n foo\n ";
    $foo .= trim-trailing;
    $foo .= trim-trailing;
    $foo .= trim-trailing;
    is($foo, "\n foo", 'our variable can be trimmed multiple times');
}

{
    ok ' ab ' ~~ /.*/, 'regex sanity';
    is $/.trim, 'ab', 'Match.trim';
}

# vim: ft=perl6
