use v6;
use Test;

plan 13;

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

#?rakudo todo 'hyper and race cause lists to become empty RT #126597'
{
    my @result = (50..100).list.hyper.grep({ $_ %% 10 });
    is @result, (50, 60, 70, 80, 90, 100), "hyper + grep";
}

#?rakudo todo 'hyper and race cause lists to become empty RT #126597'
{
    my @result = (^100).list.hyper.grep({ $_.is-prime }).map({ $_ * $_ });
    is @result, (4, 9, 25, 49, 121, 169, 289, 361, 529, 841, 961, 1369, 1681, 1849, 2209, 2809, 3481, 3721, 4489, 5041, 5329, 6241, 6889, 7921, 9409), "hyper + grep + map";
}

#?rakudo todo 'hyper and race cause lists to become empty RT #126597'
{
    # hyper + map done in reverse

    my @promises;
    for 0..4 {
        @promises.push(Promise.new);
    }
    my $last = Promise.new;
    @promises.push($last);
    $last.keep;

    #   0       1       2       3       4       5
    # [ Planned Planned Planned Planned Planned Kept ]

    #                        V===V                            V=V
    my @result = (1..5).list.hyper( degree => 5, batch => 1 ).map({
        # wait our turn
        await @promises[$_];

        # allow the next lower one to proceed
        @promises[$_ - 1].keep;

        $_; # <==
    });

    is @result, (1, 2, 3, 4, 5), "test that hyper + map done in reverse returns values in the right order";
}

#?rakudo todo 'hyper and race cause lists to become empty RT #126597'
{
    # hyper + grep done in reverse

    my @promises;
    for 0..4 {
        @promises.push(Promise.new);
    }
    my $last = Promise.new;
    @promises.push($last);
    $last.keep;

    #   0       1       2       3       4       5
    # [ Planned Planned Planned Planned Planned Kept ]

    #                        V===V                            V==V
    my @result = (1..5).list.hyper( degree => 5, batch => 1 ).grep({
        # wait our turn
        await @promises[$_];

        # allow the next lower one to proceed
        @promises[$_ - 1].keep;

        True; # <==
    });

    is @result, (1, 2, 3, 4, 5), "test that hyper + grep done in reverse keeps values in the right order";
}

# RT #127191
{
    for <batch degree> -> $name {
        for (-1,0) -> $value {
            throws-like { ^10 .hyper(|($name => $value)) }, X::Invalid::Value,
              :method<hyper>, :$name, :$value,
              "cannot have a $name of $value for hyper";
        }
    }
}

# RT #127099
{
    my @res = ^1000 .hyper.map: *+0;
    is-deeply @res, [@res.sort], '.hyper preserves order';
}
