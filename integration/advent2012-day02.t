use v6;
use Test;
plan 4;

is sub { "lol, I'm so anonymous!" }(), "lol, I'm so anonymous!", 'anon sub';

my @words = ('d', 'b', 'c', 'a', 2, 10);
my @sorted_words = @words.sort({ ~$_ });
is_deeply @sorted_words, [10, 2, 'a', 'b', 'c', 'd'], 'sorted words';

my @numbers = (5, 2, 10, 3);
my @sorted_numbers = @numbers.sort({ +$_ });
is_deeply @sorted_numbers, [2, 3, 5, 10], 'sorted numbers';

sub make_surprise_for($name) {
    return sub { "Sur-priiise, $name!" };
}

my $reveal_surprise = make_surprise_for("Finn");    # nothing happens, yet
# ...wait for it...
# ...wait...
# ...waaaaaaait...
is $reveal_surprise(), "Sur-priiise, Finn!";
