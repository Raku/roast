use v6;

use Test;

plan 39;

=begin pod

Basic tests for the chomp() builtin

=end pod

# L<S32::Str/Str/=item chomp>

# Also see L<"http://use.perl.org/~autrijus/journal/25351">
#   &chomp and &wrap are now nondestructive; chomp returns the chomped part,
#   which can be defined by the filehandle that obtains the default string at
#   the first place. To get destructive behaviour, use the .= form.

# testing \n newlines
{
    my $foo = "foo\n";
    chomp($foo);
    is($foo, "foo\n", 'our variable was not yet chomped');
    $foo .= chomp;
    is($foo, 'foo', 'our variable is chomped correctly');
    $foo .= chomp;
    is($foo, 'foo', 'our variable is chomped again with no effect');
}

{
    my $foo = "foo\n\n";
    $foo .= chomp;
    is($foo, "foo\n", 'our variable is chomped correctly');
    $foo .= chomp;
    is($foo, 'foo', 'our variable is chomped again correctly');
    $foo .= chomp;
    is($foo, 'foo', 'our variable is chomped again with no effect');
}

{
    my $foo = "foo\nbar\n";
    $foo .= chomp;
    is($foo, "foo\nbar", 'our variable is chomped correctly');
    $foo .= chomp;
    is($foo, "foo\nbar", 'our variable is chomped again with no effect');
}

{
    my $foo = "foo\n ";
    $foo .= chomp;
    is($foo, "foo\n ", 'our variable is chomped with no effect');
}

{
    my $foo = "foo\n\n";
    my $chomped = $foo.chomp;
    is($foo, "foo\n\n", ".chomp has no effect on the original string");
    is($chomped, "foo\n", ".chomp returns correctly chomped value");

    $chomped = $chomped.chomp;
    is($chomped, "foo", ".chomp returns correctly chomped value again");
}

# testing \r newlines
{
    my $foo = "foo\r";
    chomp($foo);
    is($foo, "foo\r", 'our variable was not yet chomped');
    $foo .= chomp;
    is($foo, 'foo', 'our variable is chomped correctly');
    $foo .= chomp;
    is($foo, 'foo', 'our variable is chomped again with no effect');
}

{
    my $foo = "foo\r\r";
    $foo .= chomp;
    is($foo, "foo\r", 'our variable is chomped correctly');
    $foo .= chomp;
    is($foo, 'foo', 'our variable is chomped again correctly');
    $foo .= chomp;
    is($foo, 'foo', 'our variable is chomped again with no effect');
}

{
    my $foo = "foo\rbar\r";
    $foo .= chomp;
    is($foo, "foo\rbar", 'our variable is chomped correctly');
    $foo .= chomp;
    is($foo, "foo\rbar", 'our variable is chomped again with no effect');
}

{
    my $foo = "foo\r ";
    $foo .= chomp;
    is($foo, "foo\r ", 'our variable is chomped with no effect');
}

{
    my $foo = "foo\r\r";
    my $chomped = $foo.chomp;
    is($foo, "foo\r\r", ".chomp has no effect on the original string");
    is($chomped, "foo\r", ".chomp returns correctly chomped value");

    $chomped = $chomped.chomp;
    is($chomped, "foo", ".chomp returns correctly chomped value again");
}

# testing \r\n newlines
{
    my $foo = "foo\r\n";
    chomp($foo);
    is($foo, "foo\r\n", 'our variable was not yet chomped');
    $foo .= chomp;
    is($foo, 'foo', 'our variable is chomped correctly');
    $foo .= chomp;
    is($foo, 'foo', 'our variable is chomped again with no effect');
}

{
    my $foo = "foo\r\n\r\n";
    $foo .= chomp;
    is($foo, "foo\r\n", 'our variable is chomped correctly');
    $foo .= chomp;
    is($foo, 'foo', 'our variable is chomped again correctly');
    $foo .= chomp;
    is($foo, 'foo', 'our variable is chomped again with no effect');
}

{
    my $foo = "foo\r\nbar\r\n";
    $foo .= chomp;
    is($foo, "foo\r\nbar", 'our variable is chomped correctly');
    $foo .= chomp;
    is($foo, "foo\r\nbar", 'our variable is chomped again with no effect');
}

{
    my $foo = "foo\r\n ";
    $foo .= chomp;
    is($foo, "foo\r\n ", 'our variable is chomped with no effect');
}

{
    my $foo = "foo\r\n\r\n";
    my $chomped = $foo.chomp;
    is($foo, "foo\r\n\r\n", ".chomp has no effect on the original string");
    is($chomped, "foo\r\n", ".chomp returns correctly chomped value");

    $chomped = $chomped.chomp;
    is($chomped, "foo", ".chomp returns correctly chomped value again");
}

#testing strings with less than 2 characters
{
    my $foo = "\n";
    my $bar = "\r";
    my $baz = "";

    my $chomped = $foo.chomp;
    is($chomped, "", ".chomp works on string with just a newline");

    $chomped = $bar.chomp;
    is($chomped, "", ".chomp works on string with just a carriage return");

    $chomped = $baz.chomp;
    is($chomped, "", ".chomp doesn't affect empty string");

    # \r\n newlines not tested because that's never less than 2 characters.
}
=begin pod

Basic tests for the chomp() builtin working on an array of strings

=end pod


# vim: ft=perl6
