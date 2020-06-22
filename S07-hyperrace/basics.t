use v6;
use Test;

plan 87;

for <hyper race> -> $meth {
        sub hr (\seq) { $meth eq 'race' ?? seq.sort !! seq }

        is-deeply <a b c d e f g>."$meth"().map({ $_.uc }).&hr.List,
            <A B C D E F G>, "can {$meth}-map a simple code block";

        is-deeply (^50).Seq."$meth"().map(* × 2).&hr.Seq, ^50 .map(* × 2),
            "$meth over a big-ish list of Ints";

        is-deeply (^50).List."$meth"().map(* × 2).map(* div 2).&hr.List,
            ^50 .List, "two-stage $meth map over big-ish Int list";

        is-deeply <a b c d e f g>."$meth"().map(*.uc).map(* x 2).&hr.List,
            <AA BB CC DD EE FF GG>, "two-stage $meth map over some strings";

        is-deeply (50..100).list."$meth"().grep(* %% 10).&hr.List,
            (50, 60, 70, 80, 90, 100), "$meth + grep";

        is-deeply (^100)."$meth"().grep(*.is-prime).map(*²).&hr.List, (
            4, 9, 25, 49, 121, 169, 289, 361, 529, 841, 961, 1369, 1681, 1849,
            2209, 2809,  3481, 3721, 4489, 5041, 5329, 6241, 6889, 7921, 9409
        ), "$meth + grep + map";

        subtest "$meth + map/grep in reverse" => {
            plan 2;

            # We .keep last promise and then inside the hyper .keep previous
            # ones, so we end up keeping them in reverse
            (my @promises = ^5 .map: { Promise.new }).tail.keep;
            my @result = (^5)."$meth"( degree => 5, batch => 1 ).map({
                await @promises[$_];        # wait our turn
                $_ && @promises[$_-1].keep; # let the next lower one proceed
                $_
            }).&hr;
            is-deeply @result, [0, 1, 2, 3, 4], "$meth + map";

            (@promises = ^5 .map: { Promise.new }).tail.keep;
            @result = (^5)."$meth"( degree => 5, batch => 1 ).grep({
                await @promises[$_];        # wait our turn
                $_ && @promises[$_-1].keep; # let the next lower one proceed
                True
            }).&hr;
            is-deeply @result, [0, 1, 2, 3, 4], "$meth + grep";
        }

        # https://github.com/Raku/old-issue-tracker/issues/5008
        
        for <batch degree> -> $name {
            for (-1,0) -> $value {
                throws-like { (^10)."$meth"(|($name => $value)) },
                    X::Invalid::Value, :method($meth), :$name, :$value,
                  "cannot have a $name of $value for $meth";
            }
        }

        # https://github.com/Raku/old-issue-tracker/issues/5651
        
        dies-ok { for (1..1)."$meth"() { die } },
            "Exception thrown in $meth for is not lost (1..1)";
        dies-ok { for (1..1000)."$meth"() { die } },
            "Exception thrown in $meth for is not lost (1..1000)";
        dies-ok { sink (1..1)."$meth"().map: { die } },
            "Exception thrown in $meth map is not lost (1..1)";
        dies-ok { sink (1..1000)."$meth"().map: { die } },
            "Exception thrown in $meth map is not lost (1..1000)";
        dies-ok { sink (1..1)."$meth"().grep: { die } },
            "Exception thrown in $meth grep is not lost (1..1)";
        dies-ok { sink (1..1000)."$meth"().grep: { die } },
            "Exception thrown in $meth grep is not lost (1..1000)";

        # https://github.com/Raku/old-issue-tracker/issues/5111
        
        subtest ".$meth with .map that sleep()s" => {
            plan 10;

            is-deeply (^10)."$meth"(:3batch, :5degree).map({
                    sleep rand / 100; $_ + 1
                }).&hr.Array, [^10 + 1], ".$meth\(:3batch, :5degree) [$_]"
            for ^5;

            is-deeply (^10)."$meth"(:1batch).map({
                    sleep rand / 20; $_ + 2
                }).&hr.Array, [^10 + 2], ".$meth\(:1batch) [$_]"
            for ^5;
        }

        # https://github.com/Raku/old-issue-tracker/issues/5301
        
        {
            multi sub f { $^a² }
            is-deeply (^10)."$meth"().map(&f).&hr.List,
                (0, 1, 4, 9, 16, 25, 36, 49, 64, 81),
                "$meth map with a multi sub works";
        }

        # https://github.com/Raku/old-issue-tracker/issues/6435
        
        {
            my atomicint $got = 0;
            for <a b c>."$meth"() { $got⚛++ }
            is $got, 3, "for <a b c>.$meth \{ } actually iterates";
        }

        # https://github.com/Raku/old-issue-tracker/issues/5994
        
        is-deeply ([+] (1..100)."$meth"()), 5050,
            "Correct result for [+] (1..100).$meth";
        is-deeply ([+] (1..100)."$meth"().grep(* != 22)), 5028,
            "Correct result for [+] (1..100).$meth\.grep(* != 22)";
        is-deeply ([+] (1..100).grep(* != 22)."$meth"()), 5028,
            "Correct result for [+] (1..100).grep(* != 22).$meth";
        is-deeply (^100)."$meth"().elems, 100, ".$meth\.elems works";

        {
            my atomicint $i = 0;
            (^10000)."$meth"().map: { $i⚛++ }
            is $i, 10000, "$meth map in sink context iterates";
        }

        is-deeply (^Inf)."$meth"().is-lazy, False,
            ".is-lazy on $meth.tc()Seq returns False";

        is-deeply (^3)."$meth"().Numeric, 3, ".Numeric on $meth.tc()Seq";

        {
            my @a = 1, 3, 2, 9, 0, |( 1 .. 100 );
            for ^5 -> $i {
                is-deeply @a."$meth"().map(* + 1).&hr.List,
                    (2, 4, 3, 10, 1, |( 2 .. 101 )).&hr.List,
                    "Correct result of .$meth\.map(*+1) (try $i)";
            }
        }
        {
            my $b = Blob.new((^128).pick xx 1000);
            for ^5 {
                is-deeply $b[8..906]."$meth"().map({.fmt("%20x")}).&hr.Seq,
                          $b[8..906].map({.fmt("%20x")}).&hr.Seq,
                ".$meth\.map(\{.fmt(...)}) on a Buf slice works";
            }
        }
} # <-- end of `for <hyper race> -> $meth` loop

