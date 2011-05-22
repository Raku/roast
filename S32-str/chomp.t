use v6;

use Test;

plan 13;

=begin pod

Basic tests for the chomp() builtin

=end pod

# L<S32::Str/Str/=item chomp>

# Also see L<"http://use.perl.org/~autrijus/journal/25351">
#   &chomp and &wrap are now nondestructive; chomp returns the chomped part,
#   which can be defined by the filehandle that obtains the default string at
#   the first place. To get destructive behaviour, use the .= form.

{
    my $foo = "foo\n";
    chomp($foo);
    is($foo, "foo\n", 'our variable was not yet chomped');
    $foo .= chomp;
    is($foo, 'foo', 'our variable is chomped correctly');
    $foo .= chomp;
    is($foo, 'foo', 'our variable is chomped again with no effect');
    #?rakudo skip "chomp with named argument"
    is(chomp(:string("station\n")), 'station', 'chomp works with a named argument');
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

=begin pod

Basic tests for the chomp() builtin working on an array of strings

=end pod


# vim: ft=perl6
