use Test;

sub bentley_clever($seed) {
    constant $mod = 1_000_000_000;

    my @state;

    my @seed = ($seed % $mod, 1, (* - *) % $mod ... *)[^55];
    @state = @seed[ 34, (* + 34 ) % 55 ... 0 ];

    subrand() for 55 .. 219;

    sub subrand() {
        push @state, (my $x = (@state.shift - @state[*-24]) % $mod);
        $x;
    }

    &subrand ... *;
}

my @sr := bentley_clever(292929);
is @sr[^6].join('|'),
   '467478574|512932792|539453717|20349702|615542081|378707948',
   'can do funny things with lazy series';
