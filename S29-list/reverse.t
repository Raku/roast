use v6;
use Test;

# L<S29/List/"=item reverse">

=begin pod

Basic test for the reverse() builtin with a string (Str).

=end pod

plan 49;

# As a function :
is( reverse('Pugs'), 'sguP', "as a function");

# As a method :
is( "".reverse, "", "empty string" );
is( 'Hello World !'.reverse, '! dlroW olleH', "literal" );

# On a variable ?
my Str $a = 'Hello World !';
is( $a.reverse, '! dlroW olleH', "with a Str variable" );
is( $a, 'Hello World !', "reverse should not be in-place" );
is( $a .= reverse, '! dlroW olleH', "after a .=reverse" );

# Multiple iterations (don't work in 6.2.12) :
is( 'Hello World !'.reverse.reverse, 'Hello World !', 
        "two reverse in a row." );
        
# Reverse with unicode :
is( 'ä€»«'.reverse,   '«»€ä', "some unicode characters" );


=begin pod

Tests for "reverse" builtin with lists.

NOTE: "reverse" is no longer context-sensitive.  See S29.

=end pod


my @a = reverse(1, 2, 3, 4);
my @e = (4, 3, 2, 1);

is(@a, @e, "list was reversed");

{
    my $a = reverse("foo");
    is($a, "oof", "string was reversed");

    @a = item(reverse("foo"));
    is(@a[0], "oof", 'the string was reversed');
    @a = list(reverse("foo"));
    is(@a[0], "oof", 'the string was reversed even under list context');

    @a = reverse(~("foo", "bar"));
    is(@a[0], "rab oof", 'the stringified array was reversed (stringwise)');
    @a = list reverse "foo", "bar";
    is(+@a, 2, 'the reversed list has two elements');
    is(@a[0], "bar", 'the list was reversed properly');

    is(@a[1], "foo", 'the list was reversed properly');
}

#?rakudo skip 'reverse as a function, parsefails'
{
    my @cxt_log;

    class Foo {
        my @.n;
        method foo () {
            push @cxt_log, want();
            (1, 2, 3)
        }
        method bar () {
            push @cxt_log, want();
            return @!n = do {
                push @cxt_log, want();
                reverse self.foo;
            }
        }
    }

    my @n = do {
        push @cxt_log, want();
        Foo.new.bar;
    };

    #?pugs todo 'bug'
    is(~@cxt_log, ~("List (Any)" xx 4), "contexts were passed correctly around masak's bug");
    is(+@n, 3, "list context reverse in masak's bug");
    is(~@n, "3 2 1", "elements seem reversed");
}

{    
    my @a = "foo";
    my @b = @a.reverse;
    isa_ok(@b, List);
    my $b = @a.reverse;
    isa_ok($b, List);
    is(@b[0], "foo", 'our list is reversed properly'); 
    is($b, "foo", 'in scalar context it is still a list');
    is(@a[0], "foo", "original array left untouched");
    @a .= reverse;
    is(@a[0], "foo", 'in place reversal works');
}

{
    my @a = ("foo", "bar");
    my @b = @a.reverse;
    isa_ok(@b, List);
    my $b = @a.reverse;
    isa_ok($b, List);
    is(@b[0], "bar", 'our array is reversed');
    is(@b[1], "foo", 'our array is reversed');
    
    is($b, "bar foo", 'in scalar context it is still a list');
    
    is(@a[0], "foo", "original array left untouched");
    is(@a[1], "bar", "original array left untouched");
    
    @a .= reverse;
    is(@a[0], "bar", 'in place reversal works');
    is(@a[1], "foo", 'in place reversal works');
}

{
    my $a = "foo";
    my @b = $a.reverse;
    isa_ok(@b, Array);    
    my $b = $a.reverse;
    isa_ok($b, Str);    
    
    is(@b[0], "oof", 'string in the array has been reversed');
    is($b, "oof", 'string has been reversed');
    is($a, "foo", "original scalar left untouched");
    $a .= reverse;
    is($a, "oof", 'in place reversal works on strings');
}

{
    my $a = "foo".reverse;
    my @b = "foo".reverse;
    isa_ok($a, Str);
    isa_ok(@b, Array);
    is($a, "oof", 'string literal reversal works in scalar context');
    is(@b[0], "oof", 'string literal reversal works in list context');

    @b = 'foo';
    is(@b[0], (@b.reverse)[0], 'one item list is left alone');
}

=begin pod

Tests for %hash.reverse, which inverts the keys and values of a hash.

=end pod

{
    my %hash = <a b c d>;
    is(%hash.reverse<b d>, <a c>, 'simple hash reversal');
    is(%hash, {'a' => 'b', 'c' => 'd'}, 'original hash is intact');
}

#?rakudo skip 'reverse for hash not implemented (unspecced behavior here)'
{
    my %hash = reverse {0 => 'a', 1 => 'a'};

    is(%hash.keys, <a>, 'hash reversal with collision (unspecced, keys)');
    is(%hash.values.sort, <0 1>, 'hash reversal with collision (unspecced, values)');
}
