use v6;

use Test;

plan 18;

=begin description

Basic C<kv> tests, see S32.

=end description

# L<S32::Containers/"Array"/=item kv>

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

is( 42.kv, [0, 42], "(42).kv works");

# bug in Rakudo found by masak++
{
    my $x = bar => [ baz => 42, sloth => 43 ];
    my $y = :bar[ baz => 42, sloth => 43 ];

    is $x.kv.elems, 2,      'Pair.kv (count)';
    is $x.kv.[0],   'bar',  'Pair.kv (first key)';
    is $y.kv.elems, 2,      'Pair.kv (colonpair)';
    is $y.kv.[0],   'bar',  'Pair.kv (first key) (colonpair)';

    is kv($x).elems, 2,     'kv(Pair) (count)';
    is kv($x).[0],  'bar',  'kv(Pair) (first key)';
    is kv($y).elems, 2,     'kv(Pair) (colonpair)';
    is kv($y).[0],  'bar',  'kv(Pair) (first key (colonpair))';
}

# RT #71086
{
    use MONKEY_TYPING;
    augment class Parcel {
        method test_kv() {
            my @a;
            for <a b c>.kv -> $x {
                @a.push($x);
            }
            @a.join('|');
        }
    }
    is (1, 2).test_kv, '0|a|1|b|2|c', '.kv works within class Parcel';
}

# vim: ft=perl6
