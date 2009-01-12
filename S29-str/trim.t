use v6;

use Test;

plan 14;

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

# trim in list context
{
    is_deeply(trim(("abc\n")), ("abc"), "one element list");
}

{
    #?rakudo 2 todo 'trim on empty lists'
    is_deeply(trim(()), (), "trim on empty list");
    #?rakudo 2 todo 'trim on lists'
    is_deeply(trim(("abc\n", "bcd\n")), ("abc", "bcd"), "two element list");
    is_deeply(("abc\n", "bcd\n").trim, ("abc", "bcd"), "two element list");
}