{
    isa-ok (^1000).race.map(*+1).hyper, HyperSeq,
        'Can switch from race to hyper mode';
    is-deeply (^1000).race.map(*+1).hyper.map(*+2).List.sort, (3..1002).Seq,
        'Switching from race to hyper mode does not break results';
}

{
    isa-ok (^1000).race.map(*+1).Seq, Seq,
        'Can switch from race to sequential Seq';
    is-deeply (^1000).race.map(*+1).Seq.map(*+2).List.sort, (3..1002).Seq,
        'Switching from race to sequential Seq does not break results';
}

{
    isa-ok (^1000).hyper.map(*+1).race, RaceSeq,
        'Can switch from hyper to race mode';
    is-deeply (^1000).hyper.map(*+1).race.map(*+2).List.sort, (3..1002).Seq,
        'Switching from hyper to race mode does not break results';
}

{
    isa-ok (^1000).hyper.map(*+1).Seq, Seq,
        'Can switch from hyper to sequential Seq';
    is-deeply (^1000).hyper.map(*+1).Seq.map(*+2).Seq, (3..1002).Seq,
        'hyper to sequential Seq switch does not break results or disorder';
}

# https://github.com/Raku/old-issue-tracker/issues/4967
is-deeply ^1000 .hyper.map(*+1).Array, [^1000 + 1], '.hyper preserves order';

# https://github.com/Raku/old-issue-tracker/issues/4792

{
    sub foo() {
        my $x = "*" x 2;
        $x ~~ s/ "*" ** 1..* /{ "+" x $/.chars }/;
        $x
    }
    my @a = (1..100).hyper.map({foo});
    is-deeply @a, [‘++’ xx 100], ‘hyperized s/…/…/;’
}

# https://github.com/Raku/old-issue-tracker/issues/5261
#?rakudo skip 'reliably hangs / segfaults on at least MacOS'
{
    is-deeply (^100).race(batch=>1).map({ sprintf '%1$s %2$s', 5, 42 }).List, ‘5 42’ xx 100, 
        'sprintf is threadsafe when format tokens use explicit indices';
}

# https://github.com/rakudo/rakudo/issues/3165
{
    dies-ok
        {
            my @r = (^1).race(:batch(1), :degree(1)).map({
                my @r2 = (^1).race(:batch(1), :degree(1)).map({ die 1; });
            });
        },
        'die in a race nested in a race propagates exception';
    dies-ok
        {
            my @r = (^1).hyper(:batch(1), :degree(1)).map({
                my @r2 = (^1).hyper(:batch(1), :degree(1)).map({ die 1; });
            });
        },
        'die in a hyper nested in a hyper propagates exception';
}

# vim: expandtab shiftwidth=4
