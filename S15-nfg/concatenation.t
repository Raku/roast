use v6;
use Test;

plan 15;

my $a = "\x0044";
my $b = "\x0307";
my $c = "\x0323";

{
    my $ab = $a ~ $b;
    my $ac = $a ~ $c;
    my $abc = $a ~ $b ~ $c;
    my $acb = $a ~ $c ~ $b;

    is-deeply $ab.chars, 1, 'Base + combiner is 1 grapheme (1)';
    is-deeply $ac.chars, 1, 'Base + combiner is 1 grapheme (2)';
    is-deeply $abc.chars, 1, 'Base + 2 combiners is 1 grapheme (1)';
    is-deeply $acb.chars, 1, 'Base + 2 combiners is 1 grapheme (2)';
    is-deeply $abc, $acb, 'Order of combiners concatenated does not affect equality';
}

# 3 bases joined with marks is 2 composed/synthetic followed by base
is-deeply ($a, $a, $a).join($b).chars, 3, 'join respects NFG (1)';
is-deeply ($a, $a, $a).join($c).chars, 3, 'join respects NFG (2)';
is-deeply ($a, $a, $a).join($b ~ $c).chars, 3, 'join respects NFG (3)';

# RT #127530 (normalization on concat SEGV bug)
is-deeply "\xfacf" ~ "\n", "\xfacf\n", '\xfacf ~ \n is ok';
is-deeply "\xfad0" ~ "\n", "\xfad0\n", '\xfad0 ~ \n is ok';
is-deeply "\xfad7" ~ "\n", "\xfad7\n", '\xfad7 ~ \n is ok';

#
is-deeply "a\r" ~ "\na", "a\r\na", 'a\r ~ \na is ok';

is-deeply ("\c[COMBINING ACUTE ACCENT]" x 3 ~ 'a').ords, (769,769, 769, 97), "Concat works with combining repeated characters";
is-deeply ('a' ~ "\c[COMBINING ACUTE ACCENT]" x 3).ords, (225, 769, 769), "Concat works with combining repeated characters";
is-deeply ('a' x 2 ~ "\c[COMBINING ACUTE ACCENT]" x 3).ords, (97, 225, 769, 769), "Concat works with combining repeated characters";
