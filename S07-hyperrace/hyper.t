use v6.c;
use Test;

plan 6;

{
    my @result = <a b c d e f g>.hyper.map({ $_.uc });
    is @result, <A B C D E F G>, "can hypermap a simple code block";

    @result = (^50).list.hyper.map({ $_ * 2 });
    is @result, (^50).map({$_*2}), "hyper over a big-ish list of Ints";
}

{
    my @result = (^50).list.hyper.map({ $_ * 2 }).map({ $_ div 2 });
    is @result, (^50).list, "two-stage map over big-ish Int list";

    @result = <a b c d e f g>.list.hyper.map({ $_.uc }).map({ $_ x 2 });
    is @result, <AA BB CC DD EE FF GG>, "two-stage map over some strings";
}

{
    my @result = (50..100).list.hyper.grep({ $_ %% 10 });
    is @result, (50, 60, 70, 80, 90, 100), "hyper + grep";
}

{
    my @result = (^100).list.hyper.grep({ $_.is-prime }).map({ $_ * $_ });
    is @result, (4, 9, 25, 49, 121, 169, 289, 361, 529, 841, 961, 1369, 1681, 1849, 2209, 2809, 3481, 3721, 4489, 5041, 5329, 6241, 6889, 7921, 9409), "hyper + grep + map";
}
