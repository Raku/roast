use v6;

use Test;

plan 9;

=begin description

Basic C<kv> tests, see S29.

=end description

# L<S29/"Array"/=item kv>

# (1,).kv works correctly
{
    my @a = ();
    @a = try { (1,).kv };
    #?pugs 2 todo 'bug'
    is(@a[0],0, "first element is 0");
    is(@a[1],1, "second element is 1");
}

# ('a',).kv works correctly
{
    my @a = try { ('a',).kv };
    #?pugs 2 todo 'bug'
    is(@a[0],0, "first element is 0");
    is(@a[1],'a', "second element is 'a'");
}

{ # check the invocant form
    my @array = <a b c d>;
    my @kv = @array.kv;
    is(+@kv, 8, '@array.kv returns the correct number of elems');
    is(~@kv, "0 a 1 b 2 c 3 d",  '@array.kv has no inner list');
}

{ # check the non-invocant form
    my @array = <a b c d>;
    my @kv = kv(@array);
    is(+@kv, 8, 'kv(@array) returns the correct number of elems');
    is(~@kv, "0 a 1 b 2 c 3 d", 'kv(@array) has no inner list');
}

# Check that (42).kv does *not* work, as this it the same as $some_int.kv:
dies_ok { (42).kv }, "(42).kv should not and does not work";
