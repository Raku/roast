use v6;
use Test;

plan 51;

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

#?rakudo.jvm skip 'hangs'
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

# RT #127452
{
    for ^5 -> $i {
        my @x = ^10;
        my @y = @x.hyper(:3batch, :5degree).map: { sleep rand / 100; $_ + 1 };
        is @y, [1..10], ".hyper(:3batch, :5degree) with sleepy mapper works (try $i)";
    }
}
{
    for ^5 -> $i {
        my @x = (^10).hyper(:1batch).map: { sleep rand / 20; $_ };
        is @x, [^10], ".hyper(:1batch) with sleepy mapper works (try $i)";
    }
}
{
    my @a = 1, 3, 2, 9, 0, |( 1 .. 100 );
    for ^5 -> $i {
        my $a = @a.hyper.map: * + 1;
        is $a.list, (2, 4, 3, 10, 1, |( 2 .. 101 )),
            "Correct result of .hyper.map(*+1).list (try $i)";
    }
}
{
    my $b = Blob.new((^128).pick xx 1000);
    for ^5 {
        is $b[8..906].hyper.map({.fmt("%20x")}).list, $b[8..906].map({.fmt("%20x")}).list,
            '.hyper.map({.fmt(...)}) on a Buf slice works';
    }
}

# RT #129234
dies-ok { for (1..1).hyper { die } },
    "Exception thrown in hyper for is not lost (1..1)"; 
dies-ok { for (1..1000).hyper { die } },
    "Exception thrown in hyper for is not lost (1..1000)"; 
dies-ok { sink (1..1).hyper.map: { die } },
    "Exception thrown in hyper map is not lost (1..1)"; 
dies-ok { sink (1..1000).hyper.map: { die } },
    "Exception thrown in hyper map is not lost (1..1000)"; 
dies-ok { sink (1..1).hyper.grep: { die } },
    "Exception thrown in hyper grep is not lost (1..1)"; 
dies-ok { sink (1..1000).hyper.grep: { die } },
    "Exception thrown in hyper grep is not lost (1..1000)"; 

# RT #128084
{
    multi sub f ($a) { $a**2 }
    is (^10).hyper.map(&f).list, (0, 1, 4, 9, 16, 25, 36, 49, 64, 81),
        "hyper map with a multi sub works";
}

# RT #131865
{
    my atomicint $got = 0;
    for <a b c>.hyper {
        $got⚛++
    }
    is $got, 3, 'for <a b c>.hyper { } actually iterates';
}

# RT #130576
is ([+] (1..100).hyper), 5050,
    'Correct result for [+] (1..100).hyper';
is ([+] (1..100).hyper.grep(* != 22)), 5028,
    'Correct result for [+] (1..100).hyper.grep(* != 22)';
is ([+] (1..100).grep(* != 22).hyper), 5028,
    'Correct result for [+] (1..100).grep(* != 22).hyper';
is (^100 .hyper.elems), 100, '.hyper.elems works';

{
    my atomicint $i = 0;
    (^10000).hyper.map: { $i⚛++ }
    is $i, 10000, 'hyper map in sink context iterates';
}

{
    isa-ok (^1000).hyper.map(*+1).race, RaceSeq, 'Can switch from hyper to race mode';
    is (^1000).hyper.map(*+1).race.map(*+2).list.sort, (3..1002).list,
        'Switching from hyper to race mode does not break results';
}

{
    isa-ok (^1000).hyper.map(*+1).Seq, Seq, 'Can switch from hyper to sequential Seq';
    is (^1000).hyper.map(*+1).Seq.map(*+2).list, (3..1002).list,
        'Switching from hyper to sequential Seq does not break results or disorder';
}

is (^1000).hyper.is-lazy, False, 'is-lazy on HyperSeq returns False';
