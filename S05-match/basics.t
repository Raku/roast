use v6;
use Test;

plan 2;

{
    my $m = "abc" ~~ /b/;
    my Str(Match) $sm = $m;
    isa-ok $sm, Str, "Match correctly coerces into Str";
    is $sm, "b", "coerced string is as expected";
}

done-testing;
