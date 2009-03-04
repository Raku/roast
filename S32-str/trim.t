use v6;

use Test;

plan 24;

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
# trim_start
#

#?rakudo skip 'waiting for patch to be accepted'
#?pugs todo 'waiting for patch to be accepted'
{
    my $foo = "   foo  \n";
    trim_start($foo);
    is($foo, "   foo  \n", 'trim_start does not trim a variable in-place');
    $foo .= trim_start;
    is($foo, "foo  \n", 'trim_start works correctly');
    $foo =  "\t   \t  \tfoo   \t\t  \t \n";
    $foo .= trim_start;
    is($foo, "foo   \t\t  \t \n", 'our variable is trimmed again with no effect');
}

#?rakudo skip 'waiting for patch to be accepted'
#?pugs todo 'waiting for patch to be accepted'
{
    is(''.trim_start, '', 'trim_start on an empty string gives an empty string');
}

#?rakudo skip 'waiting for patch to be accepted'
#?pugs todo 'waiting for patch to be accepted'
{
    my $foo = " foo bar ";
    $foo .= trim_start;
    is($foo, "foo bar ", 'our variable is trimmed correctly');
    $foo .= trim_start;
    is($foo, "foo bar ", 'our variable is trimmed again with no effect');
}

#?rakudo skip 'waiting for patch to be accepted'
#?pugs todo 'waiting for patch to be accepted'
{
    my $foo = "\n foo\n ";
    $foo .= trim_start;
    $foo .= trim_start;
    $foo .= trim_start;
    is($foo, "foo\n ", 'our variable can be trimmed multiple times');
}

#
# trim_end
#

#?rakudo skip 'waiting for patch to be accepted'
#?pugs todo 'waiting for patch to be accepted'
{
    my $foo = "   foo  \n";
    trim_end($foo);
    is($foo, "   foo  \n", 'trim_end does not trim a variable in-place');
    $foo .= trim_end;
    is($foo, "   foo", 'trim_end works correctly');
    $foo =  "\t   \t  \tfoo   \t\t  \t \n";
    $foo .= trim_end;
    is($foo, "\t   \t  \tfoo", 'our variable is trimmed again with no effect');
}

#?rakudo skip 'waiting for patch to be accepted'
#?pugs todo 'waiting for patch to be accepted'
{
    is(''.trim_end, '', 'trim_end on an empty string gives an empty string');
}

#?rakudo skip 'waiting for patch to be accepted'
#?pugs todo 'waiting for patch to be accepted'
{
    my $foo = " foo bar ";
    $foo .= trim_end;
    is($foo, " foo bar", 'our variable is trimmed correctly');
    $foo .= trim_end;
    is($foo, " foo bar", 'our variable is trimmed again with no effect');
}

#?rakudo skip 'waiting for patch to be accepted'
#?pugs todo 'waiting for patch to be accepted'
{
    my $foo = "\n foo\n ";
    $foo .= trim_end;
    $foo .= trim_end;
    $foo .= trim_end;
    is($foo, "\n foo", 'our variable can be trimmed multiple times');
}
