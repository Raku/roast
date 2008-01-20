use v6-alpha;

use Test;

plan 4;

=begin description

Basic C<kv> tests, see S29.

=end description

# L<S29/"Array"/=item kv>

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
