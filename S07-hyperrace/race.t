use v6;
use Test;

plan 37;

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

{
    my @result = (50..100).list.race.grep({ $_ %% 10 });
    is @result.sort, (50, 60, 70, 80, 90, 100), "race + grep";
}

{
    my @result = (^100).list.race.grep({ $_.is-prime }).map({ $_ * $_ });
    is @result.sort, (4, 9, 25, 49, 121, 169, 289, 361, 529, 841, 961, 1369, 1681, 1849, 2209, 2809, 3481, 3721, 4489, 5041, 5329, 6241, 6889, 7921, 9409), "race + grep + map";
}

#?rakudo.jvm skip 'hangs'
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

        # allow the next lower one to proceed
        @promises[$_ - 1].keep;

        $_; # <==
    });
    # @result should nearly be in reversed order, so sort it for the test
    is @result.sort(), (1, 2, 3, 4, 5), "test that race + map in reverse returns correct values";
}

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

        # allow the next lower one to proceed
        @promises[$_ - 1].keep;

        True; # <==
    });
    # @result should nearly be in reversed order, so sort it for the test
    is @result.sort(), (1, 2, 3, 4, 5), "test that race + grep in reverse returns correct values";
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

# RT #127452
{
    for ^5 -> $i {
        my @x = ^10;
        my @y = @x.race(:3batch, :5degree).map: { sleep rand / 100; $_ + 1 };
        is @y.sort, [1..10], ".race(:3batch, :5degree) with sleepy mapper works (try $i)";
    }
}
{
    for ^5 -> $i {
        my @x = (^10).race(:1batch).map: { sleep rand / 20; $_ };
        is @x.sort, [^10], ".race(:1batch) with sleepy mapper works (try $i)";
    }
}

# RT #129234
dies-ok { for (1..1).race { die } },
    "Exception thrown in race for is not lost (1..1)"; 
dies-ok { for (1..1000).race { die } },
    "Exception thrown in race for is not lost (1..1000)"; 
dies-ok { sink (1..1).race.map: { die } },
    "Exception thrown in race map is not lost (1..1)"; 
dies-ok { sink (1..1000).race.map: { die } },
    "Exception thrown in race map is not lost (1..1000)"; 
dies-ok { sink (1..1).race.grep: { die } },
    "Exception thrown in race grep is not lost (1..1)"; 
dies-ok { sink (1..1000).race.grep: { die } },
    "Exception thrown in race grep is not lost (1..1000)"; 

# RT #128084
{
    multi sub f ($a) { $a**2 }
    is (^10).race.map(&f).list.sort, (0, 1, 4, 9, 16, 25, 36, 49, 64, 81),
        "race map with a multi sub works";
}

# RT #131865
{
    my atomicint $got = 0;
    for <a b c>.race {
        $got⚛++
    }
    is $got, 3, 'for <a b c>.race { } actually iterates';
}

# RT #130576
is ([+] (1..100).race), 5050,
    'Correct result for [+] (1..100).race';
is ([+] (1..100).race.grep(* != 22)), 5028,
    'Correct result for [+] (1..100).race.grep(* != 22)';
is ([+] (1..100).grep(* != 22).race), 5028,
    'Correct result for [+] (1..100).grep(* != 22).race';
is (^100 .race.elems), 100, '.race.elems works';

{
    my atomicint $i = 0;
    (^10000).race.map: { $i⚛++ }
    is $i, 10000, 'race map in sink context iterates';
}

{
    isa-ok (^1000).race.map(*+1).hyper, HyperSeq, 'Can switch from race to hyper mode';
    is (^1000).race.map(*+1).hyper.map(*+2).list.sort, (3..1002).list,
        'Switching from race to hyper mode does not break results';
}
