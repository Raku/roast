use v6;

use Test;

plan 31;

=begin pod

Basic tests for the chomp() builtin

=end pod

# L<S29/"Str"/=item chomp>

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

    # $chomped.chomp.newline

    $chomped = $chomped.chomp;
    is($chomped, "foo", ".chomp returns correctly chomped value again");
}

# chomp in list context
#?rakudo skip 'is_deeply'
{
    is_deeply(chomp(()), [], "chomp on empty list");
    is_deeply(chomp(("abc\n")), ("abc"), "one element list");
    is_deeply(chomp(("abc\n", "bcd\n")), ("abc", "bcd"), "two element list");
    is_deeply(("abc\n", "bcd\n").chomp, ("abc", "bcd"), "two element list");
}
#?rakudo skip 'is_deeply'
{
    my @foo = ();
    my @bar = chomp @foo;
    is_deeply(@bar, @foo, "chomp empty array");
}
#?rakudo skip 'is_deeply'
{
    my @foo = ("abc\n");
    my @bar = chomp @foo;
    my @baz = ("abc");
    is_deeply(@bar, @baz, "chomp array with one element");
}
#?rakudo skip 'is_deeply'
{
    my @foo = ("abc\n", "bcd\n");
    my @bar = chomp @foo;
    my @baz = ("abc", "bcd");
    is_deeply(@bar, @baz, "chomp array with 2 elements");


    @bar = @foo.chomp;
    is_deeply(@bar, @baz, "chomp array with 2 elements");

    my @morgo = ("abc\n\n", "bcd\n\n");
    my @hapci = chomp @morgo;
    is_deeply(@hapci, @foo, "chomp array with 2 elements with duplicate newlines");

    my @szundi = @morgo.chomp;
    is_deeply(@szundi, @foo, "chomp array with 2 elements with duplicate newlines");
}

=begin pod

Basic tests for the chomp() builtin working on an array of strings

=end pod

# L<S29/Str/=item chomp>

# Also see L<"http://use.perl.org/~autrijus/journal/25351">
#   &chomp and &wrap are now nondestructive; chomp returns the chomped part,
#   which can be defined by the filehandle that obtains the default string at
#   the first place. To get destructive behaviour, use the .= form.
# Since currently the behaviour with regards to arrays is not defined, I'm
# assuming the correct behaviour is an extension of the behaviour for
# a single string.

{
    my @foo = ("foo\n","bar\n","baz\n");
    chomp(@foo);
    is(@foo[0], "foo\n", '1st element was not yet chomped');
    is(@foo[1], "bar\n", '2nd element was not yet chomped');
    is(@foo[2], "baz\n", '3rd element was not yet chomped');
    @foo .= chomp;
    #?rakudo 6 todo 'chomp on lists'
    is(@foo[0], 'foo', '1st element chomped correctly');
    is(@foo[1], 'bar', '2nd element chomped correctly');
    is(@foo[2], 'baz', '3rd element chomped correctly');
    @foo .= chomp;
    is(@foo[0], 'foo', '1st element is chomped again with no effect');
    is(@foo[1], 'bar', '2nd element is chomped again with no effect');
    is(@foo[2], 'baz', '3rd element is chomped again with no effect');
}

