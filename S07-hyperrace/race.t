use Test;

plan 10;

{
    my @result = <a b c d e f g>.race.map({ $_.uc });
    is @result.sort, <A B C D E F G>, "can racemap a simple code block";

    @result = (^50).list.race.map({ $_ * 2 });
    is @result.sort, (^50).map({$_*2}), "race over a big-ish list of Ints";
}

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

{
    # race + map done in reverse

    my @promises;
    for 0..4 {
        @promises.push(Promise.new);
    }
    my $last = Promise.new;
    @promises.push($last);
    $last.keep;

    #   0       1       2       3       4       5
    # [ Planned Planned Planned Planned Planned Kept ]

    #                        V==V                            V=V
    my @result = (1..5).list.race( degree => 5, batch => 1 ).map({
        # wait our turn
        await @promises[$_];

        # help prevent timing jitter from mattering
        # by giving the thread that was blocking us
        # a head start
        sleep 0.01;

        # allow the next lower one to proceed
        @promises[$_ - 1].keep;

        $_; # <==
    });
    is @result, (5, 4, 3, 2, 1), "test that race + map does not worry about order";
}

#?rakudo todo 'hyper and race cause lists to become empty RT #126597'
{
    # race + grep done in reverse

    my @promises;
    for 0..4 {
        @promises.push(Promise.new);
    }
    my $last = Promise.new;
    @promises.push($last);
    $last.keep;

    #   0       1       2       3       4       5
    # [ Planned Planned Planned Planned Planned Kept ]

    #                        V==V                            V==V
    my @result = (1..5).list.race( degree => 5, batch => 1 ).grep({
        # wait our turn
        await @promises[$_];

        # help prevent timing jitter from mattering
        # by giving the thread that was blocking us
        # a head start
        sleep 0.01;

        # allow the next lower one to proceed
        @promises[$_ - 1].keep;

        True; # <==
    });
    is @result, (5, 4, 3, 2, 1), "test that race + grep does not worry about order";
}

# RT #127191
{
    for <batch degree> -> $name {
        for (-1,0) -> $value {
            throws-like { ^10 .race(|($name => $value)) }, X::Invalid::Value,
              :method<race>, :$name, :$value,
              "cannot have a $name of $value for hyper";
        }
    }
}
