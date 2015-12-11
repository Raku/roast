use Test;

plan 6;

#?rakudo todo 'hyper and race cause lists to become empty RT #126597'
{
    my @result = <a b c d e f g>.race.map({ $_.uc });
    is @result.sort, <A B C D E F G>, "can racemap a simple code block";

    @result = (^50).list.race.map({ $_ * 2 });
    is @result.sort, (^50).map({$_*2}), "race over a big-ish list of Ints";
}

#?rakudo todo 'hyper and race cause lists to become empty RT #126597'
{
    my @result = (^50).list.race.map({ $_ * 2 }).map({ $_ div 2 });
    is @result.sort, (^50).list, "two-stage map over big-ish Int list";

    @result = <a b c d e f g>.list.race.map({ $_.uc }).map({ $_ x 2 });
    is @result.sort, <AA BB CC DD EE FF GG>, "two-stage map over some strings";
}
#?rakudo todo 'hyper and race cause lists to become empty RT #126597'
{
    my @result = (50..100).list.race.grep({ $_ %% 10 });
    is @result.sort, (50, 60, 70, 80, 90, 100), "race + grep";
}
#?rakudo todo 'hyper and race cause lists to become empty RT #126597'
{
    my @result = (^100).list.race.grep({ $_.is-prime }).map({ $_ * $_ });
    is @result.sort, (4, 9, 25, 49, 121, 169, 289, 361, 529, 841, 961, 1369, 1681, 1849, 2209, 2809, 3481, 3721, 4489, 5041, 5329, 6241, 6889, 7921, 9409), "race + grep + map";
}
